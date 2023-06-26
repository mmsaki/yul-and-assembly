// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/12-Calldata.sol";

contract CalldataTest is Test {
    Contract public c;
    OtherContract public oc;

    function setUp() public {
        c = new Contract();
        oc = new OtherContract();
    }

    function testExternalViewCallNoArgs() public {
        uint256 val = c.returnViaStaticacall(address(oc));
        assertEq(val, 21);
    }

    function testReturnViaRevert() public {
        uint256 val = c.returnViaRevert(address(oc));
        assertEq(val, 999);
    }

    function testCallMultiply() public {
        uint256 val = c.callMultiply(address(oc));
        assertEq(val, 33);
    }

    function testReturnStateChangingCall() public {
        c.returnStateChangingCall(address(oc));
        uint256 val = oc.x();
        assertEq(val, 999);
    }

    function testReturnUnknownSize() public {
        bytes memory len1 = c.returnUnknownSize(address(oc), 1);
        bytes memory len2 = c.returnUnknownSize(address(oc), 2);
        bytes memory len3 = c.returnUnknownSize(address(oc), 3);
        bytes memory len4 = c.returnUnknownSize(address(oc), 4);

        assertEq(len1, hex"ab");
        assertEq(len2, hex"abab");
        assertEq(len3, hex"ababab");
        assertEq(len4, hex"abababab");
    }
}
