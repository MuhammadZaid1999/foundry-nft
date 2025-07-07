// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Encoding {
    
    // ---------- concatinating ----------- //
    
    function combineStrings() public pure returns (string memory) {
        return string(abi.encodePacked("Hi Mom! ", "Miss you!")); 
    }

    function combineStrings1() public pure returns (string memory) {
        string memory someString = "Hello!              World.    ";
        return string(abi.encodePacked("Hi Mom! ", "Miss you!     ", someString)); 
    }

    function combineStrings2() public pure returns (string memory) {
        string memory someString = "Hello!              World.    ";
        return string.concat("Hi Mom! ", "Miss you!", someString); 
    }

    function combineStrings3(string memory someString) public pure returns (string memory) {
        return string.concat("Hi Mom! ", "Miss you!", "I love you!", "Hello!    ", someString); 
    }

    // ---------- encoding ----------- //  

    function encodeString() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string");
        return someString;
    }

    function encodeString1() public pure returns (bytes memory) {
        return abi.encodePacked("Hi Mom! ", "Miss you!"); 
    }

    function encodeStrings2() public pure returns (bytes memory) {
        return abi.encodePacked("Hi Mom!    ", "  Miss       you!      "); 
    }

    function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(1);
        return number;
    }

    function encodeData() public pure returns (bytes memory) {
        bytes memory number = abi.encode(50, "some string", true, address(100));
        return number;
    }

    function encodeData1() public pure returns (bytes memory) {
        bytes memory number = abi.encode(50, "some string", true, address(100));
        return number;
    }

    // ---------- packed encoding ----------- //
    function encodePackedString() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string");
        return someString;
    }

    function encodePackedString1() public pure returns (bytes memory) {
        return abi.encodePacked("Hi Mom! ", "Miss you!"); 
    }

    function encodePackedStrings2() public pure returns (bytes memory) {
        return abi.encodePacked("Hi Mom!    ", "  Miss       you!      "); 
    }

    // ---------- encoding using bytes ----------- //

    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("some string");
        return someString;
    }

    // ---------- decoding ----------- //  

    function decodeString() public pure returns (string memory) {
        string memory someString = abi.decode(encodeString(), (string));
        return someString;
    }

    function decodeString1(bytes memory encodedData) public pure returns (string memory) {
        string memory someString = abi.decode(encodedData, (string));
        return someString;
    }

    // -------- packed decoding ------- //

    // -------- multi encoding ------- //

    function multiEncode() public pure returns (bytes memory) {
        return abi.encode("some string", "it's bigger!");
    }

    // -------- multi decoding ------- //

    function multiDecode() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(multiEncode(), (string, string));
        return (someString, someOtherString);
    }

    // -------- multi packed encoding ------- //
    
    function multiEncodePacked() public pure returns (bytes memory){
        bytes memory someString = abi.encodePacked("some string", "it's bigger!");
        return someString;
    }
    
    // -------- multi packed decoding ------- //

    function multiStringCastPacked() public pure returns (string memory){ 
        string memory someString = string(multiEncodePacked());
        return someString;
    }

}
