pragma solidity ^0.4.24;

import "./TripioToken.sol";
import "./TRNOwners.sol";

contract TRNTransactions is TRNOwners {
    /**
     * Constructor
     */
    constructor() public {

    }

    /**
     * This emits when rate plan is bought in batch
     */
    event BuyInBatch(address indexed _customer, address indexed _vendor, uint256 indexed _rpid, uint256[] _dates, uint256 _token);

    /**
     * This emits when token refund is applied 
     */
    event ApplyRefund(address _customer, uint256 indexed _rnid, bool _isRefund);

    /**
     * This emits when refunded
     */
    event Refund(address _vendor, uint256 _rnid);

    /**
     * @dev Complete the buy transaction,
     *      The inventory minus one and the room night token transfer to customer
     * @param _vendorId The vendor account
     * @param _rpid The vendor's rate plan id
     * @param _date The booking date
     * @param _customer The customer account
     * @param _token The token Id
     */
    function _buy(uint256 _vendorId, uint256 _rpid, uint256 _date, address _customer, uint256 _token) private {
        // Product room night token
        (,,uint256 _price) = dataSource.getPrice(_vendorId, _rpid, _date, _token);
        (,,bytes32 _ipfs) = dataSource.getRatePlan(_vendorId, _rpid);
        uint256 rnid = dataSource.generateRoomNightToken(_vendorId, _rpid, _date, _token, _price, _ipfs);

        // Give the token to `_customer`
        dataSource.transferTokenTo(rnid, _customer);

        // Record the token to `_customer` account
        _pushRoomNight(_customer, rnid, false);

        // Record the token to `_vendor` account
        (,address vendor,,) = dataSource.getVendor(_vendorId);
        _pushRoomNight(vendor, rnid, true);

        // The inventory minus one
        dataSource.reduceInventories(_vendorId, _rpid, _date, 1);
    }

    /**
     * @dev Complete the buy transaction in batch,
     *      The inventory minus one and the room night token transfer to customer
     * @param _vendorId The vendor account
     * @param _vendor Then vendor address
     * @param _rpid The vendor's rate plan id
     * @param _dates The booking date
     * @param _token The token Id
     */
    function _buyInBatch(uint256 _vendorId, address _vendor, uint256 _rpid, uint256[] _dates, uint256 _token) private returns(bool) {
        (uint16[] memory inventories, uint256[] memory values) = dataSource.getPrices(_vendorId, _rpid, _dates, _token);
        uint256 totalValues = 0;
        for(uint256 i = 0; i < _dates.length; i++) {
            if(inventories[i] == 0 || values[i] == 0) {
                return false;
            }
            totalValues += values[i];
            // Transfer the room night to `msg.sender`
            _buy(_vendorId, _rpid, _dates[i], msg.sender, _token);
        }
        
        if (_token == 0) {
            // By through ETH
            require(msg.value == totalValues);

            // Transfer the ETH to `_vendor`
            _vendor.transfer(totalValues);
        } else {
            // By through other digital token
            address tokenAddress = dataSource.tokenIndexToAddress(_token);
            require(tokenAddress != address(0));

            // This contract transfer `price.trio` from `msg.sender` account
            TripioToken tripio = TripioToken(tokenAddress);
            tripio.transferFrom(msg.sender, _vendor, totalValues);
        }
        return true;
    }

    /**
     * Complete the refund transaction
     * Remove the `_rnid` from the owner account and the inventory plus one
     */
    function _refund(uint256 _rnid, uint256 _vendorId, uint256 _rpid, uint256 _date) private {
        // Remove the `_rnid` from the owner
        _removeRoomNight(dataSource.roomNightIndexToOwner(_rnid), _rnid);

        // The inventory plus one
        dataSource.addInventories(_vendorId, _rpid, _date, 1);

        // Change the owner of `_rnid`
        dataSource.transferTokenTo(_rnid, address(0));
    }

    /**
     * @dev By room nigth in batch through ETH(`_token` == 0) or other digital token(`_token != 0`)
     *      Throw when `_rpid` not exist
     *      Throw unless each inventory more than zero
     *      Throw unless `msg.value` equal to `price.eth`
     *      This method is payable, can accept ETH transfer
     * @param _vendorId The vendor Id
     * @param _rpid The _vendor's rate plan id
     * @param _dates The booking dates
     * @param _token The digital currency token 
     */
    function buyInBatch(uint256 _vendorId, uint256 _rpid, uint256[] _dates, uint256 _token) 
        external
        payable
        ratePlanExist(_vendorId, _rpid)
        validDates(_dates)
        returns(bool) {
        
        (,address vendor,,) = dataSource.getVendor(_vendorId);
        
        bool result = _buyInBatch(_vendorId, vendor, _rpid, _dates, _token);
        
        require(result);

        // Event
        emit BuyInBatch(msg.sender, vendor, _rpid, _dates, _token);
        return true;
    }

    /**
     * @dev Apply room night refund
     *      Throw unless `_rnid` is valid
     *      Throw unless `_rnid` can transfer
     * @param _rnid room night identifier
     * @param _isRefund if `true` the `_rnid` can refund else not
     */
    function applyRefund(uint256 _rnid, bool _isRefund) 
        external
        validToken(_rnid)
        canTransfer(_rnid)
        returns(bool) {
        dataSource.updateRefundApplications(msg.sender, _rnid, _isRefund);

        // Event
        emit ApplyRefund(msg.sender, _rnid, _isRefund);
        return true;
    }

    /**
     * @dev Whether the `_rnid` is in refund applications
     * @param _rnid room night identifier
     */
    function isRefundApplied(uint256 _rnid) 
        external
        view
        validToken(_rnid) returns(bool) {
        return dataSource.refundApplications(dataSource.roomNightIndexToOwner(_rnid), _rnid);
    }

    /**
     * @dev Refund through ETH or other digital token, give the room night ETH/TOKEN to customer and take back inventory
     *      Throw unless `_rnid` is valid
     *      Throw unless `msg.sender` is vendor
     *      Throw unless the refund application is true
     *      Throw unless the `msg.value` is equal to `roomnight.eth`
     * @param _rnid room night identifier
     */
    function refund(uint256 _rnid) 
        external
        payable
        validToken(_rnid) 
        returns(bool) {
        // Refund application is true
        require(dataSource.refundApplications(dataSource.roomNightIndexToOwner(_rnid), _rnid));

        // The `msg.sender` is the vendor of the room night.
        (uint256 vendorId,uint256 rpid,uint256 token,uint256 price,,uint256 date,) = dataSource.roomnights(_rnid);
        (,address vendor,,) = dataSource.getVendor(vendorId);
        require(msg.sender == vendor);

        address ownerAddress = dataSource.roomNightIndexToOwner(_rnid);

        if (token == 0) {
            // Refund by ETH

            // The `msg.sender` is equal to `roomnight.eth`
            uint256 value = price;
            require(msg.value >= value);

            // Transfer the ETH to roomnight's owner
            ownerAddress.transfer(value);
        } else {
            // Refund  by TRIO

            // The `roomnight.trio` is more than zero
            require(price > 0);

            // This contract transfer `price.trio` from `msg.sender` account
            TripioToken tripio = TripioToken(dataSource.tokenIndexToAddress(token));
            tripio.transferFrom(msg.sender, ownerAddress, price);
        }
        // Refund
        _refund(_rnid, vendorId, rpid, date);

        // Event 
        emit Refund(msg.sender, _rnid);
        return true;
    }
}