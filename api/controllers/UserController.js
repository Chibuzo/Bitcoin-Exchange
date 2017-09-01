/**
 * UserController
 *
 * @description :: Server-side logic for managing users
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
var Emailaddresses = require('machinepack-emailaddresses');
var Passwords = require('machinepack-passwords');

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
                        const bcrypt = require('bcrypt-nodejs');
                        var salt = bcrypt.genSaltSync();
                        var data = {
                            fullname: req.param('fullname'),
                            email: req.param('email'),
                            password: encryptedPassword,
                            salt: salt,
                            level: 1
                        };
                        
                        req.session.hash = bcrypt.hashSync(req.param('password'), salt);
                        req.session.save();
                        
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
        var hash = req.param('hash');
        User.findOne({ email : email }).exec(function(err, user) {
            if (err) return;
            if (user.status == 'Active') {
                return res.view('user/signin', { msg: 'Your email has already been confirmed. Just go ahead and login' });
            }
            if (user) {
                var crypto = require('crypto');
                var confirm_hash = crypto.createHash('md5').update(email + 'okirikwenEE129Okpkenakai').digest('hex');
                if (hash == confirm_hash) {   
                    // create bitcoin wallet
                    var passhrase = user.email + "." + user.id;
                    Wallet.createWallet(email, req.session.hash, passhrase).then(function(wallet) {
                        User.update({ id: user.id }, { status: 'Active', mnemonic: wallet.encrypted_mnemonic, level: 1 }).exec(function(err) {
                            if (err) {
                                console.log(err);
                            }
                            req.session.hash = null;
                            sendMail.sendWalletBackUpEmail(user.fullname, user.email, wallet.raw_mnemonic);
                            return res.view('user/signin', { msg: 'Your Email address has been confirmed' });
                        });
                    });
                }
            }
        });
    },
    
    
    signin: function(req, res) {
        User.findOne({ email: req.param('email') }).populate('level').exec(function(err, foundUser) {
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
                            const bcrypt = require('bcrypt-nodejs');
                            req.session.hash = bcrypt.hashSync(req.param('password'), foundUser.salt);
                            req.session.save();
                            Wallet.getBalance(foundUser.mnemonic, req.session.hash, passhrase).then(function(btc_balance) {
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
                        req.session.level = foundUser.level.level;
                        req.session.amt_limit = foundUser.level.naira_access;
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
            BitcoinTransaction.find()
            .where({
              or: [
                { sender: req.session.userId },
                { receiver: req.session.userId }
              ]
            }).sort('createdAt DESC').populate('receiver').limit(10).exec(function(err, tnx) {
                if (err) {}
                const converter = require('parallelfx');
                converter.getParallelRate({ from: 'USD', to: 'NGN' }).then(function(resp) {
                    var HTTP = require('machinepack-http');
                    HTTP.get({
                          url: '/market-price',
                          baseUrl: 'api.blockchain.info/charts',
                          data: { timespan: '1week', rollingAverage: '8hours', format: 'json' }
                    }).exec({
                          error: function(err) {
                            console.log(err);
                          },
                          requestFailed: function (err) {
                            console.log(err);
                          },
                          success: function(data) {
                              return res.view('user/dashboard', {
                                  me: {
                                      id: user.id,
                                      fname: user.fullname,
                                      email: user.email,
                                      btc_balance: req.session.coinAvailableBalance
                                  },

                                  market_price: data, trnx: tnx, xrate: resp
                              });
                          }
                    });
                });
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
        User.findOne({ id: req.session.userId }).populate('level').exec(function foundUser(err, user) {
            if (err) return res.negotiate(err);
            return res.view('user/settings', { user: user });
        });
    }
};

