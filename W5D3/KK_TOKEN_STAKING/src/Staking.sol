// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IKKToken.sol";
import "./IStaking.sol";

contract StakePool is IStaking {
    uint public constant RATE_PER_BLOCK = 10 * 1e18; // 每个区块的代币奖励
    uint public startBlockNumber = block.number; // 合约部署时的区块号


    uint public totalStaked; // 池子总质押
    uint public poolRate; // 池子当前利率（这里的利率指当前池子每单位ETH累积奖励）扩大 1e18 倍
    uint public lastRewardBlock = startBlockNumber; // 上一次更新奖励的区块号

    struct StakeInfo {
        uint amount; // 用户质押金额
        uint reward; // 用户待领取奖励
        uint userRate; // 用户上一次操作（stake unstake claim）时池子的利率
    }

    mapping (address => StakeInfo) public stakes;

    IKKToken public kkToken;

    constructor(address _kkToken) {
        kkToken = IKKToken(_kkToken);
    }

    function _updatePoolRate() internal {
        // 如果没有质押，不更新利率，之前的奖励作废
        if (totalStaked == 0) {
            lastRewardBlock = block.number;
            return;
        }

        // 更新当前池子利率
        poolRate += (block.number - lastRewardBlock) * RATE_PER_BLOCK * 1e18 / totalStaked;
        lastRewardBlock = block.number;
        emit PoolRateUpdated(block.number, poolRate);
    }

    function _updateStakerReward(address _account) internal {
        _updatePoolRate();
        StakeInfo storage _staker = stakes[_account];
        _staker.reward += _staker.amount * (poolRate - _staker.userRate) / 1e18;
        _staker.userRate = poolRate;
    }

    /**
     * @dev 质押 ETH 到合约
     */
    function stake() external payable {
        require(msg.value > 0, "StakePool: stake amount should be greater than 0");
        _updateStakerReward(msg.sender);
        stakes[msg.sender].amount += msg.value;
        totalStaked += msg.value;

        emit Staked(msg.sender, msg.value);
    }

    /**
     * @dev 赎回质押的 ETH
     * @param _amount 赎回数量
     */
    function unstake(uint256 _amount) external{
        require(_amount > 0, "StakePool: unstake amount should be greater than 0");
        require(stakes[msg.sender].amount >= _amount, "StakePool: insufficient balance");

        _updateStakerReward(msg.sender);
        stakes[msg.sender].amount -= _amount;
        totalStaked -= _amount;

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "StakePool: unstake transfer failed");

        emit Unstaked(msg.sender, _amount);
    }

    /**
     * @dev 领取 KK Token 收益
     */
    function claim() external{
        _updateStakerReward(msg.sender);
        uint256 _reward = stakes[msg.sender].reward;
        require(_reward > 0, "StakePool: no reward to claim");

        stakes[msg.sender].reward = 0;

        kkToken.mint(msg.sender, _reward);

        emit Claimed(msg.sender, _reward);
    }

    /**
     * @dev 获取质押的 ETH 数量
     * @param account 质押账户
     * @return 质押的 ETH 数量
     */
    function balanceOf(address account) external view returns (uint256){
        return stakes[account].amount;
    }

    /**
     * @dev 获取待领取的 KK Token 收益
     * @param account 质押账户
     * @return 待领取的 KK Token 收益
     */
    function earned(address account) external view returns (uint256){
        StakeInfo memory _staker = stakes[account];
        if (_staker.amount == 0 || totalStaked == 0) {
            return 0;
        }

        uint _poolRate = poolRate + (block.number - lastRewardBlock) * RATE_PER_BLOCK * 1e18 / totalStaked;
        return _staker.reward + _staker.amount * (_poolRate - _staker.userRate) / 1e18;
    }

    event Staked(address indexed staker, uint256 amount);
    event Unstaked(address indexed staker, uint256 amount);
    event Claimed(address indexed staker, uint256 amount);
    event PoolRateUpdated(uint256 blockNumber, uint256 poolRate);
}
