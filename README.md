# stack
Implementation of a basic in-memory stack in solidity.

The static sizing of the core array functions as the 'max length' of the stack. Not ideal for production purposes as-is without some optimization around the item size (set to uint256 in this example) and the max length (1024 in this example).

This implementation assumes you'd be using the `Using A for B` pattern in solidity for its use case.

```solidity
contract MyContract {
  using Stack for Stack1024;
  // ...
}
```
