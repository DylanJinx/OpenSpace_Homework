// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// sepolia contract address: 0x440cd1f8a459f1c486fca9a3d5584f686696446f
contract NFTMarket {
    struct Listing {
        uint256 price; // NFT所需token（单位：wei）
        address seller; // NFT的卖家地址
    }

    // NFT合约地址
    IERC721 public immutable nftContract;

    // token合约地址
    IERC20 public immutable tokenContract;

    // NFT列表信息->价格和卖家
    mapping(uint256 => Listing) public listings;

    event Listed(
        uint256 indexed tokenId,
        address seller,
        uint256 price
    );

    event Purchased(
        uint256 indexed tokenId, 
        address buyer, 
        uint256 price
    );

    constructor(address _nftAddress, address _tokenAddress) {
        nftContract = IERC721(_nftAddress);
        tokenContract = IERC20(_tokenAddress);
    }

    // 上架
    function list(uint256 tokenId, uint256 price) external {
        // 确定调用者是NFT的拥有者
        require(nftContract.ownerOf(tokenId) == msg.sender, "Not the owner");

        // 卖家需要先将NFT授权给市场
        require(nftContract.isApprovedForAll(msg.sender, address(this)), "Market not approved!");

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
}