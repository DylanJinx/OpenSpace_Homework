// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {ThreeSignNFTMarket} from "../src/ThreeSignNFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

// For signatures with list signatures, whitelist signatures, and ERC20 authorized signatures, the market contract address is `../src/ThreeSignThreeSignNFTMarket.sol`
contract ThreeSign_BuyNFTTest is Test {
    ThreeSignNFTMarket public marketContract;
    MyToken public tokenContract;
    DylanNFT public nftContract;

    address public nftSeller;
    uint256 public nftSellerPrivateKey;
    address public nftBuyer;
    uint256 public nftBuyerPrivateKey;
    uint256 public tokenId;
    uint256 public nftPrice = 1e18;

    // --------------------------------------------------------------setup--------------------------------------------------------------
    function setUp() public {
        tokenContract = new MyToken();
        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        (nftBuyer, nftBuyerPrivateKey) = makeAddrAndKey("nftBuyer");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        marketContract = new ThreeSignNFTMarket(address(nftContract), address(tokenContract), nftSeller);
    }

    // -----------------------------------------------------------setupTools-------------------------------------------------------
    // mint a new NFT
    function mintNFT() private {  
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(address(0), nftSeller, 0);
        vm.prank(nftSeller);
        tokenId = nftContract.mintTo(nftSeller, "https://ipfs.io/ipfs/CID1");
        // Check if the NFT was minted with the correct URI
        assertEq(nftContract.tokenURI(tokenId), "https://ipfs.io/ipfs/CID1", "URI does not match");
        console.log("Minted NFT with tokenId:", tokenId);
    }

    // give the nftBuyer some tokens
    function GiveBuyerSomeTokens() private {
        vm.expectEmit(true, true, false, true);
        emit IERC20.Transfer(address(this), nftBuyer, 1e18);
        tokenContract.transfer(nftBuyer, nftPrice);
        
        assertEq(tokenContract.balanceOf(nftBuyer), nftPrice, "Buyer does not have enough tokens");
    }

    // -----------------------------------------------------------signatures-----------------------------------------------------------

    // Whitelist signature
    function signWL(address user) private view returns(ThreeSignNFTMarket.WLData memory) {
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
    
        // Generate Signature
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest); 
        
        ThreeSignNFTMarket.WLData memory wlData = ThreeSignNFTMarket.WLData({
            v: v,
            r: r,
            s: s,
            user: user
        });

        return wlData;
    }

    // approve ERC20 signature
    function SignERC20(uint256 _depositAmount, uint256 _nonce, uint256 _ERC20Deadline) private view returns(uint8 _v, bytes32 _r, bytes32 _s) {
         bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                nftBuyer,
                address(marketContract),
                _depositAmount,
                _nonce,
                _ERC20Deadline
            )
        );
        
        bytes32 digest = tokenContract.getDigest(structHash);

        // Generate Signature
        (_v, _r, _s) = vm.sign(nftBuyerPrivateKey, digest); 

        return (_v, _r, _s);
    }

    // list signature
    function signList(
        address _nft, 
        uint256 _tokenId,
        uint256 _price,
        uint256 _listDeadline
    ) private view returns(ThreeSignNFTMarket.SellOrderWithSignature memory) {
        bytes32 structHash = keccak256(
            abi.encode(
                marketContract.LISTING_TYPEHASH(),
                _nft,
                _tokenId,
                _price,
                _listDeadline
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
        
        ThreeSignNFTMarket.SellOrderWithSignature memory sellOrder = ThreeSignNFTMarket.SellOrderWithSignature({
            nft: _nft,
            tokenId: _tokenId,
            price: _price,
            deadline: _listDeadline,
            signature: signatureForList
        });

        return sellOrder;
    }


    // --------------------------------------------------------------tests--------------------------------------------------------------
    function test_SuccessfulThreeSignNFTPurchase() public {
        mintNFT();

        // approve nft to market contract
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), 0);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId);

        GiveBuyerSomeTokens();

        // generate list signature
        ThreeSignNFTMarket.SellOrderWithSignature memory listSignature = signList(address(nftContract), tokenId, nftPrice, block.timestamp + 1 days);

        // generate whitelist signature
        ThreeSignNFTMarket.WLData memory wlSignature = signWL(nftBuyer);

        // generate ERC20 permit signature
        uint256 ERC20Deadline = block.timestamp + 1 hours;
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, ERC20Deadline);

        ThreeSignNFTMarket.ERC20PermitData memory permitData = ThreeSignNFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            deadline: ERC20Deadline
        });

        vm.prank(nftBuyer);
        marketContract.buyWithWLAndListSign(wlSignature, permitData, listSignature);

        // Assertions to ensure everything worked
        assertEq(nftContract.ownerOf(tokenId), nftBuyer);
        assertEq(tokenContract.balanceOf(nftSeller), nftPrice);
        assertEq(tokenContract.balanceOf(nftBuyer), 0);
        
    }

}