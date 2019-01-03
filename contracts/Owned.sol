pragma solidity ^0.5.0;


contract Owned {
    
    address payable public owner;

    constructor() public {

        owner = msg.sender;
    }

    // This contract only defined a modifier but does not use
    // it: it will be used in derived contracts.
    // The function body is inseerted where the special symbol '_;'
    // in the definition of the modifier appears.
    // This means that if the owner call this functons, the function 
    // will be executed and otherwise, an exception is thrown.
    modifier onlyOwner {
        require(msg.sender == owner, 
        "Only the owner of this contract can call the function");
        _;
    }
}
