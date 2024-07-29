//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Implementation {
    uint public x;
    bool public isBase;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        // 确保实现合约永远不会被初始化
        isBase = true;
    }

    function initialize(address _owner) external {
        require(isBase == false, "ERROR: This the base contract, cannot initialize");
        require(owner == address(0), "ERROR: Already initialized");
        owner = _owner;
    }

    function setX(uint _x) external onlyOwner {
        x = _x;
    }
}