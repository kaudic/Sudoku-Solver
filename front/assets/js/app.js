// eslint-disable-next-line no-redeclare
const app = {

    init: function () {

        console.log('Initialisation');
        app.form.create();
        app.board.draw();

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

    board: {

        draw: function () {

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
            for (let i = 0; i < app.board.rows; i++) {

                const divRow = document.createElement('div');
                divRow.classList.add('sudokuRow');
                sudokuBoard.appendChild(divRow);
                divRow.id = 'row' + i;

                for (let j = 0; j < app.board.columns; j++) {

                    const divColumns = document.createElement('div');
                    divColumns.classList.add('sudokuColumn');
                    divRow.appendChild(divColumns);

                    const inputCellElt = document.createElement('input');
                    inputCellElt.addEventListener('change', app.checkInput);
                    inputCellElt.style.width = app.board.cellSize;
                    inputCellElt.style.height = app.board.cellSize;
                    const boardCell = divColumns.appendChild(inputCellElt);
                    boardCell.id = i.toString() + j.toString();
                    boardCell.className = 'sudokValues';
                }
            }
        },

        rows: 9,

        columns: 9,

        cellSize: '40px',

        read: function () {

            // objectif: créer un objet qui contiendra 4 tableaux avec les chiffres de la grille et les "trous"
            // ligne, columns, square, emptyCells

            //créer l'objet vide
            //récupérer tous les inputs de la grille et itérer sur chacun des éléments 
            //prendre le numéro de ligne et le numéro de colonne de l'élément itéré (voir si nécessaire, on fait un console.log des ID et on voit dans quel sens cela est fait )et enregistrer dans l'objet ligne/colomn/square le chiffre
            //pour le square créer une fonction déportée pour aider: //loadSquare(input itéré) -> remplira le square directement
            //retourne l'objet complet
        }

    },

    stopWatch: {

        count: 0,

        On: null,

        create: () => {
            //on contrôle d'abord si le chrono est déjà présent pour ne pas en créer un 2ème.
            const chrono = document.getElementById('stopWatch');

            if (chrono) { //s'il est présent on stoppe la fonction
                return;
            }

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

        delete: function () {
            const stopWatchElt = document.getElementById('stopWatch');

            if (stopWatchElt) {
                stopWatchElt.remove();
            }


        },

        launch: () => {
            console.log('Début du chronomètre');
            app.stopWatch.On = setInterval(app.stopWatch.setOn, 1000);
        },

        setOff: function () {
            clearInterval(app.stopWatch.On);
            //TODO Faire clignoter le chrono pendant 3 sec en jouant sur le style display (none/block)
            console.log('arrêt chrono');
            app.stopWatch.count = 0;
        },

        setOn: function () {
            const stopWatchTextElt = document.querySelector('.stopWatchText');
            stopWatchTextElt.textContent = `Chrono: \n ${app.stopWatch.count}s`;
            app.stopWatch.count++;
            stopWatchTextElt.textContent = `Chrono: 
        ${app.stopWatch.count}s`;
        }
    },

    form: {

        create: function () {

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

            app.form.level.forEach((level) => {
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

        level: ['Facile1', 'Facile2', 'Moyen', 'Difficile', 'Démoniaque'],

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

        //supprimer le chrono s'il existe
        app.stopWatch.delete();

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

    },


    solveExercice: (e) => {

        e.preventDefault();

        console.log('Bouton "Résoudre Grille activé"');
        const solveBoardBtn = document.getElementById('solveBoardBtn');
        const boardId = solveBoardBtn.dataset.id;
        let route = 'http://localhost:3000/solveBoard/';

        //On teste la présence d'un id dans les dataset du bouton solve et si oui on fetch la grille concernée et on l'affiche (route1)
        if (boardId) {
            route += boardId;

        }
        //si pas de ID présent alors on lance un programme de type solveur (route2)
        else {
            route += 'none';
            //Créer puis Déclencher le chronomètre si le dataset est à false
            app.stopWatch.create();
            app.stopWatch.launch();
        }

        //TODO à cette route, il faudra pouvoir joindre les chiffres présents dans la grille: voir la fonction app.board.read() qui créé l'array avec les valeurs
        fetch(route) //on fait une demande au back d'une résolution de gille (connue en base ou non)
            .then(function (response) {

                const responseTreated = response.json(); //on décrypte la réponse du back
                return responseTreated;
            })
            .then((board) => { //si la réponse du back est une strinh c'est que l'on a reçu 'grille ok' donc il s'agit du solveur
                //TODO sera à modifier car plus tard on recevra un array aussi en retour du solveur

                if (typeof board.solveur === 'string') {
                    console.log(board.data);
                    app.stopWatch.setOff();

                }
                else { //sinon il s'agit d'un array
                    //On affiche les résultats dans la grille
                    console.log(board);
                    app.applyDatasToBoard(board.data);
                    console.log('Results for Board loaded');
                }

            });


    },




};


//Lancement de la génération de la grille

document.addEventListener('DOMContentLoaded', app.init);

