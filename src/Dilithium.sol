// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";
import "./Poly.sol";
import "./PolyVec.sol";
import "./Symmetric.sol";

library Dilithium {
    using Polynomial for Polynomial.Poly;
    using PolynomialVector for PolynomialVector.PolyVecK;
    using PolynomialVector for PolynomialVector.PolyVecL;
    using Stream for Stream.State;

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

    function verify(Signature memory sig, PublicKey memory pk, bytes32 m) public pure returns (bool) {
        Stream.State memory mustate = Stream.empty();
        mustate.absorb(abi.encode(pk));
        mustate.absorb(abi.encodePacked(m));
        bytes memory mu = mustate.squeeze_bytes(CRHBYTES);

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

        Stream.State memory cstate = Stream.empty();
        cstate.absorb(mu);
        cstate.absorb(buf);
        bytes memory c2b = cstate.squeeze_bytes(32);
        uint256 c2us = uint256(bytes32(c2b));

        return c2us == sig.c;
    }
}
