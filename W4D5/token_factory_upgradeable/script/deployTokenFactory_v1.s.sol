// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/TokenFactory_v1.sol";
import "forge-std/Script.sol";

contract DeployTokenFactory_v1 is Script {
    function run() public {
        vm.startBroadcast();
        TokenFactory_v1 implementation_v1_contract = new TokenFactory_v1();
        vm.stopBroadcast();

        console.log("implementation_v1_contract address: ", address(implementation_v1_contract));
    }
}