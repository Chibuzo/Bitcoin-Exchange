/**
 * OrderController
 *
 * @description :: Server-side logic for managing Orders
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
var validator = require('validator');

module.exports = {
	placeOrder: function(req, res) {
      var param = req.param;
      if (_.isUndefined(param('btc_qty')) || !validator.isDecimal(param('btc_qty'))) {
          return res.json(200, { status: 'error', msg: 'Bitcoin quantity must be in numbers' });
      }
      if (_.isUndefined(param('prefered_amount')) || !validator.isDecimal(param('prefered_amount'))) {
          return res.json(200, { status: 'error', msg: 'Naira amount must be in number' });
      }
		
      // let's check if this order is eligible
      if ((param('btc_qty') * param('prefered_amount')) > req.session.naira_available) {
        sendMail.sendErrMsg('Attempted hacking (Trading)', req.session.stringify);
        return res.json(200, { status: 'error', msg: 'Invalid Order' });
      }
      // lock the required amount required for this order
      var tnx_desc = "BTC purchase";
      var tnx_amt = param('prefered_amount') * param('btc_qty');
      NairaAccount.transaction('Debit', 'transfer', tnx_desc, tnx_amt, req.session.userId, 'Pending').then(function(ret) {
          if (ret.status == 'success') {
              User.findOne({ id: req.session.userId }).exec(function(err, user) {
                  if (err) return;
                  var passphrase = user.email + "." + user.id;
                  Wallet.generateAddress(user.mnemonic, req.session.hash, passphrase).then(function(addr) {
                      var data = {
                          owner: req.session.userId,
                          btc_amount: param('btc_qty'),
                          amount_per_btc: param('prefered_amount'),
                          btc_address: addr,
                          fees: sails.fees.sell_btc,
                          transaction: ret.tnx_id,
                          status: 'Open'
                      };
                      Order.create(data).exec(function(err, order) {
                          if (err) {
                              sendMail.sendErrMsg(err, data);
                              return res.json(200, { status: 'error', msg: err });
                          }
                          // try and match this order
                          Trading.marchOrder(order.id, param('btc_qty'), param('prefered_amount'), addr, req.session.userId);
                      });
                  });
              });
          } else {
              sendMail.sendErrMsg('Could lock down payment for btc order');
          }
      }).catch(function(err) {
          console.log(err);
      });
      return res.json(200, { status: 'success' });
  },
	
	cancelOrder: function(req, res) {
		var id = req.param('id');
		Order.destroy({ id: id, status: 'Open' }).exec(function(err, order) {
			if (err) return;
			NairaTransaction.destroy({ id: order[0].transaction }).exec(function(err) {
				if (err) console.log(err);	
			});
			return res.json(200, { status: 'success' });
		});
	}
};

