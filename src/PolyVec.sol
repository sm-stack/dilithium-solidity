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

    function matrix_expand(uint256 rho) public pure returns (PolyVecL[K] memory m) {
        for (uint256 i = 0; i < K; ++i) {
            for (uint256 j = 0; j < L; ++j) {
                m[i].polys[j] = m[i].polys[j].uniform(rho, uint16((i << 8) + j));
            }
        }
    }
}
