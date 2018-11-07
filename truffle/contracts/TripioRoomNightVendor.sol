pragma solidity ^0.4.24;

import "./extensions/TRNPrices.sol";
import "./extensions/TRNRatePlans.sol";

contract TripioRoomNightVendor is TRNPrices, TRNRatePlans {
    /**
     * Constructor
     */
    constructor(address _dataSource) public {
        // Init the data source
        dataSource = TripioRoomNightData(_dataSource);
    }

    /**
     * @dev Update the data source
     */
    function updateDataSource(address _dataSource) external onlyOwner {
        // Update the data source
        dataSource = TripioRoomNightData(_dataSource);
    }
    
    /**
     * @dev Destory the contract
     */
    function destroy() external onlyOwner {
        selfdestruct(owner);
    }
}