pragma solidity ^0.5.0;


library Set {

    // Define a new datatype that will be used to 
    // hold its data in the calling contract
    struct Data {

        mapping(uint => bool) flags;
    }

    // Note that the first parameter is of type 'storage reference'
    // and thus only its storage address and not its contents is 
    // passed as part of the call. This is a special feature of library 
    // functions. It is idiomatic to call the first parameter 'self', 
    // if the function can be seen as a method of that object.
    function insert (Data storage self, uint value)
    public 
    returns (bool) {
        
        if (self.flags[value]) {
            // Already there
            return false;
        }
        self.flags[value] = true;
        return true;
    }
    
    function remove(Data storage self, uint value)
    public 
    returns (bool) {

        if (!self.flags[value]) {

            return false;
        }

        self.flags[value] = false;
        return true;
    }

    function contains(Data storage self, uint value) 
    public 
    view
    returns (bool) {
        return self.flags[value];
    }
}


library Search {

    function rectangle (uint w, uint h) 
    public
    pure
    returns (uint) {
        return w * h;
    }

    function indexOf(uint[] storage self, uint value)
    public
    view
    returns (uint) {

        for (uint i = 0; i < self.length; i++) {
        
            if (self[i] == value) {
                return i;
            }
        }

        return uint(-1);
    }
}


contract LibraryContract {
    
    // https://blog.aragon.org/library-driven-development-in-solidity-2bebcaf88736/
    using Set for Set.Data;

    Set.Data private knownValues;
    
    uint[] private data;
    using Search for uint[];
    
    function searchValue(uint value) 
    public 
    view 
    returns (uint, uint) {

        uint index1 = data.indexOf(value);
        uint index2 = Search.indexOf(data, value);
        
        uint area = Search.rectangle(2, 4);

        return (index1 + area, index2);
    }

    function register(uint value)
    public {
        
        // The libnrary functions can be called without a 
        // specific instance of the library, since the "instance"
        // will be the current contract
        // Here, all variables of type Set.Data have
        // corresponding member functions.
        // The following function call is identical to
        // `Set.insert(knownValues, value)`
        require(knownValues.insert(value));
    }
}
