/**
 * BeneficiaryController
 *
 * @description :: Server-side logic for managing Beneficiaries
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	getBeneficiaries: function(req, res) {
        Beneficiary.find({user_id: req.session.userId}).exec(function(err, beneficiaries) {
            return res.view('beneficiary/index', { beneficiaries: beneficiaries });
        });
    },

    addBeneficiary: function(req, res) {
        var data = {
            bank: req.param('bank'),
            account_name: req.param('account_name'),
            account_number: req.param('account_number'),
            user_id: req.session.userId
        };

        Beneficiary.create(data).exec(function(err, account) {
            if (err) {
                if (err.invalidAttributes && err.invalidAttributes.account_number && err.invalidAttributes.account_number[0] && err.invalidAttributes.account_number[0].rule === 'unique') {
                    return res.json(200, { status: '02', msg: 'This account number is already in use!' });
                }
                return res.json(501, { status: '00', msg: err }); // couldn't be completed
            }
            return res.json(200, { status: '01', id: account.id, bank: account.bank, account_name: account.account_name, account_number: account.account_number, createdAt: account.createdAt });
        });
    }
};

