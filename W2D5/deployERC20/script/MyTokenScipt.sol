// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract CounterScript is Script {
    MyToken public myTokenContract;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        myTokenContract = new MyToken("Dylan Token", "DJ");

        vm.stopBroadcast();

        console.log("Contracts have benn deployed to: ", address(myTokenContract));
    }
}
