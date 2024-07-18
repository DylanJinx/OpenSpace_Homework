// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {MyToken} from "../src/MyToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {SetupTools} from "./SetupTools.sol";

contract SignERC20Verify is Test {
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

    // --------------------------------------------------------------setup--------------------------------------------------------------
    function setUp() public {
        tokenContract = new MyToken();
        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        (nftBuyer, nftBuyerPrivateKey) = makeAddrAndKey("nftBuyer");
        nftContract = new DylanNFT("DylanNFT", "DNFT", nftSeller);
        marketContract = new NFTMarket(address(nftContract), address(tokenContract), nftSeller);
        //marketContractMock = new NFTMarketMock(address(nftContract), address(tokenContract), nftSeller);
    }

    // --------------------------------------------------------------setupTools--------------------------------------------------------------
        // give the nftBuyer some tokens
    function GiveBuyerSomeTokens() private {
        vm.expectEmit(true, true, false, true);
        emit IERC20.Transfer(address(this), nftBuyer, 1e18);
        tokenContract.transfer(nftBuyer, nftPrice);
        
        assertEq(tokenContract.balanceOf(nftBuyer), nftPrice, "Buyer does not have enough tokens");
    }

    // --------------------------------------------------------------sign ERC20--------------------------------------------------------------
    // approve ERC20 signatures    
    function SignERC20(address spender,uint256 _depositAmount, uint256 _nonce, uint256 _deadline) private view returns(uint8 _v, bytes32 _r, bytes32 _s) {
         bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                nftBuyer,
                spender,
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

        // Generate Signature
        (_v, _r, _s) = vm.sign(nftBuyerPrivateKey, digest); 

        return (_v, _r, _s);
    }


    // --------------------------------------------------------------verification--------------------------------------------------------------

    address public nftSpender;
    uint256 public nftSpenderPrivateKey;
    // 验证ERC20签名
    function test_ERC20SignVerification() public {
        (nftSpender, nftSpenderPrivateKey) = makeAddrAndKey("nftSpender");
        uint256 depositAmount = 500;
        uint256 deadline = block.timestamp + 1000; // 1000 seconds from now
        uint256 nonce = tokenContract.nonces(nftBuyer);
        uint nonce_ = 0;
        require(nonce == nonce_, "Nonce should be 0");

        (uint8 v, bytes32 r, bytes32 s) = SignERC20(nftSpender, depositAmount, nonce_, deadline);

        GiveBuyerSomeTokens();
        vm.prank(nftSpender);
        tokenContract.permit(nftBuyer, nftSpender, depositAmount, deadline, v, r, s);
        vm.prank(nftSpender);
        tokenContract.transferFrom(nftBuyer, nftSpender, depositAmount);

        assertEq(tokenContract.balanceOf(nftSpender), depositAmount, "failed to transfer tokens");
    }
    

}