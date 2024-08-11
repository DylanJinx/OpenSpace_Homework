// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract DylanToken is ERC20("Dylan Token", "DT") {
    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }
}