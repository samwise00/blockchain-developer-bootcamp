//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string public name;
    string public symbol;
    uint256 public decimals = 18; // universal standard for erc-20 tokens
    uint256 public totalSupply = 1000000 * (10**decimals); // 1,000,000 x 10^18

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply * (10**decimals);
    }


}
