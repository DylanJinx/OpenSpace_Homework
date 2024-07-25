'use client';
import React, { useState, useEffect } from 'react';
import { createPublicClient, http, stringify, Block } from 'viem';
import { mainnet } from 'viem/chains';

// 定义类型
type BlockType = {
  number: bigint;
  hash: `0x${string}`;
  nonce: `0x${string}`;
  logsBloom: `0x${string}`;
  baseFeePerGas: bigint | null;
  blobGasUsed: bigint;
  difficulty: bigint;
  excessBlobGas: bigint;
  extraData: `0x${string}`;
  gasLimit: bigint;
  transactions: `0x${string}`[];
};

const client = createPublicClient({
  chain: mainnet,
  transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`)
});

const BlockchainInteraction = () => {
  const [blockNumber, setBlockNumber] = useState<string>("");
  const [block, setBlock] = useState<BlockType | null>(null);
  const [blockWithNumber, setBlockWithNumber] = useState<BlockType | null>(null);
  const [blockSafe, setBlockSafe] = useState<BlockType | null>(null);
  const [blockWithHash, setBlockWithHash] = useState<BlockType | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      const [
        blockNumberRes,
        blockRes,
        blockWithNumberRes,
        blockSafeRes,
        blockWithHashRes
      ] = await Promise.all([
        client.getBlockNumber(),
        client.getBlock(),
        client.getBlock({ blockNumber: 6942069n }),
        client.getBlock({ blockTag: 'safe' }),
        client.getBlock({
          blockHash: '0xe9577fb1db37cb137c7a4a70666d2923b1b0a245befe3bf04d3ead3cc261ac0d',
        }),
      ]);

      setBlockNumber(blockNumberRes.toString());
      setBlock(blockRes);
      setBlockWithNumber(blockWithNumberRes);
      setBlockSafe(blockSafeRes);
      setBlockWithHash(blockWithHashRes);
    };

    fetchData();
  }, []);

  return (
    <div>
      <p>Block number: {blockNumber}</p>
      <div>
        Block:
        <details>
          <summary>View</summary>
          <pre><code>{stringify(block, null, 2)}</code></pre>
        </details>
      </div>
      <div>
        Block at number: {blockWithNumber?.number.toString()}:
        <details>
          <summary>View</summary>
          <pre><code>{stringify(blockWithNumber, null, 2)}</code></pre>
        </details>
      </div>
      <div>
        Block at tag safe: {blockSafe?.number.toString()}:
        <details>
          <summary>View</summary>
          <pre><code>{stringify(blockSafe, null, 2)}</code></pre>
        </details>
      </div>
      <div>
        Block at hash: {blockWithHash?.number.toString()}:
        <details>
          <summary>View</summary>
          <pre><code>{stringify(blockWithHash, null, 2)}</code></pre>
        </details>
      </div>
    </div>
  );
};

export default BlockchainInteraction;



// 'use client';
// import React, { useState, useEffect } from 'react';
// import { createPublicClient, http, stringify, Block } from 'viem';
// import { mainnet } from 'viem/chains';

// const client = createPublicClient({
//     chain: mainnet,
//     transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`)
// });

// const BlockchainInteraction = async () => {
//     const [blockNumber, block, blockWithNumber, blockSafe, blockWithHash] =
//         await Promise.all([
//             client.getBlockNumber(),
//             client.getBlock(),
//             client.getBlock({ blockNumber: 6942069n }),
//             client.getBlock({ blockTag: 'safe' }),
//             client.getBlock({
//                 blockHash:
//                     '0xe9577fb1db37cb137c7a4a70666d2923b1b0a245befe3bf04d3ead3cc261ac0d',
//             }),
//         ]);

//     return (
//         <div>
//             <p>Block number: {blockNumber.toString()}</p>
//             <div>
//                 Block:
//                 <details>
//                     <summary>View</summary>
//                     <pre><code>{stringify(block, null, 2)}</code></pre>
//                 </details>
//             </div>
//             <div>
//                 Block at number: {blockWithNumber?.number.toString()}:
//                 <details>
//                     <summary>View</summary>
//                     <pre><code>{stringify(blockWithNumber, null, 2)}</code></pre>
//                 </details>
//             </div>
//             <div>
//                 Block at tag safe: {blockSafe?.number.toString()}:
//                 <details>
//                     <summary>View</summary>
//                     <pre><code>{stringify(blockSafe, null, 2)}</code></pre>
//                 </details>
//             </div>
//             <div>
//                 Block at hash: {blockWithHash?.number.toString()}:
//                 <details>
//                     <summary>View</summary>
//                     <pre><code>{stringify(blockWithHash, null, 2)}</code></pre>
//                 </details>
//             </div>
//         </div>
//     );
// };

// export default BlockchainInteraction;
