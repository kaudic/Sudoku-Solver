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
 * @summary Get a board with random blank cells. The level requested will determine the number of blank cells per line. A board id will be sent to help you get the solution.
 * @tags Boards - Routes to deal with board management
 * @param {level} level - Difficulty requested (Facile1, Facile2, Moyen, Difficile, Démoniaque)
 * @returns {boards} 200 - Array containing 9 Arrays with numbers from 0 to 9, for each line
 * @example response - 200 - success response example
 * {"id":276,"data":[[3,2,"",7,"",9,"",4,8],["","","",3,8,6,1,5,2],[8,5,6,"","",2,9,7,""],["",8,3,6,4,"",2,9,""],["",6,"",8,9,5,"",1,4],[9,4,5,2,"",1,"",8,""],[5,3,2,"",7,"",4,6,""],["",7,"",9,2,"",5,3,1],["",1,9,5,6,3,"",2,""]]}
 */

// je déporte la regexp à l'intérieur du controlleur afin de faire un decodeURI() à cause de l'accent sur Démoniaque
router.route('/getBoard/:level')
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
