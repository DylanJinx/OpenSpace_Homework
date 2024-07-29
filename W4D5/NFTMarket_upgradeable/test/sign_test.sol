// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {DylanToken} from "../src/DylanERC20.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {NFTMarket_v1} from "../src/NFTMarket_v1.sol";
import {UUPS_Proxy} from "../src/UUPS_Proxy.sol";
import {IERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {NFTMarket_v2} from "../src/NFTMarket_v2.sol";

contract sign_test is Test {

    function test_signList_sepolia() public view  {
        uint256 _deadline = 1722275250;
        uint256 sellerPrivateKey = 0x00;
        address seller = vm.addr(sellerPrivateKey);
        console.log("seller: ", seller);

        bytes32 LISTING_TYPEHASH = 0xc895c5f758f496a5ba68797e8c9b666b5e546e7d65b358d335b34c139e2dc875;
        // NFTMarket_upgradeable
        // bytes32 DOMAIN = 0xcaadc73f39634a27f75b9db0e5bd7711702ec29bd472bd044ab03c25b6bcf3ff;
        // NFTMarket_upgradeable_openzepplin
        bytes32 DOMAIN = 0x36dfae541650ab6181d10912f82fb83a819041dee40645c3d4b4288253a88997;

        bytes32 structHash = keccak256(
            abi.encode(
                LISTING_TYPEHASH,
                seller,
                1,
                1000000000000000000,
                _deadline
            )
        );

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                DOMAIN,
                structHash
            )
        );

        // Generate Signature
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(sellerPrivateKey, digest);
        bytes memory signatureForList = abi.encodePacked(r, s, v);

        // NFTMarket_v2.ListWithSignature memory _order = NFTMarket_v2.ListWithSignature({
        //     seller: nftSeller,
        //     tokenId: _tokenId,
        //     price: nftPrice,
        //     deadline: _deadline,
        //     signature: signatureForList
        // });

        console.log("signatureForList: ");
        console.logBytes(signatureForList);

    }
}