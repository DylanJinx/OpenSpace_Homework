No files changed, compilation skipped

Ran 6 tests for test/Dylan_NFTMarket_LS_WL_EPSign_Test.sol:Dylan_NFTMarket_LS_WL_EPSign_Test
[PASS] test_Fail2_Three_WLS_EP_LS() (gas: 278085)
Logs:
  Minted NFT with tokenId: 0

Traces:
  [4745195] Dylan_NFTMarket_LS_WL_EPSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d]
    ├─ [0] VM::label(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], "Fee_Collector")
    │   └─ ← [Return] 
    ├─ [1103832] → new DylanNFT@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [2447034] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [278085] Dylan_NFTMarket_LS_WL_EPSign_Test::test_Fail2_Three_WLS_EP_LS()
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [95542] DylanNFT::mintTo(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "https://ipfs.io/ipfs/CID1")
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    │   ├─ emit MetadataUpdate(_tokenId: 0)
    │   └─ ← [Return] 0
    ├─ [1787] DylanNFT::tokenURI(0) [staticcall]
    │   └─ ← [Return] "https://ipfs.io/ipfs/CID1"
    ├─ [0] VM::assertEq("https://ipfs.io/ipfs/CID1", "https://ipfs.io/ipfs/CID1", "URI does not match") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("Minted NFT with tokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::expectEmit(true, true, false, false)
    │   └─ ← [Return] 
    ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    ├─ [26724] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [218] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [658] MyToken::getDigest(0xc8a0653237abd5d9330d404af647be065853cb02ce54866dbd04616d1ac5174d) [staticcall]
    │   └─ ← [Return] 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716
    ├─ [0] VM::sign("<pk>", 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716) [staticcall]
    │   └─ ← [Return] 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1
    ├─ [262] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x552b4b16a45f58196e8f2fb958dab1f8fc941f4f3377a8ae80881d8a881e6aa3) [staticcall]
    │   └─ ← [Return] 27, 0xc0886174ce7eea867cd836d67f90758f6466b05c03153681b7988d372f877cb7, 0x4da8e11f77211adbad14eabc7eaa77287307d4356c6f7d37e1a42be93f68550d
    ├─ [0] VM::expectRevert(NoNeedWLSign_Or_ErrorSigner())
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [38038] Dylan_NFTMarket::buy(ERC20PermitData({ v: 27, r: 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, s: 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1, token: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, deadline: 86401 [8.64e4] }), 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c, SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: false }), signature: 0xc0886174ce7eea867cd836d67f90758f6466b05c03153681b7988d372f877cb74da8e11f77211adbad14eabc7eaa77287307d4356c6f7d37e1a42be93f68550d1b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151, 27, 87085030747293001255636732525115914400983596785025766580813741288950835150007, 35126473389026436311112547821668362837711686005234805751284823312025715758349) [staticcall]
    │   │   └─ ← [Return] 0x000000000000000000000000f248f591713656cdbc5033a2ebab5b29b0114818
    │   ├─ [3000] PRECOMPILES::ecrecover(0x552b4b16a45f58196e8f2fb958dab1f8fc941f4f3377a8ae80881d8a881e6aa3, 27, 87085030747293001255636732525115914400983596785025766580813741288950835150007, 35126473389026436311112547821668362837711686005234805751284823312025715758349) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   └─ ← [Revert] NoNeedWLSign_Or_ErrorSigner()
    └─ ← [Stop] 

[PASS] test_Fail_Three_WLS_EP_LS() (gas: 239490)
Logs:
  Minted NFT with tokenId: 0

