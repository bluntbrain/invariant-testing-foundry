// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/// @title ERC20 Token Vault Handler
/// @author Ishan Lakhwani
/// @notice A vault contract that handles deposits and withdrawals of ERC20 tokens
/// @dev Implements basic vault functionality with support for multiple ERC20 tokens
contract HandlerStatefulFuzzCatches {
    error HandlerStatefulFuzzCatches__UnsupportedToken();

    using SafeERC20 for IERC20;

    /// @notice Mapping to track supported tokens
    mapping(IERC20 => bool) public tokenIsSupported;
    /// @notice Mapping to track user balances for each token
    mapping(address user => mapping(IERC20 token => uint256 balance)) public tokenBalances;

    /// @notice Ensures the token is supported by the vault
    /// @param token The ERC20 token address to check
    modifier requireSupportedToken(IERC20 token) {
        if (!tokenIsSupported[token]) revert HandlerStatefulFuzzCatches__UnsupportedToken();
        _;
    }

    /// @notice Initializes the vault with supported tokens
    /// @param _supportedTokens Array of ERC20 token addresses to support
    constructor(IERC20[] memory _supportedTokens) {
        for (uint256 i; i < _supportedTokens.length; i++) {
            tokenIsSupported[_supportedTokens[i]] = true;
        }
    }

    /// @notice Deposits tokens into the vault
    /// @param token The ERC20 token to deposit
    /// @param amount The amount of tokens to deposit
    function depositToken(IERC20 token, uint256 amount) external requireSupportedToken(token) {
        tokenBalances[msg.sender][token] += amount;
        token.safeTransferFrom(msg.sender, address(this), amount);
    }

    /// @notice Withdraws all tokens of a specific type from the vault
    /// @param token The ERC20 token to withdraw
    function withdrawToken(IERC20 token) external requireSupportedToken(token) {
        uint256 currentBalance = tokenBalances[msg.sender][token];
        tokenBalances[msg.sender][token] = 0;
        token.safeTransfer(msg.sender, currentBalance);
    }
}
