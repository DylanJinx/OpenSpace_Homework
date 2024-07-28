// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./StorageSlot.sol";

contract NFTMarket_v1 {
    // bytes32: 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);

    // bytes32: 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
    bytes32 private constant ADMIN_SLOT = bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);

    uint256 public Initialization_time = 0;

    struct Listing {
        uint256 price; // NFT所需token（单位：wei）
        address seller; // NFT的卖家地址
    }

    // NFT合约地址
    IERC721 public nftContract;

    // token合约地址
    IERC20 public tokenContract;

    // NFT列表信息->价格和卖家
    mapping(uint256 => Listing) public listings;

    modifier initializer() {
        require(Initialization_time == 0, "Already initialized");
        Initialization_time += 1;
        _;
    }

    function initialize(address _nftAddress, address _tokenAddress, address _admin) initializer external {
        nftContract = IERC721(_nftAddress);
        tokenContract = IERC20(_tokenAddress);
        _setAdmin(_admin);
    }

    function _setImplementation(address _implementation) internal {
        require(_implementation.code.length > 0, "implementation is not contract");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }

    function _setAdmin(address _admin) internal {
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = _admin;
    }

    function _getImplementation() public view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _getAdmin() public view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

    function _upgradeImplementation(address newImplementation) external {
        require(msg.sender == _getAdmin(), "you are not admin");
        _setImplementation(newImplementation);
    }

    // 上架
    function list(uint256 tokenId, uint256 price) external {
        // 确定调用者是NFT的拥有者
        require(nftContract.ownerOf(tokenId) == msg.sender, "Not the owner");

        // 卖家需要先将NFT授权给市场
        require(
            nftContract.getApproved(tokenId) == address(this) || nftContract.isApprovedForAll(msg.sender, address(this)),
            "NFTMarket_Dylan: not approved");

        listings[tokenId] = Listing(price, msg.sender);
        emit Listed(tokenId, msg.sender, price);
    }

    // 购买
    function buyNFT(uint256 tokenId) external {
        // 获得tokenId对应的NFT价格和卖家
        Listing memory listing = listings[tokenId];

        // NFT价格等于0代表没有上架
        require(listing.price > 0, "Not listed");

        // 需要买家先授权足够的token给市场
        // 调用token的transferFrom方法，将买家（msg.sender）账户中的listing.price转账给卖家（listing.seller）
        require(tokenContract.transferFrom(msg.sender, listing.seller, listing.price), "Payment failed");
        
        // 将NFT 从卖家转移到买家
        nftContract.safeTransferFrom(listing.seller, msg.sender, tokenId);

        // 移除上架记录
        delete listings[tokenId];

        emit Purchased(tokenId, msg.sender, listing.price);

    }

    event Listed(
        uint256 indexed tokenId,
        address indexed seller,
        uint256 price
    );

    event Purchased(
        uint256 indexed tokenId, 
        address indexed buyer, 
        uint256 price
    );
}