// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Mock Wrapped Ether (WETH) Token Contract
/// @author Ishan Lakhwani
/// @notice A mock implementation of WETH token for testing purposes
/// @dev Inherits from OpenZeppelin's ERC20 implementation
contract MockWETH is ERC20 {
    /// @notice Initializes the mock WETH token
    /// @dev Sets name as "MockWETH" and symbol as "MWETH"
    constructor() ERC20("MockWETH", "MWETH") {}

    /// @notice Mints tokens to a specified address
    /// @dev Only for testing purposes
    /// @param to Address to mint tokens to
    /// @param amount Amount of tokens to mint
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    /// @notice Deposits ETH and mints equivalent WETH tokens
    /// @dev Mints WETH tokens equal to the ETH sent
    function deposit() external payable {
        _mint(msg.sender, msg.value);
    }

    /// @notice Withdraws ETH by burning WETH tokens
    /// @dev Burns WETH tokens and sends equivalent ETH
    /// @param amount Amount of WETH to burn and ETH to withdraw
    function withdraw(uint256 amount) external {
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
    }
}
