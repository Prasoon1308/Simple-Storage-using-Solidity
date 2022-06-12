// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";
// also you can copy the contract from other file. 

contract StorageFactory{
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContracty() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
// for storing values in array.
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        // Address
        // Application Binary Interface(ABI)
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
        // simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber); can also be used directly
    }
// for reading values from array.
    function sfGet(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public view returns(uint256){
       SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
       return simpleStorage.retrieve(); 
        //    simpleStorageArray[_simpleStorageIndex].retrieve(); can also be used directly.
    }
}