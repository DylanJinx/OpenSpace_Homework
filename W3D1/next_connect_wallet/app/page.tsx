'use client'
import ConnectButton from "@/components/ConnectButton";
import { useState } from "react";
import { useAccount, useAccountEffect } from 'wagmi';
import Link from 'next/link';

interface AccountData {
  addresses?: readonly string[];
}

export default function Home() {
  const [accountData, setAccountData] = useState<AccountData | null>(null);
  const account = useAccount();

  useAccountEffect({
    onConnect(data) {
      console.log('Connected!', data);
      setAccountData(data);
    },
    onDisconnect() {
      console.log('Disconnected!');
      setAccountData(null);
    },
  });

  return (
    <div className='flex flex-col min-h-screen bg-back'>
      {/* Top right content with Connect Button and account information */}
      <div className='flex justify-end items-start p-4'>
        <div>
          <ConnectButton />
          {account?.address ? (
            <div className='text-blue-800'>Connected Address: {account.address}</div>
          ) : (
            <div className='text-blue-600'>Please connect your wallet.</div>
          )}
          {account?.address && accountData?.addresses && (
            <div>
              <div>Authorized Addresses:
                <ul className='list-disc'>
                  {accountData.addresses.map((address, index) => (
                    <li key={index}>Account {index + 1} address: {address}</li>
                  ))}
                </ul>
              </div>
            </div>
          )}
        </div>
      </div>
      
      <div className='flex items-center justify-center space-x-4 mb-10'>
        <span className="text-xl font-bold text-blue-800">W3D4 Homework</span> 
        <Link 
          href="/BlockNumberAndHash" 
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          W3D4-1: Listens for new blocks, prints block high and block hash values
        </Link>
        <Link 
          href="/blockhash" 
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          W3D4-2: USDT Token Transaction Flow
        </Link>
        <Link 
          href="/USDTTokenTransactionFlow" 
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          test
        </Link>
      </div>

    </div>
  );
}
