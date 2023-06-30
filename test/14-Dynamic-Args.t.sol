// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/14-Dynamic-Args.sol";

contract DynamicLengthTest is Test {
    DynamicLength public dynamic;
    uint256[] vals;
    uint256[] vals2;
    uint256[] vals3;

    event ThreeArgs(
        bytes32 indexed a,
        bytes32 indexed b_loc,
        bytes32 indexed c,
        bytes32 b_len,
        bytes32 b0,
        bytes32 b1,
        bytes32 b2
    );

    event FiveArgs(
        bytes32 a,
        bytes32 indexed b_ptr,
        bytes32 b0,
        bytes32 b1,
        bytes32 c,
        bytes32 indexed d_ptr,
        bytes32 d0,
        bytes32 d1,
        bytes32 d2,
        bytes32 e
    );

    event AllDynamic(
        bytes32 indexed a_ptr,
        bytes32 indexed b_ptr,
        bytes32 indexed c_ptr
    );

    event OneArg(
        bytes32 indexed a_loc,
        bytes32 indexed a_len,
        bytes32 a0,
        bytes32 a1,
        bytes32 a2
    );

    function setUp() public {
        dynamic = new DynamicLength();
    }

    function testThreeArgs() public {
        vm.expectEmit(true, true, true, true);
        emit ThreeArgs(
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000060,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003
        );
        vals.push(uint(1));
        vals.push(uint(2));
        vals.push(uint(3));
        dynamic.threeArgs(7, vals, 9);
    }

    function testThreeArgsStruct() public {
        vm.expectEmit(true, true, true, true);
        emit ThreeArgs(
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000009,
            0x0000000000000000000000000000000000000000000000000000000000000000,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003
        );
        vals.push(uint(1));
        vals.push(uint(2));
        vals.push(uint(3));
        dynamic.threeArgsStruct(
            7,
            DynamicLength.Example(uint(1), uint(2), uint(3)),
            9
        );
    }

    function testFiveArgs() public {
        vm.expectEmit(true, true, true, true);
        emit FiveArgs(
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x00000000000000000000000000000000000000000000000000000000000000a0,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000004,
            0x0000000000000000000000000000000000000000000000000000000000000007,
            0x0000000000000000000000000000000000000000000000000000000000000100,
            0x000000000000000000000000000000000000000000000000000000000000000a,
            0x000000000000000000000000000000000000000000000000000000000000000b,
            0x000000000000000000000000000000000000000000000000000000000000000c,
            0x0000000000000000000000000000000000000000000000000000000000000009
        );

        vals.push(uint(2));
        vals.push(uint(4));

        vals2.push(uint(10));
        vals2.push(uint(11));
        vals2.push(uint(12));

        dynamic.fiveArgs(5, vals, 7, vals2, 9);
    }

    function testAllDynamic() public {
        vm.expectEmit(true, true, true, true);

        emit AllDynamic(
            0x0000000000000000000000000000000000000000000000000000000000000060,
            0x00000000000000000000000000000000000000000000000000000000000000c0,
            0x0000000000000000000000000000000000000000000000000000000000000140
        );

        vals.push(uint(1));
        vals.push(uint(2));

        vals2.push(uint(3));
        vals2.push(uint(4));
        vals2.push(uint(5));

        vals3.push(uint(6));
        vals3.push(uint(7));
        vals3.push(uint(8));
        vals3.push(uint(9));

        dynamic.allDynamic(vals, vals2, vals3);
    }

    function testOneArg() public {
        vals.push(uint(1));
        vals.push(uint(2));
        vals.push(uint(3));

        vm.expectEmit(true, true, true, true);
        emit OneArg(
            0x0000000000000000000000000000000000000000000000000000000000000020,
            0x0000000000000000000000000000000000000000000000000000000000000003,
            0x0000000000000000000000000000000000000000000000000000000000000001,
            0x0000000000000000000000000000000000000000000000000000000000000002,
            0x0000000000000000000000000000000000000000000000000000000000000003
        );

        dynamic.oneArg(vals);
    }
}
