# Contract
* Ropsten：[0x0D53Ca8D45072c29fA45A3854685ff80ce95E8b2](https://ropsten.etherscan.io/address/0x0D53Ca8D45072c29fA45A3854685ff80ce95E8b2)
* Main：[0x45A4C11105F6d0Ba19A8e848450A9fA3642c4fBa](https://ropsten.etherscan.io/address/0x45A4C11105F6d0Ba19A8e848450A9fA3642c4fBa)

# Query
## Get Vendor ids by page
| getVendorIds |                     |
|:--------------|:-------------------|
| Description  | Get Vendor ids by page |
| Modifier     | NULL                |
| Constant     | TRUE                |

| INPUTS  | TYPE    | DESCRIPTION                 |
|:---------|:-------|:----------------------------|
| _from   | uint256 | The begin id, if id = 0 search from the begin |
| _limit  | uint256 | The limit of one page|

| OUTPUTS  | TYPE      | DESCRIPTION               |
|:--------|:---------|:----------------------------|
| 0       | uint256[] | Vendor ids |
| 1       | uint256   | The next id of vendor, if id = 0 the next vendor is null|

## Get the vendor info by id
| getVendor |                     |
|:--------------|:-------------------|
| Description  | Get the vendor information by id |
| Modifier     | NULL                |
| Constant     | TRUE                |

| INPUTS   | TYPE    | DESCRIPTION   |
|:----------|:-------|:-------|
| _vendorId | uint256| vendor id |

| OUTPUTS  | TYPE      | DESCRIPTION                       |
|:--------|:----------|:--------------------------|
| 0       | string    | Vendor name                     |
| 1       | address   | Vendor address                  |
| 2       | timestamp | Create time: UTC timestamp(s) |
| 3       | valid     | Vendor is valid or not|

## Get vendor info by vendor address
| getVendorByAddress |                    |
|:-------------------|:-------------------|
| Description        | Get vendor information by vendor address |
| Modifier           | NULL               |
| Constant           | TRUE               |

| INPUTS | TYPE     | DESCRIPTION        |
|:--------|:--------|:-----------|
| _vendor | address | Vendor address |

| OUTPUTS  | TYPE      | DESCRIPTION                       |
|:--------|:----------|:--------------------------|
| 0       | string    | Vendor name               |
| 1       | address   | Vendor address            |
| 2       | timestamp | Create time: UTC timestamp(s) |
| 3       | valid     | Vendor is valid or not     |

## All supported tokens ids
| supportedTokens |                    |
|:----------------|:-------------------|
| Description     | Get all supported tokens ids |
| Modifier        | NULL               |
| Constant        | TRUE               |

| INPUTS | TYPE     | DESCRIPTION                         |
|:--------|:--------|:----------------------------|
| _from   | uint256 | The begin id, if id = 0 search from the begin |
| _limit  | uint256 | The limit of one page |

| OUTPUTS  | TYPE      | DESCRIPTION                       |
|:--------|:----------|:--------------------------|
| 0       | uint256[] | Token ids |
| 1       | uint256   | The next id of vendor, if id = 0 the next vendor is null |

## Get token info by id
| getToken    |                    |
|:------------|:-------------------|
| Description | Get token information by token id |
| Modifier    | NULL               |
| Constant    | TRUE               |

| INPUTS  | TYPE     | DESCRIPTION   |
|:---------|:--------|:------|
| _tokenId | uint256 | Token id |

| OUTPUTS  | TYPE   | DESCRIPTION            |
|:--------|:--------|:----------------|
| 0       | string  | Token symbole         |
| 1       | string  | Token name          |
| 2       | uint8   | Token decimal |
| 3       | address | Token address         |


# Update
## Update base token URI
| updateBaseTokenURI |                                   |
|:-------------------|:----------------------------------|
| Description        | Update the base URI of token  |
| Modifier           | msg.sender = owner |
| Constant           | FALSE                             |

| INPUTS   | TYPE     | DESCRIPTION                      |
|:----------|:--------|:-------------------------|
| _uri      | string  | The base URI of token |

| EVENTS                 |              |
|:--------------------|:-------------|
| TokenBaseURIChanged | (string _uri)|

## Add vendor
| addVendor     |               |
|:--------------|:--------------|
| Description   | Add vendor        |
| Modifier      | msg.sender = owner |
| Constant      | FALSE         |

| INPUTS   | TYPE     | DESCRIPTION        |
|:----------|:--------|:-----------|
| _vendor   | address | Vendor address    |
| _name     | string  | Vendor name       |

| EVENTS           |                                       |
|:--------------|:---------------------------------------|
| VendorAdded   | (address indexed _vendor, string _name)|

## Remove vendor by vendor address
| removeVendorByAddress |                  |
|:----------------------|:-----------------|
| Description           | Remove vendor by address |
| Modifier              | msg.sender = owner   |
| Constant              | FALSE            |

| INPUTS   | TYPE     | DESCRIPTION        |
|:----------|:--------|:-----------|
| _vendor   | address | Vendor address     |

| EVENTS           |                          |
|:--------------|:--------------------------|
| VendorRemoved | (address indexed _vendor) |

## Remove vendor by vendor id
| removeVendorById |                 |
|:-----------------|:----------------|
| Description      |  Remove vendor by vendor id |
| Modifier         | msg.sender = owner   |
| Constant         | FALSE           |

| INPUTS   | TYPE     | DESCRIPTION        |
|:----------|:--------|:-----------|
| _vendorId | uint256 | 商户Id     |

| EVENTS           |                          |
|:--------------|:--------------------------|
| VendorRemoved | (address indexed _vendor) |

## Make vendor valid or invalid
| makeVendorValid |               |
|:----------------|:--------------|
| Description     | Make vendor valid or invalid |
| Modifier        | msg.sender = owner |
| Constant        | FALSE         |

| INPUTS   | TYPE     | DESCRIPTION        |
|:----------|:--------|:-----------|
| _vendorId | uint256 | Vendor id  |
| _valid    | bool    | Vendor is valid or not |

| EVENTS         |                                        |
|:------------|:---------------------------------------|
| VendorValid | (address indexed _vendor, bool _valid) |

## Add token
| addToken    |               |
|:------------|:--------------|
| Description | Add token     |
| Modifier    | msg.sender = owner |
| Constant    | FALSE         |

| INPUTS   | TYPE     | DESCRIPTION        |
|:----------|:--------|:-----------|
| _contract | address | Token contract address |

| EVENTS        |                          |
|:-----------|:-------------------------|
| TokenAdded | (address indexed _token) |

## Remove token 
| removeToken |               |
|:------------|:--------------|
| Description | Remove token    |
| Modifier    | msg.sender = owner |
| Constant    | FALSE         |

| INPUTS  | TYPE     | DESCRIPTION   |
|:---------|:--------|:------|
| _tokenId | uint256 | Token id |

| EVENTS          |                  |
|:-------------|:-----------------|
| TokenRemoved | (uint256 _index) |