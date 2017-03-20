/**
 * NariaTransaction.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

    attributes: {
        tnx_type: {
            type: 'string'  // debit/credit
        },

        payment_opt: {
            type: 'string'  // Deposit/transfer
        },

        description: {
            type: 'string'
        },

        account_id: {
            type: 'integer'
        },

        amount: {
            type: 'float'
        },

        tnx_ref: {
            type: 'string'
        },

        user_id: {
            model: 'user'
        },

        bank: {
            type: 'string'
        },

        account_name: {
            type: 'string'
        },

        account_number: {
            type: 'string'
        },

        payee_name: {
            type: 'string'
        },

        status: {
            type: 'string'  // pending/ confirmed
        },

        deleted: {
            type: 'boolean'
        }
    }
};

