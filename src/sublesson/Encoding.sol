// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Encoding {

    struct User{
        uint256 userId;
        string name;
    }
    
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
        return abi.encode("Hi Mom! ", "Miss you!"); 
    }

    function encodeStrings2() public pure returns (bytes memory) {
        return abi.encode("Hi Mom!    ", "  Miss       you!      "); 
    }

    function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(1);
        return number;
    }

    function encodeAddress() public pure returns (bytes memory) {
        bytes memory addr = abi.encode(address(123456));
        return addr;
    }

    function encodeBoolean(bool val) public pure returns (bytes memory) {
        bytes memory addr = abi.encode(val);
        return addr;
    }

    function encodeByte() public pure returns (bytes memory) {
        bytes4 val = 0x54678456;
        bytes memory addr = abi.encode(val);
        return addr;
    }

    function encodeData() public pure returns (bytes memory) {
        bytes1 num = 0x23;
        bytes4 num1 = 0x12345678;
        bytes memory byt = "ZAID1234565433i33i4QWEE@@@$$##";
        string memory someStr = "some string";
        bytes memory data = abi.encode(50, someStr, true, address(100), num, num1, byt, 0x546);
        return data;
    }

    function encodeData2(int num, int[] memory nums) public pure returns (bytes memory) {
        string[5] memory strData = ["1","2","3","4","5"];
        bytes[3] memory bytesData = [bytes("0x12300041"), "0x546783453", "0x34567893"];
        bytes2[3] memory bytesData1 = [bytes2(0x1234), 0x5123, 0x3456];
        bytes memory data = abi.encode([1,2,3], ["1","2","3"],[0x1, 0x111, 0x4543344555], num, strData, nums, User(1, "name"), [User(1, "name"), User(2,"Name")], bytesData, bytesData1);
        return data;
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

    function encodePackedAddress() public pure returns (bytes memory) {
        bytes memory addr = abi.encodePacked(address(123456));
        return addr;
    }

    function encodePackedBoolean(bool val) public pure returns (bytes memory) {
        bytes memory addr = abi.encodePacked(val);
        return addr;
    }

    function encodePackedByte() public pure returns (bytes memory) {
        bytes4 val = 0x54678456;
        bytes memory addr = abi.encodePacked(val);
        return addr;
    }

    function encodePackedData() public pure returns (bytes memory) {
        bytes1 num = 0x23;
        bytes4 num1 = 0x12345678;
        bytes memory byt = "ZAID1234565433i33i4QWEE@@@$$##";
        bytes memory data = abi.encodePacked("some string", true, address(100), num, num1, byt);
        return data;
    }

    function encodePackedData2(int num, int[] memory nums) public pure returns (bytes memory) {
        bytes2[3] memory bytesData1 = [bytes2(0x1234), 0x5123, 0x3456];
        bytes memory data = abi.encodePacked([1,2,3],[0x1, 0x111, 0x4543344555], num, nums, bytesData1);
        return data;
    }

    // ---------- encoding string using bytes ----------- //

    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("some string!");
        return someString;
    }

    function encodeStringBytes1() public pure returns (bytes memory) {
        bytes memory someString = bytes("some string!    Hello!     World.");
        return someString;
    }

    // ---------- decoding string using bytes ----------- //

    function decodeStringBytes() public pure returns (string memory) {
        string memory someString = string(encodeStringBytes());
        return someString;
    }

    function decodeStringBytes1() public pure returns (string memory) {
        string memory someString = string(encodeStringBytes1());
        return someString;
    }

    function decodeStringBytes2() public pure returns (string memory) {
        string memory someString = string.concat(string(encodeStringBytes()), string(encodeStringBytes1()));
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
