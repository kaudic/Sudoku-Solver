const solver = require('../services/solver');
const dataMapper = require('../models/db');

// we install this package to help us parsing parameters received
// maybe we don't need such package
const argv = require('yargs').argv;

const boardsGeneratorProcess = async (qty) => {
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

    return 'All boards well generated and saved in DB';
};

process.on('message', (message) => {
    if (message == 'START') {
        const result = boardsGeneratorProcess(argv.qtyNewBoard);
        process.send(result);
    }
});
