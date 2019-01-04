pragma solidity ^0.5.0;


contract Priced {

    modifier costs(uint price) {
        if (msg.value >= price) {
            _;
        }
    }
}