/**
 * Created by Uzo on 4/10/2017.
 */

var Client = require('bitcore-wallet-client');

var BWS_INSTANCE_URL = 'https://bws.bitpay.com/bws/api';
var NETWORK = 'testnet';

var client = new Client({
    baseUrl: BWS_INSTANCE_URL,
    verbose: false,
});

module.exports = {
    createWallet: function (name, passphrase) {
        return new Promise(function(resolve, reject) {
            client.seedFromRandomWithMnemonic({ network: NETWORK, passphrase: passphrase });
            client.createWallet("Afiaego", name, 1, 1, { network: NETWORK }, function(err, ret) {
                if (err) {
                    console.log('error: ', err);
                    return reject(err);
                }
                var wallet = {
                    mnemonic: client.getMnemonic(),
                    wallet_id: ret.walletId
                };
                return resolve(wallet);
            });
        });
    },
    
    getBalance: function(encrypted_code, passphrase) {
        return new Promise(function(resolve, reject) {
            client.seedFromMnemonic(encrypted_code, { network: NETWORK, passphrase: passphrase });
            client.openWallet(function(err) {
                if (err) {
                    console.log(err);
                    return reject(err);
                }
                client.getBalance(function(err, balance) {
                    if (err) {
                        console.log(err);
                        return reject(err);
                    }
                    var Balance = {
                        available: balance.availableAmount,
                        totalAmount: balance.totalAmount
                    };
                    return resolve(Balance);
                });
            });
        });
    },
    
    generateAddress: function(encrypted_code, passphrase) {
        return new Promise(function(resolve, reject) {
            //client.seedFromMnemonic(encrypted_code, { network: NETWORK, passphrase: passphrase });
            client.importFromMnemonic(encrypted_code, { network: NETWORK, passphrase: passphrase }, function(err) {
                if (err) {
                    console.log(err);
                    return reject(err);
                }
                client.createAddress({}, function(err, addr) {
                    if (err) {
                        console.log('error: ', err);
                        return reject(err);
                    }
                    return resolve(addr.address);
                });
            });
        });
    },
    
    sendBTC: function(encrypted_code, passphrase, send_addr, amount, msg) {
        var _client = new Client({
            baseUrl: BWS_INSTANCE_URL,
            verbose: false,
        });
        return new Promise(function(resolve, reject) {
            _client.importFromMnemonic(encrypted_code, { network: NETWORK, passphrase: passphrase }, function(err) {
            //client.openWallet(function(err) {
                if (err) {
                    console.log(err);
                    return reject(err);
                }

                var outputs = [{
                    toAddress: send_addr,
                    amount: amount * 100000000
                }];
                var opts = {
                    outputs: outputs,
                    message: msg,
                    feePerKb: 50000
                };
                //console.log(outputs);
                _client.createTxProposal( opts, function (err, txp) {
                    if (err) {
                        console.log(err + " - this");
                        return;
                    }
                    _client.publishTxProposal({txp: txp}, function (err, txp) {
                        if (err) {
                            console.log(err);
                            return;
                        }
                        _client.signTxProposal(txp, function (err, txp) {
                            if (err) {
                                console.log(err);
                                return;
                            }
                            _client.broadcastTxProposal(txp, function (err, txp, memo) {
                                if (err) {
                                    console.log(err);
                                    return;
                                }
                                if (memo) {
                                    console.log(memo);
                                }
                                console.log("Transaction was successfully broadcasted!");
                                var response = {
                                    txid: txp.txid,
                                    fee: txp.fee,
                                    status: 'success'
                                };
                                return resolve(response);
                            });
                        });
                    });
                });
            });
        });
    }
}
