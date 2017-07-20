/**
 * UserLevel.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

  attributes: {
        level: {
            type: 'integer',
            unique: true
        },
        
        phone_verified: {
            type: 'boolean',
            defaultsTo: false
        },
        
        id_verified: {
            type: 'boolean',
            defaultsTo: false
        },
        
        address_verified: {
            type: 'boolean',
            defaultsTo: false
        },
        
        naira_access: {
            type: 'float',
            unique: true
        }
  }
};

