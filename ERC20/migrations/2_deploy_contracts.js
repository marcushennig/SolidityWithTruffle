const SafeMathLib = artifacts.require("./libraries/SafeMathLib");
const ERC20Lib = artifacts.require("./libraries/ERC20Lib");
const StandardToken = artifacts.require("./libraries/StandardToken");

module.exports = function(deployer) {
    
    // Deploy ERC20 Token
    deployer.deploy(SafeMathLib);
    deployer.link(SafeMathLib, ERC20Lib)
    deployer.deploy(ERC20Lib);
    deployer.link(ERC20Lib, StandardToken)
    deployer.deploy(StandardToken);
    
};