// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {ContractWallet} from "../src/ContractWallet.sol";
import {IContractWallet} from "../src/IContractWallet.sol";

contract Attacker {
    IContractWallet public contractWallet;

    constructor(address _contractWallet) {
        contractWallet = IContractWallet(payable(_contractWallet));
    }

    receive() external payable {
        contractWallet.executeTransaction(1);
    }

    fallback() external payable {
        contractWallet.executeTransaction(1);
    }
}


contract ContractWallet_Test is Test {
    address public signer1;
    address public signer2;
    address public signer3;
    address[] public signers;

    address public banker;

    ContractWallet public contractWallet;

    function setUp() public {
        signer1 = makeAddr("signer1");
        signer2 = makeAddr("signer2");
        signer3 = makeAddr("signer3");
        banker = makeAddr("banker");

        signers = new address[](3);
        signers[0] = signer1;
        signers[1] = signer2;
        signers[2] = signer3;

        vm.deal(signer1, 100 ether);
        vm.deal(signer2, 100 ether);
        vm.deal(signer3, 100 ether);

        contractWallet = new ContractWallet(signers);
    }

    function test_transfer() public {
        vm.prank(signer1);
        uint32 _nonce = contractWallet.proposeTransaction(banker, 10 ether, "");
        vm.prank(signer2);
        contractWallet.confirm(_nonce);

        vm.prank(signer3);
        (bool success, ) = address(contractWallet).call{value: 10 ether}("");
        console.log("success: ", success);  

        contractWallet.executeTransaction(_nonce);

        assertEq(signer1.balance, 100 ether, "signer1 balance error");
        assertEq(signer2.balance, 100 ether, "signer2 balance error");
        assertEq(signer3.balance, 90 ether, "signer3 balance error");
        assertEq(banker.balance, 10 ether, "banker balance error");
    }

    function test_ReentrantAttack() public {
        Attacker attacker = new Attacker(address(contractWallet));

        vm.prank(signer1);
        uint32 _nonce = contractWallet.proposeTransaction(address(attacker), 1 ether, "");
        vm.prank(signer2);
        contractWallet.confirm(_nonce);

        vm.prank(signer3);
        (bool success, ) = address(contractWallet).call{value: 10 ether}("");
        console.log("success: ", success);  

        vm.expectRevert();
        contractWallet.executeTransaction(_nonce);
    }
}