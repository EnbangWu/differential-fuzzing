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

    function OzLog2Up(uint256 x) public returns (uint256 result) {
        result = OZFP.log2(x, OZFP.Rounding.Up);
    }

    function soladyLog2Up(uint256 x) public returns (uint256 result) {
        result = SoladyFP.log2Up(x);
    }

    function OzMulDivDown(uint256 x, uint256 y, uint256 z)
        public
        returns (uint256 result)
    {
        result = OZFP.mulDiv(x, y, z, OZFP.Rounding.Down);
    }

    function OzMulDivUp (uint256 x, uint256 y, uint256 z)
        public
        returns (uint256 result)
    {
        result = OZFP.mulDiv(x, y, z, OZFP.Rounding.Up);
    }

    function solmateMulDivDown(uint256 x, uint256 y, uint256 z)
        public
        returns (uint256 result)
    {
        result = SolmateFP.mulDivDown(x, y, z);
    }

    function solmateMulDivUp(uint256 x, uint256 y, uint256 z)
        public
        returns (uint256 result)
    {
        result = SolmateFP.mulDivUp(x, y, z);
    }

    function soladyMulDivDown(uint256 x, uint256 y, uint256 z)
        public
        returns (uint256 result)
    {
        result = SoladyFP.mulDiv(x, y, z);
    }

    function soladyMulDivUp(uint256 x, uint256 y, uint256 z)
        public
        returns (uint256 result)
    {
        result = SoladyFP.mulDivUp(x, y, z);
    }

    function prbMulDivDown(uint256 x, uint256 y, uint256 z)
        public
        returns (uint256 result)
    {
        result = PRBFP.mulDiv(x, y, z);
    }
}
