const bcrypt = require('bcrypt');
const dataMapper = require('../../models/user');

const controller = {

    home(req, res) {
        res.render('index');
    },

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
        const actorObject = { ...req.body };

        // check if actor_login already exists, if true then render page
        const results = await dataMapper.getOneUser(actorObject.actor_login);
        if (results.rowCount > 0) {
            const createLoginMessage = 'ce login existe déjà en base de données.';
            return res.render('createLogin', { createLoginMessage });
        }
        // crypter les données du password
        const hash = await bcrypt.hash(req.body.password, 10);
        actorObject.actor_password = hash;
        await dataMapper.createUser(actorObject);
        const loginMessage = 'Utilisateur créé, vous pouvez désormais vous connecter.';
        return res.render('login', { loginMessage });
    },

    async amendActor(req, res) {
        // récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = { ...req.body };

        // lancer le dataMapper qui met à jour les données pour l'id de session en cours
        await dataMapper.updateOneUser(actorObject);

        // on remet à jour les données de la session et les locals
        req.session.actorConnected.login = actorObject.actor_login;
        req.session.actorConnected.name = actorObject.actor_name;
        req.session.actorConnected.surname = actorObject.actor_surname;
        req.session.actorConnected.email = actorObject.actor_email;
        // on transmet les infos de session à EJS
        res.locals.actorConnected = req.session.actorConnected;
        return res.redirect('/sudoku');
    },

    async deleteActor(req, res) {
        const id = Number(req.session.actorConnected.id);
        await dataMapper.deleteOneUser(id);
        // on renvoie sur la route qui supprime la session
        res.redirect('/sudoku/deconnect');
    },

    async connect(req, res) {
        const user = await dataMapper.getOneUser(req.body.login);
        if (user.rowCount === 0) {
            return res.render('login', { loginMessage: 'Le login n\'existe pas en base de données.' });
        }
        const passwordCheck = await bcrypt.compare(req.body.password, user.actor_password);
        if (!passwordCheck) {
            return res.render('login', { loginMessage: 'Mot de passe incorrect' });
        }
        req.session.actorConnected = {
            login: user.actor_login,
            role: user.role_description,
            id: user.actor_id,
            name: user.actor_name,
            surname: user.actor_surname,
            email: user.actor_email,
        };
        res.locals.actorConnected = req.session.actorConnected;
        return res.redirect('/sudoku');
    },

    deconnect: (req, res) => {
        delete req.session.actorConnected;
        res.locals = null;
        res.redirect('/sudoku/login');
    },

    displayAccount: (req, res) => {
        // createLogin view uses diretly res.locals to find the login
        res.render('createLogin');
    },

    formCreation: (req, res) => {
        res.render('createLogin', { loginCreationMessage: '' });
    },

};

module.exports = controller;
