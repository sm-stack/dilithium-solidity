// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "../Constants.sol";
import "../Reduce.sol";
import "../Symmetric.sol";
import "../Sampler.sol";
import {use_hint as use_hint_internal} from "../Rounding.sol";
import "./Ntt.sol";

contract Polynomial {
    using Stream for Stream.State;

    Ntt immutable _ntt;

    constructor(Ntt __ntt) {
        _ntt = __ntt;
    }

    struct Poly {
        int32[N] coeffs;
    }

    function clone(Poly memory a) public pure returns (Poly memory b) {
        unchecked {
            for (uint256 i = 0; i < N; ++i) {
                b.coeffs[i] = a.coeffs[i];
            }
            return b;
        }
    }

    function reduce(Poly memory a) public pure returns (Poly memory) {
        unchecked {
            for (uint256 i = 0; i < N; ++i) {
                a.coeffs[i] = reduce32(a.coeffs[i]);
            }
            return a;
        }
    }

    function caddq(Poly memory a) public pure returns (Poly memory) {
        unchecked {
            for (uint256 i = 0; i < N; ++i) {
                a.coeffs[i] = caddq32(a.coeffs[i]);
            }
            return a;
        }
    }

    function add(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        unchecked {
            for (uint256 i = 0; i < 256; i++) {
                a.coeffs[i] = a.coeffs[i] + b.coeffs[i];
            }
            return a;
        }
    }

    function sub(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        unchecked {
            for (uint256 i = 0; i < 256; i++) {
                a.coeffs[i] = a.coeffs[i] - b.coeffs[i];
            }
            return a;
        }
    }

    function shiftl(Poly memory a) public pure returns (Poly memory) {
        unchecked {
            for (uint256 i = 0; i < N; i++) {
                a.coeffs[i] = a.coeffs[i] << D_U32;
            }
            return a;
        }
    }

    function ntt(Poly memory a) public view returns (Poly memory) {
        a.coeffs = _ntt.ntt(a.coeffs);
        return a;
    }

    uint256 constant POLY_UNIFORM_NBLOCKS = (768 + STREAM128_BLOCKBYTES - 1) / STREAM128_BLOCKBYTES;

    function uniform(Poly memory a, uint256 seed, uint16 nonce) public pure returns (Poly memory) {
        unchecked {
            uint256 buflen = POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES;

            Stream.State memory state = Stream.init(seed, nonce);
            bytes memory buf;
            (state, buf) = state.s128_squeeze_nblocks(POLY_UNIFORM_NBLOCKS);

            uint256 ctr;
            uint256 off;

            {
                int32[] memory _coef = new int32[](N);
                for (uint256 i = 0; i < N; i++) {
                    _coef[i] = a.coeffs[i];
                }
                (_coef, ctr) = rej_uniform(_coef, N, buf, buflen);
                for (uint256 i = 0; i < N; i++) {
                    a.coeffs[i] = _coef[i];
                }
            }

            while (ctr < N) {
                off = buflen % 3;
                for (uint256 i = 0; i < off; i++) {
                    buf[i] = buf[buflen - off + i];
                }
                buflen = off + STREAM128_BLOCKBYTES;
                {
                    bytes memory tmpbuf;
                    (state, tmpbuf) = state.s128_squeeze_block();
                    // buf[off..] = tmpbuf
                    for (uint256 i = 0; i < STREAM128_BLOCKBYTES; i++) {
                        buf[off + i] = tmpbuf[i];
                    }
                }
                {
                    int32[] memory _coef = new int32[](N - ctr);
                    for (uint256 i = 0; i < (N - ctr); i++) {
                        _coef[i] = a.coeffs[i + ctr];
                    }
                    (_coef, ctr) = rej_uniform(_coef, N - ctr, buf, buflen);
                    for (uint256 i = 0; i < (N - ctr); i++) {
                        a.coeffs[i + ctr] = _coef[i];
                    }
                }
            }

            return a;
        }
    }

    function challenge(bytes32 seed) public pure returns (Poly memory a) {
        unchecked {
            uint64 signs = 0;

            Stream.State memory state = Stream.empty();
            state = state.absorb(bytes.concat(seed));

            bytes memory buf;
            (state, buf) = state.s256_squeeze_block();

            for (uint64 i = 0; i < 8; ++i) {
                signs |= uint64(uint8(buf[i])) << (8 * i);
            }

            uint256 pos = 8;
            uint256 b;

            for (uint256 i = N - TAU; i < N; ++i) {
                while (true) {
                    if (pos >= SHAKE256_RATE) {
                        (state, buf) = state.s256_squeeze_block();
                        pos = 0;
                    }
                    b = uint256(uint8(buf[pos]));
                    pos += 1;
                    if (b <= i) {
                        break;
                    }
                }

                a.coeffs[i] = a.coeffs[b];
                a.coeffs[b] = 1 - 2 * int32(int64(signs & 1));
                signs >>= 1;
            }
        }
    }

    function mpointwise(Poly memory a, Poly memory b) public pure returns (Poly memory c) {
        unchecked {
            {
                int64 tr = int64(a.coeffs[0]) * int64(b.coeffs[0]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[0] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[1]) * int64(b.coeffs[1]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[1] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[2]) * int64(b.coeffs[2]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[2] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[3]) * int64(b.coeffs[3]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[3] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[4]) * int64(b.coeffs[4]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[4] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[5]) * int64(b.coeffs[5]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[5] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[6]) * int64(b.coeffs[6]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[6] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[7]) * int64(b.coeffs[7]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[7] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[8]) * int64(b.coeffs[8]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[8] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[9]) * int64(b.coeffs[9]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[9] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[10]) * int64(b.coeffs[10]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[10] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[11]) * int64(b.coeffs[11]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[11] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[12]) * int64(b.coeffs[12]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[12] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[13]) * int64(b.coeffs[13]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[13] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[14]) * int64(b.coeffs[14]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[14] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[15]) * int64(b.coeffs[15]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[15] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[16]) * int64(b.coeffs[16]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[16] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[17]) * int64(b.coeffs[17]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[17] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[18]) * int64(b.coeffs[18]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[18] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[19]) * int64(b.coeffs[19]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[19] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[20]) * int64(b.coeffs[20]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[20] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[21]) * int64(b.coeffs[21]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[21] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[22]) * int64(b.coeffs[22]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[22] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[23]) * int64(b.coeffs[23]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[23] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[24]) * int64(b.coeffs[24]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[24] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[25]) * int64(b.coeffs[25]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[25] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[26]) * int64(b.coeffs[26]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[26] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[27]) * int64(b.coeffs[27]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[27] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[28]) * int64(b.coeffs[28]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[28] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[29]) * int64(b.coeffs[29]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[29] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[30]) * int64(b.coeffs[30]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[30] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[31]) * int64(b.coeffs[31]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[31] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[32]) * int64(b.coeffs[32]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[32] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[33]) * int64(b.coeffs[33]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[33] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[34]) * int64(b.coeffs[34]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[34] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[35]) * int64(b.coeffs[35]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[35] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[36]) * int64(b.coeffs[36]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[36] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[37]) * int64(b.coeffs[37]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[37] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[38]) * int64(b.coeffs[38]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[38] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[39]) * int64(b.coeffs[39]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[39] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[40]) * int64(b.coeffs[40]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[40] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[41]) * int64(b.coeffs[41]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[41] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[42]) * int64(b.coeffs[42]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[42] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[43]) * int64(b.coeffs[43]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[43] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[44]) * int64(b.coeffs[44]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[44] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[45]) * int64(b.coeffs[45]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[45] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[46]) * int64(b.coeffs[46]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[46] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[47]) * int64(b.coeffs[47]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[47] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[48]) * int64(b.coeffs[48]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[48] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[49]) * int64(b.coeffs[49]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[49] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[50]) * int64(b.coeffs[50]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[50] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[51]) * int64(b.coeffs[51]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[51] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[52]) * int64(b.coeffs[52]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[52] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[53]) * int64(b.coeffs[53]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[53] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[54]) * int64(b.coeffs[54]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[54] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[55]) * int64(b.coeffs[55]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[55] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[56]) * int64(b.coeffs[56]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[56] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[57]) * int64(b.coeffs[57]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[57] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[58]) * int64(b.coeffs[58]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[58] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[59]) * int64(b.coeffs[59]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[59] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[60]) * int64(b.coeffs[60]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[60] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[61]) * int64(b.coeffs[61]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[61] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[62]) * int64(b.coeffs[62]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[62] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[63]) * int64(b.coeffs[63]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[63] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[64]) * int64(b.coeffs[64]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[64] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[65]) * int64(b.coeffs[65]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[65] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[66]) * int64(b.coeffs[66]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[66] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[67]) * int64(b.coeffs[67]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[67] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[68]) * int64(b.coeffs[68]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[68] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[69]) * int64(b.coeffs[69]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[69] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[70]) * int64(b.coeffs[70]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[70] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[71]) * int64(b.coeffs[71]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[71] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[72]) * int64(b.coeffs[72]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[72] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[73]) * int64(b.coeffs[73]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[73] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[74]) * int64(b.coeffs[74]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[74] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[75]) * int64(b.coeffs[75]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[75] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[76]) * int64(b.coeffs[76]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[76] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[77]) * int64(b.coeffs[77]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[77] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[78]) * int64(b.coeffs[78]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[78] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[79]) * int64(b.coeffs[79]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[79] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[80]) * int64(b.coeffs[80]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[80] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[81]) * int64(b.coeffs[81]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[81] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[82]) * int64(b.coeffs[82]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[82] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[83]) * int64(b.coeffs[83]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[83] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[84]) * int64(b.coeffs[84]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[84] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[85]) * int64(b.coeffs[85]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[85] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[86]) * int64(b.coeffs[86]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[86] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[87]) * int64(b.coeffs[87]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[87] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[88]) * int64(b.coeffs[88]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[88] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[89]) * int64(b.coeffs[89]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[89] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[90]) * int64(b.coeffs[90]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[90] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[91]) * int64(b.coeffs[91]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[91] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[92]) * int64(b.coeffs[92]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[92] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[93]) * int64(b.coeffs[93]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[93] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[94]) * int64(b.coeffs[94]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[94] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[95]) * int64(b.coeffs[95]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[95] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[96]) * int64(b.coeffs[96]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[96] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[97]) * int64(b.coeffs[97]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[97] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[98]) * int64(b.coeffs[98]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[98] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[99]) * int64(b.coeffs[99]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[99] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[100]) * int64(b.coeffs[100]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[100] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[101]) * int64(b.coeffs[101]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[101] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[102]) * int64(b.coeffs[102]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[102] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[103]) * int64(b.coeffs[103]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[103] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[104]) * int64(b.coeffs[104]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[104] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[105]) * int64(b.coeffs[105]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[105] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[106]) * int64(b.coeffs[106]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[106] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[107]) * int64(b.coeffs[107]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[107] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[108]) * int64(b.coeffs[108]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[108] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[109]) * int64(b.coeffs[109]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[109] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[110]) * int64(b.coeffs[110]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[110] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[111]) * int64(b.coeffs[111]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[111] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[112]) * int64(b.coeffs[112]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[112] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[113]) * int64(b.coeffs[113]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[113] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[114]) * int64(b.coeffs[114]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[114] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[115]) * int64(b.coeffs[115]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[115] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[116]) * int64(b.coeffs[116]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[116] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[117]) * int64(b.coeffs[117]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[117] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[118]) * int64(b.coeffs[118]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[118] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[119]) * int64(b.coeffs[119]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[119] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[120]) * int64(b.coeffs[120]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[120] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[121]) * int64(b.coeffs[121]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[121] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[122]) * int64(b.coeffs[122]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[122] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[123]) * int64(b.coeffs[123]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[123] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[124]) * int64(b.coeffs[124]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[124] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[125]) * int64(b.coeffs[125]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[125] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[126]) * int64(b.coeffs[126]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[126] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[127]) * int64(b.coeffs[127]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[127] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[128]) * int64(b.coeffs[128]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[128] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[129]) * int64(b.coeffs[129]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[129] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[130]) * int64(b.coeffs[130]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[130] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[131]) * int64(b.coeffs[131]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[131] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[132]) * int64(b.coeffs[132]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[132] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[133]) * int64(b.coeffs[133]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[133] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[134]) * int64(b.coeffs[134]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[134] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[135]) * int64(b.coeffs[135]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[135] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[136]) * int64(b.coeffs[136]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[136] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[137]) * int64(b.coeffs[137]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[137] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[138]) * int64(b.coeffs[138]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[138] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[139]) * int64(b.coeffs[139]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[139] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[140]) * int64(b.coeffs[140]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[140] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[141]) * int64(b.coeffs[141]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[141] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[142]) * int64(b.coeffs[142]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[142] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[143]) * int64(b.coeffs[143]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[143] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[144]) * int64(b.coeffs[144]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[144] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[145]) * int64(b.coeffs[145]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[145] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[146]) * int64(b.coeffs[146]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[146] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[147]) * int64(b.coeffs[147]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[147] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[148]) * int64(b.coeffs[148]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[148] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[149]) * int64(b.coeffs[149]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[149] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[150]) * int64(b.coeffs[150]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[150] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[151]) * int64(b.coeffs[151]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[151] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[152]) * int64(b.coeffs[152]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[152] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[153]) * int64(b.coeffs[153]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[153] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[154]) * int64(b.coeffs[154]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[154] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[155]) * int64(b.coeffs[155]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[155] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[156]) * int64(b.coeffs[156]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[156] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[157]) * int64(b.coeffs[157]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[157] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[158]) * int64(b.coeffs[158]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[158] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[159]) * int64(b.coeffs[159]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[159] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[160]) * int64(b.coeffs[160]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[160] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[161]) * int64(b.coeffs[161]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[161] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[162]) * int64(b.coeffs[162]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[162] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[163]) * int64(b.coeffs[163]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[163] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[164]) * int64(b.coeffs[164]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[164] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[165]) * int64(b.coeffs[165]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[165] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[166]) * int64(b.coeffs[166]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[166] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[167]) * int64(b.coeffs[167]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[167] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[168]) * int64(b.coeffs[168]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[168] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[169]) * int64(b.coeffs[169]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[169] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[170]) * int64(b.coeffs[170]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[170] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[171]) * int64(b.coeffs[171]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[171] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[172]) * int64(b.coeffs[172]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[172] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[173]) * int64(b.coeffs[173]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[173] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[174]) * int64(b.coeffs[174]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[174] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[175]) * int64(b.coeffs[175]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[175] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[176]) * int64(b.coeffs[176]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[176] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[177]) * int64(b.coeffs[177]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[177] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[178]) * int64(b.coeffs[178]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[178] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[179]) * int64(b.coeffs[179]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[179] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[180]) * int64(b.coeffs[180]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[180] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[181]) * int64(b.coeffs[181]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[181] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[182]) * int64(b.coeffs[182]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[182] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[183]) * int64(b.coeffs[183]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[183] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[184]) * int64(b.coeffs[184]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[184] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[185]) * int64(b.coeffs[185]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[185] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[186]) * int64(b.coeffs[186]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[186] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[187]) * int64(b.coeffs[187]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[187] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[188]) * int64(b.coeffs[188]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[188] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[189]) * int64(b.coeffs[189]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[189] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[190]) * int64(b.coeffs[190]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[190] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[191]) * int64(b.coeffs[191]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[191] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[192]) * int64(b.coeffs[192]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[192] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[193]) * int64(b.coeffs[193]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[193] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[194]) * int64(b.coeffs[194]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[194] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[195]) * int64(b.coeffs[195]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[195] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[196]) * int64(b.coeffs[196]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[196] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[197]) * int64(b.coeffs[197]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[197] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[198]) * int64(b.coeffs[198]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[198] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[199]) * int64(b.coeffs[199]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[199] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[200]) * int64(b.coeffs[200]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[200] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[201]) * int64(b.coeffs[201]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[201] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[202]) * int64(b.coeffs[202]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[202] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[203]) * int64(b.coeffs[203]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[203] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[204]) * int64(b.coeffs[204]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[204] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[205]) * int64(b.coeffs[205]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[205] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[206]) * int64(b.coeffs[206]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[206] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[207]) * int64(b.coeffs[207]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[207] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[208]) * int64(b.coeffs[208]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[208] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[209]) * int64(b.coeffs[209]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[209] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[210]) * int64(b.coeffs[210]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[210] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[211]) * int64(b.coeffs[211]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[211] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[212]) * int64(b.coeffs[212]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[212] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[213]) * int64(b.coeffs[213]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[213] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[214]) * int64(b.coeffs[214]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[214] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[215]) * int64(b.coeffs[215]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[215] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[216]) * int64(b.coeffs[216]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[216] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[217]) * int64(b.coeffs[217]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[217] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[218]) * int64(b.coeffs[218]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[218] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[219]) * int64(b.coeffs[219]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[219] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[220]) * int64(b.coeffs[220]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[220] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[221]) * int64(b.coeffs[221]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[221] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[222]) * int64(b.coeffs[222]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[222] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[223]) * int64(b.coeffs[223]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[223] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[224]) * int64(b.coeffs[224]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[224] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[225]) * int64(b.coeffs[225]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[225] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[226]) * int64(b.coeffs[226]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[226] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[227]) * int64(b.coeffs[227]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[227] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[228]) * int64(b.coeffs[228]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[228] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[229]) * int64(b.coeffs[229]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[229] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[230]) * int64(b.coeffs[230]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[230] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[231]) * int64(b.coeffs[231]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[231] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[232]) * int64(b.coeffs[232]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[232] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[233]) * int64(b.coeffs[233]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[233] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[234]) * int64(b.coeffs[234]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[234] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[235]) * int64(b.coeffs[235]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[235] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[236]) * int64(b.coeffs[236]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[236] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[237]) * int64(b.coeffs[237]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[237] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[238]) * int64(b.coeffs[238]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[238] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[239]) * int64(b.coeffs[239]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[239] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[240]) * int64(b.coeffs[240]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[240] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[241]) * int64(b.coeffs[241]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[241] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[242]) * int64(b.coeffs[242]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[242] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[243]) * int64(b.coeffs[243]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[243] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[244]) * int64(b.coeffs[244]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[244] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[245]) * int64(b.coeffs[245]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[245] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[246]) * int64(b.coeffs[246]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[246] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[247]) * int64(b.coeffs[247]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[247] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[248]) * int64(b.coeffs[248]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[248] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[249]) * int64(b.coeffs[249]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[249] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[250]) * int64(b.coeffs[250]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[250] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[251]) * int64(b.coeffs[251]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[251] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[252]) * int64(b.coeffs[252]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[252] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[253]) * int64(b.coeffs[253]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[253] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[254]) * int64(b.coeffs[254]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[254] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[255]) * int64(b.coeffs[255]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[255] = int32((tr - tri * Q) >> 32);
            }
        }

        return c;
    }

    function use_hint(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        unchecked {
            for (uint256 i = 0; i < N; ++i) {
                a.coeffs[i] = use_hint_internal(a.coeffs[i], uint8(uint32(b.coeffs[i])));
            }
            return a;
        }
    }

    function chknorm(Poly memory a, int32 b) public pure returns (bool) {
        unchecked {
            int32 t;
            if (b > (Q_I32 - 1) / 8) {
                return true;
            }

            for (uint256 i = 0; i < N; ++i) {
                int32 ai = a.coeffs[i];
                t = ai >> 31;
                t = ai - (t & 2 * ai);
                if (t >= b) {
                    return true;
                }
            }

            return false;
        }
    }

    function pack_w1(Poly memory a) public pure returns (bytes memory) {
        unchecked {
            // if if GAMMA2 == (Q - 1) / 88
            bytes memory r = new bytes(POLYW1_PACKEDBYTES);
            for (uint256 i = 0; i < N / 4; ++i) {
                r[3 * i + 0] = bytes1(uint8(uint32(a.coeffs[4 * i + 0])));
                r[3 * i + 0] |= bytes1(uint8(uint32(a.coeffs[4 * i + 1] << 6)));

                r[3 * i + 1] = bytes1(uint8(uint32(a.coeffs[4 * i + 1] >> 2)));
                r[3 * i + 1] |= bytes1(uint8(uint32(a.coeffs[4 * i + 2] << 4)));

                r[3 * i + 2] = bytes1(uint8(uint32(a.coeffs[4 * i + 2] >> 4)));
                r[3 * i + 2] |= bytes1(uint8(uint32(a.coeffs[4 * i + 3] << 2)));
            }
            // else {
            //     for i in 0..N / 2 {
            //       r[i] = (a.coeffs[2 * i + 0] | (a.coeffs[2 * i + 1] << 4)) as u8;
            //     }
            //   }
            return r;
        }
    }

    function pack_t1(Poly memory a) public pure returns (bytes memory) {
        unchecked {
            bytes memory r = new bytes(POLYT1_PACKEDBYTES);
            for (uint256 i = 0; i < N / 4; ++i) {
                r[5 * i + 0] = bytes1(uint8(uint32(a.coeffs[4 * i + 0] >> 0)));
                r[5 * i + 1] = bytes1(uint8(uint32((a.coeffs[4 * i + 0] >> 8) | (a.coeffs[4 * i + 1] << 2))));
                r[5 * i + 2] = bytes1(uint8(uint32((a.coeffs[4 * i + 1] >> 6) | (a.coeffs[4 * i + 2] << 4))));
                r[5 * i + 3] = bytes1(uint8(uint32((a.coeffs[4 * i + 2] >> 4) | (a.coeffs[4 * i + 3] << 6))));
                r[5 * i + 4] = bytes1(uint8(uint32(a.coeffs[4 * i + 3] >> 2)));
            }
            return r;
        }
    }

    function unpack_t1(bytes memory a) public pure returns (Poly memory r) {
        unchecked {
            for (uint256 i = 0; i < N / 4; ++i) {
                r.coeffs[4 * i + 0] = int32(uint32(uint8(a[5 * i + 0])) | (uint32((uint8(a[5 * i + 1]))) << 8) & 0x3FF);
                r.coeffs[4 * i + 1] =
                    int32((uint32(uint8(a[5 * i + 1])) >> 2) | (uint32(uint8(a[5 * i + 2])) << 6) & 0x3FF);
                r.coeffs[4 * i + 2] =
                    int32((uint32(uint8(a[5 * i + 2])) >> 4) | (uint32(uint8(a[5 * i + 3])) << 4) & 0x3FF);
                r.coeffs[4 * i + 3] =
                    int32((uint32(uint8(a[5 * i + 3])) >> 6) | (uint32(uint8(a[5 * i + 4])) << 2) & 0x3FF);
            }
        }
    }

    function unpack_z(bytes memory a) public pure returns (Poly memory r) {
        unchecked {
            // if GAMMA1 == 1 << 17
            for (uint256 i = 0; i < N / 4; ++i) {
                r.coeffs[4 * i + 0] = int32(uint32(uint8(a[9 * i + 0])));
                r.coeffs[4 * i + 0] |= int32(uint32(uint8(a[9 * i + 1]))) << 8;
                r.coeffs[4 * i + 0] |= int32(uint32(uint8(a[9 * i + 2]))) << 16;
                r.coeffs[4 * i + 0] &= 0x3FFFF;

                r.coeffs[4 * i + 1] = int32(uint32(uint8(a[9 * i + 2]) >> 2));
                r.coeffs[4 * i + 1] |= int32(uint32(uint8(a[9 * i + 3]))) << 6;
                r.coeffs[4 * i + 1] |= int32(uint32(uint8(a[9 * i + 4]))) << 14;
                r.coeffs[4 * i + 1] &= 0x3FFFF;

                r.coeffs[4 * i + 2] = int32(uint32(uint8(a[9 * i + 4]) >> 4));
                r.coeffs[4 * i + 2] |= int32(uint32(uint8(a[9 * i + 5]))) << 4;
                r.coeffs[4 * i + 2] |= int32(uint32(uint8(a[9 * i + 6]))) << 12;
                r.coeffs[4 * i + 2] &= 0x3FFFF;

                r.coeffs[4 * i + 3] = int32(uint32(uint8(a[9 * i + 6]) >> 6));
                r.coeffs[4 * i + 3] |= int32(uint32(uint8(a[9 * i + 7]))) << 2;
                r.coeffs[4 * i + 3] |= int32(uint32(uint8(a[9 * i + 8]))) << 10;
                r.coeffs[4 * i + 3] &= 0x3FFFF;

                r.coeffs[4 * i + 0] = GAMMA1_I32 - r.coeffs[4 * i + 0];
                r.coeffs[4 * i + 1] = GAMMA1_I32 - r.coeffs[4 * i + 1];
                r.coeffs[4 * i + 2] = GAMMA1_I32 - r.coeffs[4 * i + 2];
                r.coeffs[4 * i + 3] = GAMMA1_I32 - r.coeffs[4 * i + 3];
            }
        }
    }
}
