// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/**
 * @title KK Token 
 */
interface IKKToken is IERC20 {
    function mint(address to, uint256 amount) external;
}