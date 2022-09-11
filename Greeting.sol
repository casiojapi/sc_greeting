// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract Greeting {
    string public name;
    string public greetingPref = "hello ";

    // all vars can be stored in various ways.
        // storage (state variable -> stored in blockchain)
        // memory (temporary var -> only exists when function get called)
        // calldata (only available for external functions [can be called from other scs])
    constructor(string memory initName) {
        name = initName;
    }

    function setName(string memory newName) public {
        name = newName;
    }

    // "view" -> it will not change data on blockchain
    // "pure" -> doesn't read data from blockchain
    // in this case we use view bc we are getting data from the bc
    function greet() public view returns (string memory) {
        return string(abi.encodePacked(greetingPref, name));
    }
}

