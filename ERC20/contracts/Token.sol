pragma solidity ^0.5.0;


contract Token {

    string public name = "ERC20 Token";
    string public symbol  = "TOK";
    uint public decimal = 18;
    uint public totalSupply;
    
    mapping(address => uint) public balances;

    constructor() public {
        
        balances[msg.sender] = 100000;
    }
    
    function balanceOf(address _owner) 
    public 
    view 
    returns (uint) {

        return balances[_owner];
    }

    function transfer(address _to, uint _value) 
    public
    returns (bool) {
        
        require(balances[msg.sender] >= _value, "Insufficient funds");
        
        balances[msg.sender] -= _value;
        balances[_to] += _value;

        return true;
    }
}