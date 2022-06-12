// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// inherit other contract 'SimpleStorage'
contract ExtraStorage is SimpleStorage{
    // virtual override - to change the functionality of first contract.
    function store(uint256 _favoritenumber)public override{
        favoritenumber = _favoritenumber + 5;
    }
}