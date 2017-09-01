/**
 * Created by Uzo on 3/19/2017.
 */

//const formatCurrency = require('format-currency');
var Promise = require('promise');

module.exports = {
    getBalance: function (userId) {
        return new Promise(function(resolve, reject) {
            NairaTransaction.find({ user_id: userId, tnx_type: 'Credit' }).exec(function (err, credit_tnx) {
                if (err) {
                    console.log(err);
                    return reject(err);
                }
                NairaTransaction.find({ user_id: userId, tnx_type: 'Debit' }).exec(function (err, debit_tnx) {
                    if (err) {
                        console.log(err);
                        return reject(err);
                    }
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
                        //if (tnx.status == 'confirmed') debit doesn't need to be confirmed
                        total_debit += +tnx.amount || 0;
                    });
                    var balance = {
                        total: total_credit_balance === 0 ? 0 : total_credit_balance - total_debit_balance,
                        available: total_credit === 0 ? 0 : total_credit - total_debit
                    };
                    return resolve(balance);
                });
            });
        });
    },
    
    transaction: function(t_type, payment_opt, desc, amount, user_id, payee_name, status, type) {
        return new Promise(function(resolve, reject) {
            status = status === undefined ? 'Confirmed' : status;
            type = type === undefined ? 'virtual' : type;
            var data = {
                tnx_type: t_type,
                payment_opt: payment_opt,
                description: desc,
                amount: amount,
                user: user_id,
                payee_name: payee_name,
                status: status,
                type: type
            };
            NairaTransaction.create(data).exec(function(err, tnx) {
                if (err) {
                    console.log(err);
                    return reject(err);
                }
                var obj = { status: 'success', tnx_id: tnx.id };
                return resolve(obj);
            });
        });
    },
    
    adminAccountBalance: function() {
        return new Promise(function(resolve, reject) {
            NairaTransaction.find({ type: 'çashin' }).exec(function (err, credit_tnx) {
                if (err) {
                    console.log(err);
                    return reject(err);
                }
                NairaTransaction.find({ type: 'cashout' }).exec(function (err, debit_tnx) {
                    if (err) {
                        console.log(err);
                        return reject(err);
                    }
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
                        //if (tnx.status == 'confirmed') debit doesn't need to be confirmed
                        total_debit += +tnx.amount || 0;
                    });
                    var balance = {
                        total: total_credit_balance === 0 ? 0 : total_credit_balance - total_debit_balance,
                        available: total_credit === 0 ? 0 : total_credit - total_debit
                    };
                    return resolve(balance);
                });
            });
        });
    }
}
