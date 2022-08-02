// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract getEtherPrice {
    AggregatorV3Interface internal priceFeed;
    address constant priceAddress = 	0x8A753747A1Fa494EC906cE90E9f37563A8AF630e;

    constructor() {
        priceFeed = AggregatorV3Interface(priceAddress);
    }
     // SI EL ETHER ESTÁ EN 1,656
     // CHAINLINK => 1,668.19499313 
    function getEthPrice() public view returns(
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    ){
        (roundId, answer, startedAt, updatedAt, answeredInRound) = priceFeed.latestRoundData();        
    }

    function getOnlyEthPrice() public view returns(
        int256 answer
    ){
        (, answer, , , ) = priceFeed.latestRoundData();        
    }
}