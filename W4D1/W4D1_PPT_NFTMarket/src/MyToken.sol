// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/**
 * forge create --rpc-url sepolia --account Dylan_5900 MyToken        
 * sepolia contract address: 0x187A30DE091B1421d5bB419ff160B1f2aB38b4d2
 * Transaction hash: 0x86deeb1d70b279712a638c149c82753a5c300228e0988a906a69b7ab48964184
 * pass verify
 */
contract MyToken is ERC20Permit {
    uint256 public maxSupply = 1000000 * 10 ** 18;

    constructor() ERC20("DylanToken", "DT") ERC20Permit("DylanToken") {
        _mint(msg.sender, maxSupply);
    }

    // 公开Digest
    function getDigest(bytes32 structHash) public view returns (bytes32) {
        return _hashTypedDataV4(structHash);
    }
}
