/**
 * UserController
 *
 * @description :: Server-side logic for managing users
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
var Emailaddresses = require('machinepack-emailaddresses');
var Passwords = require('machinepack-passwords');
var wallet = require('blockchain.info/MyWallet');
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
                            // create bitcoin wallet
                            Blockchain.createWallet(req.param('email'), encryptedPassword, newUser.id);

                            return res.json(200, { status: '01' });
                        });
                    }
                });
            }
        });
    },

    activateAccount: function(req, res) {

    },
    
    signin: function(req, res) {
        User.findOne({
          email: req.param('email')
        }).exec(function(err, foundUser) {
            if (err) return res.json(200, { status: 'Err', msg: err });
            if (!foundUser) return res.json(200, { status: 'Err', msg : 'User not found' });
      
            Passwords.checkPassword({
                passwordAttempt: req.param('password'),
                encryptedPassword: foundUser.password
            }).exec({
                error: function (err) {
                  return res.json(200, { status: 'Err', msg: err });
                },
                incorrect: function () {
                  return res.json(200, { status: 'Err', msg : 'User not found' });
                },
                success: function () {
                    if (foundUser.deleted) {
                        return res.json(200, { status: 'Err', msg: "'Your account has been deleted. Please visit http://cpbit.com/restore to restore your account.'" });
                    }
            
                    if (foundUser.banned) {
                        return res.json(200, { status: 'Err', msg: "'Your account has been banned, most likely for violation of the Terms of Service. Please contact us.'"});
                    }

                    // fetch Naira account balance
                    NairaAccount.getBalance(foundUser.id).then(function(balance) {
                        // fetch BTC account balances
                        Blockchain.getBalance(foundUser.guid, foundUser.password).then(function(btc_balance) {
                            req.session.coinBalance = btc_balance.balance / 100000000;     // converting Satoshi to BTC
                            req.session.save();
                        }).catch(function(err) {
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

    }
};

