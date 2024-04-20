// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "../Constants.sol";

contract Stream {
    struct State {
        bytes32 state;
    }

    function empty() public pure returns (State memory) {}

    function init(uint256 seed, uint16 nonce) public pure returns (State memory) {
        return State(keccak256(bytes.concat(bytes32(seed), bytes32(uint256(nonce)))));
    }

    function absorb(State memory st, bytes memory input) public pure returns (State memory) {
        st.state = keccak256(bytes.concat(st.state, input));
        return st;
    }

    function squeeze_bytes(State memory st, uint256 len) public pure returns (State memory, bytes memory) {
        unchecked {
            bytes memory buf;
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
                st.state = keccak256(bytes.concat(st.state));
            }
            return (st, buf);
        }
    }

    // n block = n * SHAKE128_RATE bytes
    function s128_squeeze_nblocks(State memory st, uint256 nblocks) public pure returns (State memory, bytes memory) {
        return squeeze_bytes(st, SHAKE128_RATE * nblocks);
    }

    // 1 block = SHAKE128_RATE bytes
    function s128_squeeze_block(State memory st) public pure returns (State memory, bytes memory) {
        return squeeze_bytes(st, SHAKE128_RATE);
    }

    // n block = n * SHAKE256_RATE bytes
    function s256_squeeze_nblocks(State memory st, uint256 nblocks) public pure returns (State memory, bytes memory) {
        return squeeze_bytes(st, SHAKE256_RATE * nblocks);
    }

    // 1 block = SHAKE256_RATE bytes
    function s256_squeeze_block(State memory st) public pure returns (State memory, bytes memory) {
        return squeeze_bytes(st, SHAKE256_RATE);
    }
}
