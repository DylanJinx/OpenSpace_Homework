// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {RNTToken} from "../src/RNTToken.sol";
import {RNTTokenIDO} from "../src/RNTTokenIDO.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";
import {ReentrancyGuard} from "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";


contract MaliciousActor {
    RNTTokenIDO public ido;

    constructor(address _ido) {
        ido = RNTTokenIDO(_ido);
    }

    // 尝试着接受到ETH后重入IDO合约
    receive() external payable {
        ido.refund();
    }
}

contract IDO_Reentrancy_refund_Test is Test {
    using Strings for uint256;
    address public RNTTokenAdmin;
    uint256 public RNTTokenAdminPrivateKey;

    address public RNTTokenIDOAdmin;
    uint256 public RNTTokenIDOAdminPrivateKey;

    address public attacker;
    uint256 public attackerPrivateKey;

    RNTToken public RNT;
    RNTTokenIDO public RNTIDO;
    MaliciousActor public maliciousActor;

    function setUp() public {
        (RNTTokenAdmin, RNTTokenAdminPrivateKey) = makeAddrAndKey("RNTTokenAdmin");
        (RNTTokenIDOAdmin, RNTTokenIDOAdminPrivateKey) = makeAddrAndKey("RNTTokenIDOAdmin");
        (attacker, attackerPrivateKey) = makeAddrAndKey("attacker");

        vm.prank(RNTTokenAdmin);
        RNT = new RNTToken();

        vm.prank(RNTTokenIDOAdmin);
        RNTIDO = new RNTTokenIDO(address(RNT));

        vm.prank(RNTTokenAdmin);
        RNT.setIDOContract(address(RNTIDO));

        vm.prank(RNTTokenIDOAdmin);
        RNTIDO.mintRNT(1000000 * 10 ** 18);

        vm.prank(attacker);
        maliciousActor = new MaliciousActor(address(RNTIDO));
    }

    function test_ReentrancyGuard_refund() public {
        address buyer;
        for (uint i = 0; i < 10; i++) {
            buyer = makeAddr(i.toString());
            vm.deal(buyer, 0.1 ether);
            vm.prank(buyer);
            RNTIDO.presale{value: 0.1 ether}();
        }
        assertEq(RNTIDO.totalETH(), 1 ether);

        uint256 attackerAmount = 0.05 ether; 
        vm.deal(address(maliciousActor), attackerAmount);
        vm.prank(address(maliciousActor));
        RNTIDO.presale{value: attackerAmount}();

        vm.warp(RNTIDO.END_TIME() + 1);

        //vm.expectRevert(abi.encodeWithSelector(ReentrancyGuard.ReentrancyGuardReentrantCall.selector));
        vm.expectRevert("S3TokenIDO: refund failed");
        vm.prank(address(maliciousActor));
        RNTIDO.refund();
    }

}