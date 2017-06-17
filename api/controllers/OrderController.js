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
		if ((param('btc_qty') * param('prefered_amount')) < req.session.naira_available) {
			sendMail.sendErrMsg('Attempted hacking', req.session.stringify);
			return res.json(200, { status: 'success' });
		}
        
		// lock the required amount required for this order
		var tnx_desc = "BTC purchase";
		NairaAccount.transaction('Debit', 'transfer', tnx_desc, param('prefered_amount'), req.session.userId).then(function(ret) {
			if (ret.status == 'success') {
				var data = {
					owner: req.session.userId,
					btc_amount: param('btc_qty'),
					amount_per_btc: param('prefered_amount'),
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
					Trading.marchOrder(order.id, param('btc_qty'), param('prefered_amount'), req.session.userId);
				});
			} else {
				sendMail.sendErrMsg('Could lock down payment for btc order');
			}
		});
		return res.json(200, { status: 'success' });
    }
};

