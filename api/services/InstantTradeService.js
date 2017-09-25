var Promise = require('promise');

module.exports = {
    buyBTC: function(user_id, btc, qty, used_market_price) {
        return new Promise(function(resolve, reject) {
            var data = {
                user: user_id,
                btc: btc,
                trade_type: 'buy',
                used_market_price: market_price
            };
            InstantTrade.create(data).exec(function (err, buy) {
                if (err) {
                    return reject(err);
                }
                return resolve({ id: buy.id, status: 'success' });
            });
        });
    }
}