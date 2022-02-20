const express = require('express');
const handler = require('../../helpers/handler');
const validate = require('../../validation/validator');
const schema = require('../../validation/schemas/boardSchema');
const { boardController: controller } = require('../../controllers/api');

const router = express.Router();

/**
 * @typedef {array} boards Array containing 9 Arrays with numbers from 0 to 9, for each line
 * @typedef {string} level could be Facile1, Facile2, Moyen, Difficile, Démoniaque
 */

/**
 * GET /api/board/getBoard/{level}
 * @summary Get a board with blank cells to play with (qty of blanks depends on the level requested)
 * @tags Boards - Routes to deal with board management
 * @param {level} level - Difficulty requested (Facile1, Facile2, Moyen, Difficile, Démoniaque)
 * @returns {boards} 200 - Array containing 9 Arrays with numbers from 0 to 9, for each line
 */
router.route('/getBoard/:level([A-Z][a-z]+[1-2]?)')
    .get(handler(controller.loadBoard));

// chargement des résultats d'une grille chargée
router.route('/solveBoard/:boardId(\\d+)')
    .get(handler(controller.loadResult));

// résolution récursive (solveur) d'une grille saisie
router.route('/solveBoard')
    .post(validate('body', schema), handler(controller.solveBoard));

// mode auto-correction, on contrôle la valeur saisie d'une cellule
router.route('/checkInput/:boardId(\\d+)/:inputId(\\d+)')
    .post(handler(controller.checkCellResult));

module.exports = router;
