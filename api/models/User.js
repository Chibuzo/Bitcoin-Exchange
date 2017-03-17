/**
 * User.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

    attributes: {
        fullname: {
            type: 'string'
        },

        email: {
            type: 'string',
            email: 'true',
            unique: 'true'
        },

        guid: {
            type: 'string',
            unique: 'true'
        },

        password: {
            type: 'string'
        },

        deleted: {
            type: 'boolean'
        },

        admin: {
            type: 'boolean'
        },

        level: {
            type: 'integer'
        },

        // add reference to beneficiaries
        beneficiaries: {
            collection: 'beneficiary',
            via: 'user_id'
        },

        // add reference to transactions
        transactions: {
            collection: 'nairatransaction',
            via: 'user_id'
        },

        bitcointransactions: {
            collection: 'bitcointransaction',
            via: 'sender'
        },

        banned: {
            type: 'boolean'
        }
    }
};

