// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

// 1 item is 32 bytes. A full point stack has 1024 elements in it. This will consume approx. 32768 bytes of memory.
struct Stack1024 {
    uint256[1024] items;
    uint256 length;
}

/**
 * @title Stack
 * @notice A stack is normally a dynamically-sized array that can be used to store items in a FIFO manner.
 * However, the EVM does not support dynamically-sized arrays in memory, so this stack is implemented with a
 * fixed-size array based on the maximum.
 * 
 * @dev To change the maximum size of the stack, simply change the static size under Stack1024.
 *
 * It's also worth optimizing by changing the item size (uint256 may be excessively large for your use-case).
 */
library Stack {
    function push(Stack1024 memory self, uint256 x) internal pure {
        require(self.length < self.items.length, "Stack overflow");
        self.items[self.length] = x;
        unchecked {
            self.length++;
        }
    }

    function pop(Stack1024 memory self) internal pure returns (uint256) {
        require(self.length > 0, "Stack underflow");
        unchecked {
            self.length--;
        }
        return self.items[self.length];
    }

    function contains(Stack1024 memory self, uint256 x) internal pure returns (bool) {
        // Optimized: this won't necessarily traverse all 1024 elements (including placeholders) in the worst case
        // (item is not being present) - only up until stack length.
        for (uint8 i = 0; i < self.length;) {
            if (self.items[i] == x) {
                return true;
            }

            unchecked {
                i++;
            }
        }
        return false;
    }
}