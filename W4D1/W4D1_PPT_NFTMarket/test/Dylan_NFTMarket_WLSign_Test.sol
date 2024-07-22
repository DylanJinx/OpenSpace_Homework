// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {Dylan_NFTMarket} from "../src/Dylan_NFTMarket.sol";

contract Dylan_NFTMarket_WLSign_Test is Test {
    Dylan_NFTMarket public marketContract;
    MyToken public tokenContract;
    DylanNFT public nftContract;

    address public nftSeller;
    uint256 public nftSellerPrivateKey;
    address public nftBuyer;
    uint256 public nftBuyerPrivateKey;
    address public Fee_Collector;
    uint256 public Fee_CollectorPrivateKey;
    // uint256 public tokenId;
    uint256 public nftPrice = 1e18;

    // --------------------------------------------------------------setup--------------------------------------------------------------
    function setUp() public {
        tokenContract = new MyToken();
        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        (nftBuyer, nftBuyerPrivateKey) = makeAddrAndKey("nftBuyer");
        (Fee_Collector, Fee_CollectorPrivateKey) = makeAddrAndKey("Fee_Collector");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        marketContract = new Dylan_NFTMarket();
    }

    // -----------------------------------------------------------setupTools-------------------------------------------------------
    function mintNFT() private returns (uint256) {  
        uint256 tokenId_;

        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(address(0), nftSeller, 0);
        vm.prank(nftSeller);
        tokenId_ = nftContract.mintTo(nftSeller, "https://ipfs.io/ipfs/CID1");
        // Check if the NFT was minted with the correct URI
        assertEq(nftContract.tokenURI(tokenId_), "https://ipfs.io/ipfs/CID1", "URI does not match");
        console.log("Minted NFT with tokenId:", tokenId_);

        return tokenId_;
    }

    // list the NFT in the market
    function nftSellerListNFT(bool _needWLSign) private returns (uint256) {   
        uint256 tokenId_ = mintNFT();  
        // approve
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), 0);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);
        // list

        uint NFTdeadline = block.timestamp + 365 days; 
        Dylan_NFTMarket.SellOrder memory order_ = Dylan_NFTMarket.SellOrder({
            seller: nftSeller,
            nft: address(nftContract),
            tokenId: tokenId_,
            payToken: address(tokenContract),
            price: nftPrice,
            deadline: NFTdeadline,
            needWLSign: _needWLSign
        });

        bytes32 orderHashId = keccak256(abi.encode(order_));

        vm.expectEmit(true, true, true, true);
        emit Dylan_NFTMarket.Listed(address(nftContract), 0, orderHashId,  nftSeller, address(tokenContract), 1e18, NFTdeadline, _needWLSign);
        vm.prank(nftSeller);
        marketContract.list(address(nftContract), tokenId_, address(tokenContract), nftPrice, NFTdeadline, _needWLSign);

        // Check if NFT is correctly listed in the market
       bytes32 backOrderHashId = marketContract.isListed(address(nftContract), tokenId_);
       assertEq(backOrderHashId, orderHashId, "OrderHashId does not match the listed orderHashId.");

        console.log("---------------------list---------------------------");
        console.log("NFT successfully listed: ");
        console.log("NFT Contract Address:", address(nftContract));
        console.log("TokenId:", tokenId_);
        console.log("Token Contract Address:", address(tokenContract));
        console.log("Listed Price:", nftPrice);
        console.log("Deadline:", NFTdeadline);
        console.log("NeedWLSign:", _needWLSign);

        return tokenId_;
    }

    // give the nftBuyer some tokens
    function GiveBuyerSomeTokens() private {
        vm.expectEmit(true, true, false, true);
        emit IERC20.Transfer(address(this), nftBuyer, 1e18);
        tokenContract.transfer(nftBuyer, nftPrice);
        
        assertEq(tokenContract.balanceOf(nftBuyer), nftPrice, "Buyer does not have enough tokens");
    }

    // set FeeTo
    function setNFTMarketFeeTo(address _to) private {
        vm.expectEmit(true, false, false, false);
        emit Dylan_NFTMarket.FeeToChanged(_to);

        marketContract.setFeeTo(_to);
    }

    // set nftContract whitelist signer
    function setNFTContractWLSigner() private {
        vm.expectEmit(true, true, false, false);
        emit Dylan_NFTMarket.WLSignerChanged(address(nftContract), nftSeller);

        marketContract.setNFT_WLSigner(address(nftContract), nftSeller);
    }

    // -----------------------------------------------------------signatures-----------------------------------------------------------
    // Whitelist signature
    function signWL(address _nftContractAddress, address _user) private view returns(Dylan_NFTMarket.WLData memory) {
        bytes32 structHash = keccak256(
            abi.encode(
                marketContract.WL_TYPEHASH(),
                _nftContractAddress,
                _user
            )
        );

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                marketContract.getDomainSeparator(),
                structHash
            )
        );

        // Generate Signature
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest);
        bytes memory signatureForWL = abi.encodePacked(r, s, v);

        Dylan_NFTMarket.WLData memory wlData = Dylan_NFTMarket.WLData({
            nft: _nftContractAddress,
            user: _user,
            signature: signatureForWL
        });

        return wlData;
    }

    // --------------------------------------------------------------tests--------------------------------------------------------------
    // The buyer uses the whitelist signature to buy the NFT that requires the whitelist signature
    function test_Success_One_WLSign() public {
        // This NFT requires whitelist purchase
        uint256 tokenId_= nftSellerListNFT(true);
        bytes32 orderHashId_ = marketContract.isListed(address(nftContract), tokenId_);
        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();
        // approve ERC20 to marketContract
        vm.prank(nftBuyer);
        tokenContract.approve(address(marketContract), nftPrice);

        // set FeeTo
        // setNFTMarketFeeTo(address(0));
        // set nftContract whitelist signer
        setNFTContractWLSigner();

        // generate WL signature
        Dylan_NFTMarket.WLData memory wlData = signWL(address(nftContract), nftBuyer);


        vm.prank(nftBuyer);
        marketContract.buy(orderHashId_, wlData.signature);

        assertEq(nftContract.ownerOf(tokenId_), nftBuyer, "NFT was not transferred to the buyer");
        assertEq(tokenContract.balanceOf(nftSeller), 1e18, "Seller did not receive the tokens");
        assertEq(tokenContract.balanceOf(nftBuyer), 0, "Buyer still has tokens");
    } 

    // The buyer does not uses the whitelist signature to buy the NFT that require the whitelist signature
    function test_Fail_One_WLSign() public {
        // This NFT requires whitelist purchase
        uint256 tokenId_= nftSellerListNFT(true);
        bytes32 orderHashId_ = marketContract.isListed(address(nftContract), tokenId_);
        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();
        // approve ERC20 to marketContract
        vm.prank(nftBuyer);
        tokenContract.approve(address(marketContract), nftPrice);

        vm.expectRevert(abi.encodeWithSelector(Dylan_NFTMarket.NeedWLSign.selector));
        vm.prank(nftBuyer);
        marketContract.buy(orderHashId_);
    } 

    // need handling fee
    function test_Success_One_WLSign_fee() public {
        // This NFT requires whitelist purchase
        uint256 tokenId_= nftSellerListNFT(true);
        bytes32 orderHashId_ = marketContract.isListed(address(nftContract), tokenId_);
        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();
        // approve ERC20 to marketContract
        vm.prank(nftBuyer);
        tokenContract.approve(address(marketContract), nftPrice);

        // set FeeTo
        setNFTMarketFeeTo(Fee_Collector);
        // set nftContract whitelist signer
        setNFTContractWLSigner();

        // generate WL signature
        Dylan_NFTMarket.WLData memory wlData = signWL(address(nftContract), nftBuyer);

        uint fee = nftPrice * marketContract.feeBP() / 10000;


        vm.prank(nftBuyer);
        marketContract.buy(orderHashId_, wlData.signature);

        assertEq(nftContract.ownerOf(tokenId_), nftBuyer, "NFT was not transferred to the buyer");
        assertEq(tokenContract.balanceOf(nftSeller), 1e18 - fee, "Seller did not receive the tokens");
        assertEq(tokenContract.balanceOf(nftBuyer), 0, "Buyer still has tokens");
        assertEq(tokenContract.balanceOf(Fee_Collector), fee, "Fee_Collector did not receive the tokens");
    } 

}