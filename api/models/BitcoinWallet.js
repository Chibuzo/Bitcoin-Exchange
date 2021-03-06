/**
 * BitcoinWallet.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

    attributes: {
        guid: {
            type: 'string',
            unique: 'true'
        },

        user_id: {
            model: 'user'
        },

        address: {
            type: 'string',
            unique: 'true'
        },

        label: {
            type: 'string'
        },

        deleted: {
            type: 'boolean'
        }
    }

};

