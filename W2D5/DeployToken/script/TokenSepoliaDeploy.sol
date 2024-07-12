// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract SepoliaDeploy is Script {

    //forge script --account Dylan_5900 --rpc-url sepolia script/TokenSepoliaDeploy.sol:SepoliaDeploy --broadcast -vvvv
    function run() public {
        vm.startBroadcast();
        // 你的合约构造器参数
        MyToken myContract = new MyToken("Jinx Token", "JD");
        vm.stopBroadcast();
    }
}
