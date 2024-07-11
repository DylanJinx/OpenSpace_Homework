// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../src/Bank.sol";

contract GreatBankTest is Test {
    Bank public bank;
    address public user;
    address[] users;

    event Deposti(address indexed user, uint amount);

    // setUp(): 再每个测试运行之前，部署一个新的Bank合约，并为user账号分配10个ETH
    function setUp() public {
        bank = new Bank();
        user = makeAddr("alice");
        // 为测试用户分配 10 个以太
        vm.deal(user, 10 ether);

        // 初始化一些用户地址
        for (uint256 i = 0; i < 10; i++) {
            address test_user = address(
                // abi.encodePacked() 将多个参数编码为一个字节数组,对于i来说，它的编码结果就是该值的简单字节表示
                // keccak256()：用于生成256位哈希值
                // uint256()：将哈希值转换为256位整数，虽然keccak256()返回的是bytes32类型的值，但是这里的转换是为了语意上明确
                // uint160()：以太坊地址是160位的，所以这个转换是将256位的哈希值截断为160位
                uint160(uint256(keccak256(abi.encodePacked(i))))
            );
            users.push(test_user);
            vm.deal(test_user, 100 ether);
        }
    }

    // testInitialBalance()：验证初始余额为0
    function testInitalBalance() public view {
        assertEq(bank.balanceOf(user), 0);
    }

    // testDepositETH()：测试存入1个ETH 并验证余额
    function testDepositETH() public {
        vm.prank(user);
        bank.depositETH{value: 1 ether}();

        assertEq(bank.balanceOf(user), 1 ether);
    }

    function testDepositRandomETH(uint96 amount) public {
        vm.assume(amount > 0);
        vm.assume(amount <= address(user).balance);

        vm.prank(user);
        bank.depositETH{value:amount}();

        assertEq(bank.balanceOf(user), amount);
    }

    // 命名为testFailDepositETH()，虽然我们是预测了失败，但是forge test会显示这个测试示例失败；命名为test_FailDepositETH()，则会显示为成功，同时我们预期了失败
    function test_FailDepositETH() public {
        vm.prank(user);
        vm.expectRevert(abi.encodeWithSelector(Bank.DepositAmountMustBeGreaterThanZero.selector));
        bank.depositETH{value: 0}();
    }

    function test_Fail_no_abi_DepositETH() public {
        vm.prank(user);
        vm.expectRevert(Bank.DepositAmountMustBeGreaterThanZero.selector);
        bank.depositETH{value: 0}();
    }

    // testMultipleDepositETH()：测试多次存入ETH
    function testmultipleDepositETH() public {
        vm.startPrank(user);

        bank.depositETH{value: 1 ether}();
        bank.depositETH{value: 2 ether}();
        bank.depositETH{value: 3 ether}();

        vm.stopPrank();

        assertEq(bank.balanceOf(user), 6 ether);
    }

    // testMultipleUsers(): 测试多个用户存入ETH
    function testMultipleUsers() public {
        uint256 depositAmount = 1 ether;

        // 遍历所有用户
        for(uint256 i = 0; i < users.length; i++) {
            vm.prank(users[i]);
            bank.depositETH{value: depositAmount}();

            // 检查用户余额是否正确更新
            uint256 expectedBalance = depositAmount;
            uint256 actualBalance = bank.balanceOf(users[i]);
            assertEq(actualBalance, expectedBalance, "User balance should be updated correctly after deposit");
        }
    }

    // 测试事件
    function testDepositETHEvent() public {
        vm.prank(user);
        vm.expectEmit(true, false, false, true);
        // 事件被定义为合约的一部分，而不是单个合约实例的一部分。因此，在测试中设置事件的期望时，需要引用合约类（如 Bank）来指定事件类型。
        emit Bank.Deposit(user, 1 ether);

        bank.depositETH{value: 1 ether}();
    }

    function testRandomUserDeposit() public {
        address randomUser = makeAddr("randomUser");
        
        vm.deal(randomUser, 100 ether);
        vm.prank(randomUser);
        bank.depositETH{value: 1 ether}();
        assertEq(bank.balanceOf(randomUser), 1 ether);
    }

    // 测试随机用户存款
    /*
        @notice 测试随机用户存款
        @dev 测试随机用户存款，确保存款金额大于0，用户地址不为零，用户地址有足够的余额进行存款，存款金额不超过用户的余额
        @param t_user 用户地址
        @param amount 存款金额
        @return 无返回值
    */
    function testFuzzRandomUserDeposit(address t_user, uint96 amount) public {
        vm.assume(t_user != address(0));

        vm.assume(amount > 0);
        
        vm.assume(amount <= address(t_user).balance);

        vm.prank(t_user);
        bank.depositETH{value: amount}();

        assertEq(bank.balanceOf(t_user), amount);

    }

    function test_totalBalance() public view {
        // 获取银行合约的余额
        uint256 totalBankBalance = address(bank).balance;
        // 计算用户余额的总和
        uint256 totalUserBalance = 0;

        // 遍历用户数组，累加每个用户的余额
        for (uint256 i = 0; i < users.length; i++) {
            totalUserBalance += bank.balanceOf(users[i]);
        }

        // 断言银行余额和用户余额的总和相等
        assertEq(totalBankBalance, totalUserBalance);
    }
}