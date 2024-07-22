query input:  
```
{  
  lists(first: 5) {  
    id  
    nft  
    tokenId  
    orderId  
    seller  
    payToken  
    price  
    deadline  
    blockNumber  
    blockTimestamp  
    transactionHash  
  }  
  solds(first: 5) {  
    id  
    orderId  
    buyer  
    fee  
    blockNumber  
    blockTimestamp  
    transactionHash  
  }  
}  
```

output:  
```json
  "data": {  
    "lists": [  
      {  
        "id": "0x54a403559e71b36c9f076a23310c9a5e721db1c38c81f695d349f762728789094c000000",  
        "nft": "0x9e09e6309142d14a4215a642b739a4f3ec85d5fc",  
        "tokenId": "0",  
        "orderId": "0xac8a034b5997902409f301f145e448f83a212b5da7e5bfa427b915c9ea21e6e2",  
        "seller": "0x524a3f4843b5b2c8bcc050fe6c82c7edf50b1a3d",  
        "payToken": "0x187a30de091b1421d5bb419ff160b1f2ab38b4d2",  
        "price": "10000",  
        "deadline": "1721745832",  
        "blockNumber": "6355773",  
        "blockTimestamp": "1721646000",  
        "transactionHash": "0x54a403559e71b36c9f076a23310c9a5e721db1c38c81f695d349f76272878909"  
      },  
      {  
        "id": "0xf38dac75e337dd6207aace46d4d4c8a59e5f1c06b8942ceac6769289e8c03a0f8b000000",  
        "nft": "0x9e09e6309142d14a4215a642b739a4f3ec85d5fc",  
        "tokenId": "1",  
        "orderId": "0xfb496093842fe1aa4246764878b88c4340b46152a4dc2539963207a4c5fc3752",  
        "seller": "0x524a3f4843b5b2c8bcc050fe6c82c7edf50b1a3d",  
        "payToken": "0x187a30de091b1421d5bb419ff160b1f2ab38b4d2",  
        "price": "20000",  
        "deadline": "1721745832",  
        "blockNumber": "6355816",  
        "blockTimestamp": "1721646684",  
        "transactionHash": "0xf38dac75e337dd6207aace46d4d4c8a59e5f1c06b8942ceac6769289e8c03a0f"  
      }  
    ],  
    "solds": [  
      {  
        "id": "0x224e98925ec962bc5daea18b1138c99dc5b9ffd703cb90761f40e10e20af0e566a000000",  
        "orderId": "0xac8a034b5997902409f301f145e448f83a212b5da7e5bfa427b915c9ea21e6e2",  
        "buyer": "0x3a8492819b0c9ab5695d447cba2532b879d25900",  
        "fee": "0",  
        "blockNumber": "6355790",  
        "blockTimestamp": "1721646288",  
        "transactionHash": "0x224e98925ec962bc5daea18b1138c99dc5b9ffd703cb90761f40e10e20af0e56"  
      },  
      {  
        "id": "0x25d27776149b602dc5602ec45ac30b397992878b0dfa08818702654d49631bcd29000000",  
        "orderId": "0xfb496093842fe1aa4246764878b88c4340b46152a4dc2539963207a4c5fc3752",  
        "buyer": "0x3a8492819b0c9ab5695d447cba2532b879d25900",  
        "fee": "0",  
        "blockNumber": "6355826",  
        "blockTimestamp": "1721646876",  
        "transactionHash": "0x25d27776149b602dc5602ec45ac30b397992878b0dfa08818702654d49631bcd"  
      }  
    ]  
}  
```