- Player has the permission to withdraw, while deployer has the permission to sweep funds.
- Vault only allow withdraw 1 DVT in 15 days. This function seems can't be exploited
- Sweep funds allow to withdraw all fund to a designated receiver. So I can be sure that this is where I have to exploit. 
- This `sweepFunds` can only be called on its own -> call from `execute`
- But `player` only has the permission to withdraw, so i may need to somehow impersonate `deployer`.
- The function accepts an arbitrary calldata to call to, so this is exactly where I need to find the bug.
- The lines
```javascript
  uint256 calldataOffset = 4 + 32 * 3; // calldata position where `actionData` begins
        assembly {
            selector := calldataload(calldataOffset)
        }
```
looks sussy.
- The contract validates if msg.sender has the authority to call the function with the `selector` extracted from above. So I may need to somehow
  - Make the `actionData` to call the sweepFunds function.
  - But using the code above, it extracts the `withdraw` function selector instead of `sweepFunds` selector to bypass the check.

- Okay, now I need to research on how `calldataload` opcode works.
- Calldata layout `https://chatgpt.com/c/67fe2e6e-10d8-800d-b958-f925edcc9aa0`

    - First 4 byte: `execute` function selector
    - Next 32 byte: `target`
    - Next 32 byte: `offset` of actionData
    - Next 32 byte: `length` of actionData
    - Other: `actual calldata`
- So we need to somehow trick the next 32 byte (byte 100...) to have the function selector. So from byte 100, it is the selector of `withdraw`
- For this, we can manipulate the offset by shifting to next 32 byte. (so the real calldata) start from byte 132 (also with the length). And this is the call to `sweepFunds`
-> Problem solved.