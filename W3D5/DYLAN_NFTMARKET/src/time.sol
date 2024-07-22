// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 0xfc6f63752d5571795860f7702a466899f0126a91
contract time {

    function getTime() public view returns (uint256) {
        return block.timestamp;
    }

    function addTime_Seconds(uint256 value) public view returns (uint256){
        return block.timestamp + value;
    }

    function addTime_Minutes(uint256 value) public view returns (uint256){
        return block.timestamp + value * 60;
    }

    function addTime_Hours(uint256 value) public view returns (uint256){
        return block.timestamp + value * 3600;
    }

    function addTime_Days(uint256 value) public view returns (uint256){
        return block.timestamp + value * 86400;
    }

}