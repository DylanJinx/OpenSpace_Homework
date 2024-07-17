import { parseAbiItem, http, createPublicClient } from 'viem'
import {mainnet } from 'viem/chains'

const client = createPublicClient({
    chain: mainnet,
    transport: http(`https://mainnet.infura.io/v3/${import.meta.env.VITE_INFURA_API_KEY}`),
    //transport: http()
})

export async function fetchUSDCTransfers() {
    const currentBlock = await client.getBlockNumber();
  
    const filter = await client.createEventFilter({
      address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',  // USDC contract address
      event: parseAbiItem('event Transfer(address indexed from, address indexed to, uint256 value)'),
      fromBlock: currentBlock - BigInt(100),
      toBlock: currentBlock
    });
  
    const logs = await client.getFilterLogs({ filter });
    
    return logs.map(log => {
        const { from, to, value } = log.args;
        const amount = Number(value) / 1e6;  // USDC has 6 decimal places
        return { from, to, amount, transactionId: log.transactionHash };
    });
}
  
fetchUSDCTransfers().catch(console.error);