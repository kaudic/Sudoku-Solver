const express = require('express');
const handler = require('../../helpers/handler');

const router = express.Router();

// Importation du contrôleur dédié au website
const { websiteController: controller } = require('../../controllers/website');
const SudokError = require('../../errors/sudokError');

router.get('/', handler(controller.home)); // page d'accueil
router.get('/login', handler(controller.login)); // pas de connexion
router.get('/deconnect', handler(controller.deconnect)); // déconnection (on shoote la session)
router.get('/account/create', handler(controller.formCreation)); // Formulaire de création de compte
router.get('/account/:login', handler(controller.displayAccount)); // afficher les infos de compte et pouvoir les modifier
router.get('/database/', handler(controller.adminAuth), handler(controller.databaseRead)); // TODO passer admin comme un argument de fonction

router.use(() => {
    throw new SudokError(404, 'Page introuvable');
});

module.exports = router;
