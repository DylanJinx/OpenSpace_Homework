# 命令
1. 本地部署合约：`forge create --rpc-url [网络：如http://127.0.0.1:8545] --private-key [私钥] [合约名] --constructor-args [如果有参数]`
    - 如：`forge create --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 Counter --constructor-args 10`

2. 查看slot存储的值：`cast rpc "eth_getStorageAt" [合约地址] [slot值] latest`
    - 如：`cast rpc "eth_getStorageAt" 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc latest  `

3. 发起交易：`cast send --from [账户] --rpc-url [网络] --unlocked 合约地址 "[函数名+参数类型]" [具体参数]`
    - 如：`cast send --from 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 --rpc-url http://localhost:8545 --unlocked 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "add(uint256)" 10`

4. 查看view之类的函数：`cast call [合约地址] "[函数名]" --rpc-url [网络]`
    - 如：`cast call 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "get()" --rpc-url http://localhost:8545`

# proxy_v1.sol
## 为什么不需要参数显式的接收calldata

在以太坊智能合约的上下文中，`calldata` 是交易的一部分，它包含了执行合约函数所必需的所有信息。当您发起一个交易并调用智能合约的函数时，您需要提供该函数的参数，这些参数以及函数选择器（标识哪个函数被调用）组合成 `calldata`。以下是详细的说明：

### 交易和 `calldata` 的关系
1. **交易构成**：
   - 每笔以太坊交易包含多个字段，例如发起者的地址、接收者的地址（如果是合约调用，则为合约地址）、发送的金额、gas 价格、gas 限制以及 `calldata`。
   - `calldata` 具体包含了要调用的合约函数的函数选择器和所有必要的参数。

2. **函数调用**：
   - 当交易发送到网络并被矿工打包进区块时，对应的智能合约被触发执行。
   - 合约代码通过读取 `calldata` 来确定被调用的函数以及该函数的输入参数。

3. **`calldata` 的使用**：
   - `calldata` 是只读的，意味着它不能在合约执行期间被修改。
   - Solidity 中有特定的数据位置关键字 `calldata`，用于标记外部函数的参数，表示这些参数直接来自交易的 `calldata`。

### `calldata` 的优势
- **成本效率**：由于 `calldata` 是外部传入的，并且在 EVM 中以只读形式存在，使用 `calldata` 可以节省gas成本，尤其是在传递大量数据时。
- **安全性**：`calldata` 保证了数据的不可变性，从而增加了智能合约的安全性。

### `calldatacopy` 指令的作用
- **功能**：`calldatacopy` 是一个低级操作，用于将 `calldata`（即交易数据）从交易中复制到智能合约的内存空间。这使得合约能够在内存中操作这些数据，而无需直接在 `calldata` 中进行读取，这对于某些操作来说更有效率。
- **参数解释**：
  - 第一个参数 `0` 表示复制的数据应该放置在内存中的起始位置。
  - 第二个参数 `0` 表示从 `calldata` 的起始位置开始复制。
  - 第三个参数 `calldatasize()` 是一个函数，返回 `calldata` 的总大小，即要复制的数据长度。

### delegatecall
- **`delegatecall` 使用复制的 `calldata`**:
  - `delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)` 这条指令使用了之前复制到内存中的 `calldata`。这里，内存中从位置 `0` 开始、长度为 `calldatasize()` 的区域被用作输入数据，调用 `_implementation` 地址上的代码。
  - `delegatecall` 执行时，它在 `CounterProxy` 的存储环境下运行 `_implementation` 的代码，但是调用数据（`calldata`）来自于原始的外部调用。

#### **解释 `calldata` 来自原始的外部调用的含义**
**代理合约的上下文中的 `calldata`**：
   - 在代理合约模式中，当 `fallback` 函数或 `receive` 函数被触发时（通常是因为没有其他函数匹配到传入的函数选择器），这些函数没有自己的参数，而是直接操作交易中传入的 `calldata`。
   - 这意味着 `fallback` 函数中的 `calldata` 是从那个原始外部调用继承来的，未经修改。所以，当我们说 `calldata` 来自原始的外部调用，实际上是指 `calldata` 保持了从最初发起调用的用户或合约时的原始状态。

# 打印代理的插槽
```shell
➜  storage_memory git:(main) ✗ forge inspect CounterProxy storageLayout
{
  "storage": [],
  "types": {}
}
```

