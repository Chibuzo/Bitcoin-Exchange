/**
 * Created by Uzo on 3/13/2017.
 */

//var Wallet = require('blockchain.info/MyWallet');

//var options = { apiCode: sails.config.api.key, apiHost: 'http://localhost:3000' };

module.exports = {
    createWallet: function(email, password, user_id) {
        var apiCode = sails.config.api.key;
        var password = password;
        var options = {
            apiHost: 'http://127.0.0.1:3000',
            email: email
        };
        Wallet.create(password, apiCode, options).then(function(myWallet) {
            var data = {
                guid: myWallet.guid,
                user_id: user_id
            };
            User.update({id: user_id}, { guid: myWallet.guid }).then(function(err) {
                // consider sending mail
            });
            return 'success';
        });
    },

    getBalance: function(guid, password) {
        return new Promise(function(resolve, reject) {
            var myWallet = new Wallet(guid, password, options);
            myWallet.getBalance().then(function(balance) {
                return resolve(balance);
            })
            .catch(function(err) {
                return reject(err);
            });
        });
    },

    createAddress: function(guid, password) {
        return new Promise(function(resolve, reject) {
            var myWallet = new Wallet(guid, password, options);

            myWallet.newAddress(options).then(function(address) {
                return resolve(address);
            })
            .catch(function(err) {
                return reject(err);
            });
        });
    },

    sendBitcoin: function(guid, password, address, amount) {
        return new Promise(function(resolve, reject) {
            var myWallet = new Wallet(guid, password, options);
            var satoshi = amount * 100000000;
            myWallet.send(address, satoshi, options).then(function(response) {
                console.log(response);
                return resolve(response);
            })
            .catch(function(err) {
                return reject(err);
            });
        });
    }
}
