const solver = require('../../services/solver');
const dataMapper = require('../../models/board');

const controller = {

    async dataBaseWrite(req, res) {
        const qty = Number(req.query.qtyNewBoards);
        const arrayOfNewBoards = [];

        // Boucle de Générations de grilles aléatoires avec leurs solutions
        for (let i = 0; i < qty; i += 1) {
            // Génération grille
            const newSolvedBoard = solver.board.generatorSupervisor();

            // On pousse les nouvelles grilles dans un tableau
            arrayOfNewBoards.push(newSolvedBoard);

            // remise à 0 du tracker et de emptyCells pour éviter de mélanger les données
            solver.board.data.emptyCells = [];
            solver.board.tracker = [];
        }

        await dataMapper.insertNewBoards(JSON.stringify(arrayOfNewBoards));
        res.redirect('/sudoku/database/');
    },

    async deleteBoard(req, res) {
        const id = Number(req.params.id);
        await dataMapper.deleteOneBoardById(id);
        return res.redirect('/sudoku/database/');
    },
};

module.exports = controller;
