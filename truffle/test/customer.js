var TripioRoomNightData = artifacts.require("TripioRoomNightData");
var TripioRoomNightAdmin = artifacts.require("TripioRoomNightAdmin");
var TripioRoomNightVendor = artifacts.require("TripioRoomNightVendor");
var TripioRoomNightCustomer = artifacts.require("TripioRoomNightCustomer");
var TripioTokenOnline = artifacts.require('TripioTokenOnline');

contract('TripioRoomNightCustomer', async(accounts) => {
    // it("Add vendor", async() => {
    //     let dataInstance = await TripioRoomNightData.deployed(); 
    //     let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
    //     await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');

    //     await adminInstance.addVendor.sendTransaction(accounts[0], 'Kirn');
    //     let result = await adminInstance.getVendorIds.call(0, 1);
    //     let id = result[0].length;
    //     assert.equal(id, 1);
    // });

    it("Create rate plan", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        let ipfs = '0xa1001394f749d9a0c5f27761b2f08e9432ce215dad6f01dbe26e468857169cbb';
        await vendorInstance.createRatePlan.sendTransaction('无早-大床房', ipfs);
        var result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];
        result = await vendorInstance.ratePlanOfVendor(1, rpid)
        assert.equal(result[2], ipfs)
    });

    it("Update price and inventory", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let trioInstance = await TripioTokenOnline.deployed();
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');
        
        // 启用Token转账
        await trioInstance.enableTransfer.sendTransaction();

        // 预留一个Token
        await adminInstance.addToken.sendTransaction(trioInstance.address);
        var result = await adminInstance.supportedTokens.call(0, 1);
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

        result = await vendorInstance.ratePlansOfVendor(1, 0, 1);
        var rpid = result[0][0];

        // 更新价格
        let ethPrice = 10000;
        let tokenPrice = 100000;
        let inventory = 2;
        await vendorInstance.updatePrices.sendTransaction(rpid, [20180725,20180726], inventory, [0, tokenId], [ethPrice, tokenPrice])
        result = await vendorInstance.priceOfDate.call(1, rpid, 20180725, 1);
        let price = result[1].toNumber();
        inventory = result[0].toNumber();
        assert.equal(price, tokenPrice);
        assert.equal(inventory, 2);
    });

    it("BuyInBatch", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');

        let vendorInstance = await TripioRoomNightVendor.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(vendorInstance.address, 'Vendor');

        let trioInstance = await TripioTokenOnline.deployed();

        let tokenPrice = 200000;
        await trioInstance.approve.sendTransaction(customerInstance.address, tokenPrice);
        await customerInstance.buyInBatch.sendTransaction(1, 1, [20180725,20180726], 1);
        var result = await customerInstance.roomNightsOfOwner(0, 10, false);
        assert(result[0].length == 2);

        let ethPrice = 20000;
        await customerInstance.buyInBatch.sendTransaction(1, 1, [20180725,20180726], 0, {from: accounts[0], value: ethPrice});
        result = await customerInstance.roomNightsOfOwner(0, 10, false);
        assert(result[0].length == 4);

        result = await vendorInstance.priceOfDate.call(1, 1, 20180725, 1);
        let inventory = result[0].toNumber();
        assert.equal(inventory, 0);
    });

    it("Update baseURI", async() => {
        let dataInstance = await TripioRoomNightData.deployed();
        let adminInstance = await TripioRoomNightAdmin.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(adminInstance.address, 'Admin');
        
        await adminInstance.updateBaseTokenURI('https://ipfs.io/ipfs/');
    });

    it("Roon night infomation", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');

        var result = await customerInstance.roomNightsOfOwner(0, 2, false);
        let rnid0 = result[0][0].toNumber();
        let rnid1 = result[0][1].toNumber();
        
        result = await customerInstance.roomNight(rnid0);
        assert.equal(result[0].toNumber(), 1);
        result = await customerInstance.roomNight(rnid1);
        assert.equal(result[0].toNumber(), 1);

        result = await customerInstance.tokenURI(rnid0);
        assert.equal('https://ipfs.io/ipfs/QmZB8R7T5xvKJDUJ6pXtUym6frQx1r6bQPcwquR1rtGHL6', result);
    });

    it("Room night amount", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');

        var result = await customerInstance.balanceOf(accounts[0]);
        assert.equal(result.toNumber(), 4);
    });

    it("Room night owner", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');

        var result = await customerInstance.roomNightsOfOwner(0, 2, false);
        let rnid0 = result[0][0].toNumber();
        let rnid1 = result[0][1].toNumber();

        result = await customerInstance.ownerOf(rnid0);
        assert.equal(result, accounts[0]);
    });

    it("Room night transfer", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');

        var result = await customerInstance.roomNightsOfOwner(0, 2, false);
        let rnid0 = result[0][0].toNumber();
        await customerInstance.safeTransferFrom.sendTransaction(accounts[0], accounts[1], rnid0);
        result = await customerInstance.ownerOf(rnid0);
        assert.equal(result, accounts[1]);
    });

    it("Room night approval", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');

        // 查询account1的Token
        var result = await customerInstance.roomNightsOfOwner(0, 2, false, {from: accounts[1]});
        let rnid0 = result[0][0].toNumber();

        // 授权account0可以操作rnid0
        await customerInstance.approve.sendTransaction(accounts[0], rnid0, {from: accounts[1]});
        
        // 从account1转移到account0, 并校验结果
        await customerInstance.transferFrom.sendTransaction(accounts[1], accounts[0], rnid0);
        result = await customerInstance.ownerOf(rnid0);
        assert.equal(result, accounts[0]);

        var result = await customerInstance.balanceOf(accounts[0]);
        assert.equal(result.toNumber(), 4);

    })

    it("Room night approval for all", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');

        // account0 授权 account1可以操作自己的token
        await customerInstance.setApprovalForAll.sendTransaction(accounts[1], true);

        var result = await customerInstance.isApprovedForAll(accounts[0], accounts[1]);
        assert.equal(result, true);

         // 查询account1的Token
        result = await customerInstance.roomNightsOfOwner(0, 2, false);
        let rnid0 = result[0][0].toNumber();

        // 从account1转移到account0, 并校验结果
        await customerInstance.transferFrom.sendTransaction(accounts[0], accounts[1], rnid0, {from : accounts[1]});
        result = await customerInstance.ownerOf(rnid0);
        assert.equal(result, accounts[1]);

        await customerInstance.setApprovalForAll.sendTransaction(accounts[1], false);
        result = await customerInstance.isApprovedForAll(accounts[0], accounts[1]);
        assert.equal(result, false);
    });

    it("Withdraw", async() => {
        let dataInstance = await TripioRoomNightData.deployed(); 
        let customerInstance = await TripioRoomNightCustomer.new(dataInstance.address);
        await dataInstance.authorizeContract.sendTransaction(customerInstance.address, 'Customer');


        await web3.eth.sendTransaction({from: accounts[0], to: customerInstance.address , value: web3.toWei(1, "ether")});

        var result = await web3.eth.getBalance(customerInstance.address);
        assert.equal(result.toNumber(), web3.toWei(1, "ether"));

        // eth 提现
        await customerInstance.withdrawBalance.sendTransaction();
        result = await web3.eth.getBalance(customerInstance.address);
        assert.equal(result.toNumber(), 0);

        // token 提现
        let trioInstance = await TripioTokenOnline.deployed();
        // 启用Token转账
        await trioInstance.enableTransfer.sendTransaction();
        await trioInstance.transfer.sendTransaction(customerInstance.address, 10000);

        result = await trioInstance.balanceOf.call(customerInstance.address);
        assert.equal(result.toNumber(), 10000);

        await customerInstance.withdrawToken.sendTransaction(trioInstance.address);
        result = await trioInstance.balanceOf.call(customerInstance.address);
        assert.equal(result.toNumber(), 0);
    })
});