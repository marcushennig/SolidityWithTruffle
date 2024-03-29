pragma solidity ^0.5.0;

import "./AnotherContract.sol";


/** @title Test contract */
contract MyContract {

    /** State variable */
    uint public storedData;
    uint private sum;
    mapping (address => uint) private donations;
    
    event Deposit(
        address indexed _from, 
        bytes32 indexed _id, 
        uint _value
    );

    AnotherContract public anotherContract = new AnotherContract();
    
    /**
    @dev This function is executed whenever 
    the contract receives plain Ether  
    */
    function () external payable {
        
        // the fallback function can execute complex 
        // operations as long as there is enough gas passed on to it
        // How to get the Ether back, send to this contract?
        donations[msg.sender] += msg.value;
    }

    /** 
    @dev Callculates a rectangle's surface and perimeter
    @param w Width of the retangle
    @param h Heigt of the rectangle 
    @return s Surface 
    @return p Perimeter 
    */
    function rectangle(uint w, uint h) 
    external
    pure
    returns (uint, uint) {
        
        return (w * h, 2 * (w + h));
    }  
    
    function getDataFromAnotherContract() 
    public 
    view 
    returns (uint) {
        
        return anotherContract.data();
    }

    function depositEther(bytes32 _id) public payable {

        // Events are emitted using 'emit', followed
        // by the name of the event and the arguments (if any)
        // in parentheses. Any usch invovocation can be detected from the 
        // the JS API by filtering for 'Deposit'
        emit Deposit(msg.sender, _id, msg.value);
    }

    function taker(uint _a, uint _b) public {
    
        sum = _a + _b;
    }

    function f1(uint _a, uint _b) 
    public 
    pure 
    returns (uint _sum, uint _prod) {
        
        _sum = _a + _b;
        _prod = _a * _b;
    }
    
    function f2(uint _a, uint _b) 
    public 
    pure 
    returns (uint _sum, uint _prod) {
        
        return (_a + _b, _a * _b);
    }

    function f3(uint _a, uint _b) 
    public 
    pure 
    returns (uint, uint) {
        
        return (_a + _b, _a * _b);
    }

    function f4(uint _a)
    public
    pure
    returns (uint _r) {
        _r = _a;
    }

    function f4(uint _a, bool _really)
    public
    pure
    returns (uint _r) {
        
        if (_really) {
            _r = _a;
        }
    }

    function testAddress() 
    public 
    view {
        
        address myAddress = address(this);
        address receiver = address(0x1b33f04117AF1A54683A012CAdDaA7f1455f7769);

        if (myAddress.balance > 100 && receiver.balance > 0) {
            
            
        }   
    }
}