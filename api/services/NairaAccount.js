/**
 * Created by Uzo on 3/19/2017.
 */

const formatCurrency = require('format-currency');

module.exports = {
    getBalance: function (userId) {
        return new Promise(function(resolve, reject) {
            NairaTransaction.find({user_id: userId, tnx_type: 'Credit'}).exec(function (err, credit_tnx) {
                NairaTransaction.find({user_id: userId, tnx_type: 'Debit'}).exec(function (err, debit_tnx) {
                    var total_credit = 0,
                        total_debit = 0,
                        total_credit_balance = 0,
                        total_debit_balance = 0;
                    credit_tnx.forEach (function (tnx) {
                        total_credit_balance += +tnx.amount || 0;
                        if (tnx.status == 'confirmed')
                            total_credit += +tnx.amount || 0;
                    });

                    debit_tnx.forEach(function (tnx) {
                        total_debit_balance = +tnx.amount || 0;
                        if (tnx.status == 'confirmed')
                            total_debit += +tnx.amount || 0;
                    });
                    var balance = {
                        total: formatCurrency(total_credit_balance - total_debit_balance),
                        available: formatCurrency(total_credit - total_debit)
                    };
                    return resolve(balance);
                });
            });
        });
    },
}
