/**
 * Created by Uzo on 3/15/2017.
 */

module.exports = {
    sendEmail: function(template, data, opts, cb) {
        sails.hooks.email.send(template, data, opts, cb);
    },
    
    sendConfirmationEmail: function(user) {
        var email_b64 = new Buffer(user.email).toString('base64');
        var crypto = require('crypto');
        var hash = crypto.createHash('md5').update(user.email + 'okirikwenEE129Okpkenakai').digest('hex');
        
        var data = {
            user: user.fullname,
            email: email_b64,
            hash: hash
        };
        var opts = {
            from: "Afiaego <no-reply@afiaego.com>",
            sender: "no-reply@afiaego.com",
            to: user.email,
            subject: "Afiaego Account Confirmation"
        };
        module.exports.sendEmail('activationEmail', data, opts, function(err) {
            if (err) console.log(err);
        });
    },
    
    sendErrMsg: function(err, data) {

    },
    
   
}
