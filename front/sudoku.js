//TODO tout est à tester -> voir comment gérer le fait que l'on fait appel au DOM et à la fonction alert alors qu'on sera côté serveur

const sudoku = {

    boardData: [], //contiendra les données de la grille à chaque lecture
    boardLineData: [], //contiendra les données de la grille en lecture en lignes
    boardColumnData: [], //contiendra les données de la grille en lecture en colonnes
    boardSquareData: [], //contiendra les données de la grille en lecture en carrés
    isBoardOk: false, //passera à true dès lors qu'il y aura une grille html et des données de saisies dedans
    isBoardFinished: false, //passera à true si le solveur a réussi
    nextCellToCalculate: null, //correspond à la prochaine cellule que le solveur doit calculer
    resultCalculated: [],//correspond au résultat du calcul en cours d'une cellule
    lastCellResult: null, //correspond au calcul de la dernière cellule calculée
    lastCellCalculated: null, //correspond à la dernière cellule calculée
    tracingDatas: [], // on enregistre dans cette variable les données utilisées dans le calcul pour s'y retrouver lors de retour arrière
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
                    sudoku.launchBackTracing();

                }

            }
        }


    },

    launchBackTracing: () => {

        console.log('--------------------------');

        sudoku.nextCellToCalculate = sudoku.boardData[0][0]; // dans nextCellule on retrouve les coordonnées de la cellule à calculer, ainsi qu'un chiffre qui sera utilisé pour dire quel n° de résultat sera utilisé
        console.log('Calcul de la cellule: ' + sudoku.nextCellToCalculate);
        sudoku.lastCellCalculated = sudoku.tracingDatas[sudoku.tracingDatas.length - 1]; // on prends en mémoire la cellule précédente au cas ou un retour arrière est nécessaire
        sudoku.resultCalculated = sudoku.calculateCell(sudoku.nextCellToCalculate, sudoku.boardData);
        console.log('Résultat du calcul: ' + sudoku.resultCalculated + ' Longueur du résultat: ' + sudoku.resultCalculated.length);

        if (sudoku.resultCalculated.length == 0) // le résultat du calcul indique qu'il n'y a pas de réponse possible, il faut donc revenir en arrière, sur la cellule précédente et voir si un autre choix 
        //était possible


        {

            console.log('Pas de résultat trouvé pour la cellule ' + sudoku.nextCellToCalculate + '. Retour arrière sur la cellule ' + sudoku.lastCellResult + '.');
            sudoku.goBack = true; // on active le flag retour arrière
            document.getElementById(sudoku.lastCellResult[0]).value = ''; //remettre à 0 dans la grille la valeur de la cellule précédente, afin qu'à la prochaine lecture de grille, 
            //la cellule soit considérée comme vide
            sudoku.tracingDatas.splice(sudoku.tracingDatas.length - 1, 1);//suppression de l'enregistrement de traçabilité de la dernière cellule calculée puisqu'on va la recalculer
            sudoku.boardData = sudoku.readBoard();
            sudoku.lastCellResult = sudoku.lastCellCalculated[1];
            sudoku.launchBackTracing(); //récursivité, on relance la fonction

        }

        else if (sudoku.resultCalculated.length <= (sudoku.lastCellResult + 1) && sudoku.goBack == true) // les résultats ont déjà été testés, il faut faire un retour arrière
        {
            console.log('Les résultats possibles ont déjà été testés. Retour arrière sur la cellule: ' + sudoku.lastCellCalculated);
            sudoku.goBack = true; // on active le flag retour arrière
            document.getElementById(sudoku.lastCellCalculated[0]).value = ''; //remettre à 0 dans la grille la valeur de la cellule précédente, afin qu'à la prochaine lecture de grille, 
            //la cellule soit considérée comme vide
            sudoku.tracingDatas.splice(sudoku.tracingDatas.length - 1, 1);//suppression de l'enregistrement de traçabilité de la dernière cellule calculée puisqu'on va la recalculer
            sudoku.boardData = sudoku.readBoard();
            sudoku.lastCellResult = sudoku.lastCellCalculated[1];
            sudoku.launchBackTracing(); //récursivité, on relance la fonction

        }


        else // plusieurs résultats sont possibles, dans ce cas il faut prendre soit le 1er des résultats (0), soit le résultat précédent incrémenté de 1 car il s'agit d'un retour arrière 
        //(voir si le flag retour arrière est à true/false)

        {

            if (sudoku.goBack == true) {
                console.log('Retour Arrière = ' + sudoku.goBack);
                document.getElementById(sudoku.nextCellToCalculate[0]).value = sudoku.resultCalculated[sudoku.numeroResultUsed + 1];
                console.log('Résultat utilisé: ' + document.getElementById(sudoku.nextCellToCalculate[0]).value);
                sudoku.nextCellToCalculate[1] = sudoku.numeroResultUsed + 1; //on garde en mémoire le num de résultat que l'on a pris

            }
            else {
                console.log('Retour Arrière = ' + sudoku.goBack);
                document.getElementById(sudoku.nextCellToCalculate[0]).value = sudoku.resultCalculated[0];
                console.log('Résultat utilisé: ' + document.getElementById(sudoku.nextCellToCalculate[0]).value);
                sudoku.nextCellToCalculate[1] = 0; // on garde en mémoire que l'on a pris le premier résultat autorisé (0)

            }

            sudoku.tracingDatas.push(sudoku.nextCellToCalculate); // on enregistre en traçabilité la cellule qui vient d'être calculée
            sudoku.boardData = sudoku.readBoard();
            sudoku.isBoardFinished = sudoku.calculateIfBoardFinished();

            if (sudoku.isBoardFinished) // on teste la somme et le nombre de chiffres trouvés sur chaque array (lignes & colonnes) pour savoir si la grille est finie
            {
                alert('Grille terminée');
            }
            else {
                sudoku.numeroResultUsed = 0;
                sudoku.goBack = false;
                sudoku.launchBackTracing(); //récursivité, on relance la fonction
            }
        }
    },

    checkBoard: () => { //remplit sudoku.isBoardOk (true/false) selon si des données existent dans les input

        // on enregistre dans une variable tous les éléments input situés à l'intérieur du tableau grâce à une classe
        let matrice = document.getElementsByClassName('sudokValues');
        let matriceValues = [''];

        // on transfert les valeurs des éléments input à un array
        for (let i = 0; i < matrice.length; i++) {
            matriceValues.push(matrice[i].value);
        }

        if (matriceValues.length > 0) {
            sudoku.isBoardOk = true;
        }
        else {
            sudoku.isBoardOk = false;
        }

        return sudoku.isBoardOk;

    },

    readBoard: () => { //remplit boardData

        //enregistrer dans une matrice nommée "matrice" tous les input du tableau identifiés par une class "sudokValues"
        //enregistrer dans une matrice nommée "matriceVide" tous les ID des input (contenant les coordonnées dans leurs ID)
        //de valeurs nulles, ce qui correspond aux cases à chercher

        var matrice = document.getElementsByClassName('sudokValues');
        var matriceVide = [];

        for (let i = 0; i < matrice.length; i++) {

            if (matrice[i].value == '') {
                matriceVide.push([matrice[i].id, 0]); //le 0 sera remplacé par le nombre de chiffres qui permettra de déterminer les priorités
            }

        }


        // Enregistrement des arrays pour les lignes, des arrays pour les colonnes et des arrays pour les carrés

        //Déclaration des variables
        var Ligne = new Array(8);
        var Colonne = new Array(8);
        var Carré = new Array(8);
        var chiffre = 0;

        //Initialisation des variables (notamment les colonnes)

        for (let i = 0; i < 9; i++) {
            Ligne[i] = new Array(11);
            Ligne[i][9] = 0; //on initialise un total des nombres à 0
            Ligne[i][10] = 0; //on initialise une somme des nombres à 0
            Colonne[i] = new Array(11);
            Colonne[i][9] = 0; //on initialise un total des nombres à 0
            Colonne[i][10] = 0; //on initialise une somme des nombres à 0
            Carré[i] = new Array();
        }



        //Enregistrement des valeurs dans les arrays Ligne, Colonnes et Carrés
        for (let i = 0; i < 81; i++) {
            var ligID = matrice[i].id.toString().substr(0, 1);
            var colID = matrice[i].id.toString().substr(2, 1);

            if (matrice[i].value == '') {
                chiffre = 0;
            }
            else {
                chiffre = parseInt(matrice[i].value);
            }

            Ligne[ligID][colID] = (chiffre);

            //on remplit le nombre de chiffres supérieurs à 0 dans chaque ligne, en colonne 9, et la somme de chaque ligne en colonne 10
            if (Ligne[ligID][colID] > 0) {
                Ligne[ligID][9] += 1;
                Ligne[ligID][10] += Ligne[ligID][colID];
            }

            Colonne[colID][ligID] = (chiffre);

            //on remplit le nombre de chiffres supérieurs à 0 dans chaque ligne, en colonne 9, et la somme de chaque ligne en colonne 10
            if (Colonne[colID][ligID] > 0) {
                Colonne[colID][9] += 1;
                Colonne[colID][10] += Colonne[colID][ligID];
            }

            //Gestion des 9 carrés, cela nécessite l'emploi d'un else if
            if (ligID <= 2 && colID <= 2) {
                Carré[0].push(chiffre);

            }
            else if (ligID <= 2 && colID > 2 && colID <= 5) {
                Carré[1].push(chiffre);
            }
            else if (ligID <= 2 && colID > 5) {
                Carré[2].push(chiffre);
            }
            else if (ligID > 2 && ligID <= 5 && colID <= 2) {
                Carré[3].push(chiffre);
            }
            else if (ligID > 2 && ligID <= 5 && colID > 2 && colID <= 5) {
                Carré[4].push(chiffre);
            }
            else if (ligID > 2 && ligID <= 5 && colID > 5) {
                Carré[5].push(chiffre);
            }
            else if (ligID > 5 && colID <= 2) {
                Carré[6].push(chiffre);
            }
            else if (ligID > 5 && colID > 2 && colID <= 5) {
                Carré[7].push(chiffre);
            }
            else if (ligID > 5 && colID > 5) {
                Carré[8].push(chiffre);
            }

            //fin de la boucle principale
        }

        //on remplit le nombre de chiffres supérieurs à 0 dans chaque ligne, en colonne 9 et la somme en colonne 10
        var nbChiffresCarré = 0;
        var sommeChiffresCarré = 0;

        for (let i = 0; i < 9; i++) {
            nbChiffresCarré = 0;
            sommeChiffresCarré = 0;

            for (let n = 0; n < (Carré[i].length) - 1; n++) {
                if (Carré[i][n] > 0) {
                    nbChiffresCarré += 1;
                    sommeChiffresCarré += Carré[i][n];
                    Carré[i].splice(9, 1, nbChiffresCarré);

                }

            }
            Carré[i].splice(10, 1, sommeChiffresCarré);
        }

        return sudoku.boardData = [matriceVide, Ligne, Colonne, Carré];
    },

    calculateCell: () => {
        //les coordonnées de la cellule se trouvent dans la variable passée en paramètre de la fonction
        //on va parser la variable pour récupérer la ligne et la colonne

        var nombrePossible = [1, 2, 3, 4, 5, 6, 7, 8, 9];
        var lig = sudoku.nextCellToCalculate[0].substr(0, 1);
        var col = sudoku.nextCellToCalculate[0].substr(2, 1);

        //on va boucler sur les matrices Lignes, colonnes et carrés pour supprimer les chiffres déjà présents de la variable nombrePossible
        // dans grille on retrouve dans les positions suivantes: 1:Ligne, 2:colonne, 3:Carré

        var ligne = sudoku.boardData[1];
        var colonne = sudoku.boardData[2];
        var carré = sudoku.boardData[3];

        //on parcourt la ligne et on élimine les chiffres déjà présents
        for (let n = 0; n < ligne[lig].length - 2; n++) {
            if (ligne[lig][n] > 0) {
                var position = nombrePossible.indexOf(ligne[lig][n]);
                if (position !== -1) {
                    nombrePossible.splice(position, 1);
                }
            }
        }

        //on parcourt la colonne et on élimine les chiffres déjà présents
        for (let n = 0; n < colonne[lig].length - 2; n++) {
            if (colonne[col][n] > 0) {
                position = nombrePossible.indexOf(colonne[col][n]);
                if (position !== -1) {
                    nombrePossible.splice(position, 1);
                }
            }
        }

        //on détermine quel carré il faut analyser
        if (lig <= 2 && col <= 2) {
            var numCarré = 0;

        }
        else if (lig <= 2 && col > 2 && col <= 5) {
            numCarré = 1;
        }
        else if (lig <= 2 && col > 5) {
            numCarré = 2;
        }
        else if (lig > 2 && lig <= 5 && col <= 2) {
            numCarré = 3;
        }
        else if (lig > 2 && lig <= 5 && col > 2 && col <= 5) {
            numCarré = 4;
        }
        else if (lig > 2 && lig <= 5 && col > 5) {
            numCarré = 5;
        }
        else if (lig > 5 && col <= 2) {
            numCarré = 6;
        }
        else if (lig > 5 && col > 2 && col <= 5) {
            numCarré = 7;
        }
        else if (lig > 5 && col > 5) {
            numCarré = 8;
        }

        //on parcourt le carré identifié et on élimine les chiffres déjà présents
        for (let n = 0; n < carré[numCarré].length - 2; n++) {
            if (carré[numCarré][n] > 0) {
                position = nombrePossible.indexOf(carré[numCarré][n]);
                if (position !== -1) {
                    nombrePossible.splice(position, 1);
                }
            }
        }

        //Ecrire le résultat dans la cellule
        document.getElementById(lig + '-' + col).focus();

        return nombrePossible;
    },

    calculateIfBoardFinished: () => { //remplit isBoardFinished


        // on récupère les variables lignes, colonnes et carrés
        sudoku.boardLineData = sudoku.boardData[1];
        sudoku.boardColumnData = sudoku.boardData[2];
        sudoku.boardSquareData = sudoku.boardData[3];

        //console.log(grille);

        for (let p = 0; p <= 8; p++) {


            if (sudoku.boardLineData[p][9] == 9 & sudoku.boardColumnData[p][9] == 9 & sudoku.boardSquareData[p][9] == 9) {

                if (sudoku.boardLineData[p][10] == 45 & sudoku.boardColumnData[p][10] == 45 & sudoku.boardSquareData[p][10] == 45) {
                    sudoku.isBoardFinished = true;
                }
                else {
                    sudoku.isBoardFinished = false;
                    return sudoku.isBoardFinished;
                }

            }
            else {
                sudoku.isBoardFinished = false;
                return sudoku.isBoardFinished;
            }
        }

        return sudoku.isBoardFinished;


    },

    loadExercice: () => { //attention la fonction est déjà côté client !
        //au préalable avant de charger l'exo, on remet la grille à 0
        let cases = document.getElementsByClassName('sudokValues');
        for (let i of cases) {
            i.value = '';
        }

        //on regarde la sélection de l'exo faite par l'utilisateur

        let select = document.getElementById('choixExo');
        let choice = select.selectedIndex;
        let valueChoice = select.options[choice].value;

        if (valueChoice == 'Facile1') {

            //précharge une grille de closer du 04 au 10 Juin 2021
            document.getElementById('0-2').value = 4;
            document.getElementById('0-3').value = 6;
            document.getElementById('0-7').value = 8;
            document.getElementById('1-0').value = 3;
            document.getElementById('1-2').value = 5;
            document.getElementById('1-4').value = 1;
            document.getElementById('1-7').value = 6;
            document.getElementById('1-8').value = 7;
            document.getElementById('2-0').value = 6;
            document.getElementById('2-4').value = 5;
            document.getElementById('2-5').value = 3;
            document.getElementById('2-6').value = 9;
            document.getElementById('3-0').value = 9;
            document.getElementById('3-4').value = 8;
            document.getElementById('4-1').value = 1;
            document.getElementById('4-4').value = 2;
            document.getElementById('4-5').value = 6;
            document.getElementById('4-6').value = 4;
            document.getElementById('5-0').value = 4;
            document.getElementById('5-6').value = 5;
            document.getElementById('5-7').value = 1;
            document.getElementById('6-2').value = 6;
            document.getElementById('6-5').value = 1;
            document.getElementById('7-2').value = 1;
            document.getElementById('7-3').value = 7;
            document.getElementById('7-4').value = 9;
            document.getElementById('7-8').value = 2;
            document.getElementById('8-1').value = 3;
            document.getElementById('8-4').value = 6;
            document.getElementById('8-5').value = 2;
            document.getElementById('8-7').value = 7;
        }

        else if (valueChoice == 'Facile2') {
            //précharge une grille de closer du 04 au 10 Juin 2021
            document.getElementById('0-0').value = 6;
            document.getElementById('0-2').value = 9;
            document.getElementById('0-5').value = 5;
            document.getElementById('0-7').value = 1;
            document.getElementById('1-2').value = 4;
            document.getElementById('1-3').value = 3;
            document.getElementById('1-4').value = 7;
            document.getElementById('1-5').value = 6;
            document.getElementById('1-8').value = 2;
            document.getElementById('2-0').value = 8;
            document.getElementById('2-1').value = 7;
            document.getElementById('2-4').value = 1;
            document.getElementById('2-7').value = 6;
            document.getElementById('3-0').value = 7;
            document.getElementById('3-5').value = 9;
            document.getElementById('3-7').value = 3;
            document.getElementById('3-8').value = 1;
            document.getElementById('4-1').value = 9;
            document.getElementById('5-0').value = 3;
            document.getElementById('5-2').value = 1;
            document.getElementById('5-3').value = 5;
            document.getElementById('5-5').value = 2;
            document.getElementById('6-0').value = 2;
            document.getElementById('6-2').value = 3;
            document.getElementById('6-6').value = 6;
            document.getElementById('6-7').value = 7;
            document.getElementById('7-1').value = 6;
            document.getElementById('7-4').value = 9;
            document.getElementById('7-5').value = 3;
            document.getElementById('7-6').value = 1;
            document.getElementById('7-8').value = 8;
            document.getElementById('8-0').value = 9;
            document.getElementById('8-5').value = 1;

        }

        else if (valueChoice == 'Moyen') {
            //précharge une grille de closer du 04 au 10 Juin 2021
            document.getElementById('0-0').value = 4;
            document.getElementById('0-5').value = 6;
            document.getElementById('0-8').value = 7;
            document.getElementById('1-3').value = 3;
            document.getElementById('1-4').value = 8;
            document.getElementById('1-7').value = 6;
            document.getElementById('1-8').value = 1;
            document.getElementById('2-1').value = 3;
            document.getElementById('2-5').value = 4;
            document.getElementById('3-1').value = 2;
            document.getElementById('3-5').value = 9;
            document.getElementById('3-7').value = 5;
            document.getElementById('4-0').value = 3;
            document.getElementById('4-1').value = 7;
            document.getElementById('4-6').value = 2;
            document.getElementById('5-0').value = 1;
            document.getElementById('5-2').value = 5;
            document.getElementById('5-6').value = 3;
            document.getElementById('5-7').value = 4;
            document.getElementById('6-3').value = 5;
            document.getElementById('6-5').value = 8;
            document.getElementById('6-7').value = 9;
            document.getElementById('7-1').value = 1;
            document.getElementById('7-4').value = 2;
            document.getElementById('7-7').value = 8;
            document.getElementById('7-8').value = 4;
            document.getElementById('8-3').value = 6;

        }

        else if (valueChoice == 'Difficile') {
            //précharge une grille de closer du 04 au 10 Juin 2021
            document.getElementById('0-1').value = 4;
            document.getElementById('0-4').value = 5;
            document.getElementById('0-7').value = 9;
            document.getElementById('1-2').value = 2;
            document.getElementById('1-6').value = 8;
            document.getElementById('1-8').value = 5;
            document.getElementById('2-1').value = 9;
            document.getElementById('2-8').value = 1;
            document.getElementById('3-0').value = 8;
            document.getElementById('3-3').value = 1;
            document.getElementById('3-6').value = 3;
            document.getElementById('3-7').value = 4;
            document.getElementById('4-1').value = 7;
            document.getElementById('4-2').value = 4;
            document.getElementById('4-5').value = 8;
            document.getElementById('5-8').value = 9;
            document.getElementById('6-0').value = 5;
            document.getElementById('6-1').value = 1;
            document.getElementById('6-3').value = 2;
            document.getElementById('7-1').value = 6;
            document.getElementById('7-3').value = 3;
            document.getElementById('7-6').value = 9;
            document.getElementById('8-4').value = 6;
            document.getElementById('8-7').value = 7;

        }

        else if (valueChoice == 'Démoniaque') {
            //précharge une grille de closer du 04 au 10 Juin 2021
            document.getElementById('0-2').value = 1;
            document.getElementById('0-7').value = 2;
            document.getElementById('1-3').value = 8;
            document.getElementById('1-5').value = 5;
            document.getElementById('1-8').value = 1;
            document.getElementById('2-0').value = 5;
            document.getElementById('2-3').value = 1;
            document.getElementById('2-5').value = 3;
            document.getElementById('2-6').value = 4;
            document.getElementById('3-1').value = 2;
            document.getElementById('3-2').value = 9;
            document.getElementById('3-6').value = 7;
            document.getElementById('3-7').value = 4;
            document.getElementById('5-1').value = 4;
            document.getElementById('5-2').value = 6;
            document.getElementById('5-6').value = 3;
            document.getElementById('5-7').value = 9;
            document.getElementById('6-2').value = 2;
            document.getElementById('6-3').value = 3;
            document.getElementById('6-5').value = 7;
            document.getElementById('6-8').value = 4;
            document.getElementById('7-0').value = 9;
            document.getElementById('7-3').value = 5;
            document.getElementById('7-5').value = 1;
            document.getElementById('8-1').value = 1;
            document.getElementById('8-6').value = 8;

        }



    }


};
