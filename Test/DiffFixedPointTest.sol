// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import "../lib/forge-std/src/Test.sol";
import "../src/MathTest.sol";
import "../lib/forge-std/src/console.sol";

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

    function test_Oz_mulDivUp() public {
        instance.OzMulDivUp(ROOT_NUM, ROOT_NUM, ROOT_NUM);
        }
    
    function test_Solady_mulDivUp() public {
        instance.soladyMulDivUp(ROOT_NUM, ROOT_NUM, ROOT_NUM);
        }
    
    function test_solmate_mulDivUp() public {
        instance.solmateMulDivUp(ROOT_NUM, ROOT_NUM, ROOT_NUM);
        }

    function test_Oz_mulDivDown() public {
        instance.OzMulDivDown(ROOT_NUM, ROOT_NUM, ROOT_NUM);
        }

    function test_Solady_mulDivDown() public {
        instance.soladyMulDivDown(ROOT_NUM, ROOT_NUM, ROOT_NUM);
        }

    function test_solmate_mulDivDown() public {
        instance.solmateMulDivDown(ROOT_NUM, ROOT_NUM, ROOT_NUM);
        }
    
    function test_prb_mulDivDown() public {
        instance.prbMulDivDown(ROOT_NUM, ROOT_NUM, ROOT_NUM);
        }
    
    function test_solmate_mulWadUp() public {
        instance.solmateMulWadUp(ROOT_NUM, ROOT_NUM);
        }

    function test_solmate_divWadUp() public {
        instance.solmateDivWadUp(ROOT_NUM, ROOT_NUM);
        }

    function test_solady_dipWadUp() public {
        instance.soladyDivWadUp(ROOT_NUM, ROOT_NUM);
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
        console.log("Testing with num: %s", num);
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
    // @audit when it's offset, Solady will return 0xad251c27, which is the 
    // function selector of MulDivFailed() so we add VM assumption
    function test_diffMulDivDown(uint256 x, uint256 y, uint256 z) public {
        if (y > 1) {
            x = x % ((type(uint256).max / y) + 1);
        }
        if (z > 0) { // assume that the divisor is not zero
        uint256 ozResult = instance.OzMulDivDown(x, y, z);
        uint256 soladyResult = instance.soladyMulDivDown(x, y, z);
        uint256 solmateResult = instance.solmateMulDivDown(x, y, z);
        uint256 prbResult = instance.prbMulDivDown(x, y, z);
        require(
            ozResult == soladyResult && soladyResult == solmateResult && solmateResult == prbResult
        );
    }
    }
    function test_diffMulDivUp(uint256 x, uint256 y, uint256 z) public {
        if (y > 1) {
            x = x % ((type(uint256).max / y) + 1);
        }
        if (z > 0) { // assume that the divisor is not zero
        uint256 ozResult = instance.OzMulDivUp(x, y, z);
        uint256 soladyResult = instance.soladyMulDivUp(x, y, z);
        uint256 solmateResult = instance.solmateMulDivUp(x, y, z);
        require(
            ozResult == soladyResult && soladyResult == solmateResult
        );
    }
    }
    function test_diffMulWadUp(uint256 x, uint256 y) public {
        if (y > 1) {
            x = x % ((type(uint256).max / y) + 1);
        }
        uint256 solmateResult = instance.solmateMulWadUp(x, y);
        uint256 soladyResult = instance.soladyMulWadUp(x, y);
        require(
            solmateResult == soladyResult
        );
    }

    function test_diffDivWadUp(uint256 x, uint256 y) public {
        vm.assume(y> 0 && x <= type(uint256).max / SolmateFP.WAD);
        uint256 solmateResult = instance.solmateDivWadUp(x, y);
        uint256 soladyResult = instance.soladyDivWadUp(x, y);
        require(
            solmateResult == soladyResult
        );
    }
}
