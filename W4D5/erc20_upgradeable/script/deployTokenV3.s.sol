// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/MyTokenV3.sol";
import "forge-std/Script.sol";

contract DeployTokenV3Implementation is Script {
    function run() public {
        vm.startBroadcast();

        MyTokenV3 implementation = new MyTokenV3();
        vm.stopBroadcast();

        console.log("implementation address:", address(implementation));
    }
}