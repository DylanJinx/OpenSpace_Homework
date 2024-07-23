// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {IRNTToken} from "./IRNTToken.sol";

contract RNTToken is ERC20("RNTToken", "RNT"), Ownable(msg.sender), IRNTToken {
    uint256 public maxSupply = 1000_000_000 * 10 ** 18;
    uint256 public totalMinted = 0;

    address public IDOContract;
    // 5% for IDO
    uint256 public MAXIDOToken = maxSupply / 20;
    uint256 public totalIDOToken = 0;
    
    address public stakeContract;
    // 20% for stake
    uint256 public MAXStakeToken = maxSupply / 5;
    uint256 public totalStakeToken = 0;

    

    function mint(address _to, uint256 _amount) public onlyOwner {
        require(totalMinted + _amount <= maxSupply, "S3Token: max supply exceeded");
        _mint(_to, _amount);
        totalMinted += _amount;
    }

    function mintForIDO(uint256 _amount) public {
        require(msg.sender == IDOContract, "S3Token: only IDO contract can mint IDO token");
        require(totalIDOToken + _amount <= MAXIDOToken, "S3Token: IDO token mint exceeded");
        _mint(IDOContract, _amount);
        totalIDOToken += _amount;
    }

    function setIDOContract(address _IDOContract) public onlyOwner {
        require(_IDOContract != address(0), "S3Token: invalid IDO admin address");

        IDOContract = _IDOContract;
    }

    function setstakeContract(address _stakeContract) public onlyOwner {
        require(_stakeContract != address(0), "S3Token: invalid stake admin address");

        stakeContract = _stakeContract;
    }
}