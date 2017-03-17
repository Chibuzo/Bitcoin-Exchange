/**
 * Created by Uzo on 3/15/2017.
 */

module.exports = {
    saveNewAddress: function(address, user_id) {
        if (!_.isUndefined(address) && address.length > 20) {
            var data = {
                address: address,
                user_id: user_id,
                status: 'Unused'
            };
            GeneratedAddress.create(data).exec(function(err, addr) {
                if (err) sendMail.sendErrMsg(err, data);
            });
        }
    },

    saveBTCTransaction: function(address, amount, sender, receiver, fee, desc, tnx_id, tnx_hash, notice, success) {
        var data = {
            address: address,
            btc: amount,
            sender: sender,
            receiver: receiver,
            description: desc,
            fee: fee,
            tnx_id: tnx_id,
            tnx_hash: tnx_hash,
            notice: notice,
            success: success
        };
        BitcoinTransaction.create(data).exec(function(err, tnx) {
            if (err) {
                sendMail.sendErrMsg(err, data);
            }
        });
    }
};