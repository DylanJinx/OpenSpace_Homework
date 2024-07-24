'use client'
import React, { useState, useEffect } from 'react';
import { createPublicClient, http, encodeAbiParameters, parseAbiParameters } from 'viem';
import { mainnet } from 'viem/chains';
import { decodeAbiParameters } from 'viem';

const client = createPublicClient({
    chain: mainnet,
    transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`)
});

const TestComponent = () => {
    const [encodedWithObjects, setEncodedWithObjects] = useState('');
    const [encodedWithHumanReadable, setEncodedWithHumanReadable] = useState('');

    const [decodedWithObjects, setDecodedWithObjects] = useState({});
    const [decodedWithHumanReadable, setDecodedWithHumanReadable] = useState({});


    // 辅助函数，用于处理编码字符串，使第一行包含34个字节，后面每行32个字节
    const formatEncodedOutput = (encodedString: any) => {
        if (!encodedString.startsWith('0x')) return encodedString;
        // 从0x后开始每64个字符截断，首行包括0x
        const firstLine = encodedString.substring(0, 66); // '0x' + 32 bytes
        const remainingLines = encodedString.substring(66).match(/.{1,64}/g)?.join('\n') || '';
        return `\n${firstLine}\n${remainingLines}`;
    };

    // 定义一个 replacer 函数用于在 JSON.stringify 时处理 BigInt
    const replacer = (key: any, value: any) =>
        typeof value === 'bigint' ? value.toString() + 'n' : value; // 将 BigInt 转换为字符串并添加 'n' 来表示它是 BigInt

    useEffect(() => {
        const encodedData = '0x000000000000000000000000123456789012345678901234567890123456789000000000000000000000000000000000000000000000000000000000499602d2000000000000000000000000000000000000000000000000ab54a98ceb1f0ad2';

        const fetchEncodedValues = async () => {
            // 编码使用具体对象定义的参数
            const encodedObjects = encodeAbiParameters(
                [{ type: 'address', name: 'user' }, { type: 'uint64', name: 'startTime' }, {type: 'uint256', name: 'amount'}],
                ['0x1234567890123456789012345678901234567890', 1234567890n, 12345678901234567890n]
            );

            // 编码使用可读的 ABI 定义
            const encodedHumanReadable = encodeAbiParameters(
                parseAbiParameters('address, uint64, uint256'),
                ['0x1234567890123456789012345678901234567890', 1234567890n, 12345678901234567890n]
            );

            setEncodedWithObjects(formatEncodedOutput(encodedObjects));
            setEncodedWithHumanReadable(formatEncodedOutput(encodedHumanReadable));

            // 使用对象定义解码
            const resultWithObjects = decodeAbiParameters(
                [{ type: 'address', name: 'user' }, { type: 'uint64', name: 'startTime' }, {type: 'uint256', name: 'amount'}],
                encodedData
            );

            // 使用人类可读的 ABI 定义解码
            const resultWithHumanReadable = decodeAbiParameters(
                parseAbiParameters('(address user, uint64 startTime, uint256 amount)'),
                encodedData
            );

            setDecodedWithObjects(resultWithObjects);
            setDecodedWithHumanReadable(resultWithHumanReadable);
        };

        fetchEncodedValues();
    }, []);

    return (
        <div>
            <h1 className="text-lg font-bold mb-4 text-center " style={{ color: '#66CDAA' }}>abi encode & decode</h1>
            <pre>Encoded with Object Definitions: {encodedWithObjects}</pre>
            <pre>Encoded with Human Readable: {encodedWithHumanReadable}</pre>

            <h3>Decoded with Object Definitions: </h3>
            <pre>{JSON.stringify(decodedWithObjects, replacer, 2)}</pre>
            <h3>Decoded with Human Readable: </h3>
            <pre>{JSON.stringify(decodedWithHumanReadable, replacer, 2)}</pre>
        </div>
    );
}

export default TestComponent;
