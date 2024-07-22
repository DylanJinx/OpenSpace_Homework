No files changed, compilation skipped

Ran 2 tests for test/Dylan_NFTMarket_LS_WLSign_Test.sol:Dylan_NFTMarket_LS_WLSign_Test
[PASS] test_Success_ETH_Three_WLS_LS() (gas: 253263)
Logs:
  BuyerETH: 10000000000000000000
  SellerETH: 10000000000000000000
  Minted NFT with tokenId: 0
  BuyerETH: 9000000000000000000
  SellerETH: 11000000000000000000

Traces:
  [4846142] Dylan_NFTMarket_LS_WLSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
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
    ├─ [2546947] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12596 bytes of code
    ├─ [0] VM::deal(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 10000000000000000000 [1e19])
    │   └─ ← [Return] 
    ├─ [0] VM::deal(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 10000000000000000000 [1e19])
    │   └─ ← [Return] 
    └─ ← [Stop] 

  [253263] Dylan_NFTMarket_LS_WLSign_Test::test_Success_ETH_Three_WLS_LS()
    ├─ [0] console::log("BuyerETH:", 10000000000000000000 [1e19]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("SellerETH:", 10000000000000000000 [1e19]) [staticcall]
    │   └─ ← [Stop] 
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
    ├─ [0] VM::expectEmit(true, true, false, false)
    │   └─ ← [Return] 
    ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    ├─ [26680] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [241] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [408] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [263] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [408] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0xcb750170b242a1e3223f1943829ef9a58af56a7da89f16c42a7a5723aa8ed126) [staticcall]
    │   └─ ← [Return] 28, 0x086289b2b659a78fd94bea90c6afef6434f339a74e77c2e25b2c8c022859477d, 0x50de731452c0ca18372224cb3991176b841f13fc186fd78b22251cd0aa802cb9
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [79115] Dylan_NFTMarket::buy{value: 1000000000000000000}(0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c, SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x0000000000000000000000000000000000000000, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true }), signature: 0x086289b2b659a78fd94bea90c6afef6434f339a74e77c2e25b2c8c022859477d50de731452c0ca18372224cb3991176b841f13fc186fd78b22251cd0aa802cb91c }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0xcb750170b242a1e3223f1943829ef9a58af56a7da89f16c42a7a5723aa8ed126, 28, 3792604158338148653023358526125311489144242521395041170677716420652493784957, 36578062183785843537942131310411969663318642707692396265272910742525606636729) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [3000] PRECOMPILES::ecrecover(0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8, 28, 77327711547795738446774952212674510112625498571600421431494765474987054172921, 23494732082952029213201977883842836417352024657625653097996404414735999444163) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [29201] DylanNFT::safeTransferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 0)
    │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], tokenId: 0)
    │   │   └─ ← [Stop] 
    │   ├─ [0] nftSeller::fallback{value: 1000000000000000000}()
    │   │   └─ ← [Stop] 
    │   ├─ emit Purchased(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], buyer: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], price: 1000000000000000000 [1e18])
    │   └─ ← [Stop] 
    ├─ [0] console::log("BuyerETH:", 9000000000000000000 [9e18]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("SellerETH:", 11000000000000000000 [1.1e19]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]
    ├─ [0] VM::assertEq(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], "NFT was not transferred to the buyer") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Seller did not receive the tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer still has tokens") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_Success_Token_Three_WLS_LS() (gas: 289911)
Logs:
  Minted NFT with tokenId: 0

Traces:
  [4846142] Dylan_NFTMarket_LS_WLSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_LS_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
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
    ├─ [2546947] → new Dylan_NFTMarket@0xF62849F9A0B5Bf2913b396098F7c7019b51A820a
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_LS_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12596 bytes of code
    ├─ [0] VM::deal(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 10000000000000000000 [1e19])
    │   └─ ← [Return] 
    ├─ [0] VM::deal(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 10000000000000000000 [1e19])
    │   └─ ← [Return] 
    └─ ← [Stop] 

  [294124] Dylan_NFTMarket_LS_WLSign_Test::test_Success_Token_Three_WLS_LS()
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
    ├─ emit Transfer(from: Dylan_NFTMarket_LS_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_LS_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [629] MyToken::balanceOf(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B]) [staticcall]
    │   └─ ← [Return] 1000000000000000000 [1e18]
    ├─ [0] VM::assertEq(1000000000000000000 [1e18], 1000000000000000000 [1e18], "Buyer does not have enough tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [24762] MyToken::approve(Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 1000000000000000000 [1e18])
    │   ├─ emit Approval(owner: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], spender: Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [0] VM::expectEmit(true, true, false, false)
    │   └─ ← [Return] 
    ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    ├─ [26680] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [241] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [408] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [263] Dylan_NFTMarket::LISTING_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0x90b3da0f89fbdabd3c438a85ce5ee2522aae13b2e4c1be6948da8f73733f43e5
    ├─ [408] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151) [staticcall]
    │   └─ ← [Return] 27, 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b4, 0x4f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d7
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [101156] Dylan_NFTMarket::buy(0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c, SellOrderWithSignature({ order: SellOrder({ seller: 0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B, nft: 0x2e234DAe75C793f67A35089C9d99245E1C58470b, tokenId: 0, payToken: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true }), signature: 0x991b00da1efac3c7082a2341dd3d8feba0bfcb54b756337f7696f3dc34eb40b44f5d9b63dbf87f7126c22a82bb942bb4cded645103bfe81e1fa5ca6c19aff0d71b }))
    │   ├─ [3000] PRECOMPILES::ecrecover(0x081614f2de19cd75ea5ee981130509b847d76771bc168ab3e4088d0519c0a151, 27, 69251576584519674624008183023994352775055758883845465775314070452624702521524, 35898104277986524958806657736115760689589181329630707483017797871153101926615) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [3000] PRECOMPILES::ecrecover(0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8, 28, 77327711547795738446774952212674510112625498571600421431494765474987054172921, 23494732082952029213201977883842836417352024657625653097996404414735999444163) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
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

Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 3.92ms (2.74ms CPU time)

Ran 1 test suite in 1.96s (3.92ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)
