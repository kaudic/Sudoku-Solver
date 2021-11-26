const express = require('express');
const router = express.Router();
const { nextTick } = require('process');
const controller = require('./controller');

//variable à transmettre à EJS
router.use((req, res, next) => {
    res.locals.actorConnected = req.session.actorConnected;
    next();
});

//liste des routes GET
router.get('/sudoku/', controller.welcome);
router.get('/sudoku/login', controller.login);
router.get('/sudoku/deconnect', controller.deconnect);
router.get('/sudoku/Login/FormCreation', controller.formCreation);
router.get('/getBoard/:level', controller.loadBoard);
router.get('/solveBoard/:boardId', controller.loadResult);
router.get('/checkInput/:boardId/:inputId', controller.checkCellResult);
router.get('/sudoku/database/', controller.adminAuth, controller.databaseRead); //TODO passer admin comme un argument de fonction

//liste des routes POST
router.post('/solveBoard/', controller.solveBoard);
router.post('/sudoku/login/add', controller.addLogin);
router.post('/sudoku/login/connect', controller.connect);

//aucune route trouvée, gestion de la 404
router.use((req, res) => {
    res.status('404').render('404');
});

module.exports = router;