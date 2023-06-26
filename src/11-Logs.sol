// SPDX-License-Identifier: GLP-3.0
pragma solidity ^0.8.0;

contract Logs {
    event SomeLog(uint256 indexed a, uint256 indexed b);
    event SomeLog2(uint256 indexed a, bool);

    function emitLog() external {
        emit SomeLog(5, 6);
    }

    function yulEmitLog() external {
        assembly {
            // keccak256("SomeLog(uint256,uint256)")
            let signature := 0xc200138117cf199dd335a2c6079a6e1be01e6592b6a76d4b5fc31b169df819cc
            log3(0, 0, signature, 5, 6)
        }
    }

    function v2EmitLog() external {
        emit SomeLog2(5, true);
    }

    function v2YulEmitLog() external {
        assembly {
            // keccak256("SomeLog2(uint256, bool)")
            let signature := 0xa72f59b60f75c1a1a855896cc4f844718bc1988949e23c1239446f3ab7118ebc
            mstore(0x00, 1)
            log2(0, 0x20, signature, 5)
        }
    }
}
