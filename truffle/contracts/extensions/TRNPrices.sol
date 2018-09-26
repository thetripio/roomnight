pragma solidity ^0.4.24;

import "./TRNData.sol";

contract TRNPrices is TRNData {

    /**
     * Constructor
     */
    constructor() public {

    }

    /**
     * This emits when rate plan price changed
     */
    event RatePlanPriceChanged(uint256 indexed _rpid);

    /**
     * This emits when rate plan inventory changed
     */
    event RatePlanInventoryChanged(uint256 indexed _rpid);

    /**
     * This emits when rate plan base price changed
     */
    event RatePlanBasePriceChanged(uint256 indexed _rpid);
    
    function _updatePrices(uint256 _rpid, uint256 _date, uint16 _inventory, uint256[] _tokens, uint256[] _prices) private {
        uint256 vendorId = dataSource.vendorIds(msg.sender);
        dataSource.updateInventories(vendorId, _rpid, _date, _inventory);
        for (uint256 tindex = 0; tindex < _tokens.length; tindex++) {
            dataSource.updatePrice(vendorId, _rpid, _date, _tokens[tindex], _prices[tindex]);
        }
    }

    function _updateInventories(uint256 _rpid, uint256 _date, uint16 _inventory) private {
        uint256 vendorId = dataSource.vendorIds(msg.sender);
        dataSource.updateInventories(vendorId, _rpid, _date, _inventory);
    }

    /**
     * @dev Update base price assigned to a vendor by `_rpid`, `msg.sender`, `_dates`
     *      Throw when `msg.sender` is not a vendor
     *      Throw when `_rpid` not exist
     *      Throw when `_tokens`'s length is not equal to `_prices`'s length or `_tokens`'s length is equal to zero
     * @param _rpid The rate plan identifier
     * @param _inventory The amount that can be sold
     * @param _tokens The pricing currency token
     * @param _prices The currency token selling price  
     */
    function updateBasePrice(uint256 _rpid, uint256[] _tokens, uint256[] _prices, uint16 _inventory) 
        external 
        ratePlanExist(dataSource.vendorIds(msg.sender), _rpid) 
        returns(bool) {
        require(_tokens.length == _prices.length);
        require(_prices.length > 0);
        uint256 vendorId = dataSource.vendorIds(msg.sender);
        dataSource.updateBaseInventory(vendorId, _rpid, _inventory);
        for (uint256 tindex = 0; tindex < _tokens.length; tindex++) {
            dataSource.updateBasePrice(vendorId, _rpid, _tokens[tindex], _prices[tindex]);
        }
        // Event 
        emit RatePlanBasePriceChanged(_rpid);
        return true;
    }

    /**
     * @dev Update prices assigned to a vendor by `_rpid`, `msg.sender`, `_dates`
     *      Throw when `msg.sender` is not a vendor
     *      Throw when `_rpid` not exist
     *      Throw when `_dates`'s length lte 0
     *      Throw when `_tokens`'s length is not equal to `_prices`'s length or `_tokens`'s length is equal to zero
     * @param _rpid The rate plan identifier
     * @param _dates The prices to be modified of `_dates`
     * @param _inventory The amount that can be sold
     * @param _tokens The pricing currency token
     * @param _prices The currency token selling price  
     */
    function updatePrices(uint256 _rpid, uint256[] _dates, uint16 _inventory, uint256[] _tokens, uint256[] _prices)
        external 
        ratePlanExist(dataSource.vendorIds(msg.sender), _rpid) 
        returns(bool) {
        require(_dates.length > 0);
        require(_tokens.length == _prices.length);
        require(_prices.length > 0);
        for (uint256 index = 0; index < _dates.length; index++) {
            _updatePrices(_rpid, _dates[index], _inventory, _tokens, _prices);
        }
        // Event 
        emit RatePlanPriceChanged(_rpid);
        return true;
    }

    /**
     * @dev Update inventory assigned to a vendor by `_rpid`, `msg.sender`, `_dates`
     *      Throw when `msg.sender` is not a vendor
     *      Throw when `_rpid` not exist
     *      Throw when `_dates`'s length lte 0
     * @param _rpid The rate plan identifier
     * @param _dates The prices to be modified of `_dates`
     * @param _inventory The amount that can be sold
     */
    function updateInventories(uint256 _rpid, uint256[] _dates, uint16 _inventory) 
        external 
        ratePlanExist(dataSource.vendorIds(msg.sender), _rpid) 
        returns(bool) {
        for (uint256 index = 0; index < _dates.length; index++) {
            _updateInventories(_rpid, _dates[index], _inventory);
        }

        // Event
        emit RatePlanInventoryChanged(_rpid);
        return true;
    }

    /**
     * @dev Returns the inventories of `_vendor`'s RP(`_rpid`) on `_dates`
     *      Throw when `_rpid` not exist
     *      Throw when `_dates`'s count lte 0
     * @param _vendorId The vendor Id
     * @param _rpid The rate plan identifier
     * @param _dates The inventories to be returned of `_dates`
     * @return The inventories
     */
    function inventoriesOfDate(uint256 _vendorId, uint256 _rpid, uint256[] _dates) 
        external 
        view
        ratePlanExist(_vendorId, _rpid) 
        returns(uint16[]) {
        require(_dates.length > 0);
        uint16[] memory result = new uint16[](_dates.length);
        for (uint256 index = 0; index < _dates.length; index++) {
            uint256 date = _dates[index];
            (uint16 inventory,) = dataSource.getInventory(_vendorId, _rpid, date);
            result[index] = inventory;
        }
        return result;
    }

    /**
     * @dev Returns the prices of `_vendor`'s RP(`_rpid`) on `_dates`
     *      Throw when `_rpid` not exist
     *      Throw when `_dates`'s count lte 0
     * @param _vendorId The vendor Id
     * @param _rpid The rate plan identifier
     * @param _dates The inventories to be returned of `_dates`
     * @param _token The digital currency token
     * @return The prices
     */
    function pricesOfDate(uint256 _vendorId, uint256 _rpid, uint256[] _dates, uint256 _token)
        external 
        view
        ratePlanExist(_vendorId, _rpid) 
        returns(uint256[]) {
        require(_dates.length > 0);
        uint256[] memory result = new uint256[](_dates.length);
        for (uint256 index = 0; index < _dates.length; index++) {
            (,, uint256 _price) = dataSource.getPrice(_vendorId, _rpid, _dates[index], _token);
            result[index] = _price;
        }
        return result;
    }

    /**
     * @dev Returns the prices and inventories of `_vendor`'s RP(`_rpid`) on `_dates`
     *      Throw when `_rpid` not exist
     *      Throw when `_dates`'s count lte 0
     * @param _vendorId The vendor Id
     * @param _rpid The rate plan identifier
     * @param _dates The inventories to be returned of `_dates`
     * @param _token The digital currency token
     * @return The prices and inventories
     */
    function pricesAndInventoriesOfDate(uint256 _vendorId, uint256 _rpid, uint256[] _dates, uint256 _token)
        external 
        view
        returns(uint256[], uint16[]) {
        uint256[] memory prices = new uint256[](_dates.length);
        uint16[] memory inventories = new uint16[](_dates.length);
        for (uint256 index = 0; index < _dates.length; index++) {
            (uint16 _inventory,, uint256 _price) = dataSource.getPrice(_vendorId, _rpid, _dates[index], _token);
            prices[index] = _price;
            inventories[index] = _inventory;
        }
        return (prices, inventories);
    }

    /**
     * @dev Returns the RP's price and inventory of `_date`.
     *      Throw when `_rpid` not exist
     * @param _vendorId The vendor Id
     * @param _rpid The rate plan identifier
     * @param _date The price and inventory to be returneed of `_date`
     * @param _token The digital currency token
     * @return The price and inventory
     */
    function priceOfDate(uint256 _vendorId, uint256 _rpid, uint256 _date, uint256 _token) 
        external 
        view
        ratePlanExist(_vendorId, _rpid) 
        returns(uint16 _inventory, uint256 _price) {
        (_inventory, , _price) = dataSource.getPrice(_vendorId, _rpid, _date, _token);
    }
}