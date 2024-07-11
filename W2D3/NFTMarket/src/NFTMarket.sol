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

    error OnlyTokenContractCanCall(address caller);
    error NotListed(uint256 tokenId);
    error IncorrectValue(uint256 markerPrice, uint256 Buyer_payment);
    error CannotBuyNFTFromSelf(address seller, address buyer, uint256 tokenId);
    error TokenTransferFailed(uint256 tokenId, address seller, uint256 price);
    
    error OnlyNFTContractCanCall(address caller);

    constructor(address _nftAddress, address _tokenAddress) {
        nftContract = IERC721(_nftAddress);
        tokenContract = IERC20(_tokenAddress);
    }

    // 处理通过ERC20代币触发的购买
    function onTransferReceived(
        address ,
        address _from, 
        uint256 _value,
        bytes calldata _data
    ) external override returns (bytes4) {
        if (msg.sender != address(tokenContract)) {
            revert OnlyTokenContractCanCall(msg.sender);
        }

        uint256 tokenId = abi.decode(_data, (uint256));
        _buyNFT(_from, tokenId, _value);
        
        return this.onTransferReceived.selector;
    }

    function _buyNFT(address buyer, uint256 tokenId, uint256 value) internal {
        Listing memory listing = listings[tokenId];

        if (listing.price == 0) {
            revert NotListed(tokenId);
        }
        if (listing.price != value) {
            revert IncorrectValue(listing.price, value);
        } 

        if (listing.seller == buyer) {
            revert CannotBuyNFTFromSelf(listing.seller, buyer, tokenId);
        }

        delete listings[tokenId];

        // 转移ERC20代币
        if (!tokenContract.transfer(listing.seller, listing.price)) {
            revert TokenTransferFailed(tokenId, listing.seller, listing.price);
        }

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
        if (msg.sender != address(nftContract)) {
            revert OnlyNFTContractCanCall(msg.sender);
        }
        
        // 解码 data 以获取价格
        uint256 price = abi.decode(_data, (uint256));
        
        // 创建 listing
        listings[_tokenId] = Listing(price, _from);
        
        emit Listed(_tokenId, _from, price);
        
        return this.onERC721Received.selector;
    }

}