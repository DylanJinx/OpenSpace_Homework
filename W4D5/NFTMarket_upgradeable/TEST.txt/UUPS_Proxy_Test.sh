No files changed, compilation skipped

Ran 1 test for test/NFTMarket_v2.sol:UUPS_Proxy_Test
[PASS] test_NFTMarket_v2() (gas: 262626)
Logs:
  Minted NFT with tokenId: 0

Traces:
  [3499365] UUPS_Proxy_Test::setUp()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [1102785] → new DylanNFT@0x8bb37534DB815Ad26e6FC565244D5eF8895656DD
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [904070] → new DylanToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [1181484] → new NFTMarket_v2@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   └─ ← [Return] 5884 bytes of code
    ├─ [67231] NFTMarket_v2::initialize(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    └─ ← [Stop] 

  [262626] UUPS_Proxy_Test::test_NFTMarket_v2()
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
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [24581] DylanNFT::setApprovalForAll(NFTMarket_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], true)
    │   ├─ emit ApprovalForAll(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], operator: NFTMarket_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], approved: true)
    │   └─ ← [Stop] 
    ├─ [251] NFTMarket_v2::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xc895c5f758f496a5ba68797e8c9b666b5e546e7d65b358d335b34c139e2dc875
    ├─ [396] NFTMarket_v2::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0xa0b4126cdc590c69ca5ee224c04d7c1cf6906946e53a4ef8437b45711d632128
    ├─ [0] VM::sign("<pk>", 0x3d0c8c2c977f5f8bf6d95e509da9d252ed5fcadaab5859217ff54c921264579e) [staticcall]
    │   └─ ← [Return] 27, 0x0d6d5928a0e5d42595428d3a3351bdba73bf30fcb833d511e63aed063acc34ec, 0x3e71a022109bdfe490296aaea91de6c2addec7fd337690e623de769151964447
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] DylanToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] DylanToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [24762] DylanToken::approve(NFTMarket_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 1000000000000000000 [1e18])
    │   ├─ emit Approval(owner: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], spender: NFTMarket_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [97246] NFTMarket_v2::BuyWithLS(ListWithSignature({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, tokenId: 0, price: 1000000000000000000 [1e18], deadline: 86401 [8.64e4], signature: 0x0d6d5928a0e5d42595428d3a3351bdba73bf30fcb833d511e63aed063acc34ec3e71a022109bdfe490296aaea91de6c2addec7fd337690e623de7691519644471b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x3d0c8c2c977f5f8bf6d95e509da9d252ed5fcadaab5859217ff54c921264579e, 27, 6073268712410550696634246775785144956598664038554382020539695092377261454572, 28244155528285266431907766933840561809879083894496946025758993685235623150663) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [2844] DylanNFT::getApproved(0) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000
    │   ├─ [838] DylanNFT::isApprovedForAll(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], NFTMarket_v2: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   │   └─ ← [Return] true
    │   ├─ [26022] DylanToken::transferFrom(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] true
    │   ├─ [29502] DylanNFT::safeTransferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 0)
    │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], tokenId: 0)
    │   │   └─ ← [Stop] 
    │   ├─ emit Purchased(tokenId: 0, buyer: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], price: 1000000000000000000 [1e18])
    │   └─ ← [Stop] 
    ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::assertEq(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "NFT was not transferred") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] DylanToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [629] DylanToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 0
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 2.47ms (907.12µs CPU time)

Ran 2 tests for test/UUPS_Proxy_Test.sol:UUPS_Proxy_Test
[PASS] test_NFTMarket_v1_upgrade_v2() (gas: 1628370)
Logs:
  proxy admin:  0x2A3C5Ab07e5350a844111178A2757E375d4001b7
  implementation_v1_contract address:  0x2e234DAe75C793f67A35089C9d99245E1C58470b
  Minted NFT with tokenId: 0
  implementation_v2_contract address:  0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
  Minted NFT with tokenId: 1

