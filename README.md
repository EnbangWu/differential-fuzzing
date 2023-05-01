# Differential Fuzzing of solidity Fixed-point libraries

This is a repo that aims to check whether different Fixed-point libraries output the same result by using Foundry differential fuzzing. 

This repo is generated from [Patrick's solidity fuzzing boilerplate](https://github.com/patrickd-/solidity-fuzzing-boilerplate)

## Setup
You will need to install [Foundry](https://book.getfoundry.sh/getting-started/installation) to run the fuzzing tests.
Here are the installation instructions for mac users:

Open your terminal and type in the following command:
```bash
curl -L https://foundry.paradigm.xyz | bash
```
This will download foundryup. Then install Foundry by running:
```bash
foundryup
```
After installing Foundry, you can compile the contracts by running:
```bash
forge build
```
And run all the tests by running:
```bash
forge test
```

You will also need to install [Ganache](https://github.com/trufflesuite/ganache#readme) to run the tests that require a forked mainnet or implementations with incompatible solidity versions.

## Running Foundry Fuzzing

```bash
# Simple fuzzing with Foundry:
forge test --match test_diffSqrt

# Differential fuzzing against another implementation with incompatible Solidity version via ganache fork:
forge test --fork-url http://127.0.0.1:8545/ --match-path test/DiffFixedPointTest.t.sol

# Differential fuzzing against an executable via FFI shell command execution:
forge test --match-path test/DiffFixedPointTest.t.sol
```

Note you can change the number of runs in  [foundry.toml](foundry.toml). More runs mean there are more random inputs feed into the functions. If you instead want to run quick tests, eg. for CI, adjust the configuration according to your needs.

## Reproducing a finding / Manual testing

<!-- ```bash
# Call function of exposed library and show execution trace:
forge run --sig "slice(bytes,uint256,uint256)" --target-contract ExposedBytesLib -vvvv src/expose/example/BytesLib.sol 0x010203 1 1

# Manually execute a testcase to reproduce an issue:
forge run --fork-url http://127.0.0.1:8545/ --sig "test_BytesLib_BytesUtil_diff_slice(bytes,uint256,uint256)" --target-contract Test -vvvv src/test/example/BytesLib-BytesUtil-diff.sol 0x010203 1 1
``` -->
## TODO
- [ ] Figure out the MulDivDown and MulDivUp differences
- [x] gas reports
- [ ] fuzzing on implementations with incompatible solidity versions
- [ ] FFI shell command execution
##### ✂ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - SNIP - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Solidity Fuzzing Boilerplate

This is a template repository intended to ease fuzzing components of Solidity projects, especially libraries.

- Write tests once and run them [Foundry](https://book.getfoundry.sh/forge/fuzz-testing.html)'s fuzzing.
- Fuzz components that use incompatible Solidity versions by deploying those into a Ganache instance via Etheno.
- Use HEVM's FFI cheatcode to generate complex fuzzing inputs or to compare outputs with non-EVM executables while doing differential fuzzing.
- Publish your fuzzing experiments without worrying about licensing by extending the shellscript to download specific files.



