/**
 * Policy Mappings
 * (sails.config.policies)
 *
 */


module.exports.policies = {

  /***************************************************************************
  *                                                                          *
  * Default policy for all controllers and actions (`true` allows public     *
  * access)                                                                  *
  *                                                                          *
  ***************************************************************************/

  // '*': true,

  BitcoinWalletController: {
      create: ['isLoggedIn']
  },
  
  BitcoinTransactionController: {
		'*': 'isLoggedIn'
  },

  UserController: {
      /*signup: ['isLoggedOut'],
      signin: ['isLoggedOut']*/
	  settings: ['isLoggedIn']
  },
  
  UserLevelController: {
		//'*': 'isLoggedIn'
  },

  AccountController: {
      '*': 'isLoggedIn'
  },
  
  NairaTransactionController: {
		//'*': 'isLoggedIn'
  },

  BeneficiaryController: {
      '*': 'isLoggedIn'
  },
  
  OfferController: {
      //'*': 'isLoggedIn'
  },
  
  OrderController: {
      '*': 'isLoggedIn'
  },

  AdminController: {
      '*': 'isAdmin'
  },
  
  AdminBankAccountController: {
		'*': 'isAdmin'
  }
};
