// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {StatefulFuzzCatches} from "../../src/StatefulFuzzCatches.sol";

/// @title Stateful Fuzz Testing Contract for StatefulFuzzCatches
/// @author Ishan Lakhwani
/// @notice Test contract demonstrating stateful fuzzing capabilities
/// @dev Contains both stateless and stateful fuzzing test cases
contract StatefulFuzzCatchesTest is StdInvariant, Test {
    StatefulFuzzCatches public sfc;

    /// @notice Sets up the test environment
    /// @dev Deploys StatefulFuzzCatches contract and sets it as the target for invariant testing
    function setUp() public {
        sfc = new StatefulFuzzCatches();
        targetContract(address(sfc));
    }

    // /// @notice Stateless fuzz test that checks if stored value is non-zero
    // /// @dev This test is expected to pass as it's stateless
    // /// @param randomNumber Random input for testing
    // function testFuzzPassesEasyInvariant(uint128 randomNumber) public {
    //     sfc.doMoreMathAgain(randomNumber);
    //     assert(sfc.storedValue() != 0);
    // }

    /// @notice Stateful fuzz test to verify stored value is never zero
    /// @dev Uncomment this function to see it catch the invariant violation
    function statefulFuzz_testMathDoesntReturnZero() public view {
        assert(sfc.storedValue() != 0);
    }
}
