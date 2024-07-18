// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract SetupTools is Test {
    NFTMarket public marketContract;
    MyToken public tokenContract;
    DylanNFT public nftContract;
    // NFTMarketMock public marketContractMock;

    address public nftSeller;
    uint256 public nftSellerPrivateKey;
    address public nftBuyer;
    uint256 public nftBuyerPrivateKey;
    uint256 public tokenId;
    uint256 public nftPrice = 1e18;

    function setUp() public {
        tokenContract = new MyToken();
        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        (nftBuyer, nftBuyerPrivateKey) = makeAddrAndKey("nftBuyer");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        marketContract = new NFTMarket(address(nftContract), address(tokenContract), nftSeller);
        //marketContractMock = new NFTMarketMock(address(nftContract), address(tokenContract), nftSeller);

    }

    // mint a new NFT
    function mintNFT() public {  
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(address(0), nftSeller, 0);
        vm.prank(nftSeller);
        tokenId = nftContract.mintTo(nftSeller, "https://ipfs.io/ipfs/CID1");
        // Check if the NFT was minted with the correct URI
        assertEq(nftContract.tokenURI(tokenId), "https://ipfs.io/ipfs/CID1", "URI does not match");
        console.log("Minted NFT with tokenId:", tokenId);
    }

    // list the NFT in the market
    function nftSellerListNFT() public {   
        // mintNFT();  
        // approve
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), 0);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId);
        // list
        vm.expectEmit(true, true, true, true);
        emit NFTMarket.Listed(tokenId, nftSeller, 1e18);
        vm.prank(nftSeller);
        marketContract.list(tokenId, nftPrice);

        // Check if NFT is correctly listed in the market
        (uint256 listedPrice, address listedSeller) = marketContract.listings(tokenId);
        assertEq(listedPrice, nftPrice, "Price did not match the listed price.");
        assertEq(listedSeller, nftSeller, "Seller is not listed correctly.");

        console.log("NFT successfully listed with tokenId:", tokenId);
        console.log("Listed Price:", listedPrice);
        console.log("Seller Address:", listedSeller);
    }

    // give the nftBuyer some tokens
    function GiveBuyerSomeTokens() private {
        vm.expectEmit(true, true, false, true);
        emit IERC20.Transfer(address(this), nftBuyer, 1e18);
        tokenContract.transfer(nftBuyer, nftPrice);
        
        assertEq(tokenContract.balanceOf(nftBuyer), nftPrice, "Buyer does not have enough tokens");
    }


}