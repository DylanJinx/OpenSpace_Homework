// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BaseERC20} from "../src/BaseERC20.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {IERC4906} from "@openzeppelin/contracts/interfaces/IERC4906.sol";
import {IERC721Errors} from "@openzeppelin/contracts/interfaces/draft-IERC6093.sol";

contract NFTFuzzyTest is Test {
    BaseERC20 public tokenContract;
    DylanNFT public nftContract;
    NFTMarket public nftMarket;

    address public nftSeller;
    uint256 public tokenId;

    function setUp() public {
        tokenContract = new BaseERC20();
        nftSeller = makeAddr("seller");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        nftMarket = new NFTMarket(address(nftContract), address(tokenContract));
    }

    function testFuzzBuyNFT(uint256 nftPrice, address nftBuyer) public {
        vm.assume(nftPrice >= 1e16 && nftPrice <= 1e22);
        vm.assume(nftBuyer != address(0) && nftBuyer != nftSeller);

        // --------------mint NFT----------------
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(address(0), nftSeller, 0);

        vm.expectEmit(false, false, false, true);
        emit IERC4906.MetadataUpdate(0);

        vm.prank(nftSeller);
        tokenId = nftContract.mintTo(nftSeller, "https://ipfs.io/ipfs/CID1");

        // Check if the NFT was minted with the correct URI
        assertEq(nftContract.tokenURI(tokenId), "https://ipfs.io/ipfs/CID1", "URI does not match");

        console.log("Minted NFT with tokenId:", tokenId);

        // --------------list NFT----------------
        bytes memory dataPrice = abi.encode(nftPrice);

        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(nftSeller, address(nftMarket), tokenId);
        
        vm.expectEmit(true, true, false, true);
        emit NFTMarket.Listed(tokenId, nftSeller, nftPrice);

        vm.prank(nftSeller);
        nftContract.safeTransferFrom(nftSeller, address(nftMarket), tokenId, dataPrice);

        // Check if NFT is correctly listed in the market
        (uint256 listedPrice, address listedSeller) = nftMarket.listings(tokenId);
        assertEq(listedPrice, nftPrice, "Price did not match the listed price.");
        assertEq(listedSeller, nftSeller, "Seller is not listed correctly.");

        console.log("NFT successfully listed with tokenId:", tokenId);
        console.log("Listed Price:", listedPrice);
        console.log("Seller Address:", listedSeller);

        // --------------buy NFT----------------
        uint256 beforeNftSellerBalance = tokenContract.balanceOf(nftSeller);

        bytes memory dataTokenId = abi.encode(tokenId);

        vm.expectEmit(true, true, false, true);
        emit BaseERC20.Transfer(address(this), nftBuyer, nftPrice);
        tokenContract.transfer(nftBuyer, nftPrice);
        assertEq(tokenContract.balanceOf(nftBuyer), nftPrice, "Buyer does not have enough tokens");

        // Buyer transfer tokens to NFTMarket
        vm.expectEmit(true, true, false, true);
        emit BaseERC20.Transfer(nftBuyer, address(nftMarket), nftPrice);

        // NFTMarket transfer tokens to seller
        vm.expectEmit(true, true, false, true);
        emit BaseERC20.Transfer(address(nftMarket), nftSeller, nftPrice);

        // NFTMarket transfer NFT to buyer
        vm.expectEmit(true, true, false, true);
        emit IERC721.Transfer(address(nftMarket), nftBuyer, tokenId);

        // NFTMarket emit purchase event
        vm.expectEmit(true, true, true, true);
        emit NFTMarket.Purchased(tokenId, nftSeller, nftBuyer, nftPrice);

        // Buyer call transferAndCall function in ERC20
        vm.prank(nftBuyer);
        tokenContract.transferAndCall(address(nftMarket), nftPrice, dataTokenId);

        address newOwner = nftContract.ownerOf(tokenId);
        assertEq(newOwner, nftBuyer, "NFT ownership not transferred to buyer");

        uint256 AfterNftSellerBalance = tokenContract.balanceOf(nftSeller);
        assertEq(AfterNftSellerBalance, beforeNftSellerBalance + nftPrice, "Seller balance not updated");

        // Output for confirmation in logs
        console.log("Test passed: NFT purchased and ownership transferred.");
        console.log("New owner of tokenId", tokenId, "is", newOwner);
    }
}