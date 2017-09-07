/**
 * OfferController
 *
 * @description :: Server-side logic for managing Offers
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
var validator = require('validator');

module.exports = {
	makeOffer: function(req, res) {
        var param = req.param;
        if (_.isUndefined(param('btc_qty')) || !validator.isDecimal(param('btc_qty'))) {
            return res.json(200, { status: 'error', msg: 'Bitcoin quantity must be in numbers' });
        }
		// let's check if this offer is eligible
		if (param('btc_qty') > req.session.coinAvailableBalance) {
			sendMail.sendErrMsg('Attempted hacking', req.session.stringify);
			console.log('Her ' + req.session.coinAvailableBalance);
			return res.json(200, { status: 'success' });
		}
        if (_.isUndefined(param('prefered_amount')) || !validator.isDecimal(param('prefered_amount'))) {
            return res.json(200, { status: 'error', msg: 'Naira amount must be in number' });
        }
        var data = {
            owner: req.session.userId,
            btc_qty: param('btc_qty'),
            amount_per_btc: param('prefered_amount'),
            token: req.session.hash,
            fees: sails.fees.sell_btc,
			status: 'Open'
        };
        Offer.create(data).exec(function(err, offer) {
            if (err) {
                sendMail.sendErrMsg(err, data);
				console.log(err);
                return res.json(200, { status: 'error', msg: err });
            }
			// try and match this offer
			Trading.tradeByOffer(offer.id, param('btc_qty'), param('prefered_amount')); /*.then(function(resp) {
				console.log(resp);
			}).catch(function(err) {
				console.log(err);
			});*/
            return res.json(200, { status: 'success', offer_id: offer.id });
        });
    },
	
	cancelOffer: function(req, res) {
		var id = req.param('id');
		Offer.destroy({ id: id, status: 'Open' }).exec(function(err) {
			if (err) return;
			return res.json(200, { status: 'success' });
		});
	}
};

