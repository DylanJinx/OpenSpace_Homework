'use client'
import ConnectButton from "@/components/ConnectButton";
import { useState } from "react";
import { useAccount, useAccountEffect } from 'wagmi'

// 定义 TypeScript 接口（如果使用 TS）
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
    <div className='p-4'>
      <ConnectButton />
      <div className='mt-2 text-gray-800'>
        {account?.address ? (
          <div>Connected Address: {account.address}</div>
        ) : (
          <div className='text-red-600'>Not connected yet, please click the button above to connect your wallet.</div>
        )}
      </div>
      {account?.address && accountData?.addresses && (
        <div className='mt-2'>
          <div>Authorized Addresses:
            <ul className='list-disc pl-8'>
              {accountData.addresses.map((address, index) => (
                <li key={index}>{address}</li>
              ))}
            </ul>
          </div>
        </div>
      )}
    </div>
  );
}
