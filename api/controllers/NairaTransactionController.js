/**
 * NariaTransactionController
 *
 * @description :: Server-side logic for managing Nariatransactions
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    fundNairaAccount: function (req, res) {
        NairaAccount.transaction(req.param('tnx_type'), req.param('payment_opt'), req.param('desc'), req.param('amount'), req.session.userId, 'CapitalX', 'Pending', 'cashin', req.param('bank'), req.param('account_name'), req.param('account_number')).then(function(resp) {
            if (resp.status == 'success') {
                return res.json(200, { status: 'success' });
            }
        })
        .catch(function(err) {
            return res.json(200, { status: 'error', msg: 'Transaction failed', reason: err });
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

