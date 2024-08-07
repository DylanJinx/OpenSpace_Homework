// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/Multicall.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AirdopMerkleNFTMarket is Multicall, Ownable(msg.sender) {
    bytes32 public merkleRoot;
    address public immutable token;

    struct SellOrder {
        address seller;
        uint256 price;
    }

    mapping (address => mapping(uint256 => SellOrder)) public sellOrders;
    mapping(address => bool) public hasPrePaid;

    constructor(bytes32 _merkleRoot, address _token) {
        merkleRoot = _merkleRoot;
        token = _token;
    }

    // need approve before list
    function list(
        address _nft,
        uint256 _tokenId,
        uint256 _price
    ) external {
        require(sellOrders[_nft][_tokenId].price == 0, "AirdopMerkleNFTMarket: already listed");
        require(_price > 0, "AirdopMerkleNFTMarket: price is zero.");
        require(IERC721(_nft).ownerOf(_tokenId) == msg.sender, "AirdopMerkleNFTMarket: not owner");
        require(
            IERC721(_nft).getApproved(_tokenId) == address(this) || IERC721(_nft).isApprovedForAll(msg.sender, address(this)),
            "AirdopMerkleNFTMarket: not approved"
        );

        sellOrders[_nft][_tokenId] = SellOrder(msg.sender, _price);

        emit Listed(_nft, _tokenId, msg.sender, _price);
    }

    function _verifyMerkleProof(
        address account,
        bytes32[] calldata merkleProof
    ) public view returns (bool) {
        bytes32 node = keccak256(abi.encodePacked(account));

        require(
            MerkleProof.verify(merkleProof, merkleRoot, node),
            "AirdopMerkleNFTMarket: Invalid proof."
        );

        return true;
    }

    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }

    function permitPrePay(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        require(owner == msg.sender, "AirdopMerkleNFTMarket: not owner");
        IERC20Permit(token).permit(owner, spender, value, deadline, v, r, s);
        hasPrePaid[owner] = true;
    }

    function claimNFT(
        address _nft,
        uint256 _tokenId,
        bytes32[] calldata merkleProof
    ) public {
        require(_verifyMerkleProof(msg.sender, merkleProof), "AirdopMerkleNFTMarket: Invalid proof.");
        require(hasPrePaid[msg.sender], "AirdopMerkleNFTMarket: not pre-paid");

        SellOrder memory _sellOrder = sellOrders[_nft][_tokenId];
        _buy(_nft, _tokenId, _sellOrder.price / 2);
    }


    function buy(
        address _nft,
        uint256 _tokenId
    ) public {
        SellOrder memory _sellOrder = sellOrders[_nft][_tokenId];
        _buy(_nft, _tokenId, _sellOrder.price);
    }

    function _buy(
        address _nft,
        uint256 _tokenId,
        uint256 _price
    ) internal {
        SellOrder memory _sellOrder = sellOrders[_nft][_tokenId];
        require(_sellOrder.price > 0, "AirdopMerkleNFTMarket: not listed");

        require(IERC20(token).balanceOf(msg.sender) >= _price, "AirdopMerkleNFTMarket: insufficient funds");
        require(IERC20(token).allowance(msg.sender, address(this)) >= _price, "AirdopMerkleNFTMarket: insufficient allowance");

        address _seller = _sellOrder.seller;

        delete sellOrders[_nft][_tokenId];

        IERC721(_nft).transferFrom(_seller, msg.sender, _tokenId);
        IERC20(token).transferFrom(msg.sender, _seller, _price);

        emit Purchased(_tokenId, _seller, msg.sender, msg.value);
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