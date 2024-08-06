// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IContractWallet.sol";

contract ContractWallet is IContractWallet {
    uint8 public immutable NEED_SIGNERS;
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
        NEED_SIGNERS = uint8(_signers.length / 2 + 1);
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

    function changeSigner(address _oldSigner, address _newSigner) public {
        require(msg.sender == address(this), "Only executeTransaction function can change signer");
        require(signers[_oldSigner], "Old signer does not exist");
        require(_newSigner != address(0), "New signer is the zero address");
        require(!signers[_newSigner], "New signer already exists");

        signers[_oldSigner] = false;
        signers[_newSigner] = true;

        emit SignerChanged(_oldSigner, _newSigner);
    }

    receive() external payable {}
    fallback() external payable {}

    event TransactionProposed(uint indexed nonce, address indexed _to, uint value, bytes _data);
    event TransactionExecuted(uint indexed nonce);
    event SignerChanged(address indexed _oldSigner, address indexed _newSigner);

    error notEnoughInitialSigners();
    error onlySignersCanProposeTransaction();
    error onlySignersCanConfirm();
    error notEnoughConfirmations();
    error transactionAlreadyExecuted();
}