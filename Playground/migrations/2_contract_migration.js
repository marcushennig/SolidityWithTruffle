const AnotherContract = artifacts.require("./AnotherContract");

const MyContract = artifacts.require("./MyContract");
const MyContract2 = artifacts.require("./MyContract2");

const BallotContract = artifacts.require("./Ballot");
const MyOwnedContract = artifacts.require("./MyOwnedContract");

const Library = artifacts.require("./libraries/Set");
const Search =  artifacts.require("./libraries/Search");
const ContractUsingLibrary = artifacts.require("./libraries/LibraryContract");

const SafeMathLib = artifacts.require("./libraries/SafeMathLib");
const ERC20Lib = artifacts.require("./libraries/ERC20Lib");
const StandardToken = artifacts.require("./libraries/StandardToken");

const Ethers = require('ethers');

module.exports = function(deployer) {
    
    deployer.deploy(AnotherContract);
    deployer.deploy(MyContract);
    deployer.deploy(MyContract2);

    // Deploy contract using  library
    deployer.deploy(Library);
    deployer.deploy(Search);
    
    deployer.link(Search, ContractUsingLibrary)
    deployer.link(Library, ContractUsingLibrary)

    deployer.deploy(ContractUsingLibrary);

    // Deploy ERC20 Token
    deployer.deploy(SafeMathLib);
    deployer.link(SafeMathLib, ERC20Lib)
    deployer.deploy(ERC20Lib);
    deployer.link(ERC20Lib, StandardToken)
    deployer.deploy(StandardToken);


    // Deploy contract with contructor requiring 
    // a bytes32 array as arguments
    var proposals = [ "Proposal_1", 
                      "Proposal_2"];

    deployer.deploy(BallotContract, proposals.map(e => Ethers.utils.toUtf8Bytes(e)));

    // Deploy contract with simple argument
    let initialPrice = 5000;
    deployer.deploy(MyOwnedContract, initialPrice);
};