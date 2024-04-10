// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";

library Stream {
    struct State {
        bytes32 state;
    }

    function empty() public pure returns (State memory) {}

    function init(uint256 seed, uint16 nonce) public pure returns (State memory) {
        return State(keccak256(abi.encodePacked(seed, nonce)));
    }

    function absorb(State memory st, bytes memory input) public pure {
        st.state = keccak256(abi.encodePacked(st.state, input));
    }

    function squeeze_bytes(State memory st, uint256 len) public pure returns (bytes memory) {
        bytes memory buf = new bytes(0);
        while (len > 0) {
            if (len < 32) {
                bytes memory left = new bytes(len);
                for (uint256 i = 0; i < len; i++) {
                    left[i] = st.state[i];
                }
                buf = bytes.concat(buf, left);
                len = 0;
            } else {
                buf = bytes.concat(buf, st.state);
                len -= 32;
            }
            st.state = keccak256(abi.encodePacked(st.state));
        }
        return buf;
    }

    // n block = n * SHAKE128_RATE bytes
    function s128_squeeze_nblocks(State memory st, uint256 nblocks) public pure returns (bytes memory) {
        return squeeze_bytes(st, SHAKE128_RATE * nblocks);
    }

    // 1 block = SHAKE128_RATE bytes
    function s128_squeeze_block(State memory st) public pure returns (bytes memory) {
        return squeeze_bytes(st, SHAKE128_RATE);
    }

    // n block = n * SHAKE256_RATE bytes
    function s256_squeeze_nblocks(State memory st, uint256 nblocks) public pure returns (bytes memory) {
        return squeeze_bytes(st, SHAKE256_RATE * nblocks);
    }

    // 1 block = SHAKE256_RATE bytes
    function s256_squeeze_block(State memory st) public pure returns (bytes memory) {
        return squeeze_bytes(st, SHAKE256_RATE);
    }
}
