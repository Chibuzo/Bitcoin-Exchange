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
    }
};

