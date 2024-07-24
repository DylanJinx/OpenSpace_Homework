'use client'
import React, { useState, useEffect } from 'react';
import { createPublicClient, http, keccak256, encodePacked, toHex } from 'viem';
import { sepolia } from 'viem/chains';

/**
 *     struct LockInfo{
        address user;
        uint64 startTime; 
        uint256 amount;
    }
 */
const client = createPublicClient({
    chain: sepolia,
    transport: http(`https://sepolia.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`)
});

const address = '0xA305A78AFC0CD40010c86053D3A92E538CEE309c';

interface LockInfo {
    user: string;
    startTime: number;
    amount: string;
}

// 解码用户地址和开始时间
const decodeUserStartTime = (data: string): { user: string, startTime: number } => {
    try {
        console.log('Data:', data);
        const userHex = '0x' + data.substring(data.length - 40);  // 最低20个字节，每个字节2个字符
        const startTimeHex = data.substring(10, 26);  // 用户地址左侧的8个字符（4个字节）

        console.log('User Hex:', userHex);
        console.log('Start Time Hex:', startTimeHex);

        return {
            user: userHex,
            startTime: parseInt(startTimeHex, 16)
        };
    } catch (error) {
        console.error('decodeUserStartTime error:', error);
        return { user: '0x', startTime: 0 };  // 发生错误时返回默认值
    }
};



const decodeAmount = (data: string): { amount: string } => {
    try {
        return {
            amount: BigInt(data).toString()
        };
    } catch (error) {
        console.error('decodeAmount error:', error);
        return { amount: '0' };  // 发生错误时返回默认值
    }
};

const TestComponent = () => {
    const [locksData, setLocksData] = useState<LockInfo[]>([]);

    const getStorageAt = async (index: bigint): Promise<string> => {
        const data = await client.getStorageAt({
            address: address,
            slot: toHex(index),
            blockTag: 'latest'
        });
        return data || "";
    };

    useEffect(() => {
        const fetchData = async () => {
            try {
                const arrayLengthHex = await getStorageAt(BigInt(0));
                const arrayLength = parseInt(arrayLengthHex, 16);

                console.log('Array Length:', arrayLength);

                const baseSlot = BigInt(keccak256(encodePacked(["uint256"], [BigInt(0)])));
                let allLocks: LockInfo[] = [];

                for (let i = 0; i < arrayLength; i++) {
                    console.log('Loop index:', i);

                    const slotUserStartTime = baseSlot + BigInt(2) * BigInt(i);
                    const slotAmount = slotUserStartTime + BigInt(1);

                    const dataUserStartTime = await getStorageAt(slotUserStartTime);
                    console.log('Data User StartTime:', dataUserStartTime);

                    const dataAmount = await getStorageAt(slotAmount);
                    console.log('Data Amount:', dataAmount);

                    const decodedUserStartTime = decodeUserStartTime(dataUserStartTime);
                    const decodedAmount = decodeAmount(dataAmount);

                    allLocks.push({
                        user: decodedUserStartTime.user,
                        startTime: decodedUserStartTime.startTime,
                        amount: decodedAmount.amount
                    });
                }

                console.log('All locks data before setting state:', allLocks);
                setLocksData(allLocks);

            } catch (error) {
                console.error('Failed to fetch storage data:', error);
                setLocksData([]);
            }
        };

        fetchData();
    }, []);

    return (
        <div>
            <h1 className="text-lg font-bold mb-4 text-center " style={{ color: '#66CDAA' }}>Locks Data</h1>
            <table className="min-w-full border border-gray-200 text-center">
                <thead>
                    <tr>
                        <th style={{ padding: '10px' }}>User</th>
                        <th style={{ padding: '10px' }}>Start Time</th>
                        <th style={{ padding: '10px' }}>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    {locksData.map((lock, index) => (
                        <tr key={index}>
                            <td style={{ padding: '10px' }}>{lock.user}</td>
                            <td style={{ padding: '10px' }}>{new Date(lock.startTime * 1000).toISOString()}</td>
                            <td style={{ padding: '10px' }}>{lock.amount}</td>
                        </tr>
                    ))}
                </tbody>
            </table>


        </div>
    );

}

export default TestComponent;