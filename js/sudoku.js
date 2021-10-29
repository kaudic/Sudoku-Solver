const sudoku = {

    boardData: null, //contiendra les données de la grille à chaque lecture

    isBoardOk: false, //passera à true dès lors qu'il y aura une grille html et des données de saisies dedans

    isBoardFinished: false, //passera à true si le solveur a réussi

    nextCellToCalculate: null, //correspond à la prochaine cellule que le solveur doit calculer

    lastCellResult: null, //correspond au calcul de la dernière cellule calculée

    numeroResultUsed: 0, // lors du backtracing il correspond au numéro de résultat utilisé parmis les choix possibles

    goBack: false, // lors du backtracing il corresponds au besoin ou non de faire un retour arrière

    initialSolveBoard: () => {

        sudoku.isBoardOk = sudoku.checkBoard(); //vérifie la présence d'une grille html & vérifie qu'il y a des chiffres de renseignés dans la grille

        if (sudoku.isBoardOk) {
            sudoku.boardData = sudoku.readBoard(); //on lit et on retourne un tableau 0: matrice vide, 1:Ligne, 2:colonne, 3:Carré

            // TODO améliorer le système de 20 boucles en ayant un programme qui s'arrête de boucler automatiquement
            for (let m = 0; m <= 20; m++) // on fait 20 boucles de calcul (chiffre qui peut être adapté)
            {

                for (let z = 0; z < sudoku.boardData[0].length; z++) {

                    sudoku.nextCellToCalculate = sudoku.boardData[0][z];

                    sudoku.lastCellResult = sudoku.calculateCell(sudoku.nextCellToCalculate, sudoku.boardData);

                    if (sudoku.lastCellResult.length == 1) {
                        const cell = document.getElementById(sudoku.nextCellToCalculate[0]);
                        cell.value = sudoku.lastCellResult[0];

                    }

                }
                sudoku.boardData = sudoku.readBoard();

                sudoku.isBoardFinished = sudoku.calculateIfBoardFinished(sudoku.boardData);

                if (sudoku.isBoardFinished) {
                    alert('Grille Terminée!');
                    return; //! ajout de ma part
                }
                else {
                    // si après 20 boucles la grille est non résolue alors on lance la fonction backtracing 
                    //avec le paramètre x=0 pour dire que l'on prendra le 1er résultat possible et qu'il ne s'agit pas d'un retour arrière

                    //reject("Résolution simple échoue. Début Bactracing");
                    console.log('Fin des 20 boucles: début du solveur bactracing.');
                    sudoku.solveBoard(); //! j'ai créé une deuxième fonction par doute 

                }

            }
        }


    },

    launchBackTracing: () => {

    },

    solveBoard: () => { //Résolution finale à contrario de la résolution initiale qui correspond aux 20 boucles

    },

    checkBoard: () => { //remplit sudoku.isBoardOk

    },

    readBoard: () => { //remplit boardData

    },

    calculateCell: () => {

    },

    calculateIfBoardFinished: () => {

    },

    loadExercice: () => {

    }


};
