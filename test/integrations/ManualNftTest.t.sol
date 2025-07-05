//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {ManualNft} from "../../src/ManualNft.sol";
import {DeployManualNft} from "../../script/DeployManualNft.s.sol";

contract ManualNftTest is Test {

    DeployManualNft public deployer;
    ManualNft public manualNft;

    address public USER = makeAddr("user");
    
    // "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    string public constant PUG =
      "ipfs://bafybeiaxstngs3daaf6dfguwnt5gq26w23lr6vugoexo2b73h6omf66rsm";


    function setUp() public {
      deployer = new DeployManualNft();
      manualNft = deployer.deployManualNft("ManualNft", "MT");
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "ManualNft";
        string memory actualName = manualNft.name();

        assert(
            keccak256(abi.encodePacked(expectedName)) == 
            keccak256(abi.encodePacked(actualName))
        );
    }

    function testNameIsCorrect1() public view {
        string memory expectedName = "ManualNft";
        string memory actualName = manualNft.name();

        assertEq(expectedName, actualName);
    }

    function testSymbolIsCorrect() public view {
        string memory expectedSymbol = "MT";
        string memory actualSymbol = manualNft.symbol();

        assert(
            keccak256(abi.encodePacked(expectedSymbol)) == 
            keccak256(abi.encodePacked(actualSymbol))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        manualNft.mintNFT(PUG);

        assert(manualNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) == 
            keccak256(abi.encodePacked(manualNft.tokenURI(0)))
        );
    }

    // ----- only for checking purpose ----
    function testCanMintAndHaveABalance1() public {
        deployer.mintManualNft(PUG);
        assert(manualNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) == 
            keccak256(abi.encodePacked(manualNft.tokenURI(0)))
        );

        deployer.mintManualNft1();
        assert(manualNft.balanceOf(DEFAULT_SENDER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) == 
            keccak256(abi.encodePacked(manualNft.tokenURI(0)))
        );
    }

}
