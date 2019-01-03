var TestContract = artifacts.require("./Test.sol");

module.exports = function(deployer) {
    // deployment steps
    deployer.deploy(TestContract);
};