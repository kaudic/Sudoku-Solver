//importation et gestion des modules externes
const express = require('express');
const app = express();
const fs = require('fs');

//importation des modules internes
const serverMethods = require('./serverMethods');


app.get('/getBoard/:level', (req, res) => {

    //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
    const { level } = req.params;

    //lecture de la base de données json et on renvoie une grille aléatoire
    fs.readFile('./boardDatabase.json', (err, data) => {
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

app.get('/solveBoard/:boardId', (req, res) => {

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

app.listen(3000, () => console.log('server running and listenning to port 3000'));
