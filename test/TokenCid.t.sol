// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {TokenCid} from "../src/TokenCid.sol";

contract TokenCidTest is Test {
    TokenCid public Token;
    string cid =" newCid";
    string id = "fileName";
    address owner;



    function setUp() public {
        Token = new TokenCid();
        owner = address(Token);
    }

    function test_getCid() public {
        Token.setCid(owner,id,cid);
        assertEq(Token.getCid(owner,id), cid);
    }

  
}
