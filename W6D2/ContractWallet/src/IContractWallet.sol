// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IContractWallet {
    function executeTransaction(uint32 _nonce) external;
}