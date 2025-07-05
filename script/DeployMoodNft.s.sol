// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { MoodNft } from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        /*
            ----- can also use this -----
            vm.startBroadcast();
            MoodNft moodNft = new MoodNft(
                svgToImageUri(sadSvg),
                svgToImageUri(happySvg)
            );
            vm.stopBroadcast();

            return moodNft;
        
            ------ or this -----
            MoodNft moodNft = deployMoodNft(sadSvg, happySvg);
            return moodNft;
        */

       return deployMoodNft(sadSvg, happySvg);
    }

    function deployMoodNft(string memory sadSvg, string memory happySvg) public returns (MoodNft) {
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageUri(sadSvg),
            svgToImageUri(happySvg)
        );
        vm.stopBroadcast();

        return moodNft;
    }

    function svgToImageUri(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        /*
            ----- can also use this -----
            string memory svgBase64Encoded = Base64.encode(abi.encodePacked(svg));
        */
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        
        /*
            ----- can also use this -----
            return string(abi.encodePacked(baseURL, svgBase64Encoded));
        */
        return string.concat(baseURL, svgBase64Encoded);
    }
}