// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ITokenRecipient.sol";

// The `isContract()` function is no longer available in `Address.sol` in `v5.0`
// import "@openzeppelin/contracts/utils/Address.sol";

// sepolia contract address: 
contract BaseERC20 {
    string public name; 
    string public symbol; 
    uint8 public decimals; 

    uint256 public totalSupply; 

    mapping (address => uint256) balances; 

    mapping (address => mapping (address => uint256)) allowances; 

    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 value
    );

    event Approval(
        address indexed owner, 
        address indexed spender, 
        uint256 value
    );

    error TransferAmountExceedsBalance();
    error TransferToZeroAddress();
    error TransferAmountExceedsAllowance();
    error TokenRecipientDidNotAcceptTokens();
    error CallToTokenRecipientFailed();

    constructor() {
        // write your code here
        // set name,symbol,decimals,totalSupply
        name = "BaseERC20";
        symbol = "BERC20";
        decimals = 18;
        totalSupply = 100000000 * 10**uint256(decimals);

        balances[msg.sender] = totalSupply;  
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        // write your code here
        return balances[_owner];

    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        // write your code here
        allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value); 
        return true; 
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {   
        // write your code here     
        return allowances[_owner][_spender];
    }

    function _isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        if (balances[_from] < _value) {
            revert TransferAmountExceedsBalance();
        }

        if (_to == address(0)) {
            revert TransferToZeroAddress();
        }
        
        balances[_from] = balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(_from, _to, _value);
    }

    function _invokeTokenReceived(
        address _from, 
        address _to, 
        uint256 _value,
        bytes memory data
    ) internal {
        if (_isContract(_to)) {
            // 此处的msg.sender = address(this)合约地址 = TokenBank合约中的operator
            // data:0x0000000000000000000000000000000000000000000000000000000000000001
            try ITokenRecipient(_to).onTransferReceived(msg.sender, _from, _value, data) returns (bytes4 retval) {
                if (retval != ITokenRecipient.onTransferReceived.selector) {
                    revert TokenRecipientDidNotAcceptTokens();
                }
            } catch Error(string memory reason) {
            // 传递具体的错误原因
            revert(reason);
            } catch (bytes memory lowLevelData) {
                // 传递低级别调用的数据
                revert(string(lowLevelData));
            }
        }
    }

    function transferAndCall(
        address _to, 
        uint256 _value
    ) external returns (bool) {
        _transfer(msg.sender, _to, _value);
        _invokeTokenReceived(msg.sender, _to, _value, "");
        return true;
    }

    function transferAndCall(
        address _to, 
        uint256 _value, 
        bytes memory data
    ) external returns (bool) {
        _transfer(msg.sender, _to, _value);
        _invokeTokenReceived(msg.sender, _to, _value, data);
        return true;
    } 

    function transferFromAndCall(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool) {
        _transfer(_from, _to, _value);
        _invokeTokenReceived(_from, _to, _value, "");
        return true;
    }

    function transferFromAndCall(
        address _from,
        address _to,
        uint256 _value,
        bytes memory data
    ) external returns (bool) {
        _transfer(_from, _to, _value);
        _invokeTokenReceived(_from, _to, _value, data);
        return true;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        _transfer(msg.sender, _to, _value);

        return true;   
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        // Check that the amount spent does not exceed the authorized amount
        require(allowances[_from][msg.sender] >= _value, "ERC20: transfer amount exceeds allowance");

        allowances[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);

        return true; 
    }

}