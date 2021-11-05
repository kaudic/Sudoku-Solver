const express = require('express');
const router = express.Router();
const fs = require('fs');
const serverMethods = require('./serverMethods');

router.get('/sudoku/', (req, res) => {

    res.render('index');
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
        fs.readFile('./boardDatabase.json', (err, data) => {
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

        //TODO lancer le solveur

    }

});

module.exports = router;