但是访问具体插槽是有数据的：
```shell
➜  storage_memory git:(main) ✗ cast rpc "eth_getStorageAt" 0x5FbDB2315678afecb367f032d93F642f64180aa3 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103 latest
"0x000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266"
```

# 实现合约的函数是用自己的constant还是代理合约的constant?
在 Solidity 中使用 `delegatecall` 时，被调用合约（B 合约）的代码在调用合约（A 合约）的上下文中执行。这意味着 B 合约中的函数可以访问 A 合约的存储空间，但是每个合约的常量和函数是独立的。

1. **常量和存储的独立性**：在 Solidity 中，常量（使用 `constant` 关键字定义）是编译时确定的，存储在合约的字节码中，而不是存储在区块链的存储空间中。因此，当 B 合约的函数被 A 合约通过 `delegatecall` 调用时，该函数将使用 B 合约中定义的常量值，而不是 A 合约的常量值。

2. **示例**：如果 B 合约中有一个函数使用了一个 `constant` 常量，即便这个函数通过 A 合约的 `delegatecall` 被调用，它依旧会使用 B 合约中定义的常量值。这是因为常量是编译到合约代码中的，和存储状态（即 state variables）是分开处理的。

# transparent_proxy_v2.sol 交互
```shell
➜  proxy_contract git:(main) ✗ cast rpc "eth_getStorageAt" 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103 latest
"0x000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266"

➜  proxy_contract git:(main) ✗ cast send --from 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 --rpc-url http://localhost:8545 --unlocked 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "something(address,bytes)" 0x5FbDB2315678afecb367f032d93F642f64180aa3 0x00

blockHash               0x9716fa25ce63c430fd763168330d1b7113a5b967f3307cc3cfe51b34f2038578
blockNumber             3
contractAddress         
cumulativeGasUsed       49697
effectiveGasPrice       768230248
from                    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
gasUsed                 49697
logs                    []
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
root                    0xffc627a2643270a1500eb311ad0adc76ac5d6d2834603a364384847538aec321
status                  1 (success)
transactionHash         0x7212b4cc2d0f7673d85ed6f60b6e90a5af86aaa64974a7dcd9053c065301422a
transactionIndex        0
type                    2
blobGasPrice            1
blobGasUsed             
to                      0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

➜  proxy_contract git:(main) ✗ cast rpc "eth_getStorageAt" 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc latest 
"0x0000000000000000000000005fbdb2315678afecb367f032d93f642f64180aa3"
```


# UUPS_Proxy
部署 UUPS_Counter_v1 实现合约
```shell
➜  proxy_contract git:(main) ✗ forge create --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 UUPS_Counter                      
[⠊] Compiling...
[⠢] Compiling 1 files with Solc 0.8.26
[⠆] Solc 0.8.26 finished in 111.53ms
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x610178dA211FEF7D417bC0e6FeD39F05609AD788
Transaction hash: 0x960ce71cd11b2b9353871b932c44a6a1c8a1568731f0a06c89f06b2de3792390
```

部署代理合约：
```shell
➜  proxy_contract git:(main) ✗ forge create --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 UUPS_Proxy --constructor-args 0x610178dA211FEF7D417bC0e6FeD39F05609AD788                                          
[⠊] Compiling...
[⠒] Compiling 1 files with Solc 0.8.26
[⠢] Solc 0.8.26 finished in 61.06ms
Compiler run successful!
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82
Transaction hash: 0x696188aef2493ecd18f3ef2ad82104804aa3960791b3581dd57bd3b7c8337731
```

查询代理合约中存储 实现合约地址 的slot值
```shell
➜  proxy_contract git:(main) ✗ cast rpc "eth_getStorageAt" 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc latest
"0x000000000000000000000000610178da211fef7d417bc0e6fed39f05609ad788"
```

调用v1的add()函数
```shell
➜  proxy_contract git:(main) ✗ cast send --from 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 --rpc-url http://localhost:8545 --unlocked 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 "add(uint256)" 100

blockHash               0x0f6588b5b0719d02608fbfd67f07047e0de8427ff8e5d5f64bb1ae3595e5f90b
blockNumber             23
contractAddress         
cumulativeGasUsed       48634
effectiveGasPrice       54164864
from                    0x70997970C51812dc3A010C7d01b50e0d17dc79C8
gasUsed                 48634
logs                    []
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
root                    0x7c0858264191ccade6ff9bcbc35505c4d13dbc5505f26dc6c7cc1038ff2c3774
status                  1 (success)
transactionHash         0xee038b60e298db8b896b1efabdaf0ab5643b77e9d023e4e90ab22d661b99b917
transactionIndex        0
type                    2
blobGasPrice            1
blobGasUsed             
to                      0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82
➜  proxy_contract git:(main) ✗ cast rpc "eth_getStorageAt" 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 0x0  latest                                                              
"0x0000000000000000000000000000000000000000000000000000000000000001"
```

