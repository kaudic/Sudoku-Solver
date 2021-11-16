const express = require('express');
const router = express.Router();
const fs = require('fs');
const serverMethods = require('./serverMethods');
const boardData = require('../data/boardDatabase.json');
const solver = require('../my_modules/solver');
const { nextTick } = require('process');

//variable à transmettre à EJS
router.use((req, res, next) => {
    res.locals.title = 'Solveur de Sudoku';
    next();
});

router.get('/sudoku/', (req, res) => {

    // const title = 'Solveur de Sudoku';
    // res.render('index', { title: title });
    res.render('index');
});


router.get('/getBoard/:level', (req, res) => {

    //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
    const { level } = req.params;

    //la base de données a été require dans la variable boardData -> plus besoin de faire des fs.readFile

    const max = Object.keys(boardData).length;
    const randomNumber = serverMethods.getRandomNumber(0, max);
    const randomId = 'id' + randomNumber;
    const boardDataLevelTreated = serverMethods.takeOutNumbersFromBoard(level, boardData[randomId]);

    const response = {
        id: randomId,
        data: boardDataLevelTreated
    };

    res.setHeader('Access-Control-Allow-Origin', '*');
    res.send(response);




});

router.get('/solveBoard/:boardId', (req, res) => {

    //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
    const { boardId } = req.params;

    if (boardId !== 'none') {

        //lecture de la base de données json et on renvoie la grille de l'ID recherchée
        fs.readFile('./data/boardDatabase.json', (err, data) => {
            if (err) throw err;
            const boardData = JSON.parse(data);

            const boardDataRequired = boardData[boardId];
            console.log(boardDataRequired);

            const response = {
                id: boardId,
                data: boardDataRequired
            };

            res.setHeader('Access-Control-Allow-Origin', '*');
            res.send(response);
        });
    }

    else {

        return nextTick();


    };

});


router.post('/solveBoard/', (req, res) => {
    console.log('Solveur démarré');

    //on récupère les données de la grille du front
    const frontBoardData = req.body;

    //enregistrer les données reçues du front (frontBoardData) vers notre variable en back : "solver.board.data"
    solver.board.data.ligne = frontBoardData.ligne;
    solver.board.data.column = frontBoardData.column;
    solver.board.data.square = frontBoardData.square;
    solver.board.data.ligne = frontBoardData.ligne;
    solver.board.data.emptyCells = frontBoardData.emptyCells;

    //lancement du solveur en mode asynchrone
    const resultatSolver = async function () {
        // try {
        const response = solver.board.solve(false);
        return response;
        // } catch (e) {
        //     console.log('erreur :' + e)
        // }

    }

    //A récupération des données du solver, on prépare le message JSON pour le front
    resultatSolver().then((data) => {
        console.log(data);
        const responseTreated = {
            results: solver.board.data.ligne, //!avant data
        };

        //envoie du message au front
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.send(responseTreated);

    });
});

router.get('/checkInput/:boardId/:inputId', (req, res) => {

    //on récupère l'Id de la grille et l'Id de l'input
    const { boardId, inputId } = req.params;
    console.log('Id grille reçu: ' + boardId);
    console.log('Input n° modifié : ' + inputId);
    const ligne = inputId.substr(0, 1);
    const column = inputId.substr(1, 1);

    //lecture de la base de données json et on renvoie l'élément recherché
    fs.readFile('./data/boardDatabase.json', (err, data) => {
        if (err) throw err;
        const boardData = JSON.parse(data);

        const response = {
            inputSolution: boardData[boardId][ligne][column]
        };

        console.log('solution: ' + response.inputSolution);

        res.setHeader('Access-Control-Allow-Origin', '*');
        res.send(response);
    });
});

router.use((req, res) => {
    res.status('404').render('404');
})

module.exports = router;