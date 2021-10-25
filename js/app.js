const app = {

    init: function () {

        console.log('Initialisation');
        app.createForm();
        app.drawBoard();
        app.createStopWatch();


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
                inputCellElt.style.width = app.boardCellSize;
                inputCellElt.style.height = app.boardCellSize;
                const boardCell = divColumns.appendChild(inputCellElt);
                boardCell.id = i + '-' + j;
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
        emptyBoardBtnElt.addEventListener('click', app.emptyExercice);

        const solveExerciceBtnElt = document.createElement('button');
        solveExerciceBtnElt.textContent = 'Résoudre la grille';
        solveExerciceBtnElt.addEventListener('click', app.solveExercice);


        //Implentation des éléments du formulaire dans le formulaire
        formElt.appendChild(labelForSelectElt);
        formElt.appendChild(selectElt);
        formElt.appendChild(loadExerciceBtnElt);
        formElt.appendChild(emptyBoardBtnElt);
        formElt.appendChild(solveExerciceBtnElt);

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

    loadExercice: () => {
        //mettre le code de chargerExercice ici
    },

    emptyExercice: () => {
        //mettre le code de  ici
    },

    solveExercice: (e) => {

        e.preventDefault();

        console.log('Bouton \"Résoudre Grille activé\"')

        //Déclencher le chronomètre
        app.launchStopWatchCount();

        //mettre le code du solveur

        setTimeout(() => {
            for (let i = 0; i < 1000000; i++)
                console.log('Démarrage du solveur' + i);
        }, 3000);

    },

    launchStopWatchCount: () => {
        console.log('Début du chronomètre');
        const stopWatchTextElt = document.querySelector('.stopWatchText');
        var count = 0;

        stopWatchTextElt.textContent = `Chrono: \n ${count}s`;

        setInterval(() => {
            count++;
            stopWatchTextElt.textContent = `Chrono: 
        ${count}s`;

        }, 1000);
    }

};


//Lancement de la génération de la grille

document.addEventListener('DOMContentLoaded', app.init);

