pragma solidity ^0.4.24;

import "../721/ERC721.sol";
import "../721/ERC721Receiver.sol";
import "./TRNOwners.sol";

contract TRNOwnership is TRNOwners, ERC721 {
    /**
     * Constructor
     */
    constructor() public {

    }

    /**
     * This emits when ownership of any TRN changes by any mechanism.
     */
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

    /**
     * This emits when the approved address for an RTN is changed or reaffirmed.
     */
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

    /**
     * This emits when an operator is enabled or disabled for an owner.
     * The operator can manage all RTNs of the owner.
     */
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    /**
     * @dev Transfer the `_tokenId` to `_to` directly
     * @param _tokenId The room night token
     * @param _to The target owner
     */
    function _transfer(uint256 _tokenId, address _to) private {
        // Find the FROM address
        address from = dataSource.roomNightIndexToOwner(_tokenId);

        // Remove room night from the `from`
        _removeRoomNight(from, _tokenId);

        // Add room night to the `_to`
        _pushRoomNight(_to, _tokenId, false);

        // Change the owner of `_tokenId`
        // Remove approval of `_tokenId`
        dataSource.transferTokenTo(_tokenId, _to);

        // Emit Transfer event
        emit Transfer(from, _to, _tokenId);
    }

    function _safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes _data)
        private
        validToken(_tokenId)
        canTransfer(_tokenId) {
        // The token's owner is equal to `_from`
        address owner = dataSource.roomNightIndexToOwner(_tokenId);
        require(owner == _from);

        // Avoid `_to` is equal to address(0)
        require(_to != address(0));

        _transfer(_tokenId, _to);

        uint256 codeSize;
        assembly { codeSize := extcodesize(_to) }
        if (codeSize == 0) {
            return;
        }
        bytes4 retval = ERC721Receiver(_to).onERC721Received(_from, _tokenId, _data);
        require (retval == dataSource.ERC721_RECEIVED());
    }

    /**
     * @dev Count all TRNs assigned to an owner.
     *      Throw when `_owner` is equal to address(0)
     * @param _owner An address for whom to query the balance.
     * @return The number of TRNs owned by `_owner`.
     */
    function balanceOf(address _owner) external view returns (uint256) {
        require(_owner != address(0));
        return dataSource.balanceOf(_owner);
    }

    /**
     * @dev Find the owner of an TRN
     *      Throw unless `_tokenId` more than zero
     * @param _tokenId The identifier for an TRN
     * @return The address of the owner of the TRN
     */
    function ownerOf(uint256 _tokenId) external view returns (address) {
        require(_tokenId > 0);
        return dataSource.roomNightIndexToOwner(_tokenId);
    }

    /**
     * @dev Transfers the ownership of an TRN from one address to another address.
     *      Throws unless `msg.sender` is the current owner or an approved address for this TRN.
     *      Throws if `_tokenId` is not a valid TRN. When transfer is complete, this function checks if 
     *      `_to` is a smart contract (code size > 0). If so, it calls `onERC721Received` on `_to` and 
     * throws if the return value is not `bytes4(keccak256("onERC721Received(address,uint256,bytes)"))`.
     * @param _from The current owner of the TRN
     * @param _to The new owner
     * @param _tokenId The TRN to transfer
     * @param _data Additional data with no specified format, sent in call to `_to`
     */
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes _data) external payable {
        _safeTransferFrom(_from, _to, _tokenId, _data);
    }

    /**
     * @dev Same like safeTransferFrom with an extra data parameter, except this function just sets data to ""(empty)
     * @param _from The current owner of the TRN
     * @param _to The new owner
     * @param _tokenId The TRN to transfer
     */
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        _safeTransferFrom(_from, _to, _tokenId, "");
    }

    /**
     * @dev Transfers the ownership of an TRN from one address to another address.
     *      Throws unless `msg.sender` is the current owner or an approved address for this TRN.
     *      Throws if `_tokenId` is not a valid TRN.
     * @param _from The current owner of the TRN
     * @param _to The new owner
     * @param _tokenId The TRN to transfer
     */
    function transferFrom(address _from, address _to, uint256 _tokenId) 
        external 
        payable
        validToken(_tokenId)
        canTransfer(_tokenId) {
        // The token's owner is equal to `_from`
        address owner = dataSource.roomNightIndexToOwner(_tokenId);
        require(owner == _from);

        // Avoid `_to` is equal to address(0)
        require(_to != address(0));

        _transfer(_tokenId, _to);
    }

    /**
     * @dev Transfers the ownership of TRNs from one address to another address.
     *      Throws unless `msg.sender` is the current owner or an approved address for this TRN.
     *      Throws if `_tokenIds` are not valid TRNs.
     * @param _from The current owner of the TRN
     * @param _to The new owner
     * @param _tokenIds The TRNs to transfer
     */
    function transferFromInBatch(address _from, address _to, uint256[] _tokenIds) 
        external
        payable
        validTokenInBatch(_tokenIds)
        canTransferInBatch(_tokenIds) {
        for(uint256 i = 0; i < _tokenIds.length; i++) {
            // The token's owner is equal to `_from`
            address owner = dataSource.roomNightIndexToOwner(_tokenIds[i]);
            require(owner == _from);

            // Avoid `_to` is equal to address(0)
            require(_to != address(0));

            _transfer(_tokenIds[i], _to);
        }
    }

    /**
     * @dev Set or reaffirm the approved address for an TRN.
     *      Throws unless `msg.sender` is the current TRN owner, or an authorized
     * @param _approved The new approved TRN controller
     * @param _tokenId The TRN to approve
     */
    function approve(address _approved, uint256 _tokenId) 
        external 
        payable 
        validToken(_tokenId)
        canOperate(_tokenId) {
        address owner = dataSource.roomNightIndexToOwner(_tokenId);
        
        dataSource.approveTokenTo(_tokenId, _approved);
        emit Approval(owner, _approved, _tokenId);
    }

    /**
     * @dev Enable or disable approval for a third party ("operator") to manage 
     *      all of `msg.sender`'s assets.
     *      Emits the ApprovalForAll event. 
     * @param _operator Address to add to the set of authorized operators.
     * @param _approved True if the operator is approved, false to revoke approval.
     */
    function setApprovalForAll(address _operator, bool _approved) external {
        require(_operator != address(0));
        dataSource.approveOperatorTo(_operator, msg.sender, _approved);
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    /**
     * @dev Get the approved address for a single TRN.
     *      Throws if `_tokenId` is not a valid TRN.
     * @param _tokenId The TRN to find the approved address for
     * @return The approved address for this TRN, or the zero address if there is none
     */
    function getApproved(uint256 _tokenId) 
        external 
        view 
        validToken(_tokenId)
        returns (address) {
        return dataSource.roomNightApprovals(_tokenId);
    }

    /**
     * @dev Query if an address is an authorized operator for another address.
     * @param _owner The address that owns The TRNs
     * @param _operator The address that acts on behalf of the owner
     * @return True if `_operator` is an approved operator for `_owner`, false otherwise
     */
    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
        return dataSource.operatorApprovals(_owner, _operator);
    }
}