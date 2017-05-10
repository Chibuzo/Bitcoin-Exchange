/**
 * Created by Uzo on 4/10/2017.
 */

module.exports = {
    create: function(req, res) {
        Wallet.createWallet('Afam').then(function(secret) {
            console.log(secret);
        });
    },

    test: function(req, res) {
        var mnemonic1 = bip39.generateMnemonic();
        console.log(mnemonic1);
        console.log('Generating the second...');
        var mnemonic2 = bip39.generateMnemonic();
        console.log(mnemonic2);

        console.log('Mnemonic to seeds...');
        var seeds;
        seeds = bip39.mnemonicToSeed(mnemonic1, 'untold');
        console.log('Seed: ' + seeds);
        seeds = bip39.mnemonicToSeedHex(mnemonic1, 'untold');
        console.log('SeedHex: ' + seeds);
        console.log(bip39.validateMnemonic(mnemonic1));
        return res;
    }
}
