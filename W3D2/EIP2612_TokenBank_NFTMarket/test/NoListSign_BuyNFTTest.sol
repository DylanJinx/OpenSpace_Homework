// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";

contract NoListSign_BuyNFTTest is Test {
    NFTMarket public marketContract;
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
        marketContract = new NFTMarket(address(nftContract), address(tokenContract), nftSeller);
    }

    function signWL(address user) private view returns(bytes memory) {
        bytes32 structHash = keccak256(
            abi.encode(
                marketContract.WL_TYPEHASH,
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

        // 生成签名
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest); 
        bytes memory signatureForWL = abi.encodePacked(r, s, v);

        return signatureForWL;
    }

    function SignERC20(uint256 _depositAmount, uint256 _nonce, uint256 _deadline) private view returns(uint8 _v, bytes32 _r, bytes32 _s) {
         bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                nftBuyer,
                address(nftContract),
                _depositAmount,
                _nonce,
                _deadline
            )
        );
        
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                tokenContract.DOMAIN_SEPARATOR(),
                structHash
            )
        );

        // 生成签名
        (_v, _r, _s) = vm.sign(nftBuyerPrivateKey, digest); 

        return (_v, _r, _s);
    }
}