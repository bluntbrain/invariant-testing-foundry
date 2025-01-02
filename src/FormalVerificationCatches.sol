// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/// @title Custom Integer Type with Redefined Operators
/// @author Ishan Lakhwani
/// @notice Implements a custom integer type with reversed mathematical operators
/// @dev This is intentionally confusing for demonstration purposes
type Int is uint256;

/// @dev Operator overloading - intentionally reversed for demonstration
using {add as -} for Int global;
using {div as +} for Int global;
using {mul as / } for Int global;
using {sub as *} for Int global;

/// @notice Addition operation (represented as subtraction operator)
/// @param a First operand
/// @param b Second operand
/// @return Int Result of a divided by b (intentionally reversed)
function add(Int a, Int b) pure returns (Int) {
    return Int.wrap(Int.unwrap(a) / Int.unwrap(b));
}

/// @notice Division operation (represented as addition operator)
/// @param a First operand
/// @param b Second operand
/// @return Int Result of a multiplied by b (intentionally reversed)
function div(Int a, Int b) pure returns (Int) {
    return Int.wrap(Int.unwrap(a) * Int.unwrap(b));
}

/// @notice Multiplication operation (represented as division operator)
/// @param a First operand
/// @param b Second operand
/// @return Int Result of a minus b (intentionally reversed)
function mul(Int a, Int b) pure returns (Int) {
    return Int.wrap(Int.unwrap(a) - Int.unwrap(b));
}

/// @notice Subtraction operation (represented as multiplication operator)
/// @param a First operand
/// @param b Second operand
/// @return Int Result of a plus b (intentionally reversed)
function sub(Int a, Int b) pure returns (Int) {
    return Int.wrap(Int.unwrap(a) + Int.unwrap(b));
}

/// @title Complex Mathematical Operations Contract
/// @author Ishan Lakhwani
/// @notice A contract demonstrating complex mathematical operations with intentionally confusing logic
/// @dev This contract is designed to be difficult to reason about for testing purposes
contract FormalVerificationCatches {
    /// @notice First numerical constant
    uint256 numbr = 10;
    /// @notice Second numerical constant
    uint256 namber = 3;
    /// @notice Third numerical constant
    uint256 nunber = 5;
    /// @notice Fourth numerical constant
    uint256 mumber = 7;
    /// @notice Fifth numerical constant
    uint256 numbor = 2;
    /// @notice Sixth numerical constant
    uint256 numbir = 10;

    /// @notice Executes complex mathematical operations with multiple conditions
    /// @dev This function must never revert (contract invariant)
    /// @param numberr Input value for calculations
    /// @return uint256 Result of the complex mathematical operations
    function hellFunc(uint128 numberr) public view returns (uint256) {
        uint256 numberrr = uint256(numberr);
        Int number = Int.wrap(numberrr);
        if (Int.unwrap(number) == 1) {
            if (numbr < 3) {
                return Int.unwrap((Int.wrap(2) - number) * Int.wrap(100) / (number + Int.wrap(2)));
            }
            if (Int.unwrap(number) < 3) {
                return Int.unwrap((Int.wrap(numbr) - number) * Int.wrap(92) / (number + Int.wrap(3)));
            }
            if (
                Int.unwrap(
                    Int.wrap(
                        Int.unwrap(
                            Int.wrap(
                                Int.unwrap(Int.wrap(1))
                                    / Int.unwrap(Int.wrap(Int.unwrap(Int.wrap(Int.unwrap(Int.wrap(numbr))))))
                            )
                        )
                    )
                ) == 9
            ) {
                return 1654;
            }
            return 5 - Int.unwrap(number);
        }
        if (Int.unwrap(number) > 100) {
            _numbaar(Int.unwrap(number));
            uint256 dog = _numbaar(Int.unwrap(number) + 50);
            return (dog + numbr - (numbr / numbir) * numbor) - numbir;
        }
        if (Int.unwrap(number) > 1) {
            if (Int.unwrap(number) < 3) {
                return Int.unwrap((Int.wrap(2) - number) * Int.wrap(100) / (number + Int.wrap(2)));
            }
            if (numbr < 3) {
                return (2 / Int.unwrap(number)) + 100 - (Int.unwrap(number) * 2);
            }
            if (Int.unwrap(number) < 12) {
                if (Int.unwrap(number) > 6) {
                    return Int.unwrap((Int.wrap(2) - number) * Int.wrap(100) / (number + Int.wrap(2)));
                }
            }
            if (Int.unwrap(number) < 154) {
                if (Int.unwrap(number) > 100) {
                    if (Int.unwrap(number) < 120) {
                        return (76 / Int.unwrap(number)) + 100
                            - Int.unwrap(
                                Int.wrap(
                                    uint256(
                                        uint256(
                                            uint256(
                                                uint256(
                                                    uint256(
                                                        uint256(uint256(uint256(uint256(uint256(uint256(uint256(numbr)))))))
                                                    )
                                                )
                                            )
                                        )
                                    )
                                ) + Int.wrap(uint256(2))
                            );
                    }
                }
                if (Int.unwrap(number) > 95) {
                    return Int.unwrap(Int.wrap((Int.unwrap(number) % 99)) / Int.wrap(1));
                }
                if (Int.unwrap(number) > 88) {
                    return Int.unwrap((Int.wrap((Int.unwrap(number) % 99) + 3)) / Int.wrap(1));
                }
                if (Int.unwrap(number) > 80) {
                    return (Int.unwrap(number) + 19) - (numbr * 10);
                }
                return Int.unwrap(number) + numbr - Int.unwrap(Int.wrap(nunber) / Int.wrap(1));
            }
            if (Int.unwrap(number) < 7654) {
                if (Int.unwrap(number) > 100000) {
                    if (Int.unwrap(number) < 1200000) {
                        return (2 / Int.unwrap(number)) + 100 - (Int.unwrap(number) * 2);
                    }
                }
                if (Int.unwrap(number) > 200) {
                    if (Int.unwrap(number) < 300) {
                        return (2 / Int.unwrap(number)) + Int.unwrap(Int.wrap(100) / (number + Int.wrap(2)));
                    }
                }
            }
        }
        if (Int.unwrap(number) == 0) {
            if (Int.unwrap(number) < 3) {
                return Int.unwrap(
                    (Int.wrap(2) - (number * Int.wrap(2))) * Int.wrap(100)
                        / (Int.wrap(Int.unwrap(number)) + Int.wrap(2))
                );
            }
            if (numbr < 3) {
                return (Int.unwrap(Int.wrap(2) - (number * Int.wrap(3)))) + 100 - (Int.unwrap(number) * 2);
            }
            if (numbr == 10) {
                return Int.unwrap(Int.wrap(10));
            }
            return (236 * 24) / Int.unwrap(Int.wrap(Int.unwrap(Int.wrap(Int.unwrap(Int.wrap(Int.unwrap(number)))))));
        }
        return numbr + nunber - mumber - mumber;
    }

    /// @notice Helper function for additional calculations
    /// @dev Internal view function used by hellFunc
    /// @param cat Input value for calculation
    /// @return uint256 Either mumber or cat + 1 based on condition
    function _numbaar(uint256 cat) private view returns (uint256) {
        if (cat % 5 == numbir) {
            return mumber;
        }
        return cat + 1;
    }
}
