// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";
import "./Reduce.sol";

library Polynomials {
    struct Poly {
        int32[N] coeffs;
    }

    function reduce(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        for (uint i = 0; i < N; i++) {
            t.coeffs[i] = reduce32(a.coeffs[i]);
        }
        return t;
    }

    function caddq(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        for (uint i = 0; i < N; i++) {
            t.coeffs[i] = caddq32(a.coeffs[i]);
        }
        return t;
    }

    function add(
        Poly memory a,
        Poly memory b
    ) public pure returns (Poly memory) {
        Poly memory t;
        for (uint i = 0; i < N; i++) {
            t.coeffs[i] = a.coeffs[i] + b.coeffs[i];
        }
        return t;
    }

    function sub(
        Poly memory a,
        Poly memory b
    ) public pure returns (Poly memory) {
        Poly memory t;
        for (uint i = 0; i < N; i++) {
            t.coeffs[i] = a.coeffs[i] - b.coeffs[i];
        }
        return t;
    }

    function shiftl(Poly memory a) public pure returns (Poly memory) {
        Poly memory t;
        for (uint i = 0; i < N; i++) {
            t.coeffs[i] = a.coeffs[i] << uint32(D);
        }
        return t;
    }
}
