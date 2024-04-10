// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

uint256 constant N = 256;
uint256 constant N_256 = 32; // N / 8
uint256 constant D = 13;

// Dilithium mode-2
uint256 constant K = 4;
uint256 constant L = 4;
uint256 constant TAU = 39;

uint256 constant SHAKE128_RATE = 168;
uint256 constant SHAKE256_RATE = 136;
uint256 constant STREAM128_BLOCKBYTES = SHAKE128_RATE;
uint256 constant STREAM256_BLOCKBYTES = SHAKE256_RATE;

int64 constant Q = 8380417;
uint32 constant Q_U32 = 8380417;
int32 constant QINV = 58728449;
int64 constant F = 41978;
