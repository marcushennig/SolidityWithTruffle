pragma solidity ^0.5.0;

import "./SafeMathLib.sol";


library ERC20Lib {

    using SafeMathLib for uint;

    struct TokenStorage {

        mapping(address => uint) balances;
        mapping(address => mapping(address => uint)) allowed;
        uint totalSupply;
    }

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    function init(TokenStorage storage self, uint _initialSupply) public {

        self.totalSupply = _initialSupply;
        self.balances[msg.sender] = _initialSupply;
    }

    function transfer(TokenStorage storage self, address _to, uint _value) 
    public
    returns (bool success) {

        self.balances[msg.sender] = self.balances[msg.sender].minus(_value);
        self.balances[_to] = self.balances[_to].plus(_value);

        emit Transfer(msg.sender, _to, _value);

        success = true;
    }

    function transferFrom(TokenStorage storage self, address _from, address _to, uint _value)
    public
    returns (bool success) {
        
        uint _allowance = self.allowed[_from][msg.sender];

        self.balances[_to] = self.balances[_to].plus(_value);
        self.balances[_from] = self.balances[_from].minus(_value);
        
        self.allowed[_from][msg.sender] = _allowance.minus(_value);
        
        emit Transfer(msg.sender, _to, _value);

        success = true;
    }

    function balanceOf(TokenStorage storage self, address _owner) 
    public
    view
    returns (uint) {

        return self.balances[_owner];
    }

    function approve(TokenStorage storage self, address _spender, uint _value) 
    public
    returns (bool success) {

        self.allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(TokenStorage storage self, address _owner, address _spender)
    public
    view 
    returns (uint remaining) {
        
        remaining = self.allowed[_owner][_spender];
    }
}