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
    }

    function mintRNT(uint _amount) onlyOwner public {
        RNT.mintForStake(_amount);

        emit MintRNT(_amount);
    }

    function _updateStakeInfo(address _staker) internal {
        StakeInfo storage stakeInfo = stakes[_staker];

        if (stakeInfo.lastUpdateTime == 0) {
            stakeInfo.lastUpdateTime = block.timestamp;
            return;
        }

        uint256 stakeTime = block.timestamp - stakeInfo.lastUpdateTime;
        stakeInfo.lastUpdateTime = block.timestamp;
        stakeInfo.unClaimed += stakeInfo.amount * stakeTime * esRNTPerDay / 86400;
    }

    function stake(uint256 _amount) public {
        require(_amount > 0, "RNTTokenStakePool: Invalid staking amount; must be greater than zero");

        _updateStakeInfo(msg.sender);
        stakes[msg.sender].amount += _amount;
        RNT.transferFrom(msg.sender, address(this), _amount);
        emit Skake(msg.sender, _amount);
    
    }
    
    // use a signature instead of approve
    function stake(ERC20PermitData calldata _approveData) public {
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

        stake(_amount);
    }

    function unstake(uint256 _amount) public {
        StakeInfo storage stakeInfo = stakes[msg.sender];
        require(_amount > 0, "RNTTokenStakePool: Invalid unstaking amount; must be greater than zero");
        require(stakeInfo.amount >= _amount, "RNTTokenStakePool: insufficient balance");
        require(RNT.balanceOf(address(this)) >= _amount, "RNTTokenStakePool: insufficient balance");

        _updateStakeInfo(msg.sender);
        stakeInfo.amount -= _amount;

        RNT.transfer(msg.sender, _amount);

        emit UnSkake(msg.sender, _amount);

    }

    function claim() public returns (uint256) {
        _updateStakeInfo(msg.sender);

        StakeInfo storage stakeInfo = stakes[msg.sender];
        uint256 canClaimable = stakeInfo.unClaimed;
        require(canClaimable > 0, "RNTTokenStakePool: nothing to claim");

        stakeInfo.unClaimed = 0;
        // transfer RNT to esRNT contract
        RNT.transfer(address(esRNT), canClaimable);
        // transfer esRNT to user
        uint256 esRNTLockInfoId = esRNT.mintForStakeUser(msg.sender, canClaimable);

        emit Claim(msg.sender, canClaimable, esRNTLockInfoId);
        return esRNTLockInfoId;
    }

    event MintRNT(uint amount);
    event Skake(address staker, uint amount);
    event UnSkake(address staker, uint amount);
    event Claim(address staker, uint amount, uint esRNTLockInfoId);
}



