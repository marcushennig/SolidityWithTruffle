const SafeMathLib = artifacts.require("SafeMathLib");
const ERC20Lib = artifacts.require("ERC20Lib");
const StandardToken = artifacts.require("StandardToken");
const Token = artifacts.require("Token");

module.exports = function(deployer) {
    
    deployer.deploy(Token);

    // Deploy ERC20 Token
    /*deployer.deploy(SafeMathLib);
    deployer.link(SafeMathLib, ERC20Lib)
    deployer.deploy(ERC20Lib);
    deployer.link(ERC20Lib, StandardToken)
    deployer.deploy(StandardToken);*/
    
};