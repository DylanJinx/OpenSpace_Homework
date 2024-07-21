'use client';
import React, { useState, useEffect } from 'react';
import { createPublicClient, http, parseAbiItem, formatUnits } from 'viem';
import { mainnet } from 'viem/chains';

const USDT_CONTRACT_ADDRESS = '0xdac17f958d2ee523a2206206994597c13d831ec7';
const TRANSFER_EVENT_ABI = parseAbiItem('event Transfer(address indexed from, address indexed to, uint256 value)');

const BlockHashPage = () => {
    const [blockHeight, setBlockHeight] = useState<number | null>(null);
    const [blockHash, setBlockHash] = useState<string | null>(null);
    const [transfers, setTransfers] = useState<any[]>([]);

    useEffect(() => {
        const client = createPublicClient({
            chain: mainnet,
            transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`),
        });

        const fetchBlockData = async () => {
            const latestBlock = await client.getBlock({ blockTag: 'latest' });
            setBlockHeight(Number(latestBlock.number));
            setBlockHash(latestBlock.hash);
        };

        const subscribeToEvents = () => {
            client.watchBlockNumber({
                onBlockNumber: async (blockNumber) => {
                    if (!blockNumber) return;

                    const safeBlockNumber = BigInt(blockNumber);
                    setBlockHeight(Number(safeBlockNumber));
                    
                    const fromBlock = safeBlockNumber - BigInt(100);
                    const toBlock = safeBlockNumber;

                    const logs = await client.getLogs({
                        address: USDT_CONTRACT_ADDRESS,
                        event: TRANSFER_EVENT_ABI,
                        fromBlock,
                        toBlock,
                    });

                    const newTransfers = logs.map(log => ({
                        blockNumber: log.blockNumber,
                        transactionHash: log.transactionHash,
                        from: log.args.from,
                        to: log.args.to,
                        value: log.args.value ? formatUnits(log.args.value, 6) : '0.00000'
                    }));

                    setTransfers(newTransfers);
                },
            });
        };

        fetchBlockData();
        subscribeToEvents();

    }, []);

    return (
        <div>
            <h1>Latest Block Information</h1>
            <p>Block Height: {blockHeight}</p>
            <p>Block Hash: {blockHash}</p>
            <h2>Recent USDT Transfers</h2>
            {transfers.map((transfer, index) => (
                <div key={index}>
                    <p>Block {transfer.blockNumber}: {transfer.transactionHash} transferred {transfer.value} USDT from {transfer.from} to {transfer.to}</p>
                </div>
            ))}
        </div>
    );
};

export default BlockHashPage;
