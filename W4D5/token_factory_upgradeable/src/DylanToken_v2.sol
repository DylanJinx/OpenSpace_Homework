//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import "../lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";

contract DylanToken_v2 is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    uint public perMint;
    uint public MAX_SUPPLY;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        string memory _symbol, 
        uint _maxSupply, 
        uint _perMint
    ) initializer external {
        __ERC20_init("DylanToken", _symbol);
        __Ownable_init(msg.sender);
        perMint = _perMint;
        MAX_SUPPLY = _maxSupply;
    }

    function mint(address to) external onlyOwner {
        require(totalSupply() + perMint <= MAX_SUPPLY, "DylanToken: MAX_SUPPLY exceeded");
        _mint(to, perMint);
    }

    function getPerMint() external view returns (uint) {
        return perMint;
    }
}