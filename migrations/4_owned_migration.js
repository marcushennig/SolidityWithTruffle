const MyOwnedContract = artifacts.require("./MyOwnedContract.sol");

module.exports = function(deployer) {
    
    let initialPrice = 5000;
    // deployment steps
    deployer.deploy(MyOwnedContract, initialPrice);
};