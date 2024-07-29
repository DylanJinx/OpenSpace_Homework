// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {EIP712Upgradeable} from "lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol";

import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import {NFTMarket_v1} from "./NFTMarket_v1.sol";

/// @custom:oz-upgrades-from src/NFTMarket_v1.sol:NFTMarket_v1
contract NFTMarket_v2 is NFTMarket_v1, EIP712Upgradeable {
   
    bytes32 public constant LISTING_TYPEHASH = keccak256("ListWithSignature(address seller, uint256 tokenId, uint256 price, uint256 deadline)");
    
    struct ListWithSignature {
        address seller;
        uint256 tokenId;
        uint256 price;
        uint256 deadline;
        bytes signature;
    }

    mapping (bytes32 => bool) public filledOrders;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize_V2(address _nftAddress, address _tokenAddress, address _admin) initializer public {
        nftContract = IERC721(_nftAddress);
        tokenContract = IERC20(_tokenAddress);
        __Ownable_init(_admin);
        __UUPSUpgradeable_init();
    }

    function BuyWithLS(ListWithSignature calldata _order) external {
        _checkListSign(_order);

        tokenContract.transferFrom(msg.sender, _order.seller, _order.price);

        nftContract.safeTransferFrom(_order.seller, msg.sender, _order.tokenId);

        emit Purchased(_order.tokenId, msg.sender, _order.price);
    }

    function _checkListSign(ListWithSignature calldata _order) private {
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    LISTING_TYPEHASH,
                    _order.seller,
                    _order.tokenId,
                    _order.price,
                    _order.deadline
                )
            )
        );

        address signer = ECDSA.recover(digest, _order.signature);

        require(signer == _order.seller, "signer is not seller");
        require(filledOrders[digest] == false, "Listing already filled");
        filledOrders[digest] = true;

        require(block.timestamp <= _order.deadline, "Listing expired");

        address NFTOwner = nftContract.ownerOf(_order.tokenId);
        require(NFTOwner == _order.seller, "Seller is not the owner");

        require(
            nftContract.getApproved(_order.tokenId) == address(this) || nftContract.isApprovedForAll(_order.seller, address(this)),
            "NFTMarket_Dylan: not approved");
    }


    // public domain separator
    function getDomainSeparator() external view returns (bytes32) {
        return _domainSeparatorV4();
    }

}