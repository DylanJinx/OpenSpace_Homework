// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// sepolia contract address :0x8bc47552bf59b96f631769d100c73db3877700f2
contract DylanNFT is ERC721URIStorage, Ownable {
    uint256 private _currentTokenId = 0;

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
}