// SPDX-License-Identifier: GLP-3.0
pragma solidity ^0.8.0;

contract OtherContract {
    // "0x0c55699c": "x()"
    uint256 public x;

    // "0x71e5ee5e": "arr(uint256)"
    uint256[] public arr;

    function get21() external pure returns (uint256) {
        return 21;
    }

    function revertWith999() external pure returns (uint256) {
        assembly {
            mstore(0x00, 999)
            revert(0x00, 0x20)
        }
    }

    function multiply(uint128 _x, uint16 _y) external pure returns (uint256) {
        return _x * _y;
    }

    function setX(uint256 _x) external {
        x = _x;
    }

    function dynamicLength(uint256[] calldata data) external {
        arr = data;
    }

    function returnVaribaleLength(uint256 len) external pure returns (bytes memory) {
        bytes memory ret = new bytes(len);
        for (uint256 i = 0; i < ret.length; i++) {
            ret[i] = 0xab;
        }
        return ret;
    }
}

contract Contract {
    function returnViaStaticacall(address _a) external view returns (uint256) {
        assembly {
            // 0x9a884bde == function selector for "get21()"
            mstore(0x00, 0x9a884bde)
            // 000000000000000000000000000000000000000000000000000000009a884bde
            //                                                         |      |
            //                                                         28     32
            let success := staticcall(gas(), _a, 28, 32, 0x00, 0x20)

            if iszero(success) { revert(0, 0) }
            return(0x00, 0x20)
        }
    }

    function returnViaRevert(address _a) external view returns (uint256) {
        assembly {
            // 0x73712595 is funtion selector for "revertWith999()"
            mstore(0x00, 0x73712595)
            pop(staticcall(gas(), _a, 28, 32, 0x00, 0x20))
            return(0x00, 0x20)
        }
    }

    function callMultiply(address _a) external view returns (uint256 result) {
        assembly {
            let mptr := mload(0x40)
            let odlMptr := mptr
            mstore(mptr, 0x196e6d84)
            mstore(add(mptr, 0x20), 3)
            mstore(add(mptr, 0x40), 11)
            mstore(0x40, add(mptr, 0x60)) // update mempry pointer `3 x 32` = 0x60
            let success := staticcall(gas(), _a, add(odlMptr, 28), mload(0x40), 0x00, 0x20)
            if iszero(success) { revert(0, 0) }

            result := mload(0x00)
        }
    }

    function returnStateChangingCall(address _a) public {
        assembly {
            // 0x4018d9aa is signature for "setX()"
            mstore(0x00, 0x4018d9aa)
            mstore(0x20, 999)
            let success := call(gas(), _a, callvalue(), 28, add(28, 32), 0x00, 0x00)

            if iszero(success) { revert(0, 0) }
        }
    }

    function returnUnknownSize(address _a, uint256 amount) external view returns (bytes memory) {
        assembly {
            // 0xb0a3f202 is signature for "returnVaribaleLength(uint256)"
            mstore(0x00, 0xd3ef80d2)
            mstore(0x20, amount)

            let success := staticcall(gas(), _a, 28, add(28, 32), 0x00, 0x00)
            if iszero(success) { revert(0, 0) }

            returndatacopy(0, 0, returndatasize())
            return(0, returndatasize())
        }
    }
}
