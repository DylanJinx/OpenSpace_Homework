// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {RNTToken} from "../src/RNTToken.sol";
import {esRNTToken} from "../src/esRNTToken.sol";
import {RNTTokenStakePool} from "../src/RNTTokenStakePool.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract RNTTokenStakePool_Test is Test {
    using Strings for uint256;

    address public RNTTokenAdmin;
    uint256 public RNTTokenAdminPrivateKey;

    address public esRNTTokenAdmin;
    uint256 public esRNTTokenAdminPrivateKey;

    address public stakePoolAdmin;
    uint256 public stakePoolAdminPrivateKey;

    address public staker;
    uint256 public stakerPrivateKey;

    RNTToken public RNT;
    esRNTToken public esRNT;
    RNTTokenStakePool public stakePool;

    function setUp() public {
        (RNTTokenAdmin, RNTTokenAdminPrivateKey) = makeAddrAndKey("RNTTokenAdmin");
        (esRNTTokenAdmin, esRNTTokenAdminPrivateKey) = makeAddrAndKey("esRNTTokenAdmin");
        (stakePoolAdmin, stakePoolAdminPrivateKey) = makeAddrAndKey("stakePoolAdmin");
        (staker, stakerPrivateKey) = makeAddrAndKey("staker");

        vm.prank(RNTTokenAdmin);
        RNT = new RNTToken();

        vm.prank(esRNTTokenAdmin);
        esRNT = new esRNTToken(address(RNT));

        vm.prank(stakePoolAdmin);
        stakePool = new RNTTokenStakePool(address(RNT), address(esRNT));
    }



}