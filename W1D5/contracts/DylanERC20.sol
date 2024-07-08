// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dylan is ERC20 {
    constructor(uint256 initialSupply) ERC20("Dylan", "DJ") {
        _mint(msg.sender, initialSupply);
    }
}
