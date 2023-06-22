// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/2-YulTypes.sol";

contract YulTypesTest is Test {
    YulTypes public types;

    function setUp() public {
        types = new YulTypes();
    }

    function testGetNumber() public {
        assertEq(types.getNumber(), 42);
    }

    function testGetX() public {
        assertEq(types.getX(), 10);
    }

    function testGetString() public {
        string memory actual = types.getString();
        string memory expected = string("Hello World");
        assertEq(bytes32(bytes(actual)), bytes32(bytes(expected)));
    }
}
