// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "../Constants.sol";
import "./Poly.sol";
import "./Ntt.sol";
import "./Invntt.sol";

contract PolynomialVector {
    struct PolyVecK {
        Polynomial.Poly[K] polys;
    }

    struct PolyVecL {
        Polynomial.Poly[L] polys;
    }

    Ntt immutable _ntt;
    Invntt immutable _invntt;
    Polynomial immutable _poly;

    constructor(Ntt __ntt, Invntt __invntt, Polynomial __poly) {
        _ntt = __ntt;
        _invntt = __invntt;
        _poly = __poly;
    }

    function clone_k(PolyVecK memory a) public pure returns (PolyVecK memory b) {
        for (uint256 i = 0; i < K; ++i) {
            for (uint256 j = 0; j < N; ++j) {
                b.polys[i].coeffs[j] = a.polys[i].coeffs[j];
            }
        }
    }

    function clone_l(PolyVecL memory a) public pure returns (PolyVecL memory b) {
        for (uint256 i = 0; i < K; ++i) {
            for (uint256 j = 0; j < N; ++j) {
                b.polys[i].coeffs[j] = a.polys[i].coeffs[j];
            }
        }
    }

    function ntt_l(PolyVecL memory a) public view returns (PolyVecL memory) {
        // 0..L
        a.polys[0].coeffs = _ntt.ntt(a.polys[0].coeffs);
        a.polys[1].coeffs = _ntt.ntt(a.polys[1].coeffs);
        a.polys[2].coeffs = _ntt.ntt(a.polys[2].coeffs);
        a.polys[3].coeffs = _ntt.ntt(a.polys[3].coeffs);
        return a;
    }

    function ntt_k(PolyVecK memory a) public view returns (PolyVecK memory) {
        // 0..L
        a.polys[0].coeffs = _ntt.ntt(a.polys[0].coeffs);
        a.polys[1].coeffs = _ntt.ntt(a.polys[1].coeffs);
        a.polys[2].coeffs = _ntt.ntt(a.polys[2].coeffs);
        a.polys[3].coeffs = _ntt.ntt(a.polys[3].coeffs);
        return a;
    }

    function invntt_k(PolyVecK memory a) public view returns (PolyVecK memory) {
        // 0..K
        a.polys[0].coeffs = _invntt.invntt(a.polys[0].coeffs);
        a.polys[1].coeffs = _invntt.invntt(a.polys[1].coeffs);
        a.polys[2].coeffs = _invntt.invntt(a.polys[2].coeffs);
        a.polys[3].coeffs = _invntt.invntt(a.polys[3].coeffs);
        return a;
    }

    function matrix_expand(uint256 rho) public view returns (PolyVecL[K] memory m) {
        m[0].polys[0] = _poly.uniform(m[0].polys[0], rho, uint16((0 << 8) + 0));
        m[0].polys[1] = _poly.uniform(m[0].polys[1], rho, uint16((0 << 8) + 1));
        m[0].polys[2] = _poly.uniform(m[0].polys[2], rho, uint16((0 << 8) + 2));
        m[0].polys[3] = _poly.uniform(m[0].polys[3], rho, uint16((0 << 8) + 3));

        m[1].polys[0] = _poly.uniform(m[1].polys[0], rho, uint16((1 << 8) + 0));
        m[1].polys[1] = _poly.uniform(m[1].polys[1], rho, uint16((1 << 8) + 1));
        m[1].polys[2] = _poly.uniform(m[1].polys[2], rho, uint16((1 << 8) + 2));
        m[1].polys[3] = _poly.uniform(m[1].polys[3], rho, uint16((1 << 8) + 3));

        m[2].polys[0] = _poly.uniform(m[2].polys[0], rho, uint16((2 << 8) + 0));
        m[2].polys[1] = _poly.uniform(m[2].polys[1], rho, uint16((2 << 8) + 1));
        m[2].polys[2] = _poly.uniform(m[2].polys[2], rho, uint16((2 << 8) + 2));
        m[2].polys[3] = _poly.uniform(m[2].polys[3], rho, uint16((2 << 8) + 3));

        m[3].polys[0] = _poly.uniform(m[3].polys[0], rho, uint16((3 << 8) + 0));
        m[3].polys[1] = _poly.uniform(m[3].polys[1], rho, uint16((3 << 8) + 1));
        m[3].polys[2] = _poly.uniform(m[3].polys[2], rho, uint16((3 << 8) + 2));
        m[3].polys[3] = _poly.uniform(m[3].polys[3], rho, uint16((3 << 8) + 3));
    }

    function mpointwise_acc(PolyVecL memory u, PolyVecL memory v) public view returns (Polynomial.Poly memory w) {
        // 0
        w = _poly.mpointwise(u.polys[0], v.polys[0]);
        // 1..L
        w = _poly.add(w, _poly.mpointwise(u.polys[1], v.polys[1]));
        w = _poly.add(w, _poly.mpointwise(u.polys[2], v.polys[2]));
        w = _poly.add(w, _poly.mpointwise(u.polys[3], v.polys[3]));
        return w;
    }

    function matrix_mpointwise(PolyVecL[K] memory mat, PolyVecL memory v) public view returns (PolyVecK memory t) {
        // 0..K
        t.polys[0] = mpointwise_acc(mat[0], v);
        t.polys[1] = mpointwise_acc(mat[1], v);
        t.polys[2] = mpointwise_acc(mat[2], v);
        t.polys[3] = mpointwise_acc(mat[3], v);
        return t;
    }

    function poly_mpointwise(Polynomial.Poly memory a, PolyVecK memory v) public view returns (PolyVecK memory r) {
        // 0..K
        r.polys[0] = _poly.mpointwise(a, v.polys[0]);
        r.polys[1] = _poly.mpointwise(a, v.polys[1]);
        r.polys[2] = _poly.mpointwise(a, v.polys[2]);
        r.polys[3] = _poly.mpointwise(a, v.polys[3]);
        return r;
    }

    function shiftl(PolyVecK memory a) public view returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = _poly.shiftl(a.polys[0]);
        a.polys[1] = _poly.shiftl(a.polys[1]);
        a.polys[2] = _poly.shiftl(a.polys[2]);
        a.polys[3] = _poly.shiftl(a.polys[3]);
        return a;
    }

    function sub(PolyVecK memory a, PolyVecK memory b) public view returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = _poly.sub(a.polys[0], b.polys[0]);
        a.polys[1] = _poly.sub(a.polys[1], b.polys[1]);
        a.polys[2] = _poly.sub(a.polys[2], b.polys[2]);
        a.polys[3] = _poly.sub(a.polys[3], b.polys[3]);
        return a;
    }

    function reduce(PolyVecK memory a) public view returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = _poly.reduce(a.polys[0]);
        a.polys[1] = _poly.reduce(a.polys[1]);
        a.polys[2] = _poly.reduce(a.polys[2]);
        a.polys[3] = _poly.reduce(a.polys[3]);
        return a;
    }

    function caddq(PolyVecK memory a) public view returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = _poly.caddq(a.polys[0]);
        a.polys[1] = _poly.caddq(a.polys[1]);
        a.polys[2] = _poly.caddq(a.polys[2]);
        a.polys[3] = _poly.caddq(a.polys[3]);
        return a;
    }

    function use_hint(PolyVecK memory a, PolyVecK memory b) public view returns (PolyVecK memory) {
        // 0..K
        a.polys[0] = _poly.use_hint(a.polys[0], b.polys[0]);
        a.polys[1] = _poly.use_hint(a.polys[1], b.polys[1]);
        a.polys[2] = _poly.use_hint(a.polys[2], b.polys[2]);
        a.polys[3] = _poly.use_hint(a.polys[3], b.polys[3]);
        return a;
    }

    function pack_w1(PolyVecK memory a) public view returns (bytes memory) {
        bytes memory r = new bytes(K * POLYW1_PACKEDBYTES);
        for (uint256 i = 0; i < K; ++i) {
            bytes memory buf = _poly.pack_w1(a.polys[i]);
            for (uint256 j = 0; j < POLYW1_PACKEDBYTES; ++j) {
                r[i * POLYW1_PACKEDBYTES + j] = buf[j];
            }
        }

        return r;
    }

    function chknorm(PolyVecL memory v, int32 bound) public view returns (bool) {
        for (uint256 i = 0; i < L; ++i) {
            if (_poly.chknorm(v.polys[i], bound)) {
                return true;
            }
        }

        return false;
    }
}
