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

        phone: {
            type: 'string',
            unique: 'true'
        },

        password: {
            type: 'string'
        },
        
        mnemonic: {
            type: 'string'
        },

        admin: {
            type: 'boolean'
        },

        level: {
            model: 'userlevel'
        },
        
        pending_update: {
            type: 'string',
            defaultsTo: 'N'
        },

        // add reference to beneficiaries
        beneficiaries: {
            collection: 'beneficiary',
            via: 'user_id'
        },

        // add reference to transactions
        transactions: {
            collection: 'nairatransaction',
            via: 'user'
        },

        bitcointransactions: {
            collection: 'bitcointransaction',
            via: 'sender'
        },

        orders: {
            collection: 'order',
            via: 'owner'
        },

        offers: {
            collection: 'offer',
            via: 'owner'
        },

        status: {
            type: 'string',     // Inactive, Active, Deleted, Banned
            defaultsTo: 'Inactive'
        }
    }
};

