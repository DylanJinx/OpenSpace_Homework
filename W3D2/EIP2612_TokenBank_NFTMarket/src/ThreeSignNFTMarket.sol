// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

// sepolia contract address: 
contract ThreeSignNFTMarket is EIP712{
    using ECDSA for bytes32;

    struct Listing {
        uint256 price;
        address seller;
    }    
    // ERC20授权转账的签名数据
    struct ERC20PermitData {
        uint8 v;
        bytes32 r;
        bytes32 s;
        uint256 deadline;
    }
    // 买家上架NFT的签名数据
    struct SellOrderWithSignature {
        address nft; // NFT地址
        uint256 tokenId; // NFT tokenId
        uint256 price; // 价格
        uint256 deadline; // 截止时间
        bytes signature; // 卖家签名
    }
    // 白名单签名数据
    struct WLData {
        uint8 v;
        bytes32 r;
        bytes32 s;
        address user;
    }

    address public immutable WL_SIGNER;
    // NFT合约地址
    IERC721 public immutable nftContract;
    // token合约地址
    ERC20Permit public immutable erc20Contract;
    // 在函数体里面写浪费gas，白名单的structhash中的typehash
    bytes32 public constant WL_TYPEHASH = keccak256("BuyWithWL(address user)");
    bytes32 public constant LISTING_TYPEHASH = keccak256("buyWithWLAndListSign(address nft, uint256 tokenId, uint256 price, uint256 deadline)");

    mapping(bytes32 => bool) public ordersFilled;
    mapping(uint256 => Listing) public listings;
    // true为已经用某个签名购买，false为未购买
    mapping(bytes32 => bool) public filledOrders;

    event Listed(
        uint256 indexed tokenId,
        address seller,
        uint256 price
    );

    event Purchased(
        uint256 indexed tokenId, 
        address indexed seller,
        address indexed buyer, 
        uint256 price
    );

    error PaymentFailed(address buyer, address seller, uint256 price);

    constructor(address _nftAddress, address _erc20Address, address _WLSigner) EIP712("NFTMarket", "1") {
        nftContract = IERC721(_nftAddress);
        erc20Contract = ERC20Permit(_erc20Address);
        WL_SIGNER = _WLSigner;
    }
    
    // 用户签名上架NFT
    function buyWithWLAndListSign(
        WLData calldata signatureForWL,
        ERC20PermitData calldata approveData,
        SellOrderWithSignature calldata sellOrder
    ) public {
        // 检查上架信息是否存在，「检查后为了防止重入，删除上架信息
        // 时间截止
        require(sellOrder.deadline >= block.timestamp, "Signature expired");    
        // 用签名验证上架信息
        bytes32 ListingDigest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    LISTING_TYPEHASH,
                    sellOrder.nft,
                    sellOrder.tokenId,
                    sellOrder.price,
                    sellOrder.deadline
                )
            )
        );
        
        require(filledOrders[ListingDigest]==false, "Order already filled!");
        filledOrders[ListingDigest] = true;

        address NFTOwner = nftContract.ownerOf(sellOrder.tokenId);
        address ListingSigner = ECDSA.recover(ListingDigest, sellOrder.signature); 
        // 确认签名者是NFT的所有者
        require(NFTOwner == ListingSigner, "Invalid signature, not the owner");

        // 检查后为了防止重入，删除上架信息
        delete listings[sellOrder.tokenId];
        
        // 检查白单签名是否来自于项目方的签署
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    WL_TYPEHASH,
                    msg.sender
                )
            )
        );

        address signerForWL = ECDSA.recover(digest, signatureForWL.v, signatureForWL.r, signatureForWL.s);

        require(signerForWL == WL_SIGNER, "Invalid signature, you are not in WL");

        // 执行 ERC20 的 permit 进行 授权
        erc20Contract.permit(
            msg.sender, 
            address(this), 
            sellOrder.price, 
            approveData.deadline, 
            approveData.v, 
            approveData.r, 
            approveData.s
        );

        // 执行 ERC20 的转账
        bool success = erc20Contract.transferFrom(msg.sender, NFTOwner, sellOrder.price);

        if (!success) revert PaymentFailed(msg.sender, NFTOwner, sellOrder.price);

        // 执行 NFT 的转账
        // 需要卖家先授权再上架
        nftContract.transferFrom(NFTOwner, msg.sender, sellOrder.tokenId);

        emit Purchased(sellOrder.tokenId, NFTOwner, msg.sender, sellOrder.price);
    }

    // 公开domain separator
    function getDomainSeparator() external view returns (bytes32) {
        return _domainSeparatorV4();
    }
    
}
