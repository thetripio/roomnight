pragma solidity ^0.4.21;

import "./TRNData.sol";

contract TRNOwners is TRNData {
    /**
     * Constructor
     */
    constructor() public {

    }

    /**
     * Add room night token to `_owner`'s account(from the header)
     */
    function _pushRoomNight(address _owner, uint256 _rnid, bool _isVendor) internal {
        require(_owner != address(0));
        require(_rnid != 0);
        if (_isVendor) {
            dataSource.pushOrderOfVendor(_owner, _rnid, false);
        } else {
            dataSource.pushOrderOfOwner(_owner, _rnid, false);
        }
    }

    /**
     * Remove room night token from `_owner`'s account
     */
    function _removeRoomNight(address _owner, uint256 _rnid) internal {
        dataSource.removeOrderOfOwner(_owner, _rnid);
    }

    /**
     * @dev Returns all the room nights of the `msg.sender`(Customer)
     * @param _from The begin of room nights Id
     * @param _limit The total room nights 
     * @param _isVendor Is Vendor
     * @return Room nights of the `msg.sender` and the next vernier
     */
    function roomNightsOfOwner(uint256 _from, uint256 _limit, bool _isVendor) 
        external
        view 
        returns(uint256[], uint256) {
        if(_isVendor) {
            return dataSource.getOrdersOfVendor(msg.sender, _from, _limit, true);
        }else {
            return dataSource.getOrdersOfOwner(msg.sender, _from, _limit, true);
        }
    }

    /**
     * @dev Returns the room night infomation in detail
     * @param _rnid Room night id
     * @return Room night infomation in detail
     */
    function roomNight(uint256 _rnid) 
        external 
        view 
        returns(uint256 _vendorId,uint256 _rpid,uint256 _token,uint256 _price,uint256 _timestamp,uint256 _date,bytes32 _ipfs, string _name) {
        (_vendorId, _rpid, _token, _price, _timestamp, _date, _ipfs) = dataSource.roomnights(_rnid);
        (_name,,) = dataSource.getRatePlan(_vendorId, _rpid);
    }
}