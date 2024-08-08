Compiling 1 files with Solc 0.8.26
Solc 0.8.26 finished in 2.58s
Compiler run successful!

Ran 4 tests for test/AirdopMerkleNFTMarket_Test.sol:AirdopMerkleNFTMarket_Test
[PASS] test_Multicall() (gas: 309755)
Logs:
  Minted NFT with tokenId: 0
  ---------------------list---------------------------
  NFT successfully listed: 
  NFT Contract Address: 0x8bb37534DB815Ad26e6FC565244D5eF8895656DD
  TokenId: 0
  Token Contract Address: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  Listed Price: 10000000000000000000
  Gas used with multicall:  154496

Traces:
  [311484] AirdopMerkleNFTMarket_Test::test_Multicall()
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
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Listed(nft: DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 10000000000000000000 [1e19])
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [49661] AirdopMerkleNFTMarket::list(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], 0, 10000000000000000000 [1e19])
    │   ├─ [642] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [844] DylanNFT::getApproved(0) [staticcall]
    │   │   └─ ← [Return] AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1]
    │   ├─ emit Listed(nft: DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 10000000000000000000 [1e19])
    │   └─ ← [Stop] 
    ├─ [0] console::log("---------------------list---------------------------") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT successfully listed: ") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT Contract Address:", DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("TokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Token Contract Address:", DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Listed Price:", 10000000000000000000 [1e19]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [658] DylanToken::getDigest(0xe6864b3208108b9d95e51fd60bdeffde1cdf56230c4772853e0e58e80121224f) [staticcall]
    │   └─ ← [Return] 0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459
    ├─ [0] VM::sign("<pk>", 0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459) [staticcall]
    │   └─ ← [Return] 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76
    ├─ [0] VM::prank(0x90F79bf6EB2c4f870365E785982E1f101E93b906)
    │   └─ ← [Return] 
    ├─ [150333] AirdopMerkleNFTMarket::multicall([0x25f6994200000000000000000000000090f79bf6eb2c4f870365e785982e1f101e93b9060000000000000000000000002e889b36ffb3ad2dc84bafcbec5d77028971bcb10000000000000000000000000000000000000000000000008ac7230489e8000000000000000000000000000000000000000000000000000000000000000003e9000000000000000000000000000000000000000000000000000000000000001c3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f9158475bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76, 0xec060ab30000000000000000000000008bb37534db815ad26e6fc565244d5ef8895656dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000200314e565e0574cb412563df634608d76f5c59d9f817e85966100ec1d48005c04ed9d015110a35000ce5c94f94ccdc63653ddd26af11314d386ae5e65ef28c79])
    │   ├─ [74799] AirdopMerkleNFTMarket::permitPrePay(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 10000000000000000000 [1e19], 1001, 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76) [delegatecall]
    │   │   ├─ [51462] DylanToken::permit(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 10000000000000000000 [1e19], 1001, 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76)
    │   │   │   ├─ [3000] PRECOMPILES::ecrecover(0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459, 28, 28746655521329674143776039206330455366997613253243038569106153471275317680199, 41513903117875313112240625268573173301817883159742446824513093722665812716406) [staticcall]
    │   │   │   │   └─ ← [Return] 0x00000000000000000000000090f79bf6eb2c4f870365e785982e1f101e93b906
    │   │   │   ├─ emit Approval(owner: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, spender: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], value: 10000000000000000000 [1e19])
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Stop] 
    │   ├─ [70406] AirdopMerkleNFTMarket::claimNFT(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], 0, [0x00314e565e0574cb412563df634608d76f5c59d9f817e85966100ec1d48005c0, 0x4ed9d015110a35000ce5c94f94ccdc63653ddd26af11314d386ae5e65ef28c79]) [delegatecall]
    │   │   ├─ [2629] DylanToken::balanceOf(0x90F79bf6EB2c4f870365E785982E1f101E93b906) [staticcall]
    │   │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   │   ├─ [792] DylanToken::allowance(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1]) [staticcall]
    │   │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   │   ├─ [28854] DylanNFT::transferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 0x90F79bf6EB2c4f870365E785982E1f101E93b906, 0)
    │   │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, tokenId: 0)
    │   │   │   └─ ← [Stop] 
    │   │   ├─ [28822] DylanToken::transferFrom(0x90F79bf6EB2c4f870365E785982E1f101E93b906, nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 5000000000000000000 [5e18])
    │   │   │   ├─ emit Transfer(from: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 5000000000000000000 [5e18])
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   │   ├─ emit Purchased(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], buyer: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, price: 0)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] [0x, 0x]
    ├─ [0] console::log("Gas used with multicall: ", 154496 [1.544e5]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [642] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] 0x90F79bf6EB2c4f870365E785982E1f101E93b906
    ├─ [0] VM::assertEq(0x90F79bf6EB2c4f870365E785982E1f101E93b906, 0x90F79bf6EB2c4f870365E785982E1f101E93b906, "NFT not transferred to buyer4") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] DylanToken::balanceOf(0x90F79bf6EB2c4f870365E785982E1f101E93b906) [staticcall]
    │   └─ ← [Return] 995000000000000000000 [9.95e20]
    ├─ [0] VM::assertEq(995000000000000000000 [9.95e20], 995000000000000000000 [9.95e20], "buyer4 balance not updated") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] DylanToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 5000000000000000000 [5e18]
    └─ ← [Stop] 

