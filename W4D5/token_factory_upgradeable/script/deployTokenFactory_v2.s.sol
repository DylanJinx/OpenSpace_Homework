// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/TokenFactory_v2.sol";
import "forge-std/Script.sol";

contract DeployTokenFactory_v2 is Script {
    function run() public {
        vm.startBroadcast();
        TokenFactory_v2 implementation_v1_contract = new TokenFactory_v2();
        vm.stopBroadcast();

        console.log("implementation_v2_contract address: ", address(implementation_v1_contract));
    }
}