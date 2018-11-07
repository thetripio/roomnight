# Contract
* Ropsten：[0x1E212155EF1197cC42B8A8D5dDffF6Dc4C584CE7](https://ropsten.etherscan.io/address/0x1E212155EF1197cC42B8A8D5dDffF6Dc4C584CE7)
* Main：[0x09FD12C95F8b4738609cF38D58DDaD0Abb792cd3](https://ropsten.etherscan.io/address/0x09FD12C95F8b4738609cF38D58DDaD0Abb792cd3)

# Query
## Get all vendors
| getVendorIds |                     |
|:--------------|:-------------------|
| Description  | Get all vendor's ids |
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