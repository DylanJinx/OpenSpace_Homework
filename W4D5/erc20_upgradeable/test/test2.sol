// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/MyTokenV2.sol";
import "forge-std/Script.sol";
import {Test, console} from "../lib/forge-std/src/Test.sol";

contract DeployUUPSProxy_www111 is Test {
    function test_w11() public pure {
        address _implementation = 0xefEba4A1D4Da5f7BaAB1d0560C5AA2ECdF02ebF6;

        bytes memory data = abi.encodeWithSelector(
            MyTokenV2(_implementation).initialize.selector,
            0x3A8492819b0C9AB5695D447cbA2532b879d25900
        );

        console.logBytes(data);
    }
}