const express = require('express');
const handler = require('../../helpers/handler');

// TODO faire les schémas de validation avec Joi
// Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');

// Import des contrôleurs avec des alias
const { boardController: controller } = require('../../controllers/api');

// chargement d'une grille en fonction d'un level demandé
const router = express.Router();

router.route('/getBoard/:level')
    .get(handler(controller.loadBoard));

// chargement des résultats d'une grille chargée
router.route('/solveBoard/:boardId(//d+)')
    .get(handler(controller.loadResult));

// résolution récursive (solveur) d'une grille saisie
router.route('/solveBoard')
    .post(handler(controller.solveBoard));

// mode auto-correction, on contrôle la valeur saisie d'une cellule
router.route('/checkInput/:boardId/:inputId')
    .post(handler(controller.checkCellResult));

module.exports = router;
