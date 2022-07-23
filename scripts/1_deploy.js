const { ethers } = require("hardhat");

async function main() {
    console.log(`Preparing deployment... \n`)
    // Fetch contract to deploy
    const Token = await ethers.getContractFactory('Token')
    const Exchange = await ethers.getContractFactory('Exchange')

    const accounts = await ethers.getSigners()
    
    console.log(`Accounts fetched:\n${accounts[0].address}\n${accounts[1].address}\n`)

    // Deploy contracts
    const dapp = await Token.deploy('Dapp University', 'DAPP', '1000000');
    await dapp.deployed()
    console.log(`DAPP deployed to address: ${dapp.address}`)

    const mETH = await Token.deploy('mETH', 'mETH', '1000000');
    await mETH.deployed()
    console.log(`mETH deployed to address: ${mETH.address}`)

    const mDAI = await Token.deploy('mDAI', 'mDAI', '1000000');
    await mDAI.deployed()
    console.log(`mDAI deployed to address: ${mDAI.address}`)

    const exchange = await Exchange.deploy(accounts[1].address, 10)
    await exchange.deployed()
    console.log(`Exchange Deployed to: ${exchange.address}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
