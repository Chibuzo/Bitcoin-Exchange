/**
 * BitcoinWalletController
 *
 * @description :: Server-side logic for managing Bitcoinwallets
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    createNewAddress: function(req, res) {
        User.findOne({ id: req.session.userId }).exec(function(err, foundUser) {
            if (err) {
                sendMail.sendErrMsg(err);
            }
            var passhrase = foundUser.email + "." + foundUser.id;
            Wallet.generateAddress(foundUser.mnemonic, foundUser.password, passhrase).then(function(addr) {
                AddressActions.saveNewAddress(addr, req.session.userId);
                res.json(200, { status: 'success', address: addr });
            }).catch(function(err) {
                console.log(err);
            });
        });
    }
};

