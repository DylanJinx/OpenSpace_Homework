// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ITokenRecipient.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// Can handle multiple tokens
contract TokenBank is ITokenRecipient {
    using SafeERC20 for IERC20;

    // The outer mapping's key is the token address, the inner mapping's key is the user address
    mapping(address => mapping(address => uint256)) public balances;

    event Deposit(address indexed token, address indexed user, uint256 amount);
    event Withdraw(address indexed token, address indexed user, uint256 amount);

    function deposit(address token, uint256 amount) public {
        // Call transferFrom()
        // Method 1: Using interface
        IERC20 tokenContract = IERC20(token);
        // User must first uthorize TokenBank with sufficient tokens
        tokenContract.safeTransferFrom(msg.sender, address(this), amount);

        // // Method 2: Using call() function
        // bytes memory data = abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, address(this), amount);
        // (bool success, ) = token.call(data);
        // require(success, "Transfer failed!");

        // Increases the user's balance for this token within TokenBank
        balances[token][msg.sender] += amount;

        emit Deposit(token, msg.sender, amount);
    }

    function withdraw(address token, uint256 amount) public {
        // Ensures the user has sufficient balance
        require(balances[token][msg.sender] >= amount, "Insufficient balance!");

        // Reduces the user's balance of the token
        balances[token][msg.sender] -= amount;

        // Call transfer()
        // Method 1: Using interface
        IERC20 tokenContract = IERC20(token);
        // Transfers tokens from TokenBank back to user
        tokenContract.safeTransfer(msg.sender, amount);
        
        // Method 2: using call() function
        // bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", msg.sender, amount);
        // (bool success, ) = token.call(data);
        // require(success, "Transfer failed!");

        emit Withdraw(token, msg.sender, amount);
    }

    // Checks if the address is a contract
    function isContract(address addr) internal view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(addr)
        }
        return size > 0;
    }

    function onTransferReceived(
        address operator, 
        address _from, 
        uint256 _value,
        bytes calldata data
    ) external override returns (bytes4) {
        require(isContract(msg.sender), "onTransferReceived: Caller is not a contract");
        // token = ERC20 contract address
        address token = msg.sender;

        balances[token][_from] += _value;
        emit Deposit(token, _from, _value);

        return ITokenRecipient.onTransferReceived.selector;
    }
}