// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";
import "./Reduce.sol";
import "./Symmetric.sol";
import "./Sampler.sol";
import {use_hint as use_hint_internal} from "./Rounding.sol";
import {ntt as ntt_internal, invntt as invntt_internal} from "./Ntt.sol";

library Polynomial {
    using Stream for Stream.State;

    struct Poly {
        int32[N] coeffs;
    }

    function clone(Poly memory a) public pure returns (Poly memory b) {
        for (uint256 i = 0; i < N; i++) {
            b.coeffs[i] = a.coeffs[i];
        }
        return b;
    }

    function reduce(Poly memory a) public pure {
        for (uint256 i = 0; i < N; i++) {
            a.coeffs[i] = reduce32(a.coeffs[i]);
        }
    }

    function caddq(Poly memory a) public pure {
        for (uint256 i = 0; i < N; i++) {
            a.coeffs[i] = caddq32(a.coeffs[i]);
        }
    }

    function add(Poly memory a, Poly memory b) public pure {
        for (uint256 i = 0; i < N; i++) {
            a.coeffs[i] = a.coeffs[i] + b.coeffs[i];
        }
    }

    function sub(Poly memory a, Poly memory b) public pure {
        for (uint256 i = 0; i < N; i++) {
            a.coeffs[i] = a.coeffs[i] - b.coeffs[i];
        }
    }

    function shiftl(Poly memory a) public pure {
        for (uint256 i = 0; i < N; i++) {
            a.coeffs[i] = a.coeffs[i] << uint32(D);
        }
    }

    function ntt(Poly memory a) public pure {
        ntt_internal(a.coeffs);
    }

    function invntt(Poly memory a) public pure {
        invntt_internal(a.coeffs);
    }

    uint256 constant POLY_UNIFORM_NBLOCKS = (768 + STREAM128_BLOCKBYTES - 1) / STREAM128_BLOCKBYTES;

    function uniform(Poly memory a, uint256 seed, uint16 nonce) public pure {
        uint256 buflen = POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES;
        bytes memory buf = new bytes(buflen);

        Stream.State memory state = Stream.init(seed, nonce);
        buf = state.s128_squeeze_nblocks(POLY_UNIFORM_NBLOCKS);

        uint256 ctr;
        uint256 off;

        {
            int32[] memory _coef = new int32[](N);
            for (uint256 i = 0; i < N; i++) {
                _coef[i] = a.coeffs[i];
            }
            ctr = rej_uniform(_coef, N, buf, buflen);
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
                bytes memory tmpbuf = new bytes(STREAM128_BLOCKBYTES);
                tmpbuf = state.s128_squeeze_block();
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
                ctr = rej_uniform(_coef, N - ctr, buf, buflen);
                for (uint256 i = 0; i < (N - ctr); i++) {
                    a.coeffs[i + ctr] = _coef[i];
                }
            }
        }
    }

    function challenge(uint256 seed) public pure returns (Poly memory a) {
        uint64 signs = 0;

        Stream.State memory state = Stream.empty();
        state.absorb(abi.encodePacked(seed));
        bytes memory buf = state.s256_squeeze_block();

        for (uint64 i = 0; i < 8; ++i) {
            signs |= uint64(uint8(buf[i])) << (8 * i);
        }

        uint256 pos = 8;
        uint256 b;

        for (uint256 i = N - TAU; i < N; ++i) {
            while (b <= 1) {
                if (pos >= SHAKE256_RATE) {
                    buf = state.s256_squeeze_block();
                    pos = 0;
                }
                b = uint256(uint8(buf[pos]));
                pos += 1;
            }

            a.coeffs[i] = a.coeffs[b];
            a.coeffs[b] = 1 - 2 * int32(int64(signs & 1));
            signs >>= 1;
        }
    }

    function mpointwise(Poly memory c, Poly memory a, Poly memory b) public pure {
        for (uint256 i = 0; i < N; ++i) {
            c.coeffs[i] = mreduce64(int64(a.coeffs[i]) * int64(b.coeffs[i]));
        }
    }

    function use_hint(Poly memory a, Poly memory b) public pure {
        for (uint256 i = 0; i < N; ++i) {
            a.coeffs[i] = use_hint_internal(a.coeffs[i], uint8(uint32(b.coeffs[i])));
        }
    }

    function pack_w1(Poly memory a) public pure returns (bytes memory) {
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

    function chknorm(Poly memory a, int32 b) public pure returns (bool) {
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
