var LinkedListLib = artifacts.require("LinkedListLib");
var TripioRoomNightData = artifacts.require("TripioRoomNightData");
var TripioRoomNightAdmin = artifacts.require("TripioRoomNightAdmin");
var TripioRoomNightCustomer = artifacts.require("TripioRoomNightCustomer");
var TripioRoomNightVendor = artifacts.require("TripioRoomNightVendor");

contract('TripioRoomNightData', async(accounts) => {
    it("Authorize contract", async() => {
        let dataInstance = await TripioRoomNightData.deployed();
        let adminInstance =  await TripioRoomNightAdmin.new(dataInstance.address);
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        
        // 授权合约
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        // 查询所有授权合约
        var result = await dataInstance.getAuthorizeContractIds.call(0, 3);
        var ids = result[0];
        for (let i = 0; i < ids.length; i++) {
            const id = ids[i];
            let contractInfo = await dataInstance.getAuthorizeContract.call(id);

            if(contractInfo[0] === 'Admin') {
                assert.equal(adminInstance.address, contractInfo[1]);
            }else if(contractInfo[0] === 'Customer') {
                assert.equal(customerInstance.address, contractInfo[1]);
            }else if(contractInfo[0] === 'Vendor') {
                assert.equal(vendorInstance.address, contractInfo[1]);
            }

            // 解除授权
            await dataInstance.deauthorizeContractById.sendTransaction(id);
        }

        // 再次查询
        result = await dataInstance.getAuthorizeContractIds.call(0, 3);
        ids = result[0].length;
        assert.equal(ids, 0);
    });
});