部署v2实现合约
```shell
➜  proxy_contract git:(main) ✗ forge create --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 UUPS_CounterV2 
[⠊] Compiling...
[⠒] Compiling 1 files with Solc 0.8.26
[⠢] Solc 0.8.26 finished in 60.14ms
Compiler run successful!
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0
Transaction hash: 0x57ed19a883c9236f4921752b5f025ae3c22ab1196743a54a0fd6ec1db51104f7
```

由于代理中，和实现合约中都没有设置管理员的地址，所以任何人都可以修改实现合约的地址
```shell
➜  proxy_contract git:(main) ✗ cast send --from 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC --rpc-url http://localhost:8545 --unlocked 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 "_upgrateTo(address)" 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0

blockHash               0x7d7555a27432bcef1b45f6203ae1fdebe04c14582b42eff1b26ffb113fe6d324
blockNumber             24
contractAddress         
cumulativeGasUsed       32559
effectiveGasPrice       47416209
from                    0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
gasUsed                 32559
logs                    []
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
root                    0x8f788624181862d4a9c6bfd3ebc3a13421c981cd93877be3f117f636270b5f34
status                  1 (success)
transactionHash         0x159efecb05b1f53821ee2783fb074b7cac366b027568ea0ded776a7cdea7e6b0
transactionIndex        0
type                    2
blobGasPrice            1
blobGasUsed             
to                      0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82
➜  proxy_contract git:(main) ✗ cast rpc "eth_getStorageAt" 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc latest
"0x000000000000000000000000a51c1fc2f0d1a1b8494ed1fe312d7c3a78ed91c0"
```

调用v2的add()函数，看看会不会在原来的基础上+i
```shell
➜  proxy_contract git:(main) ✗ cast send --from 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 --rpc-url http://localhost:8545 --unlocked 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 "add(uint256)" 100

blockHash               0xffbd0d24fca2e208544f0255f731e9b0220ab08dfd18a5e5013e262b1439f2f3
blockNumber             25
contractAddress         
cumulativeGasUsed       31534
effectiveGasPrice       41502049
from                    0x70997970C51812dc3A010C7d01b50e0d17dc79C8
gasUsed                 31534
logs                    []
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
root                    0x18dc5511831783d0f060234cf6f3ff0b7dcee7eea67a016ddb236d078fc90391
status                  1 (success)
transactionHash         0x28527a2af52d5d8193a898981e63eb808ca6d8f6dd00d2ebf1c537cdcb27265b
transactionIndex        0
type                    2
blobGasPrice            1
blobGasUsed             
to                      0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82
➜  proxy_contract git:(main) ✗ cast rpc "eth_getStorageAt" 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 0x0  latest                                            
"0x0000000000000000000000000000000000000000000000000000000000000065"
```
再换会v1实现合约
```shell
➜  proxy_contract git:(main) ✗ cast send --from 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC --rpc-url http://localhost:8545 --unlocked 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 "_upgrateTo(address)" 0x610178dA211FEF7D417bC0e6FeD39F05609AD788                                          

blockHash               0x51ca224270248fd82ba78a32d1f27247df97d265f669a24220d033532eb6f897
blockNumber             27
contractAddress         
cumulativeGasUsed       32559
effectiveGasPrice       31792802
from                    0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
gasUsed                 32559
logs                    []
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
root                    0x3ee9e169dbadd0292de11028dcf0bde0ab0039aa17981e3e584f2fcb2cba323a
status                  1 (success)
transactionHash         0x2e138ad81e88d22ccabb45228f193cca2646372bb01885be3d689bcf19756048
transactionIndex        0
type                    2
blobGasPrice            1
blobGasUsed             
to                      0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82
```

# 对比透明代理 和 UUPS代理 的gas
透明代理换实现合约地址gas: 49697
UUPS代理换实现合约地址gas: 最多32559，但需要在实现合约中完成`_upgrade()`和`_setImplementation()`