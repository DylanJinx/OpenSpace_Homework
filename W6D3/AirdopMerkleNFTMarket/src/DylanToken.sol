// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DylanToken is ERC20Permit {

    constructor() ERC20("DylanToken", "DT") ERC20Permit("DylanToken") {
    }

    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }

    // 公开Digest
    function getDigest(bytes32 structHash) public view returns (bytes32) {
        return _hashTypedDataV4(structHash);
    }
}
