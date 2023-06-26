// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/6-Storage-of-arrays.sol";

contract StorageComplexTest is Test {
    StorageComplex public sto;

    function setUp() public {
        sto = new StorageComplex();
    }

    function testFixedArrayView() public {
        assertEq(sto.fixedArrayView(0), 99);
        assertEq(sto.fixedArrayView(1), 999);
        assertEq(sto.fixedArrayView(2), 9999);
    }

    function testBigArrayLength() public {
        assertEq(sto.bigArrayLength(), 4);
    }

    function testReadBigArrayLocation() public {
        assertEq(sto.readBigArrayLocation(0), 10);
        assertEq(sto.readBigArrayLocation(1), 20);
        assertEq(sto.readBigArrayLocation(2), 30);
        assertEq(sto.readBigArrayLocation(3), 40);
    }

    function testReadSmallArray() public {
        assertEq(sto.readSmallArray(), 3);
    }

    function testReadSmallArrayLocation() public {
        assertEq(sto.readSmallArrayLocation(0), 0x0000000000000000000000000000000000000000000000000000000000030201);
    }

    function testGetMapping() public {
        assertEq(sto.getMapping(10), 5);
        assertEq(sto.getMapping(11), 6);
    }

    function testGetNestedMapping() public {
        assertEq(sto.getNestedMapping(), 7);
    }

    function testLengthOfNestedList() public {
        assertEq(sto.lengthOfNestedList(), 3);
    }

    function testGetAddressToList() public {
        assertEq(sto.getAddressToList(0), 42);
        assertEq(sto.getAddressToList(1), 1337);
        assertEq(sto.getAddressToList(2), 777);
    }
}
