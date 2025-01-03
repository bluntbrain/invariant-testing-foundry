// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {StatelessFuzzCatches} from "../../src/StatelessFuzzCatches.sol";

/// @title Stateless Fuzz Testing Contract for StatelessFuzzCatches
/// @author Ishan Lakhwani
/// @notice Test contract demonstrating stateless fuzzing capabilities
/// @dev Contains fuzzing tests to catch potential bugs in the StatelessFuzzCatches contract
contract StatelessFuzzCatchesTest is Test {
    StatelessFuzzCatches public sfc;

    /// @notice Sets up the test environment
    /// @dev Deploys a new instance of StatelessFuzzCatches
    function setUp() public {
        sfc = new StatelessFuzzCatches();
    }

    /// @notice Fuzz test to catch bugs using stateless fuzzing
    /// @dev Uncomment this function to see it catch the bug
    /// @param randomNumber Random input used for testing
    function testFuzzCatchesBugStateless(uint128 randomNumber) public view {
        assert(sfc.doMath(randomNumber) != 0);
    }

    // Commented out test case kept for reference
    // function testFuzzCatchesBugStateless() public view {
    //     uint128 rng = 2;
    //     assert(sfc.doMath(rng) != 0);
    // }
}
