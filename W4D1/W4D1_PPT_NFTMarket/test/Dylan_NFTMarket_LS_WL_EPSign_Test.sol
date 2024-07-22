// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {Dylan_NFTMarket} from "../src/Dylan_NFTMarket.sol";

contract Dylan_NFTMarket_LS_WL_EPSign_Test is Test {
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

    // approve ERC20 signature
    function SignERC20(uint256 _depositAmount, uint256 _nonce, uint256 _deadline) private view returns(uint8 _v, bytes32 _r, bytes32 _s) {
         bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                nftBuyer,
                address(marketContract),
                _depositAmount,
                _nonce,
                _deadline
            )
        );
        
        bytes32 digest = tokenContract.getDigest(structHash);

        // Generate Signature
        (_v, _r, _s) = vm.sign(nftBuyerPrivateKey, digest); 

        return (_v, _r, _s);
    }

    // list signature
    function signList(
        Dylan_NFTMarket.SellOrder memory order_
    ) private view returns(Dylan_NFTMarket.SellOrderWithSignature memory) {
        bytes32 structHash = keccak256(
            abi.encode(
                marketContract.LISTING_TYPEHASH(),
                order_.seller,
                order_.nft,
                order_.tokenId,
                order_.payToken,
                order_.price,
                order_.deadline,
                order_.needWLSign
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
        bytes memory signatureForList = abi.encodePacked(r, s, v);

        Dylan_NFTMarket.SellOrderWithSignature memory sellOrderWithSignature_ = Dylan_NFTMarket.SellOrderWithSignature({
            order: order_,
            signature: signatureForList
        });

        return sellOrderWithSignature_;
    }

    // --------------------------------------------------------------tests--------------------------------------------------------------
    // The buyer uses the whitelist signature to buy the NFT that requires the whitelist signature
    function test_Success_Three_WLS_EP_LS() public {
        // This NFT requires whitelist purchase
        // uint256 tokenId_= nftSellerListNFT(true);
        uint256 tokenId_ = mintNFT();

        // approve nft to market contract
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), tokenId_);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);

        uint NFTdeadline = block.timestamp + 365 days; 
        Dylan_NFTMarket.SellOrder memory order_ = Dylan_NFTMarket.SellOrder({
            seller: nftSeller,
            nft: address(nftContract),
            tokenId: tokenId_,
            payToken: address(tokenContract),
            price: nftPrice,
            deadline: NFTdeadline,
            needWLSign: true
        });

        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();

        // set FeeTo
        // setNFTMarketFeeTo(address(0));
        // set nftContract whitelist signer
        setNFTContractWLSigner();

        // generate WL signature
        Dylan_NFTMarket.WLData memory wlData = signWL(address(nftContract), nftBuyer);

        // generate ERC20 signature
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, block.timestamp + 1 days);
        Dylan_NFTMarket.ERC20PermitData memory _approveData = Dylan_NFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            token: address(tokenContract),
            deadline: block.timestamp + 1 days
        });

        // generate list signature
        Dylan_NFTMarket.SellOrderWithSignature memory listSignature = signList(order_);

        vm.prank(nftBuyer);
        marketContract.buy(_approveData, wlData.signature, listSignature);

        assertEq(nftContract.ownerOf(tokenId_), nftBuyer, "NFT was not transferred to the buyer");
        assertEq(tokenContract.balanceOf(nftSeller), 1e18, "Seller did not receive the tokens");
        assertEq(tokenContract.balanceOf(nftBuyer), 0, "Buyer still has tokens");
    } 

    // The buyer does not uses the whitelist signature to buy the NFT that does not requires the whitelist signature
    function test_Success2_Three_WLS_EP_LS() public {
        // This NFT requires whitelist purchase
        // uint256 tokenId_= nftSellerListNFT(true);
        uint256 tokenId_ = mintNFT();

        // approve nft to market contract
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), tokenId_);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);

        uint NFTdeadline = block.timestamp + 365 days; 
        Dylan_NFTMarket.SellOrder memory order_ = Dylan_NFTMarket.SellOrder({
            seller: nftSeller,
            nft: address(nftContract),
            tokenId: tokenId_,
            payToken: address(tokenContract),
            price: nftPrice,
            deadline: NFTdeadline,
            needWLSign: false
        });

        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();

        // set FeeTo
        // setNFTMarketFeeTo(address(0));
        // set nftContract whitelist signer
        setNFTContractWLSigner();

        // generate ERC20 signature
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, block.timestamp + 1 days);
        Dylan_NFTMarket.ERC20PermitData memory _approveData = Dylan_NFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            token: address(tokenContract),
            deadline: block.timestamp + 1 days
        });

        // generate list signature
        Dylan_NFTMarket.SellOrderWithSignature memory listSignature = signList(order_);

        vm.prank(nftBuyer);
        marketContract.buy(_approveData, listSignature);

        assertEq(nftContract.ownerOf(tokenId_), nftBuyer, "NFT was not transferred to the buyer");
        assertEq(tokenContract.balanceOf(nftSeller), 1e18, "Seller did not receive the tokens");
        assertEq(tokenContract.balanceOf(nftBuyer), 0, "Buyer still has tokens");
    } 


    // The buyer does not uses the whitelist signature to buy the NFT that require the whitelist signature
    function test_Fail_Three_WLS_EP_LS() public {
        // This NFT requires whitelist purchase
        // uint256 tokenId_= nftSellerListNFT(true);
        uint256 tokenId_ = mintNFT();

        // approve nft to market contract
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), tokenId_);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);

        uint NFTdeadline = block.timestamp + 365 days; 
        Dylan_NFTMarket.SellOrder memory order_ = Dylan_NFTMarket.SellOrder({
            seller: nftSeller,
            nft: address(nftContract),
            tokenId: tokenId_,
            payToken: address(tokenContract),
            price: nftPrice,
            deadline: NFTdeadline,
            needWLSign: true
        });

        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();

        // generate ERC20 signature
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, block.timestamp + 1 days);
        Dylan_NFTMarket.ERC20PermitData memory _approveData = Dylan_NFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            token: address(tokenContract),
            deadline: block.timestamp + 1 days
        });

        // generate list signature
        Dylan_NFTMarket.SellOrderWithSignature memory listSignature = signList(order_);
        vm.expectRevert(abi.encodeWithSelector(Dylan_NFTMarket.NeedWLSign_Or_ErrorSigner.selector));
        vm.prank(nftBuyer);
        marketContract.buy(_approveData, listSignature);

    } 

    // The buyer uses the whitelist signature to buy the NFT that does not require the whitelist signature
    function test_Fail2_Three_WLS_EP_LS() public {
        // This NFT requires whitelist purchase
        // uint256 tokenId_= nftSellerListNFT(true);
        uint256 tokenId_ = mintNFT();

        // approve nft to market contract
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), tokenId_);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);

        uint NFTdeadline = block.timestamp + 365 days; 
        Dylan_NFTMarket.SellOrder memory order_ = Dylan_NFTMarket.SellOrder({
            seller: nftSeller,
            nft: address(nftContract),
            tokenId: tokenId_,
            payToken: address(tokenContract),
            price: nftPrice,
            deadline: NFTdeadline,
            needWLSign: false
        });

        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();

        // set FeeTo
        // setNFTMarketFeeTo(address(0));
        // set nftContract whitelist signer
        setNFTContractWLSigner();

        // generate WL signature
        Dylan_NFTMarket.WLData memory wlData = signWL(address(nftContract), nftBuyer);

        // generate ERC20 signature
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, block.timestamp + 1 days);
        Dylan_NFTMarket.ERC20PermitData memory _approveData = Dylan_NFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            token: address(tokenContract),
            deadline: block.timestamp + 1 days
        });

        // generate list signature
        Dylan_NFTMarket.SellOrderWithSignature memory listSignature = signList(order_);

        vm.expectRevert(abi.encodeWithSelector(Dylan_NFTMarket.NoNeedWLSign_Or_ErrorSigner.selector));
        vm.prank(nftBuyer);
        marketContract.buy(_approveData, wlData.signature, listSignature);
    } 

    function test_Success_Three_WLS_EP_LS_fee() public {
        // This NFT requires whitelist purchase
        // uint256 tokenId_= nftSellerListNFT(true);
        uint256 tokenId_ = mintNFT();

        // approve nft to market contract
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), tokenId_);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);

        uint NFTdeadline = block.timestamp + 365 days; 
        Dylan_NFTMarket.SellOrder memory order_ = Dylan_NFTMarket.SellOrder({
            seller: nftSeller,
            nft: address(nftContract),
            tokenId: tokenId_,
            payToken: address(tokenContract),
            price: nftPrice,
            deadline: NFTdeadline,
            needWLSign: true
        });

        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();

        // set FeeTo
        setNFTMarketFeeTo(Fee_Collector);
        // set nftContract whitelist signer
        setNFTContractWLSigner();

        uint fee = nftPrice * marketContract.feeBP() / 10000;

        // generate WL signature
        Dylan_NFTMarket.WLData memory wlData = signWL(address(nftContract), nftBuyer);

        // generate ERC20 signature
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, block.timestamp + 1 days);
        Dylan_NFTMarket.ERC20PermitData memory _approveData = Dylan_NFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            token: address(tokenContract),
            deadline: block.timestamp + 1 days
        });

        // generate list signature
        Dylan_NFTMarket.SellOrderWithSignature memory listSignature = signList(order_);

        vm.prank(nftBuyer);
        marketContract.buy(_approveData, wlData.signature, listSignature);

        assertEq(nftContract.ownerOf(tokenId_), nftBuyer, "NFT was not transferred to the buyer");
        assertEq(tokenContract.balanceOf(nftSeller), 1e18 - fee, "Seller did not receive the tokens");
        assertEq(tokenContract.balanceOf(nftBuyer), 0, "Buyer still has tokens");
        assertEq(tokenContract.balanceOf(Fee_Collector), fee, "Fee_Collector did not receive the tokens");
    } 

    // Although the seller's offline signature is up on NFT, it's down again
    function test_fail3_Three_WLS_EP_LS() public {
        // This NFT requires whitelist purchase
        // uint256 tokenId_= nftSellerListNFT(true);
        uint256 tokenId_ = mintNFT();

        // approve nft to market contract
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), tokenId_);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);

        uint NFTdeadline = block.timestamp + 365 days; 
        Dylan_NFTMarket.SellOrder memory order_ = Dylan_NFTMarket.SellOrder({
            seller: nftSeller,
            nft: address(nftContract),
            tokenId: tokenId_,
            payToken: address(tokenContract),
            price: nftPrice,
            deadline: NFTdeadline,
            needWLSign: true
        });

        // give the nftBuyer some tokens
        GiveBuyerSomeTokens();

        // set FeeTo
        // setNFTMarketFeeTo(address(0));
        // set nftContract whitelist signer
        setNFTContractWLSigner();

        // generate WL signature
        Dylan_NFTMarket.WLData memory wlData = signWL(address(nftContract), nftBuyer);

        // generate ERC20 signature
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, block.timestamp + 1 days);
        Dylan_NFTMarket.ERC20PermitData memory _approveData = Dylan_NFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            token: address(tokenContract),
            deadline: block.timestamp + 1 days
        });

        // generate list signature
        Dylan_NFTMarket.SellOrderWithSignature memory listSignature = signList(order_);

        vm.prank(nftSeller);
        marketContract.ListSignCancel(listSignature);
        console.log("ListSignButCancel", marketContract.ListSignButCancel(listSignature.signature));

        vm.expectRevert(abi.encodeWithSelector(Dylan_NFTMarket.Order_Already_Canceled.selector));
        vm.prank(nftBuyer);
        marketContract.buy(_approveData, wlData.signature, listSignature);
    } 
}