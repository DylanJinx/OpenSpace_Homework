// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * forge create --rpc-url sepolia --account Dylan_5900 DylanNFT --constructor-args "DylanNFT" "DN" 0x3A8492819b0C9AB5695D447cbA2532b879d25900
 * sepolia contract address: 0x9E09e6309142D14a4215a642B739a4f3eC85D5fC
 * Transaction hash: 0x21fb89a1f092d89f4ed7e6a227667b54a97cd02b0c7037c596d7f8e231415b1c
 * pass verify
 */
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