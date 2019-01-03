const MyOwnedContract = artifacts.require("./MyOwnedContract.sol");

module.exports = function(deployer) {

    // deployment steps
    deployer.deploy(MyOwnedContract);
};