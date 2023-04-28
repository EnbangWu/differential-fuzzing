// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

import "../lib/forge-std/src/Test.sol";
import "../src/MathTest.sol";
import {Math as OZFP} from "../lib/openzeppelin-contracts/contracts/utils/math/Math.sol";

contract SqrtTest is Test {
    MathTest instance;
    uint256 public constant ROOT_NUM = 4;

    function setUp() public {
        instance = new MathTest();
    }

    function test_Solmate_sqrt() public {
        for (uint256 i = 0; i < 100; i++) {
            instance.solmateSqrt(ROOT_NUM);
        }
    }

    function test_0z_sqrt() public {
        for (uint256 i = 0; i < 100; i++) {
            instance.OzSqrt(ROOT_NUM);
        }
    }

    function test_Paul_sqrt() public {
        for (uint256 i = 0; i < 100; i++) {
            instance.paulSqrt(ROOT_NUM);
        }
    }

    function test_Solady_sqrt() public {
        for (uint256 i = 0; i < 100; i++) {
            instance.soladySqrt(ROOT_NUM);
        }
    }

    function test_diffSqrt(uint256 num) public {
        uint256 solmateResult = instance.solmateSqrt(num);
        uint256 ozResult = instance.OzSqrt(num);
        uint256 paulResult = instance.paulSqrt(num);
        uint256 soladyResult = instance.soladySqrt(num);
        require(
            solmateResult == ozResult &&
                ozResult == paulResult &&
                paulResult == soladyResult
        );
    }
}
