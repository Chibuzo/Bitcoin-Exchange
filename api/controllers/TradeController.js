/**
 * TradeController
 *
 * @description :: Server-side logic for managing Trades
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	index: function(req, res) {
		Offer.find({ owner: req.session.userId }).exec(function(err, offers) {
			if (err) return res.badRequest(err);
			Order.find({ owner: req.session.userId }).exec(function(err, orders) {
				if (err) return res.badRequest(err);
				return res.view('trade/market', { offers: offers, orders: orders });
			});
		});
	}
};

