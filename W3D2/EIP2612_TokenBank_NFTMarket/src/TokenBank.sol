// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenBank {
    mapping(address => uint256) public balances;

    // 定义事件
    event Deposited(address indexed depositer, address indexed token, uint256 amount);
    event Permitted(address indexed owner, address indexed spender, uint256 amount, uint256 deadline);

    error TokenBankTransferFromFailed(address depositer);

    // 使用permit进行授权并存款
    function permitDeposit(
        address tokenAddress, 
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s 
    ) public {
        // 调用Token合约的permit方法为TokenBank合约授权
        IERC20Permit(tokenAddress).permit(msg.sender, address(this), amount, deadline, v, r, s);
        emit Permitted(msg.sender, address(this), amount, deadline); // 触发授权事件

        // 存款
        _deposit(msg.sender, tokenAddress, amount);
    }

    function _deposit(address depositer, address token, uint256 amount) internal {
        if (!IERC20(token).transferFrom(depositer, address(this), amount)) {
            revert TokenBankTransferFromFailed(depositer);
        }
        balances[depositer] += amount;
        emit Deposited(depositer, token, amount); // 触发存款事件
    }
}
