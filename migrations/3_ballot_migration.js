const BallotContract = artifacts.require("./Ballot.sol");
const Ethers = require('ethers');

module.exports = function(deployer) {
    
    var proposals = [ "Proposal_1", 
                      "Proposal_2"];

    // deployment steps
    deployer.deploy(BallotContract, proposals.map(e => Ethers.utils.toUtf8Bytes(e)));
};