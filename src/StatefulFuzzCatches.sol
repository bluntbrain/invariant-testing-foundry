// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/// @title Stateful Fuzz Testing Example Contract
/// @author Ishan Lakhwani
/// @notice A contract to demonstrate stateful fuzzing with stored values
/// @dev Contains functions that maintain state and should never return 0
contract StatefulFuzzCatches {
    /// @notice Stored value that affects calculations
    uint256 public myValue = 1;
    /// @notice Additional stored value used in calculations
    uint256 public storedValue = 100;

    /// @notice Performs mathematical operations using state and input
    /// @param myNumber Input number for calculation
    /// @return uint256 Result of the calculation
    /// @dev Should never return 0 (contract invariant)
    function doMoreMathAgain(uint128 myNumber) public returns (uint256) {
        uint256 response = (uint256(myNumber) / 1) + myValue;
        storedValue = response;
        return response;
    }

    /// @notice Updates the stored myValue
    /// @param newValue New value to store
    function changeValue(uint256 newValue) public {
        myValue = newValue;
    }
}
