// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract DylanERC20 is ERC20 {
    constructor() ERC20("DylanToken", "Dylan") {}
    
    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }
}