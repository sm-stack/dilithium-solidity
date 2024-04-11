// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/Constants.sol";
import "../src/Dilithium.sol";

contract DilithiumGasTracker {
    function verify(Dilithium.Signature memory sig, Dilithium.PublicKey memory pk, bytes32 m)
        public
        pure
        returns (bool)
    {
        return Dilithium.verify(sig, pk, m);
    }
}

contract DilithiumTest is Test {
    DilithiumGasTracker tracker;

    function setUp() public {
        tracker = new DilithiumGasTracker();
    }

    function test_verify() public view {
        uint256 a = 2345;
        uint16 b = 23;
        console2.logBytes(abi.encode(a, b));
        Dilithium.PublicKey memory pk;
        Dilithium.Signature memory sig;
        bytes32 m = 0;

        bool _result = tracker.verify(sig, pk, m);
        _result;
    }
}