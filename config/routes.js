/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes map URLs to views and controllers.
 *
 * For more information on configuring custom routes, check out:
 * http://sailsjs.org/#!/documentation/concepts/Routes/RouteTargetSyntax.html
 */

module.exports.routes = {

  '/': {
    view: 'homepage'
  },

  /***************************************************************************
  *                                                                          *
  * Custom routes here...                                                    *
  *                                                                          *
  * If a request to a URL doesn't match any of the custom routes above, it   *
  * is matched against Sails route blueprints. See `config/blueprints.js`    *
  * for configuration options and examples.                                  *
  *                                                                          *
  ***************************************************************************/

  'GET /user/signin': {
    view: 'user/signin'
  },
  
  'GET /user/signup': {
      view: 'user/signup'
  },
  
  'PUT /user/signin': 'UserController.signin',
  
  'GET /user/signout': 'UserController.signout',
  
  'GET /user/dashboard': 'UserController.dashboard',

  'GET /wallet/create': 'BitcoinWalletController.createWallet',

  'GET /trade/': {
      view: 'trade/market'
  }

};
