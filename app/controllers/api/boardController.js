const serverMethods = require('../../services/serverMethods');
const solver = require('../../services/solver');
const dataMapper = require('../../models/board');

const controller = {

    loadBoard: (req, res) => {

        //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
        const { level } = req.params;

        //Appel du datamapper, il va renvoyer une grille aléatoire.

        dataMapper.getOneRandomBoard((error, board) => {

            if (error) {
                res.status(500).send('500');
                return;
            }
            else {

                //on la passe à la fonction aléatoire pour lui retirer des valeurs

                const boardDataLevelTreated = serverMethods.takeOutNumbersFromBoard(level, board.board_data);

                const response = {
                    id: board.board_id,
                    data: boardDataLevelTreated
                };

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);

            }

        })

    },

    loadResult: (req, res) => {

        //on récupère l'ID de la grille affichée sur le navigateur (provient d'un dataset)
        const boardId = Number(req.params.boardId);

        //Appel du dataMapper pour rechercher la grille avec l'ID fourni

        dataMapper.getOneBoardById(boardId, (error, board) => {
            if (error) {
                res.status(500).send('500');
                return;
            }
            else {

                const response = {
                    id: board.board_id,
                    data: JSON.parse(board.board_data)
                };

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);

            }

        })
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

            const response = solver.board.solve(false);
            return response;

        }

        //A récupération des données du solver, on prépare le message JSON pour le front
        resultatSolver().then((data) => {

            let responseTreated = null;

            if (data === 'Non solvable') {
                responseTreated = {
                    results: 'Il n\'y a pas de solution pour cette grille',
                };
            } else {
                responseTreated = {
                    results: solver.board.data.ligne,
                };
            }

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

        //lecture de la base de données et on renvoie l'élément recherché

        dataMapper.getOneBoardById(boardId, (error, results) => {
            if (error) {
                res.status(500).send('500');
                return;

            } else {

                const response = {
                    inputSolution: results.board_data[ligne][column]
                };

                console.log('solution: ' + response.inputSolution);

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);

            }
        })
    },

};

module.exports = controller;