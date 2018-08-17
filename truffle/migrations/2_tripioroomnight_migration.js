var LinkedListLib = artifacts.require("LinkedListLib");
var TripioTokenOnline = artifacts.require('TripioTokenOnline');

module.exports = function(deployer, network ,accounts) {
    // deploy TripioTokenOnline
    deployer.deploy(TripioTokenOnline);

    // deploy LinkedListLib
    deployer.deploy(LinkedListLib);
};
