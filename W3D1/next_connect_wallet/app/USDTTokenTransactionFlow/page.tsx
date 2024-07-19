'use client';
import React, { useState, useEffect } from 'react';
import { createPublicClient, http } from 'viem';
import { mainnet } from 'viem/chains';

const client = createPublicClient({
    chain: mainnet,
    transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`)
});

const test = () => {
    return (
        <div>
            <h1>Test</h1>
        </div>
    );
}

export default test;