/**
 * Order.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

    attributes: {
        owner: {
            model: 'user'
        },

        btc_amount: {
            type: 'float'
        },

        //cost_per_coin: {    // in naira
        //    type: 'float'
        //},
        amount_per_btc: {
            type: 'float'
        },

        fees: {
            type: 'float'
        },
        
        // must be removed!
        payment: {
            model: 'payment'
        },
        
        transaction: {
            model: 'nairatransaction'
        },

        status: {
            type: 'string',
        }
    }
};

