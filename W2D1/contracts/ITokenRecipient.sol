// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenRecipient {
    function tokensReceived (address _from, uint256 _value) external returns (bool);
}