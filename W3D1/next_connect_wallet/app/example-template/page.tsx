'use client';
import React, { useState, useEffect } from 'react';
import { createPublicClient, http } from 'viem';
import { mainnet } from 'viem/chains';

const client = createPublicClient({
    chain: mainnet,
    transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`)
});

const BlockNumberInfo = () => {
    const [blockNumber, setBlockNumber] = useState<bigint | null>(null);
    const [countdown, setCountdown] = useState<number>(16);

    useEffect(() => {
        const fetchBlockNumber = async () => {
            try {
                const number = await client.getBlockNumber();
                setBlockNumber(number);
            } catch (error) {
                console.error("Failed to fetch block number:", error);
            }
        };

        fetchBlockNumber(); // Initial fetch

        const intervalId = setInterval(() => {
            console.log("Fetching data...");
            fetchBlockNumber();
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

    return (
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', height: '100vh' }}>
            <h1>Block Number: <span className="text-green-500">{blockNumber !== null ? blockNumber.toString() : 'loading...'}</span></h1>
            <h2>Next fetch in: {countdown} seconds</h2>
        </div>
    );
}

export default BlockNumberInfo;


