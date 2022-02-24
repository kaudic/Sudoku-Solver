const bcrypt = require('bcrypt');
const dataMapper = require('../../models/user');
const formatUser = require('../../helpers/userFormatter');

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
            res.render('login', { loginMessage: 'Vous devez vous connecter pour accéder à cette page.' });
        }

        if (req.session.actorConnected.role.toString().toLowerCase() !== 'admin') {
            res.redirect('/sudoku');
        }
    },

    async addLogin(req, res) {
        const newUser = { ...req.body };
        // check if all required fields are filled
        (Object.keys(newUser)).forEach((newUserProperty) => {
            if (newUser[newUserProperty] === '') {
                return res.render('createLogin', { createLoginMessage: 'merci de compléter tous les champs obligatoires.', newUser });
            } return true;
        });

        // check if login or email already exists, if true then render page
        const results = await dataMapper.getOneUserByIdOrEmail(newUser);
        if (results.rowCount > 0) {
            return res.render('createLogin', { createLoginMessage: 'ce login ou cet email existe déjà en base de données.', newUser });
        }
        // crypter les données du password
        const hash = await bcrypt.hash(req.body.password, 10);
        newUser.password = hash;
        await dataMapper.createUser(formatUser(newUser));
        return res.render('login', { loginMessage: 'Utilisateur créé, vous pouvez désormais vous connecter.' });
    },

    async amendActor(req, res) {
        // récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = { ...req.body };
        actorObject.id = req.session.actorConnected.id;

        // hash new password excecpt if not entered, in this case we get the one from the DB
        if (actorObject.password === '') {
            actorObject.password = await dataMapper.getOnePassword(actorObject.email)
        }
        actorObject.password = await bcrypt.hash(req.body.password, 10);

        console.log(JSON.stringify(actorObject));
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
        const user = await dataMapper.getOneUserByIdOrEmail(req.body);
        if (user.rowCount === 0) {
            return res.render('login', { loginMessage: 'Le login n\'existe pas en base de données.' });
        }
        const passwordCheck = await bcrypt.compare(req.body.password, user.rows[0].actor_password);
        if (!passwordCheck) {
            return res.render('login', { loginMessage: 'Mot de passe incorrect' });
        }
        req.session.actorConnected = {
            login: user.rows[0].actor_login,
            role: user.rows[0].role_description,
            id: user.rows[0].actor_id,
            name: user.rows[0].actor_name,
            surname: user.rows[0].actor_surname,
            email: user.rows[0].actor_email,
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
