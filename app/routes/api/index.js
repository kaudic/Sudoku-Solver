const express = require('express');
// importation du dossier contrôleur de l'API
const { apiController } = require('../../controllers/api');
const SudokError = require('../../errors/sudokError');

const router = express.Router();

// importation des routeurs
const boardRouter = require('./board');
const dbRouter = require('./db');
const settingsRouter = require('./settings');

// Dispatch entre route d'accueil et routeurs secondaires
router.all('/', apiController.home);
router.use('/settings', settingsRouter);
router.use('/db', dbRouter);
router.use('/board', boardRouter);

router.use(() => {
    throw new SudokError(404, 'API Route not found');
});

module.exports = router;
