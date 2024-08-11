// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import {AutomationCompatibleInterface} from "../lib/chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract automationBank is Ownable(msg.sender), AutomationCompatibleInterface {
    using SafeERC20 for IERC20;
    uint public threshold;
    IERC20 public token;
    mapping(address => uint256) public balances;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function setThreshold(uint _threshold) external onlyOwner {
        threshold = _threshold;
    }

    function deposit(uint256 amount) external {
        token.safeTransferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough balance");
        balances[msg.sender] -= amount;
        token.safeTransfer(msg.sender, amount);
        emit Withdraw(msg.sender, amount);
    }

    function withdrawHalf() internal {
        uint256 amount = IERC20(token).balanceOf(address(this)) / 2;
        token.safeTransfer(owner(), amount);
        emit Withdraw(owner(), amount);
    }

    function checkUpkeep(bytes calldata /* checkData */) view external override returns (bool upkeepNeeded, bytes memory ) {
        uint currentBalance = IERC20(token).balanceOf(address(this));
        upkeepNeeded = currentBalance >= threshold;
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        require(IERC20(token).balanceOf(address(this)) >= threshold, "Not enough balance");
        withdrawHalf();
    }

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
}