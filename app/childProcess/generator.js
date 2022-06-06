const solver = require('../services/solver');
const dataMapper = require('../models/db');

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
        console.log('Child process generator of Boards just received START message');
        const result = boardsGeneratorProcess(900);
        process.send(result);
    }
});
