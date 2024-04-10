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

    function ntt(PolyVecK memory a) public pure {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i].ntt();
        }
    }

    function ntt(PolyVecL memory a) public pure {
        for (uint256 i = 0; i < L; ++i) {
            a.polys[i].ntt();
        }
    }

    function invntt(PolyVecK memory a) public pure {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i].invntt();
        }
    }

    function invntt(PolyVecL memory a) public pure {
        for (uint256 i = 0; i < L; ++i) {
            a.polys[i].invntt();
        }
    }

    function matrix_expand(uint256 rho) public pure returns (PolyVecL[K] memory m) {
        for (uint256 i = 0; i < K; ++i) {
            for (uint256 j = 0; j < L; ++j) {
                m[i].polys[j].uniform(rho, uint16((i << 8) + j));
            }
        }
    }

    // Mutates w
    function mpointwise_acc(Polynomial.Poly memory w, PolyVecL memory u, PolyVecL memory v) public pure {
        Polynomial.Poly memory t;
        w.mpointwise(u.polys[0], v.polys[0]);
        for (uint256 i = 1; i < L; ++i) {
            t.mpointwise(u.polys[i], v.polys[i]);
            w.add(t);
        }
    }

    // Mutates t
    function matrix_mpointwise(PolyVecK memory t, PolyVecL[K] memory mat, PolyVecL memory v) public pure {
        for (uint256 i = 0; i < K; ++i) {
            mpointwise_acc(t.polys[i], mat[i], v);
        }
    }

    function matrix_mpointwise_empty(PolyVecL[K] memory mat, PolyVecL memory v)
        public
        pure
        returns (PolyVecK memory t)
    {
        for (uint256 i = 0; i < K; ++i) {
            mpointwise_acc(t.polys[i], mat[i], v);
        }
    }

    function poly_mpointwise(PolyVecK memory r, Polynomial.Poly memory a, PolyVecK memory v) public pure {
        for (uint256 i = 0; i < K; ++i) {
            r.polys[i].mpointwise(a, v.polys[i]);
        }
    }

    function shiftl(PolyVecK memory a) public pure {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i].shiftl();
        }
    }

    function sub(PolyVecK memory a, PolyVecK memory b) public pure {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i].sub(b.polys[i]);
        }
    }

    function reduce(PolyVecK memory a) public pure {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i].reduce();
        }
    }

    function caddq(PolyVecK memory a) public pure {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i].caddq();
        }
    }

    function use_hint(PolyVecK memory a, PolyVecK memory b) public pure {
        for (uint256 i = 0; i < K; ++i) {
            a.polys[i].use_hint(b.polys[i]);
        }
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
