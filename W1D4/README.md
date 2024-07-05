# 题目  
编写一个 BigBank 合约， 它继承自该挑战 的 Bank 合约，并实现功能：  

1. 要求存款金额 >0.001 ether（用modifier权限控制）
2. BigBank 合约支持转移管理员
3. 同时编写一个 Ownable 合约，把 BigBank 的管理员转移给Ownable 合约， 实现只有Ownable 可以调用 BigBank 的 withdraw().
4. 编写 withdraw() 方法，仅管理员可以通过该方法提取资金。
5. 用数组记录存款金额的前 3 名用户

# 步骤
1. 首先部署`BigBank`合约
2. 使用`BigBank`合约的地址来部署`Ownable`合约
3. 使用部署`BigBank`合约的EOA地址调用`transferOwnership`方法，将`admin`转移给`Ownable`合约