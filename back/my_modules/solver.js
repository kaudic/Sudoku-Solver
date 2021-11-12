const { application } = require("express");

const solver = {

    board: {
        data: {

            line: [], //contiendra les données de la grille en lecture en lignes
            column: [], //contiendra les données de la grille en lecture en colonnes
            square: [], //contiendra les données de la grille en lecture en carrés
            emptyCells: [], //tableau des cellules vides, leurs coordonnées (le premier enregistrement est la prochaine cellule à être calculée)
        },

        isFinished: function () {//passera à true si le solveur a réussi: tous les chiffres >0 et un total par ligne/colonne/square de xx

            let boardOK = false;
            let totalLigne, totalColumn, totalSquare = 0;

            for (const element of solver.board.data.ligne) {
                totalLigne += element;
                if (element === 0) {
                    boardOK = false;
                    return boardOK;
                }
            }

            for (const element of solver.board.data.column) {
                totalColumn += element;
                if (element === 0) {
                    boardOK = false;
                    return boardOK;
                }
            }

            for (const element of solver.board.data.square) {
                totalSquare += element;
                if (element === 0) {
                    boardOK = false;
                    return boardOK;
                }
            }

            if (totalLigne !== 45 || totalColumn !== 45 || totalSquare !== 45) {
                boardOK = false;
                return boardOK;
            }

            boardOK = true;
            return boardOK;


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
            //on écrit des 0 dans la board sur la dernière cellule pour ne pas fausser le prochain calcul //A FACTO
            const ligne = solver.board.data.emptyCells[0].substr(0, 1);
            const column = solver.board.data.emptyCells[0].substr(1, 1);
            const square = solver.board.findSquare(ligne, column);

            solver.board.data.ligne[ligne][column] = 0;
            solver.board.data.column[column][ligne] = 0;
            solver.board.writeInSquare(ligne, column, square, 0);

            //il faut aller sur celle d'avant. On enlève alors de emptyCells la cellule d'avant
            solver.board.data.emptyCells.shift();

            //on l'enlève aussi du tracker
            const cellIndex = solver.board.tracker.findIndex((element) => {
                return (element.cellCalculated) === (ligne + column);
            });
            solver.board.tracker.splice(cellIndex, 1);
        },

        solve: function (backtracing) { //fonction solver récursive

            console.log('backtracing: ' + backtracing);
            //on regarde si backtracing est à true/false
            //si à true cela veut dire qu'on revient en arrière et donc on ne recalcule pas directement la cellule
            //on va voir si un autre résultat était testable

            if (!backtracing) {

                //On prends la première cellule vide dans [emptyCells]
                //On calcule cette cellule vide (tous les résultats possibles) à l'aide de la fonction calculateCell

                const cellResults = solver.board.calculateCell(solver.board.data.emptyCells[0]);

                console.log('Cellule calculée: ' + solver.board.data.emptyCells[0]);
                console.log('Résultats possibles: ' + cellResults);

                //Si on a plusieurs résultats possibles:

                if (cellResults.length > 0) {
                    //On enregistre la cellule calculée, les résultats possibles et le résultat testé (ce sera le premier résultat trouvé) dans le tracker
                    //création d'un objet contenant les données de la cellule
                    const testedResult = cellResults.shift();

                    const cellTrackerData = {
                        cellCalculated: solver.board.data.emptyCells[0],
                        possibleResults: cellResults,
                        testedResults: [testedResult]
                    };

                    //insertion de l'objet créé dans le tracker
                    solver.board.tracker.push(cellTrackerData);

                    //on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste
                    const ligne = solver.board.data.emptyCells[0].substr(0, 1);
                    const column = solver.board.data.emptyCells[0].substr(1, 1);
                    const square = solver.board.findSquare(ligne, column);

                    solver.board.data.ligne[ligne][column] = testedResult;
                    solver.board.data.column[column][ligne] = testedResult;
                    solver.board.writeInSquare(ligne, column, square, testedResult);
                    console.log(solver.board.data.square[0]);

                    //on enlève les coordonnées de cette cellule du tableau des cellules vides
                    solver.board.data.emptyCells.shift();

                    //on vérifie si la grille est terminée avec la méthode isFinished 
                    const stopSolver = solver.board.isFinished();
                    console.log('grille finie ? ' + stopSolver);

                    if (stopSolver) {
                        //-> si oui on fait un return pour stopper la fonction (et on ré-initialise le tracker)
                        solver.board.tracker = []; //si besoin faire une boucle avec du shift pour shooter les éléments un par un
                        return solver.board.data.ligne;
                    }
                    else {
                        //-> si non alors on relancer solver avec la valeur false pour aller sur la cellule suivante
                        // console.log(solver.board.data.ligne);
                        solver.board.solve(false);
                    }

                }
                else {
                    //on a pas trouvé de résultat sur la cellule en cours donc il faut revenir en arrière

                    solver.board.makeStepsBeforeBacktracing();

                    //on relance le solveur avec la valeur true (récursivité)
                    solver.board.solve(true);

                }
            }
            else {
                //on est là car le solveur a été relancé avec la valeur true. On recherche dans le tracker la première cellule de emptyCells (il faut y tester un autre résultat car il s'agit d'un retour arrière)
                const ligne = solver.board.data.emptyCells[0].substr(0, 1);
                const column = solver.board.data.emptyCells[0].substr(1, 1);
                const cell = solver.board.tracker.find((element) => {
                    return (element.cellCalculated) === (ligne + column);
                });

                if (!cell) {
                    console.log('Erreur de backtracing, la cellule n\'a pas été trouvée'); //on a pas retrouvé la cellule ce n'est pas normal donc arrêt de la fonction avec un log
                    return;
                }

                //on a trouvé la cellule donc on regarde s'il y avait d'autres résultats possibles.

                if (cell.possibleResults.length > 0) {
                    //Si oui on va tester un des autres résultats non testés encore
                    const testedResult = cell.possibleResults.shift();
                    cell.testedResults.push(testedResult);
                    console.log(solver.board.tracker);
                    //on relance le solveur avec la valeur false
                    solver.board.solve(false);
                }
                else {

                    solver.board.makeStepsBeforeBacktracing();

                    //on relance le solveur avec la valeur true car on veur tester un autre résultat qui avait été calculé
                    solver.board.solve(true);

                }


            }
        },



        speedUpSolve: function () { //fonction qui résous quelques cellules pour lesquelles il n'y avait qu'un seul résultat possible

        },
    }
};

module.exports = solver;