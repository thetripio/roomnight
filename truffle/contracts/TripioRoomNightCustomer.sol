pragma solidity ^0.4.24;

import "./extensions/TRNAsset.sol";
import "./extensions/TRNOwnership.sol";
import "./extensions/TRNSupportsInterface.sol";
import "./extensions/TRNTransactions.sol";

contract TripioRoomNightCustomer is TRNAsset, TRNSupportsInterface, TRNOwnership, TRNTransactions {
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
     * @dev Withdraw ETH balance from contract account, the balance will transfer to the contract owner
     */
    function withdrawBalance() external onlyOwner {
        owner.transfer(address(this).balance);
    }

    /**
     * @dev Withdraw other TOKEN balance from contract account, the balance will transfer to the contract owner
     * @param _token The TOKEN id
     */
    function withdrawTokenId(uint _token) external onlyOwner {
        TripioToken tripio = TripioToken(dataSource.tokenIndexToAddress(_token));
        uint256 tokens = tripio.balanceOf(address(this));
        tripio.transfer(owner, tokens);
    }

    /**
     * @dev Withdraw other TOKEN balance from contract account, the balance will transfer to the contract owner
     * @param _tokenAddress The TOKEN address
     */
    function withdrawToken(address _tokenAddress) external onlyOwner {
        TripioToken tripio = TripioToken(_tokenAddress);
        uint256 tokens = tripio.balanceOf(address(this));
        tripio.transfer(owner, tokens);
    }

    /**
     * @dev Destory the contract
     */
    function destroy() external onlyOwner {
        selfdestruct(owner);
    }

    function() external payable {

    }
}