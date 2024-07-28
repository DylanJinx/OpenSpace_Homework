// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// sepolia contract address :0xc204Ad7c0487779aeeEF17eEA02322768b4cf918
contract DylanNFT is ERC721URIStorage, Ownable {
    uint256 private _currentTokenId = 0;

    constructor(string memory name, string memory symbol, address initialOwner) 
        ERC721(name, symbol) 
        Ownable(initialOwner)
    {}

    function mintTo(address recipient, string memory uri) public onlyOwner {
        uint256 newTokenId = _currentTokenId++;
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, uri);
    }
}