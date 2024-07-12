import { createPublicClient, http } from 'viem'
import { mainnet } from 'viem/chains';
import  { abi } from '../../OrbitNFTBackend/out/OrbitNFT.sol/Orbit.json'; 
import dotenv from 'dotenv';

async function main() {
    const client = createPublicClient({ 
        chain: mainnet, 
        transport: http(), 
    })

    const nftContractAddress = '0x0483b0dfc6c78062b9e999a82ffb795925381415'
    const tokenId = 1

    const owner = await client.readContract({
        address: nftContractAddress,
        abi: abi,
        functionName: 'ownerOf',
        args: [tokenId]
    })

    console.log("Orbit NFT is owned by:", owner)

    const tokenURI = await client.readContract({
        address: nftContractAddress,
        abi: abi,
        functionName: 'tokenURI',
        args: [tokenId]
    })

    console.log("tokenId of 1 URI is:", tokenURI)
}

main().catch(error => {
    console.error("Error:", error);
});

