// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";


contract MintBasicNft is Script{
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
