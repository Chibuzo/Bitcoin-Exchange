/**
 * BitcoinTransactionController
 *
 * @description :: Server-side logic for managing Bitcointransactions
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	sendBTC: function(req, res) {
        User.findOne({ id: req.session.userId }).exec(function(err, foundUser) {
            if (err) {
                return res.json(200, { status: 'error', msg: err });
            }
            // see if we generated the address
            GeneratedAddress.findOne({ address: req.param('btc_address') }).exec(function(err, result) {
                if (err) {
                    sendMail.sendErrMsg(err);
                    return res.ok();
                }
                var receiver = 0;
                if (result) {
                    receiver = result.user_id;
                }
                    Blockchain.sendBitcoin(foundUser.guid, foundUser.password, req.param('btc_address'), req.param('btc_amount')).then(function(response) {
                        AddressActions.saveBTCTransaction(req.param('btc_address'), req.param('btc_amount'), req.session.userId, receiver, response.fee, req.param('description'), response.txid, response.tx_hash, response.message, response.success);
                        return res.json(200, { status: 'success' });
                    })
                    .catch(function(err) {
                        console.log(err);
                    });
                /*} else {

                }*/
            });
        });
    },

    getTransactions: function(req, res) {
        BitcoinTransaction.find({ sender: req.session.userId })
            .populate('receiver').exec(function(err, tnx) {
            if (err) console.log(err);
            res.view('bitcoin/transactions', { trnx: tnx });
        });
    }
};

