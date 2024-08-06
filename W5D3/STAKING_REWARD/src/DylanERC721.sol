// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DylanNFT is ERC721URIStorage, Ownable {
    uint256 private _currentTokenId = 0;

    // 为每个TokenId维护一个Nonce，防止重放攻击
    mapping(uint256 => uint256) public nonces;

    constructor() 
        ERC721("DylanNFT", "DNFT") 
        Ownable(msg.sender)
    {}

    function mintTo(address recipient, string memory uri) public onlyOwner returns (uint256) {
        uint256 newTokenId = _currentTokenId++;
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, uri);

        return newTokenId;
    }
}