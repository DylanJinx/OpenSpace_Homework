// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import "../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import "./DylanToken_v1.sol";

contract TokenFactory_v1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {

    // 追踪每个用户拥有的所有最小代理实例地址
    mapping(address => address[]) public allClones;
    // tokenAddr => Creator   记录每个代币的创建者
    mapping(address => address) public tokenCreators;
    // buyer => tokenAddr => amount
    mapping(address => mapping(address => uint)) public BuyerTokenAmount;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _admin) initializer public {
        __Ownable_init(_admin);
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}

    function deployInscription(
        string memory symbol,
        uint totalSupply,
        uint perMint
    ) public returns(address) {
        DylanToken_v1 dylanToken = new DylanToken_v1(symbol, totalSupply, perMint);

        allClones[msg.sender].push(address(dylanToken));
        tokenCreators[address(dylanToken)] = msg.sender;

        emit NewDeployInscription(address(dylanToken), msg.sender, symbol);

        return address(dylanToken);
    }

    function mintInscription(address tokenAddr) public {
        DylanToken_v1(tokenAddr).mint(msg.sender);
        BuyerTokenAmount[msg.sender][tokenAddr] += DylanToken_v1(tokenAddr).getPerMint();

        emit MintInscription(msg.sender, tokenAddr, DylanToken_v1(tokenAddr).getPerMint());
    }

    event NewDeployInscription(address indexed _tokenAddr, address indexed _creator, string symbol);
    event MintInscription(address indexed _to, address indexed _tokenAddr, uint _perMint);
}