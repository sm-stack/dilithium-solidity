// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";

function use_hint(int32 a, uint8 hint) pure returns (int32) {
    unchecked {
        int32 a0 = 0;
        int32 a1;

        {
            a1 = (a + 127) >> 7;

            // --
            // if (GAMMA2 == (Q - 1) / 32) {
            // a1 = (a1 * 1025 + (1 << 21)) >> 22;
            // a1 &= 15;
            // }
            // else if (GAMMA2 == (Q - 1) / 88)
            a1 = (a1 * 11275 + (1 << 23)) >> 24;
            a1 ^= ((43 - a1) >> 31) & a1;
            // --

            a0 = a - a1 * 2 * GAMMA2_I32;
            a0 -= (((Q_I32 - 1) / 2 - a0) >> 31) & Q_I32;
        }

        if (hint == 0) {
            return a1;
        }

        // if GAMMA2 == (Q - 1) / 32 {
        //     if a0 > 0 {
        //       return (a1 + 1) & 15;
        //     } else {
        //       return (a1 - 1) & 15;
        //     }
        //   }

        if (a0 > 0) {
            if (a1 == 43) {
                return 0;
            } else {
                return a1 + 1;
            }
        } else {
            if (a1 == 0) {
                return 43;
            } else {
                return a1 - 1;
            }
        }
    }
}
