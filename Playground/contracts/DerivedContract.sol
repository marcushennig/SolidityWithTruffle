pragma solidity ^0.5.0;
import "./base-contracts/Owned.sol";


contract Mortal is Owned {
    
    function kill() 
    public 
    onlyOwner {
        
        selfdestruct(owner);
    }
}


contract DerivedContract is Mortal {
    
    uint public data;

    function kill() public onlyOwner {
        
        data = 2;
        super.kill();
    }
}