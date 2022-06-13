// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol"; // importing library.
// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// to give ABI to the contract

contract FundMe{
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50*1e18;

    address[] public funders;

    mapping(address=>uint256) public addressToAmountFunded;

    function fund() public payable{
        // Want to be able to set a minimu fund amount in USD
        // Step 1: How do we send ETH to this contract?

        // require(msg.value >= minimumUsd, "Didn't send enough!");
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough!");
        // we can use amount of ether in msg.value e.x: 1e18 which means 1*10^18 wei which is 1 ether.
        // 18 decimal places 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }

    // function getPrice() public view returns(uint256){
    //         // ABI
    //         // Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    //         // (Rinkeby chain address)
    //         AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    //         (, int price,,,) = priceFeed.latestRoundData();
    //         // visit: https://docs.chain.link/docs/get-the-latest-price/ for the texts between the commas.
    //         // prices are in int as some of them can be negative.
    //         // ETH in terms of USD
    //         // 3000.00000000
    //         return uint256(price * 1e10);
    // }

    // function getVersion() public view returns(uint256){
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    //     return priceFeed.version();
    // }

    // function getConversionRate(uint256 ethAmount) public view returns(uint256){
    //     uint256 ethPrice = getPrice();
    //     uint256 ethAmountInUsd = (ethPrice*ethAmount) / 1e18;
    //     // dividing by 1e18 as to avoid 36 decimal answer.
    //     return ethAmountInUsd;
    // }

    address public owner;
    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender == owner, "Sender is not the Owner!");
        // double '=' indicates checking of the equation and single indicates the value change.
        _;
        // this indicates first run the modifier then the function.
    }

    function withdraw() public{
        // require(msg.sender == owner);

        // (starting index; ending index; setp amount)
        for(uint256 funderIndex=0; funderIndex<funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        //reset the array as we have withdrawn the money
        funders = new address[](0);
        //'0' here indicates that the new address will have to start again from zero.

        // // 1. transfer (2300 gas, throws error)
        // payable(msg.sender).transfer(address(this).balance);
        // // msg.sender => address
        // // payable(msg.sender) => payable address

        // // 2. send(2300 gas, returns bool)
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed!");

        // 3. call(forward all gas or set gas, returns bool) =>recommended way
        // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed!");
    }
}
