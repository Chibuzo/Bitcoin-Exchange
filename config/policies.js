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

  WalletController: {
      create: ['isLoggedIn']
  },

  //UserController: {
  //    /*signup: ['isLoggedOut'],
  //    signin: ['isLoggedOut']*/
  //},

  AccountController: {
      '*': 'isLoggedIn'
  },

  BeneficiaryController: {
      '*': 'isLoggedIn'
  },

  AdminController: {
      '*': 'isAdmin'
  },

  /***************************************************************************
  *                                                                          *
  * Here's an example of mapping some policies to run before a controller    *
  * and its actions                                                          *
  *                                                                          *
  ***************************************************************************/
	// RabbitController: {

		// Apply the `false` policy as the default for all of RabbitController's actions
		// (`false` prevents all access, which ensures that nothing bad happens to our rabbits)
		// '*': false,

		// For the action `nurture`, apply the 'isRabbitMother' policy
		// (this overrides `false` above)
		// nurture	: 'isRabbitMother',

		// Apply the `isNiceToAnimals` AND `hasRabbitFood` policies
		// before letting any users feed our rabbits
		// feed : ['isNiceToAnimals', 'hasRabbitFood']
	// }
};
