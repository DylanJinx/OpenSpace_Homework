// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {RNTToken} from "./RNTToken.sol";
import {ReentrancyGuard} from "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";

// 预售价格：0.0001 ETH
// 预售数量：100W RNT
// 预售门槛：单笔最低买入0.01ETH，单个地址最高买入0.1ETH
// 募集目标：0.0001 * 1000000 = 100ETH，最多200ETH
contract RNTTokenIDO is Ownable(msg.sender), ReentrancyGuard {
    RNTToken public RNT;

    // 预售开始时间
    uint public immutable START_TIME;
    // 预售结束时间
    uint public immutable END_TIME;
    // 目标募资金额
    uint public immutable TARGET_ETH;
    // 最大募资金额
    uint public immutable MAX_ETH;
    // 预售RNT数量
    uint public immutable TOTAL_RNT;

    uint public totalETH;

    mapping(address => uint) public balances;
    

    constructor(address _RNT) {
        RNT = RNTToken(_RNT);

        START_TIME = block.timestamp;
        END_TIME = START_TIME + 7 days;
        TARGET_ETH = 100 ether;
        MAX_ETH = 200 ether;
        TOTAL_RNT = 1_000_000 * 10 ** 18;
    }

    // 去RNTToken合约中调用mint函数，将RNT代币分发到IDO合约中
    function mintRNT(uint amount) onlyOwner public {
        RNT.mintForIDO(amount);

        emit MintRNT(amount);
    }

    // 预售
    function presale() onlyActive(msg.value) onlyHaveRNT public payable {
        require(msg.value >= 0.01 ether && balances[msg.sender] + msg.value <= 0.1 ether, "S3TokenIDO: invalid amount");
        balances[msg.sender] += msg.value;
        totalETH += msg.value;

        emit Presale(msg.sender, msg.value);
    }

    // 预估现在的资金获得多少RNT
    function estRNTAmountNow() public view returns (uint) {
        return TOTAL_RNT * balances[msg.sender] / totalETH;
    }

    function estRNTAmountNew(uint eths) public view returns (uint) {
        return TOTAL_RNT * (balances[msg.sender] + eths) / (totalETH + eths);
    }

    // 如果募集成功，用户可以领取代币
    function claim() onlySuccess public {
        uint giveRNTAmount = TOTAL_RNT * balances[msg.sender] / totalETH;
        balances[msg.sender] = 0;
        RNT.transfer(msg.sender, giveRNTAmount);
        
        emit Claim(msg.sender, giveRNTAmount);
    }

    // 如果募集失败，用户可以领回ETH
    function refund() onlyFailed nonReentrant public {
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "S3TokenIDO: refund failed");

        emit Refund(msg.sender, amount);
    }

    // 项目方可以提取ETH
    function withdraw() onlySuccess nonReentrant public {
        uint _amount = address(this).balance;
        (bool success, ) = payable(owner()).call{value: _amount}("");
        require(success, "S3TokenIDO: withdraw failed");

        emit Withdraw(owner(), _amount);
    }

    // 这个合约必须拥有对应数量的RNT代币
    modifier onlyHaveRNT() {
        require(RNT.balanceOf(address(this)) >= TOTAL_RNT, "S3TokenIDO: insufficient RNT balance");
        _;
    }

    modifier onlySuccess() {
        require(block.timestamp > END_TIME && totalETH >= TARGET_ETH, "S3TokenIDO: presale failed");    
        _;
    }

    modifier onlyFailed() {
        require(block.timestamp > END_TIME && totalETH < TARGET_ETH, "S3TokenIDO: presale success");
        _;
    }

    modifier onlyActive(uint256 amount) {
        require(
            block.timestamp >= START_TIME && 
            block.timestamp <= END_TIME && 
            totalETH + amount <= MAX_ETH,
            "S3TokenIDO: presale not active");
        _;
    }

    event MintRNT(uint amount);
    event Presale(address indexed user, uint amount);
    event Claim(address indexed user, uint amount);
    event Refund(address indexed user, uint amount);
    event Withdraw(address indexed user, uint amount);
}