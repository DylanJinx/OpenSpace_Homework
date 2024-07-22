// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";

/**
 * forge create --rpc-url sepolia --account Dylan_5900 Dylan_NFTMarket
 * 
 * 
 * 
 * Ownable is msg.sender, he can change the WL_SIGNER 
 *
 * There is no handling fee for nft purchases from whitelisted buyers, otherwise there is a 3/1000ths handling fee
 *
 * Note: 
 * NFTMarket charges a 0.3% fee to NFT sellers (variable feeBP). If feeTo is address(0), no seller fee is charged; otherwise, a fee equal to feeBP is deducted.
 * NFTMarket supports NFT sellers in listing NFT orders that require a whitelist signature from buyers. Thus, the SellOrder struct includes a field named needWLSign.
 * - Case 1: If feeTo = address(0) and needWLSign = false, no handling fee is charged and no whitelist signature is required. The full buyer.value is directly transferred to the seller.
 * - Case 2: If feeTo = address(0) and needWLSign = true, no handling fee is charged, but a whitelist signature is required. The full buyer.value is directly transferred to the seller.
 * - Case 3: If feeTo != address(0) and needWLSign = false, a handling fee is charged and no whitelist signature is required. The seller receives buyer.value - fee, and feeTo receives buyer.value * feeBP / 10000.
 * - Case 4: If feeTo != address(0) and needWLSign = true, a handling fee is charged and a whitelist signature is required. The seller receives buyer.value - fee, and feeTo receives buyer.value * feeBP / 10000.
 */

