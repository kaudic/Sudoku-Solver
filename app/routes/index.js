const express = require('express');
const { errorHandler, SudokError } = require('../helpers/errorHandler');

const router = express.Router();

// importation des sous-routeurs
const apiRouter = require('./api');
const websiteRouter = require('./website');

// On préfixe les sous-routers
router.use('/api', apiRouter);
router.use('/sudoku', websiteRouter);
router.use(() => {
    throw new SudokError(404, 'Page introuvable');
});
router.use((err, _, response, next) => {
    errorHandler(err, response, next);
});

module.exports = router;
