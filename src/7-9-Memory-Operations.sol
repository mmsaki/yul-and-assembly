// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.17;

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
        pure
        returns (bytes32 x40before, bytes32 x40after)
    {
        assembly {
            x40before := mload(0x40)
        }

        Point memory p = Point({x: 1, y: 2});
        p;
        assembly {
            x40after := mload(0x40)
        }
    }
}
