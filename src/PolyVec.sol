// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";
import "./Poly.sol";
import {ntt as ntt_internal, invntt as invntt_internal} from "./Ntt.sol";

library PolynomialVector {
    using Polynomial for Polynomial.Poly;

    struct PolyVecK {
        Polynomial.Poly[K] polys;
    }

    struct PolyVecL {
        Polynomial.Poly[L] polys;
    }

    function clone(PolyVecK memory a) public pure returns (PolyVecK memory b) {
        for (uint256 i = 0; i < K; i++) {
            b.polys[i] = a.polys[i].clone();
        }
    }

    function clone(PolyVecL memory a) public pure returns (PolyVecL memory b) {
        for (uint256 i = 0; i < K; i++) {
            b.polys[i] = a.polys[i].clone();
        }
    }

    function ntt(PolyVecL memory a) public pure returns (PolyVecL memory) {
        // 0..L
        a.polys[0].coeffs = ntt_internal(a.polys[0].coeffs);
        a.polys[1].coeffs = ntt_internal(a.polys[1].coeffs);
        a.polys[2].coeffs = ntt_internal(a.polys[2].coeffs);
        a.polys[3].coeffs = ntt_internal(a.polys[3].coeffs);
        return a;
    }

    function ntt(PolyVecK memory a) public pure returns (PolyVecK memory) {
        // 0..L
        a.polys[0].coeffs = ntt_internal(a.polys[0].coeffs);
        a.polys[1].coeffs = ntt_internal(a.polys[1].coeffs);
        a.polys[2].coeffs = ntt_internal(a.polys[2].coeffs);
        a.polys[3].coeffs = ntt_internal(a.polys[3].coeffs);
        return a;
    }

    function invntt(PolyVecK memory a) public pure returns (PolyVecK memory) {
        // 0..K
        a.polys[0].coeffs = invntt_internal(a.polys[0].coeffs);
        a.polys[1].coeffs = invntt_internal(a.polys[1].coeffs);
        a.polys[2].coeffs = invntt_internal(a.polys[2].coeffs);
        a.polys[3].coeffs = invntt_internal(a.polys[3].coeffs);
        return a;
    }

    function matrix_expand(uint256 rho) public pure returns (PolyVecL[K] memory m) {
        m[0].polys[0] = m[0].polys[0].uniform(rho, uint16((0 << 8) + 0));
        m[0].polys[1] = m[0].polys[1].uniform(rho, uint16((0 << 8) + 1));
        m[0].polys[2] = m[0].polys[2].uniform(rho, uint16((0 << 8) + 2));
        m[0].polys[3] = m[0].polys[3].uniform(rho, uint16((0 << 8) + 3));
        m[1].polys[0] = m[1].polys[0].uniform(rho, uint16((1 << 8) + 0));
        m[1].polys[1] = m[1].polys[1].uniform(rho, uint16((1 << 8) + 1));
        m[1].polys[2] = m[1].polys[2].uniform(rho, uint16((1 << 8) + 2));
        m[1].polys[3] = m[1].polys[3].uniform(rho, uint16((1 << 8) + 3));
        m[2].polys[0] = m[2].polys[0].uniform(rho, uint16((2 << 8) + 0));
        m[2].polys[1] = m[2].polys[1].uniform(rho, uint16((2 << 8) + 1));
        m[2].polys[2] = m[2].polys[2].uniform(rho, uint16((2 << 8) + 2));
        m[2].polys[3] = m[2].polys[3].uniform(rho, uint16((2 << 8) + 3));
        m[3].polys[0] = m[3].polys[0].uniform(rho, uint16((3 << 8) + 0));
        m[3].polys[1] = m[3].polys[1].uniform(rho, uint16((3 << 8) + 1));
        m[3].polys[2] = m[3].polys[2].uniform(rho, uint16((3 << 8) + 2));
        m[3].polys[3] = m[3].polys[3].uniform(rho, uint16((3 << 8) + 3));
    }

    function mpointwise_acc(PolyVecL memory u, PolyVecL memory v) public pure returns (Polynomial.Poly memory w) {
        // 0
        w = u.polys[0].mpointwise(v.polys[0]);
        // 1..L
        w = w.add(u.polys[1].mpointwise(v.polys[1]));
        w = w.add(u.polys[2].mpointwise(v.polys[2]));
        w = w.add(u.polys[3].mpointwise(v.polys[3]));
        return w;
    }

    function matrix_mpointwise(PolyVecL[K] memory mat, PolyVecL memory v) public pure returns (PolyVecK memory t) {
        // 0..K
        t.polys[0] = mpointwise_acc(mat[0], v);
        t.polys[1] = mpointwise_acc(mat[1], v);
        t.polys[2] = mpointwise_acc(mat[2], v);
        t.polys[3] = mpointwise_acc(mat[3], v);
        return t;
    }

    function poly_mpointwise(Polynomial.Poly memory a, PolyVecK memory v) public pure returns (PolyVecK memory r) {
        // 0..K
        r.polys[0] = a.mpointwise(v.polys[0]);
        r.polys[1] = a.mpointwise(v.polys[1]);
        r.polys[2] = a.mpointwise(v.polys[2]);
        r.polys[3] = a.mpointwise(v.polys[3]);
        return r;
    }

    function shiftl(PolyVecK memory a) public pure returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = a.polys[0].shiftl();
        a.polys[1] = a.polys[1].shiftl();
        a.polys[2] = a.polys[2].shiftl();
        a.polys[3] = a.polys[3].shiftl();
        return a;
    }

    function sub(PolyVecK memory a, PolyVecK memory b) public pure returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = a.polys[0].sub(b.polys[0]);
        a.polys[1] = a.polys[1].sub(b.polys[1]);
        a.polys[2] = a.polys[2].sub(b.polys[2]);
        a.polys[3] = a.polys[3].sub(b.polys[3]);
        return a;
    }

    function reduce(PolyVecK memory a) public pure returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = a.polys[0].reduce();
        a.polys[1] = a.polys[1].reduce();
        a.polys[2] = a.polys[2].reduce();
        a.polys[3] = a.polys[3].reduce();
        return a;
    }

    function caddq(PolyVecK memory a) public pure returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = a.polys[0].caddq();
        a.polys[1] = a.polys[1].caddq();
        a.polys[2] = a.polys[2].caddq();
        a.polys[3] = a.polys[3].caddq();
        return a;
    }

    function use_hint(PolyVecK memory a, PolyVecK memory b) public pure returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = a.polys[0].use_hint(b.polys[0]);
        a.polys[1] = a.polys[1].use_hint(b.polys[1]);
        a.polys[2] = a.polys[2].use_hint(b.polys[2]);
        a.polys[3] = a.polys[3].use_hint(b.polys[3]);
        return a;
    }

    function pack_w1(PolyVecK memory a) public pure returns (bytes memory) {
        bytes memory r = new bytes(K * POLYW1_PACKEDBYTES);
        for (uint256 i = 0; i < K; ++i) {
            bytes memory buf = a.polys[i].pack_w1();
            for (uint256 j = 0; j < POLYW1_PACKEDBYTES; ++j) {
                r[i * POLYW1_PACKEDBYTES + j] = buf[j];
            }
        }

        return r;
    }

    function chknorm(PolyVecL memory v, int32 bound) public pure returns (bool) {
        for (uint256 i = 0; i < L; ++i) {
            if (v.polys[i].chknorm(bound)) {
                return true;
            }
        }

        return false;
    }
}
