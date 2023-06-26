// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "../src/5-Bitshifting.sol";

contract BitShiftingTest is Test {
    BitshiftingBasics public bs;

    function setUp() public {
        bs = new BitshiftingBasics();
    }

    function testReadBySlot() public {
        assertEq(bs.readBySlot(0), 0x0001000800000000000000000000000600000000000000000000000000000004);
    }

    function testGetOffset() public {
        (uint256 slot, uint256 offset) = bs.getOffset();
        assertEq(slot, 0);
        assertEq(offset, 28);
    }

    function testReadE() public {
        assertEq(bs.readE(), 8);
    }

    function testReadEalt() public {
        assertEq(bs.readEalt(), 8);
    }

    function testWriteToE() public {
        bs.writeToE(40);
        assertEq(bs.E(), 40);
    }
}
