// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Transaction hash: 0xbab2215e34a7c6f592447e2abdaeb9da22cca6ff4fa1e2e977b0d0981d45996d
 */
contract CounterV2 {
    uint private counter;

    function add(uint256 i) public {
        counter += i;
    }

    function get() public view returns(uint) {
        return counter;
    }

    
}