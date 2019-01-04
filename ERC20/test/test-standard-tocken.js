const StandardToken = artifacts.require("StandardToken");
//const web3 = require('web3');
const BN = require('bn.js');

contract("StandardToken tests", async accounts => {
    

    it("Correct initial supply", async () => {

        let token = await StandardToken.deployed();
        let initialSupply = await token.initialSupply();

        assert.equal(100000, initialSupply.toNumber());
    }); 
    
    it("Correct symbol", async () => {
      
        let token = await StandardToken.deployed();
        let result = await token.symbol();

        assert.equal("SIM", result);
    });

    it("Correct total supply", async () => {

        let token = await StandardToken.deployed();
        let totalSupply = await token.totalSupply();

        assert.equal(100000, totalSupply.toNumber());
    });

    it("Correct balance of owner", async () => {

        let token = await StandardToken.deployed();

        let who = accounts[0];
 
        let balance = await token.balanceOf(who);

        assert.equal(100000, balance.toNumber());
    });

    it("Transfer ether", async () => {

        let token = await StandardToken.deployed();
       
        let sender = accounts[0];
        let receiver = accounts[1];

        let transferedValue = 1000; // web3.utils.toWei(new BN(1), "ether");
        
        let initialBalanceReceiver = await token.balanceOf(receiver);
        let initialBalanceSender = await token.balanceOf(sender)

        let result = await token.transfer(receiver, transferedValue, {from: sender});

        let finalBalanceReceiver = await token.balanceOf(receiver);
        let finalBalanceSender = await token.balanceOf(sender);

        let receivedValue = finalBalanceReceiver.sub(initialBalanceReceiver);
        let sentValue = initialBalanceSender.sub(finalBalanceSender);

        //assert.equal(sentValue.toNumber(), transferedValue + transactionFee);
        assert.isTrue(transferedValue == receivedValue.toNumber());
    });
});