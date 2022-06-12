// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage{
    uint256 favoritenumber;

    function store(uint256 _favoritenumber) public virtual{
        favoritenumber=_favoritenumber;
    }
    // variables will exists only through the functions.
    
    function retrieve() public view returns(uint256){
        return favoritenumber;
    }
    // view and pure functions do not consume any gas.

    struct People{
        uint256 favoritenumber;
        string name;
    }
    People[] public people;

        mapping(string=>uint256 ) public nametofavoritenumber;

    function addPerson(string memory _name, uint256 _favoritenumber) public{
        People memory newPerson=People({favoritenumber: _favoritenumber, name: _name});
        people.push(newPerson);
        // or use people.pus(People(_favoritenumber, _name)) only.
        nametofavoritenumber[_name]=_favoritenumber;
    }
    // calldata, memory, storage

}