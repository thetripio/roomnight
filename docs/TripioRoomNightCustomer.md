# Contract
* Ropsten：[0x8A1f185EFC5c2a9a5F7A92894d74f4F6e17d42F1](https://ropsten.etherscan.io/address/0x8A1f185EFC5c2a9a5F7A92894d74f4F6e17d42F1)

# Query

## The name of current room night token
| name |                     |
|:--------------|:-------------------|
| Description  | The name of current room night token |
| Modifier     | NULL                |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | string | The name of current room night token |

## The symbol of current room night token
| symbol |                     |
|:--------------|:-------------------|
| Description  | The symbol of current room night token |
| Modifier     | NULL                |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | string | The symbol of current room night token |

## The URI of token's information
| tokenURI |                     |
|:--------------|:-------------------|
| Description  | The URI of token's information |
| Modifier     | NULL                |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _tokenId      | uint256 | Token id |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | string | The URI of token. E.g: http://ipfs.tripiochina.cn/api/v0/cat/Qmaj8UWNjTzBMBHkkaqSiyax2nFgiwYP2ewxnhGBucn6S8 |

## The balance of any address
| balanceOf |                     |
|:--------------|:-------------------|
| Description  | Get the balance of any address |
| Modifier     | NULL                |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _owner      | address | The owner address of some token |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | uint256 | The token balance |

## The owner of token
| ownerOf |                     |
|:--------------|:-------------------|
| Description  | Get the owner of any token |
| Modifier     | NULL                |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _tokenId      | uint256 | The room night token id |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | address | The token's owner address |

## Get the approved address for a single room night token
| getApproved |                     |
|:--------------|:-------------------|
| Description  | Get the approved address for a single room night token |
| Modifier     | Token is valid |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _tokenId      | uint256 | The room night token id |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | address | The approved address for this token, or the zero address if there is none |

## Query if an address is an authorized operator for another address
| isApprovedForAll |                     |
|:--------------|:-------------------|
| Description  | Query if an address is an authorized operator for another address |
| Modifier     | NULL |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _owner      | address | The address that owns the token |
| _operator   | address | The address that acts on behalf of the owner |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | bool | True if `_operator` is an approved operator for `_owner`, false otherwise |

##  Whether the token is in refund applications
| isRefundApplied |                     |
|:--------------|:-------------------|
| Description  | Whether the token is in refund applications |
| Modifier     | Token is valid |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _rnid      | uint256 | The room night token id |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | bool | True if token in refund applications, false otherwise |

##  Get the room night infomation in detail
| roomNight |                     |
|:--------------|:-------------------|
| Description  | Get the room night infomation in detail |
| Modifier     | NULL |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _rnid      | uint256 | The room night token id |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | uint256  | Vendor id  |
| 1       | uint256  | Rateplan id |
| 2       | uint256  | ERC2.0 Token id  |
| 3       | uint256  | Price  |
| 4       | uint256  | Create time: UTC timestamp(s)  |
| 5       | uint256  | Order date E.g: 20180621 |
| 6       | bytes32  | The IPFS's address of rateplan's desc |
| 7       | string  | Rateplan name |

## Get all the room nights of the `msg.sender`(Customer or Vendor)
| roomNightsOfOwner |                     |
|:--------------|:-------------------|
| Description  | Get all the room nights of the `msg.sender`(Customer or Vendor) |
| Modifier     | NULL |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _from   | uint256 | The begin id, if id = 0 search from the begin |
| _limit  | uint256 | The limit of one page|
| _isVendor | bool | Is vendor or not |

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | uint256[]  | Room night token ids  |
| 1       | uint256  | The next id of token, if id = 0 the next token is null  |


# Update

## Transfers the ownership of an room night token from one address to another address
| safeTransferFrom |                     |
|:--------------|:-------------------|
| Description  | Transfers the ownership of an room night token from one address to another address.|
| Modifier     | Throws unless `msg.sender` is the current owner or an approved address for this room night token. Throws if `_tokenId` is not a valid room night token. When transfer is complete, this function checks if `_to` is a smart contract (code size > 0). If so, it calls `onERC721Received` on `_to` and throws if the return value is not `bytes4(keccak256("onERC721Received(address,uint256,bytes)"))`. |
| Constant     | FALSE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _from   | address | The current owner of the room night token |
| _to  | address | The new owner |
| _tokenId | uint256 | The token to transfer |
|_data | bytes | Additional data with no specified format, sent in call to `_to`|

| EVENTS  |        | 
|:--------|:---------|
| Transfer | (_from, _to, _tokenId) |

##  Transfers the ownership of an room night token from one address to another address
| transferFrom |                     |
|:--------------|:-------------------|
| Description  | Transfers the ownership of an room night token from one address to another address |
| Modifier     | Throws unless `msg.sender` is the current owner or an approved address for this token. Throws if `_tokenId` is not a valid token |
| Constant     | FALSE           |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _from   | address | The current owner of the room night token |
| _to  | address | The new owner |
| _tokenId | uint256 | The token to transfer |

| EVENTS  |        | 
|:--------|:---------|
| Transfer | (_from, _to, _tokenId) |

## Transfers the ownership of tokens from one address to another address
| transferFromInBatch |                     |
|:--------------|:-------------------|
| Description  | Transfers the ownership of tokens from one address to another address |
| Modifier     | Throws unless `msg.sender` is the current owner or an approved address for this token. Throws if `_tokenIds` are not valid tokens |
| Constant     | FALSE           |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _from   | address | The current owner of the room night token |
| _to  | address | The new owner |
| _tokenIds | uint256[] | The tokens to transfer |

| EVENTS  |        | 
|:--------|:---------|
| Transfer | (_from, _to, _tokenId) |

## Set or reaffirm the approved address for an room night token
| approve |                     |
|:--------------|:-------------------|
| Description  | Set or reaffirm the approved address for an room night token |
| Modifier     | Throws unless `msg.sender` is the current room night token owner, or an authorized |
| Constant     | FALSE           |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _approved   | address | The new approved token controller |
| _tokenId | uint256 | The token to approve |

| EVENTS  |        | 
|:--------|:---------|
| Approval |(address indexed _owner, address indexed _approved, uint256 _tokenId)|

## Enable or disable approval for a third party ("operator") to manage all of `msg.sender`'s assets
| setApprovalForAll |                     |
|:--------------|:-------------------|
| Description  | Enable or disable approval for a third party ("operator") to manage all of `msg.sender`'s assets |
| Modifier     | NULL |
| Constant     | FALSE           |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _operator | address | The new approved token controller |
| _approved | bool | The token to approve |

| EVENTS  |        | 
|:--------|:---------|
| ApprovalForAll | (address indexed _owner, address indexed _operator, bool _approved) |

## By room nigth in batch through ETH(`_token` == 0) or other digital token(`_token != 0`)
| buyInBatch |                     |
|:--------------|:-------------------|
| Description  | By room nigth in batch through ETH(`_token` == 0) or other digital token(`_token != 0`) |
| Modifier     | Throw when `_rpid` not exist. Throw unless each inventory more than zero. Throw unless `msg.value` equal to `price.eth`. This method is payable, can accept ETH transfer|
| Constant     | FALSE           |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _vendorId | uint256 | The vendor Id |
| _rpid | uint256 | The vendor's rate plan id |
| _dates | uint256[] | The booking dates |
| _token | uint256 | The digital currency token |

| EVENTS  |        | 
|:--------|:---------|
| BuyInBatch | (address indexed _customer, address indexed _vendor, uint256 indexed _rpid, uint32 _date, uint256 _token) |

## Apply room night refund
| applyRefund |                     |
|:--------------|:-------------------|
| Description  | Apply room night refund |
| Modifier     | Throw unless `_rnid` is valid. Throw unless `_rnid` can transfer |
| Constant     | FALSE           |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _rnid | uint256 | Room night token id |
| _isRefund | uint256 | if `true` the `_rnid` can refund else not |

| EVENTS  |        | 
|:--------|:---------|
| ApplyRefund | (address _customer, uint256 indexed _rnid, bool _isRefund) |

## Refund through ETH or other digital token, give the room night ETH/TOKEN to customer and take back inventory
| refund |                     |
|:--------------|:-------------------|
| Description  | Refund through ETH or other digital token, give the room night ETH/TOKEN to customer and take back inventory |
| Modifier     | Throw unless `_rnid` is valid. Throw unless `msg.sender` is vendor. Throw unless the refund application is true. Throw unless the `msg.value` is equal to `roomnight.eth`|
| Constant     | FALSE           |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _rnid | uint256 | Room night token id |

| EVENTS  |        | 
|:--------|:---------|
| Refund | (address _vendor, uint256 _rnid) |
