// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

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
        bytes memory _rho;
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
}
