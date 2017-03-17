/**
 * Created by Uzo on 3/3/2017.
 */

module.exports = function isLoggedIn(req, res, next) {
    if (req.session.admin) {
        return next();
    }

    if (req.wantsJSON) {
        return res.forbidden('You are not permitted to view this page.');
    }
    return res.redirect('/');
};