const service = require('../../services/functions');
const solver = require('../../services/solver');
const dataMapper = require('../../models/board');

const controller = {

    async loadBoard(req, res) {
        // on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
        const { level } = (req.params);
        const levelRegexCheck = new RegExp(/^[A-Z][a-zé]+[1-2]?$/);
        const isLevelOk = levelRegexCheck.test(level);
        if (!isLevelOk) {
            throw new Error('Le level demandé n\'est pas conforme à ce qu\'attends l\'API.')
        };
        // we check with a regexp what we received
        const goalOfCellsEmptyPerLine = service.emptyCellsPerLevel(level);
        // Appel du datamapper, il va renvoyer une grille aléatoire.
        const fullRandomBoard = await dataMapper.getOneRandomBoard();
        // on la passe à la fonction aléatoire pour lui retirer des valeurs
        const unfilledRandomBoard = service.wipeCells(fullRandomBoard.board_data, goalOfCellsEmptyPerLine);
        const returnObject = {
            id: fullRandomBoard.board_id,
            data: unfilledRandomBoard,
        };

        console.log('-----------------------------------------------------------------------------------------');
        console.log(JSON.stringify(returnObject));
        console.log('-----------------------------------------------------------------------------------------');

        return res.json(returnObject);
    },
    async loadResult(req, res) {
        // on récupère l'ID de la grille affichée sur le navigateur (provient d'un dataset)
        const { boardId } = req.params;
        const board = await dataMapper.getOneBoardById(boardId);
        const returnObject = {
            id: board.board_id,
            data: JSON.parse(board.board_data),
        };
        console.log('-----------------------------------------------------------------------------------------');
        console.log(JSON.stringify(returnObject));
        console.log('-----------------------------------------------------------------------------------------');
        res.json(returnObject);
    },
    async solveBoard(req, res) {
        // on récupère les données de la grille du front
        const frontBoardData = req.body;
        // enregistrer les données reçues du front (frontBoardData) vers notre objet de variables en back
        solver.data.ligne = frontBoardData;
        solver.data.column = service.loadSolverDataColumn(frontBoardData);
        solver.data.square = service.loadSolverDataSquare(frontBoardData);
        solver.data.emptyCells = service.loadSolverDataEmptyCells(frontBoardData);

        const resultatSolver = solver.solve(false);
        if (resultatSolver === 'Non solvable') {
            return res.json({ results: 'Il n\'y a pas de solution pour cette grille' });
        }
        console.log('RESULTAT: ' + JSON.stringify(solver.data.ligne));
        return res.json({ results: solver.data.ligne });
    },
    async checkCellResult(req, res) {
        // on récupère l'Id de la grille et l'Id de l'input
        const { boardId, inputId } = req.params;
        const ligne = inputId.substr(0, 1);
        const column = inputId.substr(1, 1);

        // lecture de la base de données et on renvoie l'élément recherché
        const results = await dataMapper.getOneBoardById(boardId);
        res.json({ inputSolution: results.board_data[ligne][column] });
    },
};

module.exports = controller;
