// eslint-disable-next-line no-redeclare
const app = {

    init: function () {

        console.log('Initialisation');
        app.createForm();
        app.drawBoard();
        app.createStopWatch();


    },

    checkInput: (e) => {
        //regarder si l'utilisateur a coché l'option de checker ses saisies, si oui on exécute la fonction sinon on sort
        const inputCheckOn = document.getElementById('autoCheck').checked; //booléen

        if (inputCheckOn) {

            //chercher un numéro de ID de grille
            const idGrille = document.getElementById('solveBoardBtn').dataset.id;

            //capter l'identifiant de l'input modifié
            const idInput = e.target.id;

            //Création d'une route avec les paramètres Id de Grille et Id de Input
            const route = '/checkInput/' + idGrille + '/' + idInput;
            console.log(route);

            //faire un fetch sur la route
            fetch(route)
                .then(function (response) {

                    const responseTreated = response.json(); //on décrypte la réponse du back
                    return responseTreated;
                })
                .then((response) => {

                    //On compare la solution du back avec la valeur saisie et si c'est mauvais on met en rouge
                    if (response.inputSolution !== Number(e.target.value)) {
                        document.getElementById(idInput).style.backgroundColor = 'red';
                    }
                    else {
                        document.getElementById(idInput).style.backgroundColor = 'lightgrey';
                    }


                });
        }
        else {
            return;
        }

    },

    drawBoard: () => {

        console.log('Generating Board ...');

        //Sélection de main pour y mettre un conteneur pour la grille et le Chronomètre
        const main = document.querySelector('main');
        const boardContainerElt = document.createElement('div');
        boardContainerElt.classList.add('main-content');
        main.appendChild(boardContainerElt);

        //Création d'un élément nommé sudokuBoard

        const sudokuBoard = document.createElement('div');
        sudokuBoard.id = 'sudokuBoard';
        boardContainerElt.appendChild(sudokuBoard);

        //Generating rows and columns inside rows
        for (let i = 0; i < app.boardRows; i++) {

            const divRow = document.createElement('div');
            divRow.classList.add('sudokuRow');
            sudokuBoard.appendChild(divRow);
            divRow.id = 'row' + i;

            for (let j = 0; j < app.boardColumns; j++) {

                const divColumns = document.createElement('div');
                divColumns.classList.add('sudokuColumn');
                divRow.appendChild(divColumns);

                const inputCellElt = document.createElement('input');
                inputCellElt.addEventListener('change', app.checkInput);
                inputCellElt.style.width = app.boardCellSize;
                inputCellElt.style.height = app.boardCellSize;
                const boardCell = divColumns.appendChild(inputCellElt);
                boardCell.id = i.toString() + j.toString();
                boardCell.className = 'sudokValues';
            }
        }
    },

    boardRows: 9,

    boardColumns: 9,

    boardCellSize: '40px',

    level: ['Facile1', 'Facile2', 'Moyen', 'Difficile', 'Démoniaque'],

    createForm: () => {

        console.log('Generating Form ...');

        //Sélection de la zone Main pour y mettre le Formulaire
        const formContainerElt = document.querySelector('main');
        const formElt = document.createElement('form');
        formElt.classList.add('main-form');
        formContainerElt.appendChild(formElt);

        //Création des éléments du formulaire

        //Element Select
        const selectElt = document.createElement('select');
        const labelForSelectElt = document.createElement('label');
        labelForSelectElt.textContent = 'Choisir un exercice';
        labelForSelectElt.setAttribute('for', 'level-selection');
        selectElt.id = 'level-selection';

        app.level.forEach((level) => {
            selectElt.add(new Option(level));

        });

        //Buttons
        const loadExerciceBtnElt = document.createElement('button');
        loadExerciceBtnElt.textContent = 'Charger Exercice';
        loadExerciceBtnElt.addEventListener('click', app.loadExercice);

        const emptyBoardBtnElt = document.createElement('button');
        emptyBoardBtnElt.textContent = 'Vider la grille';
        emptyBoardBtnElt.type = 'button';
        emptyBoardBtnElt.addEventListener('click', app.emptyExercice);

        const solveExerciceBtnElt = document.createElement('button');
        solveExerciceBtnElt.id = 'solveBoardBtn';
        solveExerciceBtnElt.textContent = 'Résoudre la grille';
        solveExerciceBtnElt.addEventListener('click', app.solveExercice);

        //Checkbox option
        const autoCheckInput = document.createElement('input');
        const autoCheckInputLabel = document.createElement('label');
        autoCheckInput.type = 'checkbox';
        autoCheckInput.name = 'autoCheck';
        autoCheckInput.id = 'autoCheck';
        autoCheckInputLabel.setAttribute('for', 'autoCheck');
        autoCheckInputLabel.textContent = 'Auto-Contrôle';


        //Implentation des éléments du formulaire dans le formulaire
        formElt.appendChild(labelForSelectElt);
        formElt.appendChild(selectElt);
        formElt.appendChild(loadExerciceBtnElt);
        formElt.appendChild(emptyBoardBtnElt);
        formElt.appendChild(solveExerciceBtnElt);
        formElt.appendChild(autoCheckInput);
        formElt.appendChild(autoCheckInputLabel);

    },

    emptyExercice: () => {

        //Mettre toute la grille à 0 et enlever l'Id de grille (s'il existe) des dataset du bouton de résolution
        //Remettre les background des input avec la couleur d'origine
        console.log('Emptying Board ...');

        const boardCells = document.querySelectorAll('.sudokValues');
        for (let cell of boardCells) {
            cell.value = '';
            cell.style.backgroundColor = 'lightgrey';
        }

        const solveExerciceBtnElt = document.getElementById('solveBoardBtn');
        const isGrille = solveExerciceBtnElt.dataset.id;

        if (isGrille) {
            solveExerciceBtnElt.removeAttribute('data-id');
        }


    },

    applyDatasToBoard: (data) => {

        //On parcours le tableau reçu dans le paramètre data et on boucle sur les cellules de la board pour les mettre à jour
        //On remet également tous les background à l'origine

        const boardCells = document.querySelectorAll('.sudokValues');
        for (let cell of boardCells) {
            cell.value = '';
            cell.style.backgroundColor = 'lightgrey';
        }

        for (let line = 0; line < 9; line++) {
            for (let column = 0; column < 9; column++) {
                let cell = document.getElementById(line.toString() + column.toString());
                cell.value = data[line][column];



            }
        }

    },

    loadExercice: (e) => {

        e.preventDefault();

        //On met la grille à 0 au cas ou
        app.emptyExercice();

        //on lit la difficulté demandée pour l'envoyer au serveur qui traitera alors une route dynamique
        const level = document.getElementById('level-selection').value;
        const route = 'http://localhost:3000/getBoard/' + level;

        //on fetch une grille avec un niveau de difficulté demandé
        fetch(route)
            .then(function (response) {

                return response.json();
            })
            .then((board) => {

                console.log(`Board ${board.id} loaded`);

                //on récupère un id de grille que l'on stocke dans un dataset du bouton 'Résoudre Grille'
                const solveBoardBtn = document.getElementById('solveBoardBtn');
                solveBoardBtn.dataset.id = board.id;

                app.applyDatasToBoard(board.data);

            });


        //on regarde la sélection de l'exo faite par l'utilisateur pour savoir quoi charger
        // console.log('Loading Board ...');
        // const exerciceSelectorElt = document.getElementById('level-selection');
        // const optionExerciceSelected = exerciceSelectorElt.selectedIndex;
        // const ExerciceChosen = exerciceSelectorElt.options[optionExerciceSelected].value;

        // if (ExerciceChosen == 'Facile1') {

        //     //précharge une grille de closer du 04 au 10 Juin 2021
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-1').value = '';
        //     document.getElementById('0-2').value = 4;
        //     document.getElementById('0-3').value = 6;
        //     document.getElementById('0-4').value = '';
        //     document.getElementById('0-5').value = '';
        //     document.getElementById('0-6').value = '';
        //     document.getElementById('0-7').value = 8;
        //     document.getElementById('0-8').value = '';

        //     document.getElementById('1-0').value = 3;
        //     document.getElementById('0-1').value = '';
        //     document.getElementById('1-2').value = 5;
        //     document.getElementById('0-3').value = '';
        //     document.getElementById('1-4').value = 1;
        //     document.getElementById('0-5').value = '';
        //     document.getElementById('0-6').value = '';
        //     document.getElementById('1-7').value = 6;
        //     document.getElementById('1-8').value = 7;

        //     document.getElementById('2-0').value = 6;
        //     document.getElementById('0-1').value = '';
        //     document.getElementById('0-2').value = '';
        //     document.getElementById('0-3').value = '';
        //     document.getElementById('2-4').value = 5;
        //     document.getElementById('2-5').value = 3;
        //     document.getElementById('2-6').value = 9;
        //     document.getElementById('0-7').value = '';
        //     document.getElementById('0-8').value = '';

        //     document.getElementById('3-0').value = 9;
        //     document.getElementById('0-1').value = '';
        //     document.getElementById('0-2').value = '';
        //     document.getElementById('0-3').value = '';
        //     document.getElementById('3-4').value = 8;
        //     document.getElementById('0-5').value = '';
        //     document.getElementById('0-6').value = '';
        //     document.getElementById('0-7').value = '';
        //     document.getElementById('0-8').value = '';

        //     document.getElementById('0-0').value = '';
        //     document.getElementById('4-1').value = 1;
        //     document.getElementById('0-2').value = '';
        //     document.getElementById('0-3').value = '';
        //     document.getElementById('4-4').value = 2;
        //     document.getElementById('4-5').value = 6;
        //     document.getElementById('4-6').value = 4;
        //     document.getElementById('0-7').value = '';
        //     document.getElementById('0-8').value = '';

        //     document.getElementById('5-0').value = 4;
        //     document.getElementById('0-1').value = '';
        //     document.getElementById('0-2').value = '';
        //     document.getElementById('0-3').value = '';
        //     document.getElementById('0-4').value = '';
        //     document.getElementById('0-5').value = '';
        //     document.getElementById('5-6').value = 5;
        //     document.getElementById('5-7').value = 1;
        //     document.getElementById('0-8').value = '';

        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-1').value = '';
        //     document.getElementById('6-2').value = 6;
        //     document.getElementById('0-3').value = '';
        //     document.getElementById('0-4').value = '';
        //     document.getElementById('6-5').value = 1;
        //     document.getElementById('0-6').value = '';
        //     document.getElementById('0-7').value = '';
        //     document.getElementById('0-8').value = '';

        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-1').value = '';
        //     document.getElementById('7-2').value = 1;
        //     document.getElementById('7-3').value = 7;
        //     document.getElementById('7-4').value = 9;
        //     document.getElementById('0-5').value = '';
        //     document.getElementById('0-6').value = '';
        //     document.getElementById('0-7').value = '';
        //     document.getElementById('7-8').value = 2;

        //     document.getElementById('0-0').value = '';
        //     document.getElementById('8-1').value = 3;
        //     document.getElementById('0-2').value = '';
        //     document.getElementById('0-3').value = '';
        //     document.getElementById('8-4').value = 6;
        //     document.getElementById('8-5').value = 2;
        //     document.getElementById('0-6').value = '';
        //     document.getElementById('8-7').value = 7;
        //     document.getElementById('0-8').value = '';
        // }

        // else if (ExerciceChosen == 'Facile2') {
        //     //précharge une grille de closer du 04 au 10 Juin 2021
        //     document.getElementById('0-0').value = 6;
        //     document.getElementById('0-2').value = 9;
        //     document.getElementById('0-5').value = 5;
        //     document.getElementById('0-7').value = 1;
        //     document.getElementById('1-2').value = 4;
        //     document.getElementById('1-3').value = 3;
        //     document.getElementById('1-4').value = 7;
        //     document.getElementById('1-5').value = 6;
        //     document.getElementById('1-8').value = 2;
        //     document.getElementById('2-0').value = 8;
        //     document.getElementById('2-1').value = 7;
        //     document.getElementById('2-4').value = 1;
        //     document.getElementById('2-7').value = 6;
        //     document.getElementById('3-0').value = 7;
        //     document.getElementById('3-5').value = 9;
        //     document.getElementById('3-7').value = 3;
        //     document.getElementById('3-8').value = 1;
        //     document.getElementById('4-1').value = 9;
        //     document.getElementById('5-0').value = 3;
        //     document.getElementById('5-2').value = 1;
        //     document.getElementById('5-3').value = 5;
        //     document.getElementById('5-5').value = 2;
        //     document.getElementById('6-0').value = 2;
        //     document.getElementById('6-2').value = 3;
        //     document.getElementById('6-6').value = 6;
        //     document.getElementById('6-7').value = 7;
        //     document.getElementById('7-1').value = 6;
        //     document.getElementById('7-4').value = 9;
        //     document.getElementById('7-5').value = 3;
        //     document.getElementById('7-6').value = 1;
        //     document.getElementById('7-8').value = 8;
        //     document.getElementById('8-0').value = 9;
        //     document.getElementById('8-5').value = 1;

        // }

        // else if (ExerciceChosen == 'Moyen') {
        //     //précharge une grille de closer du 04 au 10 Juin 2021
        //     document.getElementById('0-0').value = 4;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-5').value = 6;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-8').value = 7;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('1-3').value = 3;
        //     document.getElementById('1-4').value = 8;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('1-7').value = 6;
        //     document.getElementById('1-8').value = 1;

        //     document.getElementById('0-0').value = '';
        //     document.getElementById('2-1').value = 3;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('2-5').value = 4;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('3-1').value = 2;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('3-5').value = 9;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('3-7').value = 5;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('4-0').value = 3;
        //     document.getElementById('4-1').value = 7;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('4-6').value = 2;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('5-0').value = 1;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('5-2').value = 5;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('5-6').value = 3;
        //     document.getElementById('5-7').value = 4;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('6-3').value = 5;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('6-5').value = 8;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('6-7').value = 9;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('7-1').value = 1;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('7-4').value = 2;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('7-7').value = 8;
        //     document.getElementById('7-8').value = 4;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('8-3').value = 6;
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';
        //     document.getElementById('0-0').value = '';

        // }

        // else if (ExerciceChosen == 'Difficile') {
        //     //précharge une grille de closer du 04 au 10 Juin 2021
        //     document.getElementById('0-1').value = 4;
        //     document.getElementById('0-4').value = 5;
        //     document.getElementById('0-7').value = 9;
        //     document.getElementById('1-2').value = 2;
        //     document.getElementById('1-6').value = 8;
        //     document.getElementById('1-8').value = 5;
        //     document.getElementById('2-1').value = 9;
        //     document.getElementById('2-8').value = 1;
        //     document.getElementById('3-0').value = 8;
        //     document.getElementById('3-3').value = 1;
        //     document.getElementById('3-6').value = 3;
        //     document.getElementById('3-7').value = 4;
        //     document.getElementById('4-1').value = 7;
        //     document.getElementById('4-2').value = 4;
        //     document.getElementById('4-5').value = 8;
        //     document.getElementById('5-8').value = 9;
        //     document.getElementById('6-0').value = 5;
        //     document.getElementById('6-1').value = 1;
        //     document.getElementById('6-3').value = 2;
        //     document.getElementById('7-1').value = 6;
        //     document.getElementById('7-3').value = 3;
        //     document.getElementById('7-6').value = 9;
        //     document.getElementById('8-4').value = 6;
        //     document.getElementById('8-7').value = 7;

        // }

        // else if (ExerciceChosen == 'Démoniaque') {
        //     //précharge une grille de closer du 04 au 10 Juin 2021
        //     document.getElementById('0-2').value = 1;
        //     document.getElementById('0-7').value = 2;
        //     document.getElementById('1-3').value = 8;
        //     document.getElementById('1-5').value = 5;
        //     document.getElementById('1-8').value = 1;
        //     document.getElementById('2-0').value = 5;
        //     document.getElementById('2-3').value = 1;
        //     document.getElementById('2-5').value = 3;
        //     document.getElementById('2-6').value = 4;
        //     document.getElementById('3-1').value = 2;
        //     document.getElementById('3-2').value = 9;
        //     document.getElementById('3-6').value = 7;
        //     document.getElementById('3-7').value = 4;
        //     document.getElementById('5-1').value = 4;
        //     document.getElementById('5-2').value = 6;
        //     document.getElementById('5-6').value = 3;
        //     document.getElementById('5-7').value = 9;
        //     document.getElementById('6-2').value = 2;
        //     document.getElementById('6-3').value = 3;
        //     document.getElementById('6-5').value = 7;
        //     document.getElementById('6-8').value = 4;
        //     document.getElementById('7-0').value = 9;
        //     document.getElementById('7-3').value = 5;
        //     document.getElementById('7-5').value = 1;
        //     document.getElementById('8-1').value = 1;
        //     document.getElementById('8-6').value = 8;

        // }






    },

    createStopWatch: () => {

        console.log('Generating StopWatch ...');

        //Création du Chronomètre dans le conteneur de la grille et du chrono
        const stopWatchContainerElt = document.querySelector('.main-content');
        const stopWatchElt = document.createElement('div');
        stopWatchElt.id = 'stopWatch';
        stopWatchContainerElt.appendChild(stopWatchElt);

        //création d'un paragraphe au sein du Chrono pour y afficher le chrono en cours

        const stopWatchTextElt = document.createElement('p');
        stopWatchTextElt.classList.add('stopWatchText');
        stopWatchTextElt.textContent = 'Chrono:';
        stopWatchElt.appendChild(stopWatchTextElt);

    },

    solveExercice: (e) => {

        e.preventDefault();

        console.log('Bouton "Résoudre Grille activé"');

        //On teste la présence d'un id dans les dataset du bouton solve et si oui on fetch la grille concernée et on l'affiche (route1)
        //si pas de ID présent alors on lance un programme de type solveur (route2)

        const solveBoardBtn = document.getElementById('solveBoardBtn');
        const boardId = solveBoardBtn.dataset.id;
        let route = 'http://localhost:3000/solveBoard/';

        if (boardId) {
            route += boardId;

        }
        else {
            route += 'none';
            //Déclencher le chronomètre si le dataset est à false
            //! ligne à supprimer : 
            app.launchStopWatchCount();
        }

        fetch(route) //on fait une demande au back d'une résolution de gille (connue en base ou non)
            .then(function (response) {

                const responseTreated = response.json(); //on décrypte la réponse du back
                return responseTreated;
            })
            .then((board) => {

                if (typeof board.data === 'string') {
                    console.log(board.data);
                    //TODO mettre un clear interval
                    app.setOffStopWatchCount();

                }
                else {
                    //On affiche les résultats dans la grille
                    console.log(board);
                    app.applyDatasToBoard(board.data);
                    console.log('Results for Board loaded');
                }

            });


    },

    launchStopWatchCount: () => {
        console.log('Début du chronomètre');
        setInterval(app.setOnStopWatchCount, 1000);
    },

    setOffStopWatchCount: function () { clearInterval(app.setOnStopWatchCount) },

    setOnStopWatchCount: function () {
        const stopWatchTextElt = document.querySelector('.stopWatchText');
        var count = 0;
        stopWatchTextElt.textContent = `Chrono: \n ${count}s`;
        count++;
        stopWatchTextElt.textContent = `Chrono: 
        ${count}s`;
    }


};


//Lancement de la génération de la grille

document.addEventListener('DOMContentLoaded', app.init);

