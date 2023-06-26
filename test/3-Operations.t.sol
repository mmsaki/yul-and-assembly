// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "../src/3-Operations.sol";

contract OperationsTest is Test {
    IfComparison public comparison;

    function setUp() public {
        comparison = new IfComparison();
    }

    function testIsTruthy() public {
        assertEq(comparison.isTruthy(), 1);
    }

    function testIsFalsy() public {
        assertEq(comparison.isFalsy(), 1);
    }

    function testNegation() public {
        assertEq(comparison.negation(), 2);
    }

    function testBitFlip() public {
        assertEq(comparison.bitFlip(), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd);
    }

    function testSafeNegation() public {
        assertEq(comparison.safeNegation(), 1);
    }

    function testUnsafeNegation() public {
        assertEq(comparison.unsafeNegation(), 2);
    }

    function testMax() public {
        assertEq(comparison.max(32, 20), 32);
    }
}
