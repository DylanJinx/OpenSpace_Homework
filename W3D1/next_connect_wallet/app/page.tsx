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
          href="/W3D4_BlockNumberAndHash"
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          W3D4-1: Listens for new blocks, prints block high and block hash values
        </Link>
        <Link
          href="/W3D4_USDTTokenTransactionFlow"
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          W3D4-2: USDT Token Transaction Flow
        </Link>
      </div>
      <div className='flex items-center justify-center space-x-4 mb-10'>
        <span className="text-xl font-bold text-blue-800">W4D3 Homework</span>
        <Link
          href="/W4D3_read_esRNT_contract_data_from_solt"
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          Read esRNT contract data from solt
        </Link>
      </div>
      <div className='flex items-center justify-center space-x-4 mb-10'>
        <span className="text-xl font-bold text-blue-800">Viem Examples</span>
        <Link
          href="/example-template"
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          example-template
        </Link>
        <Link
          href="/encode_decode"
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          abi encode & decode
        </Link>
        <Link
          href="/blocks_fetching-blocks"
          className="px-6 py-3 bg-blue-500 text-white font-bold rounded hover:bg-blue-700 transition duration-300">
          blocks_fetching-blocks
        </Link>

      </div>

    </div>
  );
}
