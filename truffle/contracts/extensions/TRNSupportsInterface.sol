pragma solidity ^0.4.24;

import "../721/ERC165.sol";
import "./TRNData.sol";

contract TRNSupportsInterface is TRNData, ERC165 {
    /**
     * Constructor
     */
    constructor() public {

    }

    /**
     * @dev Query if a contract implements an interface
     * @param interfaceID The interface identifier, as specified in ERC-165
     * @return true if the contract implements `interfaceID` 
     * and `interfaceID` is not 0xffffffff, false otherwise
     */
    function supportsInterface(bytes4 interfaceID) 
        external 
        view 
        returns (bool) {
        return ((interfaceID == dataSource.interfaceSignature_ERC165()) ||
        (interfaceID == dataSource.interfaceSignature_ERC721Metadata()) ||
        (interfaceID == dataSource.interfaceSignature_ERC721())) &&
        (interfaceID != 0xffffffff);
    }
}