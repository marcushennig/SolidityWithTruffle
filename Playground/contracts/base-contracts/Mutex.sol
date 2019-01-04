pragma solidity ^0.5.0;


contract Mutex {
    bool public locked;

    modifier noReentrancy() {

        require(!locked, "Reentrant call");
        
        locked = true;
        _;
        locked = false;
    }
}