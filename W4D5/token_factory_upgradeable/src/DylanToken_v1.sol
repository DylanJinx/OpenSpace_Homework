//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DylanToken_v1 is ERC20, Ownable(msg.sender) {
    uint private immutable perMint;
    uint public immutable MAX_SUPPLY;

    constructor (
        string memory _symbol,
        uint _maxSupply,
        uint _perMint
    ) ERC20("DylanToken", _symbol) {
        perMint = _perMint;
        MAX_SUPPLY = _maxSupply;
    }

    function mint(address to) public onlyOwner {
        require(totalSupply() + perMint <= MAX_SUPPLY, "DylanToken: MAX_SUPPLY exceeded");
        _mint(to, perMint);
    }

    function getPerMint() public view returns (uint) {
        return perMint;
    }
}