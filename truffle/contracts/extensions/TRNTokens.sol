pragma solidity ^0.4.24;

import "./TripioToken.sol";
import "./TRNData.sol";

contract TRNTokens is TRNData {
    /**
     * Constructor
     */
    constructor() public {

    }
    /**
     * This emits when token contract is added
     */
    event TokenAdded(address indexed _token);

    /**
     * This emits when token contract is removed
     */
    event TokenRemoved(uint256 _index);

    /**
     * @dev Add supported digital currency token
     *      Only owner can operate
     * @param _contract The address of digital currency contract
     */
    function addToken(address _contract) 
        external 
        onlyOwner 
        returns(uint256) {
        require(_contract != address(0));
        uint256 id = dataSource.pushToken(_contract, false);
        // Event 
        emit TokenAdded(_contract);
        return id;
    }

    /**
     * @dev Remove digital currency token
     *      Only owner can operate
     * @param _tokenId The index of digital currency contract
     */
    function removeToken(uint256 _tokenId) 
        external 
        onlyOwner 
        returns(bool){
        require(dataSource.tokenIndexToAddress(_tokenId) != address(0));
        dataSource.removeToken(_tokenId);
        // Event
        emit TokenRemoved(_tokenId);
        return true;
    }

    /**
     * @dev Returns all the supported digital currency tokens
     * @param _from The begin tokenId
     * @param _limit How many tokenIds one page 
     * @return All the supported digital currency tokens
     */

    function supportedTokens(uint256 _from, uint256 _limit) 
        external 
        view 
        returns(uint256[], uint256) {
        return dataSource.getTokens(_from, _limit, true);
    }

    /**
     * @dev Return the token info
     * @param _tokenId The token Id
     * @return The token info(symbol, name, decimals)
     */
    function getToken(uint256 _tokenId) 
        external
        view 
        returns(string _symbol, string _name, uint8 _decimals, address _token) {
        return dataSource.getToken(_tokenId);
    }
}
