# Reports of differential fuzzing on solidity Fixed-point libraries

## Introduction
Security has become one of the core concern when writing smart contracts. While developers may be familiar with Traditional unit tests to test their code, they only provide a basic level of coverage, testing the functionality and business logic of the code. However, they operate under the assumption that the smart contract behaves as expected under given conditions. To further enhance security, we need to employ more advanced testing methodologies such as differential fuzzing.

Differential fuzzing allows us to compare different implementations of the same functionality, providing an additional layer of security by identifying discrepancies and potential vulnerabilities. This is particularly crucial for libraries that we import, as they form the foundational components of our applications. Different implementations might handle edge cases differently, and understanding these differences can help us make informed decisions about which libraries to use. Through differential fuzzing, we can ensure that the libraries we import are secure and behave as expected under a wide range of conditions.

In this project, we used [Foundry](https://book.getfoundry.sh/getting-started/installation) to perform differential fuzzing on different fixed-point libraries (OpenZepplin, Solmate, Solady and prb-math). We compared the results of the fuzzing tests and identified differences in the implementations. We also explored the gas consumption of the libraries and found that some libraries are more gas efficient than others.

## implementation differences
In general, OpenZepplin, Solmate, Solady and prb-math are all compatible with each other. However, there are some slight differences in the implementations in terms of corner cases handling.

In the Log2 functions, if the input is 0, the implementations return different results for OpenZepplin and Solady. OpenZepplin will directly return 0, while Solady will return 0x5be3aa5c (which is the named-error of ```Log2Undefined```). So we add `if (num != 0)` to the test cases to avoid this difference.

Similar differnce appears in the mulDiv() functions. We need to make sure that the divisor is not zero and it's not offset. Otherwise OZ and solady will complain differently. For example, Solady will return 0xad251c27, which is the function selector of ```MulDivFailed()``` so we add if statements as well. 

To reproduce the error cases in the test, please comment out the if statements and then run specific test cases with traces. And please refer to the library implementations for why it's being handled like that. 
## gas reports
Overall gas snapshot can be found in the `.gas-snapshot` file. The gas report is also attached here for reference.
```bash
| Function Name     | min  | avg  | median | max  | # calls |
|-------------------|------|------|--------|------|---------|
| Deployment Cost   | 705941 | - | - | - | - |
| Deployment Size   | 3558 | - | - | - | - |
| OzLog2            | 639  | 677  | 677    | 716  | 2       |
| OzLog2Up          | 783  | 796  | 796    | 809  | 2       |
| OzMulDivDown      | 674  | 674  | 674    | 674  | 2       |
| OzMulDivUp        | 769  | 809  | 809    | 849  | 2       |
| OzSqrt            | 1142 | 1146 | 1146   | 1150 | 2       |
| paulSqrt          | 977  | 977  | 977    | 978  | 2       |
| prbMulDivDown     | 581  | 581  | 581    | 581  | 2       |
| soladyDivWadUp    | 500  | 500  | 500    | 500  | 2       |
| soladyLog2        | 546  | 546  | 546    | 546  | 2       |
| soladyLog2Up      | 638  | 638  | 638    | 638  | 2       |
| soladyMulDivDown  | 504  | 504  | 504    | 504  | 2       |
| soladyMulDivUp    | 507  | 507  | 507    | 507  | 2       |
| soladyMulWadUp    | 519  | 519  | 519    | 519  | 1       |
| soladySqrt        | 683  | 683  | 683    | 683  | 2       |
| solmateDivWadUp   | 525  | 525  | 525    | 525  | 2       |
| solmateMulDivDown | 500  | 500  | 500    | 500  | 2       |
| solmateMulDivUp   | 526  | 526  | 526    | 526  | 2       |
| solmateMulWadUp   | 525  | 525  | 525    | 525  | 2       |
| solmateSqrt       | 685  | 685  | 685    | 685  | 2       |
```
or you can run this command to get it. 
```bash
forge test --gas-report
```
We found that the gas consumption of the OpenZeppelin implementation is much higher than others. In particular, functions like 
OzLog2, OzLog2Up, OzMulDivDown, OzMulDivUp, and OzSqrt consume more gas than their counterparts in other libraries.

Among the rest, solmate is the most gas efficient one. All functions in the solmate library have relatively low gas consumption, which makes it the preferred

## proper fuzz campaigns
To ensure the correctness of the fuzzing, we ran the proper fuzzing campaigns with 999999999 runs. Typically it's not necessary to run that many times during development, but as security researchers we want to cover as many cases as possible.

you can change the number of runs in  [foundry.toml](foundry.toml). More runs mean there are more random inputs feed into the functions. If you instead want to run quick tests, eg. for CI, adjust the configuration according to your needs.

## Build on our example
In the vast landscape of Solidity libraries, fixed-point arithmetic is just one aspect. To expand the scope of this research, we could compare libraries handling different functionalities, with different pragma versions. This would provide a broader understanding of the security landscape across different use-cases and Solidity versions.

Furthermore, we could leverage scripting to automate the input generation and analysis process for forge test. This would allow us to identify potential bias in the inputs and ensure a fair and comprehensive evaluation of the libraries.

Lastly, we could explore the interaction between libraries. In complex projects, it's common to import multiple libraries, which might interact in unexpected ways. Understanding these interactions through differential fuzzing could uncover potential vulnerabilities and ensure a higher level of security for our contracts.

## Conclusion
Through our differential fuzzing campaigns, we've provided an extensive comparative study of Solidity's fixed-point libraries, namely OpenZeppelin, Solmate, Solady, and FixedPoint. Despite the broad compatibility, we've discovered subtle differences in how these libraries handle edge cases, specifically within the `Log2` and `mulDiv` functions.

By highlighting these differences, we hope to assist developers in making informed decisions when choosing libraries to import for their smart contract applications. We believe that secure coding practices should not only involve writing secure code but also importing secure libraries. Through our work, we aim to contribute to the broader community's efforts to create safer, more reliable smart contracts.

In the world of blockchain, where code is law, ensuring the robustness and security of our smart contracts is paramount. The differential fuzzing of Solidity libraries is one step towards achieving this goal, providing a higher level of assurance than unit tests alone can offer. We look forward to seeing how this methodology will be employed and further developed by the web3 development community.
