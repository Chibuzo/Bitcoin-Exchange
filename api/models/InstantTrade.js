/**
 * InstantTrade.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

  attributes: {
      user: {
          model: 'user'
      },

      btc: {
          type: 'float'
      },

      used_market_price: {
          type: 'float'
      },

      trade_type: {
          type: 'string'    // buy and sell
      },

      status: {
          type: 'string',
          defaultsTo: 'Completed'
      }
  }
};

