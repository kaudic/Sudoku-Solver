const SudokError = require('../errors/sudokError');
const logger = require('./logger');

const errorHandler = (err, res) => {
    let { statusCode, message } = err;

    if (Number.isNaN(Number(statusCode))) {
        statusCode = 500;
    }
    if (statusCode === 500) {
        logger.error(err);
    }
    // Si l'application n'est pas en développement on reste vague sur l'erreur serveur
    if (statusCode === 500 && res.app.get('env') !== 'development') {
        message = 'Internal Server Error';
    }
    res.status(statusCode).json({
        status: 'error',
        statusCode,
        message,
    });
};

module.exports = {
    SudokError,
    errorHandler,
};
