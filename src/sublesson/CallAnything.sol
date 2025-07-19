// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CallAnything {
    address public s_someAddress;
    uint256 public s_someAmount;

    function transfer(address someAddress, uint256 someAmount) public {
        s_someAddress = someAddress;
        s_someAmount = someAmount;
    }

    // ---------- get Selectors -------------- //

    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    function _getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256("transfer(address,uint256)"));
    }

    function _getSelectorOne(string memory signature) public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes(signature)));
    }

    function getSelectorTwo() public view returns (bytes4 selector) {
        // We can also get a function selector from data sent into the call
        bytes memory functionCallData = abi.encodeWithSignature("transfer(address,uint256)", address(this), 123);
        selector = bytes4(bytes.concat(functionCallData[0], functionCallData[1], functionCallData[2], functionCallData[3]));
    }

    function getSelectorTwo(string memory signature) public view returns (bytes4 selector) {
        // We can also get a function selector from data sent into the call
        bytes memory functionCallData = abi.encodeWithSignature(signature, address(this), 123);
        selector = bytes4(functionCallData);
    }

    function getSelectorThree(bytes calldata functionCallData) public pure returns (bytes4 selector) {
        /*
            Pass this:
            0xa9059cbb000000000000000000000000d7acd2a9fd159e69bb102a1ca21c9a3e3a5f771b000000000000000000000000000000000000000000000000000000000000007b
            This is output of `getCallData()`
            This is another low level way to get function selector using assembly
            You can actually write code that resembles the opcodes using the assembly keyword!
            This in-line assembly is called "Yul"
            It's a best practice to use it as little as possible - only when you need to do something very VERY specific
        */
        // offset is a special attribute of calldata
        assembly {
            selector := calldataload(functionCallData.offset)
        }
    }

    function getSelectorFour() public pure returns (bytes4 selector) {
        // Another way to get your selector with the "this" keyword
        return this.transfer.selector;
    }

    function getSignatureOne() public pure returns (string memory) {
        // Just a function that gets the signature
        return "transfer(address,uint256)";
    }

    function getDataToCallTransfer(address someAddress, uint256 someAmount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, someAmount);
    }

    function getDataToCallTransfer(address someAddress, uint8 someAmount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, someAmount);
    }

    function getDataToCallTransfer(address someAddress, uint16 someAmount, bool _bool, bytes8 _bytes) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, someAmount, _bool, _bytes);
    }

    function getDataToCallTransfer(address someAddress, uint64 someAmount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, someAmount);
    }

    function getDataToCallTransfer(bytes4 selector, address someAddress, uint256 someAmount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(selector, someAddress, someAmount);
    }

    function getCallData() public view returns (bytes memory) {
        // Another way to get data (hard coded)
        return abi.encodeWithSignature("transfer(address,uint256)", address(this), 123);
    }

    function getCallData(address someAddress, uint8 someAmount) public pure returns (bytes memory) {
        // Another way to get data (hard coded)
        return abi.encodeWithSignature(getSignatureOne(), someAddress, someAmount);
    }

    function getCallData(string memory signature, address someAddress, uint16 someAmount) public pure returns (bytes memory) {
        // Another way to get data (hard coded)
        return abi.encodeWithSignature(signature, someAddress, someAmount);
    }

    // ---------- abi.encodeWithSelector -------------- //

    function callTransferWithBinary(address someAddress, uint256 someAmount) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(getSelectorOne(), someAddress, someAmount));
        return (bytes4(returnData), success);
    }

    function callTransferWithBinary1(address someAddress, uint256 someAmount, bytes32 _bytes) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(getDataToCallTransfer(someAddress, someAmount));
        return (bytes4(returnData), success);
    }

    function callTransferWithBinary2(address someAddress, uint128 someAmount) public returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(getSelectorOne(), someAddress, someAmount));
        return (returnData, success);
    }

    function callTransferWithBinary3(address someAddress, uint64 someAmount, bytes memory _bytes) public returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(0xa9059cbb, someAddress, someAmount));
        return (returnData, success);
    }

    function callTransferWithBinary4(address someAddress, uint32 someAmount, bytes2 _bytes) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(hex"a9059cbb", someAddress, someAmount));
        return (bytes4(returnData), success);
    }

    function callTransferWithBinary5(bytes4 selector, address someAddress, uint16 someAmount, bytes6 _bytes) public returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(selector, someAddress, someAmount));
        return (returnData, success);
    }

    function callTransferWithBinary6(address someAddress, uint8 someAmount, bytes1 _bytes) public returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(bytes4(keccak256(bytes("transfer(address,uint256)"))), someAddress, someAmount));
        return (returnData, success);
    }

    function callTransferWithBinary7(bytes4 selector, address someAddress, uint24 someAmount) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(getDataToCallTransfer(selector, someAddress, someAmount));
        return (bytes4(returnData), success);
    }

    // ---------- abi.encodeWithSignature -------------- //

    function callTransferWithBinarySignature(address someAddress, uint8 someAmount) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSignature("transfer(address,uint256)", someAddress, someAmount));
        return (bytes4(returnData), success);
    }

    function callTransferWithBinarySignature(string memory signature, address someAddress, uint8 someAmount, bool _bool, bytes3 _bytes) public returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSignature(signature, someAddress, someAmount));
        return (returnData, success);
    }

    function callTransferWithBinarySignature1(bool _bool, bytes2 _bytes) public returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).call(getCallData());
        return (returnData, success);
    }

    function callTransferWithBinarySignature1(string memory signature, address someAddress, uint16 someAmount, bytes memory _bytes) public returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).call(getCallData(signature, someAddress, someAmount));
        return (returnData, success);
    }

    // ---------- get Static Call -------------- //
    
    function callSomeAmountWithBinary() public view returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).staticcall(abi.encodeWithSelector(0xbea7144c));
        return (returnData, success);
    }

    function callSomeAmountWithBinary(bytes4 selector) public view returns (uint256, bool) {
        (bool success, bytes memory returnData) = address(this).staticcall(abi.encodeWithSelector(selector));
        return (abi.decode(returnData, (uint256)), success);
    }

    function callSomeAddressWithBinarySignature() public view returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = address(this).staticcall(abi.encodeWithSignature("s_someAddress()"));
        return (returnData, success);
    }

    function callSomeAddressWithBinarySignature(string memory signature) public view returns (address, bool) {
        (bool success, bytes memory returnData) = address(this).staticcall(abi.encodeWithSignature(signature));
        return (abi.decode(returnData, (address)), success);
    }

}


