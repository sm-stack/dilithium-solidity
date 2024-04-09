// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";

function mreduce64(int64 a) pure returns (int32) {
    int64 t;
    unchecked {
        t = int64(int32(a) * QINV);
    }
    t = (a - t * Q) >> 32;
    return int32(t);
}

function reduce32(int32 a) pure returns (int32) {
    int32 t = (a + (1 << 22)) >> 23;
    t = a - t * int32(Q);
    return t;
}

function caddq32(int32 a) pure returns (int32) {
    return a + ((a >> 31) & int32(Q));
}
