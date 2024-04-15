// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/console2.sol";
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
        bytes32 packed;
        PolynomialVector.PolyVecL[K] mat;
        PolynomialVector.PolyVecK t1;
    }

    struct Signature {
        bytes32 c;
        PolynomialVector.PolyVecL z;
        PolynomialVector.PolyVecK h;
    }

    function expand(PublicKey memory pk) public pure returns (ExpandedPublicKey memory epk) {
        epk.packed = keccak256(pk.pack());
        epk.t1 = pk.t1.clone();
        epk.t1 = epk.t1.shiftl();
        epk.t1 = epk.t1.ntt();
        epk.mat = PolynomialVector.matrix_expand(pk.rho);
    }

    function verifyExpanded(Signature memory sig, ExpandedPublicKey memory pk, bytes memory m)
        public
        pure
        returns (bool)
    {
        bytes32 mul = keccak256(bytes.concat(pk.packed, m));
        bytes32 mur = keccak256(bytes.concat(mul));

        if (sig.z.chknorm(int32(int256(GAMMA1 - BETA)))) {
            return false;
        }
        Polynomial.Poly memory cp = Polynomial.challenge(sig.c);
        sig.z = sig.z.ntt();
        PolynomialVector.PolyVecK memory w1 = PolynomialVector.matrix_mpointwise(pk.mat, sig.z);
        cp = cp.ntt();
        pk.t1 = PolynomialVector.poly_mpointwise(cp, pk.t1);
        w1 = w1.sub(pk.t1);
        w1 = w1.reduce();
        w1 = w1.invntt();

        w1 = w1.caddq();
        w1 = w1.use_hint(sig.h);
        bytes memory buf = w1.pack_w1();

        bytes32 c2 = keccak256(bytes.concat(mul, mur, buf));

        return c2 == sig.c;
    }

    function verify(Signature memory sig, PublicKey memory pk, bytes memory m) public pure returns (bool) {
        bytes32 mul = keccak256(bytes.concat(keccak256(pk.pack()), m));
        bytes32 mur = keccak256(bytes.concat(mul));

        if (sig.z.chknorm(int32(int256(GAMMA1 - BETA)))) {
            return false;
        }
        Polynomial.Poly memory cp = Polynomial.challenge(sig.c);
        PolynomialVector.PolyVecL[K] memory mat = PolynomialVector.matrix_expand(pk.rho);
        sig.z = sig.z.ntt();
        PolynomialVector.PolyVecK memory w1 = PolynomialVector.matrix_mpointwise(mat, sig.z);
        cp = cp.ntt();
        pk.t1 = pk.t1.shiftl();
        pk.t1 = pk.t1.ntt();
        pk.t1 = PolynomialVector.poly_mpointwise(cp, pk.t1);
        w1 = w1.sub(pk.t1);
        w1 = w1.reduce();
        w1 = w1.invntt();

        w1 = w1.caddq();
        w1 = w1.use_hint(sig.h);
        bytes memory buf = w1.pack_w1();

        bytes32 c2 = keccak256(bytes.concat(mul, mur, buf));

        return c2 == sig.c;
    }
}
