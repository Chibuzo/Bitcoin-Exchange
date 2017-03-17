/**
 * AdminBankAccountController
 *
 * @description :: Server-side logic for managing Adminbankaccounts
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
    getAccounts: function (req, res) {
        AdminBankAccount.find().exec(function(err, account) {
            return res.view('account/index', { account_details: account });
        });
    }
};

