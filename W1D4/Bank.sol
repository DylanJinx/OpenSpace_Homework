// SPDX-License-Identifier:MIT
pragma solidity >= 0.8.0;

import "./IBank.sol";

contract Bank is IBank {
    mapping (address => uint) public balances;  // 用户余额
    address public admin;  // 管理员地址
    address[3] public topDepositors;  // 存储前三名存款额最高的地址

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function.");
        _;
    }

    function deposit() public virtual payable {
        require(msg.value > 0, "Deposit must be greater than 0!");
        balances[msg.sender] += msg.value;
        updateTopDepositors(msg.sender, balances[msg.sender]);
    }



    // 更新前三名存款最高的地址
    function updateTopDepositors(address depositor, uint newBalance) private {
        bool inInserted = false;

        // 如果已在前三名中，重新排序
        for (uint i = 0; i < topDepositors.length; i++) {
            if (topDepositors[i] == depositor) {
                // 如果当前存款者余额大于前一个，则向上移动
                if(i > 0 && balances[topDepositors[i-1]] < newBalance) {
                    for (uint j = i; j > 0 && balances[topDepositors[j-1]] < newBalance; j--) {
                        (topDepositors[j] , topDepositors[j - 1]) = (topDepositors[j - 1], topDepositors[j]);
                    }
                }
                inInserted = true;
                break;
            }
        }

        // 不在之前的前三名中
        if (!inInserted) {
            for (uint i = 0; i < topDepositors.length; i++) {
                if (balances[topDepositors[i]] < newBalance) {
                    for (uint j = topDepositors.length - 1; j > i; j--) {
                        topDepositors[j] = topDepositors[j - 1];
                    }
                    topDepositors[i] = depositor;
                    break;
                }
            }
        }
    }

    // 只有管理员可以提款
    function withdraw(uint amount) external override onlyAdmin {
        require(address(this).balance >= amount, "Insufficient balance in contract!");
        payable(admin).transfer(amount);
    }


    // 获取当前合约内的余额
    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }

    // 返回整个topDepositors数组
    function getTopDepositors() public view returns (address[3] memory) {
        return topDepositors;
    }

    // 调用者直接转账则调用deposit方法
    receive() external payable {
        deposit();
    }

    // 调用者转账且有数据则调用deposit方法
    fallback() external payable {
        deposit();
    }

}

