const bcrypt = require('bcrypt');
const dataMapper = require('../../models/user');

const controller = {

    home: (req, res) => res.render('index'),

    async databaseRead(req, res) {
        // lecture de la base de données
        const results = await dataMapper.getAllBoards();
        return res.render('adminDB', { data: results });
    },

    login: (req, res) => {
        const loginMessage = '';
        return res.render('login', { loginMessage });
    },

    adminAuth(req, res) {
        if (!req.session.actorConnected) {
            const loginMessage = 'Vous devez vous connecter pour accéder à cette page.';
            res.render('login', { loginMessage });
        }

        if (req.session.actorConnected.role.toString().toLowerCase() !== 'admin') {
            res.redirect('/sudoku');
        }
    },

    async addLogin(req, res) {
        // récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = {
            actor_login: req.body.login,
            actor_name: req.body.name,
            actor_surname: req.body.surname,
            actor_email: req.body.email,
            actor_password: req.body.password,
        };

        // vérifier que tous les champs ont été complétés sinon il faut refuser la création
        for (const actorInfo in actorObject) {
            if (actorObject[actorInfo] === null || actorObject[actorInfo] === '') {
                const createLoginMessage = 'Il manque des données, tous les champs sont obligatoires.';
                return res.render('createLogin', { createLoginMessage });
            }
        }

        // vérifier que le compte actor_login n'existe pas déjà et si oui faire un render de la page de création
        const results = await dataMapper.getOneUser(actorObject.actor_login);
        if (results.length > 0) { // le compte existe déjà
            const createLoginMessage = 'ce login existe déjà en base de données.';
            return res.render('createLogin', { createLoginMessage });
        } else {

            // crypter les données du password
            bcrypt.hash(req.body.password, 10, (err, hash) => {

                if (err) {
                    //! à mettre en mode logger console.log(err);
                    res.status(500).send('500');
                }
                actorObject.actor_password = hash;
                await dataMapper.createUser(actorObject);
                const loginMessage = 'Utilisateur créé, vous pouvez désormais vous connecter.';
                res.render('login', { loginMessage });
            }
        };
    },

    async amendActor(req, res) {
        // récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = {
            actor_id: req.session.actorConnected.id,
            actor_login: req.body.login,
            actor_name: req.body.name,
            actor_surname: req.body.surname,
            actor_email: req.body.email,
        };

        // vérifier que tous les champs ont été complétés sinon il faut refuser la création
        for (const actorInfo in actorObject) {
            if (actorObject[actorInfo] === null || actorObject[actorInfo] === '') {
                const createLoginMessage = 'Il manque des données, tous les champs sont obligatoires.';
                return res.render('createLogin', { createLoginMessage });
                ;
            }
        }

        // lancer le dataMapper qui met à jour les données pour l'id de session en cours
        dataMapper.updateOneUser(actorObject);

        // on remet à jour les données de la session et les locals
        req.session.actorConnected.login = actorObject.actor_login;
        req.session.actorConnected.name = actorObject.actor_name;
        req.session.actorConnected.surname = actorObject.actor_surname;
        req.session.actorConnected.email = actorObject.actor_email;
        res.locals.actorConnected = req.session.actorConnected; // on transmet les infos de session à EJS
        return res.redirect('/sudoku');
    },

    deleteActor: (req, res) => {
        const id = Number(req.session.actorConnected.id);

        // Appel du datamapper
        dataMapper.deleteOneUser(id, (error, results) => {
            if (error) {
                res.status(500).send('500');
            } else {
                console.log(`Résultat suppression: ${JSON.stringify(results)}`);
                res.redirect('/sudoku/deconnect'); // on renvoie sur la route qui supprime la session
            }
        });
    },

    connect: (req, res) => {
        // récupérer le login et le password dans le req.body

        console.log('connexion en cours');

        const actor_login = req.body.login;
        console.log(`login: ${actor_login}`);

        const { password } = req.body;

        // Faire appel à un datamapper pour vérifier la présence du login dans la base (SELECT)

        dataMapper.getOneUser(req.body.login, (error, results) => {
            if (error) {
                console.log(error);
                res.status(500).send('500');
            } else if (results.length === 0) {
                // le login n'existe pas en base, on prévient l'utilisateur
                const loginMessage = 'Le login n\'existe pas en base de données.';
                res.render('login', { loginMessage });
            } else {
                const hash = results[0].actor_password;

                bcrypt.compare(password, hash, (error, result) => { // return true/false
                    if (error) {
                        console.log(error);
                        res.status(500).send('500');
                    } else if (!result) {
                        const loginMessage = 'Mot de passe incorrect';
                        res.render('login', { loginMessage });
                    } else {
                        // l'utilisateur existe en base de données. On enregistre donc des informations de session
                        // on va chercher les préférences d'affichage.

                        req.session.actorConnected = {
                            login: results[0].actor_login,
                            role: results[0].role_description,
                            id: results[0].actor_id,
                            name: results[0].actor_name,
                            surname: results[0].actor_surname,
                            email: results[0].actor_email,
                        };
                        res.locals.actorConnected = req.session.actorConnected; // on transmet les infos de session à EJS
                        res.redirect('/sudoku');
                    }
                });
            }
        });
    },

    deconnect: (req, res) => {
        req.session.destroy((err) => {
            if (err) {
                console.log(`Erreur destrcution session: ${err}`);
            }
        });

        res.locals = null;

        res.redirect('/sudoku/login');
    },

    displayAccount: (req, res) => {
        const { login } = req.params;
        res.render('createLogin'); // on exploitera les infos de session de façon indirecte via res.locals qui est enregistré à chaque requête
    },

    formCreation: (req, res) => {
        const loginCreationMessage = '';
        res.render('createLogin', { loginCreationMessage });
    },

};

module.exports = controller;
