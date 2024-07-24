// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
Deployer: 0x3A8492819b0C9AB5695D447cbA2532b879d25900
Deployed to: 0xA305A78AFC0CD40010c86053D3A92E538CEE309c
Transaction hash: 0xab6d42ae5e7290cf888974da793f02c6ee279e0f20ed2911be86c4b773600e21
 */
contract esRNT {
    struct LockInfo{
        address user;
        uint64 startTime; 
        uint256 amount;
    }

    // slot 0, 数组长度*2+1，动态数组具体存储位置 = keccak256(slot0)
    LockInfo[] private _locks;

    constructor() { 
        for (uint256 i = 0; i < 11; i++) {
            _locks.push(LockInfo(address(uint160(i+1)), uint64(block.timestamp*2-i), 1e18*(i+1)));
        }
    }
}