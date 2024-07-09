// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ITokenRecipient.sol";

contract Recipient_NFTMarket is ITokenRecipient {
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

    // 记录买家想要购买哪个NFT
    mapping(address => uint256) public purchaseIntents;
    // 有可能tokenId = 0，所以需要一个额外的变量来记录购买意图
    mapping(address => bool) public hasPurchaseIntent;


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

    // 让买家设置他们打算买的NFT的tokenId
    function setPurchaseIntent(uint256 tokenId) external {
        // 确保NFT已经被上架
        require(listings[tokenId].price > 0, "NFT not listed or price not set");

        purchaseIntents[msg.sender] = tokenId;
        hasPurchaseIntent[msg.sender] = true;  // 明确标记该用户已设置购买意图
    }

    // 处理通过ERC20代币触发的购买
    function tokensReceived(address _from, uint256 _value) external override returns (bool) {
        require(msg.sender == address(tokenContract), "Only tokens can call");

        require(hasPurchaseIntent[_from], "No purchase intent");
        // 获得tokenId对应的NFT价格和卖家

        uint256 tokenId = purchaseIntents[_from];
        Listing memory listing = listings[tokenId];

        require(_value == listing.price, "Incorrect price");
        require(tokenContract.transferFrom(_from, listing.seller, _value), "Payment failed");
        nftContract.safeTransferFrom(listing.seller, _from, tokenId);

        delete listings[tokenId];
        delete purchaseIntents[_from];
        delete hasPurchaseIntent[_from];

        emit Purchased(tokenId, _from, _value);
        return true;
    }
}