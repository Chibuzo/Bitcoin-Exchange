/**
 * BitcoinWalletController
 *
 * @description :: Server-side logic for managing Bitcoinwallets
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
var wallet = require('blockchain.info/MyWallet');


module.exports = {
    createWallet: function(req, res) {
        var apiCode = '97b6062e-bc20-434c-89f5-396ffb9537f7';
        var password = 'untold12345';
        var options = {
            apiHost: 'http://127.0.0.1:3000',
            email: 'info@travelhub.ng',
            label: 'Chibuzo'
        };
        wallet.create(password, apiCode, options).then(function(myWallet) {
            console.log(myWallet);
            var data = {
                quid: myWallet.guid,
                address: myWallet.address,
                label: myWallet.label
            };
            BitcoinWallet.create(data).exec(function(err) {
                return res.json(501, { status: '00', msg: err }); // couldn't be completed
            });
        });
    }
};

