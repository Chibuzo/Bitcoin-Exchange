module.exports.routes = {

    '/': {
        view: 'index'
    },

    'GET /user/signin': {
        view: 'user/signin'
    },

    'GET /user/signup': {
        view: 'user/signup'
    },

    //'POST /user/signin': 'UserController.signin',
    
    'GET /user/activate/:email/:hash': 'UserController.activateAccount',

    'GET /user/signout': 'UserController.signout',

    'GET /user/dashboard': 'UserController.dashboard',

    'GET /user/setting': 'UserController.settings',
    
    'POST /userlevel/add-idcard': 'UserLevelController.addIdCard',
    
    'POST /userlevel/add-residence-proof': 'UserLevelController.addResidentialProof',

    'GET /admin/dashboard': 'AdminController.dashboard',

    'GET /admin/users': 'AdminController.getUsers',

    'GET /admin/settings': 'AdminController.settings',

    'POST /admin/add-account': 'AdminController.addBankAccount',

    'GET /admin/naira-transactions': 'AdminController.getNairaTransactions',

    'GET /admin/btc-transactions': 'AdminController.getBTCTransactions',

    'GET /accounts/': 'AccountController.getAccounts',

    'GET /beneficiary/': 'BeneficiaryController.getBeneficiaries',

    'POST /beneficiary/add': 'BeneficiaryController.addBeneficiary',

    'POST /account/fundNairaAccount': 'NairaTransactionController.fundNairaAccount',

    'GET /account/transactions': 'AccountController.getTransactions',

    'GET /wallet/new-address': 'BitcoinWalletController.createNewAddress',

    'POST /wallet/send': 'BitcoinTransactionController.sendBTC',

    'GET /transaction/btc': 'BitcoinTransactionController.getTransactions',
    
    'POST /naira-transaction/approve-funding': 'NairaTransactionController.confirmFunding',

    // Trading routes begins here
    'GET /trade/': 'TradeController.index',
    
    'POST /offer/sell': 'OfferController.makeOffer',
    
    'POST /offer/cancel/:id': 'OfferController.cancelOffer',

    'POST /order/buy': 'OrderController.placeOrder',
    
    'POST /order/cancel/:id': 'OrderController.cancelOrder',

    'GET /wallet/create': 'ClientController.create',
    
    'GET /sendMail/': 'MailTestController.sendMail',
    
    'GET /team': { view: 'team'}

};
