# 合约地址
* Ropsten：[0x8ce76Ec4F7D39B274a87123730870309B6F708e5](https://ropsten.etherscan.io/address/0x8ce76Ec4F7D39B274a87123730870309B6F708e5)
* Main：[0xa11C24A774dEbcCf53Da7152964d7C7DAd960fa1](https://ropsten.etherscan.io/address/0xa11C24A774dEbcCf53Da7152964d7C7DAd960fa1)

# Query
## Get inventories of dates
| inventoriesOfDate  |                          |
|:----------------------------|:-------------------------|
| Description                 | Get inventories by vendor id, rateplan id and dates |
| Modifier                    | Vendor id is valid and rateplan id is valid too|
| Constant                    | TRUE |

| INPUTS   | TYPE     | DESCRIPTION                              |
|:----------|:--------|:----------------------------------|
| _vendorId | uint256 | Vendor id |
| _rpid     | uint256 | Rateplan id |
| _dates    | uint256[]| Dates E.g: [20180610,20180611] |

| OUTPUTS  | TYPE      | DESCRIPTION    |
|:--------|:----------|:--------|
| 1       | uint16[]  | Inventories | 

## Get prices of dates
| pricesOfDate  |                          |
|:----------------------------|:-------------------------|
| Description                 | Get prices by vendor id, rateplan id, dates and token id |
| Modifier                    | Vendor id is valid and rateplan id is valid too|
| Constant                    | TRUE |

| INPUTS   | TYPE     | DESCRIPTION                              |
|:----------|:--------|:----------------------------------|
| _vendorId | uint256 | Vendor id|
| _rpid     | uint256 | Rateplan id |
| _dates    | uint32[]| Dates E.g: [20180610,20180611] |
| _token    | uint256 | Token id |

| OUTPUTS  | TYPE      | DESCRIPTION    |
|:--------|:----------|:--------|
| 1       | uint256[] |  Prices | 

## Get price and inventory of date
| priceOfDate  |                          |
|:----------------------------|:-------------------------|
| Description                 | Get price and inventory by vendor id, rateplan id, date and token id |
| Modifier                    |  Vendor id is valid and rateplan id is valid too |
| Constant                    | TRUE |

| INPUTS   | TYPE     | DESCRIPTION                              |
|:----------|:--------|:----------------------------------|
| _vendorId | uint256 | Vendor id |
| _rpid     | uint256 | Rateplan id |
| _date     | uint256| Date E.g: 20180630 |
| _token    | uint256 | Token id |


| OUTPUTS  | TYPE      | DESCRIPTION    |
|:--------|:----------|:--------|
| 0      | uint16 | Inventory | 
| 1       | uint256 | Price | 

## Get rateplans of vendor
| ratePlansOfVendor  |                          |
|:----------------------------|:-------------------------|
| Description                 | Get rateplans of vendor by vendor id |
| Modifier                    | NULL |
| Constant                    | TRUE |

| INPUTS   | TYPE     | DESCRIPTION                              |
|:----------|:--------|:----------------------------------|
| _vendorId | uint256 | Vendor id |
| _from     | uint256 | The begin id, if id = 0 search from the begin |
| _limit    | uint256 | The limit of one page |

| OUTPUTS  | TYPE      | DESCRIPTION    |
|:--------|:----------|:--------|
| 0      | uint256[] | Rateplan ids | 
| 1      | uint256 | The next id of rateplan, if id = 0 the next rateplan is null | 

## Get rateplan info

| ratePlanOfVendor  |                          |
|:----------------------------|:-------------------------|
| Description                 | Get rateplan information by vendor id and rateplan id |
| Modifier                    | NULL |
| Constant                    | TRUE |

| INPUTS   | TYPE     | DESCRIPTION                              |
|:----------|:--------|:----------------------------------|
| _vendorId | uint256 | Vendor id |
| _rpid     | uint256 | Rateplan id |

| OUTPUTS  | TYPE      | DESCRIPTION    |
|:--------|:----------|:--------|
| 0      | string | Rateplan name | 
| 1      | timestamp | Create time: UTC timestamp(s) | 
| 2      | bytes32 | IPFS file address | 

## Get prices and inventories of dates
| pricesAndInventoriesOfDate  |                          |
|:----------------------------|:-------------------------|
| Description                 | Get prices and inventories by vendor id, rateplan id, dates, token id |
| Modifier                    | The begin id, if id = 0 search from the begin |
| Constant                    | TRUE |

| INPUTS   | TYPE     | DESCRIPTION  |
|:----------|:--------|:------|
| _vendorId | uint256 | Vendor id |
| _rpid     | uint256 | Rateplan Id |
| _dates    | uint256[] | Date E.g: [20180610,20180611] |
| _token    | uint256 | Token id |

| OUTPUTS  | TYPE      | DESCRIPTION    |
|:--------|:----------|:--------|
| 0      | uint256[] | Prices | 
| 1      | uint16[] | Inventories | 

# Update
## Update prices
| updatePrices  |                          |
|:----------------------------|:-------------------------|
| Description                 | Update prices and inventory of rateplan|
| Modifier                    | msg.sender = rateplan's owner, rateplan is valid |
| Constant                    | FALSE |

| INPUTS   | TYPE     | DESCRIPTION  |
|:----------|:--------|:------|
| _rpid | uint256 | RP Id |
| _dates    | uint256[] | Date E.g: [20180610,20180611] |
| _inventory | uint16 | Inventory |
| _tokens    | uint256[] | Token ids |
| _prices    | uint256[] | Prices of tokens|

| EVENTS  |       |
|:--------|:----------|
| RatePlanPriceChanged    | (uint256 indexed _rpid) | 

## Update inventories
| updateInventories  |                          |
|:----------------------------|:-------------------------|
| Description                 | Update inventories of rateplan |
| Modifier                    | msg.sender = rateplan's owner, rateplan is valid |
| Constant                    | FALSE |

| INPUTS   | TYPE     | DESCRIPTION  |
|:----------|:--------|:------|
| _rpid | uint256 | Rateplan id |
| _dates    | uint256[] | Date E.g: [20180610,20180611] |
| _inventory | uint16 | Inventory |


| EVENTS  |       |
|:--------|:----------|
| RatePlanInventoryChanged  | (uint256 indexed _rpid) | 


## Update base price 
| updateBasePrice  |                          |
|:----------------------------|:-------------------------|
| Description                 | Update the base price of all rateplans |
| Modifier                    | msg.sender = rateplan's owner, rateplan is valid  |
| Constant                    | FALSE |

| INPUTS   | TYPE     | DESCRIPTION  |
|:----------|:--------|:------|
| _rpid | uint256 | RP Id |
| _tokens    | uint256[] | Token ids |
| _prices | uint256[] | Prices of tokens |
| _inventory | uint16 | Inventory |


| EVENTS  |       |
|:--------|:----------|
| RatePlanBasePriceChanged  | (uint256 indexed _rpid) | 

## Create rateplan
| createRatePlan  |                          |
|:----------------------------|:-------------------------|
| Description                 | Create new rateplan |
| Modifier                    | msg.sender is valid vendor |
| Constant                    | FALSE |

| INPUTS   | TYPE     | DESCRIPTION  |
|:----------|:--------|:------|
| _name | string | Rateplan name |
| _ipfs    | bytes32 | The IPFS's address of rateplan's desc |

| EVENTS  |       |
|:--------|:----------|
| RatePlanCreated  | (address indexed _vendor, string _name, bytes32 indexed _ipfs) | 


## Remove rateplan
| removeRatePlan  |                          |
|:----------------------------|:-------------------------|
| Description                 | Remove rateplan |
| Modifier                    | msg.sender = rateplan's owner|
| Constant                    | FALSE |

| INPUTS   | TYPE     | DESCRIPTION  |
|:----------|:--------|:------|
| _rpid | uint256 | RP Id |

| EVENTS  |       |
|:--------|:----------|
| RatePlanRemoved  | (address indexed _vendor, uint256 indexed _rpid) | 

## Modify rateplan
| modifyRatePlan  |                          |
|:----------------------------|:-------------------------|
| Description                 | Modify rateplan |
| Modifier                    | msg.sender = rateplan's owner |
| Constant                    | FALSE |

| INPUTS   | TYPE     | DESCRIPTION  |
|:----------|:--------|:------|
| _rpid | uint256 | Rateplan id |
| _name | string | Rateplan name |
| _ipfs | bytes32 | The IPFS's address of rateplan's desc |

| EVENTS  |       |
|:--------|:----------|
| RatePlanModified  | (address indexed _vendor, uint256 indexed _rpid, string name, bytes32 _ipfs) | 