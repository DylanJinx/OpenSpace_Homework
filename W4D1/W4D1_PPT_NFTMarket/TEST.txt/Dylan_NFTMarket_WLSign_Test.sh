Compiling 1 files with Solc 0.8.26
Solc 0.8.26 finished in 2.83s
Compiler run successful!

Ran 3 tests for test/Dylan_NFTMarket_WLSign_Test.sol:Dylan_NFTMarket_WLSign_Test
[PASS] test_Fail_One_WLSign() (gas: 406695)
Logs:
  Minted NFT with tokenId: 0
  ---------------------list---------------------------
  NFT successfully listed: 
  NFT Contract Address: 0x2e234DAe75C793f67A35089C9d99245E1C58470b
  TokenId: 0
  Token Contract Address: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  Listed Price: 1000000000000000000
  Deadline: 31536001
  NeedWLSign: true

Traces:
  [4745172] Dylan_NFTMarket_WLSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
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
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [406695] Dylan_NFTMarket_WLSign_Test::test_Fail_One_WLSign()
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
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Listed(nft: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], tokenId: 0, orderHashId: 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], payToken: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [170041] Dylan_NFTMarket::list(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0, MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000000000000000000 [1e18], 31536001 [3.153e7], true)
    │   ├─ [2349] MyToken::totalSupply() [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [844] DylanNFT::getApproved(0) [staticcall]
    │   │   └─ ← [Return] Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a]
    │   ├─ emit Listed(nft: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], tokenId: 0, orderHashId: 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], payToken: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true)
    │   └─ ← [Stop] 
    ├─ [936] Dylan_NFTMarket::isListed(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0) [staticcall]
    │   └─ ← [Return] 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3
    ├─ [0] VM::assertEq(0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, "OrderHashId does not match the listed orderHashId.") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("---------------------list---------------------------") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT successfully listed: ") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT Contract Address:", DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("TokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Token Contract Address:", MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Listed Price:", 1000000000000000000 [1e18]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Deadline:", 31536001 [3.153e7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NeedWLSign:", true) [staticcall]
    │   └─ ← [Stop] 
    ├─ [936] Dylan_NFTMarket::isListed(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0) [staticcall]
    │   └─ ← [Return] 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
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
    ├─ [0] VM::expectRevert(NeedWLSign())
    │   └─ ← [Return] 
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [1321] Dylan_NFTMarket::buy(0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3)
    │   └─ ← [Revert] NeedWLSign()
    └─ ← [Stop] 

[PASS] test_Success_One_WLSign() (gas: 436424)
Logs:
  Minted NFT with tokenId: 0
  ---------------------list---------------------------
  NFT successfully listed: 
  NFT Contract Address: 0x2e234DAe75C793f67A35089C9d99245E1C58470b
  TokenId: 0
  Token Contract Address: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  Listed Price: 1000000000000000000
  Deadline: 31536001
  NeedWLSign: true

Traces:
  [4745172] Dylan_NFTMarket_WLSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
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
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [436424] Dylan_NFTMarket_WLSign_Test::test_Success_One_WLSign()
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
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Listed(nft: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], tokenId: 0, orderHashId: 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], payToken: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [170041] Dylan_NFTMarket::list(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0, MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000000000000000000 [1e18], 31536001 [3.153e7], true)
    │   ├─ [2349] MyToken::totalSupply() [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [844] DylanNFT::getApproved(0) [staticcall]
    │   │   └─ ← [Return] Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a]
    │   ├─ emit Listed(nft: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], tokenId: 0, orderHashId: 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], payToken: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true)
    │   └─ ← [Stop] 
    ├─ [936] Dylan_NFTMarket::isListed(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0) [staticcall]
    │   └─ ← [Return] 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3
    ├─ [0] VM::assertEq(0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, "OrderHashId does not match the listed orderHashId.") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("---------------------list---------------------------") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT successfully listed: ") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT Contract Address:", DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("TokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Token Contract Address:", MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Listed Price:", 1000000000000000000 [1e18]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Deadline:", 31536001 [3.153e7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NeedWLSign:", true) [staticcall]
    │   └─ ← [Stop] 
    ├─ [936] Dylan_NFTMarket::isListed(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0) [staticcall]
    │   └─ ← [Return] 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
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
    ├─ [26724] Dylan_NFTMarket::setNFT_WLSigner(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   ├─ emit WLSignerChanged(nftContract: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], WLSigner: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Stop] 
    ├─ [218] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [69652] Dylan_NFTMarket::buy(0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c)
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

[PASS] test_Success_One_WLSign_fee() (gas: 492748)
Logs:
  Minted NFT with tokenId: 0
  ---------------------list---------------------------
  NFT successfully listed: 
  NFT Contract Address: 0x2e234DAe75C793f67A35089C9d99245E1C58470b
  TokenId: 0
  Token Contract Address: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
  Listed Price: 1000000000000000000
  Deadline: 31536001
  NeedWLSign: true

Traces:
  [4745172] Dylan_NFTMarket_WLSign_Test::setUp()
    ├─ [904070] → new MyToken@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], value: 1000000000000000000000000 [1e24])
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
    │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496])
    │   └─ ← [Return] 12097 bytes of code
    └─ ← [Stop] 

  [492748] Dylan_NFTMarket_WLSign_Test::test_Success_One_WLSign_fee()
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
    ├─ [0] VM::expectEmit(true, true, true, true)
    │   └─ ← [Return] 
    ├─ emit Listed(nft: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], tokenId: 0, orderHashId: 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], payToken: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true)
    ├─ [0] VM::prank(nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B])
    │   └─ ← [Return] 
    ├─ [170041] Dylan_NFTMarket::list(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0, MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000000000000000000 [1e18], 31536001 [3.153e7], true)
    │   ├─ [2349] MyToken::totalSupply() [staticcall]
    │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   ├─ [664] DylanNFT::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B]
    │   ├─ [844] DylanNFT::getApproved(0) [staticcall]
    │   │   └─ ← [Return] Dylan_NFTMarket: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a]
    │   ├─ emit Listed(nft: DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], tokenId: 0, orderHashId: 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, seller: nftSeller: [0x2415AcE8A44b68a4c72A98912a444ba1499A9d3B], payToken: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], deadline: 31536001 [3.153e7], needWLSign: true)
    │   └─ ← [Stop] 
    ├─ [936] Dylan_NFTMarket::isListed(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0) [staticcall]
    │   └─ ← [Return] 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3
    ├─ [0] VM::assertEq(0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, "OrderHashId does not match the listed orderHashId.") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] console::log("---------------------list---------------------------") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT successfully listed: ") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT Contract Address:", DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("TokenId:", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Token Contract Address:", MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Listed Price:", 1000000000000000000 [1e18]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("Deadline:", 31536001 [3.153e7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NeedWLSign:", true) [staticcall]
    │   └─ ← [Stop] 
    ├─ [936] Dylan_NFTMarket::isListed(DylanNFT: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 0) [staticcall]
    │   └─ ← [Return] 0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3
    ├─ [0] VM::expectEmit(true, true, false, true)
    │   └─ ← [Return] 
    ├─ emit Transfer(from: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
    ├─ [30011] MyToken::transfer(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], 1000000000000000000 [1e18])
    │   ├─ emit Transfer(from: Dylan_NFTMarket_WLSign_Test: [0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496], to: nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B], value: 1000000000000000000 [1e18])
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
    ├─ [218] Dylan_NFTMarket::WL_TYPEHASH() [staticcall]
    │   └─ ← [Return] 0xa805b9094d0984ea31be68e0d994415cc8c71ab3c370ae73951774cee004189c
    ├─ [363] Dylan_NFTMarket::getDomainSeparator() [staticcall]
    │   └─ ← [Return] 0x66b902413ec708682e3ff51ddc7f0e1e26f2c41b5257d9a810c188cf736cd8b5
    ├─ [0] VM::sign("<pk>", 0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8) [staticcall]
    │   └─ ← [Return] 28, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af9, 0x33f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c3
    ├─ [241] Dylan_NFTMarket::feeBP() [staticcall]
    │   └─ ← [Return] 30
    ├─ [0] VM::prank(nftBuyer: [0x4CeC381c3bEE40863F07d7d011715C1CC4a8334B])
    │   └─ ← [Return] 
    ├─ [94410] Dylan_NFTMarket::buy(0xf52327414b321fc5c7de76f662d6fddf2a9a67516146f840c65ffe58b685d1d3, 0xaaf5ef08eaaaaf5b2d3b64f642c5a43a03dce6315525bbcd02c79ccb07278af933f18c0f8225b04650d9eb2770e38584861c837b2676816b0165ca7439de24c31c)
    │   ├─ [3000] PRECOMPILES::ecrecover(0x800bb3041a0395c63e9288b32cfd7306e366e74c5febeec5f445237d8b03f3d8, 28, 77327711547795738446774952212674510112625498571600421431494765474987054172921, 23494732082952029213201977883842836417352024657625653097996404414735999444163) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002415ace8a44b68a4c72a98912a444ba1499a9d3b
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

Suite result: ok. 3 passed; 0 failed; 0 skipped; finished in 25.62ms (26.84ms CPU time)

Ran 1 test suite in 3.86s (25.62ms CPU time): 3 tests passed, 0 failed, 0 skipped (3 total tests)
