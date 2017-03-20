/**
 * OfferController
 *
 * @description :: Server-side logic for managing Offers
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	offer: function(req, res) {
        var param = req.param;
        if (_.isUndefined(param('btc_qty')) || !_.isNumber(param('btc_qty'))) {
            return res.json(200, { status: 'error', msg: 'Bitcoin quantity must be in numbers' });
        }
        if (_.isUndefined(param('prefered_amount')) || !_.isNumber(param('prefered_amount'))) {
            return res.json(200, { status: 'error', msg: 'Naira amount must be in number' });
        }
        var data = {
            owner: req.session.userId,
            btc_qty: param('btc_qty'),
            amount_per_btc: param('prefered_amount'),
            btc_per_naira: sails.btc_cost,    // current cost of btc per naira
            fees: sails.fees.sell_btc,
        };
        Offer.create(data).exec(function(err, offer) {
            if (err) {
                sendMail.sendErrMsg(err, data);
                return res.json(200, { status: 'error', msg: err });
            }
            return res.json(200, { status: 'success', offer_id: offer.id });
        });
    }
};

