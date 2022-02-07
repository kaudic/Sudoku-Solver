const SudokError = require('../errors/sudokError');

const handler = (controller) => async (req, res, next) => {
    try {
        await controller(req, res, next);
    } catch (err) {
        const sudokError = new SudokError(err.statusCode, err.message);
        next(sudokError);
    }
};

module.exports = handler;
