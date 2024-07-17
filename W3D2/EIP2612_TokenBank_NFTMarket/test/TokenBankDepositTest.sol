// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TokenBank} from "../src/TokenBank.sol";
import {MyToken} from "../src/MyToken.sol";

contract TokenBankDepositTest is Test {
    MyToken public tokenContract;
    TokenBank public tokenBankContract;

    address public depositer;
    uint256 public privateKey;

    function setUp() public {
        tokenBankContract = new TokenBank();
        tokenContract = new MyToken();
        (depositer, privateKey) = makeAddrAndKey("depositer");

        tokenContract.transfer(depositer, 1000);
    }

    function ERC20Sign(uint256 _depositAmount, uint256 _nonce, uint256 _deadline) private view returns(uint8 _v, bytes32 _r, bytes32 _s) {
         bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                depositer,
                address(tokenBankContract),
                _depositAmount,
                _nonce,
                _deadline
            )
        );
        
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                tokenContract.DOMAIN_SEPARATOR(),
                structHash
            )
        );

        // 生成签名
        (_v, _r, _s) = vm.sign(privateKey, digest); 

        return (_v, _r, _s);
    }


    function testPermitDeposit() public {
        uint256 depositAmount = 500;

        uint256 initialBalance = tokenContract.balanceOf(depositer);
        uint256 initialContractBalance = tokenContract. balanceOf(address(tokenBankContract));


        uint256 deadline = block.timestamp + 1000; // 1000 seconds from now
        uint256 nonce = tokenContract.nonces(depositer);
        uint nonce_ = 0;
        require(nonce == nonce_, "Nonce should be 0");

        // bytes32 structHash = keccak256(
        //     abi.encode(
        //         keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
        //         depositer,
        //         address(tokenBankContract),
        //         depositAmount,
        //         nonce_,
        //         deadline
        //     )
        // );
        
        // bytes32 digest = keccak256(
        //     abi.encodePacked(
        //         "\x19\x01",
        //         tokenContract.DOMAIN_SEPARATOR(),
        //         structHash
        //     )
        // );

        // // 生成签名
        // (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest); 

        (uint8 v, bytes32 r, bytes32 s) = ERC20Sign(depositAmount, nonce_, deadline);

        // 使用生成的签名调用 permitDeposit
        vm.prank(depositer);
        tokenBankContract.permitDeposit(
            address(tokenContract),
            depositAmount,
            deadline,
            v,
            r,
            s
        );

        // 检查结果
        uint256 newBalance = tokenContract.balanceOf(depositer);
        uint256 newContractBalance = tokenContract.balanceOf(address(tokenBankContract));
        assertEq(newBalance, initialBalance - depositAmount, "Deposit amount was not correctly deducted from depositer.");
        assertEq(newContractBalance, initialContractBalance + depositAmount, "Deposit amount was not correctly added to TokenBank.");

    }
}