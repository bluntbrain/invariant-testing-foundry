// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {HandlerStatefulFuzzCatches} from "../../../src/HandlerStatefulFuzzCatches.sol";
import {YeildERC20} from "../../mocks/YeildERC20.sol";
import {MockUSDC} from "../../mocks/MockUSDC.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Invariant Test Contract for Failed Test Cases
/// @author Ishan Lakhwani
/// @notice Contains invariant tests that demonstrate failed test scenarios
/// @dev Uses foundry's StdInvariant for testing
contract Invariant is StdInvariant, Test {
    HandlerStatefulFuzzCatches handlerStatefulFuzzCatches;
    YeildERC20 yeildERC20;
    MockUSDC mockUSDC;
    IERC20[] public supportedTokens;
    uint256 public startingAmount;

    address owner = makeAddr("owner");

    /// @notice Sets up the test environment
    /// @dev Initializes tokens and contracts for testing
    function setUp() public {
        vm.startPrank(owner);
        // Give our user 1M tokens each
        yeildERC20 = new YeildERC20();
        startingAmount = yeildERC20.INITIAL_SUPPLY();
        mockUSDC = new MockUSDC();
        mockUSDC.mint(owner, startingAmount);

        supportedTokens.push(mockUSDC);
        supportedTokens.push(yeildERC20);
        handlerStatefulFuzzCatches = new HandlerStatefulFuzzCatches(supportedTokens);
        vm.stopPrank();

        targetContract(address(handlerStatefulFuzzCatches));
    }

    /// @notice Test function that demonstrates a failing invariant
    /// @dev This test shows limitations of simple fuzzing
    /// @param randomAmount Amount to use in test (bounded by startingAmount)
    function testInvariantBreakHard(uint256 randomAmount) public {
        vm.assume(randomAmount < startingAmount);
        vm.startPrank(owner);
        // Deposit some yeildERC20
        yeildERC20.approve(address(handlerStatefulFuzzCatches), randomAmount);
        handlerStatefulFuzzCatches.depositToken(yeildERC20, randomAmount);
        // Withdraw some yeildERC20
        handlerStatefulFuzzCatches.withdrawToken(yeildERC20);
        // Deposit some mockUSDC
        mockUSDC.approve(address(handlerStatefulFuzzCatches), randomAmount);
        handlerStatefulFuzzCatches.depositToken(mockUSDC, randomAmount);
        // Withdraw some mockUSDC
        handlerStatefulFuzzCatches.withdrawToken(mockUSDC);
        vm.stopPrank();

        assert(mockUSDC.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
        assert(yeildERC20.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
        assert(mockUSDC.balanceOf(owner) == startingAmount);
        assert(yeildERC20.balanceOf(owner) == startingAmount);
    }
}
