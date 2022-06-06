const SudokError = require('../errors/sudokError');
const databaseLogger = require('../helpers/databaseLogger');

const errorHandler = (err, req, res, next) => {
    let { statusCode, message } = err;
    if (Number.isNaN(Number(statusCode))) {
        statusCode = 500;
    }
    if (statusCode === 500) {
        databaseLogger(req, err);
    }
    // Si l'application n'est pas en développement on reste vague sur l'erreur serveur
    if (statusCode === 500 && res.app.get('env') !== 'development') {
        message = 'Internal Server Error';
    }
    // if application has thrown a sudok error 404, let's send a special page for it
    if (statusCode === 404) {
        return res.render('404.ejs');
    }
    return res.status(statusCode).json({
        result: false,
        status: 'error',
        statusCode,
        message,
    });
};

module.exports = {
    SudokError,
    errorHandler,
};
