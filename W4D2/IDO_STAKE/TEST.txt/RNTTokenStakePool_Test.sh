No files changed, compilation skipped

Ran 1 test for test/RNTTokenStakePool_Test.sol:RNTTokenStakePool_Test
[PASS] test_stake() (gas: 722652)
Traces:
  [726864] RNTTokenStakePool_Test::test_stake()
    ├─ [2652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::record()
    │   └─ ← [Return] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::accesses(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f])
    │   └─ ← [Return] [0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772], []
    ├─ [0] VM::load(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772) [staticcall]
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000000
    ├─ emit WARNING_UninitedSlot(who: RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], slot: 7271929705069915759578729239089391961554468801233137818181187173721979111282 [7.271e75])
    ├─ [0] VM::load(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772) [staticcall]
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000000
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::store(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
    │   └─ ← [Return] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 115792089237316195423570985008687907853269984665640564039457584007913129639935 [1.157e77]
    ├─ [0] VM::store(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772, 0x0000000000000000000000000000000000000000000000000000000000000000)
    │   └─ ← [Return] 
    ├─ emit SlotFound(who: RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], fsig: 0x70a0823100000000000000000000000000000000000000000000000000000000, keysHash: 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772, slot: 7271929705069915759578729239089391961554468801233137818181187173721979111282 [7.271e75])
    ├─ [0] VM::load(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772) [staticcall]
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000000
    ├─ [0] VM::store(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772, 0x0000000000000000000000000000000000000000000000000de0b6b3a7640000)
    │   └─ ← [Return] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [680] RNTToken::getDigest(0xc3349c38c41894a84ecb63e60f6a8815661f2bc050ab143c72b5ca08c56e257d) [staticcall]
    │   └─ ← [Return] 0x94fb400b431b68742aa15a6ef90f4c2716930fedaa6f14bab92259890ba2b36b
    ├─ [0] VM::sign("<pk>", 0x94fb400b431b68742aa15a6ef90f4c2716930fedaa6f14bab92259890ba2b36b) [staticcall]
    │   └─ ← [Return] 27, 0xda8e32f4be8173d670d7a06c559ffb6192b6a977c713c850ae0dd0673d7f2d97, 0x5cab353c76dc0662da3352f2154928359be64a61bcd57ea11b5cd24036680cdd
    ├─ [0] VM::prank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [110020] RNTTokenStakePool::stake(ERC20PermitData({ value: 1000000000000000000 [1e18], deadline: 601, v: 27, r: 0xda8e32f4be8173d670d7a06c559ffb6192b6a977c713c850ae0dd0673d7f2d97, s: 0x5cab353c76dc0662da3352f2154928359be64a61bcd57ea11b5cd24036680cdd }))
    │   ├─ [51485] RNTToken::permit(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], 1000000000000000000 [1e18], 601, 27, 0xda8e32f4be8173d670d7a06c559ffb6192b6a977c713c850ae0dd0673d7f2d97, 0x5cab353c76dc0662da3352f2154928359be64a61bcd57ea11b5cd24036680cdd)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x94fb400b431b68742aa15a6ef90f4c2716930fedaa6f14bab92259890ba2b36b, 27, 98855444959957518636072197266706511900770803311799886624434379297365551951255, 41915280340408154809300598626439098240298822583191993751283125383683480489181) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000008edc168c9bbb5ed126960e4a9f99b6c96ec76beb
    │   │   ├─ emit Approval(owner: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], spender: RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   ├─ [8945] RNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] true
    │   ├─ emit Skake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], amount: 1000000000000000000 [1e18])
    │   └─ ← [Stop] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [652] RNTToken::balanceOf(RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651]) [staticcall]
    │   └─ ← [Return] 1000001000000000000000000 [1e24]
    ├─ [0] VM::warp(86401 [8.64e4])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [220674] RNTTokenStakePool::claim()
    │   ├─ [25189] RNTToken::transfer(esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], to: esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] true
    │   ├─ [162425] esRNTToken::mintForStakeUser(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] 0
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], amount: 1000000000000000000 [1e18], esRNTLockInfoId: 0)
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000000
    ├─ [574] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [967] esRNTToken::lockInfos(0) [staticcall]
    │   └─ ← [Return] staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 1000000000000000000 [1e18], 86401 [8.64e4]
    ├─ [652] RNTToken::balanceOf(RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651]) [staticcall]
    │   └─ ← [Return] 1000000000000000000000000 [1e24]
    ├─ [652] RNTToken::balanceOf(esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::load(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772) [staticcall]
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000000
    ├─ [0] VM::store(RNTToken: [0xfF2A21441C4755bAa7bBE9fDB9422fcaAFAFF70f], 0x1013c42fe4e4fb3562fd31a547dac8856050d015b621b582f46a6ebd6fce4772, 0x0000000000000000000000000000000000000000000000000de0b6b3a7640000)
    │   └─ ← [Return] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [680] RNTToken::getDigest(0x2bf1259092820f735c559a38c3b7c71c1dec95573e37ddca781653a60f1a8277) [staticcall]
    │   └─ ← [Return] 0xddc7e40e2f98e406f1ebbeb09d1e5e922acb5a5481e8da4093b13b49d1868d50
    ├─ [0] VM::sign("<pk>", 0xddc7e40e2f98e406f1ebbeb09d1e5e922acb5a5481e8da4093b13b49d1868d50) [staticcall]
    │   └─ ← [Return] 27, 0x000f8a7972f17a0694dcbbb47326e61e669ccc993d69ee7cf2852c92da47520f, 0x585972cd5f0e1d5b158380a41260702844627663e7a6f73ead33646297fc76f1
    ├─ [0] VM::prank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [39179] RNTTokenStakePool::stake(ERC20PermitData({ value: 1000000000000000000 [1e18], deadline: 87001 [8.7e4], v: 27, r: 0x000f8a7972f17a0694dcbbb47326e61e669ccc993d69ee7cf2852c92da47520f, s: 0x585972cd5f0e1d5b158380a41260702844627663e7a6f73ead33646297fc76f1 }))
    │   ├─ [27485] RNTToken::permit(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], 1000000000000000000 [1e18], 87001 [8.7e4], 27, 0x000f8a7972f17a0694dcbbb47326e61e669ccc993d69ee7cf2852c92da47520f, 0x585972cd5f0e1d5b158380a41260702844627663e7a6f73ead33646297fc76f1)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0xddc7e40e2f98e406f1ebbeb09d1e5e922acb5a5481e8da4093b13b49d1868d50, 27, 27458421226018575522054053456565514277608815410896464434652800174271189519, 39961572399975793419748977370813286918864449706793178601249328295111124874993) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000008edc168c9bbb5ed126960e4a9f99b6c96ec76beb
    │   │   ├─ emit Approval(owner: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], spender: RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   ├─ [6945] RNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] true
    │   ├─ emit Skake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], amount: 1000000000000000000 [1e18])
    │   └─ ← [Stop] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [652] RNTToken::balanceOf(RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651]) [staticcall]
    │   └─ ← [Return] 1000001000000000000000000 [1e24]
    ├─ [0] VM::warp(172801 [1.728e5])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [98674] RNTTokenStakePool::claim()
    │   ├─ [3289] RNTToken::transfer(esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], 2000000000000000000 [2e18])
    │   │   ├─ emit Transfer(from: RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], to: esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], value: 2000000000000000000 [2e18])
    │   │   └─ ← [Return] true
    │   ├─ [70825] esRNTToken::mintForStakeUser(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 2000000000000000000 [2e18])
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 2000000000000000000 [2e18])
    │   │   └─ ← [Return] 1
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], amount: 2000000000000000000 [2e18], esRNTLockInfoId: 1)
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [574] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 3000000000000000000 [3e18]
    ├─ [967] esRNTToken::lockInfos(1) [staticcall]
    │   └─ ← [Return] staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 2000000000000000000 [2e18], 172801 [1.728e5]
    ├─ [652] RNTToken::balanceOf(RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651]) [staticcall]
    │   └─ ← [Return] 999999000000000000000000 [9.999e23]
    ├─ [652] RNTToken::balanceOf(esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0]) [staticcall]
    │   └─ ← [Return] 3000000000000000000 [3e18]
    ├─ [0] VM::prank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [28297] RNTTokenStakePool::unstake(2000000000000000000 [2e18])
    │   ├─ [652] RNTToken::balanceOf(RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651]) [staticcall]
    │   │   └─ ← [Return] 999999000000000000000000 [9.999e23]
    │   ├─ [23189] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 2000000000000000000 [2e18])
    │   │   ├─ emit Transfer(from: RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 2000000000000000000 [2e18])
    │   │   └─ ← [Return] true
    │   ├─ emit UnSkake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], amount: 2000000000000000000 [2e18])
    │   └─ ← [Stop] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 2000000000000000000 [2e18]
    ├─ [652] RNTToken::balanceOf(RNTTokenStakePool: [0x8B111e359886e000940d6850d77d1dE966C55651]) [staticcall]
    │   └─ ← [Return] 999997000000000000000000 [9.999e23]
    ├─ [0] VM::warp(1382401 [1.382e6])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [21014] esRNTToken::burn(0)
    │   ├─ [3289] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 500000000000000000 [5e17])
    │   │   ├─ emit Transfer(from: esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 500000000000000000 [5e17])
    │   │   └─ ← [Return] true
    │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: 0x0000000000000000000000000000000000000000, value: 1000000000000000000 [1e18])
    │   ├─ [7811] RNTToken::burn(500000000000000000 [5e17])
    │   │   ├─ emit Transfer(from: esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], to: 0x0000000000000000000000000000000000000000, value: 500000000000000000 [5e17])
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 2500000000000000000 [2.5e18]
    ├─ [652] RNTToken::balanceOf(esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0]) [staticcall]
    │   └─ ← [Return] 2000000000000000000 [2e18]
    ├─ [0] VM::warp(2764801 [2.764e6])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [12214] esRNTToken::burn(1)
    │   ├─ [3289] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 2000000000000000000 [2e18])
    │   │   ├─ emit Transfer(from: esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 2000000000000000000 [2e18])
    │   │   └─ ← [Return] true
    │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: 0x0000000000000000000000000000000000000000, value: 2000000000000000000 [2e18])
    │   ├─ [3011] RNTToken::burn(0)
    │   │   ├─ emit Transfer(from: esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0], to: 0x0000000000000000000000000000000000000000, value: 0)
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [652] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 4500000000000000000 [4.5e18]
    ├─ [652] RNTToken::balanceOf(esRNTToken: [0xe7081320a577e7a7E05E76C5675A01efA03cFfD0]) [staticcall]
    │   └─ ← [Return] 0
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 26.48ms (10.72ms CPU time)

Ran 1 test suite in 5.14s (26.48ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
