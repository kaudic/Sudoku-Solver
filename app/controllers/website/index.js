const bcrypt = require('bcrypt');
const userDatamapper = require('../../models/user');
const boardDatamapper = require('../../models/board');
const formatUser = require('../../helpers/userFormatter');
const mailer = require('../../helpers/mailer');

const controller = {

    home(req, res) {
        res.render('index');
    },

    async databaseRead(req, res) {
        // lecture de la base de données
        const results = await boardDatamapper.getAllBoards();
        return res.render('adminDB', { data: results });
    },

    login: (req, res) => {
        const loginMessage = '';
        return res.render('login', { loginMessage });
    },

    adminAuth(req, res, next) {
        if (!req.session.actorConnected) {
            res.render('login', { loginMessage: 'Vous devez vous connecter pour accéder à cette page.' });
        }

        if (req.session.actorConnected.role.toString().toLowerCase() !== 'admin') {
            res.redirect(`sudoku/sudoku-solver`);
        }
        next();
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
        const results = await userDatamapper.getOneUserByIdOrEmail(newUser);
        if (results.rowCount > 0) {
            return res.render('createLogin', { createLoginMessage: 'ce login ou cet email existe déjà en base de données.', newUser });
        }
        // crypter les données du password
        const hash = await bcrypt.hash(req.body.password, 10);
        newUser.password = hash;
        await userDatamapper.createUser(formatUser(newUser));
        mailer(newUser);
        return res.render('login', { loginMessage: 'Utilisateur créé, vous pouvez désormais vous connecter.' });
    },

    async amendActor(req, res) {
        // récupérer les informations dans le req.body et les affecter à un nouvel objet
        const actorObject = { ...req.body };
        actorObject.id = req.session.actorConnected.id;

        // hash new password excecpt if not entered, in this case we get the one from the DB
        if (actorObject.password === '') {
            actorObject.password = await userDatamapper.getOnePassword(actorObject.email);
        } else {
            actorObject.password = await bcrypt.hash(req.body.password, 10);
        }
        // mise à jour dans la DB
        await userDatamapper.updateOneUser(actorObject);
        return res.redirect(`sudoku/sudoku-solver/`);
    },

    async deleteActor(req, res) {
        const id = Number(req.session.actorConnected.id);
        await userDatamapper.deleteOneUser(id);
        // on renvoie sur la route qui supprime la session
        res.redirect(`sudoku/sudoku-solver/deconnect`);
    },

    async connect(req, res) {
        const user = await userDatamapper.getOneUserByIdOrEmail(req.body);
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
        return res.redirect(`${process.env.BASE_URL}/sudoku/sudoku-solver`);
    },

    deconnect: (req, res) => {
        delete req.session.actorConnected;
        res.locals = null;
        res.redirect(`${process.env.BASE_URL}/sudoku-solver/login`);
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
