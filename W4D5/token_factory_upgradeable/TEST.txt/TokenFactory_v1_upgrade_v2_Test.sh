Compiling 1 files with Solc 0.8.26
Solc 0.8.26 finished in 2.96s
Compiler run successful!

Ran 1 test for test/TokenFactory_v1_upgrade_v2_Test.sol:TokenFactory_v1_upgrade_v2_Test
[PASS] test_factory_v1_upgrade_v2() (gas: 3802763)
Logs:
  proxy admin:  0x8941466ab31c126136b09195c4764c56463Ca42c
  implementation_factory_v1_contract address:  0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  factoryProxy address:  0xca25E8B12Cca387184bb75Ad193A2cA533baa6d6
  implementation_factory_v2_contract address:  0x2e234DAe75C793f67A35089C9d99245E1C58470b

Traces:
  [1886164] TokenFactory_v1_upgrade_v2_Test::setUp()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602]
    ├─ [0] VM::label(tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602], "tokenCreator_1")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] tokenCreator_2: [0x949a4fE930Fd2eD1CBf316c08086B3541ef009F6]
    ├─ [0] VM::label(tokenCreator_2: [0x949a4fE930Fd2eD1CBf316c08086B3541ef009F6], "tokenCreator_2")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6]
    ├─ [0] VM::label(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], "tokenBuyer_1")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] factoryProxyAdmin: [0x8941466ab31c126136b09195c4764c56463Ca42c]
    ├─ [0] VM::label(factoryProxyAdmin: [0x8941466ab31c126136b09195c4764c56463Ca42c], "factoryProxyAdmin")
    │   └─ ← [Return] 
    ├─ [0] console::log("proxy admin: ", factoryProxyAdmin: [0x8941466ab31c126136b09195c4764c56463Ca42c]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1475893] → new TokenFactory_v1@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Initialized(version: 18446744073709551615 [1.844e19])
    │   └─ ← [Return] 7254 bytes of code
    ├─ [0] console::log("implementation_factory_v1_contract address: ", TokenFactory_v1: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(factoryProxyAdmin: [0x8941466ab31c126136b09195c4764c56463Ca42c])
    │   └─ ← [Return] 
    ├─ [107806] → new ERC1967Proxy@0xca25E8B12Cca387184bb75Ad193A2cA533baa6d6
    │   ├─ emit Upgraded(implementation: TokenFactory_v1: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ [48637] TokenFactory_v1::initialize(factoryProxyAdmin: [0x8941466ab31c126136b09195c4764c56463Ca42c]) [delegatecall]
    │   │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: factoryProxyAdmin: [0x8941466ab31c126136b09195c4764c56463Ca42c])
    │   │   ├─ emit Initialized(version: 1)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 170 bytes of code
    ├─ [0] console::log("factoryProxy address: ", ERC1967Proxy: [0xca25E8B12Cca387184bb75Ad193A2cA533baa6d6]) [staticcall]
    │   └─ ← [Stop] 
    └─ ← [Stop] 

  [3802763] TokenFactory_v1_upgrade_v2_Test::test_factory_v1_upgrade_v2()
    ├─ [0] VM::prank(tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602])
    │   └─ ← [Return] 
    ├─ [689176] ERC1967Proxy::deployInscription("token_1", 10000 [1e4], 1000)
    │   ├─ [684262] TokenFactory_v1::deployInscription("token_1", 10000 [1e4], 1000) [delegatecall]
    │   │   ├─ [581073] → new DylanToken_v1@0x5d1b1941f3036B4c3c564f1520E544763C8469b2
    │   │   │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: ERC1967Proxy: [0xca25E8B12Cca387184bb75Ad193A2cA533baa6d6])
    │   │   │   └─ ← [Return] 2555 bytes of code
    │   │   ├─ emit NewDeployInscription(_tokenAddr: DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2], _creator: tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602], symbol: "token_1")
    │   │   └─ ← [Return] DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2]
    │   └─ ← [Return] DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2]
    ├─ [1017] ERC1967Proxy::tokenCreators(DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2]) [staticcall]
    │   ├─ [624] TokenFactory_v1::tokenCreators(DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2]) [delegatecall]
    │   │   └─ ← [Return] tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602]
    │   └─ ← [Return] tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602]
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2], _perMint: 1000)
    ├─ [0] VM::prank(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   └─ ← [Return] 
    ├─ [73626] ERC1967Proxy::mintInscription(DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2])
    │   ├─ [73236] TokenFactory_v1::mintInscription(DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2]) [delegatecall]
    │   │   ├─ [47172] DylanToken_v1::mint(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], value: 1000)
    │   │   │   └─ ← [Stop] 
    │   │   ├─ [237] DylanToken_v1::getPerMint() [staticcall]
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ [237] DylanToken_v1::getPerMint() [staticcall]
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2], _perMint: 1000)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [585] DylanToken_v1::balanceOf(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6]) [staticcall]
    │   └─ ← [Return] 1000
    ├─ [0] VM::prank(tokenCreator_2: [0x949a4fE930Fd2eD1CBf316c08086B3541ef009F6])
    │   └─ ← [Return] 
    ├─ [684676] ERC1967Proxy::deployInscription("token_2", 10000 [1e4], 1000)
    │   ├─ [684262] TokenFactory_v1::deployInscription("token_2", 10000 [1e4], 1000) [delegatecall]
    │   │   ├─ [581073] → new DylanToken_v1@0x37DA06dd32532a57F508a0B608f0a8541FD91178
    │   │   │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: ERC1967Proxy: [0xca25E8B12Cca387184bb75Ad193A2cA533baa6d6])
    │   │   │   └─ ← [Return] 2555 bytes of code
    │   │   ├─ emit NewDeployInscription(_tokenAddr: DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178], _creator: tokenCreator_2: [0x949a4fE930Fd2eD1CBf316c08086B3541ef009F6], symbol: "token_2")
    │   │   └─ ← [Return] DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178]
    │   └─ ← [Return] DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178]
    ├─ [1017] ERC1967Proxy::tokenCreators(DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178]) [staticcall]
    │   ├─ [624] TokenFactory_v1::tokenCreators(DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178]) [delegatecall]
    │   │   └─ ← [Return] tokenCreator_2: [0x949a4fE930Fd2eD1CBf316c08086B3541ef009F6]
    │   └─ ← [Return] tokenCreator_2: [0x949a4fE930Fd2eD1CBf316c08086B3541ef009F6]
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178], _perMint: 1000)
    ├─ [0] VM::prank(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   └─ ← [Return] 
    ├─ [73626] ERC1967Proxy::mintInscription(DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178])
    │   ├─ [73236] TokenFactory_v1::mintInscription(DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178]) [delegatecall]
    │   │   ├─ [47172] DylanToken_v1::mint(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], value: 1000)
    │   │   │   └─ ← [Stop] 
    │   │   ├─ [237] DylanToken_v1::getPerMint() [staticcall]
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ [237] DylanToken_v1::getPerMint() [staticcall]
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: DylanToken_v1: [0x37DA06dd32532a57F508a0B608f0a8541FD91178], _perMint: 1000)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [585] DylanToken_v1::balanceOf(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6]) [staticcall]
    │   └─ ← [Return] 1000
    ├─ [938128] → new TokenFactory_v2@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit Initialized(version: 18446744073709551615 [1.844e19])
    │   └─ ← [Return] 4568 bytes of code
    ├─ [0] console::log("implementation_factory_v2_contract address: ", TokenFactory_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [789123] → new DylanToken_v2@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit Initialized(version: 18446744073709551615 [1.844e19])
    │   └─ ← [Return] 3824 bytes of code
    ├─ [0] VM::prank(factoryProxyAdmin: [0x8941466ab31c126136b09195c4764c56463Ca42c])
    │   └─ ← [Return] 
    ├─ [32414] ERC1967Proxy::upgradeToAndCall(TokenFactory_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0x3cf38994000000000000000000000000f62849f9a0b5bf2913b396098f7c7019b51a820a)
    │   ├─ [32003] TokenFactory_v1::upgradeToAndCall(TokenFactory_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0x3cf38994000000000000000000000000f62849f9a0b5bf2913b396098f7c7019b51a820a) [delegatecall]
    │   │   ├─ [343] TokenFactory_v2::proxiableUUID() [staticcall]
    │   │   │   └─ ← [Return] 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
    │   │   ├─ emit Upgraded(implementation: TokenFactory_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b])
    │   │   ├─ [22714] TokenFactory_v2::setERC20ImplementationAddress(DylanToken_v2: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a]) [delegatecall]
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [0] VM::deal(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], 1000000000000000000 [1e18])
    │   └─ ← [Return] 
    ├─ [0] VM::prank(tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602])
    │   └─ ← [Return] 
    ├─ [251575] ERC1967Proxy::deployInscription("token_3", 10000 [1e4], 1000, 1000000000000000 [1e15])
    │   ├─ [251155] TokenFactory_v2::deployInscription("token_3", 10000 [1e4], 1000, 1000000000000000 [1e15]) [delegatecall]
    │   │   ├─ [9031] → new <unknown>@0xA01078248C6746b41D8A97aCb8496DcDcCc34a56
    │   │   │   └─ ← [Return] 45 bytes of code
    │   │   ├─ [138585] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56::initialize("token_3", 10000 [1e4], 1000)
    │   │   │   ├─ [138392] DylanToken_v2::initialize("token_3", 10000 [1e4], 1000) [delegatecall]
    │   │   │   │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: ERC1967Proxy: [0xca25E8B12Cca387184bb75Ad193A2cA533baa6d6])
    │   │   │   │   ├─ emit Initialized(version: 1)
    │   │   │   │   └─ ← [Stop] 
    │   │   │   └─ ← [Return] 
    │   │   ├─ emit NewDeployInscription(_tokenAddr: 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56, _creator: tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602], symbol: "token_3", price: 1000000000000000 [1e15])
    │   │   └─ ← [Return] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56
    │   └─ ← [Return] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56
    ├─ [1017] ERC1967Proxy::tokenCreators(0xA01078248C6746b41D8A97aCb8496DcDcCc34a56) [staticcall]
    │   ├─ [624] TokenFactory_v2::tokenCreators(0xA01078248C6746b41D8A97aCb8496DcDcCc34a56) [delegatecall]
    │   │   └─ ← [Return] tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602]
    │   └─ ← [Return] tokenCreator_1: [0xC66CCFbcE7Fc39E1bC7c512637D06a9AF1Fd5602]
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56, _perMint: 1000)
    ├─ [0] VM::prank(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   └─ ← [Return] 
    ├─ [110431] ERC1967Proxy::mintInscription{value: 1000000000000000000}(0xA01078248C6746b41D8A97aCb8496DcDcCc34a56)
    │   ├─ [110041] TokenFactory_v2::mintInscription{value: 1000000000000000000}(0xA01078248C6746b41D8A97aCb8496DcDcCc34a56) [delegatecall]
    │   │   ├─ [503] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56::getPerMint() [staticcall]
    │   │   │   ├─ [337] DylanToken_v2::getPerMint() [delegatecall]
    │   │   │   │   └─ ← [Return] 1000
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ [0] tokenCreator_1::fallback{value: 1000000000000000000}()
    │   │   │   └─ ← [Stop] 
    │   │   ├─ [47703] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56::mint(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   │   │   ├─ [47534] DylanToken_v2::mint(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6]) [delegatecall]
    │   │   │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], value: 1000)
    │   │   │   │   └─ ← [Stop] 
    │   │   │   └─ ← [Return] 
    │   │   ├─ [503] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56::getPerMint() [staticcall]
    │   │   │   ├─ [337] DylanToken_v2::getPerMint() [delegatecall]
    │   │   │   │   └─ ← [Return] 1000
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ [503] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56::getPerMint() [staticcall]
    │   │   │   ├─ [337] DylanToken_v2::getPerMint() [delegatecall]
    │   │   │   │   └─ ← [Return] 1000
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56, _perMint: 1000)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [787] 0xA01078248C6746b41D8A97aCb8496DcDcCc34a56::balanceOf(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6]) [staticcall]
    │   ├─ [615] DylanToken_v2::balanceOf(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6]) [delegatecall]
    │   │   └─ ← [Return] 1000
    │   └─ ← [Return] 1000
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2], _perMint: 1000)
    ├─ [0] VM::prank(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   └─ ← [Return] 
    ├─ [11202] ERC1967Proxy::mintInscription(DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2])
    │   ├─ [10812] TokenFactory_v2::mintInscription(DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2]) [delegatecall]
    │   │   ├─ [237] DylanToken_v1::getPerMint() [staticcall]
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ [0] tokenCreator_1::fallback()
    │   │   │   └─ ← [Stop] 
    │   │   ├─ [3372] DylanToken_v1::mint(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6])
    │   │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], value: 1000)
    │   │   │   └─ ← [Stop] 
    │   │   ├─ [237] DylanToken_v1::getPerMint() [staticcall]
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ [237] DylanToken_v1::getPerMint() [staticcall]
    │   │   │   └─ ← [Return] 1000
    │   │   ├─ emit MintInscription(_to: tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6], _tokenAddr: DylanToken_v1: [0x5d1b1941f3036B4c3c564f1520E544763C8469b2], _perMint: 1000)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [585] DylanToken_v1::balanceOf(tokenBuyer_1: [0xB87472DAe577418b2846a0824cE7aeC32376c1f6]) [staticcall]
    │   └─ ← [Return] 2000
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 3.35ms (1.03ms CPU time)

Ran 1 test suite in 305.39s (3.35ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
