// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../src/DylanToken.sol";
import {DylanNFT} from "../src/DylanERC721.sol";
import "../src/AirdopMerkleNFTMarket.sol";
import {IERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract AirdopMerkleNFTMarket_Test is Test {
    AirdopMerkleNFTMarket public marketContract;
    DylanNFT public nftContract;
    DylanToken public tokenContract;
    uint256 public nftPrice = 10e18;

    address public buyer1;
    uint256 public buyer1PrivateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    address public buyer2;
    uint256 public buyer2PrivateKey = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;
    address public buyer3;
    uint256 public buyer3PrivateKey = 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a;
    address public buyer4;
    uint256 public buyer4PrivateKey = 0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6;

    address public nftSeller;
    uint256 public nftSellerPrivateKey;

    address public makerOwner;
    uint256 public makerOwnerPrivateKey;

    bytes32 public merkleRoot = 0xb4316902345b116c2107a907acd1ddb3b8bdb6ac431c386e16ffc220ab1943b0;

    bytes32[] public proof = [bytes32(0x00314e565e0574cb412563df634608d76f5c59d9f817e85966100ec1d48005c0), bytes32(0x4ed9d015110a35000ce5c94f94ccdc63653ddd26af11314d386ae5e65ef28c79)
    ];


    /**
    * root:0xb4316902345b116c2107a907acd1ddb3b8bdb6ac431c386e16ffc220ab1943b0
    * proof:0x00314e565e0574cb412563df634608d76f5c59d9f817e85966100ec1d48005c0,0x4ed9d015110a35000ce5c94f94ccdc63653ddd26af11314d386ae5e65ef28c79
    */

    function setUp() public {
        tokenContract = new DylanToken();
        buyer1 = vm.addr(buyer1PrivateKey);
        buyer2 = vm.addr(buyer2PrivateKey);
        buyer3 = vm.addr(buyer3PrivateKey);
        buyer4 = vm.addr(buyer4PrivateKey);
        vm.prank(buyer1);
        tokenContract.mint(1000e18);
        vm.prank(buyer2);
        tokenContract.mint(1000e18);
        vm.prank(buyer3);
        tokenContract.mint(1000e18);
        vm.prank(buyer4);
        tokenContract.mint(1000e18);

        (nftSeller, nftSellerPrivateKey) = makeAddrAndKey("nftSeller");
        vm.prank(nftSeller);
        nftContract = new DylanNFT();

        (makerOwner, makerOwnerPrivateKey) = makeAddrAndKey("makerOwner");
        vm.prank(makerOwner);
        marketContract = new AirdopMerkleNFTMarket(merkleRoot, address(tokenContract));
    }

    // -------------------------------setUp Tools--------------------------------
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
        emit AirdopMerkleNFTMarket.Listed(address(nftContract), 0, nftSeller, 10e18);
        vm.prank(nftSeller);
        marketContract.list(address(nftContract), tokenId_, nftPrice);

        console.log("---------------------list---------------------------");
        console.log("NFT successfully listed: ");
        console.log("NFT Contract Address:", address(nftContract));
        console.log("TokenId:", tokenId_);
        console.log("Token Contract Address:", address(tokenContract));
        console.log("Listed Price:", nftPrice);

        return tokenId_;
    }

    // approve ERC20 signature
    function SignERC20(
        address _user, 
        uint256 _userPrivateKey,
        uint256 _depositAmount, 
        uint256 _nonce, 
        uint256 _deadline
    ) private view returns(uint8 _v, bytes32 _r, bytes32 _s) {
        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                _user,
                address(marketContract),
                _depositAmount,
                _nonce,
                _deadline
            )
        );
        
        bytes32 digest = tokenContract.getDigest(structHash);

        // Generate Signature
        (_v, _r, _s) = vm.sign(_userPrivateKey, digest); 

        return (_v, _r, _s);
    }

    // ---------------------------- test cases -----------------------------------
    function test_permitPrePay() public {
        uint256 _deadline = block.timestamp + 1000;
        (uint8 _v, bytes32 _r, bytes32 _s) = SignERC20(buyer4, buyer4PrivateKey, 10e18, 0, _deadline);
        vm.prank(buyer4);
        marketContract.permitPrePay(buyer4, address(marketContract), 10e18, _deadline, _v, _r, _s);
        assertEq(marketContract.hasPrePaid(buyer4), true, "buyer4 has not pre-paid");
    }

    function test_buy() public {
        uint256 tokenId_ = nftSellerListNFT();

        // buy
        vm.prank(buyer1);
        tokenContract.approve(address(marketContract), nftPrice);
        vm.expectEmit(true, true, true, true);
        emit IERC721.Transfer(nftSeller, buyer1, tokenId_);
        vm.prank(buyer1);
        marketContract.buy(address(nftContract), tokenId_);

        require(nftContract.ownerOf(tokenId_) == buyer1, "NFT not transferred to buyer1");
        require(tokenContract.balanceOf(nftSeller) == nftPrice, "nftSeller balance not updated");
        require(tokenContract.balanceOf(buyer1) == 1000e18 - 10e18, "buyer1 balance not updated");
    }

    // Gas used without multicall:  154324
    function test_notUseMulticall() public {
        uint256 tokenId_ = nftSellerListNFT();

        uint256 _deadline = block.timestamp + 1000;
        (uint8 _v, bytes32 _r, bytes32 _s) = SignERC20(buyer4, buyer4PrivateKey, 10e18, 0, _deadline);
        
        uint256 startGas = gasleft();
        vm.prank(buyer4);
        marketContract.permitPrePay(buyer4, address(marketContract), 10e18, _deadline, _v, _r, _s);

        vm.prank(buyer4);
        marketContract.claimNFT(address(nftContract), tokenId_, proof);
        uint256 endGas = gasleft();

        uint256 gasUsed = startGas - endGas;
        console.log("Gas used without multicall: ", gasUsed);

        assertEq(nftContract.ownerOf(tokenId_), buyer4, "NFT not transferred to buyer4");
        assertEq(tokenContract.balanceOf(buyer4), 1000e18 - 5e18, "buyer4 balance not updated");
        require(tokenContract.balanceOf(nftSeller) == nftPrice / 2, "nftSeller balance not updated");
    }

    //Gas used with multicall:  154496
    function test_Multicall() public {
        uint256 tokenId_ = nftSellerListNFT();

        uint256 _deadline = block.timestamp + 1000;
        (uint8 _v, bytes32 _r, bytes32 _s) = SignERC20(buyer4, buyer4PrivateKey, 10e18, 0, _deadline);

        bytes[] memory _data;
        bytes4 selector1 = marketContract.permitPrePay.selector;
        bytes4 selector2 = marketContract.claimNFT.selector;
        bytes memory dataPermitPrePay = abi.encodeWithSelector(
            selector1,
            buyer4,
            address(marketContract),
            10e18,
            _deadline,
            _v,
            _r,
            _s
        );
        bytes memory dataClaimNFT = abi.encodeWithSelector(
            selector2,
            address(nftContract),
            tokenId_,
            proof
        );
        _data = new bytes[](2);
        _data[0] = dataPermitPrePay;
        _data[1] = dataClaimNFT;

        uint256 startGas = gasleft();
        vm.prank(buyer4);
        marketContract.multicall(_data);
        uint256 endGas = gasleft();

        uint256 gasUsed = startGas - endGas;
        console.log("Gas used with multicall: ", gasUsed);

        assertEq(nftContract.ownerOf(tokenId_), buyer4, "NFT not transferred to buyer4");
        assertEq(tokenContract.balanceOf(buyer4), 1000e18 - 5e18, "buyer4 balance not updated");
        require(tokenContract.balanceOf(nftSeller) == nftPrice / 2, "nftSeller balance not updated");
    }


}