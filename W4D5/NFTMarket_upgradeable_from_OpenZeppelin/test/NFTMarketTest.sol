// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {DylanToken} from "../src/DylanERC20.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {NFTMarket_v1} from "../src/NFTMarket_v1.sol";
import {IERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {NFTMarket_v2} from "../src/NFTMarket_v2.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";
import { Upgrades } from "../lib/openzeppelin-foundry-upgrades/src/Upgrades.sol";

contract NFTMarketTest is Test {
    DylanToken public tokenContract;
    DylanNFT public nftContract;
    NFTMarket_v1 public marketContract_v1;
    NFTMarket_v2 public marketContract_v2;
    ERC1967Proxy public proxy;

    address public nftSeller;
    uint256 public nftSellerPrivateKey;
    address public nftBuyer;
    uint256 public nftBuyerPrivateKey;
    address public proxyAdmin;
    uint256 public proxyAdminPrivateKey;
    uint256 public nftPrice = 1e18;

    // ------------------------------ setup ------------------------------
    function setUp() public {
        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        (nftBuyer, nftBuyerPrivateKey) = makeAddrAndKey("nftBuyer");
        (proxyAdmin, proxyAdminPrivateKey) = makeAddrAndKey("proxyAmdin");

        console.log("proxy admin: ", proxyAdmin);

        vm.prank(nftSeller);
        nftContract = new DylanNFT();

        tokenContract = new DylanToken();

        NFTMarket_v1 implementation_v1_contract = new NFTMarket_v1();
        console.log("implementation_v1_contract address: ", address(implementation_v1_contract));

        vm.prank(proxyAdmin);
        proxy = new ERC1967Proxy(
            address(implementation_v1_contract), 
            abi.encodeCall(
                implementation_v1_contract.initialize, 
                (address(nftContract), address(tokenContract),proxyAdmin)
            )
        );

        console.log("proxy address: ", address(proxy));

        marketContract_v1 = NFTMarket_v1(address(proxy));
    }

    // ------------------------------ setUp tools ------------------------------
    // mint a new NFT
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

    // list tht NFT in the market
    function nftSellerListNFT() private returns (uint256) {   
        uint256 tokenId_ = mintNFT();  
        // approve
        vm.expectEmit(true, true, true, true);
        emit IERC721.ApprovalForAll(nftSeller, address(marketContract_v1), true);
        vm.prank(nftSeller);
        nftContract.setApprovalForAll(address(marketContract_v1), true);

        // list
        vm.expectEmit(true, true, false, true);
        emit NFTMarket_v1.Listed(tokenId_, nftSeller, nftPrice);
        vm.prank(nftSeller);
        marketContract_v1.list(tokenId_, nftPrice);

        return tokenId_;
    }

    // give the nftBuyer some tokens
    function GiveBuyerSomeTokens() private {
        vm.expectEmit(true, true, false, true);
        emit IERC20.Transfer(address(this), nftBuyer, 1e18);
        tokenContract.transfer(nftBuyer, nftPrice);
        
        assertEq(tokenContract.balanceOf(nftBuyer), nftPrice, "Buyer does not have enough tokens");
    }

    // list signature
    function signList(uint256 _tokenId) private view returns(NFTMarket_v2.ListWithSignature memory) {
        uint256 _deadline = block.timestamp + 1 days;

        bytes32 structHash = keccak256(
            abi.encode(
                marketContract_v2.LISTING_TYPEHASH(),
                nftSeller,
                _tokenId,
                nftPrice,
                _deadline
            )
        );

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                marketContract_v2.getDomainSeparator(),
                structHash
            )
        );

        // Generate Signature
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest);
        bytes memory signatureForList = abi.encodePacked(r, s, v);

        NFTMarket_v2.ListWithSignature memory _order = NFTMarket_v2.ListWithSignature({
            seller: nftSeller,
            tokenId: _tokenId,
            price: nftPrice,
            deadline: _deadline,
            signature: signatureForList
        });

        return _order;
    }


    // ------------------------------ test ------------------------------
    // 先测试在v1版本下的流程，然后升级到v2版本，再测试v2版本下的流程
    function test_NFTMarket_v1_upgrade_v2_openzeppelin() public {
        uint256 tokenId = nftSellerListNFT();
        GiveBuyerSomeTokens();

        // buy
        vm.prank(nftBuyer);
        tokenContract.approve(address(marketContract_v1), nftPrice);
        vm.prank(nftBuyer);
        marketContract_v1.buyNFT(tokenId);

        assertEq(nftContract.ownerOf(tokenId), nftBuyer, "NFT was not transferred");
        require(tokenContract.balanceOf(nftSeller) == 1e18, "Seller still has tokens");
        require(tokenContract.balanceOf(nftBuyer) == 0, "Buyer still has tokens");

        // deploy NFTMarket_v2
        NFTMarket_v2 implementation_v2_contract = new NFTMarket_v2();
        // upgrade
        vm.prank(proxyAdmin);
        marketContract_v1.upgradeToAndCall(address(implementation_v2_contract), "");
        marketContract_v2 = NFTMarket_v2(address(proxy));

        // list for sign
        uint256 tokenId_1 = mintNFT();
        require(tokenId_1 == 1, "tokenId_1 error");
        NFTMarket_v2.ListWithSignature memory _order = signList(tokenId_1);

        GiveBuyerSomeTokens();

        vm.prank(nftBuyer);
        tokenContract.approve(address(marketContract_v2), nftPrice);
        vm.prank(nftBuyer);
        marketContract_v2.BuyWithLS(_order);

        assertEq(nftContract.ownerOf(tokenId_1), nftBuyer, "NFT was not transferred");
        require(tokenContract.balanceOf(nftSeller) == 2e18, "Seller still has tokens");
        require(tokenContract.balanceOf(nftBuyer) == 0, "Buyer still has tokens");
    }

    function test_Upgradeability() public {
        Upgrades.upgradeProxy(address(proxy), "NFTMarket_v2.sol:NFTMarket_v2", "", proxyAdmin);

    }

}

