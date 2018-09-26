var TripioRoomNightData = artifacts.require("TripioRoomNightData");
var TripioRoomNightAdmin = artifacts.require("TripioRoomNightAdmin");
var TripioRoomNightVendor = artifacts.require("TripioRoomNightVendor");
var TripioTokenOnline = artifacts.require('TripioTokenOnline');

contract('TripioRoomNightVendor', async(accounts) => {
    it("Add vendor", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        await adminInstance.addVendor.sendTransaction(accounts[0], 'Kirn');
        let result = await adminInstance.getVendorIds.call(0, 1);
        let id = result[0].length;
        assert.equal(id, 1);
    });

    it("Create rate plan", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        let ipfs = '0xa1001394f749d9a0c5f27761b2f08e9432ce215dad6f01dbe26e468857169cbb';
        await vendorInstance.createRatePlan.sendTransaction('Superior Queen', ipfs);
        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];
        result = await vendorInstance.ratePlanOfVendor(1, rpid)
        assert.equal(result[2], ipfs)
    });

    it("Modify rate plan" , async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];

        let ipfs = '0xa1001394f749d9a0c5f27761b2f08e9432ce215dad6f01dbe26e468857169cbb';
        let name = 'Club King';
        await vendorInstance.modifyRatePlan.sendTransaction(rpid, name, ipfs);
        
        result = await vendorInstance.ratePlanOfVendor(1, rpid)
        assert.equal(result[0], name)
    });

    it("Remove rate plan", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];

        await vendorInstance.removeRatePlan.sendTransaction(rpid);
        
        result = await vendorInstance.ratePlansOfVendor(1, 0, 1);

        assert.equal(result[0].length, 0)
    });

    it("Update price and inventory", async() => {
        // rate plan
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        let ipfs = '0xa1001394f749d9a0c5f27761b2f08e9432ce215dad6f01dbe26e468857169cbb';
        await vendorInstance.createRatePlan.sendTransaction('Superior King', ipfs);
        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];
        result = await vendorInstance.ratePlanOfVendor(1, rpid)
        assert.equal(result[2], ipfs)

        // token
        let trioInstance = await TripioTokenOnline.deployed();
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        await adminInstance.addToken.sendTransaction(trioInstance.address);
        result = await adminInstance.supportedTokens.call(0, 1);
        let tokenId = result[0][0];
        result = await adminInstance.getToken.call(tokenId);
        let symbol = result[0];
        let name = result[1];
        let decimals = result[2];
        let _symbol = await trioInstance.symbol.call();
        let _name = await trioInstance.name.call();
        let _decimals = await trioInstance.decimals.call();
        assert.equal(symbol, _symbol);
        assert.equal(name, _name);
        assert.equal(decimals.toNumber(), _decimals.toNumber());

        // update price
        let ethPrice = 10000;
        let tokenPrice = 100000;

        await vendorInstance.updatePrices.sendTransaction(rpid, [20180725,20180726], 1, [0, tokenId], [10000, 100000])

        result = await vendorInstance.priceOfDate.call(1, rpid, 20180725, 1);
        let price = result[1].toNumber();
        let inventory = result[0].toNumber();
        assert.equal(price, tokenPrice);
        assert.equal(inventory, 1);
    });

    it("Get price", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        // 
        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];
        let tokenPrice = 100000;
        let ethPrice = 10000;
        result = await vendorInstance.pricesOfDate.call(1, rpid, [20180725, 20180726], 1);
        assert.equal(tokenPrice, result[0].toNumber());
        result = await vendorInstance.pricesOfDate.call(1, rpid, [20180725, 20180726], 0);
        assert.equal(ethPrice, result[1].toNumber());
    });

    it("Update inventory only", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];
        await vendorInstance.updateInventories(rpid, [20180725, 20180726], 2)
        result = await vendorInstance.inventoriesOfDate.call(1, rpid, [20180725, 20180726]);
        
        assert.equal(2, result[0].toNumber());
        assert.equal(2, result[1].toNumber());
    }); 

    it("Update price and inventory", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];
        await vendorInstance.updatePrices.sendTransaction(rpid, [20180725], 1, [0, 1], [10, 100]);

        result = await vendorInstance.priceOfDate.call(1, rpid, 20180725, 0);
        var price = result[1].toNumber();
        var inventory = result[0].toNumber();
        assert.equal(price, 10);
        assert.equal(inventory, 1);

        result = await vendorInstance.priceOfDate.call(1, rpid, 20180725, 1);
        price = result[1].toNumber();
        inventory = result[0].toNumber();
        assert.equal(price, 100);
        assert.equal(inventory, 1);

        await vendorInstance.updateInventories.sendTransaction(rpid, [20180725], 2);
        result = await vendorInstance.priceOfDate.call(1, rpid, 20180725, 1);
        price = result[1].toNumber();
        inventory = result[0].toNumber();
        assert.equal(price, 100);
        assert.equal(inventory, 2);
    });

    it("Update base price", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];
        await vendorInstance.updateBasePrice(rpid, [0, 1], [10, 100], 1);
        
        result = await vendorInstance.priceOfDate.call(1, rpid, 20180801, 0);
        var price = result[1].toNumber();
        var inventory = result[0].toNumber();
        assert.equal(price, 10);
        assert.equal(inventory, 1);

        result = await vendorInstance.priceOfDate.call(1, rpid, 20180801, 1);
        price = result[1].toNumber();
        inventory = result[0].toNumber();
        assert.equal(price, 100);
        assert.equal(inventory, 1);
    });
});