Traces:
  [4745195] Dylan_NFTMarket_LS_WL_EPSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d]
    ├─ [0] VM::label(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], "Fee_Collector")
    │   └─ ← [Return] 
    ├─ [1103832] → new DylanNFT@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [2447034] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [239490] Dylan_NFTMarket_LS_WL_EPSign_Test::test_Fail_Three_WLS_EP_LS()
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [95542] DylanNFT::mintTo(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "https://ipfs.io/ipfs/CID1")
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    │   ├─ emit MetadataUpdate(_tokenId: 0)
    │   └─ ← [Return] 0
    ├─ [1787] DylanNFT::tokenURI(0) [staticcall]
    │   └─ ← [Return] "https://ipfs.io/ipfs/CID1"
    ├─ [0] VM::assertEq("https://ipfs.io/ipfs/CID1", "https://ipfs.io/ipfs/CID1", "URI does not match") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("Minted NFT with tokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [658] MyToken::getDigest(0xc8a0653237abd5d9330d404af647be065853cb02ce54866dbd04616d1ac5174d) [staticcall]
    │   └─ ← [Return] 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716
    ├─ [0] VM::sign("<pk>", 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716) [staticcall]
    │   └─ ← [Return] 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1
    ├─ [262] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151) [staticcall]
    │   └─ ← [Return] 27, 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b4, 0x4f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d7
    ├─ [0] VM::expectRevert(NeedWLSign_Or_ErrorSigner())
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [32886] Dylan_NFTMarket::buy(ERC20PermitData({ v: 27, r: 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, s: 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1, token: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, deadline: 86401 [8.64e4] }), SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true }), signature: 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b44f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d71b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151, 27, 69251576584519674624008183023994352775055758883845465775314070452624702521524, 35898104277986524958806657736115760689589181329630707483017797871153101926615) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   └─ ← [Revert] NeedWLSign_Or_ErrorSigner()
    └─ ← [Stop] 

[PASS] test_Success2_Three_WLS_EP_LS() (gas: 315945)
Logs:
  Minted NFT with tokenId: 0

Traces:
  [4745195] Dylan_NFTMarket_LS_WL_EPSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d]
    ├─ [0] VM::label(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], "Fee_Collector")
    │   └─ ← [Return] 
    ├─ [1103832] → new DylanNFT@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [2447034] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [316436] Dylan_NFTMarket_LS_WL_EPSign_Test::test_Success2_Three_WLS_EP_LS()
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [95542] DylanNFT::mintTo(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "https://ipfs.io/ipfs/CID1")
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    │   ├─ emit MetadataUpdate(_tokenId: 0)
    │   └─ ← [Return] 0
    ├─ [1787] DylanNFT::tokenURI(0) [staticcall]
    │   └─ ← [Return] "https://ipfs.io/ipfs/CID1"
    ├─ [0] VM::assertEq("https://ipfs.io/ipfs/CID1", "https://ipfs.io/ipfs/CID1", "URI does not match") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("Minted NFT with tokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::expectEmit(true, true, false, false)
    │   └─ ← [Return] 
    ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    ├─ [26724] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [658] MyToken::getDigest(0xc8a0653237abd5d9330d404af647be065853cb02ce54866dbd04616d1ac5174d) [staticcall]
    │   └─ ← [Return] 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716
    ├─ [0] VM::sign("<pk>", 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716) [staticcall]
    │   └─ ← [Return] 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1
    ├─ [262] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x552b4b16a45f58196e8f2fb958dab1f8fc941f4f3377a8ae80881d8a881e6aa3) [staticcall]
    │   └─ ← [Return] 27, 0xc0886174ce7eea867cd836d67f90758f6466b05c03153681b7988d372f877cb7, 0x4da8e11f77211adbad14eabc7eaa77287307d4356c6f7d37e1a42be93f68550d
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [153742] Dylan_NFTMarket::buy(ERC20PermitData({ v: 27, r: 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, s: 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1, token: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, deadline: 86401 [8.64e4] }), SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: false }), signature: 0xc0886174ce7eea867cd836d67f90758f6466b05c03153681b7988d372f877cb74da8e11f77211adbad14eabc7eaa77287307d4356c6f7d37e1a42be93f68550d1b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151, 27, 87085030747293001255636732525115914400983596785025766580813741288950835150007, 35126473389026436311112547821668362837711686005234805751284823312025715758349) [staticcall]
    │   │   └─ ← [Return] 0x000000000000000000000000f248f591713656cdbc5033a2ebab5b29b0114818
    │   ├─ [3000] PRECOMPILES::ecrecover(0x552b4b16a45f58196e8f2fb958dab1f8fc941f4f3377a8ae80881d8a881e6aa3, 27, 87085030747293001255636732525115914400983596785025766580813741288950835150007, 35126473389026436311112547821668362837711686005234805751284823312025715758349) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [51440] MyToken::permit(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 1000000000000000000 [1e18], 86401 [8.64e4], 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716, 27, 106141509730075568405338763729347599466261385789082691839603613086241232800796, 32400532950634028244052719966727517445262485272834071475521744953200157505441) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000004cec381c3bee40863f07d7d011715c1cc4a8334b
    │   │   ├─ emit Approval(owner: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], spender: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   ├─ [31701] DylanNFT::safeTransferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 0)
    │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], tokenId: 0)
    │   │   └─ ← [Stop] 
    │   ├─ [26022] MyToken::transferFrom(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ emit Purchased(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], buyer: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], price: 1000000000000000000 [1e18])
    │   └─ ← [Stop] 
    ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::assertEq(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "NFT was not transferred to the buyer") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] MyToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Seller did not receive the tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0, "Buyer still has tokens") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_Success_Three_WLS_EP_LS() (gas: 319930)
