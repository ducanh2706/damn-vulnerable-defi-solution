- Okay, this is related to Safe multisig. So I need to learn more about it first.
- Okay, have deep diven into Safe contract.
- Now I need to withdraw all funds in WalletRegistry
- For each person (4 of them), need to deploy a safe wallet with the only owner is them.
```
// Ensure wallet initialization is the expected
        uint256 threshold = Safe(walletAddress).getThreshold();
        if (threshold != 1) {
            revert InvalidThreshold(threshold);
        }

        address[] memory owners = Safe(walletAddress).getOwners();
        if (owners.length != 1) {
            revert InvalidOwnersCount(owners.length);
        }
 address walletOwner;
        unchecked {
            walletOwner = owners[0];
        }
        if (!beneficiaries[walletOwner]) {
            revert OwnerIsNotABeneficiary();
        }
```

I can deploy with owner is them easily?

`function setupOwners(address[] memory _owners, uint256 _threshold) internal`

- Token will the be sent to ưthe wallet deployed `
```
 // Pay tokens to the newly created wallet
        SafeTransferLib.safeTransfer(address(token), walletAddress, PAYMENT_AMOUNT);
```

So I need to withdraw from it. But the only owner is user, so I can't withdraw since I don't have the pk. will need somehow to bypass

There's module concept in safe `setupModules(to, data);`. this allow module contract to call without having owners to sign. So maybe i can write a module contract that can let me withdraw the fund the `recovery` address. 

