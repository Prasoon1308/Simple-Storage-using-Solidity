// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// this ABI defines the external functions implemented by Data Feeds

library PriceConverter{
    function getPrice() internal view returns(uint256){
            // ABI
            // Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
            // (Rinkeby chain address)
            AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
            (, int price,,,) = priceFeed.latestRoundData();
            // visit: https://docs.chain.link/docs/price-feeds-api-reference/ for the texts between the commas.
            // prices are in int as some of them can be negative.
            // ETH in terms of USD
            // 3000.00000000
            return uint256(price * 1e10);
    }

    function getVersion() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice*ethAmount) / 1e18;
        // dividing by 1e18 as to avoid 36 decimal answer.
        return ethAmountInUsd;
    }

}
