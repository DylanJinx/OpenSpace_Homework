Compiling 2 files with Solc 0.8.20
Solc 0.8.20 finished in 2.06s
Compiler run successful!

Ran 2 tests for test/TokenBankList_Test.sol:TokenBankList_Test
[PASS] test_deposit() (gas: 562323)
Traces:
  [562323] TokenBankList_Test::test_deposit()
    ├─ [0] VM::prank(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [108058] TokenBankList::addDepositer(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], 5000, ECRecover: [0x0000000000000000000000000000000000000001])
    │   ├─ [814] DylanERC20::allowance(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [30862] DylanERC20::transferFrom(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 5000)
    │   │   ├─ emit Transfer(from: user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 5000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], amount: 5000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], 4000, user5: [0x22068447936722AcB3481F41eE8a0B7125526D55])
    │   ├─ [814] DylanERC20::allowance(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 4000)
    │   │   ├─ emit Transfer(from: user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 4000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], amount: 4000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], 3000, user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0])
    │   ├─ [814] DylanERC20::allowance(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 3000)
    │   │   ├─ emit Transfer(from: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 3000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], amount: 3000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], 2000, user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec])
    │   ├─ [814] DylanERC20::allowance(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 2000)
    │   │   ├─ emit Transfer(from: user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 2000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], amount: 2000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], 1000, user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802])
    │   ├─ [814] DylanERC20::allowance(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000)
    │   │   ├─ emit Transfer(from: user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], amount: 1000)
    │   └─ ← [Stop] 
    ├─ [567] TokenBankList::tokenBalances(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 1000
    ├─ [0] VM::assertEq(1000, 1000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 2000
    ├─ [0] VM::assertEq(2000, 2000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 3000
    ├─ [0] VM::assertEq(3000, 3000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 4000
    ├─ [0] VM::assertEq(4000, 4000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 5000
    ├─ [0] VM::assertEq(5000, 5000) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Return] 15000 [1.5e4]
    ├─ [0] VM::assertEq(15000 [1.5e4], 15000 [1.5e4]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 999999999999999999000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999999000 [9.999e20], 999999999999999999000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 999999999999999998000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999998000 [9.999e20], 999999999999999998000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 999999999999999997000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999997000 [9.999e20], 999999999999999997000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 999999999999999996000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999996000 [9.999e20], 999999999999999996000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 999999999999999995000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999995000 [9.999e20], 999999999999999995000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [3493] TokenBankList::getTop(5) [staticcall]
    │   └─ ← [Return] [0x22068447936722AcB3481F41eE8a0B7125526D55, 0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0, 0xc0A55e2205B289a967823662B841Bd67Aa362Aec, 0x537C8f3d3E18dF5517a58B3fB9D9143697996802, 0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]
    ├─ [0] VM::assertEq(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::prank(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec])
    │   └─ ← [Return] 
    ├─ [63294] TokenBankList::deposit(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], 1500, user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], user5: [0x22068447936722AcB3481F41eE8a0B7125526D55])
    │   ├─ [3288] DylanERC20::transfer(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], 3000)
    │   │   ├─ emit Transfer(from: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], to: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], value: 3000)
    │   │   └─ ← [Return] true
    │   ├─ emit RemoveDepositer(user: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], amount: 3000)
    │   ├─ [814] DylanERC20::allowance(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 999999999999999997000 [9.999e20]
    │   ├─ [6962] DylanERC20::transferFrom(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 4500)
    │   │   ├─ emit Transfer(from: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 4500)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], amount: 4500)
    │   └─ ← [Stop] 
    ├─ [567] TokenBankList::tokenBalances(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 4500
    ├─ [0] VM::assertEq(4500, 4500) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Return] 16500 [1.65e4]
    ├─ [0] VM::assertEq(16500 [1.65e4], 16500 [1.65e4]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 999999999999999995500 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999995500 [9.999e20], 999999999999999995500 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [3493] TokenBankList::getTop(5) [staticcall]
    │   └─ ← [Return] [0x22068447936722AcB3481F41eE8a0B7125526D55, 0xc0A55e2205B289a967823662B841Bd67Aa362Aec, 0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0, 0x537C8f3d3E18dF5517a58B3fB9D9143697996802, 0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]
    ├─ [0] VM::assertEq(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_withdraw() (gas: 562473)
Traces:
  [562473] TokenBankList_Test::test_withdraw()
    ├─ [0] VM::prank(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [108058] TokenBankList::addDepositer(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], 5000, ECRecover: [0x0000000000000000000000000000000000000001])
    │   ├─ [814] DylanERC20::allowance(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [30862] DylanERC20::transferFrom(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 5000)
    │   │   ├─ emit Transfer(from: user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 5000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], amount: 5000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], 4000, user5: [0x22068447936722AcB3481F41eE8a0B7125526D55])
    │   ├─ [814] DylanERC20::allowance(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 4000)
    │   │   ├─ emit Transfer(from: user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 4000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], amount: 4000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], 3000, user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0])
    │   ├─ [814] DylanERC20::allowance(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 3000)
    │   │   ├─ emit Transfer(from: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 3000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], amount: 3000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], 2000, user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec])
    │   ├─ [814] DylanERC20::allowance(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 2000)
    │   │   ├─ emit Transfer(from: user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 2000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], amount: 2000)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF])
    │   └─ ← [Return] 
    ├─ [24739] DylanERC20::approve(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000000 [1e21])
    │   ├─ emit Approval(owner: user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], spender: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000000 [1e21])
    │   └─ ← [Return] true
    ├─ [59662] TokenBankList::addDepositer(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], 1000, user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802])
    │   ├─ [814] DylanERC20::allowance(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [8962] DylanERC20::transferFrom(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000)
    │   │   ├─ emit Transfer(from: user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], amount: 1000)
    │   └─ ← [Stop] 
    ├─ [567] TokenBankList::tokenBalances(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 1000
    ├─ [0] VM::assertEq(1000, 1000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 2000
    ├─ [0] VM::assertEq(2000, 2000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 3000
    ├─ [0] VM::assertEq(3000, 3000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 4000
    ├─ [0] VM::assertEq(4000, 4000) [staticcall]
    │   └─ ← [Return] 
    ├─ [567] TokenBankList::tokenBalances(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 5000
    ├─ [0] VM::assertEq(5000, 5000) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Return] 15000 [1.5e4]
    ├─ [0] VM::assertEq(15000 [1.5e4], 15000 [1.5e4]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 999999999999999999000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999999000 [9.999e20], 999999999999999999000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 999999999999999998000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999998000 [9.999e20], 999999999999999998000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 999999999999999997000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999997000 [9.999e20], 999999999999999997000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 999999999999999996000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999996000 [9.999e20], 999999999999999996000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 999999999999999995000 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999995000 [9.999e20], 999999999999999995000 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [3493] TokenBankList::getTop(5) [staticcall]
    │   └─ ← [Return] [0x22068447936722AcB3481F41eE8a0B7125526D55, 0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0, 0xc0A55e2205B289a967823662B841Bd67Aa362Aec, 0x537C8f3d3E18dF5517a58B3fB9D9143697996802, 0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]
    ├─ [0] VM::assertEq(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::prank(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec])
    │   └─ ← [Return] 
    ├─ [63532] TokenBankList::withdraw(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], 1500, user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802])
    │   ├─ [3288] DylanERC20::transfer(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], 3000)
    │   │   ├─ emit Transfer(from: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], to: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], value: 3000)
    │   │   └─ ← [Return] true
    │   ├─ emit RemoveDepositer(user: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], amount: 3000)
    │   ├─ [814] DylanERC20::allowance(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] 999999999999999997000 [9.999e20]
    │   ├─ [6962] DylanERC20::transferFrom(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1500)
    │   │   ├─ emit Transfer(from: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], to: TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1500)
    │   │   └─ ← [Return] true
    │   ├─ emit Deposit(user: user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], amount: 1500)
    │   └─ ← [Stop] 
    ├─ [567] TokenBankList::tokenBalances(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 1500
    ├─ [0] VM::assertEq(1500, 1500) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(TokenBankList: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Return] 13500 [1.35e4]
    ├─ [0] VM::assertEq(13500 [1.35e4], 13500 [1.35e4]) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] DylanERC20::balanceOf(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 999999999999999998500 [9.999e20]
    ├─ [0] VM::assertEq(999999999999999998500 [9.999e20], 999999999999999998500 [9.999e20]) [staticcall]
    │   └─ ← [Return] 
    ├─ [3493] TokenBankList::getTop(5) [staticcall]
    │   └─ ← [Return] [0x22068447936722AcB3481F41eE8a0B7125526D55, 0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0, 0x537C8f3d3E18dF5517a58B3fB9D9143697996802, 0xc0A55e2205B289a967823662B841Bd67Aa362Aec, 0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]
    ├─ [0] VM::assertEq(user5: [0x22068447936722AcB3481F41eE8a0B7125526D55], user5: [0x22068447936722AcB3481F41eE8a0B7125526D55]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0], user4: [0x90561e5Cd8025FA6F52d849e8867C14A77C94BA0]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802], user2: [0x537C8f3d3E18dF5517a58B3fB9D9143697996802]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec], user3: [0xc0A55e2205B289a967823662B841Bd67Aa362Aec]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF], user1: [0x29E3b139f4393aDda86303fcdAa35F60Bb7092bF]) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 2.39ms (1.59ms CPU time)

Ran 1 test suite in 2.85s (2.39ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)
