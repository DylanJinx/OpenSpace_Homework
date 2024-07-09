// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ITokenRecipient.sol";

contract Dylan is ERC20 {
    constructor(uint256 initialSupply) ERC20("Dylan", "DJ") {
        _mint(msg.sender, initialSupply);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        super.transfer(recipient, amount);
        _invokeTokenReceived(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        super.transferFrom(sender, recipient, amount);
        _invokeTokenReceived(sender, recipient, amount);
        return true;
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

    function _isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}