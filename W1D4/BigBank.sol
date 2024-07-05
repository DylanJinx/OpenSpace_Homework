// SPDX-License-Identifier:MIT
pragma solidity >= 0.8.0;

import "./Bank.sol";

contract BigBank is Bank {
    modifier minDepositAmount() {
        require(msg.value > 0.001 ether, "Deposit amount must be greater than 0.001 ether");
        _;
    }

    function deposit() public payable override minDepositAmount {
        super.deposit();
    }

    // 只有admin可以修改管理员
    function transferOwnership(address newAdmin) public onlyAdmin {
        require(newAdmin != address(0), "New admin is the zero address");
        admin = newAdmin;
    }
}