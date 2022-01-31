const express = require('express');

//TODO faire les schémas de validation avec Joi
//Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');

//Import des contrôleurs avec des alias
const { boardController: controller } = require('../../controllers/api');

//TODO faire le handler
//Import du controllerHandler pour factoriser le try/catch et la levée des erreurs
// const controllerHandler = require('../../helpers/apiControllerHandler');

const router = express.Router();

router.route('/getBoard/:level')
    .get(controller.loadBoard); //chargement d'une grille en fonction d'un level demandé

router.route('/solveBoard/:boardId')
    .get(controller.loadResult); //chargement des résultats d'une grille chargée

router.route('/solveBoard')
    .post(controller.solveBoard); //résolution récursive (solveur) d'une grille saisie

router.route('/checkInput/:boardId/:inputId')
    .post(controller.checkCellResult); //mode auto-correction, on contrôle la valeur saisie d'une cellule


module.exports = router;