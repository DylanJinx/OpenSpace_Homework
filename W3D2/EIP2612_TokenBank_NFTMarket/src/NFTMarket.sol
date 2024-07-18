// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

// sepolia contract address: 
contract NFTMarket is EIP712{
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
    // 白名单签名数据
    struct WLData {
        uint8 v;
        bytes32 r;
        bytes32 s;
        address user;
    }

    // ➜  EIP2612_TokenBank_NFTMarket git:(main) cast wallet new            
    // Successfully created new keypair.
    // Address:     0xd14167FEc1C78E31bf740BE26850C37e44d2E90C
    // Private key: 0x6026eae8a5893a9452b2b0ddf729d128dbc76320dd2820c949d99618f6ae3fde
    address public immutable WL_SIGNER;
    // NFT合约地址
    IERC721 public immutable nftContract;
    // token合约地址
    ERC20Permit public immutable erc20Contract;
    // 在函数体里面写浪费gas
    bytes32 public constant WL_TYPEHASH = keccak256("BuyWithWL(address user)");

    mapping(bytes32 => bool) public ordersFilled;
    mapping(uint256 => Listing) public listings;

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

    // 上架
    function list(uint256 tokenId, uint256 price) external {
        // 确定调用者是NFT的拥有者
        require(nftContract.ownerOf(tokenId) == msg.sender, "Not the owner");

        // 卖家需要先将NFT授权给市场
        require(nftContract.isApprovedForAll(msg.sender, address(this)) || nftContract.getApproved(tokenId)==address(this) , "Market not approved!");

        listings[tokenId] = Listing(price, msg.sender);
        emit Listed(tokenId, msg.sender, price);
    }

    // 需要用户自己上架nft
    function buyWithWL(
        uint256 tokenId,
        WLData calldata signatureForWL,
        ERC20PermitData calldata approveData
    ) public {
        // 检查上架信息是否存在，「检查后为了防止重入，删除上架信息」
        Listing memory currentNFTListing = listings[tokenId];
        // 必须上架
        require(currentNFTListing.price > 0, "Not listed");
        // 不能自己买自己的
        require(currentNFTListing.seller != msg.sender, "Seller cannot buy");
        // 检查后为了防止重入，删除上架信息
        delete listings[tokenId];
        
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
            currentNFTListing.price, 
            approveData.deadline, 
            approveData.v, 
            approveData.r, 
            approveData.s
        );

        // 执行 ERC20 的转账
        bool success = erc20Contract.transferFrom(msg.sender, currentNFTListing.seller, currentNFTListing.price);

        if (!success) revert PaymentFailed(msg.sender, currentNFTListing.seller, currentNFTListing.price);

        // 执行 NFT 的转账
        nftContract.transferFrom(currentNFTListing.seller, msg.sender, tokenId);

        emit Purchased(tokenId, currentNFTListing.seller, msg.sender, currentNFTListing.price);
    }

    // 公开domain separator
    function getDomainSeparator() external view returns (bytes32) {
        return _domainSeparatorV4();
    }

    // -------------------------------------------以下代码用于测试-------------------------------------------
    // 公开wl的digest
    function getWLDigest(address user) external view returns (bytes32) {
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    WL_TYPEHASH,
                    user
                )
            )
        );
        return digest;
    }

    function verifyWL(WLData calldata signatureForWL) external view {
        // 检查白单签名是否来自于项目方的签署
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    WL_TYPEHASH,
                    signatureForWL.user
                )
            )
        );

        address signerForWL = ECDSA.recover(digest, signatureForWL.v, signatureForWL.r, signatureForWL.s);

        require(signerForWL == WL_SIGNER, "Invalid signature, you are not in WL");
    }

    function getStructHash(address user) public pure returns (bytes32) {
        bytes32 structHash = keccak256(
            abi.encode(
                WL_TYPEHASH,
                user
            )
        );
        return structHash;
    }

    function getWL_TYPEHASH() public pure returns (bytes32) {
        return WL_TYPEHASH;
    }

}
