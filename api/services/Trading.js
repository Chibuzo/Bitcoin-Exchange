var Big = require('big.js');

module.exports = {
	marchOrder: function(order_id, btc_qty, amount, buyer_id) {
		return new Promise(function(resolve, reject) {
			// check if existing offers (at the order price/amount) can fullfil the this order bid
			Offer.find({ amount_per_btc: amount, status: 'Open' }).groupBy('amount_per_btc').sum('btc_qty').sort({ createdAt: 'desc' }).exec(function(err, offer) {
				if (err) {
					console.log(err);
					return reject('Error');
				}
				if (offer.length < 1) {
					console.log('No offer');
					return;
				}
				if (offer[0].btc_qty >= btc_qty) {
					module.exports.tradeByOrder(order_id, amount, btc_qty, buyer_id);
					return resolve('Done');
				} else {
					// instant buy
					//console.log("Found no match");
				}
			});
		});
	},
	
	tradeByOrder: function(order_id, amt, btc, buyer_id) {
		Offer.find({ amount_per_btc: amt, status: 'Open' }).populate('owner').sort({ createdAt: 'desc' }).exec(function(err, offers) {
			var btc_sum = new Big(0);
			var rem_btc = new Big(btc); // remaining btc to be purchased
			
			User.findOne({ id: buyer_id }).exec(function(err, buyer) {
				if (err) {
					sendMail.sendErrMsg('Database query error', err);
					return false;
				}
				Wallet.generateAddress(buyer.mnemonic, buyer.password).then(function(addr) {
					try {
						if (err) { throw new Error(err); }
						async.eachSeries(offers, function(offer, cb) {
							if ((btc_sum.gte(btc)) || rem_btc.lt(0)) {
								return cb('Done finally');
							}
							// transfer coin and money
							var msg = "Purchased from Afiaego market";
							var qty_to_sell = offer.btc_qty > rem_btc ? rem_btc : offer.btc_qty;
							btc_sum = btc_sum.plus(qty_to_sell);
							rem_btc = rem_btc.minus(qty_to_sell);
							Wallet.sendBTC(offer.owner.mnemonic, offer.owner.password, addr, qty_to_sell, msg).then(function(resp) {
								// send notification
								console.log('Before Savng: ' + qty_to_sell);
								AddressActions.saveBTCTransaction(addr, qty_to_sell, offer.owner.id, buyer_id, resp.fee, msg, resp.txid, 'Successful');
								if (resp.status == 'success') {
									// debit buyer
									var tnx_desc = "Bitcoin purchase";
									var amount = amt * qty_to_sell;
									
									NairaAccount.transaction('Credit', 'transfer', tnx_desc, amount, offer.owner.id);
									var sold_from = new Big(offer.btc_qty);
									module.exports.adjustOffer(offer.id, sold_from.minus(qty_to_sell));
									return cb();
								} else {
									console.log("Error sending coin");
								}
							}).catch(function(err) {
								console.log(err);
								SendMail.sendErrMsg("Error Selling bitcoin", err);
							});
						}, function(err) {
							if (err) {
								console.log('Async error ' + err);
							}
							console.log('Async finally done now');
							module.exports.closeOrder(order_id);
							// push notification
						});
					}
					catch (e) {
						console.log(e);
					}
				});
			}); // buyer found
		}); //find offers
	},
	
	
	tradeByOffer: function(offer_id, btc_to_sell, amount) {
		// find open orders at same amount
		Order.find({ amount_per_btc: amount, status: 'Open' }).populate('owner').sort({ btc_amount: 'desc' }).exec(function(err, orders) {
			if (err) {
				console.log(err);
				return;
			}
			var available_btc = new Big(btc_to_sell);
			Offer.findOne({ id: offer_id }).populate('owner').exec(function(err, offer) {
				if (err) {
					console.log(err);
					return;
				}
				async.eachSeries(orders, function(order, cb) {
					if (available_btc.gte(order.btc_amount)) {
						Wallet.generateAddress(order.owner.mnemonic, order.owner.password).then(function(addr) {
							var msg = "Sold at Afiaego market";
							Wallet.sendBTC(offer.owner.mnemonic, offer.owner.password, addr, order.btc_amount, msg).then(function(resp) {
								// send notification
								available_btc = available_btc.minus(order.btc_amount);
								AddressActions.saveBTCTransaction(addr, order.btc_amount, offer.owner.id, order.owner.id, resp.fee, msg, resp.txid, 'Successful');
								if (resp.status == 'success') {
									// debit buyer
									var tnx_desc = "Bitcoin purchase";
									var amt = amount * order.btc_amount;
									
									// credit seller and clean up
									NairaAccount.transaction('Credit', 'transfer', tnx_desc, amt, offer.owner.id);
									var sold_from = new Big(btc_to_sell);
									module.exports.adjustOffer(offer_id, sold_from.minus(order.btc_amount));
									module.exports.closeOrder(order.id);
									return cb();
								}
							}).catch(function(err) {
								console.log(err);
							});
						});
					} else {
						return cb();
					}
				}, function(err) {
					if (err) {
						console.log('Async error' . err);
					}
					// push notification
				});
			});
		});
	},
	
	adjustOffer: function(offer_id, rem_btc) {
		if (rem_btc > 0) {
			Offer.update({ id: offer_id }, { btc_qty: rem_btc }).exec(function() {});
		} else {
			Offer.update({ id: offer_id }, { status: 'Closed' }).exec(function() {});
		}
	},
	
	closeOrder: function(order_id) {
		Order.update({ id: order_id }, { status: 'Closed' }).exec(function() {});
	},
	
	cleanUp: function() {
		console.log('Trying callback');
	}
}