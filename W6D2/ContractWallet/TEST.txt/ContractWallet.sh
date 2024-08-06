No files changed, compilation skipped

Ran 4 tests for test/ContractWallet_Test.sol:ContractWallet_Test
[PASS] test_ReentrantAttack() (gas: 271973)
Logs:
  success:  true

Traces:
  [271973] ContractWallet_Test::test_ReentrantAttack()
    ├─ [79654] → new Attacker@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   └─ ← [Return] 286 bytes of code
    ├─ [0] VM::prank(signer1: [0x7C8913d493892928d19F932FB1893404b6f1cE73])
    │   └─ ← [Return] 
    ├─ [97624] ContractWallet::proposeTransaction(Attacker: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000 [1e18], 0x)
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
    ├─ [32548] ContractWallet::executeTransaction(1)
    │   ├─ [1334] Attacker::receive{value: 1000000000000000000}()
    │   │   ├─ [793] ContractWallet::executeTransaction(1)
    │   │   │   └─ ← [Revert] transactionAlreadyExecuted()
    │   │   └─ ← [Revert] transactionAlreadyExecuted()
    │   └─ ← [Revert] revert: Transaction failed
    └─ ← [Stop] 

[PASS] test_changeSigner() (gas: 241789)
Traces:
  [241789] ContractWallet_Test::test_changeSigner()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6]
    ├─ [0] VM::label(signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6], "signer4")
    │   └─ ← [Return] 
    ├─ [0] VM::prank(signer1: [0x7C8913d493892928d19F932FB1893404b6f1cE73])
    │   └─ ← [Return] 
    ├─ [165200] ContractWallet::proposeTransaction(ContractWallet: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 0, 0x15e6b022000000000000000000000000a40fa48886d3d845ac4bba792e694a936a3afc000000000000000000000000007d8c899522bbd487369a1e724ffc4581a6b473e6)
    │   ├─ emit TransactionProposed(nonce: 1, _to: ContractWallet: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], value: 0, _data: 0x15e6b022000000000000000000000000a40fa48886d3d845ac4bba792e694a936a3afc000000000000000000000000007d8c899522bbd487369a1e724ffc4581a6b473e6)
    │   └─ ← [Return] 1
    ├─ [0] VM::prank(signer2: [0x11A5669986B1fCBfcE54be4c543975b33D89856D])
    │   └─ ← [Return] 
    ├─ [2828] ContractWallet::confirm(1)
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(signer3: [0xA40fa48886D3D845ac4Bba792E694A936a3AfC00])
    │   └─ ← [Return] 
    ├─ [55953] ContractWallet::executeTransaction(1)
    │   ├─ [29710] ContractWallet::changeSigner(signer3: [0xA40fa48886D3D845ac4Bba792E694A936a3AfC00], signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6])
    │   │   ├─ emit SignerChanged(_oldSigner: signer3: [0xA40fa48886D3D845ac4Bba792E694A936a3AfC00], _newSigner: signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6])
    │   │   └─ ← [Stop] 
    │   ├─ emit TransactionExecuted(nonce: 1)
    │   └─ ← [Stop] 
    ├─ [598] ContractWallet::signers(signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6]) [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::assertEq(true, true, "signer4 not in signers") [staticcall]
    │   └─ ← [Return] 
    ├─ [598] ContractWallet::signers(signer3: [0xA40fa48886D3D845ac4Bba792E694A936a3AfC00]) [staticcall]
    │   └─ ← [Return] false
    ├─ [0] VM::assertEq(false, false, "signer3 in signers") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_failChangeSigner() (gas: 14903)
Traces:
  [14903] ContractWallet_Test::test_failChangeSigner()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6]
    ├─ [0] VM::label(signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6], "signer4")
    │   └─ ← [Return] 
    ├─ [0] VM::expectRevert(custom error f4844814:)
    │   └─ ← [Return] 
    ├─ [0] VM::prank(signer1: [0x7C8913d493892928d19F932FB1893404b6f1cE73])
    │   └─ ← [Return] 
    ├─ [546] ContractWallet::changeSigner(signer3: [0xA40fa48886D3D845ac4Bba792E694A936a3AfC00], signer4: [0x7D8c899522BbD487369A1E724fFC4581a6b473E6])
    │   └─ ← [Revert] revert: Only executeTransaction function can change signer
    └─ ← [Stop] 

[PASS] test_transfer() (gas: 198201)
Logs:
  success:  true

Traces:
  [198201] ContractWallet_Test::test_transfer()
    ├─ [0] VM::prank(signer1: [0x7C8913d493892928d19F932FB1893404b6f1cE73])
    │   └─ ← [Return] 
    ├─ [97624] ContractWallet::proposeTransaction(banker: [0xa445713A666127Ea1CA5940DB7C5AD378a01CFeb], 10000000000000000000 [1e19], 0x)
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
    ├─ [59692] ContractWallet::executeTransaction(1)
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

Suite result: ok. 4 passed; 0 failed; 0 skipped; finished in 1.77ms (1.40ms CPU time)

Ran 1 test suite in 1.42s (1.77ms CPU time): 4 tests passed, 0 failed, 0 skipped (4 total tests)
