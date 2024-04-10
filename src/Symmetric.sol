// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "./Constants.sol";

library Stream {
    struct State {
        uint256 state;
    }

    function empty() public pure returns (State memory) {}

    function init(uint256 seed, uint16 nonce) public pure returns (State memory) {
        return State(uint256(keccak256(abi.encodePacked(seed, nonce))));
    }

    function absorb(State memory st, bytes memory input) public pure returns (State memory) {
        st.state = uint256(keccak256(abi.encodePacked(st.state, input)));
        return st;
    }

    // n block = n * SHAKE128_RATE bytes
    function s128_squeeze_nblocks(State memory st, uint256 nblocks) public pure returns (State memory, bytes memory) {
        bytes memory buf = new bytes(SHAKE128_RATE * nblocks);
        while (nblocks > 0) {
            for (uint256 i = 0; i < SHAKE128_RATE; i++) {
                for (uint256 j = 0; j < 8; j++) {
                    if (st.state == 0) {
                        st.state = uint256(keccak256(abi.encodePacked(st.state)));
                    }
                    buf[buf.length - 1 - i * 8 - j] = bytes1(uint8(st.state));
                    st.state >>= 8;
                }
            }
            nblocks -= 1;
        }
        return (st, buf);
    }

    // 1 block = SHAKE128_RATE bytes
    function s128_squeeze_block(State memory st) public pure returns (State memory, bytes memory) {
        bytes memory buf = new bytes(SHAKE128_RATE);
        for (uint256 i = 0; i < SHAKE128_RATE; i++) {
            for (uint256 j = 0; j < 8; j++) {
                if (st.state == 0) {
                    st.state = uint256(keccak256(abi.encodePacked(st.state)));
                }
                buf[buf.length - 1 - i * 8 - j] = bytes1(uint8(st.state));
                st.state >>= 8;
            }
        }
        return (st, buf);
    }

    // n block = n * SHAKE256_RATE bytes
    function s256_squeeze_nblocks(State memory st, uint256 nblocks) public pure returns (State memory, bytes memory) {
        bytes memory buf = new bytes(SHAKE256_RATE * nblocks);
        while (nblocks > 0) {
            for (uint256 i = 0; i < SHAKE256_RATE; i++) {
                for (uint256 j = 0; j < 8; j++) {
                    if (st.state == 0) {
                        st.state = uint256(keccak256(abi.encodePacked(st.state)));
                    }
                    buf[buf.length - 1 - i * 8 - j] = bytes1(uint8(st.state));
                    st.state >>= 8;
                }
            }
            nblocks -= 1;
        }
        return (st, buf);
    }

    // 1 block = SHAKE256_RATE bytes
    function s256_squeeze_block(State memory st) public pure returns (State memory, bytes memory) {
        bytes memory buf = new bytes(SHAKE256_RATE);
        for (uint256 i = 0; i < SHAKE256_RATE; i++) {
            for (uint256 j = 0; j < 8; j++) {
                if (st.state == 0) {
                    st.state = uint256(keccak256(abi.encodePacked(st.state)));
                }
                buf[buf.length - 1 - i * 8 - j] = bytes1(uint8(st.state));
                st.state >>= 8;
            }
        }
        return (st, buf);
    }
}
