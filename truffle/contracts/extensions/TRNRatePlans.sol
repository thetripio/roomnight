pragma solidity ^0.4.24;

import "./TRNData.sol";

contract TRNRatePlans is TRNData {
    /**
     * Constructor
     */
    constructor() public {

    }

    /**
     * This emits when rate plan created
     */
    event RatePlanCreated(address indexed _vendor, string _name, bytes32 indexed _ipfs);

    /**
     * This emits when rate plan removed
     */
    event RatePlanRemoved(address indexed _vendor, uint256 indexed _rpid);

    /**
     * This emits when rate plan modified
     */
    event RatePlanModified(address indexed _vendor, uint256 indexed _rpid, string name, bytes32 _ipfs);

    /**
     * @dev Create rate plan
     *      Only vendor can operate
     *      Throw when `_name`'s length lte 0 or mte 100.
     * @param _name The name of rate plan
     * @param _ipfs The address of the rate plan detail info on IPFS.
     */
    function createRatePlan(string _name, bytes32 _ipfs) 
        external 
        // onlyVendor 
        returns(uint256) {
        // if vendor not exist create it
        if(dataSource.vendorIds(msg.sender) == 0) {
            dataSource.pushVendor("", msg.sender, false);
        }
        bytes memory nameBytes = bytes(_name);
        require(nameBytes.length > 0 && nameBytes.length < 200);
    
        uint256 vendorId = dataSource.vendorIds(msg.sender);
        uint256 id = dataSource.pushRatePlan(vendorId, _name, _ipfs, false);
        
        // Event 
        emit RatePlanCreated(msg.sender, _name, _ipfs);

        return id;
    }
    
    /**
     * @dev Remove rate plan
     *      Only vendor can operate
     *      Throw when `_rpid` not exist
     * @param _rpid The rate plan identifier
     */
    function removeRatePlan(uint256 _rpid) 
        external 
        onlyVendor 
        ratePlanExist(dataSource.vendorIds(msg.sender), _rpid) 
        returns(bool) {
        uint256 vendorId = dataSource.vendorIds(msg.sender);

        // Delete rate plan
        dataSource.removeRatePlan(vendorId, _rpid);
        
        // Event 
        emit RatePlanRemoved(msg.sender, _rpid);
        return true;
    }

    /**
     * @dev Modify rate plan
     *      Throw when `_rpid` not exist
     * @param _rpid The rate plan identifier
     * @param _ipfs The address of the rate plan detail info on IPFS
     */
    function modifyRatePlan(uint256 _rpid, string _name, bytes32 _ipfs) 
        external 
        onlyVendor 
        ratePlanExist(dataSource.vendorIds(msg.sender), _rpid) 
        returns(bool) {

        uint256 vendorId = dataSource.vendorIds(msg.sender);
        dataSource.updateRatePlan(vendorId, _rpid, _name, _ipfs);

        // Event 
        emit RatePlanModified(msg.sender, _rpid, _name, _ipfs);
        return true;
    }

    /**
     * @dev Returns a list of all rate plan IDs assigned to a vendor.
     * @param _vendorId The Id of vendor
     * @param _from The begin ratePlan Id
     * @param _limit How many ratePlan Ids one page 
     * @return A list of all rate plan IDs assigned to a vendor
     */
    function ratePlansOfVendor(uint256 _vendorId, uint256 _from, uint256 _limit) 
        external
        view
        vendorIdValid(_vendorId)  
        returns(uint256[], uint256) {
        return dataSource.getRatePlansOfVendor(_vendorId, _from, _limit, true);
    }

    /**
     * @dev Returns ratePlan info of vendor
     * @param _vendorId The address of vendor
     * @param _rpid The ratePlan id
     * @return The ratePlan info(_name, _timestamp, _ipfs)
     */
    function ratePlanOfVendor(uint256 _vendorId, uint256 _rpid) 
        external 
        view 
        vendorIdValid(_vendorId) 
        returns(string _name, uint256 _timestamp, bytes32 _ipfs) {
        (_name, _timestamp, _ipfs) = dataSource.getRatePlan(_vendorId, _rpid);
    }
}