Logs:
  Minted NFT with tokenId: 0

Traces:
  [4745195] Dylan_NFTMarket_LS_WL_EPSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d]
    ├─ [0] VM::label(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], "Fee_Collector")
    │   └─ ← [Return] 
    ├─ [1103832] → new DylanNFT@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [2447034] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [319930] Dylan_NFTMarket_LS_WL_EPSign_Test::test_Success_Three_WLS_EP_LS()
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [95542] DylanNFT::mintTo(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "https://ipfs.io/ipfs/CID1")
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    │   ├─ emit MetadataUpdate(_tokenId: 0)
    │   └─ ← [Return] 0
    ├─ [1787] DylanNFT::tokenURI(0) [staticcall]
    │   └─ ← [Return] "https://ipfs.io/ipfs/CID1"
    ├─ [0] VM::assertEq("https://ipfs.io/ipfs/CID1", "https://ipfs.io/ipfs/CID1", "URI does not match") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("Minted NFT with tokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::expectEmit(true, true, false, false)
    │   └─ ← [Return] 
    ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    ├─ [26724] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [218] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [658] MyToken::getDigest(0xc8a0653237abd5d9330d404af647be065853cb02ce54866dbd04616d1ac5174d) [staticcall]
    │   └─ ← [Return] 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716
    ├─ [0] VM::sign("<pk>", 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716) [staticcall]
    │   └─ ← [Return] 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1
    ├─ [262] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151) [staticcall]
    │   └─ ← [Return] 27, 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b4, 0x4f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d7
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [153916] Dylan_NFTMarket::buy(ERC20PermitData({ v: 27, r: 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, s: 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1, token: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, deadline: 86401 [8.64e4] }), 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c, SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true }), signature: 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b44f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d71b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151, 27, 69251576584519674624008183023994352775055758883845465775314070452624702521524, 35898104277986524958806657736115760689589181329630707483017797871153101926615) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [3000] PRECOMPILES::ecrecover(0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8, 28, 77327711547795738446774952212674510112625498571600421431494765474987054172921, 23494732082952029213201977883842836417352024657625653097996404414735999444163) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [51440] MyToken::permit(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 1000000000000000000 [1e18], 86401 [8.64e4], 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716, 27, 106141509730075568405338763729347599466261385789082691839603613086241232800796, 32400532950634028244052719966727517445262485272834071475521744953200157505441) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000004cec381c3bee40863f07d7d011715c1cc4a8334b
    │   │   ├─ emit Approval(owner: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], spender: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   ├─ [31701] DylanNFT::safeTransferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 0)
    │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], tokenId: 0)
    │   │   └─ ← [Stop] 
    │   ├─ [26022] MyToken::transferFrom(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ emit Purchased(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], buyer: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], price: 1000000000000000000 [1e18])
    │   └─ ← [Stop] 
    ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::assertEq(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "NFT was not transferred to the buyer") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] MyToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Seller did not receive the tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0, "Buyer still has tokens") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_Success_Three_WLS_EP_LS_fee() (gas: 376096)
