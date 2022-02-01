const service = require('../../services/functions');
const solver = require('../../services/solver');
const dataMapper = require('../../models/board');

const controller = {

    async loadBoard(req, res) {
        // on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
        const { level } = req.params;

        // Appel du datamapper, il va renvoyer une grille aléatoire.
        const fullRandomBoard = await dataMapper.getOneRandomBoard();

        // on la passe à la fonction aléatoire pour lui retirer des valeurs
        const unfilledRandomBoard = service.takeOutNumbers(level, fullRandomBoard.board_data);

        res.json = {
            id: fullRandomBoard.board_id,
            data: unfilledRandomBoard,
        };
    },

    async loadResult(req, res) {
        // on récupère l'ID de la grille affichée sur le navigateur (provient d'un dataset)
        const { boardId } = req.params;
        const board = await dataMapper.getOneBoardById(boardId);
        res.json({
            id: board.board_id,
            data: JSON.parse(board.board_data),
        });
    },

    async solveBoard(req, res) {

        // on récupère les données de la grille du front
        const frontBoardData = req.body;

        // enregistrer les données reçues du front (frontBoardData) vers notre variable en back : "solver.board.data"
        solver.board.data.ligne = frontBoardData.ligne;
        solver.board.data.column = frontBoardData.column;
        solver.board.data.square = frontBoardData.square;
        solver.board.data.ligne = frontBoardData.ligne;
        solver.board.data.emptyCells = frontBoardData.emptyCells;

        // lancement du solveur en mode asynchrone
        const resultatSolver = await solver.board.solve(false);

        // A récupération des données du solver, on prépare le message JSON pour le front
        resultatSolver().then((data) => {
            let responseTreated = null;

            if (data === 'Non solvable') {
                return res.json({ results: 'Il n\'y a pas de solution pour cette grille' });
            }
            return res.json({ results: solver.board.data.ligne });
        }

        }),


    checkCellResult: (req, res) => {
        // on récupère l'Id de la grille et l'Id de l'input
        const { boardId, inputId } = req.params;
        console.log(`Id grille reçu: ${boardId}`);
        console.log(`Input n° modifié : ${inputId}`);
        const ligne = inputId.substr(0, 1);
        const column = inputId.substr(1, 1);

        // lecture de la base de données et on renvoie l'élément recherché

        dataMapper.getOneBoardById(boardId, (error, results) => {
            if (error) {
                res.status(500).send('500');
            } else {
                const response = {
                    inputSolution: results.board_data[ligne][column],
                };

                console.log(`solution: ${response.inputSolution}`);

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);
            }
        });
    },

};

module.exports = controller;
