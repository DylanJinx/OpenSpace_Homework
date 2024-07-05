// SPDX-License-Identifier:MIT
pragma solidity >= 0.8.0;

import "./IBank.sol";

contract Ownable {
    // 不能谁都可以调用Ownable来提取BigBank的余额
    address public admin;
    IBank public bigBank;

    constructor(address _bigBankAddress) {
        admin = msg.sender;
        bigBank = IBank(_bigBankAddress);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function.");
        _;
    }

    function ownableWithdraw(uint amount) external onlyAdmin {
        bigBank.withdraw(amount);
    }

    receive() external payable { }
}

