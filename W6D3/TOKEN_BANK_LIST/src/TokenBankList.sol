// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

contract TokenBankList {
    using SafeERC20 for IERC20;

    mapping(address => uint256) public tokenBalances;
    mapping(address => address) _nextDepositers;
    uint256 public listSize;
    address constant GUARD = address(1);

    address public immutable token;

    constructor(address _token) {
        _nextDepositers[GUARD] = GUARD;
        token = _token;
    }

    function addDepositer(
        address _Depositer, // 要添加的存款人地址
        uint256 _amount,  // 存款的数量
        address _prevDepositer // 新存款人插入在这个存款人之后
    ) public {
        // 检查新加入的存款人是否已经在链表中
        require(_nextDepositers[_Depositer] == address(0), "Depositer already exists");
        // 检查前一个存款人必须已经在链表中（即其地址应有后继节点）
        require(_nextDepositers[_prevDepositer] != address(0), "_prevDepositer not exists");
        require(_verifyIndex(_prevDepositer, _amount, _nextDepositers[_prevDepositer]), "invalid index");

        // 检查是否授权
        require(IERC20(token).allowance(_Depositer, address(this)) >= _amount, "Not enough allowance");

        tokenBalances[_Depositer] = _amount;
        _nextDepositers[_Depositer] = _nextDepositers[_prevDepositer]; // 新存款人指向前一个存款人原来的指向
        _nextDepositers[_prevDepositer] = _Depositer; // 前一个存款人现在指向新存款人
        listSize++;

        // 调用transferFrom()
        IERC20(token).safeTransferFrom(_Depositer, address(this), _amount);

        emit Deposit(_Depositer, _amount);
    }

    function removeDepositer(
        address _Depositer, // 要删除的存款人
        address _prevDepositer // 前一个存款人
    ) private {
        require(_nextDepositers[_Depositer] != address(0), "Depositer not exists");
        require(_isPrevDepositer(_Depositer, _prevDepositer), "invalid index");

        // 调用transfer()
        IERC20(token).safeTransfer(_Depositer, tokenBalances[_Depositer]);
        emit RemoveDepositer(_Depositer, tokenBalances[_Depositer]);

        _nextDepositers[_prevDepositer] = _nextDepositers[_Depositer]; // 被移除存款人的前一个存款人的后继节点更新为被移除存款人的后继节点
        _nextDepositers[_Depositer] = address(0); // 被移除存款人的后继节点置为0
        tokenBalances[_Depositer] = 0;
        listSize--;

    }

    function deposit(
        address _Depositer,
        uint256 _amount,
        address _oldPrevDepositer,
        address _newPrevDepositer
    ) public {
        require(_amount > 0, "Amount must be greater than 0");

        updateAmount(_Depositer, tokenBalances[_Depositer] + _amount, _oldPrevDepositer, _newPrevDepositer);
    }

    function withdraw(
        address _Depositer,
        uint256 _amount,
        address _oldPrevDepositer,
        address _newPrevDepositer
    ) public {
        require(_amount > 0, "Amount must be greater than 0");
        require(tokenBalances[_Depositer] >= _amount, "Insufficient balance");

        updateAmount(_Depositer, tokenBalances[_Depositer] - _amount, _oldPrevDepositer, _newPrevDepositer);
    }

    function updateAmount(
        address _Depositer,
        uint256 _newBalance,
        address _oldPrevDepositer,
        address _newPrevDepositer
    ) public {
        // 检查添加存款的人是否已经在链表中
        require(_nextDepositers[_Depositer] != address(0), "Depositer not exists");
        require(_nextDepositers[_oldPrevDepositer] != address(0), "oldCandidateDepositer not exists");
        require(_nextDepositers[_newPrevDepositer] != address(0), "newCandidateDepositer not exists");

        uint _balance = tokenBalances[_Depositer];

        if (_oldPrevDepositer == _newPrevDepositer) {
            require(_isPrevDepositer(_Depositer, _oldPrevDepositer), "invalid index");
            require(_verifyIndex(_newPrevDepositer, _newBalance, _nextDepositers[_newPrevDepositer]), "invalid index");
            tokenBalances[_Depositer] = _newBalance;

            if (_balance < _newBalance) { // deposit
                IERC20(token).safeTransferFrom(_Depositer, address(this), _newBalance - _balance);
                emit Deposit(_Depositer, _newBalance - _balance);
            } else { // withdraw
                IERC20(token).safeTransfer(_Depositer, _balance - _newBalance);
                emit Withdraw(_Depositer, _balance - _newBalance);
            }
        } else {
            removeDepositer(_Depositer, _oldPrevDepositer);
            addDepositer(_Depositer, _newBalance, _newPrevDepositer);
        }
    }

    function getTop(uint256 k) public view returns(address[] memory) {
        require(k <= listSize, "k is too large");

        address[] memory DepositerLists = new address[](k);
        address currentAddress = _nextDepositers[GUARD];

        for(uint i = 0; i < k; i++) {
            DepositerLists[i] = currentAddress;
            currentAddress = _nextDepositers[currentAddress];
        }

        return DepositerLists;
    }

    function _verifyIndex(
        address prevDepositer, // 前一个存款人
        uint256 newValue,    // 新插入的存款人的金额
        address nextDepositer  // 后一个存款人
    ) internal view returns (bool) {
        return (prevDepositer == GUARD || tokenBalances[prevDepositer] >= newValue) && 
                (nextDepositer == GUARD || newValue > tokenBalances[nextDepositer]);
    }

    function _isPrevDepositer(
        address Depositer,
        address prevDepositer
    ) internal view returns(bool) {
        return _nextDepositers[prevDepositer] == Depositer;
    }

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event RemoveDepositer(address indexed user, uint256 amount);
}