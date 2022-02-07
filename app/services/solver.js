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
    },
    // passera à true si  tous les chiffres >0 et un total lig/col/squa =45
    boardFinished: function (boardLine, boardColumn, boardSquare) {
        //à écrire

    },

    linesFinished(board = this.data.line) {
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

    tracker: [ //tableau recensent toutes les cellules calculées, chaque cellule est un objet (coordonnées, résultats possibles et résultats testés)
        // {
        //     cellCalculated: [],
        //     possibleResults: [],
        //     testedResults: [] coordonnées des cellules calculées
        // }
    ],

    findSquare: function (lig, col) { //cette fonction trouve le carré concerné à partir du numéro de ligne et de colonne
        let square = '';

        if (lig <= 2 && col <= 2) {
            square = 0;
        }
        else if (lig <= 2 && col > 2 && col <= 5) {
            square = 1;
        }
        else if (lig <= 2 && col > 5) {
            square = 2;
        }
        else if (lig > 2 && lig <= 5 && col <= 2) {
            square = 3;
        }
        else if (lig > 2 && lig <= 5 && col > 2 && col <= 5) {
            square = 4;
        }
        else if (lig > 2 && lig <= 5 && col > 5) {
            square = 5;
        }
        else if (lig > 5 && col <= 2) {
            square = 6;
        }
        else if (lig > 5 && col > 2 && col <= 5) {
            square = 7;
        }
        else if (lig > 5 && col > 5) {
            square = 8;
        }

        return square;
    },

    findcolSquare: function (lig, col) {

        let colSquare = 0;

        if ((lig == 0 || lig == 3 || lig == 6) && col <= 2) {
            colSquare = Number(col);
        }
        else if ((lig == 0 || lig == 3 || lig == 6) && col > 2 && col <= 5) {
            colSquare = Number(col) - 3;
        }
        else if ((lig == 0 || lig == 3 || lig == 6) && col > 5 && col <= 8) {
            colSquare = Number(col) - 6;
        }
        else if ((lig == 1 || lig == 4 || lig == 7) && col <= 2) {
            colSquare = Number(col) + 3;
        }
        else if ((lig == 1 || lig == 4 || lig == 7) && col > 2 && col <= 5) {
            colSquare = Number(col);
        }
        else if ((lig == 1 || lig == 4 || lig == 7) && col > 5 && col <= 8) {
            colSquare = Number(col) - 3;
        }
        else if ((lig == 2 || lig == 5 || lig == 8) && col <= 2 + 6) {
            colSquare = Number(col) + 6;
        }
        else if ((lig == 2 || lig == 5 || lig == 8) && col > 2 && col <= 5) {
            colSquare = Number(col) + 3;
        }
        else if ((lig == 2 || lig == 5 || lig == 8) && col > 5 && col <= 8) {
            colSquare = Number(col);
        }

        return colSquare;

    },

    writeInSquare: function (lig, col, square, result) {

        if ((lig == 0 || lig == 3 || lig == 6) && col <= 2) {
            solver.board.data.square[square][Number(col)] = result;
        }
        else if ((lig == 0 || lig == 3 || lig == 6) && col > 2 && col <= 5) {
            solver.board.data.square[square][Number(col) - 3] = result;
        }
        else if ((lig == 0 || lig == 3 || lig == 6) && col > 5 && col <= 8) {
            solver.board.data.square[square][Number(col) - 6] = result;
        }
        else if ((lig == 1 || lig == 4 || lig == 7) && col <= 2) {
            solver.board.data.square[square][Number(col) + 3] = result;
        }
        else if ((lig == 1 || lig == 4 || lig == 7) && col > 2 && col <= 5) {
            solver.board.data.square[square][Number(col)] = result;
        }
        else if ((lig == 1 || lig == 4 || lig == 7) && col > 5 && col <= 8) {
            solver.board.data.square[square][Number(col) - 3] = result;
        }
        else if ((lig == 2 || lig == 5 || lig == 8) && col <= 2 + 6) {
            solver.board.data.square[square][Number(col) + 6] = result;
        }
        else if ((lig == 2 || lig == 5 || lig == 8) && col > 2 && col <= 5) {
            solver.board.data.square[square][Number(col) + 3] = result;
        }
        else if ((lig == 2 || lig == 5 || lig == 8) && col > 5 && col <= 8) {
            solver.board.data.square[square][Number(col)] = result;
        }

    },
    /**
     *
     * @param {string} Cellcoordinates 2 chiffres qui donne 'ligneColonne'
     */
    calculateCell: function (cellCoordinates) {

        //fonction qui calcule tous les résultats possibles pour une cellule

        //On constitue un tableau de départ qui contient tous les chiffres possibles
        //On supprimera au fur et à mesure les chiffres déjà utilisés
        const possibleResults = [1, 2, 3, 4, 5, 6, 7, 8, 9];

        //On détermine la ligne, la colonne de la cellule à partir de l'argument passé à la fonction
        //On détermine le carré concerné en envoyant ligne et colonne à une fonction déportée
        const ligne = cellCoordinates.substr(0, 1);
        const column = cellCoordinates.substr(1, 1);
        const square = solver.board.findSquare(ligne, column);

        //on créé un array qui concatène tous les chiffres utilisés dans la ligne, la colonne et le carré identifiés
        const usedNumbers = solver.board.data.ligne[ligne].concat(solver.board.data.column[column], solver.board.data.square[square]);

        //On itère sur les chiffres de usedNumbers et on les retire de possibleResults
        usedNumbers.forEach(element => {
            const index = possibleResults.indexOf(element);
            if (index !== -1) {
                possibleResults.splice(index, 1);
            }
        });

        return possibleResults;

    },

    makeStepsBeforeBacktracing: function () {

        //on recherche le dernier élément du tracker

        const trackerLength = solver.board.tracker.length;
        const lastCell = solver.board.tracker[trackerLength - 1];

        //on récupère les num de ligne/colonne/square

        const ligne = lastCell.cellCalculated.substr(0, 1);
        const column = lastCell.cellCalculated.substr(1, 1);
        const square = solver.board.findSquare(ligne, column);

        //on supprime les valeurs de cette cellule dans les data ligne/column et square

        solver.board.data.ligne[ligne][column] = 0;
        solver.board.data.column[column][ligne] = 0;
        solver.board.writeInSquare(ligne, column, square, 0);

        //on ajoute la cellule trouvée dans emptyCells afin qu'elle soit calculée au prochain passage
        solver.board.data.emptyCells.unshift(lastCell.cellCalculated);
        console.log('Prochaine cellule calculée: ' + solver.board.data.emptyCells[0]);

    },

    solveIteration: 0,

    solve: function (backtracing) { //fonction solver récursive

        solver.board.solveIteration += 1; //compteur qui sert à sortir de la fonction avant le plantage (environ 3500 itérations)

        if (solver.board.solveIteration > 3500) {
            solver.board.solveIteration = 0;
            return 'Non solvable';
        }

        console.log('compteur: ' + solver.board.solveIteration);

        console.log('backtracing: ' + backtracing);
        //on regarde si backtracing est à true/false
        //si à true cela veut dire qu'on revient en arrière et donc on ne recalcule pas directement la cellule
        //on va voir si un autre résultat était testable

        if (!backtracing) {

            //La première cellule calculée sera donnée soit par speedUpSolve (renvoie la première cellule qui n'a qu'un seul résultat possible), si speedUpSolve n'en trouve pas, alors on calcule la première cellule vide
            //On calcule cette cellule vide (tous les résultats possibles) à l'aide de la fonction calculateCell

            let nextCell = solver.board.speedUpSolve();

            if (!nextCell) {
                nextCell = solver.board.data.emptyCells[0];
            }

            const cellResults = solver.board.calculateCell(nextCell);

            console.log('Cellule calculée: ' + nextCell);
            console.log('Résultats possibles: ' + cellResults);

            //Si on a plusieurs résultats possibles:

            if (cellResults.length > 0) {
                //On enregistre la cellule calculée, les résultats possibles et le résultat testé (ce sera le premier résultat trouvé) dans le tracker
                //création d'un objet contenant les données de la cellule
                const testedResult = cellResults.shift();
                console.log('on teste le résultat suivant: ' + testedResult);

                const cellTrackerData = {
                    cellCalculated: nextCell,
                    possibleResults: cellResults,
                    testedResults: [testedResult]
                };

                //insertion de l'objet créé dans le tracker
                solver.board.tracker.push(cellTrackerData);

                //on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste
                const ligne = nextCell.substr(0, 1);
                const column = nextCell.substr(1, 1);
                const square = solver.board.findSquare(ligne, column);

                solver.board.data.ligne[ligne][column] = testedResult;
                solver.board.data.column[column][ligne] = testedResult;
                solver.board.writeInSquare(ligne, column, square, testedResult);

                //on enlève les coordonnées de cette cellule du tableau des cellules vides
                const cellToDelete = solver.board.data.emptyCells.findIndex(cell => cell === nextCell);
                solver.board.data.emptyCells.splice(cellToDelete, 1);

                //on vérifie si la grille est terminée avec la méthode isFinished
                const stopSolver = solver.board.isFinished();
                console.log('grille finie ? ' + stopSolver);

                if (stopSolver) {
                    //-> si oui on fait un return pour stopper la fonction (et on ré-initialise le tracker)
                    solver.board.tracker = []; //si besoin faire une boucle avec du shift pour shooter les éléments un par un
                    const solverResponse = solver.board.data.ligne;
                    solver.board.solveIteration = 0; //remise à 0 du compteur car c'est la fin de la fonction
                    return solverResponse;

                }
                else {
                    //-> si non alors on relancer solver avec la valeur false pour aller sur la cellule suivante
                    // par contre par sécurité on vérifie quand même qu'il reste une cellule vide dans emptyCells
                    //si ce n'est pas le cas, il y a forcément une erreur (la grille n'est pas réalisable)
                    // console.log(solver.board.data.ligne);
                    if (solver.board.data.emptyCells.length === 0) {
                        console.log('il n\'y a plus de cellules vides, la grille n\'a pas de solution');
                        return 'Non solvable';
                    }
                    else {

                        return solver.board.solve(false);
                    }

                }

            }
            else {
                //on a pas trouvé de résultat sur la cellule en cours donc il faut revenir en arrière
                console.log('Pas de résultat possible');

                if (solver.board.tracker.length === 0) {
                    console.log('Pas de retour arrière possible non plus, la grille n\'a pas de solution');
                    return 'Non solvable';
                }

                solver.board.makeStepsBeforeBacktracing();

                //on relance le solveur avec la valeur true (récursivité)
                return solver.board.solve(true);


            }
        }
        else {

            //on est là car le solveur a été relancé avec la valeur true. On recherche dans le tracker la première cellule de emptyCells (il faut y tester un autre résultat car il s'agit d'un retour arrière)
            const ligne = solver.board.data.emptyCells[0].substr(0, 1);
            const column = solver.board.data.emptyCells[0].substr(1, 1);
            console.log('On va calculer la cellule: ' + ligne + column);

            const cell = solver.board.tracker.find((element) => {
                return (element.cellCalculated) === (ligne + column);
            });

            if (!cell) {
                console.log('Erreur de backtracing, la cellule n\'a pas été trouvée'); //on a pas retrouvé la cellule ce n'est pas normal donc arrêt de la fonction avec un log
                solver.board.solveIteration = 0;
                return;
            }

            //on a trouvé la cellule donc on regarde s'il y avait d'autres résultats possibles.
            console.log('Autres résultats possibles sur ce retour arrière: ' + JSON.stringify(cell));

            if (cell.possibleResults.length > 0) {
                //Si oui on va tester un des autres résultats non testés encore
                const testedResult = cell.possibleResults.shift();

                cell.testedResults.push(testedResult);
                console.log('On teste le résultat suivant: ' + testedResult);

                //on relance le solveur avec la valeur false
                //! on devrait pouvoir factoriser car j'ai fait un copié/collé
                //on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste
                const ligne = solver.board.data.emptyCells[0].substr(0, 1);
                const column = solver.board.data.emptyCells[0].substr(1, 1);
                const square = solver.board.findSquare(ligne, column);

                solver.board.data.ligne[ligne][column] = testedResult;
                solver.board.data.column[column][ligne] = testedResult;
                solver.board.writeInSquare(ligne, column, square, testedResult);

                //on enlève les coordonnées de cette cellule du tableau des cellules vides
                solver.board.data.emptyCells.shift();
                return solver.board.solve(false);
            }
            else {

                //s'il n'y a pas de résultat possible alors il faut remove la cell du track
                const deletedCell = solver.board.tracker.pop();
                // solver.board.data.emptyCells.pop();
                console.log('Pas d\'autres résultats possibles, suppression cellule: ' + JSON.stringify(deletedCell));

                if (solver.board.tracker.length === 0) {
                    console.log('Pas de retour arrière possible non plus, la grille n\'a pas de solution');
                    return 'Non solvable';
                }

                solver.board.makeStepsBeforeBacktracing();

                //on relance le solveur avec la valeur true car on veur tester un autre résultat qui avait été calculé
                return solver.board.solve(true);

            }

        }
    },

    speedUpSolve: function () { //fonction qui renvoie la prochaine cellule à calculer (pour améliorer les perfs)

        // on déclare une variable dans laquelle on va stocker par ordre les cellules à calculer

        // Vérifier que emptyCell n'est pas vide à moins que ce soit à l'appel de la fonction

        //Calculer chaque cells de emptyCells
        for (const emptyCell of solver.board.data.emptyCells) {
            const cellResults = solver.board.calculateCell(emptyCell);
            const cellResultsLength = cellResults.length;

            if (cellResultsLength === 1) {
                console.log('prochaine cellule conseillée: ' + emptyCell);
                return emptyCell;
            }

        }
        return false;

    },

    generator: function () { //générateur de grille non résolue

        //initialisation des arrays
        solver.board.data.ligne =
            [[0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0]];

        solver.board.data.column =
            [[0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0]];

        solver.board.data.square =
            [[0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0]];

        solver.board.data.emptyCells = [];

        //déclaration d'une fonction de génération de nombre aléatoire
        const randomNumber = (min, max) => {
            return Math.floor(
                Math.random() * (max - min) + min
            );
        };

        //Lancement d'une boucle pour générer plusieurs nombres

        for (let i = 0; i < 20; i++) {

            //Génération de 2 numéros de strings pour simuler une cellule et vérifier qu'elle a pour valeur 0 (sinon elle a déjà été calculée)
            let lig = randomNumber(0, 8).toString();
            let col = randomNumber(0, 8).toString();
            console.log('cellule aléatoire proposée: ' + lig + col);
            console.log('Valeur courante de la cellule: ' + solver.board.data.ligne[lig][col]);

            if (solver.board.data.ligne[lig][col] != 0) {
                console.log('Cellule aléatoire non valide, génération d\'une nouvelle cellule');

                while (solver.board.data.ligne[lig][col] !== 0) {
                    lig = randomNumber(0, 8).toString();
                    col = randomNumber(0, 8).toString();
                }
            }
            console.log('cellule aléatoire validée: ' + lig + col);

            //On calcule les possibilités de nombre sur cette cellule
            const cellResults = solver.board.calculateCell(lig + col);
            const cellResultsLength = cellResults.length;
            console.log('longueur de résultat: ' + cellResultsLength);

            //On choisit l'une des valeurs possibles de manière aléatoire
            const randomResult = randomNumber(0, cellResultsLength);
            const cellResult = cellResults[randomResult];
            console.log('on applique la valeur: ' + cellResult);


            //on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste

            const square = solver.board.findSquare(lig, col);
            solver.board.data.ligne[lig][col] = cellResult;
            solver.board.data.column[col][lig] = cellResult;
            solver.board.writeInSquare(lig, col, square, cellResult);
        }

        //on va remplir la variable emptyCells

        for (let lig = 0; lig < 9; lig++) {
            for (let col = 0; col < 9; col++) {
                if (solver.board.data.ligne[lig][col] === 0) {
                    solver.board.data.emptyCells.push(lig.toString() + col.toString());
                }
            }
        }

        console.log(solver.board.data.ligne);
        console.log(solver.board.data.emptyCells);

        const retour = {
            data: solver.board.data.ligne,
            empty: solver.board.data.emptyCells,
        };

        return retour;
    },

    generatorSupervisor: function () { //fonction récursive qui génère une grille aléatoire et essaie de la résoudre, tant qu'il n'y a pas une grille de résolue, la récursion continue

        //Génération d'une grille aléatoire
        //Résolution de la grille aléatoire
        //Beaucoup de grilles ne sont pas solvables. Dans ce cas, le retour est 'Non solvable'
        //On veut itérer le temps d'obtenir une grille solvable avec son résultat

        solver.board.generator();

        const resultNewBoard = solver.board.solve(false); //on envoie false car nous ne sommes pas en backtracing

        if (resultNewBoard === 'Non solvable') {
            return solver.board.generatorSupervisor(); //récursion
        } else {
            return solver.board.data.ligne;
        }

    },

};

module.exports = solver;
