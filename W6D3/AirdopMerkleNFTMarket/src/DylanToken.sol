// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DylanToken is ERC20Permit {
    uint256 public maxSupply = 1000000 * 10 ** 18;

    constructor() ERC20("DylanToken", "DT") ERC20Permit("DylanToken") {
        _mint(msg.sender, maxSupply);
    }

    // 公开Digest
    function getDigest(bytes32 structHash) public view returns (bytes32) {
        return _hashTypedDataV4(structHash);
    }
}
