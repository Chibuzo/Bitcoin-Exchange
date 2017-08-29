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
				var q = req.param;
				var passhrase = foundUser.email + "." + foundUser.id;
				Wallet.sendBTC(foundUser.mnemonic, foundUser.password, passhrase, q('btc_address'), q('btc_amount'), q('description')).then(function(resp) {
					AddressActions.saveBTCTransaction(q('btc_address'), q('btc_amount'), req.session.userId, receiver, resp.fee, q('description'), resp.txid, 'message', 'Done');
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
        BitcoinTransaction.find()
        .where({
          or: [
            { sender: req.session.userId },
            { receiver: req.session.userId }
          ]
        }).sort('createdAt DESC').populate('receiver').exec(function(err, tnx) {
            if (err) console.log(err);
            res.view('bitcoin/transactions', { trnx: tnx });
        });
    },
    
    instantBuy: function(req, res) {
        market_price = 1500000;
        var btc = req.param('btc_qty');
        var purchase_amt = btc * market_price;
        
        // fetch central wallet details
        User.findOne({ id: req.session.userId }).exec(function(err, buyer) {
            if (err) return res.json(200, { status: 'error', msg: 'An error occured. We are unable to proceed with this request'});
            var passhrase = buyer.email + "." + buyer.id;
            Wallet.generateAddress(buyer.mnemonic, req.session.hash, passhrase).then(function(addr) {
                User.findOne({ admin: true }).exec(function(err, admin) {
                    if (err) return res.json(200, { status: 'error', msg: 'An error occured. We are unable to proceed with this request'});
                    var passhrase = admin.email + "." + admin.id;
                    Wallet.sendBTC(admin.mnemonic, admin.salt, passhrase, addr, btc, 'Instant Purhase from CapitalX').then(function(resp) {
                        AddressActions.saveBTCTransaction(addr, btc, admin.id, buyer.id, resp.fee, msg, resp.txid, 'Successful');
                        NairaAccount.transaction('Debit', 'transfer', 'BTC Purchase from CapitalX', purchase_amt, buyer.id);
                        NairaAccount.transaction('Credit', 'transfer', 'BTC Purchase from CapitalX', purchase_amt, admin.id);
                    });
                });
            });
        });
    }
};

