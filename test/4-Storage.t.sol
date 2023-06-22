// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "../src/4-Storage.sol";

contract StorageTest is Test {
    StorageBasics public sto;

    function setUp() public {
        sto = new StorageBasics();
    }

    function testGetSlot() public {
        assertEq(sto.getSlot(), 3);
    }

    function testGetXYul() public {
        assertEq(sto.getXYul(), 2);
    }

    function testGetVarYul() public {
        assertEq(sto.getVarYul(2), bytes32(uint256(54)));
    }

    function testSetVarYul() public {
        sto.setVarYul(10, 33);
        assertEq(sto.getVarYul(10), bytes32(uint256(33)));
    }

    function testGetX() public {
        assertEq(sto.getX(), 2);
    }

    function testSetX() public {
        sto.setX(100);
        assertEq(sto.getX(), 100);
    }
}
