var LinkedListLib = artifacts.require("LinkedListLib");
var TripioRoomNightData = artifacts.require('TripioRoomNightData');
var TripioRoomNightAdmin = artifacts.require('TripioRoomNightAdmin');
var TripioRoomNightCustomer = artifacts.require('TripioRoomNightCustomer');
var TripioRoomNightVendor = artifacts.require('TripioRoomNightVendor');
var TripioTokenOnline = artifacts.require('TripioTokenOnline');

module.exports = function(deployer, network ,accounts) {
    // deploy TripioTokenOnline
    deployer.deploy(TripioTokenOnline);

    // deploy LinkedListLib
    deployer.deploy(LinkedListLib);

    // deploy TripioRoomNightData
    deployer.link(LinkedListLib, TripioRoomNightData);

    deployer.deploy(TripioRoomNightData).then(function() {
        // deploy TripioRoomNightAdmin
        return deployer.deploy(TripioRoomNightAdmin, TripioRoomNightData.address);
    }).then(function() {
         // deploy TripioRoomNightCustomer
        return deployer.deploy(TripioRoomNightCustomer, TripioRoomNightData.address);
    }).then(function() {
        // deploy TripioRoomNightVendor
        return deployer.deploy(TripioRoomNightVendor, TripioRoomNightData.address);
    });
};
