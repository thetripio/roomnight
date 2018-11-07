# Contract
* Ropsten：[0x8A1f185EFC5c2a9a5F7A92894d74f4F6e17d42F1](https://ropsten.etherscan.io/address/0x8A1f185EFC5c2a9a5F7A92894d74f4F6e17d42F1)
* Main：[0x605FdEBd3b51eb671723cce98EB5D7B227B04fd0](https://ropsten.etherscan.io/address/0x605FdEBd3b51eb671723cce98EB5D7B227B04fd0)

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


ownerOf
getApproved
isApprovedForAll
isRefundApplied
roomNight
roomNightsOfOwner

# Update
safeTransferFrom
transferFrom
transferFromInBatch
approve
setApprovalForAll
buyInBatch
applyRefund
refund