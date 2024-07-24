// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {RNTToken} from "../src/RNTToken.sol";
import {esRNTToken} from "../src/esRNTToken.sol";
import {RNTTokenStakePool} from "../src/RNTTokenStakePool.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";


contract RNTTokenStakePool_Test is Test {
    using Strings for uint256;

    address public RNTTokenAdmin;
    uint256 public RNTTokenAdminPrivateKey;

    address public esRNTTokenAdmin;
    uint256 public esRNTTokenAdminPrivateKey;

    address public stakePoolAdmin;
    uint256 public stakePoolAdminPrivateKey;

    address public staker;
    uint256 public stakerPrivateKey;

    uint256 public StakeReward = 1_000_000 * 10 ** 18;

    RNTToken public RNT;
    esRNTToken public esRNT;
    RNTTokenStakePool public stakePool;

    function setUp() public {
        (RNTTokenAdmin, RNTTokenAdminPrivateKey) = makeAddrAndKey("RNTTokenAdmin");
        (esRNTTokenAdmin, esRNTTokenAdminPrivateKey) = makeAddrAndKey("esRNTTokenAdmin");
        (stakePoolAdmin, stakePoolAdminPrivateKey) = makeAddrAndKey("stakePoolAdmin");
        (staker, stakerPrivateKey) = makeAddrAndKey("staker");

        vm.prank(RNTTokenAdmin);
        RNT = new RNTToken();

        vm.prank(esRNTTokenAdmin);
        esRNT = new esRNTToken(address(RNT));

        vm.prank(stakePoolAdmin);
        stakePool = new RNTTokenStakePool(address(RNT), address(esRNT));

        // 在RNTToken中设置stake合约地址
        vm.prank(RNTTokenAdmin);
        RNT.setstakeContract(address(stakePool));

        // 在esRNTToken中设置stake合约地址
        vm.prank(esRNTTokenAdmin);
        esRNT.setstakeContract(address(stakePool));

        vm.prank(stakePoolAdmin);
        stakePool.mintRNT(StakeReward);
    }

    // ------------------------------------ sign ------------------------------------
    // approve ERC20 signature
    function SignERC20(uint256 _amount, uint256 _nonce, uint256 _deadline) private view returns(RNTTokenStakePool.ERC20PermitData memory) {
        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                staker,
                stakePool,
                _amount,
                _nonce,
                _deadline
            )
        );
        
        bytes32 digest = RNT.getDigest(structHash);

        uint8 _v;
        bytes32 _r;
        bytes32 _s;

        // Generate Signature
        (_v, _r, _s) = vm.sign(stakerPrivateKey, digest); 

        RNTTokenStakePool.ERC20PermitData memory _approveData = RNTTokenStakePool.ERC20PermitData ({
            value: _amount,
            deadline: _deadline,
            v: _v,
            r: _r,
            s: _s
        });


        return _approveData;
    }

    // ------------------------------------ tests ------------------------------------


    function test_stake() public {
        uint256 amount = 1 * 10 ** 18;
        uint256 _deadline;
        _deadline = block.timestamp + 600;
        deal(address(RNT), staker, amount);
        
        RNTTokenStakePool.ERC20PermitData memory _approveData_1 = SignERC20(amount, 0, _deadline);

        // day1: stake 1 RNT
        uint256 startTime;
        startTime = block.timestamp;
        vm.prank(staker);
        stakePool.stake(_approveData_1);
        require(RNT.balanceOf(staker) == 0, "stakePool did not properly pledge the user's RNT and the user's balance of RNT was incorrect ");
        require(RNT.balanceOf(address(stakePool)) == stakePool.TOTAL_STAKE_REWARD() + amount, "stakePool did not properly pledge the user's RNT and the stakePool's balance of RNT was incorrect");
        require(stakePool.currentStakeAmount() == amount, "stakePool : error currentStakeAmount");


        // day2: claim，获取 1 esRNT
        vm.warp(startTime + 1 days);
        vm.prank(staker);
        uint256 esRNTLockInfoId_1 = stakePool.claim();
        require(esRNT.balanceOf(staker) == 1e18, "got the wrong reward on the first day");
        (, uint256 LockInfoAmount_1, ) = esRNT.lockInfos(esRNTLockInfoId_1);
        require(RNT.balanceOf(address(stakePool)) == stakePool.TOTAL_STAKE_REWARD() + stakePool.currentStakeAmount(), "When the user calls claim, stakePool does not transfer RNT to the esRNT contract");
        require(RNT.balanceOf(address(esRNT)) == LockInfoAmount_1, "esRNT contract balance of RNT is error");

        deal(address(RNT), staker, amount);
        _deadline = block.timestamp + 600;
        RNTTokenStakePool.ERC20PermitData memory _approveData_2 = SignERC20(amount, 1, _deadline);

        // day2: stake 1 RNT
        vm.prank(staker);
        stakePool.stake(_approveData_2);
        require(RNT.balanceOf(staker) == 0, "stakePool did not properly pledge the user's RNT and the user's balance of RNT was incorrect ");
        require(RNT.balanceOf(address(stakePool)) == stakePool.TOTAL_STAKE_REWARD() + stakePool.currentStakeAmount() + amount - stakePool.already_claimed_Rewards(), "stakePool did not properly pledge the user's RNT and the stakePool's balance of RNT was incorrect");
        require(stakePool.currentStakeAmount() == 2e18, "stakePool : error currentStakeAmount");

        // day3: claim, 获取 2 esRNT, 共 3 esRNT
        vm.warp(startTime + 2 days);
        vm.prank(staker);
        uint256 esRNTLockInfoId_2 = stakePool.claim();
        require(esRNT.balanceOf(staker) == 3e18, "I got the wrong reward on the first day");
        (, uint256 LockInfoAmount_2, ) = esRNT.lockInfos(esRNTLockInfoId_2);
        require(RNT.balanceOf(address(stakePool)) == stakePool.TOTAL_STAKE_REWARD() + stakePool.currentStakeAmount(), "When the user calls claim, stakePool does not transfer RNT to the esRNT contract");
        require(RNT.balanceOf(address(esRNT)) == LockInfoAmount_1 + LockInfoAmount_2, "esRNT contract balance of RNT is error");

        // day3: unstake 2 RNT
        vm.prank(staker);
        stakePool.unstake(2e18);
        require(RNT.balanceOf(staker) == 2e18, "got the wrong RNT balance on the day3 for unstake");
        require(RNT.balanceOf(address(stakePool)) == stakePool.TOTAL_STAKE_REWARD() + stakePool.currentStakeAmount(), "When the user calls unclaim, stakePool does not transfer RNT to the user");
        
        // day2+15: staker burn esRNTLockInfoId_1
        vm.warp(startTime + 16 days);
        vm.prank(staker);
        esRNT.burn(esRNTLockInfoId_1);
        require(RNT.balanceOf(staker) == 2e18 + 5e17, "staker: burn esRNTLockInfoId_1 error");
        require(RNT.balanceOf(address(esRNT)) == LockInfoAmount_2, "esRNT: burn esRNTLockInfoId_1 error");

        // day3+30: staker burn esRNTLockInfoId_2
        vm.warp(startTime + 32 days);
        vm.prank(staker);
        esRNT.burn(esRNTLockInfoId_2);
        require(RNT.balanceOf(staker) == 2e18 + 5e17 + 2e18, "staker: burn esRNTLockInfoId_2 error");
        require(RNT.balanceOf(address(esRNT)) == 0, "esRNT: burn esRNTLockInfoId_2 error");

    }



}