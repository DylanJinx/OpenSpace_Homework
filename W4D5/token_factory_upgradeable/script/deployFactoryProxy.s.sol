// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.19;

// import "../src/TokenFactory_v1.sol";
// import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
// import "forge-std/Script.sol";

// contract DeployUUPSProxy is Script {
//     function run() public {
//         address tokenFactory_v1_address = 0x;
//         address _dylanTokenAddress = 0x;
//         address proxyAdmin = 0x3A8492819b0C9AB5695D447cbA2532b879d25900;

//         vm.startBroadcast();

//         // Encode the initializer function call
//         bytes memory data = abi.encodeWithSelector(
//             TokenFactory_v1(tokenFactory_v1_address).initialize.selector,
//             _dylanTokenAddress, 
//             proxyAdmin // Initial owner/admin of the contract
//         );

//         // Deploy the proxy contract with the implementation address and initializer
//         ERC1967Proxy proxy = new ERC1967Proxy(tokenFactory_v1_address, data);

//         vm.stopBroadcast();
//         // Log the proxy address
//         console.log("UUPS Proxy Address:", address(proxy));
//         console.log("data:");
//         console.logBytes(data);
//     }

// }