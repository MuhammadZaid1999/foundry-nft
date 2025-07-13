// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CallAnything {
    address public s_someAddress;
    uint256 public s_someAmount;

    function transfer(address someAddress, uint256 someAmount) public {
        s_someAddress = someAddress;
        s_someAmount = someAmount;
    }

    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    function _getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256("transfer(address,uint256)"));
    }

    function getDataToCallTransfer(address someAddress, uint256 someAmount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, someAmount);
    }

}