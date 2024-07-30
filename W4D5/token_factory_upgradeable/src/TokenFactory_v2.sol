// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import {IDylanToken_v2} from "./IDylanToken_v2.sol";

contract TokenFactory_v2 is Initializable, OwnableUpgradeable, UUPSUpgradeable {

    // 追踪每个用户拥有的所有最小代理实例地址
    mapping(address => address[]) public allClones;
    // tokenAddr => Creator   记录每个代币的创建者
    mapping(address => address) public tokenCreators;
    // buyer => tokenAddr => amount
    mapping(address => mapping(address => uint)) public BuyerTokenAmount;
    mapping(address => uint) public tokenPrices;

    address public dylanTokenAddress;


    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _admin) initializer public {
        __Ownable_init(_admin);
        __UUPSUpgradeable_init();
    }

    function setERC20ImplementationAddress(address _dylanTokenAddress) public onlyOwner {
        dylanTokenAddress = _dylanTokenAddress;
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}

    function deployInscription(
        string memory _symbol,
        uint _totalSupply,
        uint _perMint,
        uint _price
    ) public returns(address) {
        address identicalChild = Clones.clone(dylanTokenAddress);
        IDylanToken_v2(identicalChild).initialize(_symbol, _totalSupply, _perMint);
        allClones[msg.sender].push(identicalChild);
        tokenCreators[identicalChild] = msg.sender;
        tokenPrices[identicalChild] = _price;

        emit NewDeployInscription(identicalChild, msg.sender, _symbol, _price);

        return identicalChild;
    }



    function mintInscription(address _identicalChild) public payable{
        require(msg.value == (tokenPrices[_identicalChild] * IDylanToken_v2(_identicalChild).getPerMint()), "Incorrect payment");
        (bool success, ) = payable(tokenCreators[_identicalChild]).call{value: msg.value}("");
        
        if (success) {
            IDylanToken_v2(_identicalChild).mint(msg.sender);
        }

        BuyerTokenAmount[msg.sender][_identicalChild] += IDylanToken_v2(_identicalChild).getPerMint();

        emit MintInscription(msg.sender, _identicalChild, IDylanToken_v2(_identicalChild).getPerMint());
    }

    event NewDeployInscription(address indexed _tokenAddr, address indexed _creator, string symbol, uint price);
    event MintInscription(address indexed _to, address indexed _tokenAddr, uint _perMint);

}