// SPDX-License-Identifier: GLP-3.0
pragma solidity ^0.8.0;

contract Logs {
    event SomeLog(uint256 indexed a, uint256 indexed b);
    event SomeLog2(uint256 indexed a, bytes32 boolean);

    function emitLog() external {
        emit SomeLog(5, 6);
    }

    function yulEmitLog() external {
        assembly {
            // keccak256("SomeLog(uint256,uint256)")
            let signature := 0xc2001381
            log3(0, 0, signature, 5, 6)
        }
    }

    function v2EmitLog() external {
        emit SomeLog2(
            5,
            0x0000000000000000000000000000000000000000000000000000000000000001
        );
    }

    function v2YulEmitLog() external {
        assembly {
            // keccak256("SomeLog2(uint256, bool)")
            let signature := 0xa72f59b6
            mstore(0x00, 1)
            log2(0, 0x20, signature, 5)
        }
    }
}
