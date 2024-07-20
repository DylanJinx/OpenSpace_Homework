// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

// For signatures with only whitelisted signatures and ERC20 authorized signatures, the market contract address is `../src/NFTMarket.sol` 
contract NoListSign_BuyNFTTest is Test {
    NFTMarket public marketContract;
    MyToken public tokenContract;
    DylanNFT public nftContract;

    address public nftSeller;
    uint256 public nftSellerPrivateKey;
    address public nftBuyer;
    uint256 public nftBuyerPrivateKey;
    // uint256 public tokenId;
    uint256 public nftPrice = 1e18;

    // --------------------------------------------------------------setup--------------------------------------------------------------
    function setUp() public {
        tokenContract = new MyToken();
        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        (nftBuyer, nftBuyerPrivateKey) = makeAddrAndKey("nftBuyer");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        marketContract = new NFTMarket(address(nftContract), address(tokenContract), nftSeller);
    }

    // -----------------------------------------------------------setupTools-------------------------------------------------------
    // mint a new NFT
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
    function nftSellerListNFT() private returns (uint256) {   
        uint256 tokenId_ = mintNFT();  
        // approve
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), 0);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId_);
        // list
        vm.expectEmit(true, true, true, true);
        emit NFTMarket.Listed(0, nftSeller, 1e18);
        vm.prank(nftSeller);
        marketContract.list(tokenId_, nftPrice);

        // Check if NFT is correctly listed in the market
        (uint256 listedPrice, address listedSeller) = marketContract.listings(tokenId_);
        assertEq(listedPrice, nftPrice, "Price did not match the listed price.");
        assertEq(listedSeller, nftSeller, "Seller is not listed correctly.");

        console.log("NFT successfully listed with tokenId:", tokenId_);
        console.log("Listed Price:", listedPrice);
        console.log("Seller Address:", listedSeller);

        return tokenId_;
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
    
        // Generate Signature
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(nftSellerPrivateKey, digest); 
        
        NFTMarket.WLData memory wlData = NFTMarket.WLData({
            v: v,
            r: r,
            s: s,
            user: user
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

    // --------------------------------------------------------------tests--------------------------------------------------------------
    function test_SuccessfulNFTPurchase() public {
        // mintNFT();
        uint256 tokenId_ = nftSellerListNFT();
        GiveBuyerSomeTokens();

        // generate whitelist signature
        NFTMarket.WLData memory wlSignature = signWL(nftBuyer);

        // generate ERC20 permit signature
        uint256 deadline = block.timestamp + 1 hours;
        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftPrice, 0, deadline);

        NFTMarket.ERC20PermitData memory permitData = NFTMarket.ERC20PermitData({
            v: v,
            r: r,
            s: s,
            deadline: deadline
        });

        vm.prank(nftBuyer);
        marketContract.buyWithWL(tokenId_, wlSignature, permitData);

        // Assertions to ensure everything worked
        assertEq(nftContract.ownerOf(tokenId_), nftBuyer);
        assertEq(tokenContract.balanceOf(nftSeller), nftPrice);
        assertEq(tokenContract.balanceOf(nftBuyer), 0);
        
    }

}