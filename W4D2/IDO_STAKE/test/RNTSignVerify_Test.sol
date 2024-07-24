// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {RNTToken} from "../src/RNTToken.sol";
import {esRNTToken} from "../src/esRNTToken.sol";
import {RNTTokenStakePool} from "../src/RNTTokenStakePool.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";


contract RNTToken_Mock is RNTToken {

    // 公开domain separator
    function getDomainSeparator() external override view returns (bytes32) {
        return _domainSeparatorV4();
    }

    function StructHash(
        address _user,
        address _spender,
        uint256 _value,
        uint256 _deadline
    ) public returns(bytes32) {
         bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"), 
                _user, 
                _spender, 
                _value, 
                _useNonce(_user), 
                _deadline
            ));
        return structHash;
    }

    function StakeSignDigest(
        address _user,
        address _spender,
        uint256 _value,
        uint256 _deadline
    ) public returns(bytes32){
        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"), 
                _user, 
                _spender, 
                _value, 
                _useNonce(_user), 
                _deadline
            ));

        return _hashTypedDataV4(
            structHash
        );
    }
}

contract RNTSignVerify_Test is Test {
    using Strings for uint256;

    address public RNTTokenAdmin;
    uint256 public RNTTokenAdminPrivateKey;

    address public Signer;
    uint256 public SignerPrivateKey;

    address public Spender;
    uint256 public SpenderPrivateKey;

    RNTToken public RNT;
    esRNTToken public esRNT;
    RNTTokenStakePool public stakePool;
    RNTToken_Mock public signContract;

    function setUp() public {
        (RNTTokenAdmin, RNTTokenAdminPrivateKey) = makeAddrAndKey("RNTTokenAdmin");
        vm.prank(RNTTokenAdmin);
        RNT = new RNTToken();

        signContract = new RNTToken_Mock();

        (Signer, SignerPrivateKey) = makeAddrAndKey("Signer");
        (Spender, SpenderPrivateKey) = makeAddrAndKey("Spender");
    }

    // ------------------------------------ sign ------------------------------------
    // approve ERC20 signature
    function SignERC20(uint256 _amount, uint256 _nonce, uint256 _deadline) private view returns(uint8 _v, bytes32 _r, bytes32 _s) {
        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                Signer,
                Spender,
                _amount,
                _nonce,
                _deadline
            )
        );
        
        bytes32 digest = RNT.getDigest(structHash);

        // Generate Signature
        (_v, _r, _s) = vm.sign(SignerPrivateKey, digest); 

        return (_v, _r, _s);
    }

    // ------------------------------------ tests ------------------------------------

    // 验证ERC20签名
    function test_VerifyRNTSign() public {

        uint256 amount = 500;
        uint256 deadline = block.timestamp + 1000; // 1000 seconds from now
        // uint256 nonce = RNTToken.nonces(Signer);
        // uint nonce_ = 0;
        // require(nonce == nonce_, "Nonce should be 0");

        //bytes32 digest = signContract.StakeSignDigest(Signer, Spender, amount, deadline);
        // (uint8 v, bytes32 r, bytes32 s) = vm.sign(SignerPrivateKey, digest);

        (uint8 v, bytes32 r, bytes32 s) = SignERC20(amount, 0, deadline);

        deal(address(RNT), Signer, amount);
        vm.prank(Spender);
        RNT.permit(Signer, Spender, amount, deadline, v, r, s);
        vm.prank(Spender);
        RNT.transferFrom(Signer, Spender, amount);

        assertEq(RNT.balanceOf(Spender), amount, "failed to transfer tokens");
    }

    function test_console() public {
        uint256 amount = 500;
        uint256 deadline = block.timestamp + 1000;

        console.log("test domain");
        console.logBytes32(signContract.getDomainSeparator()); 
        console.log("test structHash");
        console.logBytes32(signContract.StructHash(Signer, Spender, amount, deadline));
        console.log("test digest");
        console.logBytes32(signContract.StakeSignDigest(Signer, Spender, amount, deadline)); 

        console.log("market domain");
        console.logBytes32(RNT.getDomainSeparator()); 
        
        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                Signer,
                Spender,
                amount,
                0,
                deadline
            )
        );
        console.log("market structHash");
        console.logBytes32(structHash);

        console.log("market digest");
        console.logBytes32(RNT.getDigest(structHash)); 
    }




}