// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/DylanToken_v2.sol";
import "forge-std/Script.sol";

contract DeployDylanToken_v2 is Script {
    function run() public {
        vm.startBroadcast();
        DylanToken_v2 DylanToken_v2_contract = new DylanToken_v2();
        vm.stopBroadcast();

        console.log("DylanToken_v2_contract address: ", address(DylanToken_v2_contract));
    }
}