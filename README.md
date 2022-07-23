# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
GAS_REPORT=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

# Notes
# Solidity

Open hardhat console
``` npx hardhat console --network localhost ```

Get balance in ETH (not WEI or GWEI)
``` ethers.utils.formatEther(balance.toString()) ```

# React
``` npm start ```