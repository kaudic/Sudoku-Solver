const express = require('express');
const router = express.Router();
const fs = require('fs');
const serverMethods = require('./serverMethods');

router.get('/sudoku/', (req, res) => {

    const title = 'Solveur de Sudoku';
    res.render('index', { title: title });
});


router.get('/getBoard/:level', (req, res) => {

    //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
    const { level } = req.params;

    //lecture de la base de données json et on renvoie une grille aléatoire
    fs.readFile('./data/boardDatabase.json', (err, data) => {
        if (err) throw err;
        const boardData = JSON.parse(data);
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

            const response = {
                id: boardId,
                data: boardDataRequired
            };

            res.setHeader('Access-Control-Allow-Origin', '*');
            res.send(response);
        });
    }
    else {

        console.log('Lancer une fonction de résolution récursive');

        //TODO lancer le solveur

        //simulation de fonction solveur (dur 15s) -> il faudra la mettre en asynchrone

        const resultatSolver = async function () {
            for (let i = 0; i < 50000; i++) {
                console.log(i);
            }
            return 'grille ok';
        }
        const response = async function () {
            const resultat = await resultatSolver();
            return 'grille ok'

        }
        response().then((data) => {
            const responseTreated = {
                solveur: data,
                data: [] //TODO mettre les valeurs de retour du solveur ici
            };

            res.setHeader('Access-Control-Allow-Origin', '*');
            res.send(responseTreated);

            console.log(responseTreated);
        });

    };
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

module.exports = router;