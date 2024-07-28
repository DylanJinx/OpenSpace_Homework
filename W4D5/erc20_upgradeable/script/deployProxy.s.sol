// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/MyToken.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "forge-std/Script.sol";

contract DeployUUPSProxy is Script {
    function run() public {
        address _implementation = 0x5DaE2b3aA08Dc2E473eef96b3CBB09F3302c26a9;

        vm.startBroadcast();

        bytes memory data = abi.encodeWithSelector(
            MyToken(_implementation).initialize.selector,
            0x3A8492819b0C9AB5695D447cbA2532b879d25900
        );

        ERC1967Proxy proxy = new ERC1967Proxy(_implementation, data);

        vm.stopBroadcast();

        console.log("UUPS Proxy Address: ", address(proxy));

    }
}