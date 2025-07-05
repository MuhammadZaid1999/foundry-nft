// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {ManualNft} from "../src/ManualNft.sol";

contract DeployManualNft is Script {
    ManualNft manualNft; 

    function run() external returns (ManualNft){
        return deployManualNft("ManualDoggie", "MDG");
    }

    function deployManualNft(string memory name, string memory symbol) public returns (ManualNft){
        vm.startBroadcast();
        manualNft = new ManualNft(name, symbol);
        vm.stopBroadcast();

        return manualNft;
    }

    // ----- only for checking purpose ----
    function mintManualNft(string calldata PUG) public {
        address USER = makeAddr("user");
        vm.startBroadcast(USER);
        manualNft.mintNFT(PUG);
        vm.stopBroadcast();
    }

    function mintManualNft1() public {
        string memory PUG =
            "ipfs://bafybeiaxstngs3daaf6dfguwnt5gq26w23lr6vugoexo2b73h6omf66rsm";

        vm.startBroadcast();
        manualNft.mintNFT(PUG);
        vm.stopBroadcast();
    }
    
}
