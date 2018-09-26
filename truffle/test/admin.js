var TripioRoomNightData = artifacts.require("TripioRoomNightData");
var TripioRoomNightAdmin = artifacts.require("TripioRoomNightAdmin");
var TripioTokenOnline = artifacts.require('TripioTokenOnline');
var TripioTokenOnline = artifacts.require('TripioTokenOnline');

contract('TripioRoomNightAdmin', async(accounts) => {
    it("Add vendor", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        await adminInstance.addVendor.sendTransaction(accounts[0], 'Kirn');
        let result = await adminInstance.getVendorIds.call(0, 1);
        let id = result[0].length;
        assert.equal(id, 1);
    });

    it("Remove vendor by address", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        // 检查原有数据
        let result = await adminInstance.getVendorIds.call(0, 1);
        let id = result[0].length;
        assert.equal(id, 1);

        // 删除原有数据
        await adminInstance.removeVendorByAddress.sendTransaction(accounts[0]);
        result = await adminInstance.getVendorIds.call(0, 1);
        
        id = result[0].length;
        assert.equal(id, 0);
    });

    it("Remove vendor by id", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        await adminInstance.addVendor.sendTransaction(accounts[0], 'Kirn');
        let result = await adminInstance.getVendorIds.call(0, 1);
        let id = result[0].length;
        assert.equal(id, 1);

        // 删除原有数据
        await adminInstance.removeVendorById.sendTransaction(result[0][0]);
        result = await adminInstance.getVendorIds.call(0, 1);
        
        id = result[0].length;
        assert.equal(id, 0);
    });

    it("Enable or disable vendor", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        await adminInstance.addVendor.sendTransaction(accounts[0], 'Kirn');
        result = await adminInstance.getVendorIds.call(0, 1);
        let id = result[0].length;
        assert.equal(id, 1);

        // 禁用
        let vid = result[0][0];
        await adminInstance.makeVendorValid.sendTransaction(vid, false);
        result = await adminInstance.getVendor(vid);
        assert.equal(result[3], false);
        // 启用
        await adminInstance.makeVendorValid.sendTransaction(vid, true);
        result = await adminInstance.getVendor(vid);
        assert.equal(result[3], true);
    });

    it("Get vendor by id", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        var result = await adminInstance.getVendorIds.call(0, 1);
        let vid = result[0][0];
        result = await adminInstance.getVendor.call(vid);
        assert.equal(result[1], accounts[0]);
    });

    it("Get vendor by address", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        var result = await adminInstance.getVendorIds.call(0, 1);
        let vid = result[0][0];
        result = await adminInstance.getVendorByAddress.call(accounts[0]);
        assert.equal(parseInt(result[0]), vid, "查询失败");
    });

    it("Add token", async() => {
        let trioInstance = await TripioTokenOnline.deployed();
        let dataInstance = await TripioRoomNightData.deployed();
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        await adminInstance.addToken.sendTransaction(trioInstance.address);
        var result = await adminInstance.supportedTokens.call(0, 1);
        result = await adminInstance.getToken.call(result[0][0]);
        let symbol = result[0];
        let name = result[1];
        let decimals = result[2];
        let _symbol = await trioInstance.symbol.call();
        let _name = await trioInstance.name.call();
        let _decimals = await trioInstance.decimals.call();
        assert.equal(symbol, _symbol, "添加失败");
        assert.equal(name, _name, "添加失败");
        assert.equal(decimals.toNumber(), _decimals.toNumber(), "添加失败");
    });

    it("Remove token", async() => {
        let dataInstance = await TripioRoomNightData.deployed();
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

        var result = await adminInstance.supportedTokens.call(0, 1);
        assert.equal(result[0].length, 1, "添加失败");
        await adminInstance.removeToken.sendTransaction(result[0][0]);
        result = await adminInstance.supportedTokens.call(0, 1);
        assert.equal(result[0].length, 0, "删除失败");
    });

    it("Update base uri", async() => {
        let dataInstance = await TripioRoomNightData.deployed();
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');
        
        await adminInstance.updateBaseTokenURI('https://ipfs.io/ipfs/');
    });
});