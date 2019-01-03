const AnotherContract = artifacts.require("./AnotherContract.sol");
const MyContract = artifacts.require("./MyContract.sol");


module.exports = function(deployer) {
    // deployment steps
    deployer.deploy(AnotherContract);
    deployer.deploy(MyContract);
};