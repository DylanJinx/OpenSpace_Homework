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

contract UUPS_Proxy_Test is Test {
    DylanToken public tokenContract;
    DylanNFT public nftContract;
    NFTMarket_v1 public marketContract_v1;
    NFTMarket_v2 public marketContract_v2;
    UUPS_Proxy public proxyContract;

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
        proxyContract = new UUPS_Proxy(address(implementation_v1_contract));

        marketContract_v1 = NFTMarket_v1(address(proxyContract));

        marketContract_v1.initialize(address(nftContract), address(tokenContract), proxyAdmin);
    }

    // ------------------------------ setup tools ------------------------------
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
    function test_Proxy_Slot() public view {
        // 都是在调用proxyContract._getImplementation()
        require(proxyContract._getImplementation() == marketContract_v1._getImplementation(), "implementation error");
        // proxyContract.getAdmin() 和 marketContract_v1.getAdmin() 都是获取proxy合约存储的值   
        require(proxyAdmin == marketContract_v1._getAdmin(), "admin error");
    }

    // 先测试在v1版本下的流程，然后升级到v2版本，再测试v2版本下的流程
    function test_NFTMarket_v1_upgrade_v2() public {
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

        // upgrade
        NFTMarket_v2 implementation_v2_contract = new NFTMarket_v2();
        console.log("implementation_v2_contract address: ", address(implementation_v2_contract));
        vm.prank(proxyAdmin);
        marketContract_v1._upgradeImplementation(address(implementation_v2_contract));
        require(proxyContract._getImplementation() == address(implementation_v2_contract), "implementation error");
        marketContract_v2 = NFTMarket_v2(address(proxyContract));
        require(proxyAdmin == marketContract_v2._getAdmin(), "admin error");

        // list
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


}