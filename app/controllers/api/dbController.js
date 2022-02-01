const solver = require('../../services/solver');
const dataMapper = require('../../models/board');

const controller = {

  dataBaseWrite: (req, res) => {
    const qty = Number(req.query.qtyNewBoards);

    const arrayOfNewBoards = [];

    // Boucle de Générations de grilles aléatoires avec leurs solutions

    for (let i = 0; i < qty; i++) {
      // Génération grille
      const newSolvedBoard = solver.board.generatorSupervisor();

      // On pousse les nouvelles grilles dans un tableau qui contiendra toutes les nouvelles grilles

      arrayOfNewBoards.push(newSolvedBoard);

      // remise à 0 du tracker et de emptyCells pour éviter de mélanger les données
      solver.board.data.emptyCells = [];
      solver.board.tracker = [];
    }

    const boards = JSON.stringify(arrayOfNewBoards);

    // Datamapper pour écrire les résultats
    dataMapper.insertNewBoards(boards, (error, results) => {
      if (error) {
        res.status(500).send('500');
      } else {
        console.log(results);
        res.redirect('/sudoku/database/');
      }
    });
  },

  deleteBoard: (req, res) => {
    const id = Number(req.params.id);

    dataMapper.deleteOneBoardById(id, (error, results) => {
      if (error) {
        res.status(500).send('500');
      } else {
        res.redirect('/sudoku/database/');
      }
    });
  },

};

module.exports = controller;
