/**
 * WithdrawalRequestController
 *
 * @description :: Server-side logic for managing Withdrawalrequests
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    newRequest: function(req, res) {
        var data = {
            user: req.session.userId,
            amount: req.param('amount'),
            beneficiary: req.param('beneficiary')            
        };
        WithdrawalRequest.create(data).exec(function(err, request) {
            if (err) return;
            return res.json(200, { status: 'success', req: request });
        });
    },
    
    getPendingRequests: function(req, res) {
        //var criteria = {
        //    status: 'Pending'
        //};
        //if (req.session.admin === undefined) {
        //    criteria.user = req.session.userId;
        //}
        WithdrawalRequest.find({ status: 'Pending' }).populate('user').populate('beneficiary').exec(function(err, cashouts) {
            if (err) return;
            WithdrawalRequest.find({ groupBy: ['status'], sum: ['amount'], status: 'Pending' }).exec(function(err, total_amt) {
                var amt = total_amt[0] ? total_amt[0].amount : 0.00;
                return res.view('admin/withdrawals', { requests: cashouts, total: amt }); 
            });
        });
    },
    
    getCompletedRequests: function(req, res) {
        WithdrawalRequest.find({ status: 'completed' }).populate('user').populate('beneficiary').exec(function(err, cashouts) {
            if (err) return;
            WithdrawalRequest.find({ groupBy: ['status'], sum: ['amount'], status: 'completed' }).exec(function(err, total_amt) {
                var amt = total_amt[0] ? total_amt[0].amount : 0.00;
                return res.view('admin/cashouts', { requests: cashouts, total: amt }); 
            });
        });
    },
    
    completeWithdrawal: function(req, res) {
        WithdrawalRequest.update({ id: req.param('id') }, { status: 'completed' }).populate('user').exec(function(err, request) {
            if (err) return;
            NairaAccount.transaction('Debit', 'transfer', 'Payout', request.amount, request.user.id, request.user.fullname, 'Confirmed', 'cashout').then(function(resp) {
                if (resp.status == 'success')
                    return res.json(200, { status: 'success' });
            });
        });
    },
    
    
    cancelRequest: function(req, res) {
        WithdrawalRequest.update({ id: req.param('id') }, { status: 'Cancelled' }).exec(function() {});
        return res.json(200);
    }
};

