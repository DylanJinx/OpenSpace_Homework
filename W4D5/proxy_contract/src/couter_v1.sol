// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
➜  proxy_contract git:(main) ✗ forge create --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 Counter --constructor-args 10
[⠊] Compiling...
No files changed, compilation skipped
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
Transaction hash: 0x1eb41ddf9f6a5f934e687eb499c682b60fe9f09e18d6b7e67f55608fb720bc51
 */

contract Counter {
    uint private counter;

    constructor(uint x) {
        counter = x;
    }


    function init(uint x) public {
        counter = x;
    }

    function add(uint256 i) public {
        counter += 1;
    }

    function get() public view returns(uint) {
        return counter;
    }
}