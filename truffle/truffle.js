/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a 
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() { 
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>') 
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

module.exports = {
    solc: {
        optimizer: {
          enabled: true,
          runs: 200
        }
    },
    mocha: {
        useColors: true
    },
    networks: {
        mainnet: {
            host: "",
            port: 8545,
            network_id: '1'
        },
        ropsten: {
            host: "",
            port: 8545,
            network_id: '3',
        },
        test: {
            host: "127.0.0.1",
            port: 9545,
            network_id: '*',
            from: "0x627306090abab3a6e1400e9345bc60c78a8bef57",
            gas: 6712388,
            gasPrice: 100000000000
        },
        dev: {
            host: "127.0.0.1",
            port: 9545,
            network_id: '*',
            from: "0x627306090abab3a6e1400e9345bc60c78a8bef57",
            gas: 6712388,
            gasPrice: 100000000000
        }
    }
};
