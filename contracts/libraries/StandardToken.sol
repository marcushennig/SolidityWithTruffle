pragma solidity ^0.5.0;

import "./ERC20Lib.sol";


contract StandardToken {

    using ERC20Lib for ERC20Lib.TokenStorage;
    ERC20Lib.TokenStorage private token;

    string public name = "ERC20 Token";
    string public symbol  = "SIM";
    uint public decimal = 18;
    uint public initialSupply = 100000;
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor () public {

        token.init(initialSupply);
    }

    function totalSupply()
    public 
    view
    returns (uint) {

        return token.totalSupply;
    }

    function balanceOf(address who)
    public 
    view
    returns (uint) {

        return token.balanceOf(who);
    }

    function allowance(address owner, address spender)
    public 
    view
    returns (uint) {

        return token.allowance(owner, spender);
    }

    function transfer(address to, uint value)
    public 
    returns (bool) {

        return token.transfer(to, value);
    }

    function transferFrom(address from, address to, uint value)
    public 
    returns (bool) {

        return token.transferFrom(from, to, value);
    }

    function approve(address spender, uint value)
    public
    returns (bool) {

        return token.approve(spender, value);
    }
}