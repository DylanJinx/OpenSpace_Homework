// https://github.com/OpenSpace100/blockchain-tasks/tree/main/merkle_distributor
import { toHex, encodePacked, keccak256 } from 'viem';
import { MerkleTree } from "merkletreejs";

const users = [
    "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
    "0x70997970C51812dc3A010C7d01b50e0d17dc79C8",
    "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC",
    "0x90F79bf6EB2c4f870365E785982E1f101E93b906"
];

// 只使用用户的地址生成哈希
const elements = users.map((address) =>
    keccak256(encodePacked(["address"], [address as `0x${string}`]))
);

const merkleTree = new MerkleTree(elements, keccak256, { sort: true });

const root = merkleTree.getHexRoot();
console.log("root:" + root);

const leaf = elements[3];  // 示例，取第四个用户的叶子节点
const proof = merkleTree.getHexProof(leaf);
console.log("proof:" + proof);

/**
 * root:0xb4316902345b116c2107a907acd1ddb3b8bdb6ac431c386e16ffc220ab1943b0
 * proof:0x00314e565e0574cb412563df634608d76f5c59d9f817e85966100ec1d48005c0,0x4ed9d015110a35000ce5c94f94ccdc63653ddd26af11314d386ae5e65ef28c79
 */