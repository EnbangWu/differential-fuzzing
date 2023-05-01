// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import "../lib/forge-std/src/Test.sol";
import "../src/MathTest.sol";

contract SqrtTest is Test {
    MathTest instance;
    uint256 public constant ROOT_NUM = 4;

    function setUp() public {
        instance = new MathTest();
    }

    function test_Solmate_sqrt() public {
            instance.solmateSqrt(ROOT_NUM);
    }

    function test_0Z_sqrt() public {
            instance.OzSqrt(ROOT_NUM);
    }

    function test_Paul_sqrt() public {
            instance.paulSqrt(ROOT_NUM);
    }

    function test_Solady_sqrt() public {
            instance.soladySqrt(ROOT_NUM);
    }

    function test_Oz_log2() public {
        instance.OzLog2(ROOT_NUM);
        }

    function test_Solady_log2() public {
        instance.soladyLog2(ROOT_NUM);
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

    function test_diffLog2(uint256 num) public {
        uint256 ozResult = instance.OzLog2(num);
        uint256 soladyResult = instance.soladyLog2(num);
        require(
            ozResult == soladyResult
        );
    }
}
