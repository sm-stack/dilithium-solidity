// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";
import "./Reduce.sol";
import "./Symmetric.sol";
import "./Sampler.sol";
import {ntt as ntt_internal, invntt as invntt_internal} from "./Ntt.sol";

library Polynomial {
    using Stream for Stream.State;

    struct Poly {
        int32[N] coeffs;
    }

    function reduce(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        for (uint256 i = 0; i < N; i++) {
            t.coeffs[i] = reduce32(a.coeffs[i]);
        }
        return t;
    }

    function caddq(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        for (uint256 i = 0; i < N; i++) {
            t.coeffs[i] = caddq32(a.coeffs[i]);
        }
        return t;
    }

    function add(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        Poly memory t;
        for (uint256 i = 0; i < N; i++) {
            t.coeffs[i] = a.coeffs[i] + b.coeffs[i];
        }
        return t;
    }

    function sub(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        Poly memory t;
        for (uint256 i = 0; i < N; i++) {
            t.coeffs[i] = a.coeffs[i] - b.coeffs[i];
        }
        return t;
    }

    function shiftl(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        for (uint256 i = 0; i < N; i++) {
            t.coeffs[i] = a.coeffs[i] << uint32(D);
        }
        return t;
    }

    function ntt(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        t.coeffs = ntt_internal(a.coeffs);
        return t;
    }

    function invntt(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        t.coeffs = invntt_internal(a.coeffs);
        return t;
    }

    uint256 constant POLY_UNIFORM_NBLOCKS = (768 + STREAM128_BLOCKBYTES - 1) / STREAM128_BLOCKBYTES;

    function uniform(Poly memory a, uint256 seed, uint16 nonce) public pure returns (Poly memory) {
        uint256 buflen = POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES;
        bytes memory buf = new bytes(buflen);

        Stream.State memory state = Stream.init(seed, nonce);
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
                bytes memory tmpbuf = new bytes(STREAM128_BLOCKBYTES);
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

    function challenge(uint256 seed) public pure returns (Poly memory a) {
        uint64 signs = 0;
        bytes memory buf = new bytes(SHAKE256_RATE);

        Stream.State memory state = Stream.empty();
        state = state.absorb(abi.encodePacked(seed));
        (state, buf) = state.s256_squeeze_block();

        for (uint64 i = 0; i < 8; ++i) {
            signs |= uint64(uint8(buf[i])) << (8 * i);
        }

        uint256 pos = 8;
        uint256 b;

        for (uint256 i = N - TAU; i < N; ++i) {
            while (b <= 1) {
                if (pos >= SHAKE256_RATE) {
                    (state, buf) = state.s256_squeeze_block();
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
}
