/**
 * Created by Uzo on 4/10/2017.
 */

var Client = require('bitcore-wallet-client');
const aes256 = require('nodejs-aes256');
var Promise = require('promise');

//var BWS_INSTANCE_URL = 'http://localhost:3232/bws/api';
var BWS_INSTANCE_URL = 'https://bws.bitpay.com/bws/api';
var NETWORK = 'testnet';

var client = new Client({
    baseUrl: BWS_INSTANCE_URL,
    verbose: true,
});

module.exports = {
    createWallet: function (name, hashed_pswd, passphrase) {
        return new Promise(function(resolve, reject) {
            client.seedFromRandomWithMnemonic({ network: NETWORK, passphrase: passphrase });
            client.createWallet(name, "CapitalX", 1, 1, { network: NETWORK }, function(err) {
                if (err) {
                    console.log('error: ', err);
                    return reject(err);
                }
                var hash = require('crypto').createHash('sha256');
                var key = hash.update(hashed_pswd).digest('base64');
                var wallet = {
                    raw_mnemonic: client.getMnemonic(),
                    encrypted_mnemonic: aes256.encrypt(key, client.getMnemonic()),
                    //wallet_id: ret.walletId
                };
                return resolve(wallet);
            });
        });
    },
    
    getBalance: function(encrypted_mnemonic, hashed_pswd, passphrase) {
        return new Promise(function(resolve, reject) {
            var hash = require('crypto').createHash('sha256');
            var key = hash.update(hashed_pswd).digest('base64');
            var mnemonic = aes256.decrypt(key, encrypted_mnemonic);
            //client.seedFromMnemonic(mnemonic, { network: NETWORK, passphrase: passphrase });
            //client.openWallet(function(err, wal) {
            client.importFromMnemonic(mnemonic, { network: NETWORK, passphrase: passphrase }, function(err) {
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
                    //console.log(balance);
                    return resolve(Balance);
                });
            });
        });
    },
    
    generateAddress: function(encrypted_mnemonic, hashed_pswd, passphrase) {
        return new Promise(function(resolve, reject) {
            var hash = require('crypto').createHash('sha256');
            var key = hash.update(hashed_pswd).digest('base64');
            var mnemonic = aes256.decrypt(key, encrypted_mnemonic);
            client.importFromMnemonic(mnemonic, { network: NETWORK, passphrase: passphrase }, function(err) {
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
    
    sendBTC: function(encrypted_mnemonic, hashed_pswd, passphrase, send_addr, amount, msg) {
        return new Promise(function(resolve, reject) {
            var hash = require('crypto').createHash('sha256');
            var key = hash.update(hashed_pswd).digest('base64');
            var mnemonic = aes256.decrypt(key, encrypted_mnemonic);
            client.importFromMnemonic(mnemonic, { network: NETWORK, passphrase: passphrase }, function(err) {
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
                client.createTxProposal( opts, function (err, txp) {
                    if (err) {
                        console.log(err + " - this");
                        return;
                    }
                    client.publishTxProposal({txp: txp}, function (err, txp) {
                        if (err) {
                            console.log(err);
                            return;
                        }
                        client.signTxProposal(txp, function (err, txp) {
                            if (err) {
                                console.log(err);
                                return;
                            }
                            client.broadcastTxProposal(txp, function (err, txp, memo) {
                                if (err) {
                                    console.log(err);
                                    return;
                                }
                                if (memo) {
                                    console.log(memo);
                                }
                                //console.log("Transaction was successfully broadcasted!");
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