Logs:
  Minted NFT with tokenId: 0

Traces:
  [4745195] Dylan_NFTMarket_LS_WL_EPSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d]
    ├─ [0] VM::label(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], "Fee_Collector")
    │   └─ ← [Return] 
    ├─ [1103832] → new DylanNFT@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [2447034] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [376096] Dylan_NFTMarket_LS_WL_EPSign_Test::test_Success_Three_WLS_EP_LS_fee()
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [95542] DylanNFT::mintTo(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "https://ipfs.io/ipfs/CID1")
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    │   ├─ emit MetadataUpdate(_tokenId: 0)
    │   └─ ← [Return] 0
    ├─ [1787] DylanNFT::tokenURI(0) [staticcall]
    │   └─ ← [Return] "https://ipfs.io/ipfs/CID1"
    ├─ [0] VM::assertEq("https://ipfs.io/ipfs/CID1", "https://ipfs.io/ipfs/CID1", "URI does not match") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("Minted NFT with tokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::expectEmit(true, false, false, false)
    │   └─ ← [Return] 
    ├─ emit FeeToChanged(feeTo: Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d])
    ├─ [26028] Dylan_NFTMarket::setFeeTo(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d])
    │   ├─ emit FeeToChanged(feeTo: Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d])
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, false)
    │   └─ ← [Return] 
    ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    ├─ [24724] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [241] Dylan_NFTMarket::feeBP() [staticcall]
    │   └─ ← [Return] 30
    ├─ [218] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [658] MyToken::getDigest(0xc8a0653237abd5d9330d404af647be065853cb02ce54866dbd04616d1ac5174d) [staticcall]
    │   └─ ← [Return] 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716
    ├─ [0] VM::sign("<pk>", 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716) [staticcall]
    │   └─ ← [Return] 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1
    ├─ [262] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151) [staticcall]
    │   └─ ← [Return] 27, 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b4, 0x4f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d7
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [178671] Dylan_NFTMarket::buy(ERC20PermitData({ v: 27, r: 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, s: 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1, token: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, deadline: 86401 [8.64e4] }), 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c, SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true }), signature: 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b44f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d71b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151, 27, 69251576584519674624008183023994352775055758883845465775314070452624702521524, 35898104277986524958806657736115760689589181329630707483017797871153101926615) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [3000] PRECOMPILES::ecrecover(0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8, 28, 77327711547795738446774952212674510112625498571600421431494765474987054172921, 23494732082952029213201977883842836417352024657625653097996404414735999444163) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [51440] MyToken::permit(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 1000000000000000000 [1e18], 86401 [8.64e4], 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716, 27, 106141509730075568405338763729347599466261385789082691839603613086241232800796, 32400532950634028244052719966727517445262485272834071475521744953200157505441) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000004cec381c3bee40863f07d7d011715c1cc4a8334b
    │   │   ├─ emit Approval(owner: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], spender: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   ├─ [31701] DylanNFT::safeTransferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 0)
    │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], tokenId: 0)
    │   │   └─ ← [Stop] 
    │   ├─ [26022] MyToken::transferFrom(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 997000000000000000 [9.97e17])
    │   │   ├─ emit Transfer(from: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 997000000000000000 [9.97e17])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ [26022] MyToken::transferFrom(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], 3000000000000000 [3e15])
    │   │   ├─ emit Transfer(from: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], to: Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], value: 3000000000000000 [3e15])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ emit Purchased(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], buyer: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], price: 1000000000000000000 [1e18])
    │   └─ ← [Stop] 
    ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::assertEq(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "NFT was not transferred to the buyer") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] MyToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 997000000000000000 [9.97e17]
    ├─ [0] VM::assertEq(997000000000000000 [9.97e17], 997000000000000000 [9.97e17], "Seller did not receive the tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0, "Buyer still has tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] MyToken::balanceOf(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d]) [staticcall]
    │   └─ ← [Return] 3000000000000000 [3e15]
    ├─ [0] VM::assertEq(3000000000000000 [3e15], 3000000000000000 [3e15], "Fee_Collector did not receive the tokens") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_fail3_Three_WLS_EP_LS() (gas: 298559)
