// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {RNTToken} from "../src/RNTToken.sol";
import {RNTTokenIDO} from "../src/RNTTokenIDO.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract RNTTokenIDO_Test is Test {
    using Strings for uint256;
    address public RNTTokenAdmin;
    uint256 public RNTTokenAdminPrivateKey;

    address public RNTTokenIDOAdmin;
    uint256 public RNTTokenIDOAdminPrivateKey;

    RNTToken public RNT;
    RNTTokenIDO public RNTIDO;

    function setUp() public {
        (RNTTokenAdmin, RNTTokenAdminPrivateKey) = makeAddrAndKey("RNTTokenAdmin");
        (RNTTokenIDOAdmin, RNTTokenIDOAdminPrivateKey) = makeAddrAndKey("RNTTokenIDOAdmin");

        vm.prank(RNTTokenAdmin);
        RNT = new RNTToken();

        vm.prank(RNTTokenIDOAdmin);
        RNTIDO = new RNTTokenIDO(address(RNT));

        vm.prank(RNTTokenAdmin);
        RNT.setIDOContract(address(RNTIDO));

        vm.prank(RNTTokenIDOAdmin);
        RNTIDO.mintRNT(1000000 * 10 ** 18);
    }

    function test_presale(address user) public {
        vm.deal(user, 0.1 ether);
        uint amount = 0.05 ether;
        require(amount >= 0.01 ether && RNTIDO.balances(user) + amount <= 0.1 ether, "S3Token: invalid amount");
        vm.prank(user);
        RNTIDO.presale{value: amount}();
        assertEq(RNTIDO.balances(user), amount);
        assertEq(RNTIDO.totalETH(), amount);
    }

    function test_manyPeoplePersale() public {
        address claimUser = makeAddr("1001");
        address buyer;
        for (uint i = 0; i < 1000; i++) {
            buyer = makeAddr(i.toString());
            vm.deal(buyer, 0.1 ether);
            vm.prank(buyer);
            RNTIDO.presale{value: 0.1 ether}();
        }
        assertEq(RNTIDO.totalETH(), 100 ether);

        uint256 claimUserAmount = 0.05 ether; 
        vm.deal(claimUser, claimUserAmount);
        vm.prank(claimUser);
        RNTIDO.presale{value: claimUserAmount}();

        vm.warp(RNTIDO.END_TIME() + 1);

        vm.expectEmit(true, false,false, true);
        emit RNTTokenIDO.Withdraw(RNTTokenIDOAdmin, 100 ether + claimUserAmount);
        vm.prank(RNTTokenIDOAdmin);
        RNTIDO.withdraw();

        address user = makeAddr("1");
        uint _giveUser1RNTAmount = RNTIDO.TOTAL_RNT() * RNTIDO.balances(user) / RNTIDO.totalETH();
        vm.expectEmit(true, false,false, true);
        emit RNTTokenIDO.Claim(user, _giveUser1RNTAmount);
        vm.prank(user);
        RNTIDO.claim();

        console.log("user1 RNT balance: ", RNT.balanceOf(user));

        uint _giveClaimUserRNTAmount = RNTIDO.TOTAL_RNT() * RNTIDO.balances(claimUser) / RNTIDO.totalETH();
        vm.expectEmit(true, false,false, true);
        emit RNTTokenIDO.Claim(claimUser, _giveClaimUserRNTAmount);
        vm.prank(claimUser);
        RNTIDO.claim();

        console.log("claimUser RNT balance: ", RNT.balanceOf(claimUser));
    }

    function test_Fail_a_huge_number_of_people_presale() public {
        address buyer;
        for (uint i = 0; i < 2000; i++) {
            buyer = makeAddr(i.toString());
            vm.deal(buyer, 0.1 ether);
            vm.prank(buyer);
            RNTIDO.presale{value: 0.1 ether}();
        }
        assertEq(RNTIDO.totalETH(), 200 ether);

        address user = makeAddr("2001");
        uint amount = 0.01 ether;
        vm.deal(user, amount);

        vm.expectRevert( "S3TokenIDO: presale not active" );
        vm.prank(user);
        RNTIDO.presale{value: amount}();

    }

}