'use client';
import React, { useState, useEffect } from 'react';
import { createPublicClient, http } from 'viem';
import { mainnet } from 'viem/chains';

const client = createPublicClient({
    chain: mainnet,
    transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`),
});

type BlockType = 'pending' | 'latest' | 'safe' | 'finalized' | 'earliest';

interface BlockInfo {
    type: BlockType;
    number: number | null;
    hash: string | null;
}

const FetchBlockInfo = () => {
    const [blockData, setBlockData] = useState<BlockInfo[]>([]);

    useEffect(() => {
        const fetchBlockData = async () => {
            const types: BlockType[] = ['pending', 'latest', 'safe', 'finalized', 'earliest'];
            const data: BlockInfo[] = await Promise.all(types.map(async (type) => {
                try {
                    const block = await client.getBlock({ blockTag: type });
                    return {
                        type,
                        number: Number(block.number),
                        hash: block.hash
                    };
                } catch (error) {
                    console.error(`Failed to fetch data for ${type}:`, error);
                    return {
                        type,
                        number: null,
                        hash: null
                    };
                }
            }));

            setBlockData(data);
        };

        const intervalId = setInterval(() => {
            console.log("Fetching data...");
            fetchBlockData();
        }, 15000);
        // Set interval to fetch data every 15000 ms (15 seconds)

        return () => clearInterval(intervalId); // Cleanup function to clear interval when component unmounts or updates
    }, []); // Empty dependency array to run only once after component mounts

    return (
        <div className='flex flex-col min-h-screen bg-back'>
            <h1 className="text-center mt-4 mb-4">Block Information by Type</h1>
            {blockData.map((info, index) => (
                <div key={index} className="ml-4 mt-2">
                    <h2>Type: <span className="text-blue-500">{info.type}</span></h2>
                    <p>Block Number: <span className="text-green-500">{info.number}</span></p>
                    <p>Block Hash: <span className="text-red-500">{info.hash}</span></p>
                </div>
            ))}
        </div>
    );
};

export default FetchBlockInfo;
