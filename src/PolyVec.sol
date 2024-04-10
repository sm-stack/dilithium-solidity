// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";
import "./Poly.sol";

library PolynomialVector {
    using Polynomial for Polynomial.Poly;

    struct PolyVecK {
        Polynomial.Poly[K] polys;
    }

    struct PolyVecL {
        Polynomial.Poly[L] polys;
    }

    function ntt(PolyVecK memory a) public pure returns (PolyVecK memory) {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i] = a.polys[i].ntt();
        }
        return a;
    }

    function ntt(PolyVecL memory a) public pure returns (PolyVecL memory) {
        for (uint256 i = 0; i < L; ++i) {
            a.polys[i] = a.polys[i].ntt();
        }
        return a;
    }

    function invntt(PolyVecK memory a) public pure returns (PolyVecK memory) {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i] = a.polys[i].invntt();
        }
        return a;
    }

    function invntt(PolyVecL memory a) public pure returns (PolyVecL memory) {
        for (uint256 i = 0; i < L; ++i) {
            a.polys[i] = a.polys[i].invntt();
        }
        return a;
    }

    function matrix_expand(uint256 rho) public pure returns (PolyVecL[K] memory m) {
        for (uint256 i = 0; i < K; ++i) {
            for (uint256 j = 0; j < L; ++j) {
                m[i].polys[j] = m[i].polys[j].uniform(rho, uint16((i << 8) + j));
            }
        }
    }

    function mpointwise_acc(Polynomial.Poly memory w, PolyVecL memory u, PolyVecL memory v)
        public
        pure
        returns (Polynomial.Poly memory)
    {
        Polynomial.Poly memory t;
        w = w.mpointwise(u.polys[0], v.polys[0]);
        for (uint256 i = 1; i < L; ++i) {
            t = t.mpointwise(u.polys[i], v.polys[i]);
            w = w.add(t);
        }
        return w;
    }

    function matrix_mpointwise(PolyVecK memory t, PolyVecL[K] memory mat, PolyVecL memory v)
        public
        pure
        returns (PolyVecK memory)
    {
        for (uint256 i = 0; i < K; ++i) {
            t.polys[i] = mpointwise_acc(t.polys[i], mat[i], v);
        }
        return t;
    }

    function poly_mpointwise(PolyVecK memory r, Polynomial.Poly memory a, PolyVecK memory v)
        public
        pure
        returns (PolyVecK memory)
    {
        for (uint256 i = 0; i < K; ++i) {
            r.polys[i] = r.polys[i].mpointwise(a, v.polys[i]);
        }
        return r;
    }

    function shiftl(PolyVecK memory a) public pure returns (PolyVecK memory) {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i] = a.polys[i].shiftl();
        }
        return a;
    }

    function sub(PolyVecK memory a, PolyVecK memory b) public pure returns (PolyVecK memory) {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i] = a.polys[i].sub(b.polys[i]);
        }
        return a;
    }

    function reduce(PolyVecK memory a) public pure returns (PolyVecK memory) {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i] = a.polys[i].reduce();
        }
        return a;
    }

    function caddq(PolyVecK memory a) public pure returns (PolyVecK memory) {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i] = a.polys[i].caddq();
        }
        return a;
    }
}
