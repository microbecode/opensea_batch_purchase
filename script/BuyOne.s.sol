// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.17 <=0.9.0;

import { BaseScript } from "./Base.s.sol";
import { Consideration } from "seaport-core/lib/Consideration.sol";
import { Seaport } from "seaport-core/Seaport.sol";
import {
    OrderComponents,
    OfferItem,
    ConsiderationItem,
    BasicOrderParameters,
    AdditionalRecipient
} from "seaport-types/src/lib/ConsiderationStructs.sol";
import { BasicOrderType, ItemType, OrderType, Side } from "seaport-types/src/lib/ConsiderationEnums.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract BuyOne is BaseScript {
    address public seaport = 0x00000000000000ADc04C56Bf30aC9d3c0aAF14dC; // seaport 1.5
    address public conduitController = 0x00000000F9490004C11Cef243f5400493c00Ad63; // conduitController
    //address public nft = 0x8a90CAb2b38dba80c64b7734e58Ee1dB38B8992e; // Doodle token
    address public nft = 0x0A1BBD57033F57E7B6743621b79fCB9Eb2CE3676; // Orbifold
    //uint256 public tokenId = 7484; // doodle
    uint256 public tokenId = 45_000_091; // orbifold
    uint256 public currentOwnerCounter = 0;
    address public currentOwner = 0x9882e75d33211CbfF45B0e87d9de0892D664dBff;
    //bytes32 public hashZero = 0x0000000000000000000000000000000000000000000000000000000000000000;
    address public addressZero = 0x0000000000000000000000000000000000000000;
    uint256 public futureBlock = 27_949_204;
    uint256 public buyPrice = 1_500_000_000_000_000_000; // 1,5 eth

    function run() public broadcast {
        bytes32 salt = 0x7465737400000000000000000000000000000000000000000000000000000005;
        uint256 startTime = 0;
        uint256 endTime = 5_172_014_448_931_175_958_106_549_077_934_080; // 0xff00000000000000000000000000 in decimal

        Seaport seaport = Seaport(payable(seaport));

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
        OfferItem memory offerItem = OfferItem(
            ItemType.NATIVE, // ItemType
            addressZero, // token
            0, // identifierOrCriteria
            1, // startAmount
            1 // endAmount
        );
        OfferItem[] memory offerItems = new OfferItem[](1);
        offerItems[0] = offerItem;

        ConsiderationItem memory consideration = ConsiderationItem(
            ItemType.ERC721, // ItemType
            nft, // token
            tokenId, // identifierOrCriteria
            1, // startAmount
            1, // endAmount
            payable(addressZero) // recipient
        );
        ConsiderationItem[] memory considerationItems = new ConsiderationItem[](1);
        considerationItems[0] = consideration;

        OrderComponents memory order = OrderComponents(
            msg.sender, // offerer
            addressZero, // zone
            offerItems, // offer
            considerationItems, // consideration
            OrderType.FULL_OPEN, // orderType
            0, // startTime
            futureBlock, // endTime
            ZERO_SALT, // zoneHash
            123, // salt
            ZERO_SALT, // conduit
            currentOwnerCounter // counter
        );

        /*
        struct BasicOrderParameters {
    // calldata offset
    address considerationToken; // 0x24
    uint256 considerationIdentifier; // 0x44
    uint256 considerationAmount; // 0x64
    address payable offerer; // 0x84
    address zone; // 0xa4
    address offerToken; // 0xc4
    uint256 offerIdentifier; // 0xe4
    uint256 offerAmount; // 0x104
    BasicOrderType basicOrderType; // 0x124
    uint256 startTime; // 0x144
    uint256 endTime; // 0x164
    bytes32 zoneHash; // 0x184
    uint256 salt; // 0x1a4
    bytes32 offererConduitKey; // 0x1c4
    bytes32 fulfillerConduitKey; // 0x1e4
    uint256 totalOriginalAdditionalRecipients; // 0x204
    AdditionalRecipient[] additionalRecipients; // 0x224
    bytes signature; // 0x244
    // Total length, excluding dynamic array data: 0x264 (580)
        }
        */

        AdditionalRecipient[] memory additionalRecipient = new AdditionalRecipient[](0);
        bytes memory signature; // = 0x74657374696e67206461746120666f722064796e616d6963206279746573;

        BasicOrderParameters memory basicOrder = BasicOrderParameters(
            nft, // considerationToken
            tokenId, // considerationIdentifier
            1, // considerationAmount
            payable(msg.sender), // offerer
            addressZero, // zone
            addressZero, // offerToken
            0, // offerIdentifier
            buyPrice, // offerAmount
            BasicOrderType.ETH_TO_ERC721_FULL_OPEN, // basicOrderType
            0, // startTime
            futureBlock, // endTime
            ZERO_SALT, // zoneHash
            123, // salt
            ZERO_SALT, // offererConduitKey
            ZERO_SALT, // fulfillerConduitKey
            0, // totalOriginalAdditionalRecipients
            additionalRecipient, // additionalRecipients
            signature // signature
        );

        bool succ = seaport.fulfillBasicOrder(basicOrder);
    }
}
