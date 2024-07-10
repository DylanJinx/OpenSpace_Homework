// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ITokenRecipient.sol";

contract Dylan is ERC20 {
    constructor(uint256 initialSupply) ERC20("Dylan", "DJ") {
        _mint(msg.sender, initialSupply);
    }

    function _isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(balances[_from] >= _value, "ERC20: transfer amount exceeds balance");
        require(_to != address(0), "ERC20: transfer to the zero address");
        
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
                require(retval == ITokenRecipient.onTransferReceived.selector, "Token recipient contract did not accept tokens");
            } catch {
                revert("Call to onTransferReceived failed");
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
        bytes calldata data
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
        bytes calldata data
    ) external returns (bool) {
        _transfer(_from, _to, _value);
        _invokeTokenReceived(_from, _to, _value, data);
        return true;
    }
}