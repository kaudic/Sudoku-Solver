const solver = {

    board: {
        data: {

            line: [], //contiendra les données de la grille en lecture en lignes
            column: [], //contiendra les données de la grille en lecture en colonnes
            square: [], //contiendra les données de la grille en lecture en carrés
            emptyCells: [], //tableau des cellules vides, leurs coordonnées (le premier enregistrement est la prochaine cellule à être calculée)
        },

        isFinished: function () {//passera à true si le solveur a réussi: tous les chiffres >0 et un total par ligne/colonne/square de xx

        },

        tracker: [ //tableau recensent toutes les cellules calculées, chaque cellule est un objet (coordonnées, résultats possibles et résultats testés)
            {
                cellCalculated: [],
                possibleResults: [],
                testedResults: [] //coordonnées des cellules calculées
            }
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

        solve: function () { //fonction solver récursive

            //initialisation du tracker

            solver.board.tracker = [
                {
                    cellCalculated: [],
                    possibleResults: [],
                    testedResults: []
                }
            ];

            //On prends la première cellule vide dans [emptyCells]
            //On calcule cette cellule vide (tous les résultats possibles) à l'aide de la fonction calculateCell

            const cellResults = solver.board.calculateCell(solver.board.data.emptyCells[0]);

            //Si on a plusieurs résultats possibles:

            if (cellResults.length > 0) {
                //On enregistre la cellule calculée, les résultats possibles et le résultat testé (ce sera le premier résultat trouvé) dans le tracker

                //TODO retrouver dans solver.app.tracker à l'aide de find la cellule calculée
                //TODO si on la trouve alors on modifie les propriétés de la cellule 
                //TODO si on ne la trouve pas, il faut la créer et l'ajouter dans solver.app.tracker comme ci-dessous

                // const cell = {
                //     cellCalculated: [solver.board.data.emptyCells[0]],
                //     possibleResults: [cellResults], //TODO attention ici il faudra enlever de cellResults le résultat testé
                //     testedResults: [cellResults[0]]
                // };

                //on enlève les coordonnées de cette cellule du tableau des cellules vides
                solver.board.data.emptyCells.shift();

                //on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste


                //on vérifie si la grille est terminée avec la méthode isFinished 
                //-> si oui on fait un return pour stopper la fonction
                //-> si non on relance le solveur (récursivité)
            }
            else {
                //S'il n'y a pas de solution trouvée, cela signifie qu'il faut revenir en arrière sur les choix effectués

                //BOUCLE
                //On regarde dans le tracker la dernière cellule qui a été calculée et on voit s'il reste des résultats possibles

                //Si on a au moins encore 1 résultat possible alors:
                //On met à jour le tracker : résultats possibles, résultats testés
                //on met à jour board.data (ligne/colonne/square) avec la valeur que l'on teste à la place de l'ancienne
                //on vérifie si la grille est terminée avec la méthode isFinished
                //-> si oui on fait un return pour stopper la fonction
                //-> si non on relance le solveur (récursivité)

                //Si on a pas d'autres résultats possibles dans le tracker pour la cellule précédente
                //On supprime du tracker la référence précédente
                //on supprime de board.data (ligne/colonne/square) la valeur qui n'était pas bonne
                //on remplit emptyCells avec la cellule car elle redevient vide
                //TODO on retourne sur boucle - voir comment faire (s'agit-il d'une fonction? ou d'une boucle while ?)
            }



            for (let i = 0; i < 50000; i++) {
                // console.log(i);
            }

            return solver.board.data.ligne;
        },

        speedUpSolve: function () { //fonction qui résous quelques cellules pour lesquelles il n'y avait qu'un seul résultat possible

        },
    }
};

module.exports = solver;