const fs = require('fs');
const serverMethods = require('./serverMethods');
const solver = require('../my_modules/solver');
const { updateDisplaySettingsById, getDisplaySettingsById, deleteOneBoardById, insertNewBoards, deleteOneUser, createUser, getOneUser, getOneRandomBoard, getOneBoardById, getAllBoards, updateOneUser } = require('../dataMapper.js');
const bcrypt = require('bcrypt');
const client = require('../bdd');

const controller = {
    welcome: (req, res) => {

        res.render('index');
    },

    login: (req, res) => {
        const loginMessage = '';
        res.render('login', { loginMessage });
    },

    adminAuth: (req, res, next) => {

        if (!req.session.actorConnected) {

            console.log('Accès refusé, utilisateur non connecté.');
            const loginMessage = 'Vous devez vous connecter pour accéder à cette page.';
            res.render('login', { loginMessage });
            return;

        }
        else {
            if (req.session.actorConnected.role.toString().toLowerCase() !== 'admin') {

                console.log('L\'utilisateur n\'a pas les droits suffisants pour accéder à cette page.');
                res.redirect('/sudoku');
                return;
            }
            else {
                console.log('Utilisateur connecté à une page administrateur.');
            }
        }

        next();

    },

    addLogin: (req, res) => {

        //récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = {
            actor_login: req.body.login,
            actor_name: req.body.name,
            actor_surname: req.body.surname,
            actor_email: req.body.email,
            actor_password: req.body.password
        }

        //vérifier que tous les champs ont été complétés sinon il faut refuser la création

        for (const actorInfo in actorObject) {
            if (actorObject[actorInfo] === null || actorObject[actorInfo] === '') {
                const createLoginMessage = 'Il manque des données, tous les champs sont obligatoires.';
                res.render('createLogin', { createLoginMessage });
                return;
            };
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

    amendActor: (req, res) => {

        //récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = {
            actor_id: req.session.actorConnected.id,
            actor_login: req.body.login,
            actor_name: req.body.name,
            actor_surname: req.body.surname,
            actor_email: req.body.email,
        }

        //vérifier que tous les champs ont été complétés sinon il faut refuser la création

        for (const actorInfo in actorObject) {
            if (actorObject[actorInfo] === null || actorObject[actorInfo] === '') {
                const createLoginMessage = 'Il manque des données, tous les champs sont obligatoires.';
                res.render('createLogin', { createLoginMessage });
                return;
            };
        }

        //lancer le dataMapper qui met à jour les données pour l'id de session en cours

        updateOneUser(actorObject, (error, results) => {

            if (error) {
                res.status(500).send('500');
                return;
            }
            else {

                //on remet à jour les données de la session et les locals

                req.session.actorConnected.login = actorObject.actor_login;
                req.session.actorConnected.name = actorObject.actor_name;
                req.session.actorConnected.surname = actorObject.actor_surname;
                req.session.actorConnected.email = actorObject.actor_email;

                res.locals.actorConnected = req.session.actorConnected; //on transmet les infos de session à EJS

                res.redirect('/sudoku');
            }

        })

    },

    deleteActor: (req, res) => {

        const id = Number(req.session.actorConnected.id);

        //Appel du datamapper
        deleteOneUser(id, (error, results) => {

            if (error) {
                res.status(500).send('500');
                return;
            }
            else {
                console.log('Résultat suppression: ' + JSON.stringify(results));
                res.redirect('/sudoku/deconnect'); //on renvoie sur la route qui supprime la session
            }

        })

    },

    connect: (req, res) => {

        //récupérer le login et le password dans le req.body

        console.log('connexion en cours');

        const actor_login = req.body.login;
        console.log('login: ' + actor_login);

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

                bcrypt.compare(password, hash, function (error, result) { //return true/false
                    if (error) {
                        console.log(error);
                        res.status(500).send('500');
                    }
                    else if (!result) {

                        const loginMessage = 'Mot de passe incorrect';
                        res.render('login', { loginMessage });

                    }
                    else {
                        req.session.actorConnected = {
                            login: results[0].actor_login,
                            role: results[0].role_description,
                            id: results[0].actor_id,
                            name: results[0].actor_name,
                            surname: results[0].actor_surname,
                            email: results[0].actor_email,
                        };
                        res.locals.actorConnected = req.session.actorConnected; //on transmet les infos de session à EJS
                        res.redirect('/sudoku');
                    }
                });

            }
        })

    },

    deconnect: (req, res) => {

        req.session.destroy(function (err) {
            if (err) {
                console.log('Erreur destrcution session: ' + err);
            }
        });

        res.locals = null;

        res.redirect('/sudoku/login');
    },

    displayAccount: (req, res) => {

        const { login } = req.params;
        res.render('createLogin'); //on exploitera les infos de session de façon indirecte via res.locals qui est enregistré à chaque requête

    },

    formCreation: (req, res) => {
        const loginCreationMessage = ''
        res.render('createLogin', { loginCreationMessage });
    },

    loadBoard: (req, res) => {

        //on récupère le niveau de difficulté demandé par le client (envoyé dans la route)
        const { level } = req.params;

        //Appel du datamapper, il va renvoyer une grille aléatoire.

        getOneRandomBoard((error, board) => {

            if (error) {
                res.status(500).send('500');
                return;
            }
            else {

                //on la passe à la fonction aléatoire pour lui retirer des valeurs

                const boardDataLevelTreated = serverMethods.takeOutNumbersFromBoard(level, board.board_data);

                const response = {
                    id: board.board_id,
                    data: boardDataLevelTreated
                };

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);

            }

        })

    },

    loadResult: (req, res) => {

        //on récupère l'ID de la grille affichée sur le navigateur (provient d'un dataset)
        const boardId = Number(req.params.boardId);

        //Appel du dataMapper pour rechercher la grille avec l'ID fourni

        getOneBoardById(boardId, (error, board) => {
            if (error) {
                res.status(500).send('500');
                return;
            }
            else {

                const response = {
                    id: board.board_id,
                    data: JSON.parse(board.board_data)
                };

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);

            }

        })
    },

    getDisplaySettings: (req, res) => {

        //on récupère l'ID de l'utilisateur connecté dans la session
        const id = req.session.actorConnected.id;

        //Appel du dataMapper pour rechercher les couleurs de cet utilisateur

        getDisplaySettingsById(id, (error, colors) => {
            if (error) {
                res.status(500).send('500');
                return;
            }
            else {

                const response = {
                    display_color1: (colors[0].display_color1),
                    display_color2: (colors[0].display_color2),
                    display_color3: (colors[0].display_color3),
                    display_color4: (colors[0].display_color4),
                    display_color5: (colors[0].display_color5)
                };

                res.setHeader('Access-Control-Allow-Origin', '*');
                console.log('response: ' + JSON.stringify(response));
                res.send(response);

            }

        })
    },

    updateDisplaySettings: (req, res) => {

        const displayId = req.params.displayId;
        const actorId = req.session.actorConnected.id;

        console.log('displayID: ' + displayId);
        console.log('actorID: ' + actorId);

        updateDisplaySettingsById(actorId, displayId, (error, results) => {
            if (error) {
                res.status(500).send('500');
                return;
            }
            else {
                res.setHeader('Access-Control-Allow-Origin', '*');
                console.log('response: ' + JSON.stringify(results));
                res.send(results);

            }
        })
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

        //lecture de la base de données et on renvoie l'élément recherché

        getOneBoardById(boardId, (error, results) => {
            if (error) {
                res.status(500).send('500');
                return;

            } else {


                const response = {
                    inputSolution: results.board_data[ligne][column]
                };

                console.log('solution: ' + response.inputSolution);

                res.setHeader('Access-Control-Allow-Origin', '*');
                res.send(response);

            }
        })
    },

    databaseRead: (req, res) => {

        //lecture de la base de données

        getAllBoards((error, results) => {

            //On renvoie un fichier EJS qui affiche les données
            res.render('adminDB', { data: results });

        })

    },

    dataBaseWrite: (req, res) => {

        const qty = Number(req.query.qtyNewBoards);

        const arrayOfNewBoards = [];

        //Boucle de Générations de grilles aléatoires avec leurs solutions

        for (let i = 0; i < qty; i++) {

            //Génération grille
            const newSolvedBoard = solver.board.generatorSupervisor();

            //On pousse les nouvelles grilles dans un tableau qui contiendra toutes les nouvelles grilles

            arrayOfNewBoards.push(newSolvedBoard);

            //remise à 0 du tracker et de emptyCells pour éviter de mélanger les données
            solver.board.data.emptyCells = [];
            solver.board.tracker = [];
        }

        const boards = JSON.stringify(arrayOfNewBoards);

        //Datamapper pour écrire les résultats
        insertNewBoards(boards, (error, results) => {
            if (error) {
                res.status(500).send('500');
                return;
            }
            else {
                console.log(results);
                res.redirect('/sudoku/database/');
            }

        })

    },

    deleteBoard: (req, res) => {
        const id = Number(req.params.id);

        deleteOneBoardById(id, (error, results) => {

            if (error) {
                res.status(500).send('500');
            }
            else {
                res.redirect('/sudoku/database/');
            }

        })
    }

};

module.exports = controller;