contract CallFunctionWithoutContract {
    address public s_selectorAndSignatureAddress;

    constructor(address selectorAndSignatureAddress) {
        s_selectorAndSignatureAddress = selectorAndSignatureAddress;
    }

    // pass in 0xa9059cbb000000000000000000000000d7acd2a9fd159e69bb102a1ca21c9a3e3a5f771b000000000000000000000000000000000000000000000000000000000000007b
    // you could use this to change state
    function callFunctionDirectly(bytes calldata callData) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.call(abi.encodeWithSignature("getSelectorThree(bytes)",callData));
        return (bytes4(returnData), success);
    }

    // pass in 0xa9059cbb000000000000000000000000d7acd2a9fd159e69bb102a1ca21c9a3e3a5f771b000000000000000000000000000000000000000000000000000000000000007b
    // you could use this not change state
    function callFunctionDirectly1(bytes calldata callData) public view returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.staticcall(abi.encodeWithSignature("getSelectorThree(bytes)",callData));
        return (bytes4(returnData), success);
    }

    // pass in 0xa9059cbb000000000000000000000000d7acd2a9fd159e69bb102a1ca21c9a3e3a5f771b000000000000000000000000000000000000000000000000000000000000007b
    // you could use this not change state
    function callFunctionDirectly2(bytes calldata callData) public returns (bytes4, bool) {
        s_selectorAndSignatureAddress = s_selectorAndSignatureAddress;

        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.staticcall(abi.encodeWithSignature("getSelectorThree(bytes)",callData));
        return (bytes4(returnData), success);
    }

    // with a staticcall, we can have this be a view function!
    function staticFunctionCallDirectly() public view returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.staticcall(abi.encodeWithSignature("getSelectorOne()"));
        return (bytes4(returnData), success);
    }

    function callTransferFunctionDirectlyThree(address someAddress, uint256 amount) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.call(abi.encodeWithSignature("transfer(address,uint256)", someAddress, amount));
        return (bytes4(returnData), success);
    }

    function callTransferFunctionDirectlyThree1(address someAddress, uint256 amount) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.call(abi.encodeWithSelector(0xa9059cbb, someAddress, amount));
        return (bytes4(returnData), success);
    }

    function callSomeAmountFunctionDirectly() public view returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.staticcall(abi.encodeWithSignature("s_someAmount()"));
        return (returnData, success);
    }

    function callSomeAmountFunctionDirectly(string calldata signature) public view returns (uint256, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.staticcall(abi.encodeWithSignature(signature));
        return (abi.decode(returnData, (uint256)), success);
    }

    function callSomeAddressFunctionDirectly() public view returns (bytes memory, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.staticcall(abi.encodeWithSelector(0xaad229d5));
        return (returnData, success);
    }

    function callSomeAddressFunctionDirectly(bytes4 selector) public view returns (address, bool) {
        (bool success, bytes memory returnData) = s_selectorAndSignatureAddress.staticcall(abi.encodeWithSelector(selector));
        return (abi.decode(returnData, (address)), success);
    }

}