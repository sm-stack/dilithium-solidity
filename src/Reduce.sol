// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";

function mreduce64(int64 a) pure returns (int32) {
    unchecked {
        int64 t = int64(int32(a) * QINV);
        t = (a - t * Q) >> 32;
        return int32(t);
    }
}

function reduce32(int32 a) pure returns (int32) {
    unchecked {
        int32 t = (a + 4194304) >> 23;
        t = a - t * Q_I32;
        return t;
    }
}

function caddq32(int32 a) pure returns (int32) {
    unchecked {
        return a + ((a >> 31) & Q_I32);
    }
}
