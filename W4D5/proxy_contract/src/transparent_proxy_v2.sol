// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library StorageSlot {
    struct AddressSlot {
        address value;
    }

    function getAddressSlot(
        bytes32 slot
    ) internal pure returns (AddressSlot storage r) {
        assembly {
            r.slot := slot
        }
    }
}
/**
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Transaction hash: 0x6425bb3576693730899ec5f6a4d2ed81acdd223aacb2d9e90eac75c403e9e45a

 */
contract TransparentProxy {
    // bytes32: 0xf24d367544d0e47cb7537e31ff39174e2dacbae249d6e9fdfa91f8347eaf4e23
    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);
    // bytes32: 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
    bytes32 private constant ADMIN_SLOT = bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1);

    constructor() {
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = msg.sender;
    }

    function _delegate(address _implementation) internal virtual {
        assembly {

            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    // 代理到 Counter
    function _fallback() private {
        _delegate(_getImplementation());
    }

    fallback() external payable {
        if(msg.sender != _getAdmin()) {
            _fallback();
        } else {
            // 0xbb913f41000000000000000000000000bb0fdfa3eb9cd98e26ffc7a29364319c76cc535b00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000002007b000000000000000000000000000000000000000000000000000000000000
            (address newImplementation, bytes memory data) = abi.decode(msg.data[4:], (address, bytes));
            _setImplementation(newImplementation);
            // if (data.length > 0) {
            //     newImplementation.delegatecall(data);
            // }
        }
    }

    receive() external payable {
        _fallback();
    }

    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _getAdmin() private view returns (address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

    function _setImplementation(address _implementation) private {
        require(_implementation.code.length > 0, "implementation is not contract");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }


}
