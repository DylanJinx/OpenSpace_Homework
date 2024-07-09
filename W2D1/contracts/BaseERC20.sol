// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ITokenRecipient.sol";
// The `isContract()` function is no longer available in `Address.sol` in `v5.0`
// import "@openzeppelin/contracts/utils/Address.sol";

// contract address: 0x6AE26629B35e98fbBA05893D7b01B96B769e88DC
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
        balances[_from] = balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(_from, _to, _value);
    }

    function _invokeTokenReceived(address _from, address _to, uint256 _value) internal {
        if (_isContract(_to)) {
            try ITokenRecipient(_to).tokensReceived(_from, _value) returns (bool received) {
                require(received, "Token recipient contract did not accept tokens");
            } catch {
                revert("Call to tokensReceived failed");
            }
        }
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Determine if the transfer amount exceeds the balance
        require(balances[msg.sender] >= _value, "ERC20: transfer amount exceeds balance");

        // The transferred address cannot be 0
        require(_to != address(0), "Transfer to address 0");

        _transfer(msg.sender, _to, _value);
        _invokeTokenReceived(msg.sender, _to, _value); 

        return true;   
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // Check that the amount spent does not exceed the authorized amount
        require(allowances[_from][msg.sender] >= _value, "ERC20: transfer amount exceeds allowance");

        // Check if the account balance is sufficient
        require(balances[_from] >= _value, "ERC20: transfer amount exceeds balance");

        _transfer(_from, _to, _value);
        _invokeTokenReceived(_from, _to, _value);

        allowances[_from][msg.sender] -= _value;

        return true; 
    }

}