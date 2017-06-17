/**
 * NariaTransactionController
 *
 * @description :: Server-side logic for managing Nariatransactions
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    fundNairaAccount: function (req, res) {
        var data = {
            'amount': req.param('amount'),
            'tnx_type': req.param('tnx_type'),
            'payment_opt': req.param('payment_opt'),
            'account_name': req.param('account_name'),
            'account_number': req.param('account_number'),
            'bank': req.param('bank'),
            'user_id': req.session.userId,
            'description': req.param('desc'),
            'status': 'Pending'
        };

        NairaTransaction.create(data).exec(function(err) {
            if (err) {
                return res.json(200, { status: 'Error', msg: 'Transaction failed', reason: err });
            }
            return res.json(200, { status: 'success' });
        });
    },
    
    confirmFunding: function(req, res) {
        NairaTransaction.update({ id: req.param('id') }, { status: 'confirmed' }).exec(function(err) {
            if (err) {
                return res.json(200, { status: 'Error' });
            }
            return res.json(200, { status: 'success' });  
        });
    }
};

