// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract CounterScript is Script {
    MyToken public myTokenContract;

    function setUp() public {}

    // forge script CounterScript --rpc-url local --broadcast -vvvvv
    function run() public {
        uint256 deployer = vm.envUint("ANVIL_PRIVATE_KEY");

        vm.startBroadcast(deployer);

        myTokenContract = new MyToken("Jinx Token", "JD");

        vm.stopBroadcast();

        console.log("Contracts have benn deployed to: ", address(myTokenContract));
    }
}
