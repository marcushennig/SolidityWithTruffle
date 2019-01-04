pragma solidity ^0.5.0;

import "./base-contracts/Owned.sol";
import "./base-contracts/Priced.sol";


contract MyOWnedContract is Owned, Priced {

    uint public price;

    /** Build new contract and set the
    initial price for functions */
    constructor(uint initialPrice) 
    public {

        price = initialPrice;
    }

    /**
    Only the contract owner can change the price
    @param newPrice New price for all functions having a price tag
     */
    function changePrice(uint newPrice) 
    external 
    onlyOwner {
        price = newPrice;    
    }

    function close() public onlyOwner {
        
        selfdestruct(owner);    
    }

    /**
     Function with a price. Add the 'payable' keyword
     otherwise the function will reject any payments
     @param w Width 
     @param h Height
     */
    function expensiveFunction(uint w, uint h) 
    public
    payable 
    costs(price)
    returns (uint area) {

        area = w * h;        
    }
}