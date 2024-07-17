// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

// contract NFTMarketMock is NFTMarket {

//     constructor(address _nftContract, address _erc20Contract, address _wlSigner) NFTMarket(_nftContract, _erc20Contract, _wlSigner) {}

//     function hashbuyWithWL(address user) public view returns(bytes32) {
//         return _hashTypedDataV4(
//             keccak256(abi.encode(
//                 WL_TYPEHASH,
//                 user
//             ))
//         );
//     }

// }

contract NoListSign_BuyNFTTest is Test {
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

    // list the NFT in the market
    function nftSellerListNFT() private {   
        // mintNFT();  
        // approve
        vm.expectEmit(true, true, true, true);
        emit IERC721.Approval(nftSeller, address(marketContract), 0);
        vm.prank(nftSeller);
        nftContract.approve(address(marketContract), tokenId);
        // list
        vm.expectEmit(true, true, true, true);
        emit NFTMarket.Listed(tokenId, nftSeller, 1e18);
        vm.prank(nftSeller);
        marketContract.list(tokenId, nftPrice);

        // Check if NFT is correctly listed in the market
        (uint256 listedPrice, address listedSeller) = marketContract.listings(tokenId);
        assertEq(listedPrice, nftPrice, "Price did not match the listed price.");
        assertEq(listedSeller, nftSeller, "Seller is not listed correctly.");

        console.log("NFT successfully listed with tokenId:", tokenId);
        console.log("Listed Price:", listedPrice);
        console.log("Seller Address:", listedSeller);
    }

    // give the nftBuyer some tokens
    function GiveBuyerSomeTokens() private {
        vm.expectEmit(true, true, false, true);
        emit IERC20.Transfer(address(this), nftBuyer, 1e18);
        tokenContract.transfer(nftBuyer, nftPrice);
        
        assertEq(tokenContract.balanceOf(nftBuyer), nftPrice, "Buyer does not have enough tokens");
    }

    // Whitelist signatures
    function signWL(address user) private view returns(NFTMarket.WLData memory) {
        // bytes32 structHash = keccak256(
        //     abi.encode(
        //         marketContract.WL_TYPEHASH,
        //         user
        //     )
        // );
        
        // bytes32 digest = keccak256(
        //     abi.encodePacked(
        //         "\x19\x01",
        //         marketContract.getDomainSeparator(),
        //         structHash
        //     )
        // );
        
        bytes32 digest = marketContract.getWLDigest(user);

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

    // 验证白名单
    function test_WhitelistVerification() public view {

        NFTMarket.WLData memory wlSignature = signWL(nftBuyer);

        // Check if the signature is correct
        bytes32 digest = marketContract.getWLDigest(nftBuyer);

        address signerForWL = ECDSA.recover(digest, wlSignature.v, wlSignature.r, wlSignature.s);
        assertEq(signerForWL, nftSeller, "Invalid signature, you are not in WL");
    }

    // approve ERC20 signatures    
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

    function test_SuccessfulNFTPurchase() public {
        mintNFT();
        nftSellerListNFT();
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
        marketContract.buyWithWL(tokenId, wlSignature, permitData);

        // Assertions to ensure everything worked
        assertEq(nftContract.ownerOf(tokenId), nftBuyer);
        assertEq(tokenContract.balanceOf(nftSeller), nftPrice);
        assertEq(tokenContract.balanceOf(nftBuyer), 0);
        
    }

}