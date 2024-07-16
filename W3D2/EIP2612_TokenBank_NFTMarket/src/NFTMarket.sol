// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";

// sepolia contract address: 
contract NFTMarket is EIP712{
    using ECDSA for bytes32;

    struct SellOrder {
        address seller; // 卖家
        address nft; // NFT地址
        uint256 tokenId; // NFT tokenId
        uint256 price; // 价格
        uint256 deadline; // 截止时间
    }

    IERC20 public erc20;
    mapping(bytes32 => bool) public ordersFilled;

    constructor(address _erc20Address) EIP712("NFTMarket", "1") {
        erc20 = IERC20(_erc20Address);
    }

    // 购买函数，处理三种签名：销售订单签名、ERC20授权签名、白名单签名
    // function buy(
    //     SellOrder calldata order,
    //     uint8 vSell, bytes32 rSell, bytes32 sSell,
    //     uint deadlineApprove, uint8 vApprove, bytes32 rApprove, bytes32 sApprove,
    //     uint8 vWL, bytes32 rWL, bytes32 sWL
    // ) external {
    //     // 验证销售订单的签名是否有效
    //     bytes32 orderHash = _hashTypedDataV4(keccak256(abi.encode(
    //         keccak256("SellOrder(address seller,address nft,uint256 tokenId,uint256 price,uint256 deadline)"),
    //         order.seller,
    //         order.nft,
    //         order.tokenId,
    //         order.price,
    //         order.deadline
    //     )));

    //     require(order.deadline >= block.timestamp, "Order expired");
    //     require(recoverSigner(orderHash, vSell, rSell, sSell) == order.seller, "Invalid signature for sell order");
    //     require(!ordersFilled[orderHash], "Order already filled");

    //     // 验证白名单签名
    //     bytes32 whitelistHash = keccak256(abi.encodePacked(msg.sender));
    //     require(recoverSigner(whitelistHash, vWL, rWL, sWL) == order.seller, "Not authorized by whitelist");

    //     // 通过EIP-2612的permit方法授权ERC20代币转账
    //     IERC20Permit(address(erc20)).permit(msg.sender, address(this), order.price, deadlineApprove, vApprove, rApprove, sApprove);

    //     // 转账ERC20代币支付NFT
    //     erc20.transferFrom(msg.sender, order.seller, order.price);

    //     // 转移NFT给买家
    //     IERC721(order.nft).safeTransferFrom(order.seller, msg.sender, order.tokenId);

    //     // 标记订单为已完成
    //     ordersFilled[orderHash] = true;
    // }

    // //从签名中恢复出签名者地址
    // function recoverSigner(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
    //     // 使用 ECDSA 库的 toEthSignedMessageHash 方法将 hash 转换为符合 Ethereum 签名标准的哈希
    //     address signer = ECDSA.recover(hash, v, r, s);
    //     // 恢复签名者地址
    //     return signer;
    // }
}
