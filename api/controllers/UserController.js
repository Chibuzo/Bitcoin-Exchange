/**
 * UserController
 *
 * @description :: Server-side logic for managing users
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
var Emailaddresses = require('machinepack-emailaddresses');
var Passwords = require('machinepack-passwords');
//const formatCurrency = require('format-currency');

module.exports = {  
    signup: function(req, res) {
        if (_.isUndefined(req.param('email'))) {
            return res.badRequest('An email address is required!');
        }
    
        if (_.isUndefined(req.param('password')) || req.param('password').length < 6) {
            return res.badRequest('A password is required, and must be aleast 6 characters');
        }
        
        // validate email and password
        Emailaddresses.validate({
            string: req.param('email')
        }).exec({ 
            error: function(err) {
                return res.serverError(err);
            },
            invalid: function() {
                return res.badRequest('Doesn\'t look like an email address to me!');
            },
            success: function() {
                Passwords.encryptPassword({
                    password: req.param('password'),
                }).exec({
                    error: function(err) {
                        return res.serverError(err);
                    },        
                    success: function(encryptedPassword) {
                        // collect ALL signup data                        
                        var data = {
                            fullname: req.param('fullname'),
                            email: req.param('email'),
                            password: encryptedPassword,
                            level: 0
                        };
                        
                        User.create(data).exec(function(err, newUser) {
                            if (err) {
                                if (err.invalidAttributes && err.invalidAttributes.email && err.invalidAttributes.email[0] && err.invalidAttributes.email[0].rule === 'unique') {
                                    return res.json(200, { status: '02', msg: 'Email address is already taken, please try another one.' });
                                }
                                return res.json(501, { status: '00', msg: err }); // couldn't be completed
                            }
                            sendMail.sendConfirmationEmail(newUser);
                            return res.json(200, { status: '01' });
                        });
                    }
                });
            }
        });
    },


    activateAccount: function(req, res) {
        var email = new Buffer(req.param('email'), 'base64').toString('ascii');
        console.log(email);
        var hash = req.param('hash');
        User.findOne({ email : email }).exec(function(err, user) {
            if (err) return;
            if (user) {
                var crypto = require('crypto');
                var confirm_hash = crypto.createHash('md5').update(email + 'okirikwenEE129Okpkenakai').digest('hex');
                if (hash == confirm_hash) {
                    console.log('Aye');
                    // create bitcoin wallet
                    Wallet.createWallet(email, user.password).then(function(wallet) {
                        User.update({ id: user.id }, { status: 'Active', mnemonic: wallet.mnemonic }).exec(function(err) {
                            if (err) {
                                console.log(err);
                            }
                            return res.view('user/signin', { msg: 'Your email has been confirmed' });
                        });
                    });
                }
            }
        });
    },
    
    
    signin: function(req, res) {
        User.findOne({ email: req.param('email') }).exec(function(err, foundUser) {
            if (err) return res.json(200, { status: 'Err', msg: err });
            if (!foundUser) return res.json(200, { status: 'Err', msg : 'User not found' });
            Passwords.checkPassword({ passwordAttempt: req.param('password'), encryptedPassword: foundUser.password }).exec({
                error: function (err) {
                  return res.json(200, { status: 'Err', msg: err });
                },
                incorrect: function () {
                  return res.json(200, { status: 'Err', msg : 'User not found' });
                },
                success: function () {
                    if (foundUser.status == 'Active') {
                        // fetch Naira account balance
                        NairaAccount.getBalance(foundUser.id).then(function(balance) {
                            // fetch BTC account balances
                            var passhrase = foundUser.email + "." + foundUser.id;
                            Wallet.getBalance(foundUser.mnemonic, foundUser.password, foundUser.password).then(function(btc_balance) {
                                req.session.coinAvailableBalance = btc_balance.available / 100000000;     // converting Satoshi to BTC
                                req.session.coinTotalAmount = btc_balance.totalAmount / 100000000;
                                req.session.save();
                            })
                            .catch(function(err) {
                                console.log(err);
                            });
                            req.session.naira_balance = balance.total;
                            req.session.naira_available = balance.available;
                            req.session.save();
                        }).catch(function(err) {
                            console.log(err);
                        });
                        req.session.userId = foundUser.id;
                        req.session.fname = foundUser.fullname;
                        req.session.admin = foundUser.admin;
                        var user_type = foundUser.admin ? 'admin' : 'user';
                        return res.json(200, { status: 'Ok', user_type: user_type });
                    } else if (foundUser.status == 'Inactive') {
                        return res.json(200, { status: 'Err', msg: "Your account is not yet Activated."});
                    } else if (foundUser.status == 'Deleted') {
                        return res.json(200, { status: 'Err', msg: "Your account has been deleted." });
                    } else if (foundUser.status == 'Banned') {
                        return res.json(200, { status: 'Err', msg: "Your account has been banned, most likely for violation of the Terms of Service. Please contact us."});
                    }
                }
            });
        });
    },
    
    dashboard: function(req, res) {
        if (!req.session.userId) {
            return res.view ('user/signin');
        }
        
        User.findOne(req.session.userId, function(err, user) {
            if (err) {
                return res.negotiate(err);
            }

            return res.view('user/dashboard', {
                me: {
                    id: user.id,
                    fname: user.fullname,
                    email: user.email,
                    btc_balance: req.session.coinBalance
                }
            });
        });
    },
    
    signout: function (req, res) {
        if (!req.session.userId) return res.redirect('/');
        User.findOne(req.session.userId, function foundUser(err, createdUser) {
            if (err) return res.negotiate(err);
        
            if (!createdUser) {
                sails.log.verbose('Session refers to a user who no longer exists.');
                return res.redirect('/');
            }
            req.session.userId = null;
            return res.redirect('/');
        });
    },

    settings: function(req, res) {
        User.findOne(req.session.userId, function foundUser(err, user) {
            if (err) return res.negotiate(err);
            return res.view('user/settings', { user: user });
        });
    }
};

