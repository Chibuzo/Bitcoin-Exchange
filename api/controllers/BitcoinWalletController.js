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

            Blockchain.createAddress(foundUser.guid, foundUser.password).then(function(new_address) {
                AddressActions.saveNewAddress(new_address.address, req.session.userId);
                res.json(200, { status: 'success', address: new_address.address });
            });
        });
    }
};

