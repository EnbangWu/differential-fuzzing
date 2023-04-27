// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;


// should I use the remappings here?
import "../lib/forge-std/src/Test.sol";
import { Math as OZFP} from "../lib/OpenZeppelinFullMath.sol";
import { FixedPointMathLib as SolmateFP} from "../lib/SolmateFixedPoint.sol";
import {PRBMathCommon as PRBFP} from "../lib/PRBMathCommon.sol";
import {FixedPointMathLib as SoladyFP} from "../lib/FixedPointMathLib.sol";
// import {RealMath} from "../lib/RealMath.sol";
// import {SafeDecimalMath} from "../lib/SafeDecimalMath.sol";
// import {ABDKMath64x64} from "../lib/ABDKMath64x64.sol";
// import {FixidityLib} from "../lib/FixidityLib.sol";

contract MulDivTest is Test {
    function test_mulDivDown(uint256 x, uint256 y, uint256 denominator) public {
        // vm.assume(denominator != 0); // avoid division by zero to find out the error
        OZFP.Rounding rounding = OZFP.Rounding.Down; // set to down for consistency
        uint256 solmateResult = SolmateFP.mulDivDown(x, y, denominator);
        uint256 ozResult = OZFP.mulDiv(x, y, denominator,rounding);
        assertEq(solmateResult, ozResult); // it's not equal possbily because of overflow handler
    }

    function test_mulDivUp(uint256 x, uint256 y, uint256 denominator) public {
        OZFP.Rounding rounding = OZFP.Rounding.Up; // set to up for consistency
        uint256 solmateResult = SolmateFP.mulDivUp(x, y, denominator);
        uint256 ozResult = OZFP.mulDiv(x, y, denominator,rounding);
        assertEq(solmateResult, ozResult); // it's not equal
    }

    function test_sqrt(uint256 x) public {
        uint256 solmateResult = SolmateFP.sqrt(x);
        uint256 ozResult = OZFP.sqrt(x);
        assertEq(solmateResult, ozResult);
    }
}


