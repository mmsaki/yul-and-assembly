// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/10-Return.sol";

contract ReturnTest is Test {
    Return public ret;

    function setUp() public {
        ret = new Return();
    }

    function testReturnTuple() public {
        (uint256 val0, uint256 val1) = ret.returnTuple();
        assertEq(val0, 2);
        assertEq(val1, 4);
    }

    function testRequireV1() public {
        vm.expectRevert();
        ret.requireV1();
    }

    function testRequireV2() public {
        vm.expectRevert();
        ret.requireV2();
    }

    function testHashV1() public {
        bytes32 hash = ret.hashv1();
        assertEq(hash, 0x6e0c627900b24bd432fe7b1f713f1b0744091a646a9fe4a65a18dfed21f2949c);
    }

    function testHashV2() public {
        bytes32 hash = ret.hashV2();
        assertEq(hash, 0x6e0c627900b24bd432fe7b1f713f1b0744091a646a9fe4a65a18dfed21f2949c);
    }
}
