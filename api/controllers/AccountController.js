/**
 * AccountController
 *
 * @description :: Server-side logic for managing Accounts
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    getTransactions: function(req, res) {
        NairaTransaction.find({ user_id: req.session.userId}).sort({ createdAt: 'desc' }).exec(function(err, tnx) {
            return res.view('account/transactions', { tranx: tnx });
        });
    },

    getAccounts: function(req, res) {
        WithdrawalRequest.findOne({ user: req.session.userId, status: 'Pending' }).populate('beneficiary').exec(function(err, reqs) {
            if (err) {}
            return res.view('account/index', { request: reqs });
        });
    }
};

