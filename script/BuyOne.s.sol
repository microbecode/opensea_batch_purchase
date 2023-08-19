// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.17 <=0.9.0;

import { BaseScript } from "./Base.s.sol";
import { Consideration } from "seaport-core/lib/Consideration.sol";
import { OrderComponents, OfferItem, ConsiderationItem } from "seaport-types/src/lib/ConsiderationStructs.sol";
import {
    BasicOrderType,
    ItemType,
    OrderType,
    Side
} from "seaport-types/src/lib/ConsiderationEnums.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract BuyOne is BaseScript {
    address public seaport = 0x00000000000000ADc04C56Bf30aC9d3c0aAF14dC; // seaport 1.5
    address public conduitController = 0x00000000F9490004C11Cef243f5400493c00Ad63; // conduitController
    //address public nft = 0x8a90CAb2b38dba80c64b7734e58Ee1dB38B8992e; // Doodle token
    address public nft = 0x0A1BBD57033F57E7B6743621b79fCB9Eb2CE3676; // Orbifold
    //uint256 public tokenId = 7484; // doodle
    uint256 public tokenId = 45000091; // orbifold
    uint256 public currentOwnerCounter = 0;
    address public currentOwner = 0x9882e75d33211CbfF45B0e87d9de0892D664dBff;
    bytes32 public hashZero = 0x0000000000000000000000000000000000000000000000000000000000000000;
    address public addressZero = 0x000000000000000000000000000000000000;

    function run() public broadcast {
        bytes32 salt = 0x7465737400000000000000000000000000000000000000000000000000000005;
        uint256 startTime = 0;
        uint256 endTime = 5172014448931175958106549077934080; // 0xff00000000000000000000000000 in decimal
/*
struct OfferItem {
    ItemType itemType;
    address token;
    uint256 identifierOrCriteria;
    uint256 startAmount;
    uint256 endAmount;
}

struct ConsiderationItem {
    ItemType itemType;
    address token;
    uint256 identifierOrCriteria;
    uint256 startAmount;
    uint256 endAmount;
    address payable recipient;
}

struct OrderComponents {
    address offerer;
    address zone;
    OfferItem[] offer;
    ConsiderationItem[] consideration;
    OrderType orderType;
    uint256 startTime;
    uint256 endTime;
    bytes32 zoneHash;
    uint256 salt;
    bytes32 conduitKey;
    uint256 counter;
}

*/
        OrderItem memory orderItem = OrderItem(
            ItemType.NATIVE, // ItemType
            addressZero, // token
            0, // identifierOrCriteria
            1, // startAmount
            1 // endAmount
        );
        ConsiderationItem memory consideration = ConsiderationItem(
            ItemType.ERC721, // ItemType
            nft, // token
            0, // identifierOrCriteria
            1, // startAmount
            1, // endAmount
            addressZero // recipient
        );

        OrderComponents memory order = OrderComponents(
            msg.sender, // offerer
            addressZero, // zone
            [orderItem], // offer
        );
        Consideration cons = Consideration(payable(seaport));


        
     }
}
