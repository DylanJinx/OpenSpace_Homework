// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Bank {
    mapping(address => uint) public balanceOf;

    event Deposit(address indexed user, uint amount);

    error DepositAmountMustBeGreaterThanZero();

    function depositETH() external payable {
        if (msg.value <= 0) {
            revert DepositAmountMustBeGreaterThanZero();
        }
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
}