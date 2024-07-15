'use client'
import ConnectButton from "@/components/ConnectButton";
import { useState } from "react";
import { useAccount, useAccountEffect } from 'wagmi';

interface AccountData {
  addresses?:readonly string[];
}

export default function Home() {
  const [accountData, setAccountData] = useState<AccountData | null>(null);
  const account = useAccount();

  useAccountEffect({
    onConnect(data) {
      console.log('Connected!', data)
      setAccountData(data);
    },
    onDisconnect() {
      console.log('Disconnected!')
      setAccountData(null);
    },
  });

  return (
    <div className='flex flex-col items-center justify-center min-h-screen bg-back p-4'>
      <ConnectButton />
      <div className='mt-2 text-gray-800'>
        {account?.address ? (
          <div className='text-blue-800'>Connected Address: {account.address}</div>
        ) : (
          <div className='text-blue-600'>Please connect your wallet.</div>
        )}
      </div>
      {account?.address && accountData?.addresses && (
        <div className='mt-2'>
          <div>Authorized Addresses:
            <ul className='list-disc pl-8'>
              {accountData.addresses.map((address, index) => (
                <li key={index}>Account {index + 1} address: {address}</li>
              ))}
            </ul>
          </div>
        </div>
      )}
    </div>
  );
}
