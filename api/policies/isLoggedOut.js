/**
 * Created by Uzo on 2/20/2017.
 */
module.exports = function isLoggedOut(req, res, next) {
    if (!req.session.userId) {
        return next();
    }

    if (req.wantsJSON) {
        return res.forbidden('You are not permitted to perform this action.');
    }
    return res.redirect('/');
};
