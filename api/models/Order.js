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

        amount_per_btc: {
            type: 'float'
        },
        
        btc_address: {
            type: 'string'
        },

        fees: {
            type: 'float'
        },
        
        transaction: {
            model: 'nairatransaction'
        },

        status: {
            type: 'string',
        }
    }
};

