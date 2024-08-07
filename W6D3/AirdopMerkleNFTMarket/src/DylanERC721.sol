// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DylanNFT is ERC721URIStorage, Ownable {
    uint256 private _currentTokenId = 0;

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