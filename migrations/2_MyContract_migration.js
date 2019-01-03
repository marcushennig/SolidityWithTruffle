var MyContract = artifacts.require("./MyContract.sol");

module.exports = function(deployer) {
    // deployment steps
    deployer.deploy(MyContract);
};