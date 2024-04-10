// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/Test.sol";
import "../src/Constants.sol";
import "../src/Ntt.sol";

contract NttTest is Test {
    function test_invntt() public pure {
        int32[N] memory a = [
            int32(-410121),
            -3439227,
            -1510274,
            1543151,
            -2293562,
            -1024787,
            -1768713,
            3416108,
            -1829266,
            -39421,
            1553720,
            383193,
            -1303564,
            2601404,
            178534,
            3075833,
            -1669488,
            2938151,
            419856,
            3374895,
            -3659025,
            2791925,
            -2014544,
            -4116040,
            528058,
            -460960,
            -498884,
            -3726436,
            1576721,
            1111713,
            -2404662,
            289307,
            3590938,
            362196,
            -2812407,
            -1463477,
            1001050,
            2798150,
            -472041,
            1298972,
            -601719,
            -3341683,
            -2239048,
            -3200450,
            -1250550,
            -2932037,
            -158803,
            -42310,
            1710565,
            1768181,
            3343337,
            -4124626,
            -970397,
            2715826,
            650012,
            -2014903,
            4155312,
            -570039,
            -1014542,
            -1136867,
            -2854295,
            3545986,
            3534334,
            1775063,
            543277,
            1440396,
            -2274992,
            -1666074,
            -2522410,
            1374130,
            2546411,
            2357995,
            3246445,
            -1637839,
            -3940900,
            -22882,
            3617374,
            3695910,
            3135497,
            3461903,
            321845,
            1837065,
            -4102518,
            2025912,
            4037956,
            3262194,
            -1077158,
            -104681,
            1543795,
            2067328,
            -3128599,
            3610959,
            1154470,
            -1950084,
            3161277,
            -1484341,
            3056494,
            145395,
            -2412862,
            3811285,
            -2651526,
            794539,
            -1077785,
            -3775793,
            1851954,
            925186,
            -1420046,
            -2129292,
            -2572721,
            -1709299,
            2466220,
            -1148025,
            -631434,
            1616317,
            1979838,
            1787596,
            -2046122,
            4145612,
            2425669,
            -1207333,
            -3920849,
            2920839,
            -1437055,
            2250361,
            -2512504,
            -2660187,
            -2934830,
            3926550,
            1895481,
            -763893,
            1348485,
            3392907,
            -2603573,
            748841,
            3508436,
            -3904020,
            800986,
            1434045,
            3024446,
            -2067148,
            4058529,
            -1797892,
            2428719,
            -1661266,
            -1174918,
            -1085872,
            -437562,
            2040521,
            3475996,
            35877,
            3621178,
            -1269117,
            -743638,
            442376,
            -278296,
            -2265303,
            1611044,
            -1440032,
            545695,
            3186212,
            2126009,
            -93566,
            1381483,
            -4000405,
            -1074727,
            291811,
            3040864,
            -1459167,
            -3809294,
            -1446926,
            -2959019,
            1110797,
            -2346583,
            1125183,
            -1458376,
            476652,
            2246737,
            -1552594,
            -321172,
            -328787,
            3727158,
            2578512,
            -637322,
            2145686,
            124009,
            316574,
            598758,
            -2180345,
            -40300,
            1777560,
            -712912,
            3969900,
            -837615,
            4186858,
            -1992625,
            1592425,
            4172055,
            1030316,
            1732649,
            3365500,
            -2209545,
            -2216165,
            1598405,
            4122715,
            4094540,
            363060,
            369838,
            -1841354,
            3772391,
            1383675,
            -1268324,
            -237400,
            -3972626,
            1314275,
            -128037,
            -810499,
            -3799034,
            -1750396,
            766339,
            1350337,
            -519324,
            -3673999,
            873780,
            -2497778,
            1159808,
            3552922,
            900408,
            3883840,
            -4073441,
            2974189,
            763212,
            -1033993,
            -1137934,
            -3359093,
            452287,
            2935586,
            -917124,
            608771,
            3625009,
            -2851574,
            -207975,
            -101949,
            -3075118,
            -1522612,
            -3819111,
            3826184,
            2419692,
            1871952,
            -1722545,
            -710127,
            3035522,
            -3436794,
            -2649023,
            383072,
            2434951,
            3052038
        ];

        int32[N] memory aExpected = [
            int32(775832),
            -3236070,
            3979117,
            -477690,
            -3845958,
            3442130,
            3288278,
            3510572,
            -4059961,
            398894,
            -2353757,
            2033799,
            1142104,
            -1503727,
            -1966738,
            -646014,
            -1208934,
            2807801,
            1786267,
            77787,
            -3034606,
            -2018590,
            -4138114,
            -119863,
            -2143281,
            -2656209,
            -1161853,
            -1355718,
            -3330698,
            535482,
            3053760,
            1831603,
            2290608,
            2796725,
            -2609926,
            -663097,
            1464007,
            2958053,
            -2816324,
            2906926,
            500159,
            943996,
            524888,
            -4163949,
            -834472,
            964151,
            2161202,
            1983774,
            -3656476,
            -3020535,
            952201,
            2170010,
            711358,
            1519731,
            -3738927,
            -3756753,
            921738,
            -3392868,
            2699399,
            3324418,
            -1453193,
            1620721,
            449384,
            -39155,
            3109821,
            1029974,
            142649,
            921233,
            3727107,
            637146,
            -756794,
            34504,
            -1893151,
            -603841,
            2330154,
            1322568,
            -1191265,
            -748922,
            1386438,
            2435097,
            355691,
            705695,
            -504939,
            1785625,
            3011361,
            2599030,
            -721431,
            3258978,
            826952,
            3134195,
            1786978,
            -2063102,
            3719340,
            -3791185,
            766135,
            1412965,
            2002641,
            344357,
            -3493197,
            -3971320,
            -1589376,
            3333787,
            -886393,
            -3473781,
            2615969,
            258578,
            -1357515,
            31929,
            -2417061,
            3279057,
            623958,
            402549,
            -3223514,
            1434146,
            2674659,
            4184013,
            2350081,
            -2255267,
            3242948,
            -2755729,
            3141850,
            -3642170,
            -410070,
            -3603228,
            509187,
            747235,
            -2733439,
            2951878,
            934726,
            -1464030,
            -3685617,
            -177281,
            -2026915,
            -2014190,
            3892744,
            -2765709,
            178393,
            1247779,
            -328544,
            -647840,
            227976,
            -1303803,
            -407239,
            2659686,
            330785,
            22660,
            3150838,
            -49448,
            -3247191,
            3366409,
            3515827,
            2681493,
            -3955013,
            957672,
            2270951,
            -2324620,
            848541,
            252308,
            2362816,
            -480849,
            1886753,
            1946701,
            -3448907,
            3931255,
            -2029213,
            -3650910,
            3939281,
            730275,
            2214811,
            1201755,
            -694587,
            -2004861,
            2583875,
            3279717,
            3819665,
            2574119,
            -2112908,
            -2400101,
            -1349537,
            3495414,
            1347624,
            -2225620,
            -2050682,
            -2951590,
            -3996103,
            -3607935,
            3247458,
            -2175324,
            -1553702,
            -2091666,
            1571828,
            -1878102,
            2718529,
            -541427,
            -662267,
            -1324341,
            -370258,
            -474473,
            2224715,
            2128310,
            -345001,
            1208578,
            -1376070,
            3433670,
            3140605,
            875985,
            -1831696,
            449356,
            -220450,
            1787974,
            2388192,
            -34248,
            -3456146,
            2415580,
            1786863,
            -2849072,
            -212492,
            59437,
            -716203,
            1968326,
            1107129,
            434519,
            185631,
            3036577,
            -2325373,
            567821,
            1988023,
            2839088,
            -1233636,
            -3135158,
            4161465,
            -3730607,
            1882010,
            -3271303,
            -2556717,
            -1387745,
            -3161242,
            1813752,
            -3561981,
            130118,
            -2005282,
            -3396498,
            1716289,
            -3253036,
            -1302754,
            2500212,
            -1918240,
            1201565,
            -1106518,
            743553,
            902331,
            804710,
            -3047027,
            3654086,
            911638,
            3708051
        ];

        invntt(a);

        for (uint256 i = 0; i < N; i++) {
            assertEq(a[i], aExpected[i]);
        }
    }

    function test_ntt() public pure {
        int32[N] memory a = [
            int32(-1),
            1,
            -4,
            -3,
            -4,
            4,
            1,
            1,
            2,
            4,
            1,
            2,
            -2,
            3,
            1,
            0,
            -3,
            1,
            -1,
            -2,
            4,
            -4,
            -1,
            -3,
            -4,
            -3,
            3,
            -3,
            -1,
            0,
            0,
            2,
            3,
            -4,
            3,
            4,
            1,
            -3,
            -1,
            3,
            0,
            0,
            1,
            -4,
            -1,
            -2,
            -2,
            2,
            3,
            0,
            1,
            1,
            4,
            1,
            2,
            2,
            4,
            1,
            -2,
            2,
            0,
            3,
            1,
            -3,
            4,
            -3,
            2,
            -1,
            3,
            2,
            -3,
            4,
            3,
            -4,
            -2,
            2,
            4,
            -1,
            3,
            -2,
            -1,
            -4,
            -1,
            -4,
            -3,
            4,
            -1,
            -3,
            -2,
            0,
            -4,
            3,
            -4,
            -1,
            -1,
            4,
            -4,
            0,
            1,
            -1,
            4,
            1,
            -4,
            3,
            4,
            -3,
            -2,
            -2,
            -3,
            0,
            3,
            -1,
            2,
            -4,
            -3,
            -2,
            1,
            -3,
            -3,
            -3,
            1,
            1,
            4,
            -1,
            2,
            4,
            4,
            -3,
            3,
            1,
            -4,
            2,
            -4,
            -3,
            2,
            -4,
            -1,
            3,
            4,
            -4,
            3,
            -3,
            4,
            0,
            -2,
            2,
            1,
            -3,
            1,
            0,
            4,
            2,
            3,
            -2,
            2,
            -2,
            4,
            -1,
            3,
            -2,
            1,
            -3,
            3,
            -3,
            3,
            4,
            1,
            4,
            3,
            3,
            -1,
            0,
            -2,
            1,
            3,
            -4,
            2,
            -1,
            4,
            1,
            0,
            2,
            -1,
            -2,
            1,
            4,
            -4,
            0,
            0,
            3,
            -3,
            1,
            -4,
            4,
            -3,
            1,
            -4,
            3,
            -1,
            2,
            4,
            -1,
            0,
            -4,
            -2,
            4,
            -4,
            4,
            4,
            -2,
            -3,
            3,
            2,
            -2,
            -4,
            -1,
            3,
            1,
            3,
            1,
            -4,
            2,
            -3,
            2,
            4,
            4,
            -3,
            3,
            -4,
            3,
            -4,
            0,
            -2,
            3,
            -3,
            -2,
            3,
            1,
            -4,
            -3,
            3,
            -2,
            -3,
            4,
            -3,
            1,
            1,
            2,
            -1,
            -1,
            0,
            -3,
            -3,
            0,
            -1,
            3
        ];

        int32[N] memory aExpected = [
            -262661,
            -8506629,
            3427761,
            2784265,
            3141917,
            -2372709,
            -8049215,
            -2353801,
            3022212,
            7731946,
            1644566,
            3053540,
            -255898,
            -2738860,
            876613,
            9132009,
            10276178,
            7874020,
            -11588,
            1969958,
            12632850,
            8341150,
            8287818,
            3925510,
            -8773920,
            -747228,
            898118,
            -2317034,
            3897976,
            -4414032,
            -834621,
            4071501,
            -1432521,
            -9685153,
            -13990476,
            -13659378,
            -7289253,
            -7755363,
            3791227,
            -3833707,
            -9487410,
            -8901660,
            -19000363,
            -13214259,
            544413,
            -6844765,
            -6105586,
            -11435970,
            -2978543,
            -1014713,
            -5667934,
            -13166438,
            -5875092,
            -12621756,
            -9964452,
            -5673368,
            -3935130,
            -4224380,
            -7354605,
            -7906865,
            -4353982,
            1618188,
            4762265,
            2833189,
            -310581,
            -3991895,
            -11913640,
            -5312548,
            3570135,
            -4704135,
            -3170969,
            -5592951,
            1453785,
            -4560687,
            -1182968,
            2521098,
            -3751247,
            -4714079,
            301131,
            -2224209,
            -5642042,
            458282,
            5403769,
            2707403,
            12215228,
            5224740,
            6413907,
            6815913,
            4580029,
            425581,
            1318364,
            -783726,
            7326262,
            7568074,
            689180,
            -547668,
            -4653694,
            -11442820,
            -7832628,
            -5377838,
            -11257920,
            -8298570,
            -4596359,
            -4150699,
            -3065694,
            -10682906,
            -2769659,
            937211,
            1653867,
            3120263,
            -1126589,
            7211075,
            -14877134,
            -18262456,
            -8293726,
            -9183292,
            -10773770,
            -6705792,
            -5315674,
            2787012,
            -2270115,
            -9841689,
            -5051871,
            -7388413,
            4234814,
            1052190,
            -2471397,
            -6463519,
            10137330,
            5496024,
            4753901,
            -645043,
            7223139,
            1246181,
            9902026,
            8334682,
            6254834,
            13121436,
            5157886,
            5524544,
            3335176,
            -1444146,
            7151165,
            8213713,
            5425362,
            2999358,
            9659970,
            4975850,
            10923812,
            12903596,
            3807803,
            8025009,
            -5468017,
            -1536129,
            -2185854,
            2751920,
            6580366,
            4468658,
            8981903,
            2405433,
            8513375,
            9863111,
            7777890,
            11623292,
            -484225,
            2094367,
            6670303,
            -1190953,
            -113377,
            7560821,
            -1565727,
            512851,
            2493128,
            -2496028,
            -2851481,
            -11119827,
            -3547676,
            -6187460,
            4743114,
            -1430434,
            8695423,
            404053,
            -5689198,
            -237334,
            -10292594,
            -2482562,
            -4377285,
            -8964791,
            -8246037,
            -13793329,
            -106937,
            -5784361,
            16421657,
            16169825,
            17295701,
            14750529,
            15111685,
            13365139,
            5665684,
            6845556,
            3012973,
            2469901,
            -34925,
            3554251,
            2179597,
            9005783,
            11178922,
            11448090,
            4172918,
            6892142,
            -3097350,
            -2378354,
            -2508563,
            -3588283,
            -7774392,
            -7426678,
            3013820,
            8971556,
            11583329,
            6634515,
            657092,
            6937984,
            -6083813,
            -1488819,
            -1315854,
            5205578,
            -7934583,
            -2186897,
            6308547,
            3324877,
            10276044,
            2595056,
            8209625,
            2358083,
            6005802,
            2915382,
            1471531,
            -1624379,
            -3631962,
            -4158290,
            544917,
            -6606555,
            998696,
            584554,
            1926740,
            844426,
            1017867,
            -3082165,
            -5819081,
            -8499759,
            521737,
            -7231469,
            -4117257,
            -5370457,
            -6235069,
            314971
        ];

        ntt(a);

        for (uint256 i = 0; i < N; i++) {
            assertEq(a[i], aExpected[i]);
        }
    }
}