Traces:
  [3004201] UUPS_Proxy_Test::setUp()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]
    ├─ [0] VM::label(proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7], "proxyAmdin")
    │   └─ ← [Return] 
    ├─ [0] console::log("proxy admin: ", proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [1102785] → new DylanNFT@0x8bb37534DB815Ad26e6FC565244D5eF8895656DD
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [904070] → new DylanToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [496936] → new NFTMarket_v1@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   └─ ← [Return] 2471 bytes of code
    ├─ [0] console::log("implementation_v1_contract address: ", NFTMarket_v1: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7])
    │   └─ ← [Return] 
    ├─ [82522] → new UUPS_Proxy@0xf9f143952086c810533A4A749a00D232C98DA14c
    │   └─ ← [Return] 299 bytes of code
    ├─ [69791] UUPS_Proxy::initialize(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7])
    │   ├─ [69253] NFTMarket_v1::initialize(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]) [delegatecall]
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    └─ ← [Stop] 

  [1628370] UUPS_Proxy_Test::test_NFTMarket_v1_upgrade_v2()
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
    ├─ emit ApprovalForAll(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], operator: UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c], approved: true)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [24581] DylanNFT::setApprovalForAll(UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c], true)
    │   ├─ emit ApprovalForAll(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], operator: UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c], approved: true)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Listed(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 1000000000000000000 [1e18])
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [59618] UUPS_Proxy::list(0, 1000000000000000000 [1e18])
    │   ├─ [54586] NFTMarket_v1::list(0, 1000000000000000000 [1e18]) [delegatecall]
    │   │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   │   ├─ [2844] DylanNFT::getApproved(0) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000
    │   │   ├─ [838] DylanNFT::isApprovedForAll(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c]) [staticcall]
    │   │   │   └─ ← [Return] true
    │   │   ├─ emit Listed(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] DylanToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] DylanToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [24762] DylanToken::approve(UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c], 1000000000000000000 [1e18])
    │   ├─ emit Approval(owner: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], spender: UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [62108] UUPS_Proxy::buyNFT(0)
    │   ├─ [61579] NFTMarket_v1::buyNFT(0) [delegatecall]
    │   │   ├─ [26022] DylanToken::transferFrom(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 1000000000000000000 [1e18])
    │   │   │   ├─ emit Transfer(from: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 1000000000000000000 [1e18])
    │   │   │   └─ ← [Return] true
    │   │   ├─ [29502] DylanNFT::safeTransferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 0)
    │   │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], tokenId: 0)
    │   │   │   └─ ← [Stop] 
    │   │   ├─ emit Purchased(tokenId: 0, buyer: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], price: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::assertEq(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "NFT was not transferred") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] DylanToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [629] DylanToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [1181484] → new NFTMarket_v2@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   └─ ← [Return] 5884 bytes of code
    ├─ [0] console::log("implementation_v2_contract address: ", NFTMarket_v2: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7])
    │   └─ ← [Return] 
    ├─ [6477] UUPS_Proxy::_upgradeImplementation(NFTMarket_v2: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a])
    │   ├─ [5948] NFTMarket_v1::_upgradeImplementation(NFTMarket_v2: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a]) [delegatecall]
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [407] UUPS_Proxy::_getImplementation() [staticcall]
    │   └─ ← [Return] NFTMarket_v2: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a]
    ├─ [993] UUPS_Proxy::_getAdmin() [staticcall]
    │   ├─ [464] NFTMarket_v2::_getAdmin() [delegatecall]
    │   │   └─ ← [Return] proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]
    │   └─ ← [Return] proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [69642] DylanNFT::mintTo(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "https://ipfs.io/ipfs/CID1")
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], tokenId: 1)
    │   ├─ emit MetadataUpdate(_tokenId: 1)
    │   └─ ← [Return] 1
    ├─ [1787] DylanNFT::tokenURI(1) [staticcall]
    │   └─ ← [Return] "https://ipfs.io/ipfs/CID1"
    ├─ [0] VM::assertEq("https://ipfs.io/ipfs/CID1", "https://ipfs.io/ipfs/CID1", "URI does not match") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("Minted NFT with tokenId:", 1) [staticcall]
    │   └─ ← [Stop] 
    ├─ [780] UUPS_Proxy::LISTING_TYPEHASH() [staticcall]
    │   ├─ [251] NFTMarket_v2::LISTING_TYPEHASH() [delegatecall]
    │   │   └─ ← [Return] 0xc895c5f758f496a5ba68797e8c9b666b5e546e7d65b358d335b34c139e2dc875
    │   └─ ← [Return] 0xc895c5f758f496a5ba68797e8c9b666b5e546e7d65b358d335b34c139e2dc875
    ├─ [1168] UUPS_Proxy::getDomainSeparator() [staticcall]
    │   ├─ [639] NFTMarket_v2::getDomainSeparator() [delegatecall]
    │   │   └─ ← [Return] 0x01b82f7ff1329d5ea690fd351ed6678a53f7dca050c5351781dbf58a1bf7a606
    │   └─ ← [Return] 0x01b82f7ff1329d5ea690fd351ed6678a53f7dca050c5351781dbf58a1bf7a606
    ├─ [0] VM::sign("<pk>", 0x3375ce76583fbf038ad528bfa1215d1a8a1b900a0bd33bff2f6f17a0b8228d04) [staticcall]
    │   └─ ← [Return] 27, 0x6c46be8c7b4db703b243c26fe312a1f38e705a8cfc726112eff46de00906a19a, 0x6db8201313a468209cfb895e14cb442a415ca0c120f031134927b64ce476aa0f
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [23211] DylanToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] DylanToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [22662] DylanToken::approve(UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c], 1000000000000000000 [1e18])
    │   ├─ emit Approval(owner: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], spender: UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [47769] UUPS_Proxy::BuyWithLS(ListWithSignature({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, tokenId: 1, price: 1000000000000000000 [1e18], deadline: 86401 [8.64e4], signature: 0x6c46be8c7b4db703b243c26fe312a1f38e705a8cfc726112eff46de00906a19a6db8201313a468209cfb895e14cb442a415ca0c120f031134927b64ce476aa0f1b }))
    │   ├─ [47189] NFTMarket_v2::BuyWithLS(ListWithSignature({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, tokenId: 1, price: 1000000000000000000 [1e18], deadline: 86401 [8.64e4], signature: 0x6c46be8c7b4db703b243c26fe312a1f38e705a8cfc726112eff46de00906a19a6db8201313a468209cfb895e14cb442a415ca0c120f031134927b64ce476aa0f1b })) [delegatecall]
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x3375ce76583fbf038ad528bfa1215d1a8a1b900a0bd33bff2f6f17a0b8228d04, 27, 48974782060711062386424433137127809221954688095882211514084376493686499221914, 49627421725685909578064829963163095265193197886773297526203287782548139584015) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   │   ├─ [664] DylanNFT::ownerOf(1) [staticcall]
    │   │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   │   ├─ [2844] DylanNFT::getApproved(1) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000
    │   │   ├─ [838] DylanNFT::isApprovedForAll(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], UUPS_Proxy: [0xf9f143952086c810533A4A749a00D232C98DA14c]) [staticcall]
    │   │   │   └─ ← [Return] true
    │   │   ├─ [4122] DylanToken::transferFrom(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 1000000000000000000 [1e18])
    │   │   │   ├─ emit Transfer(from: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 1000000000000000000 [1e18])
    │   │   │   └─ ← [Return] true
    │   │   ├─ [5102] DylanNFT::safeTransferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1)
    │   │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], tokenId: 1)
    │   │   │   └─ ← [Stop] 
    │   │   ├─ emit Purchased(tokenId: 1, buyer: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], price: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    ├─ [664] DylanNFT::ownerOf(1) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::assertEq(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "NFT was not transferred") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] DylanToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 2000000000000000000 [2e18]
    ├─ [629] DylanToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 0
    └─ ← [Stop] 

