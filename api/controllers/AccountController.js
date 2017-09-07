/**
 * AccountController
 *
 * @description :: Server-side logic for managing Accounts
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    getTransactions: function(req, res) {
        NairaTransaction.find({ user: req.session.userId}).sort({ createdAt: 'desc' }).exec(function(err, tnx) {
            return res.view('account/transactions', { tranx: tnx });
        });
    },

    getAccounts: function(req, res) {
        User.findOne({ id: req.session.userId }).exec(function(err, user) {
            // fetch Naira account balance
            NairaAccount.getBalance(user.id).then(function (balance) {
                // fetch BTC account balances
                var passphrase = user.email + "." + user.id;
                Wallet.getBalance(user.mnemonic, req.session.hash, passphrase).then(function (btc_bal) {
                    var btc_balance = {};
                    req.session.coinAvailableBalance = btc_balance.available_bal = btc_bal.available / 100000000;     // converting Satoshi to BTC
                    req.session.coinTotalAmount = btc_balance.total_bal = btc_bal.totalAmount / 100000000;

                    WithdrawalRequest.findOne({
                        user: req.session.userId,
                        status: 'Pending'
                    }).populate('beneficiary').exec(function (err, reqs) {
                        if (err) {}
                        AdminBankAccount.find().exec(function (err, acc) {
                            return res.view('account/index', {
                                request: reqs,
                                'btc_balance': btc_balance,
                                'naira_balance': balance,
                                'account_details': acc
                            });
                        });
                    });
                })
                .catch(function (err) {
                    console.log(err);
                });
                req.session.naira_balance = balance.total;
                req.session.naira_available = balance.available;
                req.session.save();
            }).catch(function (err) {
                console.log(err);
            });
        });
    }
};