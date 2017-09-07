/**
 * TradeController
 *
 * @description :: Server-side logic for managing Trades
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
var converter = require('parallelfx');

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
				Order.find({ groupBy: ['amount_per_btc'], sum: ['btc_amount'], status: 'Open' }).sort({ amount_per_btc: 'desc' }).exec(function(err, order_spread) {
					if (err) return console.log(err);
					Order.find({ owner: req.session.userId, status: 'Open' }).exec(function(err, orders) {
						if (err) return res.badRequest(err);
						Order.find({ status: 'Closed' }).sort({ 'updatedAt': 'desc' }).exec(function(err, trades) {
							if (err) return console.log(err);
							converter.getParallelRate({ from: 'USD', to: 'NGN' }).then(function(resp) {
								var HTTP = require('machinepack-http');
								HTTP.get({
									url: '/market-price',
									baseUrl: 'api.blockchain.info/charts',
									data: { timespan: '4weeks', rollingAverage: '8hours', format: 'json' }
								}).exec({
									error: function(err) {
										console.log(err);
									},
									requestFailed: function (err) {
										console.log(err);
									},
									success: function(data) {
										//console.log(data);
										return res.view('trade/market', { offers: offers, orders: orders, offer_spread: offer_spread, order_spread: order_spread, trades: trades, market_price: data, xrate: resp.rate });
									}
								});
							});
						});
					});
				});
			});
		});
	}
};

