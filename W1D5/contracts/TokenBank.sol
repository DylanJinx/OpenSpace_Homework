// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// 可以代理多种Token
contract TokenBank {
    // 外层映射的键是代币地址，内层映射的键是用户地址
    mapping(address => mapping(address => uint256)) public balances;

    event Deposit(address indexed token, address indexed user, uint256 amount);
    event Withdraw(address indexed token, address indexed user, uint256 amount);

    function deposit(address token, uint256 amount) public {
        // 调用transferFrom()
        // 法一：使用接口
        IERC20 tokenContract = IERC20(token);
        // 用户需要先授权给TokenBank足够的Token
        require(tokenContract.transferFrom(msg.sender, address(this), amount), "Transfer failed!");

        // // 法二：使用call()
        // bytes memory data = abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, address(this), amount);
        // (bool success, ) = token.call(data);
        // require(success, "Transfer failed!");

        // 增加用户在TokenBank中对于该Token的余额
        balances[token][msg.sender] += amount;

        emit Deposit(token, msg.sender, amount);
    }

    function withdraw(address token, uint256 amount) public {
        // 确保用户有足够的余额
        require(balances[token][msg.sender] >= amount, "Insufficient balance!");

        // 减少用户对该Token的余额
        balances[token][msg.sender] -= amount;

        // 调用transfer()
        // 法一：使用接口
        IERC20 tokenContract = IERC20(token);
        // 将Token从TokenBank转回用户
        require(tokenContract.transfer(msg.sender, amount), "Transfer failed!");

        // 法二：使用call()
        // bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", msg.sender, amount);
        // (bool success, ) = token.call(data);
        // require(success, "Transfer failed!");

        emit Withdraw(token, msg.sender, amount);
    }
}