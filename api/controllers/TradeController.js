/**
 * TradeController
 *
 * @description :: Server-side logic for managing Trades
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	index: function(req, res) {
		//Offer.destroy({}).exec(function() {});
		//Order.destroy({}).exec(function() {});
		//NairaTransaction.destroy({}).exec(function() {});
		Offer.find({ owner: req.session.userId, status: 'Open' }).exec(function(err, offers) {
			if (err) return res.badRequest(err);
			//Offer.find().groupBy('amount_per_btc').sum('btc_qty').sort({ amount_per_btc: 'desc'} ).exec(function(err, offer_spread) {
			Offer.find({ groupBy: ['amount_per_btc'], sum: ['btc_qty'], status: 'Open' }).sort({ amount_per_btc: 'desc' }).exec(function(err, offer_spread) {
				if (err) return res.badRequest(err);				
				Order.find({ owner: req.session.userId, status: 'Open' }).exec(function(err, orders) {
					if (err) return res.badRequest(err);
					return res.view('trade/market', { offers: offers, orders: orders, offer_spread: offer_spread });
				});
			});
		});
	}
};

