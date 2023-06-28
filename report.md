# Reports of differential fuzzing on solidity Fixed-point libraries

## Introduction
Security has become one of the core concerns when writing smart contracts. While developers may be familiar with traditional unit tests to test their code, they only provide a basic level of coverage, testing the functionality and business logic of the code. However, they operate under the assumption that the smart contract behaves as expected under given conditions. To further enhance security, we need to employ more advanced testing methodologies such as differential fuzzing.

Differential fuzzing is a testing technique that involves executing different implementations of the same function or logic and comparing the results. This technique allows us to verify that the different implementations are equivalent and behave consistently, even when provided with unexpected, invalid, or random inputs. This is different from normal fuzzing which typically tests a single implementation by feeding it a wide range of inputs and monitoring for unexpected behavior, crashes, or security vulnerabilities.

In this project, we used [Foundry](https://book.getfoundry.sh/getting-started/installation) to perform differential fuzzing on different fixed-point libraries ([OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/0a25c1940ca220686588c4af3ec526f725fe2582), [Solmate](https://github.com/transmissions11/solmate/tree/2001af43aedb46fdc2335d2a7714fb2dae7cfcd1), [Solady](https://github.com/vectorized/solady/tree/74c34fb4c4af0ba35489b25c3a55388e498874a8) and [prb-math](https://github.com/PaulRBerg/prb-math/tree/7ce3009bbfa0d8e2d430b7a1a9ca46b6e706d90d)). Notice that among several major releases of Solmate libraries ( and they did change a lot ), We used the latest release (v6) of Solmate library because we think that most of the new projects which choose to import Solmate library will select this version. Our initial motivation was to check if there were any significant differences in the results returned by these libraries. Despite our exhaustive efforts, we found broad compatibility among these libraries, with some differences in handling edge cases and gas efficiency.

## Implementation differences
We will illustrate the differences in the implementation of these libraries through the following examples.

In the Log2 functions (Return the log in base 2), if the input is 0, the implementations return different results for OpenZeppelin and Solady. OpenZeppelin will directly return 0, while Solady will return 0x5be3aa5c (which is the signature of ```Log2Undefined```). So we add `if (num != 0)` to the test cases to avoid this difference.

A similar difference appears in the mulDiv() functions. We need to make sure that the divisor is not zero and it's not offset. Otherwise, OZ and solady will complain differently. For example, Solady will return 0xad251c27, which is the signature of ```MulDivFailed()``` so we add if statements as well. 

To reproduce the error cases in the test, please comment out the if statements and then run specific test cases with traces. And please refer to the library implementations for why it's being handled like that. 
## Gas reports
Since the functions in these libraries are mostly compatible, we also compared their gas consumption.

Overall gas snapshot can be found in the `.gas-snapshot` file. The simplified gas report version is also attached below for better readability ( avg gas consumption for each function call ).
```bash
| Function Name     | OZ   |Solady|Solmate |PRB-math|
|-------------------|------|------|--------|------|
| Log2              | 677  | 546  | N/A    | N/A  |
| Log2Up            | 796  | 638  | N/A    | N/A  |
| MulDivDown        | 674  | 504  | 500    | 581  |
| MulDivUp          | 809  | 507  | 526    | N/A  |
| Sqrt              | 1146 | 683  | 685    | 977  |
| DivWadUp          | N/A  | 500  | 525    | N/A  |
| MulWadUp          | N/A  | 519  | 525    | N/A  |
```
or you can run this command to get it. 
```bash
forge test --gas-report
```
We found that the gas consumption of the OpenZeppelin implementation is much higher than others. In particular, functions like 
OzLog2, OzLog2Up, OzMulDivDown, OzMulDivUp, and OzSqrt consume more gas than their counterparts in other libraries.

Among the rest, solady is the most gas efficient one. All functions compared in the solady library have relatively low gas consumption, and it provides the most comprehensive functionalities,  which makes it preferred for advanced users. However, it's worth noting that only [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/38a450460d8c501980932b136c8e7c99f6071902/audit/ZeppelinAudit.md) and [Solmate](https://github.com/transmissions11/solmate/blob/main/audits/v6-Fixed-Point-Solutions.pdf) have been audited by external security teams. And even Solmate is not designed with user safety in mind, so before shooting your foot, one should thoroughly read the documentation and understand the library. 

The good news is, Cantina decided to audit Solady library as a public goods project, you can monitor their status [here](https://cantina.xyz/crowdfund/solady)

## Proper fuzz campaigns
To ensure the correctness of the fuzzing, we ran the proper fuzzing campaigns with 9999999 runs. Typically it's not necessary to run that many times during development, but as security researchers we want to cover as many cases as possible.

you can change the number of runs in  [foundry.toml](https://github.com/EnbangWu/differential-fuzzing/blob/main/foundry.toml). More runs mean there are more random inputs fed into the functions. If you instead want to run quick tests, eg. for CI, adjust the configuration according to your needs.

## Build on our example
In the vast landscape of Solidity libraries, fixed-point arithmetic is just one aspect. To expand the scope of this research, we could compare libraries handling different functionalities, with different pragma versions. This would provide a broader understanding of the security landscape across different use cases and Solidity versions.

Furthermore, we could leverage scripting to automate the input generation and analysis process for the forge test. This would allow us to identify potential bias in the inputs and ensure a fair and comprehensive evaluation of the libraries.


## Conclusion
The primary intent of our differential fuzzing campaign was to uncover any significant discrepancies in the outputs produced by Solidity's fixed-point libraries OpenZeppelin, Solmate, Solady, and PRB-Math. Although the libraries demonstrated broad compatibility, our extensive testing uncovered minor differences in the way they handle edge cases, particularly within the Log2 and mulDiv functions. While these disparities might seem minor, they could lead to unexpected behaviors in smart contracts, hence their importance.

Through this work, we hope to provide developers with detailed insights that can guide their decisions when choosing libraries for their smart contract applications. Our study didn't find any significant deviations among the libraries. However, the slight differences we observed serve as a reminder of the importance of thorough testing and understanding of the code we use.

In the world of blockchain, where code is law, ensuring the robustness and security of our smart contracts is paramount. The differential fuzzing of Solidity libraries is one step towards achieving this goal, providing a higher level of assurance than unit tests alone can offer. We look forward to seeing how this methodology will be employed and further developed by the web3 development community.
