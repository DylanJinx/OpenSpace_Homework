// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MyWallet { 
    // slot 0
    string public name;
    // slot 1
    mapping(address => bool) private approved;
    // slot 2
    address public owner;

    function getOwner() internal view returns(address _owner) {
        assembly {
            _owner := sload(2)
        }
    }

    function setOwner(address _owner) internal {
        assembly {
            sstore(2, _owner)
        }
    }

    constructor(string memory _name) {
        name = _name;
        setOwner(msg.sender);
    } 

    modifier auth {
        require (msg.sender == getOwner(), "Not authorized");
        _;
    }

    function transferOwnership(address _addr) public auth {
        require(_addr!=address(0), "New owner is the zero address");
        require(getOwner() != _addr, "New owner is the same as the old owner");
        setOwner(_addr);
    }
}