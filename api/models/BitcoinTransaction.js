/**
 * BitcoinTransaction.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

    attributes: {
        address: {
            type: 'string'
        },

        sender: {
            model: 'user'
        },

        receiver: {
            model: 'user'
        },

        btc: {
            type: 'string'
        },

        description: {
            type: 'text'
        },

        fee: {
            type: 'string'
        },

        tnx_id: {
            type: 'string'
        },

        tnx_hash: {
            type: 'string'
        },

        notice: {
            type: 'string'
        },

        success: {
            type: 'boolean'
        },
    }
};

