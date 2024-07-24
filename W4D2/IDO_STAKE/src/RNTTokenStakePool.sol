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

    uint256 public currentStakeAmount;
    uint256 public currentUnclaimed;
    uint256 public currentLastUpdateTime;
    uint256 public currentStakeTime;
    uint256 public already_claimed_Rewards;

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
        currentLastUpdateTime = block.timestamp;
    }

    function mintRNT(uint _amount) onlyOwner public {
        RNT.mintForStake(_amount);

        TOTAL_STAKE_REWARD += _amount;

        emit MintRNT(_amount);
    }
    
    // use a signature instead of approve
    function stake(ERC20PermitData calldata _approveData) public ensureSufficientRewardsAvailable {
        uint startTime = block.timestamp;
        
        uint256 _amount = _approveData.value;
        require(_amount > 0, "RNTTokenStakePool: Invalid staking amount; must be greater than zero");

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

        StakeInfo storage stakeInfo = stakes[msg.sender];

        // transfer RNT to this contract
        RNT.transferFrom(msg.sender, address(this), _amount);

        if (stakeInfo.lastUpdateTime == 0) {
            stakeInfo.lastUpdateTime = block.timestamp;
        }

        // 算用户的
        uint256 stakeTime = startTime - stakeInfo.lastUpdateTime;
        stakeInfo.lastUpdateTime += stakeTime;
        stakeInfo.unClaimed += stakeInfo.amount * stakeTime * esRNTPerDay / 86400;
        stakeInfo.amount += _amount;
        
        // 算总的
        currentStakeTime = block.timestamp - currentLastUpdateTime;
        currentLastUpdateTime += currentStakeTime;
        currentUnclaimed += currentStakeAmount * currentStakeTime * esRNTPerDay / 86400;
        currentStakeAmount += _amount;
    }

    function unstake(uint256 _amount) public {
        uint256 startTime = block.timestamp;

        StakeInfo storage stakeInfo = stakes[msg.sender];

        require(stakeInfo.amount >= _amount, "RNTTokenStakePool: insufficient balance");

        RNT.transfer(msg.sender, _amount);

        // 算用户的
        uint256 stakeTime = startTime - stakeInfo.lastUpdateTime;
        stakeInfo.lastUpdateTime += stakeTime;
        stakeInfo.unClaimed += stakeInfo.amount * stakeTime * esRNTPerDay / 86400;
        stakeInfo.amount -= _amount;

        // 算总的
        currentStakeTime = block.timestamp - currentLastUpdateTime;
        currentLastUpdateTime += currentStakeTime;
        currentUnclaimed += currentStakeAmount * currentStakeTime * esRNTPerDay / 86400;
        currentStakeAmount -= _amount;
    }

    function claim() public returns (uint256) {
        uint256 startTime = block.timestamp;

        StakeInfo storage stakeInfo = stakes[msg.sender];
        
        uint256 stakeTime = startTime - stakeInfo.lastUpdateTime;
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
        TOTAL_STAKE_REWARD -= canClaimable;
        already_claimed_Rewards += canClaimable;

        return esRNTLockInfoId;
    }

    // 只有还有足够的 RNT 代币才能继续质押
    modifier ensureSufficientRewardsAvailable() {
        currentStakeTime = block.timestamp - currentLastUpdateTime;
        uint NOW_CANCLAIMABLE = currentUnclaimed + 
            currentStakeAmount * currentStakeTime * esRNTPerDay / 86400;
        require(TOTAL_STAKE_REWARD - NOW_CANCLAIMABLE - already_claimed_Rewards > 0, "S3TokenIDO: insufficient RNT balance");
        _;
    }

    event MintRNT(uint amount);
}