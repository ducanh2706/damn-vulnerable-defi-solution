- Have grinded Proxy https://www.rareskills.io/proxy-patterns for 3 hours.
- Sweep funds again? Seem like I will also need to use this function.
```

        for (uint8 i = 0; i < targets.length; ++i) {
            targets[i].functionCallWithValue(dataElements[i], values[i]);
        }

        if (getOperationState(id) != OperationState.ReadyForExecution) {
            revert NotReadyForExecution(id);
        }

        operations[id].executed = true;
```
This is `ClimberTimeLock` didn't follow CEI. maybe i need somehow to make the operation state be readyForExecution first.
- TimeRole is the admin of itself. seems sussy. I can grant myself (player) with a role proposer easily, then schedule
- Also update the maxDelay.
- Okay flow is:
  - Update max delay first (to zero)
  - Grant player as proposer.
- Hmm, but schedule only allow proposer role. Let's set timeLock is proposer on its own.
- Now lets schedule.
    -> 3 call.
- After this, player will have proposer & also admin role?
- Now player has proposer role, i can change the implementation of the contract, that allows sweepFund can be called by owner. Now let's implement
- Seems hard i think, cause i can't call schedule because i didn't know the last call to it.
- Maybe i need to calculate the salt that makes it equal (off-chain).
- Just make a contract to make schedule, grant it proposer role.

