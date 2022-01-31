const express = require('express');
const router = express.Router();

//importation des routeurs
const userRouter = require('./user');
const boardRouter = require('./board');
const dbRouter = require('./db');
const settingsRouter = require('./settings');

//importation du dossier contrôleur de l'API
const { apiController } = require('../../controllers/api');

//TODO ERREURS SPECIFIQUES API
//importation des erreurs spécifiques
// const { ApiError } = require('../../helpers/errorHandler');

//Dispatch entre route d'accueil et routeurs secondaires
router.all('/', apiController.home);
router.use('/user', userRouter);
router.use('/settings', settingsRouter);
router.use('/db', dbRouter);
router.use('/board', boardRouter);

//TODO utiliser erreur sépcifique pour générer la 404
// router.use(() => {
//     throw new ApiError(404, 'API Route not found');
// });

module.exports = router;