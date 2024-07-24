// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {ERC20Permit} from "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {RNTToken} from "./RNTToken.sol";

contract esRNTToken is ERC20("esRNTToken", "esRNT"), Ownable(msg.sender) {
    RNTToken public RNT;

    // esRNT的总发行量 = 质押奖励
    uint256 public esNFTMaxSupply = 1000_000_000 * 10 ** 18 / 5;
    uint256 public totalesNFTMinted = 0;

    // 需要锁定的时间 = 30 * 86400
    uint256 public NEED_LOCK_TIME = 2592000;

    address public stakeContract;

    struct LockInfo {
        address user;
        uint256 amount;
        uint256 lockTime; // 锁定的时间
    }

    LockInfo[] public lockInfos;

    constructor(address _RNT) {
        RNT = RNTToken(_RNT);
    }

    function mintForStakeUser(address _to, uint256 _amount) public returns(uint256){
        require(msg.sender == stakeContract, "S3Token: only stake contract can mint stake token");
        require(totalesNFTMinted + _amount <= esNFTMaxSupply, "S3Token: stake token mint exceeded");
        _mint(_to, _amount);
        totalesNFTMinted += _amount;

        lockInfos.push(LockInfo(_to, _amount, block.timestamp));
        uint256 newLockInfoId = lockInfos.length - 1;

        return newLockInfoId;
    }

    function setstakeContract(address _stakeContract) public onlyOwner {
        require(_stakeContract != address(0), "S3Token: invalid stake admin address");

        stakeContract = _stakeContract;
    }

    // 用户解锁
    function burn(uint256 _LockInfoId) public {
        LockInfo storage lockInfo = lockInfos[_LockInfoId];
        require(msg.sender == lockInfo.user, "S3Token: only lockInfo owner can burn");

        // 已经解锁的数量
        uint256 unlockedAmount = lockInfo.amount * (block.timestamp - lockInfo.lockTime) / NEED_LOCK_TIME;

        RNT.transfer(lockInfo.user, unlockedAmount);

        // 烧毁未解锁的esRNT
        _burn(lockInfo.user, lockInfo.amount - unlockedAmount);

        // 将未解锁的RNT转回给RNT合约
        RNT.transfer(address(RNT), lockInfo.amount - unlockedAmount);

        // 删除锁定信息
        delete lockInfos[_LockInfoId];
    }
}