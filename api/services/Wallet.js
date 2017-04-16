/**
 * Created by Uzo on 4/10/2017.
 */

var Client = require('bitcore-wallet-client');

var BWS_INSTANCE_URL = 'https://bws.bitpay.com/bws/api';

module.exports = {
    createWallet: function (name) {
        return new promise(function(resolve, reject) {
            var client = new Client({
                baseUrl: BWS_INSTANCE_URL,
                verbose: false,
            });

            client.createWallet("Afiaego", "Chibuzo", 2, 2, {network: 'testnet'}, function(err, secret) {
                if (err) {
                    console.log('error: ',err);
                    return
                };
                // Handle err
                console.log('Wallet Created. Share this secret with your copayers: ' + secret);
                //fs.writeFileSync('irene.dat', client.export());

                client.joinWallet(secret, "Okolo", {}, function(err, wallet) {
                    if (err) {
                        console.log('error: ', err);
                        return
                    };

                    console.log('Joined ' + wallet.name + '!');
                    //fs.writeFileSync('tomas.dat', client.export());

                    client.openWallet(function(err, ret) {
                        if (err) {
                            console.log('error: ', err);
                            return
                        };
                        console.log('\n\n** Wallet Info', ret); //TODO

                        console.log('\n\nCreating first address:', ret); //TODO
                        if (ret.wallet.status == 'complete') {
                            client.createAddress({}, function(err,addr){
                                if (err) {
                                    console.log('error: ', err);
                                    return;
                                };

                                console.log('\nReturn:', addr)
                            });
                        }
                    });
                });
                return resolve(secret);
            })
            .catch(function(err) {

            });
        });
    }
}
