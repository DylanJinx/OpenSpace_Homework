// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StakePool_CompoundInterest {
    address public immutable NFTMARKET;

    uint public totalStaked; // 池子总质押
    uint public poolRate; // 池子当前利率（这里的利率指当前池子每单位ETH累积奖励）
    // uint public totalFee; // 池子总奖励

    struct StakeInfo {
        uint256 amount; // 用户质押金额
        uint256 reward; // 用户待领取奖励
        uint256 userRate; // 用户上一次操作（stake unstake claim）时池子的利率
    }

    mapping (address => StakeInfo) public stakes;

    constructor(address _nftMarket) {
        NFTMARKET = _nftMarket;
    }

    function _updateReward(address _account) internal {
        StakeInfo memory _staker = stakes[_account];
        _staker.reward += _staker.amount * (poolRate / _staker.userRate) / 1e18;
        _staker.userRate = poolRate;

        stakes[_account] = _staker;
    }

    function stake() public payable {
        require(msg.value > 0, "StakePool: stake amount should be greater than 0");

        _updateReward(msg.sender);
        stakes[msg.sender].amount += msg.value;
        totalStaked += msg.value;

        emit Staked(msg.sender, msg.value);
    }

    function unstake(uint amount) public {
        require(amount > 0, "StakePool: unstake amount should be greater than 0");
        require(stakes[msg.sender].amount >= amount, "StakePool: insufficient balance");

        _updateReward(msg.sender);
        stakes[msg.sender].amount -= amount;
        totalStaked -= amount;

        payable(msg.sender).transfer(amount);

        emit Unstaked(msg.sender, amount);
    }

    function claim() public {
        _updateReward(msg.sender);
        uint256 _reward = stakes[msg.sender].reward;
        require(_reward > 0, "StakePool: no reward to claim");

        stakes[msg.sender].reward = 0;

        payable(msg.sender).transfer(_reward);

        emit Claimed(msg.sender, _reward);
    }

    receive() external payable {
        require(msg.sender == NFTMARKET, "StakePool: only NFTMarket can send ETH");

        if (totalStaked > 0) {
            poolRate = poolRate * (1 + msg.value * 1e18 / totalStaked);
        }
    }
    
    event Staked(address indexed staker, uint256 amount);
    event Unstaked(address indexed staker, uint256 amount);
    event Claimed(address indexed staker, uint256 amount);
}