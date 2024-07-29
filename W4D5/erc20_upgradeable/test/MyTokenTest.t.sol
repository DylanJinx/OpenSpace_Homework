// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import "../src/MyToken.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";
import { Upgrades } from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract MyTokenTest is Test {
    MyToken myToken;
    ERC1967Proxy proxy;
    address owner;
    address newOwner;

    address admin;

    function setUp() public {
        console.log("address(this):", address(this));
        admin = address(0x123);
        vm.prank(admin);
        MyToken implementation = new MyToken();
        console.log("implementation address:", address(implementation));
    
        owner = vm.addr(1);

        vm.prank(admin);
        // 部署代理并通过代理合约调用初始化函数来初始化代理合约本身的状态
        proxy = new ERC1967Proxy(
            address(implementation),
            abi.encodeCall(implementation.initialize, admin)
        );
        console_log_AMDIM_SLOT(address(proxy));
        console_log_AMDIM_SLOT(address(myToken));

        console_log_IMPLEMENTATION_SLOT();
        // console_log_AMDIM_SLOT();

        console.log("proxy address:", address(proxy));

        // 用代理关联 MyToken 接口
        // 虽然proxy没有MyToken的方法，但是调用MyToken的方法时，其实就是生成函数选择器+参数
        // 由于proxy没有这个函数，所以调用proxy的fallback函数，fallback函数会delegatecall MyToken的方法
        myToken = MyToken(address(proxy));

        // newOwner = address(1);

        // emit log_address(owner);
        // emit log_address(newOwner);

    }

    function console_log_IMPLEMENTATION_SLOT() private  view{
        bytes32 value = vm.load(address(proxy), bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1));

        console.log("slot of implementation:");
        console.logBytes32(value);
    }

    function console_log_AMDIM_SLOT(address _contract) private view {
        bytes32 adminSlot = bytes32(uint256(keccak256(abi.encodePacked("eip1967.proxy.admin"))) - 1);
        bytes32 value = vm.load(address(_contract), adminSlot);

        console.log("Slot of admin:");
        console.logBytes32(value);

    }

    function test_ERC20Functionality() public {
        vm.prank(admin);
        myToken.mint(address(2), 1000);
        assertEq(myToken.balanceOf(address(2)), 1000);
    }

    function test_Upgradeability() public {
        Upgrades.upgradeProxy(address(proxy), "MyTokenV2.sol:MyTokenV2", "", admin);
        console_log_IMPLEMENTATION_SLOT();
        console_log_AMDIM_SLOT(address(proxy));
        console_log_AMDIM_SLOT(address(myToken));
    }

}