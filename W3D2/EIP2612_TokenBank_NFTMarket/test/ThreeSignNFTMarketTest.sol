// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {ThreeSignNFTMarket} from "../src/ThreeSignNFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";

contract NoListSign_BuyNFTTest is Test {
    ThreeSignNFTMarket public marketContract;
    MyToken public tokenContract;
    DylanNFT public nftContract;

    address public nftSeller;
    uint256 public nftSellerPrivateKey;
    address public nftBuyer;
    uint256 public nftBuyerPrivateKey;
    uint256 public tokenId;

    function setUp() public {
        tokenContract = new MyToken();
        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        (nftBuyer, nftBuyerPrivateKey) = makeAddrAndKey("nftBuyer");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        marketContract = new ThreeSignNFTMarket(address(nftContract), address(tokenContract), nftSeller);
    }

    // 白名单签名
    function signWL() private view returns(bytes memory) {
        bytes32 structHash = keccak256(
            abi.encode(
                marketContract.WL_TYPEHASH,
                nftBuyer
            )
        );
        
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                marketContract.getDomainSeparator(),
                structHash
            )
        );

        // 生成签名
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest); 
        bytes memory signatureForWL = abi.encodePacked(r, s, v);

        return signatureForWL;
    }

    // 上架签名
    function signListing(
        address _nft, 
        uint256 _tokenId, 
        uint256 _price, 
        uint256 _deadline
    ) private view returns(bytes memory) {
        bytes32 structHash = keccak256(
            abi.encode(
                marketContract.LISTING_TYPEHASH,
                _nft,
                _tokenId,
                _price,
                _deadline
            )
        );
        
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                marketContract.getDomainSeparator(),
                structHash
            )
        );

        // 生成签名
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest); 
        bytes memory signatureForWL = abi.encodePacked(r, s, v);

        return signatureForWL;
    }
}