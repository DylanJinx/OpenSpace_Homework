Compiling 1 files with Solc 0.8.20
Solc 0.8.20 finished in 1.86s
Compiler run successful!

Ran 2 tests for test/ContractWallet_Test.sol:ContractWallet_Test
[PASS] test_ReentrantAttack() (gas: 271873)
Logs:
  success:  true

Traces:
  [271873] ContractWallet_Test::test_ReentrantAttack()
    ├─ [79654] → new Attacker@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   └─ ← [Return] 286 bytes of code
    ├─ [0] VM::prank(signer1: [0x7C8913d493892928d19F932FB1893404b6f1cE73])
    │   └─ ← [Return] 
    ├─ [97602] ContractWallet::proposeTransaction(Attacker: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000 [1e18], 0x)
    │   ├─ emit TransactionProposed(nonce: 1, _to: Attacker: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000 [1e18], _data: 0x)
    │   └─ ← [Return] 1
    ├─ [0] VM::prank(signer2: [0x11A5669986B1fCBfcE54be4c543975b33D89856D])
    │   └─ ← [Return] 
    ├─ [2828] ContractWallet::confirm(1)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(signer3: [0xA40fa48886D3D845ac4Bba792E694A936a3AfC00])
    │   └─ ← [Return] 
    ├─ [55] ContractWallet::receive{value: 10000000000000000000}()
    │   └─ ← [Stop] 
    ├─ [0] console::log("success: ", true) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectRevert(custom error f4844814:)
    │   └─ ← [Return] 
    ├─ [32492] ContractWallet::executeTransaction(1)
    │   ├─ [1312] Attacker::receive{value: 1000000000000000000}()
    │   │   ├─ [771] ContractWallet::executeTransaction(1)
    │   │   │   └─ ← [Revert] transactionAlreadyExecuted()
    │   │   └─ ← [Revert] transactionAlreadyExecuted()
    │   └─ ← [Revert] revert: Transaction failed
    └─ ← [Stop] 

[PASS] test_transfer() (gas: 198135)
Logs:
  success:  true

Traces:
  [198135] ContractWallet_Test::test_transfer()
    ├─ [0] VM::prank(signer1: [0x7C8913d493892928d19F932FB1893404b6f1cE73])
    │   └─ ← [Return] 
    ├─ [97602] ContractWallet::proposeTransaction(banker: [0xa445713A666127Ea1CA5940DB7C5AD378a01CFeb], 10000000000000000000 [1e19], 0x)
    │   ├─ emit TransactionProposed(nonce: 1, _to: banker: [0xa445713A666127Ea1CA5940DB7C5AD378a01CFeb], value: 10000000000000000000 [1e19], _data: 0x)
    │   └─ ← [Return] 1
    ├─ [0] VM::prank(signer2: [0x11A5669986B1fCBfcE54be4c543975b33D89856D])
    │   └─ ← [Return] 
    ├─ [2828] ContractWallet::confirm(1)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(signer3: [0xA40fa48886D3D845ac4Bba792E694A936a3AfC00])
    │   └─ ← [Return] 
    ├─ [55] ContractWallet::receive{value: 10000000000000000000}()
    │   └─ ← [Stop] 
    ├─ [0] console::log("success: ", true) [staticcall]
    │   └─ ← [Stop] 
    ├─ [59670] ContractWallet::executeTransaction(1)
    │   ├─ [0] banker::fallback{value: 10000000000000000000}()
    │   │   └─ ← [Stop] 
    │   ├─ emit TransactionExecuted(nonce: 1)
    │   └─ ← [Stop] 
    ├─ [0] VM::assertEq(100000000000000000000 [1e20], 100000000000000000000 [1e20], "signer1 balance error") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(100000000000000000000 [1e20], 100000000000000000000 [1e20], "signer2 balance error") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(90000000000000000000 [9e19], 90000000000000000000 [9e19], "signer3 balance error") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(10000000000000000000 [1e19], 10000000000000000000 [1e19], "banker balance error") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 17.35ms (4.81ms CPU time)

Ran 1 test suite in 1.56s (17.35ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)
