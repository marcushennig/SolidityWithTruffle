pragma solidity ^0.5.0;

import "./interfaces/IERC1410.sol";


/**
 * @title Reference implementation of partially-fungible tokens
 */
contract PartialFungibleToken is IERC1410 {

    // Represents a fungible set of tokens.
    struct Tranche {

        uint256 amount;
        bytes32 tranche;
    }

    uint256 public totalSupply;

    string public name;

    string public symbol;

    // Mapping from investor to aggregated balance across all investor token sets
    mapping (address => uint256) public balances;

    // Mapping from investor to their tranches
    mapping (address => Tranche[]) public tranches;

    // Mapping from (investor, tranche) to index of corresponding tranche in tranches
    mapping (address => mapping (bytes32 => uint256)) public trancheToIndex;

    // Mapping from (investor, tranche, operator) to approved status
    mapping (address => mapping (bytes32 => mapping (address => bool))) public trancheApprovals;

    // Mapping from (investor, operator) to approved status (can be used against any tranches)
    mapping (address => mapping (address => bool)) public approvals;

    /// @notice Counts the sum of all tranche balances assigned to an owner
    /// @param _owner An address for whom to query the balance
    /// @return The number of tokens owned by `_owner`, possibly zero
    function balanceOf(address _owner) 
    external 
    view 
    returns (uint256) {
      
        return balances[_owner];
    }

    /// @notice Counts the balance associated with a specific tranche assigned to an owner
    /// @param _tranche The tranche for which to query the balance
    /// @param _owner An address for whom to query the balance
    /// @return The number of tokens owned by `_owner` with the metadata associated with `_tranche`, possibly zero
    function balanceOfTranche(bytes32 _tranche, address _owner) 
    external 
    view 
    returns (uint256) {

        return tranches[_owner][trancheToIndex[_owner][_tranche]].amount;
    }

    /// @notice Transfers the ownership of tokens from a specified tranche from one address to another address
    /// @param _tranche The tranche from which to transfer tokens
    /// @param _to The address to which to transfer tokens to
    /// @param _amount The amount of tokens to transfer from `_tranche`
    /// @param _data Additional data attached to the transfer of tokens
    /// @return A reason code related to the success of the send operation
    /// @return The tranche to which the transferred tokens were allocated for the _to address
    function sendTranche(bytes32 _tranche, address _to, uint256 _amount, bytes _data) 
    external 
    returns (byte, bytes32) {
        
        (byte reason, bytes32 newTranche) = _sendTranche(msg.sender, _to, _amount, _tranche, _data, "");
        
        emit SentTranche(
            address(0),
            msg.sender,
            _to,
            _tranche,
            newTranche,
            _amount,
            _data,
            ""
        );
        return (reason, newTranche);
    }

    function _sendTranche(address _from, address _to, uint256 _amount, bytes32 _tranche, bytes _data, bytes _operatorData) 
    internal 
    returns (byte, bytes32) {

        if (tranches[_from][trancheToIndex[_from][_tranche]].amount < _amount) {
            return (hex"00", bytes32(""));
        }

        // Checking the overflow condition in subtraction TODO: Create a library for that similar to SafeMath
        if (tranches[_from][trancheToIndex[_from][_tranche]].amount > tranches[_from][trancheToIndex[_from][_tranche]].amount - _amount) {
            return (hex"10", bytes32(""));
        }

        // Checking the overflow condition in addition TODO: Create a library for that similar to SafeMath
        if (tranches[_to][trancheToIndex[_to][_tranche]].amount > tranches[_to][trancheToIndex[_to][_tranche]].amount + _amount) {
            return (hex"10", bytes32(""));
        }

        tranches[_from][trancheToIndex[_from][_tranche]].amount = tranches[_from][trancheToIndex[_from][_tranche]].amount - _amount;
        balances[_from] = balances[_from] - _amount;
        tranches[_to][trancheToIndex[_to][_tranche]].amount = tranches[_to][trancheToIndex[_to][_tranche]].amount + _amount;
        balances[_to] = balances[_to] + _amount;

        // TODO: If transferring to a registered contract, call its callback function

        return (hex"01", _tranche);

    }

    /// @notice Transfers the ownership of tokens from a specified tranche from one address to another address
    /// @param _from The address from which to transfer tokens from
    /// @param _to The address to which to transfer tokens to
    /// @param _tranche The tranche from which to transfer tokens
    /// @param _amount The amount of tokens to transfer from `_tranche`
    /// @param _data Additional data attached to the transfer of tokens
    /// @param _operatorData Additional data attached to the transfer of tokens by the operator
    /// @return A reason code related to the success of the send operation
    /// @return The tranche to which the transferred tokens were allocated for the _to address
    function operatorSendTranche(bytes32 _tranche, address _from, address _to, uint256 _amount, bytes _data, bytes _operatorData) 
    external 
    returns (byte, bytes32) {

        // Check operator is approved
        if ((!trancheApprovals[_from][_tranche][msg.sender]) && (!approvals[_from][msg.sender])) {
            return (hex"20", bytes32(""));
        }
        
        (byte reason, bytes32 newTranche) = _sendTranche(_from, _to, _amount, _tranche, _data, _operatorData);
        
        emit SentTranche(
            msg.sender,
            _from,
            _to,
            _tranche,
            newTranche,
            _amount,
            _data,
            _operatorData
        );
        return (reason, newTranche);
    }

    /// @notice Allows enumeration over an individual owners tranches
    /// @param _owner An address over which to enumerate tranches
    /// @param _index The index of the tranche
    /// @return The tranche key corresponding to `_index`
    function trancheByIndex(address _owner, uint256 _index) 
    external 
    view 
    returns (bytes32) {
    
        return tranches[_owner][_index].tranche;
    }

    /// @notice Enables caller to determine the count of tranches owned by an address
    /// @param _owner An address over which to enumerate tranches
    /// @return The number of tranches owned by an `_owner`
    function tranchesOf(address _owner) 
    external 
    view 
    returns (uint256) {
    
        return tranches[_owner].length;
    }

    /// @notice Defines a list of operators which can operate over all addresses and tranches
    /// @return The list of default operators
    function defaultOperators() 
    public 
    view 
    returns (address[]) {
    
        // No default operators
        return new address[](0);
    }

    /// @notice Defines a list of operators which can operate over all addresses for the specified tranche
    /// @return The list of default operators for `_tranche`
    function defaultOperatorsTranche(bytes32 _tranche) 
    public 
    view 
    returns (address[]) {

        // No default operators
        return new address[](0);
    }


    /// @notice Authorises an operator for all tranches of `msg.sender`
    /// @param _operator An address which is being authorised
    function authorizeOperator(address _operator) 
    public {
       
        approvals[msg.sender][_operator] = true;

        emit AuthorizedOperator(_operator, msg.sender);
    }

    /// @notice Authorises an operator for a given tranche of `msg.sender`
    /// @param _tranche The tranche to which the operator is authorised
    /// @param _operator An address which is being authorised
    function authorizeOperatorTranche(bytes32 _tranche, address _operator) 
    public {
        trancheApprovals[msg.sender][_tranche][_operator] = true;

        emit AuthorizedOperatorTranche(_tranche, _operator, msg.sender);
    }

    /// @notice Revokes authorisation of an operator previously given for all tranches of `msg.sender`
    /// @param _operator An address which is being de-authorised
    function revokeOperator(address _operator) 
    public {

        approvals[msg.sender][_operator] = false;
        emit RevokedOperator(_operator, msg.sender);
    }

    /// @notice Revokes authorisation of an operator previously given for a specified tranche of `msg.sender`
    /// @param _tranche The tranche to which the operator is de-authorised
    /// @param _operator An address which is being de-authorised
    function revokeOperatorTranche(bytes32 _tranche, address _operator) 
    public {

        trancheApprovals[msg.sender][_tranche][_operator] = false;
        emit RevokedOperatorTranche(_tranche, _operator, msg.sender);
    }

    /// @notice Determines whether `_operator` is an operator for all tranches of `_owner`
    /// @param _operator The operator to check
    /// @param _owner The owner to check
    /// @return Whether the `_operator` is an operator for all tranches of `_owner`
    function isOperatorFor(address _operator, address _owner) 
    public 
    view 
    returns (bool) {

        return approvals[_owner][_operator];
    }

    /// @notice Determines whether `_operator` is an operator for a specified tranche of `_owner`
    /// @param _tranche The tranche to check
    /// @param _operator The operator to check
    /// @param _owner The owner to check
    /// @return Whether the `_operator` is an operator for a specified tranche of `_owner`
    function isOperatorForTranche(bytes32 _tranche, address _operator, address _owner) 
    public 
    view 
    returns (bool) {

        return trancheApprovals[_owner][_tranche][_operator];
    }

    /// @notice Increases totalSupply and the corresponding amount of the specified owners tranche
    /// @param _tranche The tranche to allocate the increase in balance
    /// @param _owner The owner whose balance should be increased
    /// @param _amount The amount by which to increase the balance
    /// @param _data Additional data attached to the minting of tokens
    /// @return A reason code related to the success of the mint operation
    function mint(bytes32 _tranche, address _owner, uint256 _amount, bytes _data) 
    public 
    returns (byte reason) {

        // TODO: Apply the check for Authorization of Mint function
        if (tranches[_owner][trancheToIndex[_owner][_tranche]].amount + _amount < tranches[_owner][trancheToIndex[_owner][_tranche]].amount) {
            return (hex"10");
        }

        if (balances[_owner] + _amount < balances[_owner]) {
            return (hex"10");
        }

        if (totalSupply + _amount < totalSupply) {
            return (hex"10");
        }
        tranches[_owner][trancheToIndex[_owner][_tranche]].amount = tranches[_owner][trancheToIndex[_owner][_tranche]].amount + _amount;
        balances[_owner] = balances[_owner] + _amount;
        totalSupply = totalSupply + _amount;

        emit Minted(_owner, _tranche, _amount, _data);
        emit SentTranche(
            msg.sender,
            address(0),
            _owner,
            bytes32(""),
            _tranche,
            _amount,
            _data,
            ""
        );
        return hex"01";
    }

    /// @notice Decreases totalSupply and the corresponding amount of the specified owners tranche
    /// @param _tranche The tranche to allocate the decrease in balance
    /// @param _owner The owner whose balance should be decreased
    /// @param _amount The amount by which to decrease the balance
    /// @param _data Additional data attached to the burning of tokens
    /// @return A reason code related to the success of the burn operation
    function burn(bytes32 _tranche, address _owner, uint256 _amount, bytes _data) 
    public returns (byte reason) 
    {
        // TODO: Apply the check for Authorization of burn function
        if (tranches[_owner][trancheToIndex[_owner][_tranche]].amount - _amount > tranches[_owner][trancheToIndex[_owner][_tranche]].amount) {
            return (hex"10");
        }
        
        if (balances[_owner] - _amount > balances[_owner]) {
            return (hex"10");
        }
        
        if (totalSupply - _amount > totalSupply) {
            return (hex"10");
        }
        
        tranches[_owner][trancheToIndex[_owner][_tranche]].amount = tranches[_owner][trancheToIndex[_owner][_tranche]].amount - _amount;
        balances[_owner] = balances[_owner] - _amount;
        totalSupply = totalSupply - _amount;
        
        emit Burnt(_owner, _tranche, _amount, _data);
        emit SentTranche(
            msg.sender,
            _owner,
            address(0),
            _tranche,
            bytes32(""),
            _amount,
            _data,
            ""
        );
        return hex"01";
    }
}