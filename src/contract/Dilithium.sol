// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "../Constants.sol";
import "./Packing.sol";
import "./Poly.sol";
import "./PolyVec.sol";

contract Dilithium {
    Polynomial immutable _poly;
    PolynomialVector immutable _polyvec;
    Packing immutable _packing;

    constructor(Polynomial __poly, PolynomialVector __polyvec, Packing __packing) {
        _poly = __poly;
        _polyvec = __polyvec;
        _packing = __packing;
    }

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

    function expand(PublicKey memory pk) public view returns (ExpandedPublicKey memory epk) {
        epk.packed = keccak256(_packing.pack(pk));
        epk.t1 = _polyvec.clone_k(pk.t1);
        epk.t1 = _polyvec.shiftl(epk.t1);
        epk.t1 = _polyvec.ntt_k(epk.t1);
        epk.mat = _polyvec.matrix_expand(pk.rho);
    }

    function verifyExpanded(Signature memory sig, ExpandedPublicKey memory pk, bytes memory m)
        public
        view
        returns (bool)
    {
        bytes32 mul = keccak256(bytes.concat(pk.packed, m));
        bytes32 mur = keccak256(bytes.concat(mul));

        if (_polyvec.chknorm(sig.z, int32(int256(GAMMA1 - BETA)))) {
            return false;
        }
        Polynomial.Poly memory cp = _poly.challenge(sig.c);
        sig.z = _polyvec.ntt_l(sig.z);
        PolynomialVector.PolyVecK memory w1 = _polyvec.matrix_mpointwise(pk.mat, sig.z);
        cp = _poly.ntt(cp);
        pk.t1 = _polyvec.poly_mpointwise(cp, pk.t1);
        w1 = _polyvec.sub(w1, pk.t1);
        w1 = _polyvec.reduce(w1);
        w1 = _polyvec.invntt_k(w1);

        w1 = _polyvec.caddq(w1);
        w1 = _polyvec.use_hint(w1, sig.h);
        bytes memory buf = _polyvec.pack_w1(w1);

        bytes32 c2 = keccak256(bytes.concat(mul, mur, buf));

        return c2 == sig.c;
    }

    function verify(Signature memory sig, PublicKey memory pk, bytes memory m) public view returns (bool) {
        ExpandedPublicKey memory epk = expand(pk);
        return verifyExpanded(sig, epk, m);
    }
}
