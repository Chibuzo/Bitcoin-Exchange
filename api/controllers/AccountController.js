/**
 * AccountController
 *
 * @description :: Server-side logic for managing Accounts
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
const formatCurrency = require('format-currency');

module.exports = {
	getAccounts: function (req, res) {
        NairaTransaction.find({ user_id: req.session.userId, tnx_type: 'Credit' }).exec(function(err, credit_tnx) {
            NairaTransaction.find({ user_id: req.session.userId, tnx_type: 'Debit' }).exec(function(err, debit_tnx) {
                var total_credit = 0;
                var total_debit = 0;
                credit_tnx.forEach (function(tnx) {
                    //if (tnx.status == 'confirmed')
                        total_credit += +tnx.amount || 0;
                });

                debit_tnx.forEach(function(tnx) {
                    if (tnx.status == 'confirmed')
                        total_debit += +tnx.amount || 0;
                });
                var naira_account_balance = formatCurrency(total_credit - total_debit);
                return res.view('account/index', { naira_balance: naira_account_balance });
            });
        });
    },

    getTransactions: function(req, res) {
        NairaTransaction.find({ user_id: req.session.userId}).exec(function(err, tnx) {
            return res.view('account/transactions', { tranx: tnx });
        });
    }
};

