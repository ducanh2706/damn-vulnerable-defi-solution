// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {Safe} from "@safe-global/safe-smart-account/contracts/Safe.sol";

contract FakeModule {
    function approveFake(address token, uint256 value, address who) external {
        (bool ok,) = token.call(abi.encodeWithSignature("approve(address,uint256)", who, value));
        require(ok);
    }
}
