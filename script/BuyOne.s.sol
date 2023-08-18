// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <=0.9.0;

import { BaseScript } from "./Base.s.sol";
import "seaport-core/lib/Consideration.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract BuyOne is BaseScript {
    address public seaport = 0x00000000000000ADc04C56Bf30aC9d3c0aAF14dC; // seaport 1.5
    address public nft = 0x8a90CAb2b38dba80c64b7734e58Ee1dB38B8992e; // Doodle token
    uint256 public tokenId = 7484;

    function run() public broadcast { }
}
