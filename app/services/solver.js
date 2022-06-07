const method = require('./functions')

/* eslint-disable complexity */
/* eslint-disable max-lines-per-function */
const solver = {
    data: {
        // contiendra les données de la grille en lecture en lignes
        line: [],
        // contiendra les données de la grille en lecture en colonnes
        column: [],
        // contiendra les données de la grille en lecture en carrés
        square: [],
        // cellules vides(coordonnées) (enresgitrement 0 est la prochaine à être calculée)
        emptyCells: [],
        // array with calculated cells, cell-> object;
        tracker: [

            // {
            //     cellCalculated: [],
            //     possibleResults: [],
            //     testedResults: [] coordonnées des cellules calculées
            // }
        ],
        solveIteration: 0,
    },
    // vérifie cohérence des chiffres entre lignes, colonnes et carrés
    boardFinished() {
        const stateLines = solver.linesFinished();

        if (stateLines) {
            // console.log('stateLines:' + stateLines);
            const stateColumns = solver.columnsFinished();

            if (stateColumns) {
                // console.log('stateColumns:' + stateColumns);
                const stateSquares = solver.squaresFinished();
                // return true;
                if (stateSquares) {
                    // console.log('stateSquares:' + stateSquares);
                    return true;
                }
            }
        }
        return false;
    },
    linesFinished(board = this.data.line) {
        // console.log('LINE: ' + board);
        let areLinesOK = true;
        board.forEach((line) => {
            for (let i = 1; i < 10; i += 1) {
                if (!line.includes(i) || line.length !== 9) {
                    areLinesOK = false;
                }
            }
        });
        return areLinesOK;
    },
    squaresFinished(board = this.data.square) {
        let areSquaresOK = true;
        // console.log('SQUARE: ' + board);
        board.forEach((square) => {
            for (let i = 1; i < 10; i += 1) {
                if (!square.includes(i) || square.length !== 9) {
                    areSquaresOK = false;
                }
            }
        });
        return areSquaresOK;
    },
    columnsFinished(board = this.data.column) {
        let areColumnsOK = true;
        board.forEach((column) => {
            for (let i = 1; i < 10; i += 1) {
                if (!column.includes(i) || column.length !== 9) {
                    areColumnsOK = false;
                }
            }
        });
        return areColumnsOK;
    },
    // cette fonction trouve le carré concerné à partir du numéro de ligne et de colonne
    // eslint-disable-next-line max-lines-per-function
    // eslint-disable-next-line complexity
    findSquare(lig, col) {
        let square = '';

        if (lig <= 2 && col <= 2) {
            square = 0;
        } else if (lig <= 2 && col > 2 && col <= 5) {
            square = 1;
        } else if (lig <= 2 && col > 5) {
            square = 2;
        } else if (lig > 2 && lig <= 5 && col <= 2) {
            square = 3;
        } else if (lig > 2 && lig <= 5 && col > 2 && col <= 5) {
            square = 4;
        } else if (lig > 2 && lig <= 5 && col > 5) {
            square = 5;
        } else if (lig > 5 && col <= 2) {
            square = 6;
        } else if (lig > 5 && col > 2 && col <= 5) {
            square = 7;
        } else if (lig > 5 && col > 5) {
            square = 8;
        }
        return square;
    },
    updateSquare() {
        // console.log('update square starting');

        solver.data.square[0][0] = solver.data.ligne[0][0];
        solver.data.square[0][1] = solver.data.ligne[0][1];
        solver.data.square[0][2] = solver.data.ligne[0][2];
        solver.data.square[0][3] = solver.data.ligne[1][0];
        solver.data.square[0][4] = solver.data.ligne[1][1];
        solver.data.square[0][5] = solver.data.ligne[1][2];
        solver.data.square[0][6] = solver.data.ligne[2][0];
        solver.data.square[0][7] = solver.data.ligne[2][1];
        solver.data.square[0][8] = solver.data.ligne[2][2];

        solver.data.square[1][0] = solver.data.ligne[0][3];
        solver.data.square[1][1] = solver.data.ligne[0][4];
        solver.data.square[1][2] = solver.data.ligne[0][5];
        solver.data.square[1][3] = solver.data.ligne[1][3];
        solver.data.square[1][4] = solver.data.ligne[1][4];
        solver.data.square[1][5] = solver.data.ligne[1][5];
        solver.data.square[1][6] = solver.data.ligne[2][3];
        solver.data.square[1][7] = solver.data.ligne[2][4];
        solver.data.square[1][8] = solver.data.ligne[2][5];

        solver.data.square[2][0] = solver.data.ligne[0][6];
        solver.data.square[2][1] = solver.data.ligne[0][7];
        solver.data.square[2][2] = solver.data.ligne[0][8];
        solver.data.square[2][3] = solver.data.ligne[1][6];
        solver.data.square[2][4] = solver.data.ligne[1][7];
        solver.data.square[2][5] = solver.data.ligne[1][8];
        solver.data.square[2][6] = solver.data.ligne[2][6];
        solver.data.square[2][7] = solver.data.ligne[2][7];
        solver.data.square[2][8] = solver.data.ligne[2][8];

        solver.data.square[3][0] = solver.data.ligne[3][0];
        solver.data.square[3][1] = solver.data.ligne[3][1];
        solver.data.square[3][2] = solver.data.ligne[3][2];
        solver.data.square[3][3] = solver.data.ligne[4][0];
        solver.data.square[3][4] = solver.data.ligne[4][1];
        solver.data.square[3][5] = solver.data.ligne[4][2];
        solver.data.square[3][6] = solver.data.ligne[5][0];
        solver.data.square[3][7] = solver.data.ligne[5][1];
        solver.data.square[3][8] = solver.data.ligne[5][2];

        solver.data.square[4][0] = solver.data.ligne[3][3];
        solver.data.square[4][1] = solver.data.ligne[3][4];
        solver.data.square[4][2] = solver.data.ligne[3][5];
        solver.data.square[4][3] = solver.data.ligne[4][3];
        solver.data.square[4][4] = solver.data.ligne[4][4];
        solver.data.square[4][5] = solver.data.ligne[4][5];
        solver.data.square[4][6] = solver.data.ligne[5][3];
        solver.data.square[4][7] = solver.data.ligne[5][4];
        solver.data.square[4][8] = solver.data.ligne[5][5];

        solver.data.square[5][0] = solver.data.ligne[3][6];
        solver.data.square[5][1] = solver.data.ligne[3][7];
        solver.data.square[5][2] = solver.data.ligne[3][8];
        solver.data.square[5][3] = solver.data.ligne[4][6];
        solver.data.square[5][4] = solver.data.ligne[4][7];
        solver.data.square[5][5] = solver.data.ligne[4][8];
        solver.data.square[5][6] = solver.data.ligne[5][6];
        solver.data.square[5][7] = solver.data.ligne[5][7];
        solver.data.square[5][8] = solver.data.ligne[5][8];

        solver.data.square[6][0] = solver.data.ligne[6][0];
        solver.data.square[6][1] = solver.data.ligne[6][1];
        solver.data.square[6][2] = solver.data.ligne[6][2];
        solver.data.square[6][3] = solver.data.ligne[7][0];
        solver.data.square[6][4] = solver.data.ligne[7][1];
        solver.data.square[6][5] = solver.data.ligne[7][2];
        solver.data.square[6][6] = solver.data.ligne[8][0];
        solver.data.square[6][7] = solver.data.ligne[8][1];
        solver.data.square[6][8] = solver.data.ligne[8][2];

        solver.data.square[7][0] = solver.data.ligne[6][3];
        solver.data.square[7][1] = solver.data.ligne[6][4];
        solver.data.square[7][2] = solver.data.ligne[6][5];
        solver.data.square[7][3] = solver.data.ligne[7][3];
        solver.data.square[7][4] = solver.data.ligne[7][4];
        solver.data.square[7][5] = solver.data.ligne[7][5];
        solver.data.square[7][6] = solver.data.ligne[8][3];
        solver.data.square[7][7] = solver.data.ligne[8][4];
        solver.data.square[7][8] = solver.data.ligne[8][5];

        solver.data.square[8][0] = solver.data.ligne[6][6];
        solver.data.square[8][1] = solver.data.ligne[6][7];
        solver.data.square[8][2] = solver.data.ligne[6][8];
        solver.data.square[8][3] = solver.data.ligne[7][6];
        solver.data.square[8][4] = solver.data.ligne[7][7];
        solver.data.square[8][5] = solver.data.ligne[7][8];
        solver.data.square[8][6] = solver.data.ligne[8][6];
        solver.data.square[8][7] = solver.data.ligne[8][7];
        solver.data.square[8][8] = solver.data.ligne[8][8];

    },
    /**
     *
     * @param {string} Cellcoordinates 2 chiffres qui donne 'ligneColonne'
     */
    calculateCell(cellCoordinates) {
        // fonction qui calcule tous les résultats possibles pour une cellule
        // On constitue un tableau de départ qui contient tous les chiffres possibles
        // On supprimera au fur et à mesure les chiffres déjà utilisés
        const possibleResults = [1, 2, 3, 4, 5, 6, 7, 8, 9];

        // On détermine la ligne, la colonne de la cellule à partir de l'argument passé
        // On détermine le carré concerné en envoyant ligne et colonne à une fonction déportée
        const ligne = cellCoordinates.substr(0, 1);
        const column = cellCoordinates.substr(1, 1);
        const square = solver.findSquare(ligne, column);

        // create of array with concatenation of all numbers
        const usedNumbers = solver.data.ligne[ligne]
            .concat(solver.data.column[column], solver.data.square[square]);

        // On itère sur les chiffres de usedNumbers et on les retire de possibleResults
        usedNumbers.forEach((element) => {
            const index = possibleResults.indexOf(element);
            if (index !== -1) {
                possibleResults.splice(index, 1);
            }
        });
        return possibleResults;
    },
    makeStepsBeforeBacktracing() {
        // on recherche le dernier élément du tracker
        const trackerLength = solver.data.tracker.length;
        const lastCell = solver.data.tracker[trackerLength - 1];

        // on récupère les num de ligne/colonne/square
        const ligne = lastCell.cellCalculated.substr(0, 1);
        const column = lastCell.cellCalculated.substr(1, 1);

        // on supprime les valeurs de cette cellule dans les data ligne/column et square
        solver.data.ligne[ligne][column] = 0;
        solver.data.column[column][ligne] = 0;
        solver.updateSquare();

        // push found cells in emptyCells of it to be calculated in next round
        solver.data.emptyCells.unshift(lastCell.cellCalculated);
    },
    // fonction solver récursive
    solve(backtracing) {
        // compteur qui sert à sortir de la fonction avant le plantage (environ 3500 itérations)
        solver.data.solveIteration += 1;
        if (solver.data.solveIteration > 3500) {
            solver.data.solveIteration = 0;
            return 'Non solvable';
        }
        // on regarde si backtracing est à true/false
        // si à true cela veut dire qu'on revient en arrière et donc on ne recalcule pas directement la cellule
        // on va voir si un autre résultat était testable
        if (!backtracing) {
            // La première cellule calculée sera donnée soit par speedUpSolve (renvoie la première cellule qui n'a qu'un seul résultat possible), si speedUpSolve n'en trouve pas, alors on calcule la première cellule vide
            // On calcule cette cellule vide (tous les résultats possibles) à l'aide de la fonction calculateCell
            let nextCell = solver.speedUpSolve();

            if (nextCell === 'backtracing') {
                if (!solver.data.tracker[solver.data.tracker.length - 1]) {
                    return 'Non solvable';
                }
                solver.makeStepsBeforeBacktracing();
                return solver.solve(true);
            }

            if (!nextCell) {
                nextCell = solver.data.emptyCells[0];
            }

            const cellResults = solver.calculateCell(nextCell);

            // Si on a plusieurs résultats possibles:
            if (cellResults.length > 0) {
                // On enregistre la cellule calculée, les résultats possibles et le résultat testé (ce sera le premier résultat trouvé) dans le tracker
                // création d'un objet contenant les données de la cellule
                const testedResult = cellResults.shift();
                const cellTrackerData = {
                    cellCalculated: nextCell,
                    possibleResults: cellResults,
                    testedResults: [testedResult]
                };

                // insertion de l'objet créé dans le tracker
                solver.data.tracker.push(cellTrackerData);
                // console.log(JSON.stringify(cellTrackerData));

                // on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste
                const ligne = nextCell.substr(0, 1);
                const column = nextCell.substr(1, 1);

                solver.data.ligne[ligne][column] = testedResult;
                solver.data.column[column][ligne] = testedResult;
                solver.updateSquare();

                // on enlève les coordonnées de cette cellule du tableau des cellules vides
                const cellToDelete = solver.data.emptyCells.findIndex(cell => cell === nextCell);
                solver.data.emptyCells.splice(cellToDelete, 1);

                // on vérifie si la grille est terminée avec la méthode isFinished
                const stopSolver = solver.boardFinished();
                // console.log('solver.data.ligne: ' + JSON.stringify(solver.data.ligne));
                // console.log('stopSolver: ' + stopSolver);

                if (stopSolver) {
                    // -> si oui on fait un return pour stopper la fonction (et on ré-initialise le tracker)
                    // si besoin faire une boucle avec du shift pour shooter les éléments un par un
                    solver.data.tracker = [];
                    const solverResponse = solver.data.ligne;
                    // remise à 0 du compteur car c'est la fin de la fonction
                    solver.solveIteration = 0;
                    return solverResponse;

                }
                else {
                    //-> si non alors on relancer solver avec la valeur false pour aller sur la cellule suivante
                    // par contre par sécurité on vérifie quand même qu'il reste une cellule vide dans emptyCells
                    // si ce n'est pas le cas, il y a forcément une erreur (la grille n'est pas réalisable)
                    if (solver.data.emptyCells.length === 0) {
                        return 'Non solvable';
                    }
                    else {
                        return solver.solve(false);
                    }
                }
            }
            else {
                // on a pas trouvé de résultat sur la cellule en cours donc il faut revenir en arrière
                if (solver.data.tracker.length === 0) {
                    return 'Non solvable';
                }
                if (!solver.data.tracker[solver.data.tracker.length - 1]) {
                    return 'Non solvable';
                }
                solver.makeStepsBeforeBacktracing();
                // on relance le solveur avec la valeur true (récursivité)
                return solver.solve(true);
            }
        }
        else {
            // on est là car le solveur a été relancé avec la valeur true. On recherche dans le tracker la première cellule de emptyCells (il faut y tester un autre résultat car il s'agit d'un retour arrière)
            const ligne = solver.data.emptyCells[0].substr(0, 1);
            const column = solver.data.emptyCells[0].substr(1, 1);

            const cell = solver.data.tracker.find((element) => {
                return (element.cellCalculated) === (ligne + column);
            });

            if (!cell) {
                solver.solveIteration = 0;
                return;
            }
            // on a trouvé la cellule donc on regarde s'il y avait d'autres résultats possibles.
            if (cell.possibleResults.length > 0) {
                // Si oui on va tester un des autres résultats non testés encore
                const testedResult = cell.possibleResults.shift();
                cell.testedResults.push(testedResult);
                // on relance le solveur avec la valeur false
                // on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste
                const ligne = solver.data.emptyCells[0].substr(0, 1);
                const column = solver.data.emptyCells[0].substr(1, 1);

                solver.data.ligne[ligne][column] = testedResult;
                solver.data.column[column][ligne] = testedResult;
                solver.updateSquare();

                // on enlève les coordonnées de cette cellule du tableau des cellules vides
                solver.data.emptyCells.shift();
                return solver.solve(false);
            }
            else {
                // s'il n'y a pas de résultat possible alors il faut remove la cell du track
                const deletedCell = solver.data.tracker.pop();

                if (solver.data.tracker.length === 0) {
                    return 'Non solvable';
                }
                if (!solver.data.tracker[solver.data.tracker.length - 1]) {
                    return 'Non solvable';
                }
                solver.makeStepsBeforeBacktracing();
                // on relance le solveur avec la valeur true car on veur tester un autre résultat qui avait été calculé
                return solver.solve(true);
            }
        }
    },
    // fonction qui renvoie la prochaine cellule à calculer (pour améliorer les perfs)
    speedUpSolve() {
        // console.log('solver.data.emptyCells: ' + solver.data.emptyCells);
        // on déclare une variable dans laquelle on va stocker par ordre les cellules à calculer
        // Vérifier que emptyCell n'est pas vide à moins que ce soit à l'appel de la fonction
        // Calculer chaque cells de emptyCells et stocker le résultat dans un tableau
        // Trier ensuite emptyCells en fct du nb de résultat possible par cellule
        // Si une seule cellule n'a pas de résultat alors retour arrière

        const arrayOfResultsLength = {};

        for (const emptyCell of solver.data.emptyCells) {
            const cellResults = solver.calculateCell(emptyCell);
            // console.log('emptyCell: ' + emptyCell, cellResults, cellResults.length);
            arrayOfResultsLength[emptyCell] = cellResults.length;
            if (cellResults.length === 0) {
                return 'backtracing';
            }
        }
        solver.data.emptyCells.sort((a, b) => {
            return arrayOfResultsLength[a] - arrayOfResultsLength[b]
        });

        return false;
    },
    generator: function () { //générateur de grille non résolue

        // initialisation des arrays
        solver.data.ligne =
            [[0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0]];

        solver.data.column =
            [[0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0]];

        solver.data.square =
            [[0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0]];

        solver.data.emptyCells = [];

        // déclaration d'une fonction de génération de nombre aléatoire
        const randomNumber = (min, max) => {
            return Math.floor(
                Math.random() * (max - min) + min
            );
        };

        // Lancement d'une boucle pour générer plusieurs nombres
        for (let i = 0; i < 20; i++) {
            // Génération de 2 numéros de strings pour simuler une cellule et vérifier qu'elle a pour valeur 0 (sinon elle a déjà été calculée)
            let lig = randomNumber(0, 8).toString();
            let col = randomNumber(0, 8).toString();

            if (solver.data.ligne[lig][col] != 0) {
                while (solver.data.ligne[lig][col] !== 0) {
                    lig = randomNumber(0, 8).toString();
                    col = randomNumber(0, 8).toString();
                }
            }
            // On calcule les possibilités de nombre sur cette cellule
            const cellResults = solver.calculateCell(lig + col);
            const cellResultsLength = cellResults.length;

            // On choisit l'une des valeurs possibles de manière aléatoire
            const randomResult = randomNumber(0, cellResultsLength);
            const cellResult = cellResults[randomResult];

            //on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste
            solver.data.ligne[lig][col] = cellResult;
            solver.data.column[col][lig] = cellResult;
            solver.updateSquare();
        }

        // on va remplir la variable emptyCells
        for (let lig = 0; lig < 9; lig++) {
            for (let col = 0; col < 9; col++) {
                if (solver.data.ligne[lig][col] === 0) {
                    solver.data.emptyCells.push(lig.toString() + col.toString());
                }
            }
        }

        const retour = {
            data: solver.data.ligne,
            empty: solver.data.emptyCells,
        };
        return retour;
    },
    // fonction récursive qui génère une grille aléatoire et essaie de la résoudre, tant qu'il n'y a pas une grille de résolue, la récursion continue
    generatorSupervisor() {
        // Génération d'une grille aléatoire
        // Résolution de la grille aléatoire
        // Beaucoup de grilles ne sont pas solvables. Dans ce cas, le retour est 'Non solvable'
        // On veut itérer le temps d'obtenir une grille solvable avec son résultat

        solver.generator();
        const resultNewBoard = solver.solve(false); //on envoie false car nous ne sommes pas en backtracing

        if (resultNewBoard === 'Non solvable') {
            return solver.generatorSupervisor(); //récursion
        } else {
            return solver.data.ligne;
        }
    },
};

module.exports = solver;
