// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/// @title Stateless Fuzz Testing Example Contract
/// @author Ishan Lakhwani
/// @notice A simple contract to demonstrate stateless fuzzing
/// @dev Contains a function that should never return 0 (invariant)
contract StatelessFuzzCatches {
    /// @notice Performs a mathematical operation that should never return 0
    /// @param myNumber Input number for calculation
    /// @return uint256 Result of the calculation
    /// @dev Contains a deliberate violation of the invariant when myNumber == 2
    function doMath(uint128 myNumber) public pure returns (uint256) {
        if (myNumber == 2) {
            return 0;
        }
        return 1;
    }
}
