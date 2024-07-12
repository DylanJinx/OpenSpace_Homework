# 运行文件命令：bash ./deploy.sh
# 需要在foundry.toml中设置[rpc_endpoints]设置local = "http://hostlocal:8545"
forge create --rpc-url local --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/MyToken.sol:MyToken --constructor-args "Dylan Token" "DJ"

# 连接本地节点
curl -X POST --data '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}' http://127.0.0.1:8545


# 访问sepolia查询余额 0xb9cee3a6842ad712 = 13.38888904654054 ETH
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x3A8492819b0C9AB5695D447cbA2532b879d25900", "latest"],"id":1}' https://1rpc.io/sepolia

# 访问以太坊主网查询余额 0x2f61bffb382cc1 = 0.013336801086811328 ETH
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0x3A8492819b0C9AB5695D447cbA2532b879d25900", "latest"],"id":1}' https://eth.drpc.org