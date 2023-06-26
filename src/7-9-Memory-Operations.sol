// SPDX-License-Identifier: GLP-3.0
pragma solidity ^0.8.0;

/*
    Solidity uses memory for:
        1. `abi.encode` and `abi.encodePacked`
        2. Structs and arrays, nut you explicitly nee the memory keyword
        3. When strcuts or arrays are declared memory in function arguments
        4. Because objects in memory are laid out end to end, arrays have no push unlike storage 
    In yul
        1. The variable itself is where it begins in memory
        2. To aceess a dynamic arrays, you have to add 32 bytes or 0x20 to skip the length
*/

contract Memory {
    struct Point {
        uint256 x;
        uint256 y;
    }

    event MemoryPointer(bytes32);
    event MemoryPointerMsize(bytes32, bytes32);

    function highAcess() external pure returns (uint ret) {
        assembly {
            ret := mload(0xffffffffffffffff)
        }
    }

    function mstore() external pure returns (bytes32 ret) {
        assembly {
            mstore(0x00, 7)
            ret := mload(0x00)
        }
    }

    function mstore8() external pure returns (bytes32 ret) {
        assembly {
            mstore8(0x00, 7)
            ret := mload(0x00)
        }
    }

    function memPointer()
        external
        returns (bytes32 x40before, bytes32 x40after)
    {
        assembly {
            x40before := mload(0x40)
        }
        emit MemoryPointer(x40before);
        // will occupy 64 bytes in memory
        Point memory p = Point({x: 1, y: 2});
        p;
        assembly {
            x40after := mload(0x40)
        }
        emit MemoryPointer(x40after);
    }

    function memPointerV2()
        external
        returns (
            bytes32 x40before,
            bytes32 msizeBefore,
            bytes32 x40after,
            bytes32 msizeAfter
        )
    {
        assembly {
            x40before := mload(0x40)
            msizeBefore := msize()
        }
        emit MemoryPointerMsize(x40before, msizeBefore);
        Point memory p = Point({x: 1, y: 2});
        p;
        assembly {
            // access memory in a far location
            pop(mload(0xff))
            x40after := mload(0x40)
            msizeAfter := msize()
        }
        emit MemoryPointerMsize(x40after, msizeAfter);
    }

    function fixedArray()
        external
        pure
        returns (bytes32 x40Before, bytes32 x40After)
    {
        assembly {
            x40Before := mload(0x40)
        }
        uint256[2] memory arr = [uint256(5), uint256(6)];
        arr;
        assembly {
            x40After := mload(0x40)
        }
    }

    function abiEncode()
        external
        returns (bytes32 x40Before, bytes32 x40After)
    {
        assembly {
            x40Before := mload(0x40)
        }

        emit MemoryPointer(x40Before);
        // abi.encode puts length, 5 and 19 in memory
        bytes memory x = abi.encode(uint256(5), uint128(19));
        x;
        assembly {
            x40After := mload(0x40)
        }
        emit MemoryPointer(x40After);
    }

    function abiEncodePacked()
        external
        returns (bytes32 x40Before, bytes32 x40After)
    {
        assembly {
            x40Before := mload(0x40)
        }
        emit MemoryPointer(x40Before);
        // tries to make bytes shorteoccupy less bytes in memory
        bytes memory x = abi.encodePacked(uint256(5), uint128(19));
        x;
        assembly {
            x40After := mload(0x40)
        }
        emit MemoryPointer(x40After);
    }

    event Debug(bytes32, bytes32, bytes32, bytes32);

    function args(
        uint8[4] memory arr
    )
        external
        pure
        returns (
            bytes32 location,
            bytes32 index0,
            bytes32 index1,
            bytes32 index2,
            bytes32 index3
        )
    {
        assembly {
            location := arr
            index0 := mload(location)
            index1 := mload(add(arr, 0x20))
            index2 := mload(add(arr, 0x40))
            index3 := mload(add(arr, 0x60))
        }
        // emit Debug(location, len, valueAtIndex0, valueAtIndex1);
    }

    function breakFreeMemoryPointer(
        uint256[1] memory val
    ) external pure returns (uint256) {
        assembly {
            mstore(0x40, 0x80)
        }

        uint256[1] memory bar = [uint256(6)];
        bar;
        return val[0];
    }

    uint8[] foo = [1, 2, 3, 4, 5, 6];

    function unpacked()
        external
        view
        returns (
            bytes32 pointer,
            bytes32 len,
            bytes32 index0,
            bytes32 index1,
            bytes32 index2
        )
    {
        bytes32 ptr;
        assembly {
            ptr := mload(0x40)
        }
        uint8[] memory bar = foo;
        bar;

        assembly {
            len := mload(ptr)
            index0 := mload(add(ptr, 0x20))
            index1 := mload(add(ptr, 0x40))
            index2 := mload(add(ptr, 0x60))
            pointer := mload(0x40)
        }
    }
}