[PASS] test_buy() (gas: 248979)
Logs:
  Minted NFT with tokenId: 0
  ---------------------list---------------------------
  NFT successfully listed: 
  NFT Contract Address: 0x8bb37534DB815Ad26e6FC565244D5eF8895656DD
  TokenId: 0
  Token Contract Address: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  Listed Price: 10000000000000000000

Traces:
  [253192] AirdopMerkleNFTMarket_Test::test_buy()
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
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Listed(nft: DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 10000000000000000000 [1e19])
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [49661] AirdopMerkleNFTMarket::list(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], 0, 10000000000000000000 [1e19])
    │   ├─ [642] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [844] DylanNFT::getApproved(0) [staticcall]
    │   │   └─ ← [Return] AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1]
    │   ├─ emit Listed(nft: DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 10000000000000000000 [1e19])
    │   └─ ← [Stop] 
    ├─ [0] console::log("---------------------list---------------------------") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT successfully listed: ") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT Contract Address:", DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("TokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Token Contract Address:", DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Listed Price:", 10000000000000000000 [1e19]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266)
    │   └─ ← [Return] 
    ├─ [24762] DylanToken::approve(AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 10000000000000000000 [1e19])
    │   ├─ emit Approval(owner: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, spender: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], value: 10000000000000000000 [1e19])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, tokenId: 0)
    ├─ [0] VM::prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266)
    │   └─ ← [Return] 
    ├─ [66789] AirdopMerkleNFTMarket::buy(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], 0)
    │   ├─ [2629] DylanToken::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [792] DylanToken::allowance(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1]) [staticcall]
    │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   ├─ [28854] DylanNFT::transferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 0)
    │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, tokenId: 0)
    │   │   └─ ← [Stop] 
    │   ├─ [28822] DylanToken::transferFrom(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 10000000000000000000 [1e19])
    │   │   ├─ emit Transfer(from: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 10000000000000000000 [1e19])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ emit Purchased(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], buyer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, price: 0)
    │   └─ ← [Stop] 
    ├─ [642] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
    ├─ [629] DylanToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 10000000000000000000 [1e19]
    ├─ [629] DylanToken::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [staticcall]
    │   └─ ← [Return] 990000000000000000000 [9.9e20]
    └─ ← [Stop] 

[PASS] test_notUseMulticall() (gas: 301725)
Logs:
  Minted NFT with tokenId: 0
  ---------------------list---------------------------
  NFT successfully listed: 
  NFT Contract Address: 0x8bb37534DB815Ad26e6FC565244D5eF8895656DD
  TokenId: 0
  Token Contract Address: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  Listed Price: 10000000000000000000
  Gas used without multicall:  154324

