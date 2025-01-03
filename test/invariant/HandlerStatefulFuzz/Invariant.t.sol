// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {HandlerStatefulFuzzCatches} from "../../../src/HandlerStatefulFuzzCatches.sol";
import {YeildERC20} from "../../mocks/YeildERC20.sol";
import {MockUSDC} from "../../mocks/MockUSDC.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Handler} from "./Handler.t.sol";

/// @title Invariant Break Hard Test Contract
/// @author Ishan Lakhwani
/// @notice Tests invariants using stateful fuzzing with a handler
/// @dev Uses foundry's StdInvariant and a custom Handler contract
contract InvariantBreakHardTest is StdInvariant, Test {
    HandlerStatefulFuzzCatches handlerStatefulFuzzCatches;
    YeildERC20 yeildERC20;
    MockUSDC mockUSDC;
    IERC20[] public supportedTokens;
    uint256 public startingAmount;

    address owner = makeAddr("owner");

    Handler handler;

    /// @notice Sets up the test environment with handler
    /// @dev Initializes tokens, contracts and handler for testing
    function setUp() public {
        vm.startPrank(owner);
        // Give our owner 1M tokens each
        yeildERC20 = new YeildERC20();
        startingAmount = yeildERC20.INITIAL_SUPPLY();
        mockUSDC = new MockUSDC();
        mockUSDC.mint(owner, startingAmount);

        supportedTokens.push(mockUSDC);
        supportedTokens.push(yeildERC20);
        handlerStatefulFuzzCatches = new HandlerStatefulFuzzCatches(supportedTokens);
        vm.stopPrank();

        handler = new Handler(handlerStatefulFuzzCatches, yeildERC20, mockUSDC);

        bytes4[] memory selectors = new bytes4[](3);
        selectors[0] = handler.depositYeildERC20.selector;
        selectors[1] = handler.withdrawYeildERC20.selector;
        selectors[2] = handler.withdrawMockUSDC.selector;

        targetSelector(FuzzSelector({addr: address(handler), selectors: selectors}));
        targetContract(address(handler));
    }

    /// @notice Tests invariants that should hold after any sequence of operations
    /// @dev Verifies token balances and ownership after withdrawals
    function statefulFuzz_testInvariantBreakHandler() public {
        vm.startPrank(owner);
        handlerStatefulFuzzCatches.withdrawToken(mockUSDC);
        handlerStatefulFuzzCatches.withdrawToken(yeildERC20);
        vm.stopPrank();

        assert(mockUSDC.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
        assert(yeildERC20.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
        assert(mockUSDC.balanceOf(owner) == startingAmount);
        assert(yeildERC20.balanceOf(owner) == startingAmount);
    }
}
