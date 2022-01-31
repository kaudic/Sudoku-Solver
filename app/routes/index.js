const express = require('express');
const router = express.Router();

//importation des sous-routeurs
const apiRouter = require('./api');
const websiteRouter = require('./website');

//TODO construire le errorHandler
// const { errorHandler } = require('../helpers/errorHandler');

// On préfixe les sous-routers
router.use('/api', apiRouter);
router.use('/sudoku', websiteRouter);

//TODO une fois construit le mettre en application ici
// router.use((err, _, response, next) => {
//     errorHandler(err, response, next);
// });

module.exports = router;