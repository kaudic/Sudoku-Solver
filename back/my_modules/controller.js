const fs = require('fs');
const serverMethods = require('./serverMethods');
const boardData = require('../data/boardDatabase.json');
const solver = require('../my_modules/solver');
const { createUser, getOneUser } = require('../dataMapper.js');
const bcrypt = require('bcrypt');


const controller = {
    welcome: (req, res) => {

        res.render('index');
    },

    login: (req, res) => {
        const loginMessage = '';
        res.render('login', { loginMessage });
    },

    addLogin: (req, res) => {

        //récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = {
            actor_login: req.body.login,
            actor_name: req.body.name,
            actor_surname: req.body.surname,
            actor_email: req.body.email,
        }

        //vérifier que le compte actor_login n'existe pas déjà et si oui faire un render de la page de création

        getOneUser(actorObject.actor_login, (error, results) => {

            if (error) {
                console.log(error);
                res.status(500).send('500');
            }
            else if (results.length > 0) { //le compte existe déjà
                const createLoginMessage = 'ce login existe déjà en base de données.'
                res.render('createLogin', { createLoginMessage });
            }
            else {
                //crypter les données du password
                bcrypt.hash(req.body.password, 10, function (err, hash) {

                    // Controler que le hash a fonctionné sans erreur

                    if (err) {
                        console.log(err);
                        res.status(500).send('500');
                    }

                    actorObject.actor_password = hash;

                    //appeler datamapper.createUser pour mettre en base de données un nouveau login et lui passer un objet contenant le user_login et le user_password

                    createUser(actorObject, (error, results) => {

                        if (error) {
                            req.error = error;
                            console.log('error: ' + error);
                            res.status(500).send('500');
                        }
                        else if (!results) {
                            req.error = new Error('L\'insertion n\'a pas pas fonctionnée');
                        }
                        else {

                            //rendre réponse pour dire que le login est créé en affichant un message sur la page de login
                            const loginMessage = 'Utilisateur créé, vous pouvez désormais vous connecter.';
                            res.render('login', { loginMessage });
                        }
                    })
                });

            }

        })

    },

    connect: (req, res) => {

        //récupérer le login et le password dans le req.body

        const actor_login = req.body.login;
        const password = req.body.password;

        //Faire appel à un datamapper pour vérifier la présence du login dans la base (SELECT)

        getOneUser(req.body.login, (error, results) => {

            if (error) {
                console.log(error);
                res.status(500).send('500');
            }
            else if (results.length === 0) {
                //le login n'existe pas en base, on prévient l'utilisateur
                const loginMessage = 'Le login n\'existe pas en base de données.';
                res.render('login', { loginMessage });
            }
            else {

                const hash = results[0].actor_password;
                console.log(hash);

                bcrypt.compare(password, hash, function (error, result) { //return true/false
                    if (error) {
                        console.log(error);
                        res.status(500).send('500');
                    }
                    else if (!result) {

                        console.log('coucou');

                        const loginMessage = 'Mot de passe incorrect';
                        res.render('login', { loginMessage });

                    }
                    else {
                        req.session.connected = results[0].actor_login;
                        res.locals.connectedPerson = req.session.connected;
                        res.render('index');
                    }
                });

            }
        })

        //si incorrecte renvoyer la page /sudoku/login avec un message info non correcte

        //si correcte, renseigner le login dans req.session et remplacer le logo de connexion par le log in
        //render dans l'index directement

    },

    formCreation: (req, res) => {
        const loginCreationMessage = ''
        res.render('createLogin', { loginCreationMessage });
    },

    loadBoard: (req, res) => {

        //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
        const { level } = req.params;

        //la base de données a été require dans la variable boardData -> plus besoin de faire des fs.readFile

        // const max = Object.keys(boardData).length;
        const max = boardData.length;
        const randomNumber = serverMethods.getRandomNumber(0, max);
        // const randomId = 'id' + randomNumber;
        const boardDataLevelTreated = serverMethods.takeOutNumbersFromBoard(level, boardData[randomNumber].data);

        const response = {
            // id: randomId,
            id: boardData[randomNumber].id,
            data: boardDataLevelTreated
        };

        res.setHeader('Access-Control-Allow-Origin', '*');
        res.send(response);
    },

    loadResult: (req, res) => {

        //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
        const { boardId } = req.params;

        if (boardId !== 'none') {

            //lecture de la base de données json et on renvoie la grille de l'ID recherchée
            fs.readFile('./data/boardDatabase.json', (err, data) => {
                if (err) throw err;
                const boardData = JSON.parse(data);

                const boardDataRequired = boardData.find((element) => {
                    return element.id === boardId;
                });
                console.log(boardDataRequired);

                const response = {
                    id: boardId,
                    data: boardDataRequired.data
                };

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);
            });
        }

        else {

            return nextTick();


        };

    },

    solveBoard: (req, res) => {
        console.log('Solveur démarré');

        //on récupère les données de la grille du front
        const frontBoardData = req.body;

        //enregistrer les données reçues du front (frontBoardData) vers notre variable en back : "solver.board.data"
        solver.board.data.ligne = frontBoardData.ligne;
        solver.board.data.column = frontBoardData.column;
        solver.board.data.square = frontBoardData.square;
        solver.board.data.ligne = frontBoardData.ligne;
        solver.board.data.emptyCells = frontBoardData.emptyCells;

        //lancement du solveur en mode asynchrone
        const resultatSolver = async function () {

            const response = solver.board.solve(false);
            return response;

        }

        //A récupération des données du solver, on prépare le message JSON pour le front
        resultatSolver().then((data) => {

            let responseTreated = null;

            if (data === 'Non solvable') {
                responseTreated = {
                    results: 'Il n\'y a pas de solution pour cette grille',
                };
            } else {
                responseTreated = {
                    results: solver.board.data.ligne,
                };
            }

            //envoie du message au front
            res.setHeader('Access-Control-Allow-Origin', '*');
            res.send(responseTreated);

        });
    },

    checkCellResult: (req, res) => {

        //on récupère l'Id de la grille et l'Id de l'input
        const { boardId, inputId } = req.params;
        console.log('Id grille reçu: ' + boardId);
        console.log('Input n° modifié : ' + inputId);
        const ligne = inputId.substr(0, 1);
        const column = inputId.substr(1, 1);

        //lecture de la base de données json et on renvoie l'élément recherché
        fs.readFile('./data/boardDatabase.json', (err, data) => {
            if (err) throw err;
            const boardData = JSON.parse(data);

            const searchedBoard = boardData.find((element) => {
                return element.id === boardId;
            });

            const response = {
                inputSolution: searchedBoard.data[ligne][column]
            };

            console.log('solution: ' + response.inputSolution);

            res.setHeader('Access-Control-Allow-Origin', '*');
            res.send(response);
        });
    },

    database: (req, res) => {

        //lecture du fichier json initial
        fs.readFile('../sudoku-solver/back/data/boardDatabase.json', ((err, data) => {
            if (err) throw err;

            const initialDatabase = JSON.parse(data);
            let nextID = (initialDatabase.length) - 1;

            //Boucle de Générations de grilles aléatoires avec leurs solutions

            for (let i = 0; i < 5; i++) {

                nextID += 1;

                //Génération grille
                const newSolvedBoard = solver.board.generatorSupervisor();
                const newSolvedBoardObject = {
                    id: "id" + nextID,
                    data: newSolvedBoard
                };

                //On pousse les nouvelles grilles dans un objet qui deviendra la nouvelle base de données JSON
                initialDatabase.push(newSolvedBoardObject);

                //remise à 0 du tracker et de emptyCells pour éviter de mélanger les données
                solver.board.data.emptyCells = [];
                solver.board.tracker = [];
            }

            const finalDatabase = JSON.stringify(initialDatabase);


            fs.writeFile('../sudoku-solver/back/data/boardDatabase.json', finalDatabase, (err) => {
                if (err) throw err;
            });
            console.log('Nouvelles grilles enregistrées en base de données JSON');
            //On renvoie un fichier EJS qui affiche les données

            res.render('adminDB');


        }));


    }

};

module.exports = controller;