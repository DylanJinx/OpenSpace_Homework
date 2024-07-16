'use client'
import { useState } from 'react';
import {createPublicClient, http } from 'viem';
import { mainnet } from 'viem/chains';
import OrbitABI from "../abi/orbit.json";

const client = createPublicClient({
  chain: mainnet,
  transport: http(`https://mainnet.infura.io/v3/${process.env.NEXT_PUBLIC_INFURA_API_KEY}`) // 根据 Next.js 的约定，你需要将环境变量名从 INFURA_API_KEY 改为 NEXT_PUBLIC_INFURA_API_KEY，这样它才会在客户端 JavaScript 中可用
  //transport: http()
});

const contractAddress = '0x0483b0dfc6c78062b9e999a82ffb795925381415';

export default function Home() {
  //创建了一个名为 tokenId 的状态变量，并初始化为一个空字符串 ''。setTokenId 是一个函数，用于更新 tokenId 的值。使用 useState 钩子允许组件在不同的渲染周期之间保持状态。当你需要改变 tokenId 的值时，你会调用 setTokenId 函数，并传入新的值
  const [tokenId, setTokenId] = useState('');
  const [owner, setOwner] = useState('');
  const [tokenURI, setTokenURI] = useState('');
  //创建了一个名为 metaData 的状态变量，初始值为 null。由于它使用了 TypeScript 的 any 类型，这意味着 metaData 可以被设置为任何类型的值，提供了灵活性来存储任何形式的元数据。setMetaData 是一个函数，用来更新这个状态。
  const [metaData, setMetaData] = useState<any>(null);

  const handleTokenIdChange = (value: string) => {
    setTokenId(value); // 调用了之前通过 useState 定义的 setTokenId 函数，将传入的 value 设置为新的 tokenId。这通常在用户输入或选择一个新的 tokenId 时发生，例如，通过一个输入框。
    setOwner(''); // 调用 setOwner 函数并传入空字符串 ''，用于重置 owner 状态。这个操作的目的可能是确保每次 tokenId 改变时，相关联的 owner 信息也会被清除，防止显示前一个 tokenId 的所有者信息。
    setTokenURI(''); // 用于确保不会显示与旧 tokenId 相关的资源信息或元数据
  }

  const handleQuery = () => {
    // 调用 client.readContract 函数，该函数用于读取智能合约的数据。它接受一个对象作为参数，包含了智能合约的地址、ABI、函数名和参数等信息。在这里，我们使用了 OrbitABI 作为智能合约的 ABI，用于读取 tokenId 对应的 NFT 所有者和 tokenURI。
    client.readContract({
      address: contractAddress,
      abi: OrbitABI,
      functionName: 'ownerOf',
      args: [BigInt(tokenId)]
    }).then((res: any) => {
      setOwner(String(res));
    })
    client.readContract({
      address: contractAddress,
      abi: OrbitABI,
      functionName: 'tokenURI',
      args: [BigInt(tokenId)]
    }).then((res: any) => {
      setTokenURI(res);
      fetchTokenURI(res); // 调用 fetchTokenURI 函数，用于获取 tokenURI 对应的元数据
    })
  }

  function fetchTokenURI(tokenURI: string) {
    fetch(tokenURI.replace('ipfs://', 'https://ipfs.io/ipfs/'))
      .then(res => res.json())
      .then(res => {
        console.log(res);
        setMetaData(res);
      })
  }

  return (
    // className 是用来指定 HTML 元素的 CSS 类的属性。在这里，我们使用了 Tailwind CSS 提供的一些类名，用于设置元素的样式。这些类名可以帮助我们快速地构建出一个简单的 UI，而不需要写任何 CSS 代码。
    /* 这是一个假设的例子，实际的定义会依赖于你使用的 CSS 框架 */
    // .p-4 {
    //   padding: 1rem; /* 这通常对应于所有方向上的内边距为1rem */
    // }
    <div className='p-4'>
      <div className='mb-4'>
        <label className="mr-4">tokenId:</label>

        {/*shadow（阴影效果）、border（边框）、rounded（圆角）、w-40（宽度40单位）、py-2（垂直内边距）、px-3（水平内边距）、text-gray-700（文本颜色）、leading-tight（行高紧凑）、focus:outline-none（聚焦时无轮廓）、focus:shadow-outline（聚焦时阴影轮廓）*/}
        {/**
         * type="text"：指定输入框为文本类型。
         * placeholder="Enter tokenId"：当输入框为空时显示的占位符文本。
         * value={tokenId}：React 的受控组件属性，输入框的当前值绑定到状态变量 tokenId。
         * onChange={e => handleTokenIdChange(e.target.value)}：当用户在输入框中输入时触发的事件处理函数。这里传递输入框的当前值到 handleTokenIdChange 函数，该函数负责更新状态变量 tokenId。 */}
        <input className="
          shadow 
          appearance-none 
          border 
          rounded 
          w-40 
          py-2 
          px-3 
          mr-4 
          text-gray-700 
          leading-tight 
          focus:outline-none 
          focus:shadow-outline" 
          type="text"
          placeholder="Enter tokenId" 
          value={tokenId} 
        onChange={e => handleTokenIdChange(e.target.value)} />

        <button className="
          bg-blue-500 
          hover:bg-blue-700 
          text-white 
          font-bold 
          py-2 
          px-4 
          rounded 
          focus:outline-none 
          focus:shadow-outline" 
          onClick={handleQuery}>
            Query
        </button>

      </div>
      <div>
        {
          owner ? (
            <>
            {/**
             * <>...</>：这是 React 的 Fragment 简写语法，允许你组合多个元素而无需添加额外的 DOM 元素作为包裹层 
             */}
              <div className = 'text-2xl mb-2'>
                NFT Info
              </div>
              <p>
                <span className='text-gray-400 w-20 inline-block'>owner: </span>
                {owner}
              </p>
            </>
          ) : null
        }
      </div>
      <div className='mb-4'>
        {
          tokenURI ? (
            <p>
              <span className='text-gray-400 w-20 inline-block'>tokenURI: </span>
              {tokenURI}
            </p>
                    
          ) : null
        }
      </div>
      <div className='mb-4'>
        {
          metaData ? (
            <div className='flex'>
              <div className='mr-8'>
                <div className='text-2xl mb-2'>NFT Image</div>
                {/**
                 * src 属性定义图像的源 URL，即图像的位置。
                 * {metaData.image.replace('ipfs://', 'https://gateway.pinata.cloud/ipfs/')} 这部分使用 JavaScript 的字符串替换方法。metaData 是一个对象，它的 image 属性包含一个 IPFS 地址。由于 IPFS 地址 (ipfs://) 并不直接被浏览器支持，这里将它替换成一个可以被浏览器解析的 HTTP URL，使用了 Pinata 的 IPFS 网关。这样，IPFS 上存储的图片可以通过普通的 HTTP 协议被访问和显示。
                 * 
                 * alt 属性提供图片的替代文本，这是一个可访问性功能，使得当图像无法显示时（如网络问题或图像文件损坏），用户能够了解图像的内容。
                 * {metaData.name} 表示图片的描述或名称，这也是从 metaData 对象中取得。此属性对于搜索引擎优化（SEO）和屏幕阅读器用户来说非常重要，帮助他们理解图像的内容。
                 */}
                <img className='w-80' src={metaData.image.replace('ipfs://','https://gateway.pinata.cloud/ipfs/')} alt={metaData.name} />
              </div>
              <div className='flex-1'>
                <div className='text-2xl mb-2'>NFT Details</div>
                <p><span className='text-gray-400 w-20 inline-block'>name: </span>{metaData.name}</p>
                <p><span className='text-gray-400 w-20 inline-block'>desc: </span>{metaData.description || '-'}</p>
                <p><span className='text-gray-400 w-20 inline-block'>edition: </span>{metaData.edition}</p>
                {/**
                 * DNA像是一个哈希值或唯一标识符，用来确保每个 NFT 的唯一性。在 NFT 世界中，"DNA" 可能被用来生成或定义NFT的特定视觉或属性特征
                 */}
                <p><span className='text-gray-400 w-20 inline-block'>DNA: </span>{metaData.dna}</p>
                <p><span className='text-gray-400 w-20 inline-block'>date: </span>{new Date(metaData.date).toLocaleString()}</p>
                <p className='text-gray-400 inline-block'>attributes:</p>
                <table className="border">
                  <tbody>
                    {
                      metaData.attributes.map((item: any, index: number) => (
                        <tr key={index}>
                          <td className='px-4'>{item.trait_type}</td>
                          <td className='px-4'>{item.value}</td>
                        </tr>
                      ))
                    }
                  </tbody>
                </table>
              </div>
            </div>
          ) : null
        }
      </div>
    </div>
  )
}