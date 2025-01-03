// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Mock USDC Token Contract
/// @author Ishan Lakhwani
/// @notice A mock implementation of USDC token for testing purposes
/// @dev Inherits from OpenZeppelin's ERC20 implementation
contract MockUSDC is ERC20 {
    /// @notice Initializes the mock USDC token
    /// @dev Sets name as "MockUSDC" and symbol as "MUSDC"
    constructor() ERC20("MockUSDC", "MUSDC") {}

    /// @notice Mints tokens to a specified address
    /// @dev Only for testing purposes, not present in real USDC
    /// @param to Address to mint tokens to
    /// @param amount Amount of tokens to mint
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
