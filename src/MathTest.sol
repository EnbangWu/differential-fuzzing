// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

import {Math as OZFP} from "../lib/openzeppelin-contracts/contracts/utils/math/Math.sol";
import {FixedPointMathLib as SolmateFP} from "../lib/solmate/src/utils/FixedPointMathLib.sol";
import "../lib/prb-math/src/Common.sol" as PRBFP;
import {FixedPointMathLib as SoladyFP} from "../lib/solady/src/utils/FixedPointMathLib.sol";

contract MathTest {
    // Use the libraries to do stuff

    function solmateSqrt(uint256 x) public returns (uint256 a) {
        a = SolmateFP.sqrt(x);
    }

    function OzSqrt(uint256 x) public returns (uint256 b) {
        b = OZFP.sqrt(x);
    }

    function paulSqrt(uint256 x) public returns (uint256 c) {
        c = PRBFP.sqrt(x);
    }

    function soladySqrt(uint256 x) public returns (uint256 d) {
        d = SoladyFP.sqrt(x);
    }

    function OzLog2(uint256 x) public returns (uint256 result) {
        result = OZFP.log2(x);
    }

    function soladyLog2(uint256 x) public returns (uint256 result) {
        result = SoladyFP.log2(x);
    }
}
