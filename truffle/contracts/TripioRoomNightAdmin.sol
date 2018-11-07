pragma solidity ^0.4.24;
import "./extensions/TRNVendors.sol";
import "./extensions/TRNTokens.sol";

contract TripioRoomNightAdmin is TRNVendors, TRNTokens {
    /**
     * This emits when token base uri changed
     */
    event TokenBaseURIChanged(string _uri);

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
     * @dev Update the base URI of token asset
     * @param _uri The base uri of token asset
     */
    function updateBaseTokenURI(string _uri) 
        external 
        onlyOwner {
        dataSource.updateTokenBaseURI(_uri);
        emit TokenBaseURIChanged(_uri);
    }

    /**
     * @dev Destory the contract
     */
    function destroy() external onlyOwner {
        selfdestruct(owner);
    }
}