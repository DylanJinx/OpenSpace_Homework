//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface Implementation {
    function initialize(address _owner) external;
}

contract CloneFactory {
    // Implementation.sol address
    address public implementation;

    //追踪每个用户拥有的所有最小代理实例地址
    mapping(address => address[]) public allClones;

    event NewClone(address _newClone, address _owner);

    constructor(address _implementation) {
        implementation = _implementation;
    }

    // from openzepplin-contracts/contracts/proxy/Clones.sol
    function clone(address implementation) internal returns (address instance) {
        /// @solidity memory-safe-assembly
        assembly {
            // Cleans the upper 96 bits of the `implementation` word, then packs the first 3 bytes
            // of the `implementation` address with the bytecode before the address.
            mstore(0x00, or(shr(0xe8, shl(0x60, implementation)), 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000))
            // Packs the remaining 17 bytes of `implementation` with the bytecode after the address.
            mstore(0x20, or(shl(0x78, implementation), 0x5af43d82803e903d91602b57fd5bf3))
            instance := create(0, 0x09, 0x37)
        }
        require(instance != address(0), "ERROR: Failed to create clone");
    }

    function _clone() external {
        address identicalChild = clone(implementation);
        allClones[msg.sender].push(identicalChild);
        Implementation(identicalChild).initialize(msg.sender);
        emit NewClone(identicalChild, msg.sender);
    }

    function returnClones(address _owner) external view returns (address[] memory) {
        return allClones[_owner];
    }
}