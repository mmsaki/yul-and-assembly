// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/7-9-Memory-Operations.sol";

contract MemoryTest is Test {
    Memory public mem;

    function setUp() public {
        mem = new Memory();
    }

    function testHighAccess() public {
        vm.expectRevert();
        mem.highAcess();
    }

    function testMstore() public {
        // bytes32 val = vm.load();
        assertEq(
            mem.mstore(),
            0x0000000000000000000000000000000000000000000000000000000000000007
        );
    }

    function testMstore8() public {
        assertEq(
            mem.mstore8(),
            0x0700000000000000000000000000000000000000000000000000000000000000
        );
    }

    function testMemoryPointrt() public {
        (bytes32 bef, bytes32 aft) = mem.memPointer();
        assertEq(
            bef,
            0x0000000000000000000000000000000000000000000000000000000000000080
        );
        assertEq(
            aft,
            0x00000000000000000000000000000000000000000000000000000000000000c0
        );
    }
}
