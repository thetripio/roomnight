pragma solidity ^0.4.24;

import "./TRNData.sol";

contract TRNVendors is TRNData {
    
    /**
     * Constructor
     */
    constructor() public {

    }

    /**
     * This emits when vendor is added
     */
    event VendorAdded(address indexed _vendor, string _name);

    /**
     * This emits when vendor is removed
     */
    event VendorRemoved(address indexed _vendor);

    /**
     * This emits when vendor's validation is changed
     */
    event VendorValid(address indexed _vendor, bool _valid);

    /**
     * This emits when vendor's name is updated
     */
    event VendorUpdated(address indexed _vendor, string _name);

    /**
     * @dev Add vendor to the system.
     *      Only owner can operate
     *      Throw when `_vendor` is equal to `address(0)`
     *      Throw unless `_vendor` not exist.
     *      Throw when `_name`'s length lte 0 or mte 100.
     * @param _vendor The address of vendor
     * @param _name The name of vendor
     * @return Success
     */
    function addVendor(address _vendor, string _name) 
        external 
        onlyOwner 
        returns(bool) {
        // _vendor is valid address
        require(_vendor != address(0));
        // _vendor not exists
        require(dataSource.vendorIds(_vendor) == 0);
        // The length of _name between 0 and 1000
        bytes memory nameBytes = bytes(_name);
        require(nameBytes.length > 0 && nameBytes.length < 200);

        dataSource.pushVendor(_name, _vendor, false);
    
        // Event
        emit VendorAdded(_vendor, _name);
        return true;
    }

    /**
     * @dev Remove vendor from the system by address.
     *      Only owner can operate
     * @param _vendor The address of vendor
     * @return Success
     */
    function removeVendorByAddress(address _vendor) 
        public 
        onlyOwner 
        returns(bool) {
        // _vendor exists
        uint256 id = dataSource.vendorIds(_vendor);
        require(id > 0);
        
        dataSource.removeVendor(id);
        // Event
        emit VendorRemoved(_vendor);
        return true;
    }

    /**
     * @dev Remove vendor from the system by Id
     *      Only owner can operate
     * @param _vendorId The id of vendor
     */
    function removeVendorById(uint256 _vendorId) 
        external 
        onlyOwner 
        returns(bool) {
        (,address vendor,,) = dataSource.getVendor(_vendorId);
        return removeVendorByAddress(vendor);
    }

    /**
     * @dev Change the `_vendorId`'s validation
     *      Only owner can operate
     * @param _vendorId The id of vendor
     * @param _valid The validation of vendor
     * @return Success
     */
    function makeVendorValid(uint256 _vendorId, bool _valid) 
        external 
        onlyOwner 
        returns(bool) {
        (,address vendor,,) = dataSource.getVendor(_vendorId);
        require(dataSource.vendorIds(vendor) > 0);
        dataSource.updateVendorValid(_vendorId, _valid);
        
        // Event
        emit VendorValid(vendor, _valid);
        return true;
    }

    /**
     * @dev Update the `_vendorId`'s name
     *      Only owner can operate
     * @param _vendorId Then id of vendor
     * @param _name The name of vendor
     * @return Success
     */
    function updateVendorName(uint256 _vendorId, string _name) 
        external
        onlyOwner
        returns(bool) {
        (,address vendor,,) = dataSource.getVendor(_vendorId);
        require(dataSource.vendorIds(vendor) > 0);
        // The length of _name between 0 and 1000
        bytes memory nameBytes = bytes(_name);
        require(nameBytes.length > 0 && nameBytes.length < 200);
        dataSource.updateVendorName(_vendorId, _name);

        // Event
        emit VendorUpdated(vendor, _name);
        return true;
    }

    /**
     * @dev Get Vendor ids by page
     * @param _from The begin vendorId
     * @param _limit How many vendorIds one page
     * @return The vendorIds and the next vendorId as tuple, the next page not exists when next eq 0
     */
    function getVendorIds(uint256 _from, uint256 _limit) 
        external 
        view 
        returns(uint256[], uint256){
        return dataSource.getVendors(_from, _limit, true);
    }

    /**
     * @dev Get Vendor by id
     * @param _vendorId Then vendor id
     * @return The vendor info(_name, _vendor, _timestamp, _valid)
     */
    function getVendor(uint256 _vendorId) 
        external 
        view 
        returns(string _name, address _vendor, uint256 _timestamp, bool _valid) {
        (_name, _vendor, _timestamp, _valid) = dataSource.getVendor(_vendorId);
    }

    /**
     * @dev Get Vendor by address\
     * @param _vendor Then vendor address
     * @return Then vendor info(_vendorId, _name, _timestamp, _valid)
     */
    function getVendorByAddress(address _vendor) 
        external 
        view
        returns(uint256 _vendorId, string _name, uint256 _timestamp, bool _valid) {
        _vendorId = dataSource.vendorIds(_vendor);
        (_name,, _timestamp, _valid) = dataSource.getVendor(_vendorId);
    }
}