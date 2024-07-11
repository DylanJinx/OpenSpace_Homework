// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ITokenRecipient.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

// sepolia contract address: 
contract NFTMarket is ITokenRecipient, IERC721Receiver {
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
        address indexed seller,
        uint256 price
    );

    event Purchased(
        uint256 indexed tokenId, 
        address indexed seller,
        address indexed buyer, 
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

    // 处理通过ERC20代币触发的购买
    function onTransferReceived(
        address ,
        address _from, 
        uint256 _value,
        bytes calldata _data
    ) external override returns (bytes4) {
        require(msg.sender == address(tokenContract), "Only tokens can call");

        uint256 tokenId = abi.decode(_data, (uint256));
        _buyNFT(_from, tokenId, _value);
        
        return ITokenRecipient.onTransferReceived.selector;
    }

    function _buyNFT(address buyer, uint256 tokenId, uint256 value) internal {
        Listing memory listing = listings[tokenId];

        require(listing.price > 0, "Not listed");
        require(listing.price == value, "Incorrect value");

        delete listings[tokenId];

        // 转移ERC20代币
        require(
            tokenContract.transfer(listing.seller, listing.price), 
            "_buyNFT: Token transfer failed"
        );

        // 转移NFT
        nftContract.safeTransferFrom(address(this), buyer, tokenId); // success

        emit Purchased(tokenId, listing.seller, buyer, listing.price);
    }

    function onERC721Received(
        address ,
        address _from,
        uint256 _tokenId,
        bytes calldata _data
    ) external override returns (bytes4) {
        require(msg.sender == address(nftContract), "Invalid NFT contract");
        
        // 解码 data 以获取价格
        uint256 price = abi.decode(_data, (uint256));
        
        // 创建 listing
        listings[_tokenId] = Listing(price, _from);
        
        emit Listed(_tokenId, _from, price);
        
        return this.onERC721Received.selector;
    }

}