// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITokenRecipient {
    function onTransferReceived (
        address operator,
        address _from,
        uint256 _value,
        bytes calldata _data
        ) external returns (bytes4);
}