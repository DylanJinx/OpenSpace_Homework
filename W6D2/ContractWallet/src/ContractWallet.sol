// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IContractWallet.sol";

contract ContractWallet is IContractWallet {
    uint8 public constant NEED_SIGNERS = 2;
    uint32 public nonce;
    
    struct TxInfo{
        address _to;
        uint value;
        bytes _data;
    }

    mapping (uint32 => TxInfo) public txInfos; // txId / nonce => TxInfo
    mapping (uint32 => uint) public confirms; // Current number of transaction confirmations
    mapping (address => bool) public signers;
    mapping (uint32 => bool) public executed;

    constructor(address[] memory _signers) {
        if (_signers.length < NEED_SIGNERS) revert notEnoughInitialSigners();
        for (uint i = 0; i < _signers.length; i++) {
            signers[_signers[i]] = true;
        }
    }

    function proposeTransaction(
        address _to,
        uint _value,
        bytes memory _data
    ) public returns(uint32) {
        if (!signers[msg.sender]) revert onlySignersCanProposeTransaction();

        nonce++;
        txInfos[nonce] = TxInfo(_to, _value, _data);
        confirms[nonce] = 1;

        emit TransactionProposed(nonce, _to, _value, _data);
        return nonce;
    }

    function confirm(uint32 _nonce) public {
        if (!signers[msg.sender]) revert onlySignersCanConfirm();

        confirms[_nonce]++;
    }

    function executeTransaction(uint32 _nonce) public {
        if (confirms[_nonce] < NEED_SIGNERS) revert notEnoughConfirmations();

        if (executed[_nonce]) revert transactionAlreadyExecuted();

        executed[_nonce] = true;
        
        TxInfo memory txInfo = txInfos[_nonce];
        (bool success, ) = txInfo._to.call{value: txInfo.value}(txInfo._data);
        require(success, "Transaction failed");

        emit TransactionExecuted(_nonce);
    }

    receive() external payable {}
    fallback() external payable {}

    event TransactionProposed(uint indexed nonce, address indexed _to, uint value, bytes _data);
    event TransactionExecuted(uint indexed nonce);

    error notEnoughInitialSigners();
    error onlySignersCanProposeTransaction();
    error onlySignersCanConfirm();
    error notEnoughConfirmations();
    error transactionAlreadyExecuted();
}