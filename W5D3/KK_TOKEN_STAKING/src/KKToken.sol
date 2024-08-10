// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IKKToken.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract KKToken is ERC20("KKTOKEN", "KK"), IKKToken {
    function mint(address to, uint256 amount) external override {
        _mint(to, amount);
    }
}
