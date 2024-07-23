// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {RNTToken} from "./RNTToken.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {esRNTToken} from "./esRNTToken.sol";

// 质押挖矿,挖矿得到 esRNT，esRNT 可解锁成 RNT
// 1 RNT 质押 1天 获得 1 esRNT，则 1RNT 质押 1秒 获得 1/86400 esRNT
// 1 esRNT 在30天后才能全部兑换成 1 个RNT
contract RNTTokenStakePool is Ownable(msg.sender) {

    RNTToken public RNT;
    esRNTToken public esRNT;

    // 1 RNT 质押 1天 获得 多少 esRNT
    uint256 public esRNTPerDay = 1;

    // 目前还有的质押奖励
    uint256 public TOTAL_STAKE_REWARD;

    uint256 public NOW_STAKE_AMOUNT;
    uint256 public NOW_UNCLAIMED;
    uint256 public NOW_LAST_UPDATE_TIME;
    uint256 public NOW_STAKE_TIME;

    struct ERC20PermitData {
        uint256 value;
        uint256 deadline;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    struct StakeInfo {
        uint256 amount;
        uint256 lastUpdateTime;
        uint256 unClaimed;
    }

    mapping(address => StakeInfo) public stakes;

    constructor(address _RNT, address _esRNT) {
        RNT = RNTToken(_RNT);
        esRNT = esRNTToken(_esRNT);
        NOW_LAST_UPDATE_TIME = block.timestamp;
    }

    function mintRNT(uint _amount) onlyOwner public {
        RNT.mintForStake(_amount);

        TOTAL_STAKE_REWARD += _amount;

        emit MintRNT(_amount);
    }
    
    // use a signature instead of approve
    function stake(ERC20PermitData calldata _approveData) public onlyHaveRNT {
        uint256 _amount = _approveData.value;
        require(_amount > 0, "RNTTokenStakePool: invalid amount");

        // check signature
        RNT.permit(
            msg.sender,
            address(this),
            _amount,
            _approveData.deadline,
            _approveData.v,
            _approveData.r,
            _approveData.s
        );

        // transfer RNT to this contract
        RNT.transferFrom(msg.sender, address(this), _amount);
        StakeInfo storage stakeInfo = stakes[msg.sender];

        if (stakeInfo.lastUpdateTime == 0) {
            stakeInfo.lastUpdateTime = block.timestamp;
        }

        // 算用户的
        uint256 stakeTime = block.timestamp - stakeInfo.lastUpdateTime;
        stakeInfo.lastUpdateTime += stakeTime;
        stakeInfo.unClaimed += stakeInfo.amount * stakeTime * esRNTPerDay / 86400;
        stakeInfo.amount += _amount;
        
        // 算总的
        NOW_STAKE_TIME = block.timestamp - NOW_LAST_UPDATE_TIME;
        NOW_LAST_UPDATE_TIME += NOW_STAKE_TIME;
        NOW_UNCLAIMED += NOW_STAKE_AMOUNT * NOW_STAKE_TIME * esRNTPerDay / 86400;
        NOW_STAKE_AMOUNT += _amount;
    }

    function unstake(uint256 _amount) public {
        StakeInfo storage stakeInfo = stakes[msg.sender];
        require(stakeInfo.amount >= _amount, "RNTTokenStakePool: insufficient balance");

        uint256 stakeTime = block.timestamp - stakeInfo.lastUpdateTime;
        RNT.transfer(msg.sender, _amount);

        // 算用户的
        stakeInfo.lastUpdateTime += stakeTime;
        stakeInfo.unClaimed += stakeInfo.amount * stakeTime * esRNTPerDay / 86400;
        stakeInfo.amount -= _amount;

        // 算总的
        NOW_STAKE_TIME = block.timestamp - NOW_LAST_UPDATE_TIME;
        NOW_LAST_UPDATE_TIME += NOW_STAKE_TIME;
        NOW_UNCLAIMED += NOW_STAKE_AMOUNT * NOW_STAKE_TIME * esRNTPerDay / 86400;
        NOW_STAKE_AMOUNT -= _amount;
    }

    function claim() public returns (uint256) {
        StakeInfo storage stakeInfo = stakes[msg.sender];
        
        uint256 stakeTime = block.timestamp - stakeInfo.lastUpdateTime;
        uint256 canClaimable = stakeInfo.unClaimed + 
            stakeInfo.amount * stakeTime * esRNTPerDay / 86400;

        require(canClaimable > 0, "RNTTokenStakePool: nothing to claim");

        stakeInfo.unClaimed = 0;
        stakeInfo.lastUpdateTime += stakeTime;

        // transfer RNT to esRNT contract
        RNT.transfer(address(esRNT), canClaimable);
        
        // transfer esRNT to user
        uint256 esRNTLockInfoId = esRNT.mintForStakeUser(msg.sender, canClaimable);

        // 算总的
        TOTAL_STAKE_REWARD -= canClaimable * 2;

        return esRNTLockInfoId;
    }

    // 只有还有足够的 RNT 代币才能继续质押
    modifier onlyHaveRNT() {
        NOW_STAKE_TIME = block.timestamp - NOW_LAST_UPDATE_TIME;
        uint NOW_CANCLAIMABLE = NOW_UNCLAIMED + 
            NOW_STAKE_AMOUNT * NOW_STAKE_TIME * esRNTPerDay / 86400;
        require(TOTAL_STAKE_REWARD - NOW_CANCLAIMABLE > 0, "S3TokenIDO: insufficient RNT balance");
        _;
    }

    event MintRNT(uint amount);
}