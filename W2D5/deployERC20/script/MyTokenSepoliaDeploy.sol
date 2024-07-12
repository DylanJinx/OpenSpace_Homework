// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";
import {Test} from "forge-std/Test.sol";

contract SepoliaDeploy is Script {
    function run() public {
        vm.startBroadcast();
        // 你的合约构造器参数
        MyToken myContract = new MyToken("Jinx Token", "JD");
        vm.stopBroadcast();
    }
}
