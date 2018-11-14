# Vendor
## Rateplan
The vendor has the RP query and management functions, and can query the RP list and details maintained by the vendor, and can modify and delete at any time.

### Create Delete Update RP
The vendor can save the structured information of the room night to a file and upload it to the IPFS node to get the corresponding file address, and then create an RP on the chain through the IPFS file address and the RP name.
The RP holder can delete the RP that he created. If the information changes during the room night, you need to re-upload the IPFS to generate a new file address and modify the corresponding RP.

### Rateplan List
Vendors can query all the RPs they have created on the chain and can display them by pagination.

### Rateplan Detail
The RP details can be queried by vendor ID and RP ID. RP details include: name, creation time, IPFS address.

## Price And Inventory
After the vendor has created the RP, it needs to set the corresponding inventory and price for the RP to sell.

## Base Price And Iventory
Vendor can set a base price and inventory for an RP to take effect for all dates.

## Special Price
In addition to the base price, you can set a specific price and inventory for a certain date. In the price setting, in addition to the price of the corresponding ETH, other ERC 2.0 Token price settings are provided, that is, each RP can be set to sell at different token prices.

After the price and inventory settings are completed, you can query the inventory and price of a certain date on the chain. 