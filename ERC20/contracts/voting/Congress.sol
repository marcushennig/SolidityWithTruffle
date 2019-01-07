pragma solidity ^0.5.0;


contract Owned {
    
    address public owner;

    constructor() public {

        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner is allowed");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {

        owner = newOwner;
    }
}


contract TokenRecipient {

    event ReceivedEther(address _sender, uint _amount);
    event ReceivedTokens(address _from, uint256 _value, address _token, bytes _extraData);

    function receiveApproval(address _from, uint256 _value, address _token, bytes memory _extraData) public {
        
        Token t = Token(_token);
        
        require(t.transferFrom(_from, address(this), _value));

        emit ReceivedTokens(_from, _value, _token, _extraData);
    }
}


interface Token {

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}


/**
 * Based on https://www.ethereum.org/dao
 * TODO: Continue tutorial
 */
contract Congress is Owned, TokenRecipient {

    uint public minimumQuorum;
    uint public debatingPeriodeInMinutes;
    int public majorityMargin;
    
    Proposal[] public proposals;
    
    uint public numProposals;
    mapping (address => uint) public memberId;
    Member[] public members;

    event ProposalAdded(uint proposalId, address recipient, uint amount, string description);
    event Voted(uint proposalId, bool position, address voter, string justification);
    event ProposalTallied(uint proposalId, int result, uint quorum, bool active);
    event MembershipChanged(address member, bool isMember);
    event ChangeOfRules(uint newMinimumQuorum, uint newDebatingPeriodInMinutes, int newMajorityMargin);

    struct Proposal {
        
        address recipient;
        uint amount;
        string description;
        bool executed;
        bool passed;
        uint numberOfVotes;
        int currentResult;
        bytes32 proposalHash;
        Vote[] votes;
        mapping (address => bool) voted;
    } 

    struct Member {

        address member;
        string name;
        uint memberSince;
    }

    struct Vote {

        bool inSupport;
        address voter;
        string justification;
    }

    /**
    Modifier allows only shareholders 
    to vote and create new proposals
     */
    modifier onlyMembers() {

        require(memberId[msg.sender] != 0, "Must be member");
        _;
    }

    /**
    Constructor 
     */
    constructor(
        uint _minimumQuorum,
        uint _debatingPeriodeInMinutes,
        int _majorityMargin
    ) 
    public 
    payable {

        // changeVotingRules(_minimumQuorum, _debatingPeriodeInMinutes, _majorityMargin);

        addMember(address(0), "");
        addMember(owner, "founder");
    }
    
    /** 
    * Add member
    *
    * Make 'targetMember' a member named 'memberName'
    *
    * @param targetMember ethereum address to be added
    * @param memberName public name for the member
    */
    function addMember(address targetMember, string memory memberName) 
    public 
    onlyOwner {
        
        uint id = memberId[targetMember];
        
        if (id == 0) {

            memberId[targetMember] = members.length;
            id = members.length++;
        }

        members[id] = Member({
            member: targetMember, 
            memberSince: now, 
            name: memberName
        });
        
        emit MembershipChanged(targetMember, true);
    }

    /**
    * Remove Member 
    */
    function removeMember(address targetMember) 
    public 
    onlyOwner {
        
        require(memberId[targetMember] != 0);

        for (uint i = memberId[targetMember]; i < members.length - 1; i++) {

            members[i] = members[i + 1];
            memberId[members[i].member] = i;
        }
        memberId[targetMember] = 0;
        
        delete members[members.length-1];
        members.length--;
        //emit MembershipChanged(targetMember, false);
    }
}