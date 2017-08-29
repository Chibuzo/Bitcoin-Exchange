/**
 * UserLevelController
 *
 * @description :: Server-side logic for managing Userlevels
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	addIdCard: function(req, res) {
        var allowedImgTypes = ['image/png', 'image/jpeg'];
        var n = 0;
        req.file('id_card').upload({
            dirname: require('path').resolve(sails.config.appPath, 'assets/idCards/'),
            saveAs: function(file, cb) {
                n++;
                if (allowedImgTypes.indexOf(file.headers['content-type']) === -1) {
                    return res.badRequest('Unsupported photo format.');
                }
                var ext = file.filename.split('.').pop();
                var sub;
                if (n == 1) sub = '_front.';
                else if (n == 2) sub = '_back.';
                filename = 'userID_' + req.session.userId + sub + ext;
                return cb(null, filename);
            }
        },
        function(err) {
            if (err) {
                return res.badRequest(err);
            }
            User.update({ id: req.session.userId }, { pending_update: 'Y' }).exec(function() {});
            var msg = "We have recieved your Identity prove. We will verify and get back to you. This process may take up to 48 hours";
            return res.view('message', { msg: msg, alert_type: 'alert-success' });
        });
    },
    
    addResidentialProof: function(req, res) {
        var allowedImgTypes = ['image/png', 'image/jpeg'];
        req.file('residential_proof').upload({
            dirname: require('path').resolve(sails.config.appPath, 'assets/residential_proofs/'),
            saveAs: function(file, cb) {
                if (allowedImgTypes.indexOf(file.headers['content-type']) === -1) {
                    return res.badRequest('Unsupported photo format.');
                }
                var ext = file.filename.split('.').pop();
                filename = 'proof_' + req.session.userId + '.' + ext;
                return cb(null, filename);
            }
        },
        function(err) {
            if (err) {
                return res.badRequest(err);
            }
            User.update({ id: req.session.userId }, { pending_update: 'Y' }).exec(function() {});
            var msg = "We have recieved your proof of residential address. We will verify and get back to you. This process may take up to 48 hours";
            return res.view('message', { msg: msg, alert_type: 'alert-success' });
        });
    },
    
    verifyPhone: function(req, res) {
        var phone = req.param('phone');
        // validate phone
        if (phone.charAt(0) == '0') {
          phone = '234' + phone.substr(1);
        } else if (phone.length > 13 || phone.length == 14) {
          phone = '234' + phone.substr(4);
        }
        if (phone.length < 13) {
          return res.json(200, { status: 'Error', msg: 'Invalid phone number' });
        }
        req.session.phone = phone;
        // proceed
        req.session.phone_code = Math.floor(100000 + Math.random() * 900000);
        req.session.save();
        var msg = req.session.phone_code + " is your CapitalX verification code";
        var HTTP = require('machinepack-http');
        HTTP.get({
          url: '/tools/geturl/Sms.php',
          baseUrl: 'http://www.multitexter.com',
          data: { username: 'farmhubb@gmail.com', password: '61761cezeilo', sender: 'CapitalX', message: msg, flash: 1, recipients: phone }
        }).exec({
          error: function(err) {
            console.log(err);
          },
          requestFailed: function (err) {
            console.log(err);
          },
          success: function() {
            return res.json(200, { status: 'success' });
          }
        });
    },
    
    verifyPhoneCode: function(req, res) {
        var code = req.param('verification_code');
        if (code == req.session.phone_code) {
            User.update({ id: req.session.userId }, { phone: req.session.phone, level: 2 }).populate('level').exec(function(err, user) {
                req.session.phone_code = req.session.phone = null;
                req.session.level = user.level.level;
                return res.json(200, { status: 'success' });
            });
        }
    }
};