Logs:
  Minted NFT with tokenId: 0
  ListSignButCancel true

Traces:
  [4745195] Dylan_NFTMarket_LS_WL_EPSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d]
    ├─ [0] VM::label(Fee_Collector: [0xCe68C7bFC876e923931589D76c4646f28caEDd4d], "Fee_Collector")
    │   └─ ← [Return] 
    ├─ [1103832] → new DylanNFT@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [2447034] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [298559] Dylan_NFTMarket_LS_WL_EPSign_Test::test_fail3_Three_WLS_EP_LS()
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [95542] DylanNFT::mintTo(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "https://ipfs.io/ipfs/CID1")
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 0)
    │   ├─ emit MetadataUpdate(_tokenId: 0)
    │   └─ ← [Return] 0
    ├─ [1787] DylanNFT::tokenURI(0) [staticcall]
    │   └─ ← [Return] "https://ipfs.io/ipfs/CID1"
    ├─ [0] VM::assertEq("https://ipfs.io/ipfs/CID1", "https://ipfs.io/ipfs/CID1", "URI does not match") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("Minted NFT with tokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_LS_WL_EPSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::expectEmit(true, true, false, false)
    │   └─ ← [Return] 
    ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    ├─ [26724] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [218] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [658] MyToken::getDigest(0xc8a0653237abd5d9330d404af647be065853cb02ce54866dbd04616d1ac5174d) [staticcall]
    │   └─ ← [Return] 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716
    ├─ [0] VM::sign("<pk>", 0x151b15b8617aebb78348a3096cd1c632e83dc0c835e2d1a0077cfb69455a2716) [staticcall]
    │   └─ ← [Return] 27, 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1
    ├─ [262] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151) [staticcall]
    │   └─ ← [Return] 27, 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b4, 0x4f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d7
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [52866] Dylan_NFTMarket::ListSignCancel(SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true }), signature: 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b44f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d71b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151, 27, 69251576584519674624008183023994352775055758883845465775314070452624702521524, 35898104277986524958806657736115760689589181329630707483017797871153101926615) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   └─ ← [Stop] 
    ├─ [943] Dylan_NFTMarket::ListSignButCancel(0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b44f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d71b) [staticcall]
    │   └─ ← [Return] true
    ├─ [0] console::log("ListSignButCancel", true) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::expectRevert(Order_Already_Canceled())
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [1336] Dylan_NFTMarket::buy(ERC20PermitData({ v: 27, r: 0xeaa9f72f5727c8f1a1616abe8eb642fc2e2d46098488a1c484555d9533484c1c, s: 0x47a20d410f77d17c52173815b786fd081d19b066a3dce1955fd2b6ca4a11b7a1, token: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, deadline: 86401 [8.64e4] }), 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c, SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true }), signature: 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b44f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d71b }))
    │   └─ ← [Revert] Order_Already_Canceled()
    └─ ← [Stop] 

Suite result: ok. 6 passed; 0 failed; 0 skipped; finished in 4.34ms (10.61ms CPU time)

Ran 1 test suite in 2.28s (4.34ms CPU time): 6 tests passed, 0 failed, 0 skipped (6 total tests)
