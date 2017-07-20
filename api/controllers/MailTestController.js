module.exports = {
    sendMail: function() {
        sails.hooks.email.send(
            "activationEmail",
            {
              recipient: "Chibuzo",
              senderName: "Afiaego"
            },
            {
              from: "Afiaego <no-reply@afiaego.com>",
              sender: "no-reply@afiaego.com",
              to: "chibuzo.henry@gmail.com",
              subject: "Afiaego - Activate Your Account"
            },
            function(err) { console.log(err || "It worked!");}
        );
    }
}