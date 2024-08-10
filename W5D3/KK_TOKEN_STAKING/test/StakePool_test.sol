// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../src/KKToken.sol";
import {StakePool} from "../src/Staking.sol";
import {Test, console} from "../lib/forge-std/src/Test.sol";

contract StakePool_Test is Test {
    StakePool public stakePool;
    KKToken public kkToken;

    address public staker1;
    address public staker2;

    function setUp() public {
        kkToken = new KKToken();
        stakePool = new StakePool(address(kkToken));
        staker1 = address(0x1);
        staker2 = address(0x2);

        vm.deal(staker1, 1000 ether);
        vm.deal(staker2, 1000 ether);
    }

    function test_stake() public {
        vm.prank(staker1);
        stakePool.stake{value: 1}();
        assertEq(stakePool.balanceOf(staker1), 1);
        console.log("block number: ", block.number);
        vm.roll(11);
        console.log("block number: ", block.number);
        assertEq(stakePool.earned(staker1), 100e18);

        vm.prank(staker2);
        stakePool.stake{value: 1}();
        assertEq(stakePool.balanceOf(staker2), 1);
        vm.roll(21);
        assertEq(stakePool.earned(staker2), 50e18);
        assertEq(stakePool.earned(staker1), 150e18);
    }

    function test_unstake() public {
        test_stake();
        vm.prank(staker1);
        stakePool.unstake(1);
        assertEq(stakePool.balanceOf(staker1), 0);
        assertEq(staker1.balance, 1000 ether);
    }

    function test_claim() public {
        test_stake();
        vm.prank(staker1);
        stakePool.claim();
        assertEq(kkToken.balanceOf(staker1), 150e18);
        assertEq(stakePool.earned(staker1), 0);
        vm.prank(staker2);
        stakePool.claim();
        assertEq(kkToken.balanceOf(staker2), 50e18);
        assertEq(stakePool.earned(staker2), 0);
    }
}