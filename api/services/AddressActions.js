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
            GeneratedAddress.create(data).exec(function(err) {
                if (err) sendMail.sendErrMsg(err, data);
            });
        }
    },

    saveBTCTransaction: function(address, amount, sender, receiver, fee, desc, tnx_id, notice, tnx_date) {
        tnx_date = tnx_date === undefined ? new Date().toISOString() : tnx_date;
        var data = {
            address: address,
            btc: amount,
            sender: sender,
            receiver: receiver,
            description: desc,
            fee: fee,
            tnx_id: tnx_id,
            tnx_date: tnx_date,
            notice: notice
        };
        BitcoinTransaction.create(data).exec(function(err) {
            if (err) {
                sendMail.sendErrMsg(err, data);
                console.log(err);
            }
        });
    }
};