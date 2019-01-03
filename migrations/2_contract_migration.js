const AnotherContract = artifacts.require("./AnotherContract.sol");
const MyContract = artifacts.require("./MyContract.sol");
const BallotContract = artifacts.require("./Ballot.sol");
const MyOwnedContract = artifacts.require("./MyOwnedContract.sol");

const Ethers = require('ethers');

module.exports = function(deployer) {
    
    deployer.deploy(AnotherContract);
    deployer.deploy(MyContract);

    var proposals = [ "Proposal_1", 
                      "Proposal_2"];

    // deployment steps
    deployer.deploy(BallotContract, proposals.map(e => Ethers.utils.toUtf8Bytes(e)));

    let initialPrice = 5000;
    // deployment steps
    deployer.deploy(MyOwnedContract, initialPrice);
};