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
        console.log('unfilledRandomBoard: ' + unfilledRandomBoard);

        return res.json({
            id: fullRandomBoard.board_id,
            data: unfilledRandomBoard,
        });
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
        // enregistrer les données reçues du front (frontBoardData) vers notre variable en back
        solver.data.ligne = frontBoardData.ligne;
        solver.data.column = frontBoardData.column;
        solver.data.square = frontBoardData.square;
        solver.data.emptyCells = frontBoardData.emptyCells;

        const resultatSolver = solver.solve(false);
        if (resultatSolver === 'Non solvable') {
            return res.json({ results: 'Il n\'y a pas de solution pour cette grille' });
        }
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
