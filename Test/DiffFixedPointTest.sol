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

    function test_Oz_log2Up() public {
        instance.OzLog2Up(ROOT_NUM);
        }

    function test_Solady_log2Up() public {
        instance.soladyLog2Up(ROOT_NUM);
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

    //@notice when num = 0, ozResult = 0, soladyResult = 0x5be3aa5c
    function test_diffLog2(uint256 num) public {
        vm.assume(num > 0); //@audit they handle num = 0 differently.
        uint256 ozResult = instance.OzLog2(num);
        uint256 soladyResult = instance.soladyLog2(num);
        require(
            ozResult == soladyResult
        );
    }

    function test_diffLog2Up(uint256 num) public {
        vm.assume(num > 0); // same here
        uint256 ozResult = instance.OzLog2Up(num);
        uint256 soladyResult = instance.soladyLog2Up(num);
        require(
            ozResult == soladyResult
        );
    }
}
