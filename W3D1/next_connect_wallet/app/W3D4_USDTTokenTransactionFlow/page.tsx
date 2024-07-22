'use client';
import React, { useState, useEffect, useCallback } from 'react';
import { createPublicClient, http, parseAbiItem } from 'viem';
import { mainnet } from 'viem/chains';

const client = createPublicClient({
    chain: mainnet,
    transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`)
});

// 类型声明
interface TransferEvent {
    blockNumber: number;
    txHash: string;
    from: string;
    amount: string;
    to: string;
};

const USDT_ADDRESS = '0xdAC17F958D2ee523a2206206994597C13D831ec7';


const useTransferEvents = () => {
    // 存储转账事件的数组
    const [transfers, setTransfers] = useState<TransferEvent[]>([]);
    // 是否正在加载数据，当请求完成并获取到数据后，使用 setTransfers() 来更新转账事件的数据，然后用 setLoading(false) 表示数据加载完毕。
    const [loading, setLoading] = useState(true);
    const [blockNumber, setBlockNumber] = useState(0);
    const [countdown, setCountdown] = useState<number>(16);

    useEffect(() => {
        const fetchTransfers = async () => {
            setLoading(true);
            try {
                const blockNum = BigInt(await client.getBlockNumber());
                setBlockNumber(Number(blockNum));

                const logs = await client.getLogs({
                    address: USDT_ADDRESS,
                    event: parseAbiItem('event Transfer(address indexed from, address indexed to, uint256 value)'),
                    fromBlock: blockNum,
                    toBlock: blockNum,
                });

                const formattedTransfers = logs.map(event => ({
                    blockNumber: Number(event.blockNumber),
                    txHash: event.transactionHash,
                    from: event.args.from ?? '0x',
                    amount: (Number(event.args.value) / 1e6).toFixed(3),
                    to: event.args.to ?? '0x',
                }));
                
                setTransfers(formattedTransfers);
            } catch (error) {
                console.error('Failed to fetch transfer events: ', error);
            } finally {
                setLoading(false);
            }
        };
        
        fetchTransfers(); // Initial

        const intervalId = setInterval(() => {
            console.log("Fetching data...");
            fetchTransfers();
            setCountdown(16); // Reset countdown
        }, 16000);

        const countdownId = setInterval(() => {
            setCountdown((prevCountdown) => prevCountdown > 0 ? prevCountdown - 1 : 16);
        }, 1000);

        return () => {
            clearInterval(intervalId);
            clearInterval(countdownId);
        };
    }, []);

    return { transfers, loading, blockNumber, countdown };
};

const copyToClipboard = (text: any) => {
  navigator.clipboard.writeText(text).then(() => {
    alert('Copied to clipboard!');
  }, (err) => {
    console.error('Could not copy text: ', err);
  });
}

const TransferEvents = () => {
    const { transfers, loading, blockNumber, countdown } = useTransferEvents();

    return (
      <div className="flex flex-col min-h-screen">
        <div className="p-10 rounded shadow-lg min-w-full max-w-4xl">
          <h1 className="text-2xl font-bold mb-6 text-center">
            USDT Transfer Events in Current Block （Block Number: {blockNumber || 'loading...'}）
          </h1>
          <h2 className="text-center">Next fetch in: {countdown} seconds</h2>
          {loading ? (
            <p>Loading...</p>
          ) : (
            <table className="min-w-full border border-gray-200 text-center">
              <thead>
                <tr>
                  <th className="py-2 px-4 border-b">Transaction Hash</th>
                  <th className="py-2 px-4 border-b">From</th>
                  <th className="py-2 px-4 border-b">Amount (USDT)</th>
                  <th className="py-2 px-4 border-b">To</th>
                </tr>
              </thead>
              <tbody>
                {transfers.length > 0 ? (
                  transfers.map((transfer, index) => (
                    <tr key={index}>
                      <td className="py-2 px-4 border-b">
                        {transfer.txHash.substring(0, 10) + '...'}
                        <button 
                          style={{ marginLeft: '10px', fontSize: '0.75rem', color: '#6495ED', fontWeight: 'bold' }}
                          onClick={() => copyToClipboard(transfer.txHash)}
                        >
                          Copy
                        </button>
                      </td>
                      <td className="py-2 px-4 border-b">
                        {transfer.from.substring(0, 8) + '...' + transfer.from.substring(transfer.from.length - 8)}
                        <button 
                          style={{ marginLeft: '10px', fontSize: '0.75rem', color: '#6495ED', fontWeight: 'bold' }}
                          onClick={() => copyToClipboard(transfer.from)}
                        >
                          Copy
                        </button>
                      </td>
                      <td className="py-2 px-4 border-b">
                        {transfer.amount}
                      </td>
                      <td className="py-2 px-4 border-b">
                        {transfer.to.substring(0, 8) + '...' + transfer.to.substring(transfer.to.length - 8)}
                        <button 
                          style={{ marginLeft: '10px', fontSize: '0.75rem', color: '#6495ED', fontWeight: 'bold' }}
                          onClick={() => copyToClipboard(transfer.to)}
                        >
                          Copy
                        </button>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td className="py-2 px-4 border-b text-center" colSpan={4}>No transfer events found.</td>
                  </tr>
                )}
              </tbody>
            </table>
          )}
        </div>
      </div>
    );
    
    
  
};

export default TransferEvents;
  