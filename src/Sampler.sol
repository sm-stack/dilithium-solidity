// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";

function rej_uniform(int32[] memory a, uint256 len, bytes memory buf, uint256 buflen) pure returns (uint256) {
    uint256 ctr = 0;
    uint256 pos = 0;
    uint32 t = 0;

    while (ctr < len && pos + 3 <= buflen) {
        t = uint32(uint8(buf[pos]));
        pos += 1;
        t |= uint32(uint8(buf[pos])) << 8;
        pos += 1;
        t |= uint32(uint8(buf[pos])) << 16;
        pos += 1;
        t &= 0x7FFFFF;

        if (t < Q_U32) {
            a[ctr] = int32(t);
            ctr += 1;
        }
    }

    return (ctr);
}
