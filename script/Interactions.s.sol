// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {ManualNft} from "../src/ManualNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";


contract MintBasicNft is Script{
    // "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    string public constant TOKENURI = 
        "ipfs://bafybeiaxstngs3daaf6dfguwnt5gq26w23lr6vugoexo2b73h6omf66rsm";
    
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNFT(TOKENURI);
        vm.stopBroadcast();

    }

}

contract MintManualNft is Script{
    // "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    string public constant TOKENURI = 
        "ipfs://bafybeiaxstngs3daaf6dfguwnt5gq26w23lr6vugoexo2b73h6omf66rsm";
    
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ManualNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        ManualNft(contractAddress).mintNFT(TOKENURI);
        vm.stopBroadcast();

    }

}
