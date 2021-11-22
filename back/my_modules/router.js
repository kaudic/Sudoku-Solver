const express = require('express');
const router = express.Router();
const { nextTick } = require('process');
const controller = require('./controller');

//variable à transmettre à EJS
router.use((req, res, next) => {
    res.locals.title = 'Solveur de Sudoku';
    next();
});

//liste des routes
router.get('/sudoku/', controller.welcome);
router.get('/sudoku/login', controller.login);
router.get('/getBoard/:level', controller.loadBoard);
router.get('/solveBoard/:boardId', controller.loadResult);
router.post('/solveBoard/', controller.solveBoard);
router.get('/checkInput/:boardId/:inputId', controller.checkCellResult);
router.get('/sudoku/database/', controller.database);

//aucune route trouvée, gestion de la 404
router.use((req, res) => {
    res.status('404').render('404');
});

module.exports = router;