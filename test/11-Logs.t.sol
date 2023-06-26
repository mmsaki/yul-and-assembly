// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/11-Logs.sol";

contract LogsTest is Test {
    Logs public lg;

    event SomeLog(uint256 indexed a, uint256 indexed b);
    event SomeLog2(uint256 indexed a, bool);

    function setUp() public {
        lg = new Logs();
    }

    function testEmitLog() public {
        vm.expectEmit(true, true, true, true);
        emit SomeLog(
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006
        );
        lg.emitLog();
    }

    function testYulEmitLog() public {
        vm.expectEmit(true, true, true, true);
        emit SomeLog(
            0x0000000000000000000000000000000000000000000000000000000000000005,
            0x0000000000000000000000000000000000000000000000000000000000000006
        );
        lg.yulEmitLog();
    }

    function testV2EmitLog() public {
        vm.expectEmit(true, true, true, true);
        emit SomeLog2(
            0x0000000000000000000000000000000000000000000000000000000000000005,
            true
        );
        lg.v2EmitLog();
    }

    // TODO: Why does this revert?
    // function testV2YulEmitLog() public {
    //     vm.expectEmit(true, true, true, true);
    //     emit SomeLog2(
    //         0x0000000000000000000000000000000000000000000000000000000000000005,
    //         true
    //     );
    //     lg.v2YulEmitLog();
    // }
}
