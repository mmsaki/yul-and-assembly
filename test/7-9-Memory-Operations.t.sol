// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.18;

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
        assertEq(mem.mstore(), 0x0000000000000000000000000000000000000000000000000000000000000007);
    }

    function testMstore8() public {
        assertEq(mem.mstore8(), 0x0700000000000000000000000000000000000000000000000000000000000000);
    }

    function testMemoryPointer() public {
        (bytes32 memBefore, bytes32 memAfter) = mem.memPointer();
        assertEq(memBefore, 0x0000000000000000000000000000000000000000000000000000000000000080);
        assertEq(memAfter, 0x00000000000000000000000000000000000000000000000000000000000000c0);
        assertEq(uint256(memAfter) - uint256(memBefore), 64);
    }

    function testMemoryPointerV2() public {
        (bytes32 memPointerBefore, bytes32 msizeBefore, bytes32 memPointerAfter, bytes32 msizeAfter) =
            mem.memPointerV2();
        assertEq(memPointerBefore, 0x0000000000000000000000000000000000000000000000000000000000000080);
        assertEq(msizeBefore, 0x0000000000000000000000000000000000000000000000000000000000000060);
        assertEq(memPointerAfter, 0x00000000000000000000000000000000000000000000000000000000000000c0);
        assertEq(msizeAfter, 0x0000000000000000000000000000000000000000000000000000000000000120);
    }

    function testFixedArray() public {
        (bytes32 pointerBefore, bytes32 pointerAfter) = mem.fixedArray();
        assertEq(pointerBefore, 0x0000000000000000000000000000000000000000000000000000000000000080);
        assertEq(pointerAfter, 0x00000000000000000000000000000000000000000000000000000000000000c0);
    }

    function testAbiEncode() public {
        (bytes32 memPointerBefore, bytes32 memPointerAfter) = mem.abiEncode();
        assertEq(memPointerBefore, 0x0000000000000000000000000000000000000000000000000000000000000080);
        assertEq(memPointerAfter, 0x00000000000000000000000000000000000000000000000000000000000000e0);

        assertEq(uint256(memPointerAfter) - uint256(memPointerBefore), 96);
    }

    function testAbiEncodePacked() public {
        (bytes32 pointerBefore, bytes32 pointerAfter) = mem.abiEncodePacked();
        assertEq(pointerBefore, 0x0000000000000000000000000000000000000000000000000000000000000080);
        assertEq(pointerAfter, 0x00000000000000000000000000000000000000000000000000000000000000d0);
    }

    function testArgs() public {
        (bytes32 location, bytes32 index0, bytes32 index1, bytes32 index2, bytes32 index3) = mem.args([1, 2, 3, 4]);

        assertEq(location, 0x0000000000000000000000000000000000000000000000000000000000000080);
        assertEq(index0, 0x0000000000000000000000000000000000000000000000000000000000000001);
        assertEq(index1, 0x0000000000000000000000000000000000000000000000000000000000000002);
        assertEq(index2, 0x0000000000000000000000000000000000000000000000000000000000000003);
        assertEq(index3, 0x0000000000000000000000000000000000000000000000000000000000000004);
    }

    function testBreakFreeMemoryPointer() public {
        uint256 val = mem.breakFreeMemoryPointer([uint256(99)]);
        assertEq(val, 6);
    }

    function testUnpacked() public {
        (bytes32 pointer, bytes32 len, bytes32 index0, bytes32 index1, bytes32 index2) = mem.unpacked();

        assertEq(len, 0x0000000000000000000000000000000000000000000000000000000000000006);
        assertEq(index0, 0x0000000000000000000000000000000000000000000000000000000000000001);
        assertEq(index1, 0x0000000000000000000000000000000000000000000000000000000000000002);
        assertEq(index2, 0x0000000000000000000000000000000000000000000000000000000000000003);
        assertEq(pointer, 0x0000000000000000000000000000000000000000000000000000000000000160);
    }
}