contract Dylan_NFTMarket is EIP712("NFTMarket_Dylan", "1"), Ownable(msg.sender) {
    using ECDSA for bytes32;

    uint256 public constant feeBP = 30; // 30 Basis Points which equals 0.3%
    // the address is used to collect handling fees
    // if feeTo = address(0), it means no handling fee for the seller
    address public feeTo;

    // ERC20 Signature data for authorized transfers
    struct ERC20PermitData {
        uint8 v;
        bytes32 r;
        bytes32 s;
        address token;
        uint256 deadline;
    }

    // Seller lists NFT's data without using signatures
    struct SellOrder {
        address seller;
        address nft;
        uint256 tokenId;
        address payToken;
        uint256 price;
        uint256 deadline;
        bool needWLSign;
    }
    // Seller lists NFT's data without using signatures
    struct SellOrderWithSignature {
        SellOrder order;
        bytes signature;
    }
    // 白名单签名数据
    struct WLData {
        address nft;
        address user;
        bytes signature;
    }

    // Write typehash in the structhash that wastes gas and whitelists inside the function body
    bytes32 public constant WL_TYPEHASH = keccak256("BuyWithWL(address nft, address user)");
    bytes32 public constant LISTING_TYPEHASH = keccak256("buyWithWLAndListSign(address seller, address nft, uint256 tokenId, address payToken, uint256 price, uint256 deadline)");
    
    // true is purchased with a signature, false is not purchased
    mapping(bytes32 => bool) public filledOrders;
    // seller use signature to list, but want to cancel, if ListSignButCancel is true, the order is canceled
    mapping(bytes => bool) public ListSignButCancel;
    // The listingOrders mapping acts as an order book in the smart contract, recording the details of all NFTs that are currently being sold
    mapping(bytes32 => SellOrder) public listingOrders;
    // reset, Confirm the current sales order status given the NFT and tokenId
    mapping(address => mapping(uint256 => bytes32)) private lastorderHashId_;
    // key: nft address, value: WLSigner
    mapping(address => address) public nft_WLSigner;
    

    function list(
        address _nft, 
        uint256 _tokenId, 
        address _payToken, 
        uint256 _price, 
        uint256 _deadline,
        bool _needWLSign
    ) external {
        require(_deadline > block.timestamp, "NFTMarket_Dylan: deadline is in the past!");
        require(_price > 0, "NFTMarket_Dylan: price is zero.");
        // When the address 0 is returned, it means that the receiving ETH
        // totalSupply() : return the value of tokens in existence.
        require(_payToken == address(0) || IERC20(_payToken).totalSupply() > 0, "NFTMarket_Dylan: payToken is not a valid ERC20 token.");

        // check
        require(IERC721(_nft).ownerOf(_tokenId) == msg.sender, "NFTMarket_Dylan: not owner");
        require(
            IERC721(_nft).getApproved(_tokenId) == address(this) || IERC721(_nft).isApprovedForAll(msg.sender, address(this)),
            "NFTMarket_Dylan: not approved");

            SellOrder memory order_ = SellOrder({
                seller: msg.sender,
                nft: _nft,
                tokenId: _tokenId,
                payToken: _payToken,
                price: _price,
                deadline: _deadline,
                needWLSign: _needWLSign
            });

            // Each NFT message generates a unique identifier
            bytes32 orderHashId = keccak256(abi.encode(order_));

            // safe check repeat list
            require(listingOrders[orderHashId].seller == address(0), "NFTMarket_Dylan: order already listed");

            listingOrders[orderHashId] = order_;
            lastorderHashId_[_nft][_tokenId] = orderHashId;

            emit Listed(_nft, _tokenId, orderHashId, msg.sender, _payToken, _price, _deadline, _needWLSign);
    }

    // Check to see if it's on the shelf, return the orderHashId
    function isListed(
        address _nft, 
        uint256 _tokenId
    ) external view returns (bytes32) {
        bytes32 orderHashId = lastorderHashId_[_nft][_tokenId];
        return listingOrders[orderHashId].seller == address(0) ? bytes32(0x00) : orderHashId;
    }

    // cancel the order
    function cancel(bytes32 _orderHashId) external {
        address seller = listingOrders[_orderHashId].seller;
        require(seller != address(0), "NFTMarket_Dylan: order not listed");
        require(seller == msg.sender, "NFTMarket_Dylan: only seller can cancel");
        delete listingOrders[_orderHashId];
        emit Cancel(_orderHashId);
    }

    // ------------------------------ one signature: seller signing whitelist ------------------------------
    // seller need approve one NFT or all NFTs to NFTMarket first (onchain), and then list a NFT (onchain)
    // buyer need approve NFTMarket to transfer ERC20 token first (onchain), and then buy a NFT (onchain)

    // Purchase from non-whitelisted users
    function buy(bytes32 _orderHashId) public payable {
        // 0. load order info to memory for check
        SellOrder memory order = listingOrders[_orderHashId];

        // Check whether this NFT requires whitelisting
        if (order.needWLSign) {
            revert NeedWLSign();
        }
        _buy(order, feeTo);
    }

    // Purchase from whitelisted users 
    function buy(
        bytes32 _orderHashId, 
        bytes calldata _signatureForWL
    ) external payable {
        // 0. load order info to memory for check
        SellOrder memory order = listingOrders[_orderHashId];

        // Check whether this NFT requires whitelisting
        if (!order.needWLSign) {
            revert NotNeedWLSign();
        }
        
        _checkWL(order.nft, _signatureForWL);
        
        _buy(order, feeTo);
    }

    // ------------------------------ two signatures: seller signing whitelist and buyer signing ERC20Permit ------------------------------
    // seller need approve one NFT or all NFTs to NFTMarket first (onchain), and then list a NFT (onchain)
    // buyer need sign the approveERC20 to NFTMarket first (offchain), and then buy a NFT (onchain)
    // If the buyer brings his ERC20Permit signature to make a purchase, it means that the payment was made with ERC20, so function have not payable
    function buy(
        bytes32 _orderHashId, 
        ERC20PermitData calldata _approveData
    ) external {
        // load order info to memory for check
        SellOrder memory order = listingOrders[_orderHashId];

        // Check whether this NFT requires whitelisting
        if (order.needWLSign) {
            revert NeedWLSign();
        }

        // Check which Token this NFT needs to be paid with
        require(order.payToken != address(0), "NFTMarket_Dylan: not need ERC20");

        // check NFT need token is the same as the token in the _approveData
        require(order.payToken == _approveData.token, "NFTMarket_Dylan: wrong token");
    
        // permit: approve ERC20 for nftMarket
        IERC20Permit(_approveData.token).permit(
            msg.sender, 
            address(this), 
            order.price,
            _approveData.deadline, 
            _approveData.v, 
            _approveData.r, 
            _approveData.s
        );

        _buy(order, feeTo);
        
    }

    function buy(
        bytes32 _orderHashId, 
        ERC20PermitData calldata _approveData,
        bytes calldata _signatureForWL
    ) external {
        // load order info to memory for check
        SellOrder memory order = listingOrders[_orderHashId];

        // Check whether this NFT requires whitelisting
        if (!order.needWLSign) {
            revert NotNeedWLSign();
        }
        _checkWL(listingOrders[_orderHashId].nft, _signatureForWL);

        // Check which Token this NFT needs to be paid with
        require(order.payToken != address(0), "NFTMarket_Dylan: not need ERC20");

        // check NFT need token is the same as the token in the _approveData
        require(order.payToken == _approveData.token, "NFTMarket_Dylan: wrong token");
    
        // permit: approve ERC20 for nftMarket
        IERC20Permit(_approveData.token).permit(
            msg.sender, 
            address(this), 
            order.price,
            _approveData.deadline, 
            _approveData.v, 
            _approveData.r, 
            _approveData.s
        );

        _buy(order, feeTo);
    }

// ------------------------------ three signatures: seller signing List, seller signing whitelist and buyer signing ERC20Permit ------------------------------
    // seller need sign list to market (offchain), and then  approve this NFT (onchain)
    // buyer need sign the approveERC20 to NFTMarket first (offchain), and then buy a NFT (onchain)
    // If the buyer brings his ERC20Permit signature to make a purchase, it means that the payment was made with ERC20, so function have not payable
    // Because the NFT owner is signed off-chain, some important information (such as whether a whitelist signature is required) is displayed on the centralized page, but because it is not listed on the chain, this important information is not saved on the chain. Therefore, Need to verify whether needWLSign is true or false.
    function Verify_LSForNeedWLSign (
        SellOrder memory _order,
        bytes calldata _signature
    ) private returns (bool) {
        SellOrder memory NeedWLSignOrder = SellOrder({
            seller: _order.seller,
            nft: _order.nft,
            tokenId: _order.tokenId,
            payToken: _order.payToken,
            price: _order.price,
            deadline: _order.deadline,
            needWLSign: true
        });

        SellOrder memory NotNeedWLSignOrder = SellOrder({
            seller: _order.seller,
            nft: _order.nft,
            tokenId: _order.tokenId,
            payToken: _order.payToken,
            price: _order.price,
            deadline: _order.deadline,
            needWLSign: false
        });

        if (_checkListSign(NeedWLSignOrder, _signature)) {
            return true;
        } else if (_checkListSign(NotNeedWLSignOrder, _signature)) {
            return false;
        } else {
            revert("NFTMarket_Dylan: Invalid signature");
        }
    }

    function _checkListSign(SellOrder memory _order, bytes calldata _signature) private returns (bool) {
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    LISTING_TYPEHASH,
                    _order.seller,
                    _order.nft,
                    _order.tokenId,
                    _order.payToken,
                    _order.price,
                    _order.deadline,
                    _order.needWLSign
                )
            )
        );

        address signer = ECDSA.recover(digest, _signature);
        if (signer != _order.seller) return false;
        if (filledOrders[digest]) return false;

        filledOrders[digest] = true;  // Mark the order as filled

        address NFTOwner = IERC721(_order.nft).ownerOf(_order.tokenId);
        return (signer == NFTOwner);
    }

    // Purchase from non-whitelisted users
    function buy(
        ERC20PermitData calldata _approveData,
        SellOrderWithSignature calldata _sellOrderWithSignature
    ) external {
        if (ListSignButCancel[_sellOrderWithSignature.signature]) {
            revert Order_Already_Canceled();
        }

        // load order info to memory for check
        SellOrder memory order = _sellOrderWithSignature.order;

        if (Verify_LSForNeedWLSign(order, _sellOrderWithSignature.signature) == true) {
            revert NeedWLSign_Or_ErrorSigner();
        }

        // Check which Token this NFT needs to be paid with
        require(order.payToken != address(0), "NFTMarket_Dylan: not need ERC20");

        // check NFT need token is the same as the token in the _approveData
        require(order.payToken == _approveData.token, "NFTMarket_Dylan: wrong token");
    
        // permit: approve ERC20 for nftMarket
        IERC20Permit(_approveData.token).permit(
            msg.sender, 
            address(this), 
            order.price,
            _approveData.deadline, 
            _approveData.v, 
            _approveData.r, 
            _approveData.s
        );

        _buy(order, feeTo);
        
    }

    function buy(
        ERC20PermitData calldata _approveData,
        bytes calldata _signatureForWL,
        SellOrderWithSignature calldata _sellOrderWithSignature
    ) external {
        if (ListSignButCancel[_sellOrderWithSignature.signature]) {
            revert Order_Already_Canceled();
        }

        // load order info to memory for check
        SellOrder memory order = _sellOrderWithSignature.order;


        if (Verify_LSForNeedWLSign(order, _sellOrderWithSignature.signature) == false) {
            revert NoNeedWLSign_Or_ErrorSigner();
        }

        _checkWL(order.nft, _signatureForWL);

        // Check which Token this NFT needs to be paid with
        require(order.payToken != address(0), "NFTMarket_Dylan: not need ERC20");

        // check NFT need token is the same as the token in the _approveData
        require(order.payToken == _approveData.token, "NFTMarket_Dylan: wrong token");
    
        // permit: approve ERC20 for nftMarket
        IERC20Permit(_approveData.token).permit(
            msg.sender, 
            address(this), 
            order.price,
            _approveData.deadline, 
            _approveData.v, 
            _approveData.r, 
            _approveData.s
        );

        _buy(order, feeTo);
    }

    // ------------------------------ two signatures: seller signing list and seller signing whitelist  ------------------------------
    // seller need sign list to market (offchain), and then  approve this NFT (onchain)
    // buyer need approve NFTMarker first (onchain), and then buy a NFT (onchain)
    // Purchase from non-whitelisted users
    function buy(
        SellOrderWithSignature calldata _sellOrderWithSignature
    ) external payable {
        if (ListSignButCancel[_sellOrderWithSignature.signature]) {
            revert Order_Already_Canceled();
        }

        // load order info to memory for check
        SellOrder memory order = _sellOrderWithSignature.order;

        if (Verify_LSForNeedWLSign(order, _sellOrderWithSignature.signature) == true) {
            revert NeedWLSign_Or_ErrorSigner();
        }

        _buy(order, feeTo);
        
    }

    function buy(
        bytes calldata _signatureForWL,
        SellOrderWithSignature calldata _sellOrderWithSignature
    ) external payable {
        if (ListSignButCancel[_sellOrderWithSignature.signature]) {
            revert Order_Already_Canceled();
        }

        // load order info to memory for check
        SellOrder memory order = _sellOrderWithSignature.order;


        if (Verify_LSForNeedWLSign(order, _sellOrderWithSignature.signature) == false) {
            revert NoNeedWLSign_Or_ErrorSigner();
        }

        _checkWL(order.nft, _signatureForWL);

        _buy(order, feeTo);
    }

        function _buy(
        SellOrder memory order, 
        address _feeReceiver
    ) private {

        // 1. check
        require(order.seller != address(0), "NFTMarket_Dylan: order not listed");
        require(order.deadline >= block.timestamp, "NFTMarket_Dylan: order expired");

        // 2. transfer NFT
        IERC721(order.nft).safeTransferFrom(order.seller, msg.sender, order.tokenId);

        // 3. transfer Token
        // fee 0.3% or 0
        uint256 fee = 0;
        if (_feeReceiver != address(0)) {
            // no fee for seller
            fee = order.price * feeBP / 10000;
        }

        if (order.payToken == address(0)) {
            require(msg.value == order.price, "NFTMarket_Dylan: wrong eth value");
        } else {
            require(msg.value == 0, "NFTMarket_Dylan: you should not send eth, use ERC20Token instead");
        }

        // need buyer approve NFTMarker first
        _transferOut(order.payToken, order.seller, order.price - fee);

        if (fee > 0) {
            _transferOut(order.payToken, _feeReceiver, fee);
        }

        emit Purchased(order.tokenId, order.seller, msg.sender, order.price);
    }

    function _transferOut(
        address _ERC20Token, 
        address _seller, 
        uint256 _amount
    ) private {
        if (_ERC20Token == address(0)) {
            (bool success, ) = _seller.call{value: _amount}("");
            require(success, "NFTMarket_Dylan: eth transfer failed");
        } else {
            require(
                IERC20(_ERC20Token).transferFrom(msg.sender, _seller, _amount),
                "NFTMarket_Dylan: erc20 transfer failed"
            );
        }
    }


    // public domain separator
    function getDomainSeparator() external view returns (bytes32) {
        return _domainSeparatorV4();
    }

    function _checkWL(address _nftContract, bytes calldata _signatureForWL) private view {
        // Check that the white slip signature is from the program side of the signature
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    WL_TYPEHASH,
                    _nftContract,
                    msg.sender
                )
            )
        );

        address signerForWL = ECDSA.recover(digest, _signatureForWL);

        require(signerForWL == nft_WLSigner[_nftContract], "Invalid signature, you are not in WL");
    }


    function setFeeTo(address _to) external onlyOwner {
        require(feeTo != _to, "NFTMarket_Dylan: feeTo is the same");
        feeTo = _to;

        emit FeeToChanged(feeTo);
    }

    function setNFT_WLSigner(address _nftContract, address _WLSigner) external onlyOwner {
        require(_nftContract != address(0), "NFTMarket_Dylan: nftContract is the zero address");
        require(_WLSigner != address(0), "NFTMarket_Dylan: WLSigner is the zero address");
        require(nft_WLSigner[_nftContract] != _WLSigner, "NFTMarket_Dylan: WLSigner is the same");

        nft_WLSigner[_nftContract] = _WLSigner;

        emit WLSignerChanged(_nftContract, _WLSigner);

    }

    // If the seller is uploading NFTs by means of offline signatures, this method needs to be called when downloading a particular NFT
    function ListSignCancel(SellOrderWithSignature calldata _sellOrderWithSignature) public {
        require(_sellOrderWithSignature.order.seller == msg.sender, "NFTMarket_Dylan: only seller can cancel");
        if (!_checkListSign(_sellOrderWithSignature.order, _sellOrderWithSignature.signature)) {
            revert("NFTMarket_Dylan: Invalid signature");
        }

        if (ListSignButCancel[ _sellOrderWithSignature.signature]) {
            revert("NFTMarket_Dylan: order already canceled");
        }
        ListSignButCancel[ _sellOrderWithSignature.signature] = true;
    }

    event Purchased(
        uint256 indexed tokenId, 
        address indexed seller,
        address indexed buyer, 
        uint256 price
    );

    event Listed(
        address indexed nft, 
        uint256 indexed tokenId, 
        bytes32 indexed orderHashId, 
        address seller, 
        address payToken, 
        uint256 price, 
        uint256 deadline,
        bool needWLSign
    );

    event Cancel(bytes32 indexed orderHashId);
    event FeeToChanged(address indexed feeTo);
    event WLSignerChanged(address indexed nftContract, address indexed WLSigner);

    error PaymentFailed(address buyer, address seller, uint256 price);
    error NeedWLSign();
    error NotNeedWLSign();
    error NeedWLSign_Or_ErrorSigner();
    error NoNeedWLSign_Or_ErrorSigner();
    error Order_Already_Canceled();


    
}
