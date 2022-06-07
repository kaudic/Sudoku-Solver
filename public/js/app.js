// eslint-disable-next-line no-redeclare
const app = {

    init() {
        console.log('Initialisation');
        app.form.create();
        app.board.draw();
    },
    isValid(e) {
        // On met la zone de message d'erreur à vide (au cas ou)
        app.emptyErrorMessage();

        // on récupère la valeur saisie, la ligne, la colonne et le carré concerné
        const userValue = (e.target.value);
        const idInput = e.target.id;
        const lig = idInput.substr(0, 1);
        const col = idInput.substr(1, 1);
        const square = app.board.findSquare(lig, col);

        // première vérification: s'assurer que le chiffre est compris entre 1 et 9 inclus

        if ((userValue < 1 || userValue > 9) && userValue !== '') {
            e.target.value = '';
            e.target.select();
            // On affiche un message d'erreur dans la zone prévue
            const messageErrorElt = document.getElementById('errorMessage');
            messageErrorElt.textContent = `La valeur ${userValue} est refusée. Il faut saisir des chiffres entre 1 et 9.`;
            return;
        }

        // besoin d'un switch pour déterminer en fonction du carré quelles lignes et colonnes doivent être checkées

        let squareMinLig = 0;
        let squareMaxLig = 0;
        let squareMinCol = 0;
        let squareMaxCol = 0;

        switch (square) {
            case 0:
                squareMinLig = 0;
                squareMaxLig = 2;
                squareMinCol = 0;
                squareMaxCol = 2;
                break;
            case 1:
                squareMinLig = 0;
                squareMaxLig = 2;
                squareMinCol = 3;
                squareMaxCol = 5;
                break;
            case 2:
                squareMinLig = 0;
                squareMaxLig = 2;
                squareMinCol = 6;
                squareMaxCol = 8;
                break;
            case 3:
                squareMinLig = 3;
                squareMaxLig = 5;
                squareMinCol = 0;
                squareMaxCol = 2;
                break;
            case 4:
                squareMinLig = 3;
                squareMaxLig = 5;
                squareMinCol = 3;
                squareMaxCol = 5;
                break;
            case 5:
                squareMinLig = 3;
                squareMaxLig = 5;
                squareMinCol = 6;
                squareMaxCol = 8;
                break;
            case 6:
                squareMinLig = 6;
                squareMaxLig = 8;
                squareMinCol = 0;
                squareMaxCol = 2;
                break;
            case 7:
                squareMinLig = 6;
                squareMaxLig = 8;
                squareMinCol = 3;
                squareMaxCol = 5;
                break;
            case 8:
                squareMinLig = 6;
                squareMaxLig = 8;
                squareMinCol = 6;
                squareMaxCol = 8;
                break;
        }

        // on récupère toutes les valeurs de input
        const inputCells = document.getElementsByClassName('sudokValues');

        // on cherche si la valeur existe déjà dans les lignes, colonnes et carrés
        for (const cell of inputCells) {
            const cellLig = cell.id.substr(0, 1);
            const cellCol = cell.id.substr(1, 1);

            if ((cellLig === lig && cellCol !== col) || (cellCol === col && cellLig !== lig) || (cellLig >= squareMinLig && cellLig <= squareMaxLig && cellCol >= squareMinCol && cellCol <= squareMaxCol && cellLig !== lig && cellCol !== col)) {
                if (cell.value === userValue && cell.value != '') {
                    // si oui, on efface la valeur et on met un alerte
                    e.target.value = '';
                    e.target.select();

                    // On affiche un message d'erreur dans la zone prévue
                    const messageErrorElt = document.getElementById('errorMessage');
                    messageErrorElt.textContent = `La valeur ${userValue} n'est pas possible. Valeur déjà présente.`;
                    return;
                }
            }
        }
    },
    checkInput: (e) => {
        // On met la zone de message d'erreur à vide (au cas ou)
        app.emptyErrorMessage();

        // regarder si l'utilisateur a coché l'option de checker ses saisies, si oui on exécute la fonction sinon on sort
        const inputCheckOn = document.getElementById('autoCheck').checked; // booléen

        if (inputCheckOn) {
            // chercher un numéro de ID de grille
            const idGrille = document.getElementById('solveBoardBtn').dataset.id;

            // capter l'identifiant de l'input modifié
            const idInput = e.target.id;

            // Création d'une route avec les paramètres Id de Grille et Id de Input
            const route = `/api/board/checkInput/${idGrille}/${idInput}`;
            console.log(route);

            // faire un fetch sur la route
            fetch(route)
                .then((response) => {
                    const responseTreated = response.json(); // on décrypte la réponse du back
                    return responseTreated;
                })
                .then((response) => {
                    const userAttempt = Number(e.target.value);
                    // On compare la solution du back avec la valeur saisie et si c'est mauvais on met en rouge
                    // et On affiche un message d'erreur dans la zone prévue
                    if (response.inputSolution !== userAttempt) {
                        document.getElementById(idInput).style.backgroundColor = 'red';
                        const messageErrorElt = document.getElementById('errorMessage');
                        messageErrorElt.textContent = `La valeur ${userAttempt} n'est pas la bonne solution.`;
                        document.getElementById(idInput).value = userAttempt;
                    } else {
                        document.getElementById(idInput).style.backgroundColor = 'lightgrey';
                    }
                });
        } else {

        }
    },
    board: {
        draw() {
            console.log('Generating Board ...');

            // Sélection de main pour y mettre un conteneur pour la grille et le Chronomètre
            const main = document.querySelector('main');
            const boardContainerElt = document.createElement('div');
            boardContainerElt.classList.add('main-content');
            main.appendChild(boardContainerElt);

            // Création d'un élément nommé sudokuBoard
            const sudokuBoard = document.createElement('div');
            sudokuBoard.id = 'sudokuBoard';
            boardContainerElt.appendChild(sudokuBoard);

            // Generating rows and columns inside rows
            for (let i = 0; i < app.board.rows; i++) {
                const divRow = document.createElement('div');
                divRow.classList.add('sudokuRow');
                sudokuBoard.appendChild(divRow);
                divRow.id = `row${i}`;

                for (let j = 0; j < app.board.columns; j++) {
                    const divColumns = document.createElement('div');
                    divColumns.classList.add('sudokuColumn');
                    divRow.appendChild(divColumns);

                    const inputCellElt = document.createElement('input');
                    const labelForInputCellElt = document.createElement('label');
                    inputCellElt.addEventListener('change', app.checkInput);
                    inputCellElt.addEventListener('change', app.isValid);

                    const boardCell = divColumns.appendChild(inputCellElt);
                    const boardLabel = divColumns.appendChild(labelForInputCellElt);
                    boardLabel.setAttribute("for", i.toString() + j.toString());
                    boardLabel.textContent = 'Cellule ' + i.toString() + j.toString();
                    boardLabel.classList.add('visually-hidden');
                    boardCell.id = i.toString() + j.toString();
                    boardCell.className = 'sudokValues';
                }
            }

            // Création d'une zone HTML pour y mettre le message d'erreur
            const messageErreurElt = document.createElement('p');
            messageErreurElt.className = 'errorMessage';
            messageErreurElt.id = 'errorMessage';

            // Sélection d'une zone pour insertion du message d'erreur
            const sudokBoardElt = document.getElementById('sudokuBoard');
            sudokBoardElt.appendChild(messageErreurElt);
        },
        rows: 9,
        columns: 9,
        cellSize: '40px',
        data: {
            emptyCells: [],
            ligne: [[], [], [], [], [], [], [], [], []],
            column: [[], [], [], [], [], [], [], [], []],
            square: [[], [], [], [], [], [], [], [], []],
        },
        read() {
            // on commence par vider emptyCells car sinon sans rafraichissement de la page client, la méthode push ne fait qu'augmenter la variable emptyCells avec les grilles précédentes
            app.board.data.ligne = [[], [], [], [], [], [], [], [], []];
            // récupérer tous les inputs de la grille et itérer sur chacun des éléments
            const cellELements = document.getElementsByClassName('sudokValues');
            for (const cell of cellELements) {
                const numLigne = cell.id.substr(0, 1);
                const numColumn = cell.id.substr(1, 1);
                let inputValue = 0;
                // les cellules vides sont transformées en 0
                if (!cell.value) {
                    inputValue = 0;
                } else {
                    inputValue = Number(cell.value);
                }
                app.board.data.ligne[numLigne][numColumn] = inputValue;
            }
            return app.board.data.ligne;
        },

        findSquare(lig, col) { // cette fonction trouve le carré concerné à partir du numéro de ligne et de colonne
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
        findcolSquare(lig, col) {
            let colSquare = 0;

            if ((lig == 0 || lig == 3 || lig == 6) && col <= 2) {
                colSquare = Number(col);
            } else if ((lig == 0 || lig == 3 || lig == 6) && col > 2 && col <= 5) {
                colSquare = Number(col) - 3;
            } else if ((lig == 0 || lig == 3 || lig == 6) && col > 5 && col <= 8) {
                colSquare = Number(col) - 6;
            } else if ((lig == 1 || lig == 4 || lig == 7) && col <= 2) {
                colSquare = Number(col) + 3;
            } else if ((lig == 1 || lig == 4 || lig == 7) && col > 2 && col <= 5) {
                colSquare = Number(col);
            } else if ((lig == 1 || lig == 4 || lig == 7) && col > 5 && col <= 8) {
                colSquare = Number(col) - 3;
            } else if ((lig == 2 || lig == 5 || lig == 8) && col <= 2 + 6) {
                colSquare = Number(col) + 6;
            } else if ((lig == 2 || lig == 5 || lig == 8) && col > 2 && col <= 5) {
                colSquare = Number(col) + 3;
            } else if ((lig == 2 || lig == 5 || lig == 8) && col > 5 && col <= 8) {
                colSquare = Number(col);
            }

            return colSquare;
        },
    },
    stopWatch: {

        count: 0,

        On: null,

        create: () => {
            // on contrôle d'abord si le chrono est déjà présent pour ne pas en créer un 2ème.
            const chrono = document.getElementById('stopWatch');
            app.stopWatch.count = 0;

            if (chrono) { // s'il est présent on stoppe la fonction
                return;
            }

            console.log('Generating StopWatch ...');

            // Création du Chronomètre dans le conteneur de la grille et du chrono
            const stopWatchContainerElt = document.querySelector('.main-content');
            const stopWatchElt = document.createElement('div');
            stopWatchElt.id = 'stopWatch';
            stopWatchContainerElt.appendChild(stopWatchElt);

            // création d'un paragraphe au sein du Chrono pour y afficher le chrono en cours

            const stopWatchTextElt = document.createElement('p');
            stopWatchTextElt.classList.add('stopWatchText');
            stopWatchTextElt.textContent = 'Chrono:';
            stopWatchElt.appendChild(stopWatchTextElt);

            // sous le chrono en cours on affiche un bouton pause
            const breakBtn = document.createElement('div');
            breakBtn.id = 'breakBtn';
            breakBtn.textContent = 'Pause';
            breakBtn.addEventListener('click', (e) => {
                app.stopWatch.breakToggle(e);
            });
            stopWatchElt.appendChild(breakBtn);
        },

        delete() {
            const stopWatchElt = document.getElementById('stopWatch');

            if (stopWatchElt) {
                stopWatchElt.remove();
            }
        },

        launch: () => {
            console.log('Début du chronomètre');
            app.stopWatch.On = setInterval(app.stopWatch.setOn, 1000);
        },

        setOff() {
            clearInterval(app.stopWatch.On);
            // TODO Faire clignoter le chrono pendant 3 sec en jouant sur le style display (none/block)
            console.log('arrêt chrono');
            // app.stopWatch.count = 0;
        },

        setOn() {
            const stopWatchTextElt = document.querySelector('.stopWatchText');
            stopWatchTextElt.textContent = `Chrono: \n ${app.stopWatch.count}s`;
            app.stopWatch.count++;
            stopWatchTextElt.textContent = `Chrono:
        ${app.stopWatch.count}s`;
        },

        breakToggle(e) {
            if (e.target.textContent === 'Pause') {
                e.target.textContent = 'Reprendre';
                console.log('Chrono mis en pause');
                app.stopWatch.setOff();
            } else {
                e.target.textContent = 'Pause';
                console.log('Chrono redémarré');
                app.stopWatch.launch();
            }
        },
    },
    form: {

        create() {
            // Je commente tout le code car j'implémente en dur le formulaire
            console.log('Generating Form ...');

            // Buttons
            const loadExerciceBtnElt = document.getElementById('loadExerciceBtnElt');
            // loadExerciceBtnElt.textContent = 'Charger Exercice';
            loadExerciceBtnElt.addEventListener('click', app.loadExercice);

            const emptyBoardBtnElt = document.getElementById('emptyBoardBtnElt');
            // emptyBoardBtnElt.textContent = 'Vider la grille';
            // emptyBoardBtnElt.type = 'button';
            emptyBoardBtnElt.addEventListener('click', app.emptyExercice);

            const solveExerciceBtnElt = document.getElementById('solveBoardBtn');
            // solveExerciceBtnElt.id = 'solveBoardBtn';
            // solveExerciceBtnElt.textContent = 'Résoudre la grille';
            solveExerciceBtnElt.addEventListener('click', app.solveExercice);

            const newChrono = document.getElementById('newChrono');
            // newChrono.id = 'newChrono';
            // newChrono.textContent = 'Lancer un chrono';
            newChrono.addEventListener('click', (e) => {
                e.preventDefault();
                app.stopWatch.setOff();
                app.stopWatch.delete();
                app.stopWatch.create();
                app.stopWatch.launch();
            });
        },

        level: ['Facile1', 'Facile2', 'Moyen', 'Difficile', 'Démoniaque'],

    },
    emptyErrorMessage: () => {
        // On met la zone de message d'erreur à vide (au cas ou)
        const messageErreurElt = document.getElementById('errorMessage');
        messageErreurElt.textContent = '';
    },
    emptyExercice: () => {
        // On met la zone de message d'erreur à vide (au cas ou)
        app.emptyErrorMessage();

        // Mettre toute la grille à 0 et enlever l'Id de grille (s'il existe) des dataset du bouton de résolution
        // Remettre les background des input avec la couleur d'origine
        console.log('Emptying Board ...');

        const boardCells = document.querySelectorAll('.sudokValues');
        for (const cell of boardCells) {
            cell.value = '';
            cell.style.backgroundColor = 'lightgrey';
        }

        const solveExerciceBtnElt = document.getElementById('solveBoardBtn');
        const isGrille = solveExerciceBtnElt.dataset.id;

        if (isGrille) {
            solveExerciceBtnElt.removeAttribute('data-id');
        }

        // supprimer le compte du chrono et le chrono html s'il existe
        app.stopWatch.setOff();
        app.stopWatch.delete();

        // on enlève l'option de Live-Correction proposée pour les grilles chargées
        const autoCheckInput = document.getElementById('autoCheck');
        const autoCheckInputLabel = document.getElementById('autoCheckLabel');
        autoCheckInput.style.display = 'none';
        autoCheckInputLabel.style.display = 'none';
        autoCheckInput.checked = false;
    },
    applyDatasToBoard: (data) => {
        // On met la zone de message d'erreur à vide (au cas ou)
        app.emptyErrorMessage();

        // On parcours le tableau reçu dans le paramètre data et on boucle sur les cellules de la board pour les mettre à jour
        // On remet également tous les background à l'origine

        const boardCells = document.querySelectorAll('.sudokValues');
        for (const cell of boardCells) {
            cell.value = '';
            cell.style.backgroundColor = 'lightgrey';
        }

        for (let line = 0; line < 9; line++) {
            for (let column = 0; column < 9; column++) {
                const cell = document.getElementById(line.toString() + column.toString());
                cell.value = data[line][column];
            }
        }
    },
    loadExercice: (e) => {
        e.preventDefault();

        // On met la zone de message d'erreur à vide (au cas ou)
        app.emptyErrorMessage();

        // On met la grille à 0 au cas ou
        app.emptyExercice();

        // on lit la difficulté demandée pour l'envoyer au serveur qui traitera alors une route dynamique
        const level = document.getElementById('level-selection').value;
        const route = `${BASE_URL}/api/board/getBoard/${level}`;
        console.log(route);

        // on fetch une grille avec un niveau de difficulté demandé
        fetch(route)
            .then((response) => response.json())
            .then((board) => {
                console.log(`Board ${board.id} loaded`);

                // on récupère un id de grille que l'on stocke dans un dataset du bouton 'Résoudre Grille'
                const solveBoardBtn = document.getElementById('solveBoardBtn');
                solveBoardBtn.dataset.id = board.id;

                app.applyDatasToBoard(board.data);
            })
            .catch((err) => console.log("board not found"));

        // on affiche l'option de Live-Correction proposée pour les grilles chargées et on le décoche

        const autoCheckInput = document.getElementById('autoCheck');
        const autoCheckInputLabel = document.getElementById('autoCheckLabel');
        autoCheckInput.style.display = 'inline-block';
        autoCheckInputLabel.style.display = 'inline-block';
        autoCheckInput.checked = false;
    },
    solveExercice: (e) => {
        e.preventDefault();

        console.log('Bouton "Résoudre Grille activé"');
        const solveBoardBtn = document.getElementById('solveBoardBtn');
        const boardId = solveBoardBtn.dataset.id;
        console.log(`BASE_URL:${BASE_URL}`);
        let route = `${BASE_URL}/api/board/solveBoard/`;

        // On teste la présence d'un id dans les dataset du bouton solve et si oui on fetch la grille concernée et on l'affiche (route1)
        if (boardId) {
            route += boardId;
            console.log(`BoardId ok, route:${route}`);

            fetch(route) // on fait une demande au back d'une résolution de gille connue avec un ID transmis en paramètre
                .then((response) => {
                    const responseTreated = response.json(); // on décrypte la réponse du back
                    return responseTreated;
                })
                .then((board) => {
                    // On affiche les résultats dans la grille
                    app.applyDatasToBoard(board.data);
                    console.log('Results for Board loaded');
                });
        } else {
            // Route du solveur car la grille n'est pas connue en base. Il faut donc lire la grille et l'envoyer dans le fetch
            console.log(`BoardId non identifiée, route:${route}`);

            // déjà démarrage du chrono pour mesurer la performance du système solveur
            // app.stopWatch.setOff();
            // app.stopWatch.create();
            // app.stopWatch.launch();

            // lecture de la grille html
            const boardData = app.board.read(); // un objet qui contient des tableaux sur différentes propriétés
            const boardDataJSON = JSON.stringify(boardData);

            // envoie de la grille sous format JSON
            fetch(route, {
                method: 'POST',
                body: boardDataJSON,
                headers: {
                    'Content-Type': 'application/json',
                },
            })
                // réception des calculs du solveur, décryptage du json
                .then((response) => {
                    const responseTreated = response.json();
                    return responseTreated;
                })
                // le décryptage des calculs solveur est terminé, on écrit les données dans la grille html
                .then((board) => {
                    console.log(board.results);
                    if (board.results === 'Il n\'y a pas de solution pour cette grille') {
                        // app.stopWatch.setOff();
                        // Mise à jour du message d'erreur
                        const messageErreurElt = document.getElementById('errorMessage');
                        messageErreurElt.textContent = board.results;
                    } else {
                        app.applyDatasToBoard(board.results);
                        // on arrête aussi le chrono pour voir le temps de calcul total
                        // app.stopWatch.setOff();
                    }
                });
        }
    },
};

// Lancement de la génération de la grille
document.addEventListener('DOMContentLoaded', app.init);
