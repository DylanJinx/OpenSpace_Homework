// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/MyTokenV2.sol";
import "forge-std/Script.sol";

contract DeployTokenV2Implementation is Script {
    function run() public {
        vm.startBroadcast();

        MyTokenV2 implementation = new MyTokenV2();
        vm.stopBroadcast();

        console.log("implementation address:", address(implementation));
    }
}