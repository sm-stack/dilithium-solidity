// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/console2.sol";
import "./Constants.sol";
import "./Reduce.sol";
import "./Symmetric.sol";
import "./Sampler.sol";
import {use_hint as use_hint_internal} from "./Rounding.sol";
import {ntt as ntt_internal, invntt as invntt_internal} from "./Ntt.sol";

library Polynomial {
    using Stream for Stream.State;

    struct Poly {
        int32[N] coeffs;
    }

    function log(Poly memory a) public pure {
        console2.log("Poly");
        for (uint256 i = 0; i < N; i++) {
            console2.logInt(a.coeffs[i]);
        }
    }

    function clone(Poly memory a) public pure returns (Poly memory b) {
        for (uint256 i = 0; i < N; i++) {
            b.coeffs[i] = a.coeffs[i];
        }
        return b;
    }

    function reduce(Poly memory a) public pure returns (Poly memory) {
        unchecked {
            {
                int32 at = a.coeffs[0];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[0] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[1];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[1] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[2];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[2] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[3];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[3] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[4];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[4] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[5];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[5] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[6];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[6] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[7];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[7] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[8];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[8] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[9];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[9] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[10];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[10] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[11];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[11] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[12];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[12] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[13];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[13] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[14];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[14] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[15];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[15] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[16];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[16] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[17];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[17] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[18];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[18] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[19];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[19] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[20];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[20] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[21];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[21] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[22];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[22] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[23];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[23] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[24];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[24] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[25];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[25] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[26];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[26] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[27];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[27] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[28];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[28] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[29];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[29] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[30];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[30] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[31];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[31] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[32];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[32] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[33];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[33] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[34];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[34] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[35];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[35] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[36];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[36] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[37];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[37] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[38];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[38] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[39];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[39] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[40];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[40] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[41];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[41] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[42];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[42] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[43];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[43] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[44];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[44] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[45];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[45] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[46];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[46] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[47];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[47] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[48];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[48] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[49];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[49] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[50];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[50] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[51];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[51] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[52];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[52] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[53];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[53] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[54];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[54] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[55];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[55] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[56];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[56] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[57];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[57] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[58];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[58] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[59];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[59] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[60];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[60] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[61];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[61] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[62];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[62] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[63];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[63] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[64];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[64] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[65];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[65] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[66];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[66] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[67];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[67] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[68];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[68] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[69];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[69] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[70];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[70] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[71];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[71] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[72];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[72] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[73];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[73] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[74];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[74] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[75];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[75] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[76];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[76] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[77];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[77] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[78];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[78] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[79];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[79] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[80];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[80] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[81];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[81] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[82];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[82] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[83];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[83] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[84];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[84] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[85];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[85] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[86];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[86] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[87];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[87] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[88];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[88] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[89];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[89] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[90];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[90] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[91];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[91] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[92];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[92] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[93];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[93] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[94];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[94] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[95];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[95] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[96];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[96] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[97];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[97] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[98];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[98] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[99];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[99] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[100];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[100] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[101];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[101] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[102];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[102] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[103];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[103] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[104];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[104] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[105];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[105] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[106];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[106] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[107];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[107] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[108];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[108] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[109];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[109] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[110];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[110] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[111];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[111] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[112];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[112] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[113];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[113] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[114];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[114] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[115];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[115] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[116];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[116] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[117];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[117] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[118];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[118] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[119];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[119] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[120];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[120] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[121];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[121] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[122];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[122] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[123];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[123] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[124];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[124] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[125];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[125] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[126];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[126] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[127];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[127] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[128];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[128] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[129];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[129] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[130];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[130] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[131];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[131] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[132];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[132] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[133];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[133] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[134];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[134] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[135];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[135] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[136];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[136] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[137];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[137] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[138];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[138] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[139];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[139] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[140];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[140] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[141];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[141] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[142];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[142] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[143];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[143] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[144];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[144] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[145];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[145] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[146];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[146] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[147];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[147] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[148];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[148] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[149];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[149] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[150];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[150] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[151];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[151] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[152];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[152] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[153];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[153] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[154];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[154] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[155];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[155] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[156];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[156] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[157];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[157] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[158];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[158] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[159];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[159] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[160];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[160] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[161];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[161] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[162];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[162] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[163];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[163] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[164];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[164] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[165];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[165] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[166];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[166] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[167];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[167] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[168];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[168] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[169];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[169] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[170];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[170] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[171];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[171] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[172];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[172] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[173];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[173] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[174];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[174] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[175];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[175] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[176];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[176] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[177];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[177] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[178];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[178] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[179];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[179] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[180];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[180] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[181];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[181] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[182];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[182] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[183];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[183] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[184];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[184] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[185];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[185] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[186];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[186] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[187];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[187] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[188];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[188] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[189];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[189] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[190];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[190] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[191];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[191] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[192];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[192] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[193];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[193] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[194];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[194] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[195];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[195] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[196];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[196] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[197];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[197] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[198];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[198] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[199];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[199] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[200];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[200] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[201];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[201] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[202];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[202] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[203];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[203] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[204];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[204] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[205];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[205] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[206];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[206] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[207];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[207] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[208];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[208] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[209];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[209] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[210];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[210] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[211];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[211] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[212];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[212] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[213];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[213] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[214];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[214] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[215];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[215] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[216];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[216] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[217];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[217] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[218];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[218] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[219];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[219] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[220];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[220] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[221];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[221] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[222];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[222] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[223];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[223] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[224];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[224] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[225];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[225] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[226];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[226] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[227];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[227] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[228];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[228] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[229];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[229] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[230];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[230] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[231];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[231] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[232];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[232] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[233];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[233] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[234];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[234] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[235];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[235] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[236];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[236] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[237];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[237] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[238];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[238] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[239];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[239] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[240];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[240] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[241];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[241] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[242];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[242] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[243];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[243] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[244];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[244] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[245];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[245] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[246];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[246] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[247];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[247] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[248];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[248] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[249];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[249] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[250];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[250] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[251];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[251] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[252];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[252] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[253];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[253] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[254];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[254] = at - t * Q_I32;
            }
            {
                int32 at = a.coeffs[255];
                int32 t = (at + 4194304) >> 23;
                a.coeffs[255] = at - t * Q_I32;
            }
            return a;
        }
    }

    function caddq(Poly memory a) public pure returns (Poly memory) {
        unchecked {
            {
                int32 t = a.coeffs[0];
                a.coeffs[0] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[1];
                a.coeffs[1] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[2];
                a.coeffs[2] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[3];
                a.coeffs[3] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[4];
                a.coeffs[4] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[5];
                a.coeffs[5] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[6];
                a.coeffs[6] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[7];
                a.coeffs[7] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[8];
                a.coeffs[8] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[9];
                a.coeffs[9] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[10];
                a.coeffs[10] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[11];
                a.coeffs[11] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[12];
                a.coeffs[12] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[13];
                a.coeffs[13] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[14];
                a.coeffs[14] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[15];
                a.coeffs[15] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[16];
                a.coeffs[16] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[17];
                a.coeffs[17] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[18];
                a.coeffs[18] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[19];
                a.coeffs[19] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[20];
                a.coeffs[20] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[21];
                a.coeffs[21] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[22];
                a.coeffs[22] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[23];
                a.coeffs[23] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[24];
                a.coeffs[24] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[25];
                a.coeffs[25] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[26];
                a.coeffs[26] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[27];
                a.coeffs[27] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[28];
                a.coeffs[28] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[29];
                a.coeffs[29] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[30];
                a.coeffs[30] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[31];
                a.coeffs[31] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[32];
                a.coeffs[32] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[33];
                a.coeffs[33] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[34];
                a.coeffs[34] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[35];
                a.coeffs[35] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[36];
                a.coeffs[36] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[37];
                a.coeffs[37] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[38];
                a.coeffs[38] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[39];
                a.coeffs[39] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[40];
                a.coeffs[40] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[41];
                a.coeffs[41] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[42];
                a.coeffs[42] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[43];
                a.coeffs[43] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[44];
                a.coeffs[44] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[45];
                a.coeffs[45] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[46];
                a.coeffs[46] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[47];
                a.coeffs[47] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[48];
                a.coeffs[48] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[49];
                a.coeffs[49] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[50];
                a.coeffs[50] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[51];
                a.coeffs[51] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[52];
                a.coeffs[52] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[53];
                a.coeffs[53] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[54];
                a.coeffs[54] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[55];
                a.coeffs[55] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[56];
                a.coeffs[56] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[57];
                a.coeffs[57] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[58];
                a.coeffs[58] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[59];
                a.coeffs[59] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[60];
                a.coeffs[60] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[61];
                a.coeffs[61] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[62];
                a.coeffs[62] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[63];
                a.coeffs[63] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[64];
                a.coeffs[64] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[65];
                a.coeffs[65] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[66];
                a.coeffs[66] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[67];
                a.coeffs[67] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[68];
                a.coeffs[68] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[69];
                a.coeffs[69] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[70];
                a.coeffs[70] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[71];
                a.coeffs[71] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[72];
                a.coeffs[72] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[73];
                a.coeffs[73] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[74];
                a.coeffs[74] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[75];
                a.coeffs[75] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[76];
                a.coeffs[76] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[77];
                a.coeffs[77] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[78];
                a.coeffs[78] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[79];
                a.coeffs[79] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[80];
                a.coeffs[80] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[81];
                a.coeffs[81] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[82];
                a.coeffs[82] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[83];
                a.coeffs[83] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[84];
                a.coeffs[84] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[85];
                a.coeffs[85] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[86];
                a.coeffs[86] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[87];
                a.coeffs[87] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[88];
                a.coeffs[88] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[89];
                a.coeffs[89] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[90];
                a.coeffs[90] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[91];
                a.coeffs[91] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[92];
                a.coeffs[92] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[93];
                a.coeffs[93] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[94];
                a.coeffs[94] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[95];
                a.coeffs[95] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[96];
                a.coeffs[96] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[97];
                a.coeffs[97] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[98];
                a.coeffs[98] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[99];
                a.coeffs[99] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[100];
                a.coeffs[100] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[101];
                a.coeffs[101] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[102];
                a.coeffs[102] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[103];
                a.coeffs[103] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[104];
                a.coeffs[104] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[105];
                a.coeffs[105] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[106];
                a.coeffs[106] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[107];
                a.coeffs[107] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[108];
                a.coeffs[108] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[109];
                a.coeffs[109] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[110];
                a.coeffs[110] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[111];
                a.coeffs[111] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[112];
                a.coeffs[112] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[113];
                a.coeffs[113] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[114];
                a.coeffs[114] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[115];
                a.coeffs[115] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[116];
                a.coeffs[116] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[117];
                a.coeffs[117] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[118];
                a.coeffs[118] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[119];
                a.coeffs[119] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[120];
                a.coeffs[120] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[121];
                a.coeffs[121] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[122];
                a.coeffs[122] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[123];
                a.coeffs[123] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[124];
                a.coeffs[124] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[125];
                a.coeffs[125] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[126];
                a.coeffs[126] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[127];
                a.coeffs[127] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[128];
                a.coeffs[128] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[129];
                a.coeffs[129] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[130];
                a.coeffs[130] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[131];
                a.coeffs[131] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[132];
                a.coeffs[132] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[133];
                a.coeffs[133] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[134];
                a.coeffs[134] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[135];
                a.coeffs[135] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[136];
                a.coeffs[136] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[137];
                a.coeffs[137] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[138];
                a.coeffs[138] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[139];
                a.coeffs[139] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[140];
                a.coeffs[140] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[141];
                a.coeffs[141] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[142];
                a.coeffs[142] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[143];
                a.coeffs[143] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[144];
                a.coeffs[144] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[145];
                a.coeffs[145] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[146];
                a.coeffs[146] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[147];
                a.coeffs[147] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[148];
                a.coeffs[148] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[149];
                a.coeffs[149] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[150];
                a.coeffs[150] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[151];
                a.coeffs[151] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[152];
                a.coeffs[152] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[153];
                a.coeffs[153] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[154];
                a.coeffs[154] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[155];
                a.coeffs[155] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[156];
                a.coeffs[156] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[157];
                a.coeffs[157] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[158];
                a.coeffs[158] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[159];
                a.coeffs[159] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[160];
                a.coeffs[160] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[161];
                a.coeffs[161] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[162];
                a.coeffs[162] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[163];
                a.coeffs[163] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[164];
                a.coeffs[164] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[165];
                a.coeffs[165] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[166];
                a.coeffs[166] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[167];
                a.coeffs[167] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[168];
                a.coeffs[168] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[169];
                a.coeffs[169] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[170];
                a.coeffs[170] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[171];
                a.coeffs[171] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[172];
                a.coeffs[172] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[173];
                a.coeffs[173] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[174];
                a.coeffs[174] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[175];
                a.coeffs[175] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[176];
                a.coeffs[176] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[177];
                a.coeffs[177] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[178];
                a.coeffs[178] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[179];
                a.coeffs[179] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[180];
                a.coeffs[180] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[181];
                a.coeffs[181] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[182];
                a.coeffs[182] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[183];
                a.coeffs[183] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[184];
                a.coeffs[184] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[185];
                a.coeffs[185] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[186];
                a.coeffs[186] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[187];
                a.coeffs[187] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[188];
                a.coeffs[188] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[189];
                a.coeffs[189] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[190];
                a.coeffs[190] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[191];
                a.coeffs[191] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[192];
                a.coeffs[192] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[193];
                a.coeffs[193] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[194];
                a.coeffs[194] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[195];
                a.coeffs[195] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[196];
                a.coeffs[196] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[197];
                a.coeffs[197] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[198];
                a.coeffs[198] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[199];
                a.coeffs[199] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[200];
                a.coeffs[200] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[201];
                a.coeffs[201] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[202];
                a.coeffs[202] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[203];
                a.coeffs[203] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[204];
                a.coeffs[204] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[205];
                a.coeffs[205] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[206];
                a.coeffs[206] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[207];
                a.coeffs[207] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[208];
                a.coeffs[208] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[209];
                a.coeffs[209] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[210];
                a.coeffs[210] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[211];
                a.coeffs[211] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[212];
                a.coeffs[212] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[213];
                a.coeffs[213] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[214];
                a.coeffs[214] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[215];
                a.coeffs[215] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[216];
                a.coeffs[216] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[217];
                a.coeffs[217] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[218];
                a.coeffs[218] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[219];
                a.coeffs[219] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[220];
                a.coeffs[220] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[221];
                a.coeffs[221] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[222];
                a.coeffs[222] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[223];
                a.coeffs[223] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[224];
                a.coeffs[224] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[225];
                a.coeffs[225] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[226];
                a.coeffs[226] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[227];
                a.coeffs[227] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[228];
                a.coeffs[228] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[229];
                a.coeffs[229] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[230];
                a.coeffs[230] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[231];
                a.coeffs[231] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[232];
                a.coeffs[232] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[233];
                a.coeffs[233] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[234];
                a.coeffs[234] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[235];
                a.coeffs[235] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[236];
                a.coeffs[236] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[237];
                a.coeffs[237] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[238];
                a.coeffs[238] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[239];
                a.coeffs[239] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[240];
                a.coeffs[240] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[241];
                a.coeffs[241] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[242];
                a.coeffs[242] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[243];
                a.coeffs[243] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[244];
                a.coeffs[244] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[245];
                a.coeffs[245] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[246];
                a.coeffs[246] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[247];
                a.coeffs[247] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[248];
                a.coeffs[248] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[249];
                a.coeffs[249] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[250];
                a.coeffs[250] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[251];
                a.coeffs[251] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[252];
                a.coeffs[252] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[253];
                a.coeffs[253] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[254];
                a.coeffs[254] = t + ((t >> 31) & Q_I32);
            }
            {
                int32 t = a.coeffs[255];
                a.coeffs[255] = t + ((t >> 31) & Q_I32);
            }
            return a;
        }
    }

    function add(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        unchecked {
            a.coeffs[0] = a.coeffs[0] + b.coeffs[0];
            a.coeffs[1] = a.coeffs[1] + b.coeffs[1];
            a.coeffs[2] = a.coeffs[2] + b.coeffs[2];
            a.coeffs[3] = a.coeffs[3] + b.coeffs[3];
            a.coeffs[4] = a.coeffs[4] + b.coeffs[4];
            a.coeffs[5] = a.coeffs[5] + b.coeffs[5];
            a.coeffs[6] = a.coeffs[6] + b.coeffs[6];
            a.coeffs[7] = a.coeffs[7] + b.coeffs[7];
            a.coeffs[8] = a.coeffs[8] + b.coeffs[8];
            a.coeffs[9] = a.coeffs[9] + b.coeffs[9];
            a.coeffs[10] = a.coeffs[10] + b.coeffs[10];
            a.coeffs[11] = a.coeffs[11] + b.coeffs[11];
            a.coeffs[12] = a.coeffs[12] + b.coeffs[12];
            a.coeffs[13] = a.coeffs[13] + b.coeffs[13];
            a.coeffs[14] = a.coeffs[14] + b.coeffs[14];
            a.coeffs[15] = a.coeffs[15] + b.coeffs[15];
            a.coeffs[16] = a.coeffs[16] + b.coeffs[16];
            a.coeffs[17] = a.coeffs[17] + b.coeffs[17];
            a.coeffs[18] = a.coeffs[18] + b.coeffs[18];
            a.coeffs[19] = a.coeffs[19] + b.coeffs[19];
            a.coeffs[20] = a.coeffs[20] + b.coeffs[20];
            a.coeffs[21] = a.coeffs[21] + b.coeffs[21];
            a.coeffs[22] = a.coeffs[22] + b.coeffs[22];
            a.coeffs[23] = a.coeffs[23] + b.coeffs[23];
            a.coeffs[24] = a.coeffs[24] + b.coeffs[24];
            a.coeffs[25] = a.coeffs[25] + b.coeffs[25];
            a.coeffs[26] = a.coeffs[26] + b.coeffs[26];
            a.coeffs[27] = a.coeffs[27] + b.coeffs[27];
            a.coeffs[28] = a.coeffs[28] + b.coeffs[28];
            a.coeffs[29] = a.coeffs[29] + b.coeffs[29];
            a.coeffs[30] = a.coeffs[30] + b.coeffs[30];
            a.coeffs[31] = a.coeffs[31] + b.coeffs[31];
            a.coeffs[32] = a.coeffs[32] + b.coeffs[32];
            a.coeffs[33] = a.coeffs[33] + b.coeffs[33];
            a.coeffs[34] = a.coeffs[34] + b.coeffs[34];
            a.coeffs[35] = a.coeffs[35] + b.coeffs[35];
            a.coeffs[36] = a.coeffs[36] + b.coeffs[36];
            a.coeffs[37] = a.coeffs[37] + b.coeffs[37];
            a.coeffs[38] = a.coeffs[38] + b.coeffs[38];
            a.coeffs[39] = a.coeffs[39] + b.coeffs[39];
            a.coeffs[40] = a.coeffs[40] + b.coeffs[40];
            a.coeffs[41] = a.coeffs[41] + b.coeffs[41];
            a.coeffs[42] = a.coeffs[42] + b.coeffs[42];
            a.coeffs[43] = a.coeffs[43] + b.coeffs[43];
            a.coeffs[44] = a.coeffs[44] + b.coeffs[44];
            a.coeffs[45] = a.coeffs[45] + b.coeffs[45];
            a.coeffs[46] = a.coeffs[46] + b.coeffs[46];
            a.coeffs[47] = a.coeffs[47] + b.coeffs[47];
            a.coeffs[48] = a.coeffs[48] + b.coeffs[48];
            a.coeffs[49] = a.coeffs[49] + b.coeffs[49];
            a.coeffs[50] = a.coeffs[50] + b.coeffs[50];
            a.coeffs[51] = a.coeffs[51] + b.coeffs[51];
            a.coeffs[52] = a.coeffs[52] + b.coeffs[52];
            a.coeffs[53] = a.coeffs[53] + b.coeffs[53];
            a.coeffs[54] = a.coeffs[54] + b.coeffs[54];
            a.coeffs[55] = a.coeffs[55] + b.coeffs[55];
            a.coeffs[56] = a.coeffs[56] + b.coeffs[56];
            a.coeffs[57] = a.coeffs[57] + b.coeffs[57];
            a.coeffs[58] = a.coeffs[58] + b.coeffs[58];
            a.coeffs[59] = a.coeffs[59] + b.coeffs[59];
            a.coeffs[60] = a.coeffs[60] + b.coeffs[60];
            a.coeffs[61] = a.coeffs[61] + b.coeffs[61];
            a.coeffs[62] = a.coeffs[62] + b.coeffs[62];
            a.coeffs[63] = a.coeffs[63] + b.coeffs[63];
            a.coeffs[64] = a.coeffs[64] + b.coeffs[64];
            a.coeffs[65] = a.coeffs[65] + b.coeffs[65];
            a.coeffs[66] = a.coeffs[66] + b.coeffs[66];
            a.coeffs[67] = a.coeffs[67] + b.coeffs[67];
            a.coeffs[68] = a.coeffs[68] + b.coeffs[68];
            a.coeffs[69] = a.coeffs[69] + b.coeffs[69];
            a.coeffs[70] = a.coeffs[70] + b.coeffs[70];
            a.coeffs[71] = a.coeffs[71] + b.coeffs[71];
            a.coeffs[72] = a.coeffs[72] + b.coeffs[72];
            a.coeffs[73] = a.coeffs[73] + b.coeffs[73];
            a.coeffs[74] = a.coeffs[74] + b.coeffs[74];
            a.coeffs[75] = a.coeffs[75] + b.coeffs[75];
            a.coeffs[76] = a.coeffs[76] + b.coeffs[76];
            a.coeffs[77] = a.coeffs[77] + b.coeffs[77];
            a.coeffs[78] = a.coeffs[78] + b.coeffs[78];
            a.coeffs[79] = a.coeffs[79] + b.coeffs[79];
            a.coeffs[80] = a.coeffs[80] + b.coeffs[80];
            a.coeffs[81] = a.coeffs[81] + b.coeffs[81];
            a.coeffs[82] = a.coeffs[82] + b.coeffs[82];
            a.coeffs[83] = a.coeffs[83] + b.coeffs[83];
            a.coeffs[84] = a.coeffs[84] + b.coeffs[84];
            a.coeffs[85] = a.coeffs[85] + b.coeffs[85];
            a.coeffs[86] = a.coeffs[86] + b.coeffs[86];
            a.coeffs[87] = a.coeffs[87] + b.coeffs[87];
            a.coeffs[88] = a.coeffs[88] + b.coeffs[88];
            a.coeffs[89] = a.coeffs[89] + b.coeffs[89];
            a.coeffs[90] = a.coeffs[90] + b.coeffs[90];
            a.coeffs[91] = a.coeffs[91] + b.coeffs[91];
            a.coeffs[92] = a.coeffs[92] + b.coeffs[92];
            a.coeffs[93] = a.coeffs[93] + b.coeffs[93];
            a.coeffs[94] = a.coeffs[94] + b.coeffs[94];
            a.coeffs[95] = a.coeffs[95] + b.coeffs[95];
            a.coeffs[96] = a.coeffs[96] + b.coeffs[96];
            a.coeffs[97] = a.coeffs[97] + b.coeffs[97];
            a.coeffs[98] = a.coeffs[98] + b.coeffs[98];
            a.coeffs[99] = a.coeffs[99] + b.coeffs[99];
            a.coeffs[100] = a.coeffs[100] + b.coeffs[100];
            a.coeffs[101] = a.coeffs[101] + b.coeffs[101];
            a.coeffs[102] = a.coeffs[102] + b.coeffs[102];
            a.coeffs[103] = a.coeffs[103] + b.coeffs[103];
            a.coeffs[104] = a.coeffs[104] + b.coeffs[104];
            a.coeffs[105] = a.coeffs[105] + b.coeffs[105];
            a.coeffs[106] = a.coeffs[106] + b.coeffs[106];
            a.coeffs[107] = a.coeffs[107] + b.coeffs[107];
            a.coeffs[108] = a.coeffs[108] + b.coeffs[108];
            a.coeffs[109] = a.coeffs[109] + b.coeffs[109];
            a.coeffs[110] = a.coeffs[110] + b.coeffs[110];
            a.coeffs[111] = a.coeffs[111] + b.coeffs[111];
            a.coeffs[112] = a.coeffs[112] + b.coeffs[112];
            a.coeffs[113] = a.coeffs[113] + b.coeffs[113];
            a.coeffs[114] = a.coeffs[114] + b.coeffs[114];
            a.coeffs[115] = a.coeffs[115] + b.coeffs[115];
            a.coeffs[116] = a.coeffs[116] + b.coeffs[116];
            a.coeffs[117] = a.coeffs[117] + b.coeffs[117];
            a.coeffs[118] = a.coeffs[118] + b.coeffs[118];
            a.coeffs[119] = a.coeffs[119] + b.coeffs[119];
            a.coeffs[120] = a.coeffs[120] + b.coeffs[120];
            a.coeffs[121] = a.coeffs[121] + b.coeffs[121];
            a.coeffs[122] = a.coeffs[122] + b.coeffs[122];
            a.coeffs[123] = a.coeffs[123] + b.coeffs[123];
            a.coeffs[124] = a.coeffs[124] + b.coeffs[124];
            a.coeffs[125] = a.coeffs[125] + b.coeffs[125];
            a.coeffs[126] = a.coeffs[126] + b.coeffs[126];
            a.coeffs[127] = a.coeffs[127] + b.coeffs[127];
            a.coeffs[128] = a.coeffs[128] + b.coeffs[128];
            a.coeffs[129] = a.coeffs[129] + b.coeffs[129];
            a.coeffs[130] = a.coeffs[130] + b.coeffs[130];
            a.coeffs[131] = a.coeffs[131] + b.coeffs[131];
            a.coeffs[132] = a.coeffs[132] + b.coeffs[132];
            a.coeffs[133] = a.coeffs[133] + b.coeffs[133];
            a.coeffs[134] = a.coeffs[134] + b.coeffs[134];
            a.coeffs[135] = a.coeffs[135] + b.coeffs[135];
            a.coeffs[136] = a.coeffs[136] + b.coeffs[136];
            a.coeffs[137] = a.coeffs[137] + b.coeffs[137];
            a.coeffs[138] = a.coeffs[138] + b.coeffs[138];
            a.coeffs[139] = a.coeffs[139] + b.coeffs[139];
            a.coeffs[140] = a.coeffs[140] + b.coeffs[140];
            a.coeffs[141] = a.coeffs[141] + b.coeffs[141];
            a.coeffs[142] = a.coeffs[142] + b.coeffs[142];
            a.coeffs[143] = a.coeffs[143] + b.coeffs[143];
            a.coeffs[144] = a.coeffs[144] + b.coeffs[144];
            a.coeffs[145] = a.coeffs[145] + b.coeffs[145];
            a.coeffs[146] = a.coeffs[146] + b.coeffs[146];
            a.coeffs[147] = a.coeffs[147] + b.coeffs[147];
            a.coeffs[148] = a.coeffs[148] + b.coeffs[148];
            a.coeffs[149] = a.coeffs[149] + b.coeffs[149];
            a.coeffs[150] = a.coeffs[150] + b.coeffs[150];
            a.coeffs[151] = a.coeffs[151] + b.coeffs[151];
            a.coeffs[152] = a.coeffs[152] + b.coeffs[152];
            a.coeffs[153] = a.coeffs[153] + b.coeffs[153];
            a.coeffs[154] = a.coeffs[154] + b.coeffs[154];
            a.coeffs[155] = a.coeffs[155] + b.coeffs[155];
            a.coeffs[156] = a.coeffs[156] + b.coeffs[156];
            a.coeffs[157] = a.coeffs[157] + b.coeffs[157];
            a.coeffs[158] = a.coeffs[158] + b.coeffs[158];
            a.coeffs[159] = a.coeffs[159] + b.coeffs[159];
            a.coeffs[160] = a.coeffs[160] + b.coeffs[160];
            a.coeffs[161] = a.coeffs[161] + b.coeffs[161];
            a.coeffs[162] = a.coeffs[162] + b.coeffs[162];
            a.coeffs[163] = a.coeffs[163] + b.coeffs[163];
            a.coeffs[164] = a.coeffs[164] + b.coeffs[164];
            a.coeffs[165] = a.coeffs[165] + b.coeffs[165];
            a.coeffs[166] = a.coeffs[166] + b.coeffs[166];
            a.coeffs[167] = a.coeffs[167] + b.coeffs[167];
            a.coeffs[168] = a.coeffs[168] + b.coeffs[168];
            a.coeffs[169] = a.coeffs[169] + b.coeffs[169];
            a.coeffs[170] = a.coeffs[170] + b.coeffs[170];
            a.coeffs[171] = a.coeffs[171] + b.coeffs[171];
            a.coeffs[172] = a.coeffs[172] + b.coeffs[172];
            a.coeffs[173] = a.coeffs[173] + b.coeffs[173];
            a.coeffs[174] = a.coeffs[174] + b.coeffs[174];
            a.coeffs[175] = a.coeffs[175] + b.coeffs[175];
            a.coeffs[176] = a.coeffs[176] + b.coeffs[176];
            a.coeffs[177] = a.coeffs[177] + b.coeffs[177];
            a.coeffs[178] = a.coeffs[178] + b.coeffs[178];
            a.coeffs[179] = a.coeffs[179] + b.coeffs[179];
            a.coeffs[180] = a.coeffs[180] + b.coeffs[180];
            a.coeffs[181] = a.coeffs[181] + b.coeffs[181];
            a.coeffs[182] = a.coeffs[182] + b.coeffs[182];
            a.coeffs[183] = a.coeffs[183] + b.coeffs[183];
            a.coeffs[184] = a.coeffs[184] + b.coeffs[184];
            a.coeffs[185] = a.coeffs[185] + b.coeffs[185];
            a.coeffs[186] = a.coeffs[186] + b.coeffs[186];
            a.coeffs[187] = a.coeffs[187] + b.coeffs[187];
            a.coeffs[188] = a.coeffs[188] + b.coeffs[188];
            a.coeffs[189] = a.coeffs[189] + b.coeffs[189];
            a.coeffs[190] = a.coeffs[190] + b.coeffs[190];
            a.coeffs[191] = a.coeffs[191] + b.coeffs[191];
            a.coeffs[192] = a.coeffs[192] + b.coeffs[192];
            a.coeffs[193] = a.coeffs[193] + b.coeffs[193];
            a.coeffs[194] = a.coeffs[194] + b.coeffs[194];
            a.coeffs[195] = a.coeffs[195] + b.coeffs[195];
            a.coeffs[196] = a.coeffs[196] + b.coeffs[196];
            a.coeffs[197] = a.coeffs[197] + b.coeffs[197];
            a.coeffs[198] = a.coeffs[198] + b.coeffs[198];
            a.coeffs[199] = a.coeffs[199] + b.coeffs[199];
            a.coeffs[200] = a.coeffs[200] + b.coeffs[200];
            a.coeffs[201] = a.coeffs[201] + b.coeffs[201];
            a.coeffs[202] = a.coeffs[202] + b.coeffs[202];
            a.coeffs[203] = a.coeffs[203] + b.coeffs[203];
            a.coeffs[204] = a.coeffs[204] + b.coeffs[204];
            a.coeffs[205] = a.coeffs[205] + b.coeffs[205];
            a.coeffs[206] = a.coeffs[206] + b.coeffs[206];
            a.coeffs[207] = a.coeffs[207] + b.coeffs[207];
            a.coeffs[208] = a.coeffs[208] + b.coeffs[208];
            a.coeffs[209] = a.coeffs[209] + b.coeffs[209];
            a.coeffs[210] = a.coeffs[210] + b.coeffs[210];
            a.coeffs[211] = a.coeffs[211] + b.coeffs[211];
            a.coeffs[212] = a.coeffs[212] + b.coeffs[212];
            a.coeffs[213] = a.coeffs[213] + b.coeffs[213];
            a.coeffs[214] = a.coeffs[214] + b.coeffs[214];
            a.coeffs[215] = a.coeffs[215] + b.coeffs[215];
            a.coeffs[216] = a.coeffs[216] + b.coeffs[216];
            a.coeffs[217] = a.coeffs[217] + b.coeffs[217];
            a.coeffs[218] = a.coeffs[218] + b.coeffs[218];
            a.coeffs[219] = a.coeffs[219] + b.coeffs[219];
            a.coeffs[220] = a.coeffs[220] + b.coeffs[220];
            a.coeffs[221] = a.coeffs[221] + b.coeffs[221];
            a.coeffs[222] = a.coeffs[222] + b.coeffs[222];
            a.coeffs[223] = a.coeffs[223] + b.coeffs[223];
            a.coeffs[224] = a.coeffs[224] + b.coeffs[224];
            a.coeffs[225] = a.coeffs[225] + b.coeffs[225];
            a.coeffs[226] = a.coeffs[226] + b.coeffs[226];
            a.coeffs[227] = a.coeffs[227] + b.coeffs[227];
            a.coeffs[228] = a.coeffs[228] + b.coeffs[228];
            a.coeffs[229] = a.coeffs[229] + b.coeffs[229];
            a.coeffs[230] = a.coeffs[230] + b.coeffs[230];
            a.coeffs[231] = a.coeffs[231] + b.coeffs[231];
            a.coeffs[232] = a.coeffs[232] + b.coeffs[232];
            a.coeffs[233] = a.coeffs[233] + b.coeffs[233];
            a.coeffs[234] = a.coeffs[234] + b.coeffs[234];
            a.coeffs[235] = a.coeffs[235] + b.coeffs[235];
            a.coeffs[236] = a.coeffs[236] + b.coeffs[236];
            a.coeffs[237] = a.coeffs[237] + b.coeffs[237];
            a.coeffs[238] = a.coeffs[238] + b.coeffs[238];
            a.coeffs[239] = a.coeffs[239] + b.coeffs[239];
            a.coeffs[240] = a.coeffs[240] + b.coeffs[240];
            a.coeffs[241] = a.coeffs[241] + b.coeffs[241];
            a.coeffs[242] = a.coeffs[242] + b.coeffs[242];
            a.coeffs[243] = a.coeffs[243] + b.coeffs[243];
            a.coeffs[244] = a.coeffs[244] + b.coeffs[244];
            a.coeffs[245] = a.coeffs[245] + b.coeffs[245];
            a.coeffs[246] = a.coeffs[246] + b.coeffs[246];
            a.coeffs[247] = a.coeffs[247] + b.coeffs[247];
            a.coeffs[248] = a.coeffs[248] + b.coeffs[248];
            a.coeffs[249] = a.coeffs[249] + b.coeffs[249];
            a.coeffs[250] = a.coeffs[250] + b.coeffs[250];
            a.coeffs[251] = a.coeffs[251] + b.coeffs[251];
            a.coeffs[252] = a.coeffs[252] + b.coeffs[252];
            a.coeffs[253] = a.coeffs[253] + b.coeffs[253];
            a.coeffs[254] = a.coeffs[254] + b.coeffs[254];
            a.coeffs[255] = a.coeffs[255] + b.coeffs[255];
            return a;
        }
    }

    function sub(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        unchecked {
            a.coeffs[0] = a.coeffs[0] - b.coeffs[0];
            a.coeffs[1] = a.coeffs[1] - b.coeffs[1];
            a.coeffs[2] = a.coeffs[2] - b.coeffs[2];
            a.coeffs[3] = a.coeffs[3] - b.coeffs[3];
            a.coeffs[4] = a.coeffs[4] - b.coeffs[4];
            a.coeffs[5] = a.coeffs[5] - b.coeffs[5];
            a.coeffs[6] = a.coeffs[6] - b.coeffs[6];
            a.coeffs[7] = a.coeffs[7] - b.coeffs[7];
            a.coeffs[8] = a.coeffs[8] - b.coeffs[8];
            a.coeffs[9] = a.coeffs[9] - b.coeffs[9];
            a.coeffs[10] = a.coeffs[10] - b.coeffs[10];
            a.coeffs[11] = a.coeffs[11] - b.coeffs[11];
            a.coeffs[12] = a.coeffs[12] - b.coeffs[12];
            a.coeffs[13] = a.coeffs[13] - b.coeffs[13];
            a.coeffs[14] = a.coeffs[14] - b.coeffs[14];
            a.coeffs[15] = a.coeffs[15] - b.coeffs[15];
            a.coeffs[16] = a.coeffs[16] - b.coeffs[16];
            a.coeffs[17] = a.coeffs[17] - b.coeffs[17];
            a.coeffs[18] = a.coeffs[18] - b.coeffs[18];
            a.coeffs[19] = a.coeffs[19] - b.coeffs[19];
            a.coeffs[20] = a.coeffs[20] - b.coeffs[20];
            a.coeffs[21] = a.coeffs[21] - b.coeffs[21];
            a.coeffs[22] = a.coeffs[22] - b.coeffs[22];
            a.coeffs[23] = a.coeffs[23] - b.coeffs[23];
            a.coeffs[24] = a.coeffs[24] - b.coeffs[24];
            a.coeffs[25] = a.coeffs[25] - b.coeffs[25];
            a.coeffs[26] = a.coeffs[26] - b.coeffs[26];
            a.coeffs[27] = a.coeffs[27] - b.coeffs[27];
            a.coeffs[28] = a.coeffs[28] - b.coeffs[28];
            a.coeffs[29] = a.coeffs[29] - b.coeffs[29];
            a.coeffs[30] = a.coeffs[30] - b.coeffs[30];
            a.coeffs[31] = a.coeffs[31] - b.coeffs[31];
            a.coeffs[32] = a.coeffs[32] - b.coeffs[32];
            a.coeffs[33] = a.coeffs[33] - b.coeffs[33];
            a.coeffs[34] = a.coeffs[34] - b.coeffs[34];
            a.coeffs[35] = a.coeffs[35] - b.coeffs[35];
            a.coeffs[36] = a.coeffs[36] - b.coeffs[36];
            a.coeffs[37] = a.coeffs[37] - b.coeffs[37];
            a.coeffs[38] = a.coeffs[38] - b.coeffs[38];
            a.coeffs[39] = a.coeffs[39] - b.coeffs[39];
            a.coeffs[40] = a.coeffs[40] - b.coeffs[40];
            a.coeffs[41] = a.coeffs[41] - b.coeffs[41];
            a.coeffs[42] = a.coeffs[42] - b.coeffs[42];
            a.coeffs[43] = a.coeffs[43] - b.coeffs[43];
            a.coeffs[44] = a.coeffs[44] - b.coeffs[44];
            a.coeffs[45] = a.coeffs[45] - b.coeffs[45];
            a.coeffs[46] = a.coeffs[46] - b.coeffs[46];
            a.coeffs[47] = a.coeffs[47] - b.coeffs[47];
            a.coeffs[48] = a.coeffs[48] - b.coeffs[48];
            a.coeffs[49] = a.coeffs[49] - b.coeffs[49];
            a.coeffs[50] = a.coeffs[50] - b.coeffs[50];
            a.coeffs[51] = a.coeffs[51] - b.coeffs[51];
            a.coeffs[52] = a.coeffs[52] - b.coeffs[52];
            a.coeffs[53] = a.coeffs[53] - b.coeffs[53];
            a.coeffs[54] = a.coeffs[54] - b.coeffs[54];
            a.coeffs[55] = a.coeffs[55] - b.coeffs[55];
            a.coeffs[56] = a.coeffs[56] - b.coeffs[56];
            a.coeffs[57] = a.coeffs[57] - b.coeffs[57];
            a.coeffs[58] = a.coeffs[58] - b.coeffs[58];
            a.coeffs[59] = a.coeffs[59] - b.coeffs[59];
            a.coeffs[60] = a.coeffs[60] - b.coeffs[60];
            a.coeffs[61] = a.coeffs[61] - b.coeffs[61];
            a.coeffs[62] = a.coeffs[62] - b.coeffs[62];
            a.coeffs[63] = a.coeffs[63] - b.coeffs[63];
            a.coeffs[64] = a.coeffs[64] - b.coeffs[64];
            a.coeffs[65] = a.coeffs[65] - b.coeffs[65];
            a.coeffs[66] = a.coeffs[66] - b.coeffs[66];
            a.coeffs[67] = a.coeffs[67] - b.coeffs[67];
            a.coeffs[68] = a.coeffs[68] - b.coeffs[68];
            a.coeffs[69] = a.coeffs[69] - b.coeffs[69];
            a.coeffs[70] = a.coeffs[70] - b.coeffs[70];
            a.coeffs[71] = a.coeffs[71] - b.coeffs[71];
            a.coeffs[72] = a.coeffs[72] - b.coeffs[72];
            a.coeffs[73] = a.coeffs[73] - b.coeffs[73];
            a.coeffs[74] = a.coeffs[74] - b.coeffs[74];
            a.coeffs[75] = a.coeffs[75] - b.coeffs[75];
            a.coeffs[76] = a.coeffs[76] - b.coeffs[76];
            a.coeffs[77] = a.coeffs[77] - b.coeffs[77];
            a.coeffs[78] = a.coeffs[78] - b.coeffs[78];
            a.coeffs[79] = a.coeffs[79] - b.coeffs[79];
            a.coeffs[80] = a.coeffs[80] - b.coeffs[80];
            a.coeffs[81] = a.coeffs[81] - b.coeffs[81];
            a.coeffs[82] = a.coeffs[82] - b.coeffs[82];
            a.coeffs[83] = a.coeffs[83] - b.coeffs[83];
            a.coeffs[84] = a.coeffs[84] - b.coeffs[84];
            a.coeffs[85] = a.coeffs[85] - b.coeffs[85];
            a.coeffs[86] = a.coeffs[86] - b.coeffs[86];
            a.coeffs[87] = a.coeffs[87] - b.coeffs[87];
            a.coeffs[88] = a.coeffs[88] - b.coeffs[88];
            a.coeffs[89] = a.coeffs[89] - b.coeffs[89];
            a.coeffs[90] = a.coeffs[90] - b.coeffs[90];
            a.coeffs[91] = a.coeffs[91] - b.coeffs[91];
            a.coeffs[92] = a.coeffs[92] - b.coeffs[92];
            a.coeffs[93] = a.coeffs[93] - b.coeffs[93];
            a.coeffs[94] = a.coeffs[94] - b.coeffs[94];
            a.coeffs[95] = a.coeffs[95] - b.coeffs[95];
            a.coeffs[96] = a.coeffs[96] - b.coeffs[96];
            a.coeffs[97] = a.coeffs[97] - b.coeffs[97];
            a.coeffs[98] = a.coeffs[98] - b.coeffs[98];
            a.coeffs[99] = a.coeffs[99] - b.coeffs[99];
            a.coeffs[100] = a.coeffs[100] - b.coeffs[100];
            a.coeffs[101] = a.coeffs[101] - b.coeffs[101];
            a.coeffs[102] = a.coeffs[102] - b.coeffs[102];
            a.coeffs[103] = a.coeffs[103] - b.coeffs[103];
            a.coeffs[104] = a.coeffs[104] - b.coeffs[104];
            a.coeffs[105] = a.coeffs[105] - b.coeffs[105];
            a.coeffs[106] = a.coeffs[106] - b.coeffs[106];
            a.coeffs[107] = a.coeffs[107] - b.coeffs[107];
            a.coeffs[108] = a.coeffs[108] - b.coeffs[108];
            a.coeffs[109] = a.coeffs[109] - b.coeffs[109];
            a.coeffs[110] = a.coeffs[110] - b.coeffs[110];
            a.coeffs[111] = a.coeffs[111] - b.coeffs[111];
            a.coeffs[112] = a.coeffs[112] - b.coeffs[112];
            a.coeffs[113] = a.coeffs[113] - b.coeffs[113];
            a.coeffs[114] = a.coeffs[114] - b.coeffs[114];
            a.coeffs[115] = a.coeffs[115] - b.coeffs[115];
            a.coeffs[116] = a.coeffs[116] - b.coeffs[116];
            a.coeffs[117] = a.coeffs[117] - b.coeffs[117];
            a.coeffs[118] = a.coeffs[118] - b.coeffs[118];
            a.coeffs[119] = a.coeffs[119] - b.coeffs[119];
            a.coeffs[120] = a.coeffs[120] - b.coeffs[120];
            a.coeffs[121] = a.coeffs[121] - b.coeffs[121];
            a.coeffs[122] = a.coeffs[122] - b.coeffs[122];
            a.coeffs[123] = a.coeffs[123] - b.coeffs[123];
            a.coeffs[124] = a.coeffs[124] - b.coeffs[124];
            a.coeffs[125] = a.coeffs[125] - b.coeffs[125];
            a.coeffs[126] = a.coeffs[126] - b.coeffs[126];
            a.coeffs[127] = a.coeffs[127] - b.coeffs[127];
            a.coeffs[128] = a.coeffs[128] - b.coeffs[128];
            a.coeffs[129] = a.coeffs[129] - b.coeffs[129];
            a.coeffs[130] = a.coeffs[130] - b.coeffs[130];
            a.coeffs[131] = a.coeffs[131] - b.coeffs[131];
            a.coeffs[132] = a.coeffs[132] - b.coeffs[132];
            a.coeffs[133] = a.coeffs[133] - b.coeffs[133];
            a.coeffs[134] = a.coeffs[134] - b.coeffs[134];
            a.coeffs[135] = a.coeffs[135] - b.coeffs[135];
            a.coeffs[136] = a.coeffs[136] - b.coeffs[136];
            a.coeffs[137] = a.coeffs[137] - b.coeffs[137];
            a.coeffs[138] = a.coeffs[138] - b.coeffs[138];
            a.coeffs[139] = a.coeffs[139] - b.coeffs[139];
            a.coeffs[140] = a.coeffs[140] - b.coeffs[140];
            a.coeffs[141] = a.coeffs[141] - b.coeffs[141];
            a.coeffs[142] = a.coeffs[142] - b.coeffs[142];
            a.coeffs[143] = a.coeffs[143] - b.coeffs[143];
            a.coeffs[144] = a.coeffs[144] - b.coeffs[144];
            a.coeffs[145] = a.coeffs[145] - b.coeffs[145];
            a.coeffs[146] = a.coeffs[146] - b.coeffs[146];
            a.coeffs[147] = a.coeffs[147] - b.coeffs[147];
            a.coeffs[148] = a.coeffs[148] - b.coeffs[148];
            a.coeffs[149] = a.coeffs[149] - b.coeffs[149];
            a.coeffs[150] = a.coeffs[150] - b.coeffs[150];
            a.coeffs[151] = a.coeffs[151] - b.coeffs[151];
            a.coeffs[152] = a.coeffs[152] - b.coeffs[152];
            a.coeffs[153] = a.coeffs[153] - b.coeffs[153];
            a.coeffs[154] = a.coeffs[154] - b.coeffs[154];
            a.coeffs[155] = a.coeffs[155] - b.coeffs[155];
            a.coeffs[156] = a.coeffs[156] - b.coeffs[156];
            a.coeffs[157] = a.coeffs[157] - b.coeffs[157];
            a.coeffs[158] = a.coeffs[158] - b.coeffs[158];
            a.coeffs[159] = a.coeffs[159] - b.coeffs[159];
            a.coeffs[160] = a.coeffs[160] - b.coeffs[160];
            a.coeffs[161] = a.coeffs[161] - b.coeffs[161];
            a.coeffs[162] = a.coeffs[162] - b.coeffs[162];
            a.coeffs[163] = a.coeffs[163] - b.coeffs[163];
            a.coeffs[164] = a.coeffs[164] - b.coeffs[164];
            a.coeffs[165] = a.coeffs[165] - b.coeffs[165];
            a.coeffs[166] = a.coeffs[166] - b.coeffs[166];
            a.coeffs[167] = a.coeffs[167] - b.coeffs[167];
            a.coeffs[168] = a.coeffs[168] - b.coeffs[168];
            a.coeffs[169] = a.coeffs[169] - b.coeffs[169];
            a.coeffs[170] = a.coeffs[170] - b.coeffs[170];
            a.coeffs[171] = a.coeffs[171] - b.coeffs[171];
            a.coeffs[172] = a.coeffs[172] - b.coeffs[172];
            a.coeffs[173] = a.coeffs[173] - b.coeffs[173];
            a.coeffs[174] = a.coeffs[174] - b.coeffs[174];
            a.coeffs[175] = a.coeffs[175] - b.coeffs[175];
            a.coeffs[176] = a.coeffs[176] - b.coeffs[176];
            a.coeffs[177] = a.coeffs[177] - b.coeffs[177];
            a.coeffs[178] = a.coeffs[178] - b.coeffs[178];
            a.coeffs[179] = a.coeffs[179] - b.coeffs[179];
            a.coeffs[180] = a.coeffs[180] - b.coeffs[180];
            a.coeffs[181] = a.coeffs[181] - b.coeffs[181];
            a.coeffs[182] = a.coeffs[182] - b.coeffs[182];
            a.coeffs[183] = a.coeffs[183] - b.coeffs[183];
            a.coeffs[184] = a.coeffs[184] - b.coeffs[184];
            a.coeffs[185] = a.coeffs[185] - b.coeffs[185];
            a.coeffs[186] = a.coeffs[186] - b.coeffs[186];
            a.coeffs[187] = a.coeffs[187] - b.coeffs[187];
            a.coeffs[188] = a.coeffs[188] - b.coeffs[188];
            a.coeffs[189] = a.coeffs[189] - b.coeffs[189];
            a.coeffs[190] = a.coeffs[190] - b.coeffs[190];
            a.coeffs[191] = a.coeffs[191] - b.coeffs[191];
            a.coeffs[192] = a.coeffs[192] - b.coeffs[192];
            a.coeffs[193] = a.coeffs[193] - b.coeffs[193];
            a.coeffs[194] = a.coeffs[194] - b.coeffs[194];
            a.coeffs[195] = a.coeffs[195] - b.coeffs[195];
            a.coeffs[196] = a.coeffs[196] - b.coeffs[196];
            a.coeffs[197] = a.coeffs[197] - b.coeffs[197];
            a.coeffs[198] = a.coeffs[198] - b.coeffs[198];
            a.coeffs[199] = a.coeffs[199] - b.coeffs[199];
            a.coeffs[200] = a.coeffs[200] - b.coeffs[200];
            a.coeffs[201] = a.coeffs[201] - b.coeffs[201];
            a.coeffs[202] = a.coeffs[202] - b.coeffs[202];
            a.coeffs[203] = a.coeffs[203] - b.coeffs[203];
            a.coeffs[204] = a.coeffs[204] - b.coeffs[204];
            a.coeffs[205] = a.coeffs[205] - b.coeffs[205];
            a.coeffs[206] = a.coeffs[206] - b.coeffs[206];
            a.coeffs[207] = a.coeffs[207] - b.coeffs[207];
            a.coeffs[208] = a.coeffs[208] - b.coeffs[208];
            a.coeffs[209] = a.coeffs[209] - b.coeffs[209];
            a.coeffs[210] = a.coeffs[210] - b.coeffs[210];
            a.coeffs[211] = a.coeffs[211] - b.coeffs[211];
            a.coeffs[212] = a.coeffs[212] - b.coeffs[212];
            a.coeffs[213] = a.coeffs[213] - b.coeffs[213];
            a.coeffs[214] = a.coeffs[214] - b.coeffs[214];
            a.coeffs[215] = a.coeffs[215] - b.coeffs[215];
            a.coeffs[216] = a.coeffs[216] - b.coeffs[216];
            a.coeffs[217] = a.coeffs[217] - b.coeffs[217];
            a.coeffs[218] = a.coeffs[218] - b.coeffs[218];
            a.coeffs[219] = a.coeffs[219] - b.coeffs[219];
            a.coeffs[220] = a.coeffs[220] - b.coeffs[220];
            a.coeffs[221] = a.coeffs[221] - b.coeffs[221];
            a.coeffs[222] = a.coeffs[222] - b.coeffs[222];
            a.coeffs[223] = a.coeffs[223] - b.coeffs[223];
            a.coeffs[224] = a.coeffs[224] - b.coeffs[224];
            a.coeffs[225] = a.coeffs[225] - b.coeffs[225];
            a.coeffs[226] = a.coeffs[226] - b.coeffs[226];
            a.coeffs[227] = a.coeffs[227] - b.coeffs[227];
            a.coeffs[228] = a.coeffs[228] - b.coeffs[228];
            a.coeffs[229] = a.coeffs[229] - b.coeffs[229];
            a.coeffs[230] = a.coeffs[230] - b.coeffs[230];
            a.coeffs[231] = a.coeffs[231] - b.coeffs[231];
            a.coeffs[232] = a.coeffs[232] - b.coeffs[232];
            a.coeffs[233] = a.coeffs[233] - b.coeffs[233];
            a.coeffs[234] = a.coeffs[234] - b.coeffs[234];
            a.coeffs[235] = a.coeffs[235] - b.coeffs[235];
            a.coeffs[236] = a.coeffs[236] - b.coeffs[236];
            a.coeffs[237] = a.coeffs[237] - b.coeffs[237];
            a.coeffs[238] = a.coeffs[238] - b.coeffs[238];
            a.coeffs[239] = a.coeffs[239] - b.coeffs[239];
            a.coeffs[240] = a.coeffs[240] - b.coeffs[240];
            a.coeffs[241] = a.coeffs[241] - b.coeffs[241];
            a.coeffs[242] = a.coeffs[242] - b.coeffs[242];
            a.coeffs[243] = a.coeffs[243] - b.coeffs[243];
            a.coeffs[244] = a.coeffs[244] - b.coeffs[244];
            a.coeffs[245] = a.coeffs[245] - b.coeffs[245];
            a.coeffs[246] = a.coeffs[246] - b.coeffs[246];
            a.coeffs[247] = a.coeffs[247] - b.coeffs[247];
            a.coeffs[248] = a.coeffs[248] - b.coeffs[248];
            a.coeffs[249] = a.coeffs[249] - b.coeffs[249];
            a.coeffs[250] = a.coeffs[250] - b.coeffs[250];
            a.coeffs[251] = a.coeffs[251] - b.coeffs[251];
            a.coeffs[252] = a.coeffs[252] - b.coeffs[252];
            a.coeffs[253] = a.coeffs[253] - b.coeffs[253];
            a.coeffs[254] = a.coeffs[254] - b.coeffs[254];
            a.coeffs[255] = a.coeffs[255] - b.coeffs[255];
            return a;
        }
    }

    function shiftl(Poly memory a) public pure returns (Poly memory) {
        for (uint256 i = 0; i < N; i++) {
            a.coeffs[i] = a.coeffs[i] << D_U32;
        }
        return a;
    }

    function ntt(Poly memory a) public pure returns (Poly memory) {
        ntt_internal(a.coeffs);
        return a;
    }

    function invntt(Poly memory a) public pure returns (Poly memory) {
        invntt_internal(a.coeffs);
        return a;
    }

    uint256 constant POLY_UNIFORM_NBLOCKS = (768 + STREAM128_BLOCKBYTES - 1) / STREAM128_BLOCKBYTES;

    function uniform(Poly memory a, uint256 seed, uint16 nonce) public pure returns (Poly memory) {
        uint256 buflen = POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES;

        Stream.State memory state = Stream.init(seed, nonce);
        bytes memory buf;
        (state, buf) = state.s128_squeeze_nblocks(POLY_UNIFORM_NBLOCKS);

        uint256 ctr;
        uint256 off;

        {
            int32[] memory _coef = new int32[](N);
            for (uint256 i = 0; i < N; i++) {
                _coef[i] = a.coeffs[i];
            }
            (_coef, ctr) = rej_uniform(_coef, N, buf, buflen);
            for (uint256 i = 0; i < N; i++) {
                a.coeffs[i] = _coef[i];
            }
        }

        while (ctr < N) {
            off = buflen % 3;
            for (uint256 i = 0; i < off; i++) {
                buf[i] = buf[buflen - off + i];
            }
            buflen = off + STREAM128_BLOCKBYTES;
            {
                bytes memory tmpbuf;
                (state, tmpbuf) = state.s128_squeeze_block();
                // buf[off..] = tmpbuf
                for (uint256 i = 0; i < STREAM128_BLOCKBYTES; i++) {
                    buf[off + i] = tmpbuf[i];
                }
            }
            {
                int32[] memory _coef = new int32[](N - ctr);
                for (uint256 i = 0; i < (N - ctr); i++) {
                    _coef[i] = a.coeffs[i + ctr];
                }
                (_coef, ctr) = rej_uniform(_coef, N - ctr, buf, buflen);
                for (uint256 i = 0; i < (N - ctr); i++) {
                    a.coeffs[i + ctr] = _coef[i];
                }
            }
        }

        return a;
    }

    function challenge(bytes32 seed) public pure returns (Poly memory a) {
        uint64 signs = 0;

        Stream.State memory state = Stream.empty();
        state = state.absorb(bytes.concat(seed));

        bytes memory buf;
        (state, buf) = state.s256_squeeze_block();

        for (uint64 i = 0; i < 8; ++i) {
            signs |= uint64(uint8(buf[i])) << (8 * i);
        }

        uint256 pos = 8;
        uint256 b;

        for (uint256 i = N - TAU; i < N; ++i) {
            while (true) {
                if (pos >= SHAKE256_RATE) {
                    (state, buf) = state.s256_squeeze_block();
                    pos = 0;
                }
                b = uint256(uint8(buf[pos]));
                pos += 1;
                if (b <= i) {
                    break;
                }
            }

            a.coeffs[i] = a.coeffs[b];
            a.coeffs[b] = 1 - 2 * int32(int64(signs & 1));
            signs >>= 1;
        }
    }

    function mpointwise(Poly memory a, Poly memory b) public pure returns (Poly memory c) {
        unchecked {
            {
                int64 tr = int64(a.coeffs[0]) * int64(b.coeffs[0]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[0] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[1]) * int64(b.coeffs[1]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[1] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[2]) * int64(b.coeffs[2]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[2] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[3]) * int64(b.coeffs[3]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[3] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[4]) * int64(b.coeffs[4]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[4] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[5]) * int64(b.coeffs[5]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[5] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[6]) * int64(b.coeffs[6]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[6] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[7]) * int64(b.coeffs[7]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[7] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[8]) * int64(b.coeffs[8]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[8] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[9]) * int64(b.coeffs[9]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[9] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[10]) * int64(b.coeffs[10]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[10] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[11]) * int64(b.coeffs[11]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[11] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[12]) * int64(b.coeffs[12]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[12] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[13]) * int64(b.coeffs[13]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[13] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[14]) * int64(b.coeffs[14]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[14] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[15]) * int64(b.coeffs[15]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[15] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[16]) * int64(b.coeffs[16]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[16] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[17]) * int64(b.coeffs[17]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[17] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[18]) * int64(b.coeffs[18]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[18] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[19]) * int64(b.coeffs[19]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[19] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[20]) * int64(b.coeffs[20]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[20] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[21]) * int64(b.coeffs[21]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[21] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[22]) * int64(b.coeffs[22]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[22] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[23]) * int64(b.coeffs[23]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[23] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[24]) * int64(b.coeffs[24]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[24] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[25]) * int64(b.coeffs[25]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[25] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[26]) * int64(b.coeffs[26]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[26] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[27]) * int64(b.coeffs[27]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[27] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[28]) * int64(b.coeffs[28]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[28] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[29]) * int64(b.coeffs[29]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[29] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[30]) * int64(b.coeffs[30]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[30] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[31]) * int64(b.coeffs[31]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[31] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[32]) * int64(b.coeffs[32]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[32] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[33]) * int64(b.coeffs[33]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[33] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[34]) * int64(b.coeffs[34]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[34] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[35]) * int64(b.coeffs[35]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[35] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[36]) * int64(b.coeffs[36]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[36] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[37]) * int64(b.coeffs[37]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[37] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[38]) * int64(b.coeffs[38]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[38] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[39]) * int64(b.coeffs[39]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[39] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[40]) * int64(b.coeffs[40]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[40] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[41]) * int64(b.coeffs[41]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[41] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[42]) * int64(b.coeffs[42]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[42] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[43]) * int64(b.coeffs[43]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[43] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[44]) * int64(b.coeffs[44]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[44] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[45]) * int64(b.coeffs[45]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[45] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[46]) * int64(b.coeffs[46]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[46] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[47]) * int64(b.coeffs[47]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[47] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[48]) * int64(b.coeffs[48]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[48] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[49]) * int64(b.coeffs[49]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[49] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[50]) * int64(b.coeffs[50]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[50] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[51]) * int64(b.coeffs[51]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[51] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[52]) * int64(b.coeffs[52]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[52] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[53]) * int64(b.coeffs[53]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[53] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[54]) * int64(b.coeffs[54]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[54] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[55]) * int64(b.coeffs[55]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[55] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[56]) * int64(b.coeffs[56]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[56] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[57]) * int64(b.coeffs[57]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[57] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[58]) * int64(b.coeffs[58]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[58] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[59]) * int64(b.coeffs[59]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[59] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[60]) * int64(b.coeffs[60]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[60] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[61]) * int64(b.coeffs[61]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[61] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[62]) * int64(b.coeffs[62]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[62] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[63]) * int64(b.coeffs[63]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[63] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[64]) * int64(b.coeffs[64]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[64] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[65]) * int64(b.coeffs[65]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[65] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[66]) * int64(b.coeffs[66]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[66] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[67]) * int64(b.coeffs[67]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[67] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[68]) * int64(b.coeffs[68]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[68] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[69]) * int64(b.coeffs[69]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[69] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[70]) * int64(b.coeffs[70]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[70] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[71]) * int64(b.coeffs[71]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[71] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[72]) * int64(b.coeffs[72]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[72] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[73]) * int64(b.coeffs[73]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[73] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[74]) * int64(b.coeffs[74]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[74] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[75]) * int64(b.coeffs[75]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[75] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[76]) * int64(b.coeffs[76]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[76] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[77]) * int64(b.coeffs[77]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[77] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[78]) * int64(b.coeffs[78]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[78] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[79]) * int64(b.coeffs[79]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[79] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[80]) * int64(b.coeffs[80]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[80] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[81]) * int64(b.coeffs[81]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[81] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[82]) * int64(b.coeffs[82]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[82] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[83]) * int64(b.coeffs[83]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[83] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[84]) * int64(b.coeffs[84]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[84] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[85]) * int64(b.coeffs[85]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[85] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[86]) * int64(b.coeffs[86]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[86] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[87]) * int64(b.coeffs[87]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[87] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[88]) * int64(b.coeffs[88]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[88] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[89]) * int64(b.coeffs[89]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[89] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[90]) * int64(b.coeffs[90]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[90] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[91]) * int64(b.coeffs[91]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[91] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[92]) * int64(b.coeffs[92]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[92] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[93]) * int64(b.coeffs[93]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[93] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[94]) * int64(b.coeffs[94]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[94] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[95]) * int64(b.coeffs[95]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[95] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[96]) * int64(b.coeffs[96]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[96] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[97]) * int64(b.coeffs[97]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[97] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[98]) * int64(b.coeffs[98]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[98] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[99]) * int64(b.coeffs[99]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[99] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[100]) * int64(b.coeffs[100]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[100] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[101]) * int64(b.coeffs[101]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[101] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[102]) * int64(b.coeffs[102]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[102] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[103]) * int64(b.coeffs[103]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[103] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[104]) * int64(b.coeffs[104]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[104] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[105]) * int64(b.coeffs[105]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[105] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[106]) * int64(b.coeffs[106]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[106] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[107]) * int64(b.coeffs[107]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[107] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[108]) * int64(b.coeffs[108]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[108] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[109]) * int64(b.coeffs[109]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[109] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[110]) * int64(b.coeffs[110]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[110] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[111]) * int64(b.coeffs[111]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[111] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[112]) * int64(b.coeffs[112]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[112] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[113]) * int64(b.coeffs[113]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[113] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[114]) * int64(b.coeffs[114]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[114] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[115]) * int64(b.coeffs[115]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[115] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[116]) * int64(b.coeffs[116]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[116] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[117]) * int64(b.coeffs[117]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[117] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[118]) * int64(b.coeffs[118]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[118] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[119]) * int64(b.coeffs[119]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[119] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[120]) * int64(b.coeffs[120]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[120] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[121]) * int64(b.coeffs[121]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[121] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[122]) * int64(b.coeffs[122]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[122] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[123]) * int64(b.coeffs[123]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[123] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[124]) * int64(b.coeffs[124]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[124] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[125]) * int64(b.coeffs[125]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[125] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[126]) * int64(b.coeffs[126]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[126] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[127]) * int64(b.coeffs[127]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[127] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[128]) * int64(b.coeffs[128]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[128] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[129]) * int64(b.coeffs[129]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[129] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[130]) * int64(b.coeffs[130]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[130] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[131]) * int64(b.coeffs[131]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[131] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[132]) * int64(b.coeffs[132]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[132] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[133]) * int64(b.coeffs[133]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[133] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[134]) * int64(b.coeffs[134]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[134] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[135]) * int64(b.coeffs[135]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[135] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[136]) * int64(b.coeffs[136]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[136] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[137]) * int64(b.coeffs[137]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[137] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[138]) * int64(b.coeffs[138]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[138] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[139]) * int64(b.coeffs[139]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[139] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[140]) * int64(b.coeffs[140]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[140] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[141]) * int64(b.coeffs[141]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[141] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[142]) * int64(b.coeffs[142]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[142] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[143]) * int64(b.coeffs[143]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[143] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[144]) * int64(b.coeffs[144]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[144] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[145]) * int64(b.coeffs[145]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[145] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[146]) * int64(b.coeffs[146]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[146] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[147]) * int64(b.coeffs[147]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[147] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[148]) * int64(b.coeffs[148]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[148] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[149]) * int64(b.coeffs[149]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[149] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[150]) * int64(b.coeffs[150]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[150] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[151]) * int64(b.coeffs[151]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[151] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[152]) * int64(b.coeffs[152]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[152] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[153]) * int64(b.coeffs[153]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[153] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[154]) * int64(b.coeffs[154]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[154] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[155]) * int64(b.coeffs[155]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[155] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[156]) * int64(b.coeffs[156]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[156] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[157]) * int64(b.coeffs[157]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[157] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[158]) * int64(b.coeffs[158]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[158] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[159]) * int64(b.coeffs[159]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[159] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[160]) * int64(b.coeffs[160]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[160] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[161]) * int64(b.coeffs[161]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[161] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[162]) * int64(b.coeffs[162]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[162] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[163]) * int64(b.coeffs[163]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[163] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[164]) * int64(b.coeffs[164]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[164] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[165]) * int64(b.coeffs[165]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[165] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[166]) * int64(b.coeffs[166]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[166] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[167]) * int64(b.coeffs[167]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[167] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[168]) * int64(b.coeffs[168]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[168] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[169]) * int64(b.coeffs[169]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[169] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[170]) * int64(b.coeffs[170]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[170] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[171]) * int64(b.coeffs[171]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[171] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[172]) * int64(b.coeffs[172]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[172] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[173]) * int64(b.coeffs[173]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[173] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[174]) * int64(b.coeffs[174]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[174] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[175]) * int64(b.coeffs[175]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[175] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[176]) * int64(b.coeffs[176]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[176] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[177]) * int64(b.coeffs[177]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[177] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[178]) * int64(b.coeffs[178]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[178] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[179]) * int64(b.coeffs[179]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[179] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[180]) * int64(b.coeffs[180]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[180] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[181]) * int64(b.coeffs[181]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[181] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[182]) * int64(b.coeffs[182]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[182] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[183]) * int64(b.coeffs[183]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[183] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[184]) * int64(b.coeffs[184]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[184] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[185]) * int64(b.coeffs[185]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[185] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[186]) * int64(b.coeffs[186]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[186] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[187]) * int64(b.coeffs[187]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[187] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[188]) * int64(b.coeffs[188]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[188] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[189]) * int64(b.coeffs[189]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[189] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[190]) * int64(b.coeffs[190]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[190] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[191]) * int64(b.coeffs[191]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[191] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[192]) * int64(b.coeffs[192]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[192] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[193]) * int64(b.coeffs[193]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[193] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[194]) * int64(b.coeffs[194]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[194] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[195]) * int64(b.coeffs[195]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[195] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[196]) * int64(b.coeffs[196]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[196] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[197]) * int64(b.coeffs[197]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[197] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[198]) * int64(b.coeffs[198]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[198] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[199]) * int64(b.coeffs[199]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[199] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[200]) * int64(b.coeffs[200]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[200] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[201]) * int64(b.coeffs[201]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[201] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[202]) * int64(b.coeffs[202]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[202] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[203]) * int64(b.coeffs[203]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[203] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[204]) * int64(b.coeffs[204]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[204] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[205]) * int64(b.coeffs[205]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[205] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[206]) * int64(b.coeffs[206]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[206] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[207]) * int64(b.coeffs[207]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[207] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[208]) * int64(b.coeffs[208]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[208] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[209]) * int64(b.coeffs[209]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[209] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[210]) * int64(b.coeffs[210]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[210] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[211]) * int64(b.coeffs[211]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[211] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[212]) * int64(b.coeffs[212]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[212] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[213]) * int64(b.coeffs[213]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[213] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[214]) * int64(b.coeffs[214]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[214] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[215]) * int64(b.coeffs[215]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[215] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[216]) * int64(b.coeffs[216]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[216] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[217]) * int64(b.coeffs[217]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[217] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[218]) * int64(b.coeffs[218]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[218] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[219]) * int64(b.coeffs[219]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[219] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[220]) * int64(b.coeffs[220]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[220] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[221]) * int64(b.coeffs[221]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[221] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[222]) * int64(b.coeffs[222]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[222] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[223]) * int64(b.coeffs[223]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[223] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[224]) * int64(b.coeffs[224]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[224] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[225]) * int64(b.coeffs[225]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[225] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[226]) * int64(b.coeffs[226]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[226] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[227]) * int64(b.coeffs[227]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[227] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[228]) * int64(b.coeffs[228]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[228] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[229]) * int64(b.coeffs[229]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[229] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[230]) * int64(b.coeffs[230]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[230] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[231]) * int64(b.coeffs[231]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[231] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[232]) * int64(b.coeffs[232]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[232] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[233]) * int64(b.coeffs[233]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[233] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[234]) * int64(b.coeffs[234]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[234] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[235]) * int64(b.coeffs[235]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[235] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[236]) * int64(b.coeffs[236]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[236] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[237]) * int64(b.coeffs[237]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[237] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[238]) * int64(b.coeffs[238]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[238] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[239]) * int64(b.coeffs[239]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[239] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[240]) * int64(b.coeffs[240]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[240] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[241]) * int64(b.coeffs[241]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[241] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[242]) * int64(b.coeffs[242]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[242] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[243]) * int64(b.coeffs[243]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[243] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[244]) * int64(b.coeffs[244]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[244] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[245]) * int64(b.coeffs[245]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[245] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[246]) * int64(b.coeffs[246]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[246] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[247]) * int64(b.coeffs[247]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[247] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[248]) * int64(b.coeffs[248]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[248] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[249]) * int64(b.coeffs[249]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[249] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[250]) * int64(b.coeffs[250]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[250] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[251]) * int64(b.coeffs[251]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[251] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[252]) * int64(b.coeffs[252]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[252] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[253]) * int64(b.coeffs[253]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[253] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[254]) * int64(b.coeffs[254]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[254] = int32((tr - tri * Q) >> 32);
            }
            {
                int64 tr = int64(a.coeffs[255]) * int64(b.coeffs[255]);
                int64 tri = int64(int32(tr) * QINV);
                c.coeffs[255] = int32((tr - tri * Q) >> 32);
            }
        }

        return c;
    }

    function use_hint(Poly memory a, Poly memory b) public pure returns (Poly memory) {
        for (uint256 i = 0; i < N; ++i) {
            a.coeffs[i] = use_hint_internal(a.coeffs[i], uint8(uint32(b.coeffs[i])));
        }
        return a;
    }

    function chknorm(Poly memory a, int32 b) public pure returns (bool) {
        int32 t;
        if (b > (Q_I32 - 1) / 8) {
            return true;
        }

        for (uint256 i = 0; i < N; ++i) {
            int32 ai = a.coeffs[i];
            t = ai >> 31;
            t = ai - (t & 2 * ai);
            if (t >= b) {
                return true;
            }
        }

        return false;
    }

    function pack_w1(Poly memory a) public pure returns (bytes memory) {
        // if if GAMMA2 == (Q - 1) / 88
        bytes memory r = new bytes(POLYW1_PACKEDBYTES);
        for (uint256 i = 0; i < N / 4; ++i) {
            r[3 * i + 0] = bytes1(uint8(uint32(a.coeffs[4 * i + 0])));
            r[3 * i + 0] |= bytes1(uint8(uint32(a.coeffs[4 * i + 1] << 6)));

            r[3 * i + 1] = bytes1(uint8(uint32(a.coeffs[4 * i + 1] >> 2)));
            r[3 * i + 1] |= bytes1(uint8(uint32(a.coeffs[4 * i + 2] << 4)));

            r[3 * i + 2] = bytes1(uint8(uint32(a.coeffs[4 * i + 2] >> 4)));
            r[3 * i + 2] |= bytes1(uint8(uint32(a.coeffs[4 * i + 3] << 2)));
        }
        // else {
        //     for i in 0..N / 2 {
        //       r[i] = (a.coeffs[2 * i + 0] | (a.coeffs[2 * i + 1] << 4)) as u8;
        //     }
        //   }
        return r;
    }

    function pack_t1(Poly memory a) public pure returns (bytes memory) {
        bytes memory r = new bytes(POLYT1_PACKEDBYTES);
        for (uint256 i = 0; i < N / 4; ++i) {
            r[5 * i + 0] = bytes1(uint8(uint32(a.coeffs[4 * i + 0] >> 0)));
            r[5 * i + 1] = bytes1(uint8(uint32((a.coeffs[4 * i + 0] >> 8) | (a.coeffs[4 * i + 1] << 2))));
            r[5 * i + 2] = bytes1(uint8(uint32((a.coeffs[4 * i + 1] >> 6) | (a.coeffs[4 * i + 2] << 4))));
            r[5 * i + 3] = bytes1(uint8(uint32((a.coeffs[4 * i + 2] >> 4) | (a.coeffs[4 * i + 3] << 6))));
            r[5 * i + 4] = bytes1(uint8(uint32(a.coeffs[4 * i + 3] >> 2)));
        }
        return r;
    }

    function unpack_t1(bytes memory a) public pure returns (Poly memory r) {
        for (uint256 i = 0; i < N / 4; ++i) {
            r.coeffs[4 * i + 0] = int32(uint32(uint8(a[5 * i + 0])) | (uint32((uint8(a[5 * i + 1]))) << 8) & 0x3FF);
            r.coeffs[4 * i + 1] = int32((uint32(uint8(a[5 * i + 1])) >> 2) | (uint32(uint8(a[5 * i + 2])) << 6) & 0x3FF);
            r.coeffs[4 * i + 2] = int32((uint32(uint8(a[5 * i + 2])) >> 4) | (uint32(uint8(a[5 * i + 3])) << 4) & 0x3FF);
            r.coeffs[4 * i + 3] = int32((uint32(uint8(a[5 * i + 3])) >> 6) | (uint32(uint8(a[5 * i + 4])) << 2) & 0x3FF);
        }
    }

    function unpack_z(bytes memory a) public pure returns (Poly memory r) {
        // if GAMMA1 == 1 << 17
        for (uint256 i = 0; i < N / 4; ++i) {
            r.coeffs[4 * i + 0] = int32(uint32(uint8(a[9 * i + 0])));
            r.coeffs[4 * i + 0] |= int32(uint32(uint8(a[9 * i + 1]))) << 8;
            r.coeffs[4 * i + 0] |= int32(uint32(uint8(a[9 * i + 2]))) << 16;
            r.coeffs[4 * i + 0] &= 0x3FFFF;

            r.coeffs[4 * i + 1] = int32(uint32(uint8(a[9 * i + 2]) >> 2));
            r.coeffs[4 * i + 1] |= int32(uint32(uint8(a[9 * i + 3]))) << 6;
            r.coeffs[4 * i + 1] |= int32(uint32(uint8(a[9 * i + 4]))) << 14;
            r.coeffs[4 * i + 1] &= 0x3FFFF;

            r.coeffs[4 * i + 2] = int32(uint32(uint8(a[9 * i + 4]) >> 4));
            r.coeffs[4 * i + 2] |= int32(uint32(uint8(a[9 * i + 5]))) << 4;
            r.coeffs[4 * i + 2] |= int32(uint32(uint8(a[9 * i + 6]))) << 12;
            r.coeffs[4 * i + 2] &= 0x3FFFF;

            r.coeffs[4 * i + 3] = int32(uint32(uint8(a[9 * i + 6]) >> 6));
            r.coeffs[4 * i + 3] |= int32(uint32(uint8(a[9 * i + 7]))) << 2;
            r.coeffs[4 * i + 3] |= int32(uint32(uint8(a[9 * i + 8]))) << 10;
            r.coeffs[4 * i + 3] &= 0x3FFFF;

            r.coeffs[4 * i + 0] = GAMMA1_I32 - r.coeffs[4 * i + 0];
            r.coeffs[4 * i + 1] = GAMMA1_I32 - r.coeffs[4 * i + 1];
            r.coeffs[4 * i + 2] = GAMMA1_I32 - r.coeffs[4 * i + 2];
            r.coeffs[4 * i + 3] = GAMMA1_I32 - r.coeffs[4 * i + 3];
        }
    }
}
