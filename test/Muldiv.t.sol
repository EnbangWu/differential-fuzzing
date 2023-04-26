// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// should I use the remappings here?
import "../lib/forge-std/src/Test.sol";
import { Math } from "../lib/OpenZeppelinFullMath.sol";
import { FixedPointMathLib } from "../lib/SolmateFixedPoint.sol";

contract MulDivTest is Test {
    function test_mulDivDown(uint256 x, uint256 y, uint256 denominator) public {
        // vm.assume(denominator != 0); // avoid division by zero to find out the error
        Math.Rounding rounding = Math.Rounding.Down; // set to down for consistency
        uint256 somateResult = FixedPointMathLib.mulDivDown(x, y, denominator);
        uint256 ozResult = Math.mulDiv(x, y, denominator,rounding);
        assertEq(somateResult, ozResult); // it's not equal possbily because of overflow handler
    }

    function test_mulDivUp(uint256 x, uint256 y, uint256 denominator) public {
        Math.Rounding rounding = Math.Rounding.Up; // set to up for consistency
        uint256 somateResult = FixedPointMathLib.mulDivUp(x, y, denominator);
        uint256 ozResult = Math.mulDiv(x, y, denominator,rounding);
        assertEq(somateResult, ozResult); // it's not equal
    }

    function test_sqrt(uint256 x) public {
        uint256 somateResult = FixedPointMathLib.sqrt(x);
        uint256 ozResult = Math.sqrt(x);
        assertEq(somateResult, ozResult);
    }
}


