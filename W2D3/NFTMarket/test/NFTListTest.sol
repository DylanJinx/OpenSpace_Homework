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

contract NFTListTest is Test {
    BaseERC20 public tokenContract;
    DylanNFT public nftContract;
    NFTMarket public nftMarket;

    address public nftSeller;
    address public nftBuyer;
    uint256 public tokenId;

    function setUp() public {
        tokenContract = new BaseERC20();
        nftSeller = makeAddr("seller");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        nftMarket = new NFTMarket(address(nftContract), address(tokenContract));
        nftBuyer = makeAddr("buyer");

        // mint a new NFT
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(address(0), nftSeller, 0);

        vm.expectEmit(false, false, false, true);
        emit IERC4906.MetadataUpdate(0);

        vm.prank(nftSeller);
        tokenId = nftContract.mintTo(nftSeller, "https://ipfs.io/ipfs/CID1");

        // Check if the NFT was minted with the correct URI
        assertEq(nftContract.tokenURI(tokenId), "https://ipfs.io/ipfs/CID1", "URI does not match");

        console.log("Minted NFT with tokenId:", tokenId);
    }

    // function testMint() public {
    //     vm.expectEmit(true, true, true, true);
    //     emit IERC721.Transfer(address(0), nftSeller, 0);

    //     vm.expectEmit(false, false, false, true);
    //     emit IERC4906.MetadataUpdate(0);

    //     vm.prank(nftSeller);
    //     tokenId = nftContract.mintTo(nftSeller, "https://ipfs.io/ipfs/CID1");

    //     // Check if the NFT was minted with the correct URI
    //     assertEq(nftContract.tokenURI(tokenId), "https://ipfs.io/ipfs/CID1", "URI does not match");

    //     console.log("Minted NFT with tokenId:", tokenId);
    // }

    // list success
    function testListNFT() public {
        uint256 price = 10e18;
        bytes memory data = abi.encode(price);

        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(nftSeller, address(nftMarket), tokenId);
        
        vm.expectEmit(true, true, false, true);
        emit NFTMarket.Listed(tokenId, nftSeller, price);

        vm.prank(nftSeller);
        nftContract.safeTransferFrom(nftSeller, address(nftMarket), tokenId, data);

        // Check if NFT is correctly listed in the market
        (uint256 listedPrice, address listedSeller) = nftMarket.listings(tokenId);
        assertEq(listedPrice, price, "Price did not match the listed price.");
        assertEq(listedSeller, nftSeller, "Seller is not listed correctly.");

        console.log("NFT successfully listed with tokenId:", tokenId);
        console.log("Listed Price:", listedPrice);
        console.log("Seller Address:", listedSeller);
    }

    // list fail: non-owner listing
    function testNonOwnerListingNFT() public {
        uint256 price = 10e18;
        bytes memory data = abi.encode(price);

        vm.expectRevert(abi.encodeWithSelector(IERC721Errors.ERC721InsufficientApproval.selector, nftBuyer, tokenId));
        // vm.expectRevert();
        
        vm.prank(nftBuyer);
        nftContract.safeTransferFrom(nftBuyer, address(nftMarket), tokenId, data);
    }

}