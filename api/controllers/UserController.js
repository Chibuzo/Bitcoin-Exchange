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
    
        if (_.isUndefined(req.param('password')) && req.param('password').length < 6) {
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
                    success: function(result) {
                        // collect ALL signup data
                        var data = {
                            fullname: req.param('fullname'),
                            email: req.param('email'),
                            password: result
                        };
                        
                        User.create(data).exec(function(err) {
                          if (err) {
                              if (err.invalidAttributes && err.invalidAttributes.email && err.invalidAttributes.email[0] && err.invalidAttributes.email[0].rule === 'unique') {
                                  return res.json(200, { status: '02', msg: 'Email address is already taken, please try another one.' });
                              }
                              return res.json(501, { status: '00', msg: err }); // couldn't be completed
                          }
                          return res.json(200, { status: '01' });
                        });
                    }
                });
            }
        });
    },
    
    signin: function(req, res) {
        User.findOne({
          email: req.param('email')
        }).exec(function foundUser(err, createdUser) {
            if (err) return res.json(200, { status: 'Err', msg: err });
            if (!createdUser) return res.json(200, { status: 'Err', msg : 'User not found' });
      
            Passwords.checkPassword({
                passwordAttempt: req.param('password'),
                encryptedPassword: createdUser.password
            }).exec({
                error: function (err) {
                  return res.json(200, { status: 'Err', msg: err });
                },
                incorrect: function () {
                  return res.json(200, { status: 'Err', msg : 'User not found' });
                },
                success: function () {
                    if (createdUser.deleted) {
                        return res.json(200, { status: 'Err', msg: "'Your account has been deleted. Please visit http://cpbit.com/restore to restore your account.'" });
                    }
            
                    if (createdUser.banned) {
                        return res.json(200, { status: 'Err', msg: "'Your account has been banned, most likely for violation of the Terms of Service. Please contact us.'"});
                    }
                    req.session.userId = createdUser.id;
                    return res.json(200, { status: 'Ok' });
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
                    email: user.email
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
};

