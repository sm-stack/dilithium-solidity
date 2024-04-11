// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/console2.sol";
import "./Constants.sol";
import "./Dilithium.sol";
import "./Poly.sol";

library Packing {
    using Polynomial for Polynomial.Poly;
    using Polynomial for bytes;

    function pack(Dilithium.PublicKey memory pk) public pure returns (bytes memory) {
        bytes memory buf;
        buf = bytes.concat(buf, bytes32(pk.rho));
        for (uint256 i = 0; i < K; i++) {
            buf = bytes.concat(buf, pk.t1.polys[i].pack_t1());
        }
        return buf;
    }

    function unpack_pk(bytes memory _pk) public pure returns (Dilithium.PublicKey memory pk) {
        bytes memory _rho = new bytes(32);
        for (uint256 i = 0; i < 32; i++) {
            _rho[i] = _pk[i];
        }
        pk.rho = uint256(bytes32(_rho));
        for (uint256 i = 0; i < K; i++) {
            bytes memory buf = new bytes(POLYT1_PACKEDBYTES);
            for (uint256 j = 0; j < POLYT1_PACKEDBYTES; j++) {
                buf[j] = _pk[32 + i * POLYT1_PACKEDBYTES + j];
            }
            pk.t1.polys[i] = buf.unpack_t1();
        }
    }

    function unpack_sig(bytes memory _sig) public view returns (Dilithium.Signature memory sig) {
        bytes memory _c = new bytes(32);
        for (uint256 i = 0; i < 32; ++i) {
            _c[i] = _sig[i];
        }
        sig.c = uint256(bytes32(_c));

        uint256 index = 32;

        for (uint256 i = 0; i < L; ++i) {
            bytes memory buf = new bytes(POLYZ_PACKEDBYTES);
            for (uint256 j = 0; j < POLYZ_PACKEDBYTES; j++) {
                buf[j] = _sig[index + j];
            }
            sig.z.polys[i] = buf.unpack_z();
            index += POLYZ_PACKEDBYTES;
        }

        index = 32 + L * POLYZ_PACKEDBYTES;

        uint8 k = 0;
        for (uint256 i = 0; i < K; ++i) {
            uint8 sigidxoi = uint8(_sig[index + OMEGA + i]);

            if (sigidxoi < k || sigidxoi > OMEGA_U8) {
                revert("invalid signature, omega");
            }

            for (uint256 j = k; j < sigidxoi; ++j) {
                if (j > k && _sig[index + j] <= _sig[index + j - 1]) {
                    revert("invalid signature, not ordered");
                }

                sig.h.polys[i].coeffs[uint8(_sig[index + j])] = 1;
            }

            k = sigidxoi;
        }

        for (uint8 j = k; j < OMEGA_U8; ++j) {
            if (_sig[index + j] > 0) {
                revert("invalid signature, extra indices not zero");
            }
        }
    }
}
