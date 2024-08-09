// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarket is Ownable(msg.sender) {
    uint256 public constant feeBP = 30; // 30 Basis Points which equals 0.3%
    address public stakePool;

    struct SellOrder {
        address seller;
        uint256 price;
    }

    mapping (address => mapping(uint256 => SellOrder)) public sellOrders;

    // need approve before list
    function list(
        address _nft,
        uint256 _tokenId,
        uint256 _price
    ) external {
        require(sellOrders[_nft][_tokenId].price == 0, "NFTMarket: already listed");
        require(_price > 0, "NFTMarket: price is zero.");
        require(IERC721(_nft).ownerOf(_tokenId) == msg.sender, "NFTMarket: not owner");
        require(
            IERC721(_nft).getApproved(_tokenId) == address(this) || IERC721(_nft).isApprovedForAll(msg.sender, address(this)),
            "NFTMarket: not approved"
        );

        sellOrders[_nft][_tokenId] = SellOrder(msg.sender, _price);

        emit Listed(_nft, _tokenId, msg.sender, _price);
    }

    function buy(
        address _nft,
        uint256 _tokenId
    ) external payable {
        SellOrder memory _sellOrder = sellOrders[_nft][_tokenId];

        require(_sellOrder.price > 0, "NFTMarket: not listed");
        require(msg.value == _sellOrder.price, "NFTMarket: insufficient funds");

        address _seller = _sellOrder.seller;
        uint256 _fee = msg.value * feeBP / 10000;
        uint256 _payment = msg.value - _fee;

        delete sellOrders[_nft][_tokenId];

        IERC721(_nft).transferFrom(_seller, msg.sender, _tokenId);
        payable(_seller).transfer(_payment);
        payable(stakePool).transfer(_fee);

        emit Purchased(_tokenId, _seller, msg.sender, msg.value);
    }

    function setStakePool(address _stakePool) public {
        stakePool = _stakePool;
    }

    event Purchased(
        uint256 indexed tokenId, 
        address indexed seller,
        address indexed buyer, 
        uint256 price
    );

    event Listed(
        address indexed nft, 
        uint256 indexed tokenId, 
        address seller, 
        uint256 price
    );
}