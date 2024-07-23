// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IERC20Permit} from "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol";
interface IRNTToken is IERC20, IERC20Permit {
    function mintForIDO(uint256 _amount) external;

}