// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";
import "./Poly.sol";
import "./PolyVec.sol";
import "./Symmetric.sol";
import "./Packing.sol";

library Dilithium {
    using Polynomial for Polynomial.Poly;
    using PolynomialVector for PolynomialVector.PolyVecK;
    using PolynomialVector for PolynomialVector.PolyVecL;
    using Stream for Stream.State;
    using Packing for PublicKey;

    struct PublicKey {
        uint256 rho;
        PolynomialVector.PolyVecK t1;
    }

    struct ExpandedPublicKey {
        PolynomialVector.PolyVecL[K] rho;
        PolynomialVector.PolyVecK t1;
        PolynomialVector.PolyVecK t1_2;
    }

    struct Signature {
        uint256 c;
        PolynomialVector.PolyVecL z;
        PolynomialVector.PolyVecK h;
    }

    function verify(Signature memory sig, PublicKey memory pk, bytes memory m) public pure returns (bool) {
        bytes32 mu = keccak256(bytes.concat(keccak256(pk.pack()), m));

        if (sig.z.chknorm(int32(int256(GAMMA1 - BETA)))) {
            return false;
        }

        Polynomial.Poly memory cp = Polynomial.challenge(sig.c);
        PolynomialVector.PolyVecL[K] memory mat = PolynomialVector.matrix_expand(pk.rho);
        sig.z.ntt();
        PolynomialVector.PolyVecK memory w1 = PolynomialVector.matrix_mpointwise_empty(mat, sig.z);
        cp.ntt();
        pk.t1.shiftl();
        pk.t1.ntt();
        PolynomialVector.PolyVecK memory t1_2 = pk.t1.clone();
        pk.t1.poly_mpointwise(cp, t1_2);
        w1.sub(pk.t1);
        w1.reduce();
        w1.invntt();

        w1.caddq();
        w1.use_hint(sig.h);
        bytes memory buf = w1.pack_w1();

        uint256 c2 = uint256(keccak256(bytes.concat(mu, buf)));

        return c2 == sig.c;
    }
}
