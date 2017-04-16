/**
 * Created by Uzo on 4/10/2017.
 */

module.exports = {
    create: function(req, res) {
        Wallet.createWallet('Afam').then(function(secret) {
            console.log(secret);
        });
    }
}
