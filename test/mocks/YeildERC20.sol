// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Yield ERC20 Token Contract with Fee Mechanism
/// @author Ishan Lakhwani
/// @notice An ERC20 token that implements a fee mechanism every 10 transactions
/// @dev Inherits from OpenZeppelin's ERC20 implementation
contract YeildERC20 is ERC20 {
    /// @notice Initial supply of tokens
    uint256 public constant INITIAL_SUPPLY = 1_000_000e18;

    /// @notice Address of contract owner who receives fees
    address public immutable owner;

    /// @notice Counter for tracking number of transactions
    uint256 public count = 0;

    /// @notice Fee percentage taken (10%)
    uint256 public constant FEE = 10;

    /// @notice Amount that goes to user (90%)
    uint256 public constant USER_AMOUNT = 90;

    /// @notice Precision factor for percentage calculations
    uint256 public constant PRECISION = 100;

    /// @notice Initializes the token with initial supply
    /// @dev Mints initial supply to deployer
    constructor() ERC20("MockYeildERC20", "MYEILD") {
        owner = msg.sender;
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /// @notice Override of ERC20 _update to implement fee mechanism
    /// @dev Takes 10% fee every 10 transactions
    /// @param from Address tokens are transferred from
    /// @param to Address tokens are transferred to
    /// @param value Amount of tokens being transferred
    function _update(address from, address to, uint256 value) internal virtual override {
        if (to == owner) {
            super._update(from, to, value);
        } else if (count >= 10) {
            uint256 userAmount = value * USER_AMOUNT / PRECISION;
            uint256 ownerAmount = value * FEE / PRECISION;
            count = 0;
            super._update(from, to, userAmount);
            super._update(from, owner, ownerAmount);
        } else {
            count++;
            super._update(from, to, value);
        }
    }
}
