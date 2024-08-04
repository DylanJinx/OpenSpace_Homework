// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./libraries/Math.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IUniswapV2Pair.sol";
import {UniswapV2ERC20} from "./UniswapV2ERC20.sol";
import "./libraries/UQ112x112.sol";

contract UniswapV2Pair is IUniswapV2Pair, UniswapV2ERC20 {
    // using SafeMath for uint;  // 0.8.0 doesn't need SafeMath, the compiler checks for overflows

    using UQ112x112 for uint224;

    uint public constant MINIMUM_LIQUIDITY = 10**3;
    bytes4 private constant SELECTOR = bytes4(keccak256(bytes('transfer(address,uint256)')));

    address public factory;
    address public token0;
    address public token1;

    uint112 private reserve0; // the amount of token0 in the reserve
    uint112 private reserve1; // the amount of token1 in the reserve
    uint32  private blockTimestampLast; // 因为TWAP是基于时间的，所以需要记录最后一次的时间戳
    
    uint public price0CumulativeLast; // token0的价格累计值 
    uint public price1CumulativeLast; // token1的价格累计值
    uint public kLast; // reserve0 * reserve1, as of immediately after the most recent liquidity event

    constructor() {
        factory = msg.sender;
    }

    uint private unlocked = 1;
    modifier lock() {
        require(unlocked == 1, 'UniswapV2: LOCKED');
        unlocked = 0;
        _;
        unlocked = 1;
    }

    // called once by the factory at time of deployment
    function initialize(
        address _token0, 
        address _token1
    ) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN'); // sufficient check
        token0 = _token0;
        token1 = _token1;
    }

    function getReserves() public view returns (
        uint112 _reserve0, 
        uint112 _reserve1, 
        uint32 _blockTimestampLast
    ) {
        _reserve0 = reserve0;
        _reserve1 = reserve1;
        _blockTimestampLast = blockTimestampLast;
    }

    // Need to transfer token0 and token1 first
    function mint(address to) external returns (uint liquidity) {
        (uint112 _reserve0, uint112 _reserve1,) = getReserves(); // gas savings
        uint balance0 = IERC20(token0).balanceOf(address(this));
        uint balance1 = IERC20(token1).balanceOf(address(this));

        uint amount0 = balance0 - _reserve0;
        uint amount1 = balance1 - _reserve1;

        // uint liquidity; // The number of LPToken should be cast to the user

        if (totalSupply == 0) {
            liquidity = Math.sqrt(amount0 * amount1) - MINIMUM_LIQUIDITY;
            _mint(address(0), MINIMUM_LIQUIDITY);
        } else {
            liquidity = Math.min(
                totalSupply * amount0 / _reserve0, 
                totalSupply * amount1 / _reserve1
            );
        }

        if (liquidity <= 0) {
            revert InsufficientLiquidityMinted();
        }

        _mint(to, liquidity);
        _update(balance0, balance1, _reserve0, _reserve1);

        emit Mint(msg.sender, amount0, amount1);
    }

    // Need to transfer LPToken first
    function burn(address _to) public returns(
        uint amount0, 
        uint amount1
    ) {
        uint balance0 = IERC20(token0).balanceOf(address(this));
        uint balance1 = IERC20(token1).balanceOf(address(this));

        (uint112 _reserve0, uint112 _reserve1,) = getReserves(); // gas savings

        uint liquidity = balanceOf[address(this)];
        amount0 = balance0 * liquidity / totalSupply;
        amount1 = balance1 * liquidity / totalSupply;

        _burn(address(this), liquidity);
        _safeTransfer(token0, _to, amount0);
        _safeTransfer(token1, _to, amount1);

        // update reserves
        balance0 = IERC20(token0).balanceOf(address(this));
        balance1 = IERC20(token1).balanceOf(address(this));
        _update(balance0, balance1, _reserve0, _reserve1);

        emit Burn(msg.sender, amount0, amount1, _to);
    }

    // For example, to exchange 'token0' for 'token1', users first need to authorize the 'UniswapV2Pair' contract to use the corresponding amount of 'token0' from their account. This step is done by calling the 'approve' method. After authorization, the user initiates the exchange process by calling 'UniswapV2Pair' or an exchange function on the related routing contract (e.g. 'swapExactTokensForTokens'). In this process, the contract will transfer 'token0' according to the authorization and provide the corresponding 'token1' according to the current state of the liquidity pool.
    function swap(
        uint amount0Out, 
        uint amount1Out, 
        address to, 
        bytes calldata data
    ) external lock {
        if (amount0Out == 0 && amount1Out == 0) {
            revert InsufficientOutputAmount();
        }

        (uint112 _reserve0, uint112 _reserve1,) = getReserves(); // Determine if the reserve is sufficient
        if (amount0Out > _reserve0 || amount1Out > _reserve1) {
            revert InsufficientLiquidity();
        }

        // after swap the amount in the pool
        uint256 balance0 = IERC20(token0).balanceOf(address(this)) - amount0Out;
        uint256 balance1 = IERC20(token1).balanceOf(address(this)) - amount1Out;

        if (balance0 * balance1 < uint256(_reserve0) * uint256(_reserve1)) {
            revert InvalidK();
        }

        _update(balance0, balance1, _reserve0, _reserve1);

        // Transfer the token to the user
        require(to != token0 && to != token1 , "UniswapV2:INVALID_TO");
        if (amount0Out > 0)_safeTransfer(token0, to, amount0Out);
        if (amount1Out > 0)_safeTransfer(token1, to, amount1Out);
    }

    function skim(address to) external{}
    function sync() external {}

    function _update(
        uint256 balance0, 
        uint256 balance1,
        uint112 _reserve0,
        uint112 _reserve1
    ) private {
        if (balance0 > type(uint112).max || balance1 > type(uint112).max) {
            revert BalanceOverflow();
        }

        unchecked {
            uint32 timeElapsed = uint32(block.timestamp) - blockTimestampLast; // Overflow is desired

            if (timeElapsed > 0 && _reserve0 > 0 && _reserve1 > 0) {
                /*
                累积价格包含了上一次交易区块中发生的截止价格，但不会将当前区块中的最新截止价格计算进去，这个计算要等到后续区块的交易发生时进行。
                因此累积价格永远都比当前区块的最新价格（执行价格）慢那么一个区块
                */
                // 用的是reserve0 和 reserve1进行计算（上一个区块的价格），其目的是为了使当前价格比当前区块的最新价格慢一个区块
                price0CumulativeLast += uint256(UQ112x112.encode(_reserve1).uqdiv(_reserve0)) * timeElapsed;
                price1CumulativeLast += uint256(UQ112x112.encode(_reserve0).uqdiv(_reserve1)) * timeElapsed;
            }
        }
        reserve0 = uint112(balance0);
        reserve1 = uint112(balance1);
        blockTimestampLast = uint32(block.timestamp);

        emit Sync(reserve0, reserve1);
    }

    function _safeTransfer(
        address _token, 
        address _to, 
        uint value
    ) private {
        // abi.encodeWithSignature("transfer(address,uint256)", to, value)
        (bool success, bytes memory data) = _token.call(abi.encodeWithSelector(SELECTOR, _to, value));

        if (!success || (data.length > 0 && abi.decode(data, (bool)) == false)) {
            revert TransferFailed();
        }
    }

    error InsufficientLiquidityMinted();
    error InsufficientLiquidityBurned();
    error InsufficientOutputAmount();
    error InsufficientLiquidity();
    error InvalidK();
    error TransferFailed();
    error BalanceOverflow();
}