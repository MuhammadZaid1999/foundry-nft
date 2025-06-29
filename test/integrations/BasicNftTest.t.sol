//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNFTTest is Test {

    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public USER = makeAddr("user");
    
    // "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    string public constant PUG =
      "ipfs://bafybeiaxstngs3daaf6dfguwnt5gq26w23lr6vugoexo2b73h6omf66rsm";


    function setUp() public {
      deployer = new DeployBasicNft();
      basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Doggie";
        string memory actualName = basicNft.name();

        assert(
            keccak256(abi.encodePacked(expectedName)) == 
            keccak256(abi.encodePacked(actualName))
        );
    }

    function testNameIsCorrect1() public view {
        string memory expectedName = "Doggie";
        string memory actualName = basicNft.name();

        assertEq(expectedName, actualName);
    }

    function testSymbolIsCorrect() public view {
        string memory expectedSymbol = "DG";
        string memory actualSymbol = basicNft.symbol();

        assert(
            keccak256(abi.encodePacked(expectedSymbol)) == 
            keccak256(abi.encodePacked(actualSymbol))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNFT(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) == 
            keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

}
