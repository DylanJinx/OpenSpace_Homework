// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IDylanToken_v2 {
    function initialize(string memory symbol, uint256 totalSupply, uint256 perMint) external;
    function mint(address _to) external;
    function getPerMint() external view returns (uint256);
}
