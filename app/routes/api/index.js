const express = require('express');

// imports of helpers
const handler = require('../../helpers/handler');

// importation du dossier contrôleur de l'API
const { apiController } = require('../../controllers/api');
const seoController = require('../../controllers/api/seo');
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

// page publique de consultation du fichier robot.txt
router.get('/robots.txt', handler(seoController.renderRobotTxt));

// page publique de consultation du fichier sitemap.xml
router.get('/sitemap.xml', handler(seoController.renderSiteMapXml));

router.use(() => {
    throw new SudokError(404, 'API Route not found');
});

module.exports = router;
