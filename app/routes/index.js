const express = require('express');
const { errorHandler, SudokError } = require('../helpers/errorHandler');

// imports of controllers
const webSiteController = require('../controllers/website');

// imports of helpers
const handler = require('../helpers/handler');
const seoController = require('../controllers/api/seo');
const settingsController = require('../controllers/api/settingsController');

const router = express.Router();

// si erreur utilisateur, on redirige sur /sudoku
router.get('/', (req, res) => {
    res.redirect('/sudoku');
});

// importation des sous-routeurs
const apiRouter = require('./api');
const websiteRouter = require('./website');

// On préfixe les sous-routers
router.use('/api', apiRouter);
router.use('/sudoku', websiteRouter);

// page publique de consultation du fichier robot.txt
router.get('/robots.txt', handler(seoController.renderRobotTxt));

// page publique de consultation du fichier sitemap.xml
router.get('/sitemap.xml', handler(seoController.renderSiteMapXml));

// page admin de consultation des logs d'erreurs enregistrés en database
router.get('/logs', handler(webSiteController.adminAuth), handler(settingsController.renderLogs));

router.use(() => {
    throw new SudokError(404, 'Page introuvable');
});

// If an error is thrown then it will be treated in this middleware
router.use((err, req, res, next) => {
    errorHandler(err, req, res, next);
});

module.exports = router;
