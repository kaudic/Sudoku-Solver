
const solver = require('../../services/solver');
const dataMapper = require('../../models/db');

const controller = {

    async dataBaseWrite(req, res) {
        console.log('----------------------------------------------------------------------------------------------');
        // console.log('req.body:' + req.body);
        const qty = Number(req.body.qtyNewBoard);
        // const qty = 2;
        const arrayOfNewBoards = [];

        // Boucle de Générations de grilles aléatoires avec leurs solutions
        for (let i = 0; i < qty; i += 1) {
            // Génération grille
            const newSolvedBoard = solver.generatorSupervisor();

            // On pousse les nouvelles grilles dans un tableau
            arrayOfNewBoards.push(newSolvedBoard);

            // remise à 0 du tracker et de emptyCells pour éviter de mélanger les données
            solver.data.emptyCells = [];
            solver.tracker = [];
        }

        await dataMapper.insertNewBoards(JSON.stringify(arrayOfNewBoards));
        res.json({
            result: true,
            message: 'New boards are well generated and inserted in database'
        });
    },

    async deleteBoard(req, res) {
        const id = Number(req.params.id);
        await dataMapper.deleteOneBoardById(id);
        return res.redirect('/sudoku/database/');
    },
};

// controller.dataBaseWrite();

module.exports = controller;
