const { expect } = require('chai');
const { ethers } = require('hardhat')

const tokens = (n) => {
    return ethers.utils.parseUnits(n.toString(), 'ether'); // converts etherinto wei
}
describe('Token function', () => {
    let token;

    beforeEach(async () => {
        // Fetch token from Blockchain
        const Token = await ethers.getContractFactory('Token');
        token = await Token.deploy('Dapp University', 'DAPP', '1000000');
    })

    describe('Deployment', () => {
        const name = 'Dapp University';
        const symbol = 'DAPP';
        const totalSupply = tokens('1000000')
        it('Token has correct name', async () => {
            // Read token name
            // Check that name is correct
            expect(await token.name()).to.equal(name);
        })
    
        it('Token has correct symbol', async () => {
            expect(await token.symbol()).to.equal(symbol);
        })
    
        it('Token has correct decimals', async () => {
            expect(await token.decimals()).to.equal('18');
        })
    
        it('Token has correct total supply', async () => {
            expect(await token.totalSupply()).to.equal(totalSupply);
        })
    })

})
