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

    function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(1);
        return number;
    }

    function encodeAddress() public pure returns (bytes memory) {
        bytes memory addr = abi.encode(address(5));
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

    // ---------- packed encoding ----------- //
    function encodePackedString() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string");
        return someString;
    }

    function encodePackedNumber() public pure returns (bytes memory) {
        uint256 someNumber = 10278645554431;
        bytes memory number = abi.encodePacked(someNumber);
        return number;
    }

    function encodePackedAddress() public pure returns (bytes memory) {
        bytes memory addr = abi.encodePacked(address(10));
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

    function decodeNumber() public pure returns (uint8) {
        uint8 someString = abi.decode(encodeNumber(), (uint8));
        return someString;
    }

    function decodeAddress() public pure returns (address) {
        address someString = abi.decode(encodeAddress(), (address));
        return someString;
    }

    function decodeBoolean() public pure returns (bool) {
        bool someString = abi.decode(encodeBoolean(true), (bool));
        return someString;
    }

    function decodeByte() public pure returns (bytes4) {
        bytes4 someString = abi.decode(encodeByte(), (bytes4));
        return someString;
    }

    // -------- packed decoding ------- //
    function decodePackedString() public pure returns (string memory) {
        string memory someString = string(encodePackedString());
        return someString;
    }

    function decodePackedNumber() public pure returns (uint256) {
        uint256 someString = abi.decode(encodePackedNumber(), (uint256));
        return someString;
    }

    function decodePackedByte() public pure returns (bytes4) {
        bytes4 addr = bytes4(encodePackedByte());
        return addr;
    }

    // -------- multi encoding ------- //

    function encodeString1() public pure returns (bytes memory) {
        return abi.encode("Hi Mom! ", "Miss you!"); 
    }

    function encodeStrings2() public pure returns (bytes memory) {
        return abi.encode("Hi Mom!    ", "  Miss       you!      "); 
    }

    function encodeData() public pure returns (bytes memory) {
        bytes1 num = 0x23;
        bytes4 num1 = 0x12345678;
        bytes memory byt = "ZAID1234565433i33i4QWEE@@@$$##";
        string memory someStr = "some string";
        bytes memory data = abi.encode(50, someStr, true, address(100), num, num1, byt, "zaidi", bytes2(0x1234), bytes("0x12345"));
        return data;
    }

    function encodeData2() public pure returns (bytes memory) {
        int[4] memory nums = [int(1),2,4,5];
        string[5] memory strData = ["1","2","3","4","5"];
        bytes[3] memory bytesData = [bytes("0x12300041"), "0x546783453", "0x34567893"];
        bytes2[3] memory bytesData1 = [bytes2(0x1234), 0x5123, 0x3456];
        User memory user = User(1, "aaaa");
        User[2] memory user1 = [User(1, "bbbb"), User(2,"cccc")];
        bytes memory data = abi.encode(strData, nums, user, user1, bytesData, bytesData1);
        return data;
    }

    function encodeData3() public pure returns (bytes memory) {
        bytes memory data = abi.encode(["1","2","3","4","5"], [1,2,4,5], User(1, "aaaa"), [User(1, "bbbb"), User(2,"cccc")], [bytes("0x12300041"), "0x546783453", "0x34567893"], [bytes2(0x1234), 0x5123, 0x3456]);
        return data;
    }

    int[] numss;
    string[] strDatas;
    bytes[] bytesDatas;
    bytes2[] bytesDatas1;
    User[] users1; 

    function encodeData4() public returns (bytes memory) {
        numss.push(1);
        numss.push(1);
        numss.push(1);
        numss.push(1);

        strDatas.push("1");
        strDatas.push("1");
        strDatas.push("1");

        bytesDatas.push("0x12300040");
        bytesDatas.push("0x12300041");
        bytesDatas.push("0x12300042");
        
        bytesDatas1.push(0x1234);
        bytesDatas1.push(0x5123);
        bytesDatas1.push(0x3456);

        User memory user = User(1, "aaaa");
        
        users1.push(User(1, "bbbb")); 
        users1.push(User(2, "cccc"));
        
        bytes memory data = abi.encode(strDatas, numss, user, users1, bytesDatas, bytesDatas1);
        return data;
    }

    function multiEncode() public pure returns (bytes memory) {
        return abi.encode("some string", "it's bigger!");
    }

    // -------- multi decoding ------- //

    function decodeString1() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(encodeString1(), (string, string));
        return (someString, someOtherString);
    }

    function decodeString2() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(encodeStrings2(), (string, string));
        return (someString, someOtherString);
    }

    function decodeData() public pure returns (uint8, string memory, bool, address, bytes1, bytes4, bytes memory, string memory) {
        (uint8 a, string memory b, bool c, address d, bytes1 e, bytes4 f, bytes memory g, string memory h,,) = abi.decode(encodeData(), (uint8, string, bool, address, bytes1, bytes4, bytes, string, bytes2, bytes));
        return (a, b, c, d, e, f, g, h);
    }

    function decodeData1() public pure returns (bytes2, bytes memory) {
        (,,,,,,,, bytes2 i, bytes memory j) = abi.decode(encodeData(), (uint8, string, bool, address, bytes1, bytes4, bytes, string, bytes2, bytes));
        return (i, j);
    }

    function decodeData2() public pure returns (string[5] memory a, int[4] memory b, User memory c, User[2] memory d, bytes[3] memory e, bytes2[3] memory f) {
        (a, b, c, d, e, f) = abi.decode(encodeData2(), (string[5], int[4], User, User[2], bytes[3], bytes2[3]));
    }

    function decodeData3() public pure returns (string[5] memory a, int[4] memory b, User memory c, User[2] memory d, bytes[3] memory e, bytes2[3] memory f) {
        (a, b, c, d, e, f) = abi.decode(encodeData3(), (string[5], int[4], User, User[2], bytes[3], bytes2[3]));
    }

    function decodeData4() public returns (string[] memory a, int[] memory b, User memory c, User[] memory d, bytes[] memory e, bytes2[] memory f) {
        (a, b, c, d, e, f) = abi.decode(encodeData4(), (string[], int[], User, User[], bytes[], bytes2[]));
    }

    function multiDecode() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(multiEncode(), (string, string));
        return (someString, someOtherString);
    }

    // -------- multi packed encoding ------- //

    function encodePackedString1() public pure returns (bytes memory) {
        return abi.encodePacked("Hi Mom! ", "Miss you!"); 
    }

    function encodePackedStrings2() public pure returns (bytes memory) {
        return abi.encodePacked("Hi Mom!    ", "  Miss       you!      "); 
    }

    function encodePackedData() public pure returns (bytes memory) {
        bytes memory data = abi.encodePacked(uint256(50), bytes32(0x3456789101112131415161718192021222324252627342424232322213221133));
        return data;
    }

    function encodePackedData2() public pure returns (bytes memory) {
        uint8[4] memory nums = [uint8(1),2,4,5];
        bytes2[3] memory bytesData1 = [bytes2(0x1234), 0x5123, 0x3456];
        bytes memory data = abi.encodePacked(int256(-50), nums, bytesData1);
        return data;
    }

    function encodePackedData3() public pure returns (bytes memory) {
        bytes memory data = abi.encodePacked([1,2,4,5], [bytes2(0x1234), 0x5123, 0x3456]);
        return data;
    }

    function encodePackedData4() public returns (bytes memory) {
        numss.push(1);
        numss.push(1);
        numss.push(1);
        numss.push(1);

        bytesDatas1.push(0x1234);
        bytesDatas1.push(0x5123);
        bytesDatas1.push(0x3456);
                
        bytes memory data = abi.encodePacked(numss, bytesDatas1);
        return data;
    }
    
    function multiEncodePacked() public pure returns (bytes memory){
        bytes memory someString = abi.encodePacked("some string", "it's bigger!");
        return someString;
    }
    
    // -------- multi packed decoding ------- //

    function decodePackedString1() public pure returns (string memory) {
        string memory someString = string(encodePackedString1());
        return someString;
    }

    function decodePackedStrings2() public pure returns (string memory) {
        string memory someString = string(encodePackedStrings2());
        return someString;
    }

    function decodePackedData() public pure returns (uint256, bytes32) {
        (uint256 a, bytes32 b) = abi.decode(encodePackedData(), (uint256, bytes32));
        return (a, b);
    }

    function decodePackedData2() public pure returns (int256 a, int[4] memory c, bytes2[3] memory d) {
        (a, c, d) = abi.decode(encodePackedData2(), (int256, int[4], bytes2[3]));
    }

    function decodePackedData3() public pure returns (int[4] memory a, bytes2[3] memory b) {
        (a, b) = abi.decode(encodePackedData3(), (int[4], bytes2[3]));
    }

    // ------ only for one time call -------
    function decodePackedData4() public returns (int[4] memory a, bytes2[3] memory b) {
        (a, b) = abi.decode(encodePackedData4(), (int256[4], bytes2[3]));
    }

    function multiStringCastPacked() public pure returns (string memory){ 
        string memory someString = string(multiEncodePacked());
        return someString;
    }

}
