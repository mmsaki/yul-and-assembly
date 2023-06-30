// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract DynamicLength {
    struct Example {
        uint256 a;
        uint256 b;
        uint256 c;
    }

    event ThreeArgs(
        bytes32 indexed a,
        bytes32 indexed b_loc,
        bytes32 indexed c,
        bytes32 b_len,
        bytes32 b0,
        bytes32 b1,
        bytes32 b2
    );

    function threeArgs(uint256 _a, uint256[] calldata _b, uint256 c_) external {
        bytes32 a;
        bytes32 b_loc;
        bytes32 c;
        bytes32 b_len;
        bytes32 b0;
        bytes32 b1;
        bytes32 b2;
        bytes4 selector;
        assembly {
            selector := calldataload(0x00)
            let offset := 0x04
            a := calldataload(add(offset, 0x00))
            b_loc := calldataload(add(offset, 0x20))
            c := calldataload(add(offset, 0x40))
            b_len := calldataload(add(offset, b_loc))
            b0 := calldataload(add(add(offset, b_loc), 0x20))
            b1 := calldataload(add(add(offset, b_loc), 0x40))
            b2 := calldataload(add(add(offset, b_loc), 0x60))
        }

        emit ThreeArgs(a, b_loc, c, b_len, b0, b1, b2);
    }

    function threeArgsStruct(
        uint256 a_,
        Example calldata b_,
        uint256 c_
    ) external {
        bytes32 a;
        bytes32 b0;
        bytes32 b1;
        bytes32 b2;
        bytes32 c;
        bytes4 selector;
        assembly {
            selector := calldataload(0x00)
            let offset := 0x04
            a := calldataload(add(offset, 0x00))
            b0 := calldataload(add(offset, 0x20))
            b1 := calldataload(add(offset, 0x40))
            b2 := calldataload(add(offset, 0x60))
            c := calldataload(add(offset, 0x80))
        }
        emit ThreeArgs(a, 0, c, 0, b0, b1, b2);
    }

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

    function fiveArgs(
        uint256 a_,
        uint256[] calldata b_,
        uint256 c_,
        uint256[] calldata d_,
        uint256 e_
    ) external {
        bytes32 a;
        bytes32 b_loc;
        bytes32 b0;
        bytes32 b1;
        bytes32 c;
        bytes32 d_loc;
        bytes32 d0;
        bytes32 d1;
        bytes32 d2;
        bytes32 e;

        assembly {
            let selector := calldataload(0x00)
            let offset := 0x04
            a := calldataload(add(offset, 0x00))
            b_loc := calldataload(add(offset, 0x20))
            let b_ptr := add(offset, b_loc)
            let b_len := calldataload(b_ptr)
            b0 := calldataload(add(b_ptr, 0x20))
            b1 := calldataload(add(b_ptr, 0x40))
            c := calldataload(add(offset, 0x40))
            d_loc := calldataload(add(offset, 0x60))
            let d_ptr := add(offset, d_loc)
            let d_len := calldataload(d_ptr)
            d0 := calldataload(add(d_ptr, 0x20))
            d1 := calldataload(add(d_ptr, 0x40))
            d2 := calldataload(add(d_ptr, 0x60))
            e := calldataload(add(offset, 0x80))
        }

        emit FiveArgs(a, b_loc, b0, b1, c, d_loc, d0, d1, d2, e);
    }

    event OneArg(
        bytes32 indexed a_loc,
        bytes32 indexed a_len,
        bytes32 a0,
        bytes32 a1,
        bytes32 a2
    );

    function oneArg(uint256[] calldata a) external {
        bytes32 a_loc;
        bytes32 a_len;
        bytes32 a0;
        bytes32 a1;
        bytes32 a2;
        assembly {
            let offset := 0x04
            a_loc := calldataload(offset)
            let pointer := add(offset, a_loc)
            a_len := calldataload(pointer)
            a0 := calldataload(add(pointer, 0x20))
            a1 := calldataload(add(pointer, 0x40))
            a2 := calldataload(add(pointer, 0x60))
        }

        emit OneArg(a_loc, a_len, a0, a1, a2);
    }

    function allDynamic(
        uint256[] calldata a,
        uint256[] calldata b,
        uint256[] calldata c
    ) external {}
}