[PASS] test_Proxy_Slot() (gas: 18823)
Logs:
  proxy admin:  0x2A3C5Ab07e5350a844111178A2757E375d4001b7
  implementation_v1_contract address:  0x2e234DAe75C793f67A35089C9d99245E1C58470b

Traces:
  [3004201] UUPS_Proxy_Test::setUp()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    ├─ [0] VM::label(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], "nftSeller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::label(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "nftBuyer")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]
    ├─ [0] VM::label(proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7], "proxyAmdin")
    │   └─ ← [Return] 
    ├─ [0] console::log("proxy admin: ", proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [1102785] → new DylanNFT@0x8bb37534DB815Ad26e6FC565244D5eF8895656DD
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 5153 bytes of code
    ├─ [904070] → new DylanToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: UUPS_Proxy_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
    │   └─ ← [Return] 3941 bytes of code
    ├─ [496936] → new NFTMarket_v1@0x2e234DAe75C793f67A35089C9d99245E1C58470b
    │   └─ ← [Return] 2471 bytes of code
    ├─ [0] console::log("implementation_v1_contract address: ", NFTMarket_v1: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7])
    │   └─ ← [Return] 
    ├─ [82522] → new UUPS_Proxy@0xf9f143952086c810533A4A749a00D232C98DA14c
    │   └─ ← [Return] 299 bytes of code
    ├─ [69791] UUPS_Proxy::initialize(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7])
    │   ├─ [69253] NFTMarket_v1::initialize(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]) [delegatecall]
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 
    └─ ← [Stop] 

  [18823] UUPS_Proxy_Test::test_Proxy_Slot()
    ├─ [2407] UUPS_Proxy::_getImplementation() [staticcall]
    │   └─ ← [Return] NFTMarket_v1: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]
    ├─ [407] UUPS_Proxy::_getImplementation() [staticcall]
    │   └─ ← [Return] NFTMarket_v1: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]
    ├─ [5492] UUPS_Proxy::_getAdmin() [staticcall]
    │   ├─ [2463] NFTMarket_v1::_getAdmin() [delegatecall]
    │   │   └─ ← [Return] proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]
    │   └─ ← [Return] proxyAmdin: [0x2A3C5Ab07e5350a844111178A2757E375d4001b7]
    └─ ← [Stop] 

Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 3.05ms (1.21ms CPU time)

Ran 2 test suites in 2.63s (5.51ms CPU time): 3 tests passed, 0 failed, 0 skipped (3 total tests)
