
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/NFTMarket_v2.sol";
import "forge-std/Script.sol";

contract DeployNFTMarket_v2 is Script {
    function run() public {
        vm.startBroadcast();
        NFTMarket_v2 implementation_v2_contract = new NFTMarket_v2();
        vm.stopBroadcast();

        console.log("implementation_v2_contract address: ", address(implementation_v2_contract));
    }
}