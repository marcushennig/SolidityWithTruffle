pragma solidity ^0.5.0;


contract MyContract2 {

    uint[] public x; // The data location of c is 'storage' 

    /**
    https://solidity.readthedocs.io/en/latest/types.html#data-location
    @param memoryArray Data location of 'memoryArray' is memory
     */
    function f(uint[] memory memoryArray)
    public {
        
        x = memoryArray; // copies the whole array to storage
        uint[] storage y = x; // assigns a point
        y.length = 2; // modifies x through y
        delete x; // clears the array, also modifes y
        
    }

}