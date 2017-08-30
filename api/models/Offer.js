/**
 * Offer.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

    attributes: {
        owner: {
            model: 'user'
        },

        btc_qty: {
            type: 'float'
        },

        amount_per_btc: {   // in naira
            type: 'float'
        },

        token: {
            type: 'string'
        },

        fees: {
            type: 'float'
        },

        status: {
            type: 'string',
        }
    }
};

