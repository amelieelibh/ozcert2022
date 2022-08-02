// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./GetEtherPriceChainlink.sol";

contract ERC20Sell is ERC20, getEtherPrice{
    
    uint public tokenPrice = 10e18;
    
    
    constructor() ERC20("Blockdemy Community Token", "BCT") {
        _mint(address(this), 1000 * 1e18);
    }

    function getCostOf(uint _amount) public view returns(uint) {
        return (tokenPrice * _amount) / uint(getOnlyEthPrice());
    }

    function sellTokens(uint256 amount) public payable returns(bool){
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= totalSupply(), "Amount must be less than total supply");
        require(msg.value >= getCostOf(amount), "You don't have enough ether to buy this amount of tokens");
        payable(msg.sender).transfer(amount);
        return true;
    }
}