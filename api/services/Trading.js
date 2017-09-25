var Big = require('big.js');

module.exports = {
    //marchOrder: function(order_id, btc_qty, amount, addr, buyer_id, ng_tnx_id) {
    //    return new Promise(function(resolve, reject) {
    //        // check if existing offers (at the order price/amount) can fullfil this order bid
    //        Offer.find({
    //            status: 'Open'
    //        }).where({ amount_per_btc: { '<=': amount }}).groupBy('amount_per_btc').sum('btc_qty').sort({ amount_per_btc: 'asc'}).exec(function (err, offer) {
    //            if (err) {
    //                console.log(err);
    //                return reject('Error');
    //            }
    //            if (offer.length < 1) {
    //                return resolve('Broadcast');
    //            }
    //            // let's check whether the available btc at this price can satisfy this order
    //            var available_offer = 0;
    //            offer.forEach(function(offer) {
    //                available_offer += offer.btc_qty;
    //            });
    //            if (available_offer >= btc_qty) {
    //                module.exports.tradeByOrder(order_id, amount, btc_qty, addr, buyer_id, ng_tnx_id);
    //                return resolve('Done');
    //            } else {
    //                // add to pending trade pool
    //                return resolve('Broadcast');
    //            }
    //        });
    //    });
    //},
	
	tradeByOrder: function(order_id, btc, amt, address, buyer_id, ng_tnx_id) {
        return new Promise(function(resolve, reject) {
            // find offers that would fullfil this order
            Offer.find({status: 'Open'}).where({amount_per_btc: {'<=': amt}}).populate('owner').sort({amount_per_btc: 'asc'}).exec(function (err, offers) {
                if (err) {
                    console.log(err);
                    return reject('Error');
                }
                if (offers.length < 1) {
                    return resolve('Broadcast');
                }
                // let's check whether the available btc at this price can satisfy this order
                var available_offer = 0;
                offers.forEach(function(_offer) {
                    available_offer += _offer.btc_qty;
                });
                if (available_offer >= btc) {
                    var btc_sum = new Big(0);
                    var rem_btc = new Big(btc); // remaining btc to be purchased

                    try {
                        async.eachSeries(offers, function (offer, cb) {
                            if ((btc_sum.gte(btc)) || rem_btc.lt(0)) {
                                return cb('Done finally');
                            }
                            // transfer coin and money
                            var msg = "BTC Sales";
                            var qty_to_sell = offer.btc_qty > rem_btc ? rem_btc : offer.btc_qty;
                            var passphrase = offer.owner.email + "." + offer.owner.id;
                            Wallet.sendBTC(offer.owner.mnemonic, offer.token, passphrase, address, qty_to_sell.toString(), msg).then(function (resp) {
                                rem_btc = rem_btc.minus(qty_to_sell);
                                btc_sum = btc_sum.plus(qty_to_sell);

                                //console.log('Before Savng: ' + qty_to_sell);
                                AddressActions.saveBTCTransaction(address, qty_to_sell.toString(), offer.owner.id, buyer_id, resp.fee, msg, resp.txid, 'Successful');
                                if (resp.status == 'success') {
                                    // debit buyer
                                    var tnx_desc = "Bitcoin sales";
                                    var amount = offer.amount_per_btc * qty_to_sell;

                                    // let's see if there's naira profit
                                    if (amt > offer.amount_per_btc) {

                                    }
                                    // credit seller
                                    NairaAccount.transaction('Credit', 'transfer', tnx_desc, amount, offer.owner.id, '');
                                    // confirm order naira debit
                                    NairaAccount.confirmTransaction(ng_tnx_id);
                                    var sold_from = new Big(offer.btc_qty);
                                    module.exports.adjustOffer(offer.id, sold_from.minus(qty_to_sell));
                                    return cb();
                                } else {
                                    console.log("Error sending coin during trading", arguments);
                                    return reject("Error");
                                }
                            }).catch(function (err) {
                                console.log(err);
                                SendMail.sendErrMsg("Error Sending bitcoin", err);
                                return reject("Error");
                            });
                        }, function (err) {
                            if (err) {
                                console.log('Async error ' + err);
                            }
                            //console.log('Async finally done now');
                            module.exports.closeOrder(order_id, btc, amt);
                            return resolve("Fulfilled");
                        });
                    }
                    catch (e) {
                        console.log(e);
                        return reject('Error');
                    }
                } else {
                    // add to pending trade pool
                    return resolve('Broadcast');
                }
            }); //find offers
        });
	},
	
	
	tradeByOffer: function(offer_id, btc_to_sell, amount) {
		return new Promise(function(resolve, reject) {
			// find open orders at same amount
			Order.find({
				status: 'Open'
			}).where({ amount_per_btc: { '>=': amount }}).populate('owner').sort({btc_amount: 'asc'}).exec(function (err, orders) {
				if (err) {
					console.log(err);
					return;
				}
				if (orders.length < 1) {
                    return resolve('Broadcast');
                }
				var available_btc = new Big(btc_to_sell);
				Offer.findOne({id: offer_id}).populate('owner').exec(function (err, offer) {
					if (err) {
						console.log(err);
						return reject(err);
					}
					async.eachSeries(orders, function (order, cb) {
						if (available_btc.gte(order.btc_amount)) {
							var msg = "Sold at CapitalX market";
							var passphrase = offer.owner.email + "." + offer.owner.id;
							Wallet.sendBTC(offer.owner.mnemonic, offer.token, passphrase, order.btc_address, order.btc_amount, msg).then(function (resp) {
								// send notification
								available_btc = available_btc.minus(order.btc_amount);
								AddressActions.saveBTCTransaction(order.btc_address, order.btc_amount, offer.owner.id, order.owner.id, resp.fee, msg, resp.txid, 'Successful');
								if (resp.status == 'success') {
									// debit buyer
									var tnx_desc = "Bitcoin purchase";
									var amt = offer.amount_per_btc * order.btc_amount;

                                    // let's see if there's naira profit
                                    if (order.amount_per_btc > amount) {

                                    }

									// credit seller and clean up
									NairaAccount.transaction('Credit', 'transfer', tnx_desc, amt, offer.owner.id);
                                    // confirm buy transaction
                                    NairaAccount.confirmTransaction(order.transaction);
									var sold_from = new Big(btc_to_sell);
									module.exports.adjustOffer(offer_id, sold_from.minus(order.btc_amount));
									module.exports.closeOrder(order.id, btc_to_sell, amount);
									return cb();
								}
							}).catch(function (err) {
								console.log(err);
							});

						} else {
							return cb();
						}
					}, function (err) {
						if (err) {
							console.log('Async error '.err);
						}
						return resolve('Fulfilled')
					});
				});
			});
		});
	},
	
	adjustOffer: function(offer_id, rem_btc) {
		if (rem_btc.toString() > 0) {
			Offer.update({ id: offer_id }, { btc_qty: rem_btc.toString() }).exec(function() {});
		} else {
			Offer.update({ id: offer_id }, { status: 'Closed', token: '' }).exec(function() {});
		}
	},
	
	closeOrder: function(order_id, btc_qty, amount) {
		Order.update({ id: order_id }, { status: 'Closed' }).exec(function(err, order) {
            // push trade update
            var time = new Date(order[0].updatedAt);
            time = time.getUTCHours() + ":" + time.getUTCMinutes();
            sails.sockets.broadcast('trade', 'completed-trade', { amount_per_btc: amount, btc_qty: btc_qty, trade_time: time });
        });
    },
	
	cleanUp: function() {
		console.log('Trying callback');
	}
}