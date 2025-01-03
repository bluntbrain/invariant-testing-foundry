# Smart Contract Testing Examples
> A comprehensive guide to Foundry's testing capabilities including Fuzz Testing and Invariant Testing

## Overview
This repository demonstrates different testing methodologies in Foundry, focusing on:
- Fuzz Testing
- Invariant Testing
- Stateless vs Stateful Testing
- Handler-based Testing

## Test Structure

### 1. Mock Contracts
- `MockUSDC.sol`: Basic ERC20 implementation for testing
- `MockWETH.sol`: WETH implementation with deposit/withdraw
- `YieldERC20.sol`: ERC20 with fee mechanism (10% fee every 10 transactions)

### 2. Testing Approaches

#### A. Fuzz Testing
- Automatically generates random inputs
- Tests function behavior across many scenarios
- Example: `testInvariantBreakHard(uint256 randomAmount)`
```solidity
function testInvariantBreakHard(uint256 randomAmount) public {
    vm.assume(randomAmount < startingAmount);
    // Test deposit/withdraw cycles
}
```

#### B. Invariant Testing
Two main approaches:

1. **Stateless Testing**
- Tests individual function calls
- No state maintained between calls
- Limited in catching complex bugs
```solidity
// Example in StatelessFuzzCatchesTest.t.sol
```

2. **Stateful Testing**
- Maintains state between function calls
- Tests sequences of operations
- Better at finding complex bugs
```solidity
// Example in StatefulFuzzCatchesTest.t.sol
```

#### C. Handler Pattern
Located in `test/invariant/HandlerStatefulFuzz/`

1. **Handler Contract**
- Controls test flow
- Bounds input values
- Manages function sequences
```solidity
function depositYeildERC20(uint256 _amount) public {
    uint256 amount = bound(_amount, 0, yeildERC20.balanceOf(owner));
    // ... deposit logic
}
```

2. **Invariant Tests with Handler**
```solidity
contract InvariantBreakHardTest {
    function setUp() public {
        // Setup handler and target selectors
        targetSelector(FuzzSelector({
            addr: address(handler),
            selectors: selectors
        }));
    }
}
```

## Key Features

### Invariant Properties Tested
- Token balances after operations
- Ownership consistency
- Fee mechanism correctness

### Test Coverage
- Deposit/Withdraw cycles
- Fee calculations
- Balance tracking
- Owner operations

## Running Tests

```bash
# Run all tests
forge test

# Run specific test file
forge test --match-path test/invariant/HandlerStatefulFuzz/Invariant.t.sol

# Run with verbosity
forge test -vvv
```

## Key Learnings
1. Simple fuzz testing may miss complex bugs
2. Stateful testing with handlers provides better coverage
3. Invariant testing helps verify persistent properties
4. Handlers help control test flow and bound inputs

## Project Structure
```
├── src/
│   └── HandlerStatefulFuzzCatches.sol
├── test/
│   ├── mocks/
│   │   ├── MockUSDC.sol
│   │   ├── MockWETH.sol
│   │   └── YeildERC20.sol
│   └── invariant/
│       └── HandlerStatefulFuzz/
│           ├── Handler.t.sol
│           ├── Invariant.t.sol
│           └── InvariantFail.t.sol
```

## Dependencies
- Foundry
- OpenZeppelin Contracts
