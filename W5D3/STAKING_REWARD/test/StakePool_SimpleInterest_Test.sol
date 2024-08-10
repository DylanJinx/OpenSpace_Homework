// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {StakePool_SimpleInterest} from "../src/StakePool_SimpleInterest.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {Test, console} from "../lib/forge-std/src/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {IERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract StakePool_SimpleInterest_Test is Test {
    DylanNFT public nftContract;
    StakePool_SimpleInterest public stakePool;
    NFTMarket public marketContract;

    address public nftSeller;
    address public nftBuyer;
    address public marketOwner;
    address public staker1;
    address public staker2;

    uint public nftPrice = 10 ether;

    function setUp() public {
        nftSeller = address(0x1);
        nftBuyer = address(0x2);
        marketOwner = address(0x3);
        staker1 = address(0x4);
        staker2 = address(0x5);

        vm.prank(nftSeller);
        nftContract = new DylanNFT();

        vm.deal(nftBuyer, 1000 ether);
        vm.deal(staker1, 10 ether);
        vm.deal(staker2, 10 ether);

        vm.prank(marketOwner);
        marketContract = new NFTMarket();

        stakePool = new StakePool_SimpleInterest(address(marketContract));

        vm.prank(marketOwner);
        marketContract.setStakePool(address(stakePool));
    }

    function mintNFT() private returns (uint256) {  
        uint256 tokenId_;

        // vm.expectEmit(true, true, true, true);
        // emit IERC721.Transfer(address(0), nftSeller, 0);
        vm.prank(nftSeller);
        tokenId_ = nftContract.mintTo(nftSeller, "https://ipfs.io/ipfs/CID1");
        // Check if the NFT was minted with the correct URI
        assertEq(nftContract.tokenURI(tokenId_), "https://ipfs.io/ipfs/CID1", "URI does not match");
        console.log("Minted NFT with tokenId:", tokenId_);

        return tokenId_;
    }

    // list the NFT in the market
    function nftSellerListNFT() private returns (uint256) {   
        uint256 tokenId_ = mintNFT();  
        // approve
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), tokenId_);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);
        // list
        vm.expectEmit(true, true, true, true);
        emit NFTMarket.Listed(address(nftContract), tokenId_, nftSeller, 10e18);
        vm.prank(nftSeller);
        marketContract.list(address(nftContract), tokenId_, nftPrice);

        console.log("---------------------list---------------------------");
        console.log("NFT successfully listed: ");
        console.log("NFT Contract Address:", address(nftContract));
        console.log("TokenId:", tokenId_);
        console.log("Listed Price:", nftPrice);

        return tokenId_;
    }

    function BuyNFT() private {
        uint256 tokenId_ = nftSellerListNFT();

        // buy
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(nftSeller, nftBuyer, tokenId_);
        vm.prank(nftBuyer);
        marketContract.buy{value: 10 ether}(address(nftContract), tokenId_);

        // uint _fee = 10 ether * 30 / 10000;

        assertEq(nftContract.ownerOf(tokenId_), nftBuyer, "NFT was not transferred to the buyer");
        // assertEq(nftSeller.balance, 10 ether - _fee, "Seller balance is not correct");
        
        // assertEq(address(stakePool).balance, _fee+ stakePool.totalStaked(), "StakePool balance is not correct");
    }

    function test_stake() public {
        vm.prank(staker1);
        stakePool.stake{value: 1}();
        assertEq(10 ether - 1, staker1.balance, "Staker1 balance is not correct");
        
        BuyNFT();

        assertEq(10 ether * 30 / 10000, stakePool.earned(staker1), "Staker1 earned is not correct");
    }

    function test_unstake() public {
        vm.prank(staker1);
        stakePool.stake{value: 1}();
        assertEq(10 ether - 1, staker1.balance, "Staker1 balance is not correct");

        vm.prank(staker1);
        stakePool.unstake(1);

        assertEq(10 ether, staker1.balance, "Staker1 balance is not correct");
    }

    function test_claim() public {
        vm.prank(staker1);
        stakePool.stake{value: 1}();
        
        BuyNFT();

        vm.prank(staker1);
        stakePool.claim();

        assertEq(10 ether + (10 ether * 30 / 10000) - 1, staker1.balance, "Staker1 balance is not correct");
        assertEq(0, stakePool.earned(staker1), "Staker1 earned is not correct");
    }

    function test_MultipleStakers() public {
        vm.prank(staker1);
        stakePool.stake{value: 1}();
        vm.prank(staker2);
        stakePool.stake{value: 1}();

        BuyNFT();

        vm.prank(staker1);
        stakePool.claim();
        uint balance_1 = 10 ether + (10 ether * 30 / 10000) / 2 - 1;
        assertEq(balance_1, staker1.balance, "Staker1 balance is not correct");
        assertEq(0, stakePool.earned(staker1), "Staker1 earned is not correct");

        vm.prank(staker2);
        stakePool.claim();
        assertEq(balance_1, staker2.balance, "Staker2 balance is not correct");
        assertEq(0, stakePool.earned(staker2), "Staker2 earned is not correct");

        vm.prank(staker1);
        stakePool.unstake(1);
        BuyNFT();
        assertEq(balance_1 + 1, staker1.balance, "Staker1 balance is not correct");
        assertEq(0, stakePool.earned(staker1), "Staker1 earned is not correct");
        assertEq(balance_1, staker2.balance, "Staker2 balance is not correct");
        assertEq((10 ether * 30 / 10000), stakePool.earned(staker2), "Staker2 earned is not correct");

        vm.prank(staker2);
        stakePool.claim();
        assertEq(balance_1 + (10 ether * 30 / 10000), staker2.balance, "Staker2 balance is not correct");

        vm.prank(staker1);
        stakePool.stake{value: 1 ether}();
        BuyNFT();
        
        uint _fee = 10 ether * 30 / 10000;
        uint numerator = _fee * 1e18;
        uint denominator = 1 ether + 1;
        uint earned_2 = numerator / denominator;
        uint earned_1 = earned_2 * 1 ether;

        // uint earned_2 = uint(10 ether * 1 * 1e18 / (1 ether + 1));

        assertEq(earned_1, stakePool.earned_1e18(staker1), "Staker1 earned is not correct");
        assertEq(earned_2, stakePool.earned_1e18(staker2), "Staker2 earned is not correct");
    }

}