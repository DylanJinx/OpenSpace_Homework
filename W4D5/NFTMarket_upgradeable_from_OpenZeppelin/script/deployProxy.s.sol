// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/NFTMarket_v1.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "forge-std/Script.sol";

contract DeployUUPSProxy is Script {
    function run() public {

        address _implementation = 0x644dBD7A52E93A02f34cf521A55ce3a309a70E83;
        address nftContract = 0x8eDd5ED36B1e1dd1FB55e1D3A82DffB417825188;
        address tokenContract = 0xBD1A56e4bC4E22ae10F13a242e62C40A87fF180A;
        address proxyAdmin = 0x3A8492819b0C9AB5695D447cbA2532b879d25900;

        vm.startBroadcast();

        // Encode the initializer function call
        bytes memory data = abi.encodeWithSelector(
            NFTMarket_v1(_implementation).initialize.selector,
            nftContract, 
            tokenContract,
            proxyAdmin // Initial owner/admin of the contract
        );

        // Deploy the proxy contract with the implementation address and initializer
        ERC1967Proxy proxy = new ERC1967Proxy(_implementation, data);

        vm.stopBroadcast();
        // Log the proxy address
        console.log("UUPS Proxy Address:", address(proxy));
        console.log("data:");
        console.logBytes(data);
    }
}