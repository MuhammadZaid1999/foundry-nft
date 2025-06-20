// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {ManualNft} from "../src/ManualNft.sol";

contract DeployManualNft is Script {

    function run() external returns (ManualNft){
        deployManualNft("ManualDoggie", "MDG");
    }

    function deployManualNft(string memory name, string memory symbol) public returns (ManualNft){
        vm.startBroadcast();
        ManualNft manualNft = new ManualNft(name, symbol);
        vm.stopBroadcast();

        return manualNft;
    }
    
}
