// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

uint256 constant N = 256;
uint256 constant N_256 = 32; // N / 8
uint256 constant D = 13;

uint256 constant CRHBYTES = 64;
uint256 constant SEEDBYTES = 32;
uint256 constant PUBLIC_KEY_BYTES = SEEDBYTES + K * POLYT1_PACKEDBYTES;
uint256 constant SIG_BYTES = SEEDBYTES + L * POLYZ_PACKEDBYTES + POLYVECH_PACKEDBYTES;

// Dilithium mode-2
uint256 constant OMEGA = 80;
uint8 constant OMEGA_U8 = 80;
uint256 constant K = 4;
uint256 constant L = 4;
uint256 constant TAU = 39;
uint256 constant GAMMA1 = 1 << 17;
uint256 constant GAMMA2 = 95232; // ( Q - 1 ) / 88
int32 constant GAMMA1_I32 = 1 << 17;
int32 constant GAMMA2_I32 = 95232;
uint256 constant BETA = 78;
uint256 constant POLYW1_PACKEDBYTES = 192;
uint256 constant POLYT1_PACKEDBYTES = 320;
uint256 constant POLYVECH_PACKEDBYTES = OMEGA + K;
uint256 constant POLYZ_PACKEDBYTES = 576;

uint256 constant SHAKE128_RATE = 168;
uint256 constant SHAKE256_RATE = 136;
uint256 constant STREAM128_BLOCKBYTES = SHAKE128_RATE;
uint256 constant STREAM256_BLOCKBYTES = SHAKE256_RATE;

int64 constant Q = 8380417;
uint32 constant Q_U32 = 8380417;
int32 constant Q_I32 = 8380417;
int32 constant QINV = 58728449;
int64 constant F = 41978;
