const fs = require('fs');
const serverMethods = require('./serverMethods');
const boardData = require('../data/boardDatabase.json');
const solver = require('../my_modules/solver');

const controller = {
    welcome: (req, res) => {

        res.render('index');
    },

    loadBoard: (req, res) => {

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
    },

    loadResult: (req, res) => {

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

    },

    solveBoard: (req, res) => {
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
    },

    checkCellResult: (req, res) => {

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
    },

    database: (req, res) => {

        //lecture du fichier json initial
        fs.readFile('../back/data/boardDatabase2.json', ((err, data) => {
            if (err) throw err;

            const initialDatabase = JSON.parse(data);
            let nextID = (initialDatabase.length) - 1;

            //Boucle de Générations de grilles aléatoires avec leurs solutions

            let newSolvedBoard = [];

            for (let i = 0; i < 10; i++) {

                nextID += 1;

                //Génération grille
                newSolvedBoard = solver.board.generatorSupervisor();
                const newSolvedBoardObject = {
                    id: "id" + nextID,
                    data: newSolvedBoard
                };

                //On pousse les nouvelles grilles dans un objet qui deviendra la nouvelle base de données JSON
                initialDatabase.push(newSolvedBoardObject);

                //remise à 0 du tracker et de emptyCells pour éviter de mélanger les données
                solver.board.data.emptyCells = [];
                solver.board.tracker = [];
            }

            const finalDatabase = JSON.stringify(initialDatabase);

            fs.writeFile('../back/data/boardDatabase2.json', finalDatabase, (err) => {
                if (err) throw err;
            });
            console.log('Nouvelles grilles enregistrées en base de données JSON');
            //On renvoie un fichier EJS qui affiche les données
            res.send(JSON.stringify(initialDatabase));



        }));









    }

};

module.exports = controller;