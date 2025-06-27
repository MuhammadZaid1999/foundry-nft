// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Base64 } from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNFT__CantFlipMoodIfNotOwner();

    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    uint256 private s_tokenCounter;

    enum Mood {
        SAD,
        HAPPY
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSvgImageUri, string memory happySvgImageUri) ERC721("MoodNFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if(s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        // string memory tokenMetadata = string.concat(
        //     '{"name:"', 
        //     name(),
        //     '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image":',
        //     imageURI,
        //     '"}'
        // );

        // string.concat(
        //     '{"name:"', 
        //     name(),
        //     '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image":',
        //     imageURI,
        //     '"}'
        // );

        /*
            we just have our metadata as a string in our contract, 
            we need to convert this to the hashed syntax that our browser understands.
            Currently we have a string, in order to acquire the Base64 hash of this data, 
            we need to first convert this string to bytes, we can do this with some typecasting.
        */

        // abi.encodePacked(
        //     '{"name:"', 
        //     name(),
        //     '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image":',
        //     imageURI,
        //     '"}'
        // );

        // bytes(
        //     abi.encodePacked(
        //         '{"name:"', 
        //         name(),
        //         '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image":',
        //         imageURI,
        //         '"}'
        //     )
        // );

        /*
            Now we can apply our Base64 encoding to acquire our hash.
        */

        // Base64.encode(
        //     abi.encodePacked(
        //         '{"name:"', 
        //         name(),
        //         '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image":',
        //         imageURI,
        //         '"}'
        //     )
        // );

        // Base64.encode(
        //     bytes(
        //         abi.encodePacked(
        //             '{"name:"', 
        //             name(),
        //             '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image":',
        //             imageURI,
        //             '"}'
        //         )
        //     )
        // );

        /*
            we can concatenate the result of this _baseURI function with the Base64 encoding of our JSON object... 
            and finally we can type cast all of this as a string to be returned by our tokenURI function.
        */

        /* 
          ------ final metadata ------ 
        */
        // return string(
        //     abi.encodePacked(
        //         _baseURI(),
        //         Base64.encode(
        //             bytes(
        //                 abi.encodePacked(
        //                     '{"name: "',
        //                     name(),
        //                     '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image": ',
        //                     imageURI,
        //                     '"}'
        //                 )
        //             )
        //         )
        //     )
        // );

        /* 
          ------ another way to set final metadata ------ 
        */
        string memory metadata = Base64.encode(
            bytes(
                abi.encodePacked(
                    '{"name:"', 
                    name(),
                    '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image":',
                    imageURI,
                    '"}'
                )
            )
        );

        // return string(abi.encodePacked(_baseURI(), metadata));
        return string.concat(_baseURI(), metadata);
    }

    function flipMood(uint256 tokenId) public {
        if((getApproved(tokenId) != msg.sender) && (ownerOf(tokenId) != msg.sender)) {
            revert MoodNFT__CantFlipMoodIfNotOwner();
        }

        if(s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

}
