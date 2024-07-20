// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DylanNFT is ERC721URIStorage, Ownable {
    using ECDSA for bytes32;
    using Strings for uint256;

    uint256 private _currentTokenId = 0;

    // 为每个TokenId维护一个Nonce，防止重放攻击
    mapping(uint256 => uint256) public nonces;

    constructor(string memory name, string memory symbol, address initialOwner) 
        ERC721(name, symbol) 
        Ownable(initialOwner)
    {}

    function mintTo(address recipient, string memory uri) public onlyOwner returns (uint256) {
        uint256 newTokenId = _currentTokenId++;
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, uri);

        return newTokenId;
    }

    // function permit(
    //     address owner,
    //     address spender,
    //     uint256 tokenId,
    //     uint256 price, 
    //     uint256 deadline,
    //     uint8 v,
    //     bytes32 r,
    //     bytes32 s
    // ) public {
    //     // 确认许可未过期
    //     require(block.timestamp <= deadline, "DylanNFT: Permit has expired");
    //     // 当前NFT的所有者
    //     address NFTowner = ownerOf(tokenId);
    //     require(owner == NFTowner, "DylanNFT: Not the owner");

    //     bytes32 structHash = keccak256(
    //         abi.encode(
    //             keccak256("Permit(address owner,address spender,uint256 tokenId,uint256 price,uint256 nonce,uint256 deadline)"),
    //             owner,
    //             spender,
    //             tokenId,
    //             price,
    //             nonces[tokenId],
    //             deadline
    //         )
    //     );

    //     // 使用EIP712规范生成摘要
    //     bytes32 digest = _hashTypedDataV4(structHash);

    //     // 恢复签名者地址
    //     address signer = ECDSA.recover(digest, v, r, s);

    //     // 确认签名者是NFT的所有者
    //     require(signer == owner, "DylanNFT: Invalid signature");
    //     // 确认所有者地址有效
    //     require(owner != address(0), "DylanNFT: Invalid owner");

    //     nonces[tokenId]++;  // 更新nonce防止重放攻击

    //     // _approve(spender, tokenId, owner);
    //     _approve(spender, tokenId, address(0));

    // }
}