// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library StorageSlot {
    struct AddressSlot {
        address value;
    }

    function getAddressSlot(
        bytes32 slot
    ) internal pure returns (AddressSlot storage r) { // 使用storage代表这个r是指向存储的引用，而不是存储在内容中，这样可以直接修改智能合约的存储。
        assembly {
            r.slot := slot // 设置r的具体存储位置
        }
    }
}
/**
    Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
    Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
    Transaction hash: 0xced12a79f7ce4e9737843fca8e1d58751d1a36af4e068667945051d940c8b1d2
 */
contract CounterProxy {
    // bytes32: 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);

    /**
        ➜  storage_memory git:(main) ✗ cast rpc "eth_getStorageAt" [要查询的合约地址] [哪个slot] latest
     */
    // bytes32: 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
    bytes32 private constant ADMIN_SLOT = bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);

    constructor() {
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = msg.sender;
    }

    /**
    当使用 `delegatecall` 并且调用成功时（`result` 不为 0），`delegatecall` 执行的合约函数返回的数据会被存放在内存中，从位置 0 开始，长度为 `returndatasize()`。
        这里的几个关键步骤如下：

        1. **`delegatecall` 执行**：
            - 这个指令调用另一个合约（在 `_implementation` 地址上）的函数，使用当前合约的存储上下文。它传递当前调用的完整 `calldata`，这通常包括被调用函数的标识符和参数。

        2. **存储返回数据**：
            - `delegatecall` 完成后，如果有返回数据，这些数据会被 EVM 临时存储在一个特殊的返回区域中。`returndatasize()` 指令可以用来获取这些返回数据的长度。

        3. **复制返回数据到内存**：
            - `returndatacopy(0, 0, returndatasize())` 指令将从返回区域复制返回数据到内存中指定的位置（这里是从内存的起始位置 0 开始）。

        4. **返回数据到外部调用者**：
            - 如果 `delegatecall` 成功（`result` 不为 0），则 `return(0, returndatasize())` 指令会将内存中从位置 0 开始、长度为 `returndatasize()` 的数据返回给原始调用者。

        这样，原始调用者就可以接收到由 `_delegate` 函数通过 `delegatecall` 调用的函数返回的任何数据。这使得代理合约能够在逻辑上完全模拟另一个合约的行为，而对外部调用者来说，它看起来就像是直接与实际执行逻辑的合约进行交互一样。
     */
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

    function _fallback() internal {
        _delegate(_getImplementation());
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _setImplementation(address _implementation) private {
        require(_implementation.code.length > 0, "implementation is not contract");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }

    function upgradeTo(address _implementation) external onlyAdmin {
        _setImplementation(_implementation);
    }

    modifier onlyAdmin() {
        require(StorageSlot.getAddressSlot(ADMIN_SLOT).value == msg.sender, "unauthorized");
        _;
    }

}