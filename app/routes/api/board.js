const express = require('express');
const handler = require('../../helpers/handler');
const validate = require('../../validation/validator');
const schema = require('../../validation/schemas/boardSchema');
const { boardController: controller } = require('../../controllers/api');

const router = express.Router();

/**
* An object containing a board with empty values and a board id
 * @typedef {object} playerBoard
 * @property {integer} id - The board id
 * @property {integer} data - The board numbers with empty values
 */

/**
* An object containing a board with empty values and a board id
 * @typedef {object} errorPlayerBoard
 * @property {boolean} result - false
 * @property {string} status - error
 * @property {integer} statusCode - 500
 * @property {string} message - Le level demandé n'est pas conforme à ce qu'attends l'API.
 */

/**
 * GET /api/board/getBoard/{level}
 * @summary Get a board with random blank cells. The level requested will determine the number of blank cells per line. A board id will be sent to help you get the solution.
 * @tags Boards - Routes to deal with board management
 * @param {string} level.path - level param description - enum:Facile1,Facile2,Moyen,Difficile,Démoniaque
 * @returns {playerBoard} 200 - Object sent in case of success: list of numbers with random empty values in the data property of the object
 * @example response - 200 - success response example
 * {"id":276,"data":[[3,2,"",7,"",9,"",4,8],["","","",3,8,6,1,5,2],[8,5,6,"","",2,9,7,""],["",8,3,6,4,"",2,9,""],["",6,"",8,9,5,"",1,4],[9,4,5,2,"",1,"",8,""],[5,3,2,"",7,"",4,6,""],["",7,"",9,2,"",5,3,1],["",1,9,5,6,3,"",2,""]]}
 * @returns {errorPlayerBoard} 500 - Object sent in case of wrong usage of the API route)
 * @example response - 500 - failed response example
 * {
  "result": false,
  "status": "error",
  "statusCode": 500,
  "message": "Le level demandé n'est pas conforme à ce qu'attends l'API."
}
*/

// je déporte la regexp à l'intérieur du controlleur afin de faire un decodeURI() à cause de l'accent sur Démoniaque
router.route('/getBoard/:level')
    .get(handler(controller.loadBoard));

/**
* An object containing a board with empty values and a board id
 * @typedef {object} playerBoard
 * @property {integer} id - The board id
 * @property {integer} data - The board numbers with empty values
 */

/**
* An object containing a board with empty values and a board id
 * @typedef {object} errorSolvedBoard
 * @property {boolean} result - false
 * @property {string} status - error
 * @property {integer} statusCode - 500
 * @property {string} message - Cannot read property 'board_id' of undefined.
 */

/**
 * GET /api/board/solveBoard/{boardId}
 * @summary Get the solution of one board if you know its id
 * @tags Boards - Routes to deal with board management
 * @param {integer} boardId.path - boardId param description
 * @returns {playerBoard} 200 - Object sent in case of success: full list of numbers in the data property of the object
 * @example response - 200 - success response example
 * {"id":3280,"data":[[9,2,1,8,3,6,7,4,5],[8,6,4,7,1,5,3,2,9],[7,3,5,4,2,9,1,8,6],[6,1,7,5,9,2,8,3,4],[3,5,8,1,6,4,2,9,7],[4,9,2,3,8,7,6,5,1],[1,4,9,2,7,8,5,6,3],[2,7,6,9,5,3,4,1,8],[5,8,3,6,4,1,9,7,2]]}
 * @returns {errorPlayerBoard} 500 - Object sent in case of wrong usage of the API route)
 * @example response - 500 - failed response example
 * {
  "result": false,
  "status": "error",
  "statusCode": 500,
  "message": "Cannot read property 'board_id' of undefined"
}
*/

// chargement des résultats d'une grille chargée
router.route('/solveBoard/:boardId(\\d+)')
    .get(handler(controller.loadResult));

/**
* POST /api/board/solveBoard
* @summary Solve any valid boards with backtracing method - delay of resolution <1s
* @param {array<integer>} request.body.required - boards numbers containing 0 for the figures that need to be solved - application/json
* @returns {playerBoard} 200 - full list of numbers in 9 arrays - each array is representing one line of the board
 * @example response - 200 - success response example
 * [[2,3,6,4,1,5,7,8,9],[5,8,9,6,2,7,1,3,4],[1,4,7,8,3,9,2,5,6],[4,6,2,3,5,1,8,9,7],[9,5,8,7,4,2,6,1,3],[3,7,1,9,6,8,4,2,5],[6,2,5,1,7,3,9,4,8],[7,9,3,2,8,4,5,6,1],[8,1,4,5,9,6,3,7,2]]
* @example request - example payload
 * [[0,0,0,0,0,2,0,4,0],[2,0,0,0,0,8,0,0,0],[3,1,0,0,0,0,0,0,0],[0,0,0,0,8,0,6,9,0],[0,0,0,0,0,4,0,0,1],[0,6,0,0,0,0,8,0,7],[0,0,0,0,0,7,5,0,0],[0,0,0,0,2,0,4,0,0],[0,0,0,0,0,0,1,0,2]]
 *
* @tags Boards - Routes to deal with board management
*/

// résolution récursive (solveur) d'une grille saisie
router.route('/solveBoard')
    .post(validate('body', schema), handler(controller.solveBoard));

// mode auto-correction, on contrôle la valeur saisie d'une cellule
router.route('/checkInput/:boardId(\\d+)/:inputId(\\d+)')
    .post(handler(controller.checkCellResult));

module.exports = router;
