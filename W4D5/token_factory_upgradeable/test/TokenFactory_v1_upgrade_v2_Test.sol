// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import "../lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DylanToken_v1} from "../src/DylanToken_v1.sol";
import {DylanToken_v2} from "../src/DylanToken_v2.sol";
import {TokenFactory_v1} from "../src/TokenFactory_v1.sol";
import {TokenFactory_v2} from "../src/TokenFactory_v2.sol";

contract TokenFactory_v1_upgrade_v2_Test is Test {
    DylanToken_v2 public dylanToken_v2;
    TokenFactory_v1 public Proxy_factory_v1;
    TokenFactory_v2 public Proxy_factory_v2;
    ERC1967Proxy public factoryProxy;

    address public tokenCreator_1;
    uint256 public tokenCreator_1PrivateKey;
    address public tokenCreator_2;
    uint256 public tokenCreator_2PrivateKey;
    address public tokenBuyer_1;
    uint256 public tokenBuyer_1PrivateKey;
    address public factoryProxyAdmin;
    uint256 public factoryProxyAdminPrivateKey;

    // ------------------------------ setup ------------------------------
    function setUp() public {
        (tokenCreator_1, tokenCreator_1PrivateKey) = makeAddrAndKey("tokenCreator_1");
        (tokenCreator_2, tokenCreator_2PrivateKey) = makeAddrAndKey("tokenCreator_2");
        (tokenBuyer_1, tokenBuyer_1PrivateKey) = makeAddrAndKey("tokenBuyer_1");
        (factoryProxyAdmin, factoryProxyAdminPrivateKey) = makeAddrAndKey("factoryProxyAdmin");

        console.log("proxy admin: ", factoryProxyAdmin);


        TokenFactory_v1 implementation_factory_v1_contract = new TokenFactory_v1();
        console.log("implementation_factory_v1_contract address: ", address(implementation_factory_v1_contract));

        vm.prank(factoryProxyAdmin);
        factoryProxy = new ERC1967Proxy(
            address(implementation_factory_v1_contract), 
            abi.encodeCall(
                implementation_factory_v1_contract.initialize, 
                (factoryProxyAdmin)
            )
        );

        console.log("factoryProxy address: ", address(factoryProxy));

        Proxy_factory_v1 = TokenFactory_v1(address(factoryProxy));
    }


    // ------------------------------ test ------------------------------
    function test_factory_v1_upgrade_v2() public {
        // v1
        vm.prank(tokenCreator_1);
        address token_1_address = Proxy_factory_v1.deployInscription("token_1", 10000, 1000);
        require(Proxy_factory_v1.tokenCreators(token_1_address) == tokenCreator_1, "token creator error");

        vm.expectEmit(true, true, false, true);
        emit TokenFactory_v1.MintInscription(tokenBuyer_1, token_1_address, 1000);
        vm.prank(tokenBuyer_1);
        Proxy_factory_v1.mintInscription(token_1_address);
        require(DylanToken_v1(token_1_address).balanceOf(tokenBuyer_1) == 1000, "token balance error");

        vm.prank(tokenCreator_2);
        address token_2_address = Proxy_factory_v1.deployInscription("token_2", 10000, 1000);
        require(Proxy_factory_v1.tokenCreators(token_2_address) == tokenCreator_2, "token creator error");
        vm.expectEmit(true, true, false, true);
        emit TokenFactory_v1.MintInscription(tokenBuyer_1, token_2_address, 1000);
        vm.prank(tokenBuyer_1);
        Proxy_factory_v1.mintInscription(token_2_address);
        require(DylanToken_v1(token_2_address).balanceOf(tokenBuyer_1) == 1000, "token balance error");

        // upgrade
        TokenFactory_v2 implementation_factory_v2_contract = new TokenFactory_v2();
        console.log("implementation_factory_v2_contract address: ", address(implementation_factory_v2_contract));

        dylanToken_v2 = new DylanToken_v2();
        
        bytes memory _data = abi.encodeCall(TokenFactory_v2.setERC20ImplementationAddress, address(dylanToken_v2));
        
        vm.prank(factoryProxyAdmin);
        Proxy_factory_v1.upgradeToAndCall(address(implementation_factory_v2_contract), _data);

        Proxy_factory_v2 = TokenFactory_v2(address(factoryProxy));

        // v2
        deal(tokenBuyer_1, 1e18);
        vm.prank(tokenCreator_1);
        address token_3_address = Proxy_factory_v2.deployInscription("token_3", 10000, 1000, 1e15);
        require(Proxy_factory_v2.tokenCreators(token_3_address) == tokenCreator_1, "token creator error");

        vm.expectEmit(true, true, false, true);
        emit TokenFactory_v2.MintInscription(tokenBuyer_1, token_3_address, 1000);
        vm.prank(tokenBuyer_1);
        Proxy_factory_v2.mintInscription{value: 1e18}(token_3_address);
        require(DylanToken_v2(token_3_address).balanceOf(tokenBuyer_1) == 1000, "token balance error");
        require(tokenCreator_1.balance == 1e18, "token creator balance error");

        // test token be created by v1
        vm.expectEmit(true, true, false, true);
        emit TokenFactory_v2.MintInscription(tokenBuyer_1, token_1_address, 1000);
        vm.prank(tokenBuyer_1);
        Proxy_factory_v2.mintInscription(token_1_address);
        require(DylanToken_v1(token_1_address).balanceOf(tokenBuyer_1) == 2000, "token balance error");
    }


}
