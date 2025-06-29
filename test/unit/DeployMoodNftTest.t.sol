// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Test} from "forge-std/Test.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() external {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIyMDAiIHk9IjI1MCIgZmlsbD0id2hpdGUiPkhpISBZb3UgZGVjb2RlZCB0aGlzIXsiICJ9PC90ZXh0Pjwvc3ZnPg==";
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="200" y="250" fill="white">Hi! You decoded this!{" "}</text></svg>';
    
        string memory actualUri = deployer.svgToImageUri(svg);
        assertEq(actualUri, expectedUri, "The SVG URI does not match the expected value.");
        assert(
            keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri))
        );
    }
}