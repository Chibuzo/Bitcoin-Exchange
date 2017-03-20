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
            type: 'string'
        },

        amount_per_btc: {   // in naira
            type: 'string'
        },

        btc_per_naira: {
            type: 'sting'
        },

        fees: {
            type: 'string'
        },

        status: {
            type: 'string',
            default: 'Pending'  // Pending, Completed or Cancelled
        }
    }
};

