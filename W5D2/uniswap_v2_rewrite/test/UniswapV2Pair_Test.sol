// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import "../src/UniswapV2Pair.sol";
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ERC20Mintable is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}
    
    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }
}

contract UniswapV2Pair_Test is Test {
    UniswapV2Pair pair;
    ERC20Mintable token0;
    ERC20Mintable token1;

    address public tokenOwner;
    address public tokenOwner2;

    address public factoryOwner;

    function setUp() public {
        factoryOwner = makeAddr("factoryOwner");
        tokenOwner = makeAddr("tokenOwner");
        tokenOwner2 = makeAddr("tokenOwner2");

        pair = new UniswapV2Pair();
        token0 = new ERC20Mintable("Token A", "TKA");
        token1 = new ERC20Mintable("Token B", "TKB");

        vm.prank(factoryOwner);
        pair = new UniswapV2Pair();
        vm.prank(factoryOwner);
        pair.initialize(address(token0), address(token1));

        vm.prank(tokenOwner);
        token0.mint(10 ether);
        vm.prank(tokenOwner);
        token1.mint(10 ether);

        vm.prank(tokenOwner2);
        token0.mint(10 ether);
        vm.prank(tokenOwner2);
        token1.mint(10 ether);
    }

    function assertReserves(
        uint112 _reserve0, 
        uint112 _reserve1
    ) internal view {
        (uint112 reserve0, uint112 reserve1, ) = pair.getReserves();
        assertEq(reserve0, _reserve0, "reserve0 is not as expected");
        assertEq(reserve1, _reserve1, "reserve1 is not as expected");
    }

    // first add liquidity
    function MintBootstrap() internal {
        
        vm.prank(tokenOwner);
        token0.transfer(address(pair), 1 ether);
        vm.prank(tokenOwner);
        token1.transfer(address(pair), 1 ether);

        uint _liquidity = pair.mint(tokenOwner);
        assertEq(_liquidity, pair.balanceOf(tokenOwner), "UniswapV2Pair: mint() should return the number of LP tokens minted");
        uint expectedLiquidity = 1e18 - 1000;
        assertEq(_liquidity, expectedLiquidity, "the number of liquidity is not as expected");
        assertEq(pair.totalSupply(), expectedLiquidity + 1000, "the total supply of LP tokens is not as expected");

        assertReserves(1 ether, 1 ether);
    }

    // add more liquidity
    function test_MintMoreLiquidity() public {
        // first
        MintBootstrap();

        // second
        vm.prank(tokenOwner);
        token0.transfer(address(pair), 2 ether);
        vm.prank(tokenOwner);
        token1.transfer(address(pair), 2 ether);
        uint _liquidity = pair.mint(tokenOwner);
        assertEq(_liquidity, 2e18);
        assertEq(3 ether - 1000, pair.balanceOf(tokenOwner), "UniswapV2Pair: mint() should return the number of LP tokens minted");
        assertEq(pair.totalSupply(), 3 ether, "the total supply of LP tokens is not as expected");
        assertReserves(3 ether, 3 ether);
    }

    // Adding liquidity in the wrong proportion
    function test_MintWrongProportion() public {
        // first proportion with 1:1
        MintBootstrap();

        // second proportion with 2:1
        vm.prank(tokenOwner);
        token0.transfer(address(pair), 2 ether);
        vm.prank(tokenOwner);
        token1.transfer(address(pair), 1 ether);
        uint _liquidity = pair.mint(tokenOwner);
        assertEq(_liquidity, 1e18);
        assertEq(2 ether - 1000, pair.balanceOf(tokenOwner), "UniswapV2Pair: mint() should return the number of LP tokens minted");
        assertEq(pair.totalSupply(), 2 ether, "the total supply of LP tokens is not as expected");
        assertReserves(3 ether, 2 ether);
    }

    function testBurn() public {
        // first
        MintBootstrap();

        uint _liquidity = pair.balanceOf(tokenOwner);
        vm.prank(tokenOwner);
        pair.transfer(address(pair), _liquidity);
        vm.prank(tokenOwner);
        pair.burn(tokenOwner);
        assertEq(pair.balanceOf(tokenOwner), 0, "UniswapV2Pair: burn() should return the number of LP tokens burned");
        
        assertReserves(1000, 1000);

        assertEq(token0.balanceOf(tokenOwner), 10 ether - 1000, "the balance of token0 is not as expected");
        assertEq(token1.balanceOf(tokenOwner), 10 ether - 1000, "the balance of token1 is not as expected");
    }

        // Adding liquidity in the wrong proportion and burn
    function test_MintWrongProportion_burn_tokenOwner2() public {
        // first proportion with 1:1
        MintBootstrap();

        // second proportion with 2:1
        vm.prank(tokenOwner2);
        token0.transfer(address(pair), 2 ether);
        vm.prank(tokenOwner2);
        token1.transfer(address(pair), 1 ether);
        pair.mint(tokenOwner2);

        uint liquidity_2 = pair.balanceOf(tokenOwner2);
        assertEq(liquidity_2, 1e18, "the number of liquidity is not as expected");

        vm.prank(tokenOwner2);
        pair.transfer(address(pair), liquidity_2);
        vm.prank(tokenOwner2);
        pair.burn(tokenOwner2);
        assertEq(pair.balanceOf(tokenOwner2), 0, "UniswapV2Pair: burn() should return the number of LP tokens burned");

        assertReserves(15e17, 1e18);

        assertEq(token0.balanceOf(tokenOwner2), 10 ether - 5e17, "the balance of token0 is not as expected");
        assertEq(token1.balanceOf(tokenOwner2), 10 ether, "the balance of token1 is not as expected");
    }

    function test_MintWrongProportion_burn_tokenOwner() public {
        // first proportion with 1:1
        vm.startPrank(tokenOwner);

        token0.transfer(address(pair), 1 ether);
        token1.transfer(address(pair), 1 ether);
        pair.mint(tokenOwner);

        // second proportion with 2:1
        token0.transfer(address(pair), 2 ether);
        token1.transfer(address(pair), 1 ether);
        pair.mint(tokenOwner);

        uint liquidity = pair.balanceOf(tokenOwner);
        pair.transfer(address(pair), liquidity);
        pair.burn(tokenOwner);
        assertEq(pair.balanceOf(tokenOwner), 0, "UniswapV2Pair: burn() should return the number of LP tokens burned");
        
        assertReserves(1500, 1000);

        assertEq(token0.balanceOf(tokenOwner), 10 ether - 1500, "the balance of token0 is not as expected");
        assertEq(token1.balanceOf(tokenOwner), 10 ether - 1000, "the balance of token1 is not as expected");

        vm.stopPrank();
    }
}