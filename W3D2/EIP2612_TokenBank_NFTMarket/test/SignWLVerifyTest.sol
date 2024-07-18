// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {SetupTools} from "./SetupTools.sol";

contract SignWLVerify is Test {
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

    // --------------------------------------------------------------setupTools--------------------------------------------------------------


    // --------------------------------------------------------------sign ERC20--------------------------------------------------------------
    // Whitelist signatures
    function signWL(address user) private view returns(NFTMarket.WLData memory) {


        bytes32 structHash = keccak256(
            abi.encode(
                marketContract.WL_TYPEHASH(),
                user
            )
        );
        
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                marketContract.getDomainSeparator(),
                structHash
            )
        );
        
        // bytes32 digest = marketContract.getWLDigest(user);

        // Generate Signature
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest); 
        
        NFTMarket.WLData memory wlData = NFTMarket.WLData({
            v: v,
            r: r,
            s: s,
            user: user
        });

        console.log("test domain");
        console.logBytes32(marketContract.getDomainSeparator()); 
        console.log("test structHash");
        console.logBytes32(structHash); 
        console.log("test digest");
        console.logBytes32(digest); 

        console.log("market domain");
        console.logBytes32(marketContract.getDomainSeparator()); 
        console.log("market structHash");
        console.logBytes32(marketContract.getStructHash(user));
        console.log("market digest");
        console.logBytes32(marketContract.getWLDigest(user)); 

        return wlData;
    }

    // function test_signWL() public view {
    //     NFTMarket.WLData memory signatureForWL = signWL(nftBuyer);
    // }


    // --------------------------------------------------------------verification--------------------------------------------------------------
    //verify WL
    function test_WhitelistVerification() public view {

        NFTMarket.WLData memory signatureForWL = signWL(nftBuyer);

        marketContract.verifyWL(signatureForWL);
    }

}