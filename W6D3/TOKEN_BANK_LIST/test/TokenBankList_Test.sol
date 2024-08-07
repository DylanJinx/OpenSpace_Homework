// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../src/TokenBankList.sol";
import "../src/DylanERC20.sol";

contract TokenBankList_Test is Test {
    TokenBankList public bank;
    DylanERC20 public token;
    address constant GUARD = address(1);

    address public user1;
    address public user2;
    address public user3;
    address public user4;
    address public user5;

    function setUp() public {
        token = new DylanERC20();
        bank = new TokenBankList(address(token));

        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
        user3 = makeAddr("user3");
        user4 = makeAddr("user4");
        user5 = makeAddr("user5");

        vm.prank(user1);
        token.mint(1000e18);
        vm.prank(user2);
        token.mint(1000e18);
        vm.prank(user3);
        token.mint(1000e18);
        vm.prank(user4);
        token.mint(1000e18);
        vm.prank(user5);
        token.mint(1000e18);
    }

    function addDepositer() internal {
        vm.prank(user5);
        token.approve(address(bank), 1000e18);
        bank.addDepositer(user5, 5000, GUARD);
        vm.prank(user4);
        token.approve(address(bank), 1000e18);
        bank.addDepositer(user4, 4000, user5);
        vm.prank(user3);
        token.approve(address(bank), 1000e18);
        bank.addDepositer(user3, 3000, user4);
        vm.prank(user2);
        token.approve(address(bank), 1000e18);
        bank.addDepositer(user2, 2000, user3);
        vm.prank(user1);
        token.approve(address(bank), 1000e18);
        bank.addDepositer(user1, 1000, user2);


        assertEq(bank.tokenBalances(user1), 1000);
        assertEq(bank.tokenBalances(user2), 2000);
        assertEq(bank.tokenBalances(user3), 3000);
        assertEq(bank.tokenBalances(user4), 4000);
        assertEq(bank.tokenBalances(user5), 5000);

        assertEq(token.balanceOf(address(bank)), 15000);
        assertEq(token.balanceOf(user1), 1000e18 - 1000);
        assertEq(token.balanceOf(user2), 1000e18 - 2000);
        assertEq(token.balanceOf(user3), 1000e18 - 3000);
        assertEq(token.balanceOf(user4), 1000e18 - 4000);
        assertEq(token.balanceOf(user5), 1000e18 - 5000);

        address[] memory top5 = bank.getTop(5);
        assertEq(top5[0], user5);
        assertEq(top5[1], user4);
        assertEq(top5[2], user3);
        assertEq(top5[3], user2);
        assertEq(top5[4], user1);
    }

    function test_deposit() public {
        addDepositer();
        vm.prank(user3);
        bank.deposit(user3, 1500, user4, user5);
        assertEq(bank.tokenBalances(user3), 4500);
        assertEq(token.balanceOf(address(bank)), 16500);
        assertEq(token.balanceOf(user3), 1000e18 - 4500);

        address[] memory top5 = bank.getTop(5);
        assertEq(top5[0], user5);
        assertEq(top5[1], user3);
        assertEq(top5[2], user4);
        assertEq(top5[3], user2);
        assertEq(top5[4], user1);
    }

    function test_withdraw() public {
        addDepositer();
        vm.prank(user3);
        bank.withdraw(user3, 1500, user4, user2);
        assertEq(bank.tokenBalances(user3), 1500);
        assertEq(token.balanceOf(address(bank)), 13500);
        assertEq(token.balanceOf(user3), 1000e18 - 1500);

        address[] memory top5 = bank.getTop(5);
        assertEq(top5[0], user5);
        assertEq(top5[1], user4);
        assertEq(top5[2], user2);
        assertEq(top5[3], user3);
        assertEq(top5[4], user1);
    }

    // function test_removeDepositer() public {
    //     addDepositer();
    //     vm.prank(user3);
    //     bank.removeDepositer(user3, user4);
    //     assertEq(bank.tokenBalances(user3), 0);
    //     assertEq(token.balanceOf(address(bank)), 12000);
    //     assertEq(token.balanceOf(user3), 1000e18);

    //     address[] memory top4 = bank.getTop(4);
    //     assertEq(top4[0], user5);
    //     assertEq(top4[1], user4);
    //     assertEq(top4[2], user2);
    //     assertEq(top4[3], user1);
    // }


}