// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./UniswapV2Pair.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "../lib/forge-std/src/Test.sol";

contract UniswapV2Factory is IUniswapV2Factory, Test {
    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;
    
    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    // 设置收取交易费用的地址
    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');
        feeTo = _feeTo;
    }

    // 用于更改 feeToSetter 的地址，即更改谁有权限来设置 feeTo 地址
    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }

    function createPair(
        address tokenA, 
        address tokenB
    ) external returns (address pair) {
        if (tokenA == tokenB) {
            revert IdenticalAddresses();
        }

        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
    
        if (token0 == address(0)) {
            revert ZeroAddress();
        }

        if (getPair[token0][token1] != address(0)) {
            revert PairExists();
        }

        bytes memory bytecode = type(UniswapV2Pair).creationCode;
        // 参考：https://learnblockchain.cn/article/8887
        // bytes32 hash = keccak256(abi.encodePacked(bytecode));
        // console.log("here here here: ");
        // console.logBytes32(hash);

        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        IUniswapV2Pair(pair).initialize(token0, token1);

        // 注册
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair;
        allPairs.push(pair);

        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    
    error IdenticalAddresses();
    error PairExists();
    error ZeroAddress();
}