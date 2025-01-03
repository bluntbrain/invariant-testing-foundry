// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {HandlerStatefulFuzzCatches} from "../../../src/HandlerStatefulFuzzCatches.sol";
import {YeildERC20} from "../../mocks/YeildERC20.sol";
import {MockUSDC} from "../../mocks/MockUSDC.sol";

/// @title Handler Contract for Stateful Fuzzing Tests
/// @author Ishan Lakhwani
/// @notice Handles token operations for stateful fuzzing tests
/// @dev Used in conjunction with Invariant.t.sol for testing
contract Handler is Test {
    HandlerStatefulFuzzCatches handlerStatefulFuzzCatches;
    YeildERC20 yeildERC20;
    MockUSDC mockUSDC;
    address owner;

    /// @notice Initializes the handler with required contracts
    /// @param _handlerStatefulFuzzCatches Main contract to test
    /// @param _yeildERC20 YieldERC20 token instance
    /// @param _mockUSDC MockUSDC token instance
    constructor(HandlerStatefulFuzzCatches _handlerStatefulFuzzCatches, YeildERC20 _yeildERC20, MockUSDC _mockUSDC) {
        handlerStatefulFuzzCatches = _handlerStatefulFuzzCatches;
        yeildERC20 = _yeildERC20;
        mockUSDC = _mockUSDC;
        owner = yeildERC20.owner();
    }

    /// @notice Deposits YieldERC20 tokens
    /// @param _amount Amount to deposit (will be bounded)
    function depositYeildERC20(uint256 _amount) public {
        uint256 amount = bound(_amount, 0, yeildERC20.balanceOf(owner));
        vm.startPrank(owner);
        yeildERC20.approve(address(handlerStatefulFuzzCatches), amount);
        handlerStatefulFuzzCatches.depositToken(yeildERC20, amount);
        vm.stopPrank();
    }

    /// @notice Deposits MockUSDC tokens
    /// @param _amount Amount to deposit (will be bounded)
    function depositMockUSDC(uint256 _amount) public {
        uint256 amount = bound(_amount, 0, mockUSDC.balanceOf(owner));
        vm.startPrank(owner);
        mockUSDC.approve(address(handlerStatefulFuzzCatches), amount);
        handlerStatefulFuzzCatches.depositToken(mockUSDC, amount);
        vm.stopPrank();
    }

    /// @notice Withdraws YieldERC20 tokens
    function withdrawYeildERC20() public {
        vm.startPrank(owner);
        handlerStatefulFuzzCatches.withdrawToken(yeildERC20);
        vm.stopPrank();
    }

    /// @notice Withdraws MockUSDC tokens
    function withdrawMockUSDC() public {
        vm.startPrank(owner);
        handlerStatefulFuzzCatches.withdrawToken(mockUSDC);
        vm.stopPrank();
    }
}
