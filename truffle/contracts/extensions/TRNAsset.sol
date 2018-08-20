pragma solidity ^0.4.21;

import "../721/ERC721Metadata.sol";
import "./TRNData.sol";
import "../libs/IPFSLib.sol";

contract TRNAsset is TRNData, ERC721Metadata {
    using IPFSLib for bytes;
    using IPFSLib for bytes32;

    /**
     * Constructor
     */
    constructor() public {
        
    }

    /**
     * @dev Descriptive name for Tripio's Room Night Token in this contract
     * @return The name of the contract
     */
    function name() external pure returns (string _name) {
        return "Tripio Room Night";
    }

    /**
     * @dev Abbreviated name for Tripio's Room Night Token in this contract
     * @return The simple name of the contract
     */
    function symbol() external pure returns (string _symbol) {
        return "TRN";
    }

    /**
     * @dev If `_tokenId` is not valid trows an exception otherwise return a URI which point to a JSON file like:
     *      {
     *       "name": "Identifies the asset to which this NFT represents",
     *       "description": "Describes the asset to which this NFT represents",
     *       "image": "A URI pointing to a resource with mime type image/* representing the asset to which this NFT represents. Consider making any images at a width between 320 and 1080 pixels and aspect ratio between 1.91:1 and 4:5 inclusive."
     *      }
     * @param _tokenId The RoomNight digital token
     * @return The digital token asset uri
     */
    function tokenURI(uint256 _tokenId) 
        external 
        view 
        validToken(_tokenId) 
        returns (string) { 
        bytes memory prefix = new bytes(2);
        prefix[0] = 0x12;
        prefix[1] = 0x20;
        (,,,,,,bytes32 ipfs) = dataSource.roomnights(_tokenId);
        bytes memory value = prefix.concat(ipfs.toBytes());
        bytes memory ipfsBytes = value.base58Address();
        bytes memory tokenBaseURIBytes = bytes(dataSource.tokenBaseURI());
        return string(tokenBaseURIBytes.concat(ipfsBytes));
    }
}
