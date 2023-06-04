# Reports of differential fuzzing on solidity Fixed-point libraries

## implementation differences
In the Log2 functions, if the input is 0, the implementations return different results for OpenZepplin and Solady. OpenZepplin will directly return 0, while Solady will return 0x5be3aa5c (which is the named-error of ```Log2Undefined```). So we add `vm.assume(num != 0)` to the test cases to avoid this difference.

Similar differnce appears in the mulDiv() functions. We need to make sure that the divisor is not zero and it's not offset. Otherwise OZ and solady will complain differently. For example, Solady will return 0xad251c27, which is the function selector of ```MulDivFailed()``` so we add VM assumption as well. 

## gas reports
Overall gas snapshot can be found in the `.gas-snapshot` file. For a more accurate gas report, please run this command:
```
forge test --gas-report
```
We found that the gas consumption of OpenZepplin is much higher than other library implementations. And among the rest, solmate is the most gas efficient one. 

## TODO
- [ ] fuzzing on implementations with incompatible solidity versions
- [ ] FFI shell command execution
- [ ] change the vm.assume() to if statement
- [ ] a proper fuzz campaign with more runs