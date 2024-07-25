No files changed, compilation skipped

Ran 1 test for test/IDO_Reentrancy_refund_Test.sol:IDO_Reentrancy_refund_Test
[PASS] test_ReentrancyGuard_refund() (gas: 432748)
Traces:
  [432748] IDO_Reentrancy_refund_Test::test_ReentrancyGuard_refund()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 0: [0x82A978B3f5962A5b0957d9ee9eEf472EE55B42F1]
    ├─ [0] VM::label(0: [0x82A978B3f5962A5b0957d9ee9eEf472EE55B42F1], "0")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(0: [0x82A978B3f5962A5b0957d9ee9eEf472EE55B42F1], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(0: [0x82A978B3f5962A5b0957d9ee9eEf472EE55B42F1])
    │   └─ ← [Return] 
    ├─ [54360] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [2652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 0: [0x82A978B3f5962A5b0957d9ee9eEf472EE55B42F1], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 1: [0x7d577a597B2742b498Cb5Cf0C26cDCD726d39E6e]
    ├─ [0] VM::label(1: [0x7d577a597B2742b498Cb5Cf0C26cDCD726d39E6e], "1")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(1: [0x7d577a597B2742b498Cb5Cf0C26cDCD726d39E6e], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(1: [0x7d577a597B2742b498Cb5Cf0C26cDCD726d39E6e])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 1: [0x7d577a597B2742b498Cb5Cf0C26cDCD726d39E6e], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 2: [0xDCEceAF3fc5C0a63d195d69b1A90011B7B19650D]
    ├─ [0] VM::label(2: [0xDCEceAF3fc5C0a63d195d69b1A90011B7B19650D], "2")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(2: [0xDCEceAF3fc5C0a63d195d69b1A90011B7B19650D], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(2: [0xDCEceAF3fc5C0a63d195d69b1A90011B7B19650D])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 2: [0xDCEceAF3fc5C0a63d195d69b1A90011B7B19650D], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 3: [0x598443F1880Ef585B21f1d7585Bd0577402861E5]
    ├─ [0] VM::label(3: [0x598443F1880Ef585B21f1d7585Bd0577402861E5], "3")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(3: [0x598443F1880Ef585B21f1d7585Bd0577402861E5], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(3: [0x598443F1880Ef585B21f1d7585Bd0577402861E5])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 3: [0x598443F1880Ef585B21f1d7585Bd0577402861E5], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 4: [0x13cBB8D99C6C4e0f2728C7d72606e78A29C4E224]
    ├─ [0] VM::label(4: [0x13cBB8D99C6C4e0f2728C7d72606e78A29C4E224], "4")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(4: [0x13cBB8D99C6C4e0f2728C7d72606e78A29C4E224], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(4: [0x13cBB8D99C6C4e0f2728C7d72606e78A29C4E224])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 4: [0x13cBB8D99C6C4e0f2728C7d72606e78A29C4E224], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 5: [0x77dB2BEBBA79Db42a978F896968f4afCE746ea1F]
    ├─ [0] VM::label(5: [0x77dB2BEBBA79Db42a978F896968f4afCE746ea1F], "5")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(5: [0x77dB2BEBBA79Db42a978F896968f4afCE746ea1F], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(5: [0x77dB2BEBBA79Db42a978F896968f4afCE746ea1F])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 5: [0x77dB2BEBBA79Db42a978F896968f4afCE746ea1F], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 6: [0x24143873e0E0815fdCBcfFDbe09C979CbF9Ad013]
    ├─ [0] VM::label(6: [0x24143873e0E0815fdCBcfFDbe09C979CbF9Ad013], "6")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(6: [0x24143873e0E0815fdCBcfFDbe09C979CbF9Ad013], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(6: [0x24143873e0E0815fdCBcfFDbe09C979CbF9Ad013])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 6: [0x24143873e0E0815fdCBcfFDbe09C979CbF9Ad013], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 7: [0x10A1c1CB95c92EC31D3f22C66Eef1d9f3F258c6B]
    ├─ [0] VM::label(7: [0x10A1c1CB95c92EC31D3f22C66Eef1d9f3F258c6B], "7")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(7: [0x10A1c1CB95c92EC31D3f22C66Eef1d9f3F258c6B], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(7: [0x10A1c1CB95c92EC31D3f22C66Eef1d9f3F258c6B])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 7: [0x10A1c1CB95c92EC31D3f22C66Eef1d9f3F258c6B], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 8: [0xe0FC04FA2d34a66B779fd5CEe748268032a146c0]
    ├─ [0] VM::label(8: [0xe0FC04FA2d34a66B779fd5CEe748268032a146c0], "8")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(8: [0xe0FC04FA2d34a66B779fd5CEe748268032a146c0], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(8: [0xe0FC04FA2d34a66B779fd5CEe748268032a146c0])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 8: [0xe0FC04FA2d34a66B779fd5CEe748268032a146c0], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 9: [0x90F0B1EBbbA1C1936aFF7AAf20a7878FF9e04B6c]
    ├─ [0] VM::label(9: [0x90F0B1EBbbA1C1936aFF7AAf20a7878FF9e04B6c], "9")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(9: [0x90F0B1EBbbA1C1936aFF7AAf20a7878FF9e04B6c], 100000000000000000 [1e17])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(9: [0x90F0B1EBbbA1C1936aFF7AAf20a7878FF9e04B6c])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 100000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: 9: [0x90F0B1EBbbA1C1936aFF7AAf20a7878FF9e04B6c], amount: 100000000000000000 [1e17])
    │   └─ ← [Stop] 
    ├─ [374] RNTTokenIDO::totalETH() [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::deal(MaliciousActor: [0x959951c51b3e4B4eaa55a13D1d761e14Ad0A1d6a], 50000000000000000 [5e16])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(MaliciousActor: [0x959951c51b3e4B4eaa55a13D1d761e14Ad0A1d6a])
    │   └─ ← [Return] 
    ├─ [25960] RNTTokenIDO::presale{value: 50000000000000000}()
    │   ├─ [652] RNTToken::balanceOf(RNTTokenIDO: [0x1709316F4a8d1eb64D2464390A376A00dD7d2a57]) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ emit Presale(user: MaliciousActor: [0x959951c51b3e4B4eaa55a13D1d761e14Ad0A1d6a], amount: 50000000000000000 [5e16])
    │   └─ ← [Stop] 
    ├─ [207] RNTTokenIDO::END_TIME() [staticcall]
    │   └─ ← [Return] 604801 [6.048e5]
    ├─ [0] VM::warp(604802 [6.048e5])
    │   └─ ← [Return] 
    ├─ [0] VM::expectRevert(S3TokenIDO: refund failed)
    │   └─ ← [Return] 
    ├─ [0] VM::prank(MaliciousActor: [0x959951c51b3e4B4eaa55a13D1d761e14Ad0A1d6a])
    │   └─ ← [Return] 
    ├─ [15967] RNTTokenIDO::refund()
    │   ├─ [3124] MaliciousActor::receive{value: 50000000000000000}()
    │   │   ├─ [587] RNTTokenIDO::refund()
    │   │   │   └─ ← [Revert] ReentrancyGuardReentrantCall()
    │   │   └─ ← [Revert] ReentrancyGuardReentrantCall()
    │   └─ ← [Revert] revert: S3TokenIDO: refund failed
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 3.96ms (1.43ms CPU time)

Ran 1 test suite in 502.34ms (3.96ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
