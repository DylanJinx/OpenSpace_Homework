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
import "./NFTFuzzyTest.sol";

contract NFT_InVariant_Test is Test {
    BaseERC20 public tokenContract;
    DylanNFT public nftContract;
    NFTMarket public nftMarket;

    address public nftSeller;

    NFTFuzzyTest public nftFuzzyTest;

    function setUp() public {
        tokenContract = new BaseERC20();
        nftSeller = makeAddr("seller");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        nftMarket = new NFTMarket(address(nftContract), address(tokenContract));
        nftFuzzyTest = new NFTFuzzyTest();
        targetContract(address(nftFuzzyTest));
    }

    function invariant_NFTMarket_zero_token() public {
        assertEq(tokenContract.balanceOf(address(nftMarket)), 0, "NFTMarket should have 0 token");
    }
}