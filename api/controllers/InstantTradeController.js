/**
 * InstantTradeController
 *
 * @description :: Server-side logic for managing Instanttrades
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    instantBuy: function(req, res) {
        market_price = req.param('market_price');
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
                        NairaAccount.transaction('Debit', 'transfer', 'BTC Purchase from CapitalX', purchase_amt, buyer.id, '', 'confirmed');
                        InstantTradeService.buyBTC(req.session.userId, btc, market_price);
                    });
                });
            });
        });
    }
};