Traces:
  [305060] AirdopMerkleNFTMarket_Test::test_notUseMulticall()
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
    ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], tokenId: 0)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [25052] DylanNFT::approve(AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 0)
    │   ├─ emit Approval(owner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], approved: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], tokenId: 0)
    │   └─ ← [Stop] 
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Listed(nft: DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 10000000000000000000 [1e19])
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [49661] AirdopMerkleNFTMarket::list(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], 0, 10000000000000000000 [1e19])
    │   ├─ [642] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [844] DylanNFT::getApproved(0) [staticcall]
    │   │   └─ ← [Return] AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1]
    │   ├─ emit Listed(nft: DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], price: 10000000000000000000 [1e19])
    │   └─ ← [Stop] 
    ├─ [0] console::log("---------------------list---------------------------") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT successfully listed: ") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT Contract Address:", DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("TokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Token Contract Address:", DylanToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Listed Price:", 10000000000000000000 [1e19]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [658] DylanToken::getDigest(0xe6864b3208108b9d95e51fd60bdeffde1cdf56230c4772853e0e58e80121224f) [staticcall]
    │   └─ ← [Return] 0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459
    ├─ [0] VM::sign("<pk>", 0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459) [staticcall]
    │   └─ ← [Return] 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76
    ├─ [0] VM::prank(0x90F79bf6EB2c4f870365E785982E1f101E93b906)
    │   └─ ← [Return] 
    ├─ [74799] AirdopMerkleNFTMarket::permitPrePay(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 10000000000000000000 [1e19], 1001, 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76)
    │   ├─ [51462] DylanToken::permit(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 10000000000000000000 [1e19], 1001, 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459, 28, 28746655521329674143776039206330455366997613253243038569106153471275317680199, 41513903117875313112240625268573173301817883159742446824513093722665812716406) [staticcall]
    │   │   │   └─ ← [Return] 0x00000000000000000000000090f79bf6eb2c4f870365e785982e1f101e93b906
    │   │   ├─ emit Approval(owner: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, spender: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], value: 10000000000000000000 [1e19])
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(0x90F79bf6EB2c4f870365E785982E1f101E93b906)
    │   └─ ← [Return] 
    ├─ [70406] AirdopMerkleNFTMarket::claimNFT(DylanNFT: [0x8bb37534DB815Ad26e6FC565244D5eF8895656DD], 0, [0x00314e565e0574cb412563df634608d76f5c59d9f817e85966100ec1d48005c0, 0x4ed9d015110a35000ce5c94f94ccdc63653ddd26af11314d386ae5e65ef28c79])
    │   ├─ [2629] DylanToken::balanceOf(0x90F79bf6EB2c4f870365E785982E1f101E93b906) [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000 [1e21]
    │   ├─ [792] DylanToken::allowance(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1]) [staticcall]
    │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   ├─ [28854] DylanNFT::transferFrom(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 0x90F79bf6EB2c4f870365E785982E1f101E93b906, 0)
    │   │   ├─ emit Transfer(from: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], to: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, tokenId: 0)
    │   │   └─ ← [Stop] 
    │   ├─ [28822] DylanToken::transferFrom(0x90F79bf6EB2c4f870365E785982E1f101E93b906, nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], 5000000000000000000 [5e18])
    │   │   ├─ emit Transfer(from: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, to: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], value: 5000000000000000000 [5e18])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ emit Purchased(tokenId: 0, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], buyer: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, price: 0)
    │   └─ ← [Stop] 
    ├─ [0] console::log("Gas used without multicall: ", 154324 [1.543e5]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [642] DylanNFT::ownerOf(0) [staticcall]
    │   └─ ← [Return] 0x90F79bf6EB2c4f870365E785982E1f101E93b906
    ├─ [0] VM::assertEq(0x90F79bf6EB2c4f870365E785982E1f101E93b906, 0x90F79bf6EB2c4f870365E785982E1f101E93b906, "NFT not transferred to buyer4") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] DylanToken::balanceOf(0x90F79bf6EB2c4f870365E785982E1f101E93b906) [staticcall]
    │   └─ ← [Return] 995000000000000000000 [9.95e20]
    ├─ [0] VM::assertEq(995000000000000000000 [9.95e20], 995000000000000000000 [9.95e20], "buyer4 balance not updated") [staticcall]
    │   └─ ← [Return] 
    ├─ [629] DylanToken::balanceOf(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]) [staticcall]
    │   └─ ← [Return] 5000000000000000000 [5e18]
    └─ ← [Stop] 

[PASS] test_permitPrePay() (gas: 96357)
Traces:
  [96357] AirdopMerkleNFTMarket_Test::test_permitPrePay()
    ├─ [658] DylanToken::getDigest(0xe6864b3208108b9d95e51fd60bdeffde1cdf56230c4772853e0e58e80121224f) [staticcall]
    │   └─ ← [Return] 0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459
    ├─ [0] VM::sign("<pk>", 0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459) [staticcall]
    │   └─ ← [Return] 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76
    ├─ [0] VM::prank(0x90F79bf6EB2c4f870365E785982E1f101E93b906)
    │   └─ ← [Return] 
    ├─ [74799] AirdopMerkleNFTMarket::permitPrePay(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 10000000000000000000 [1e19], 1001, 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76)
    │   ├─ [51462] DylanToken::permit(0x90F79bf6EB2c4f870365E785982E1f101E93b906, AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], 10000000000000000000 [1e19], 1001, 28, 0x3f8e07cab6ce4e8e5919393af4ebab10321285878622b193ea8b05584f915847, 0x5bc80957d6b1a7de33c1662af9556aa3de44bb9c64d11b07649c743e4b8f6b76)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x8a70f48da1cfb1a5d2b70f5921f0ef2131078ebb1fdfaba30e1bc81bdcbe0459, 28, 28746655521329674143776039206330455366997613253243038569106153471275317680199, 41513903117875313112240625268573173301817883159742446824513093722665812716406) [staticcall]
    │   │   │   └─ ← [Return] 0x00000000000000000000000090f79bf6eb2c4f870365e785982e1f101e93b906
    │   │   ├─ emit Approval(owner: 0x90F79bf6EB2c4f870365E785982E1f101E93b906, spender: AirdopMerkleNFTMarket: [0x2E889B36fFb3Ad2dC84BaFCBEC5D77028971BcB1], value: 10000000000000000000 [1e19])
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [548] AirdopMerkleNFTMarket::hasPrePaid(0x90F79bf6EB2c4f870365E785982E1f101E93b906) [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::assertEq(true, true, "buyer4 has not pre-paid") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 4 passed; 0 failed; 0 skipped; finished in 22.23ms (23.53ms CPU time)

Ran 1 test suite in 300.19ms (22.23ms CPU time): 4 tests passed, 0 failed, 0 skipped (4 total tests)
