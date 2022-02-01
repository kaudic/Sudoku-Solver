const dataMapper = require('../../models/user');
const bcrypt = require('bcrypt');

const controller = {

  home: (req, res) => {
    res.render('index');
  },

  databaseRead: (req, res) => {
    // lecture de la base de données

    dataMapper.getAllBoards((error, results) => {
      // On renvoie un fichier EJS qui affiche les données
      res.render('adminDB', { data: results });
    });
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

    if (req.session.actorConnected.role.toString().toLowerCase() !== 'admin') {
      console.log('L\'utilisateur n\'a pas les droits suffisants pour accéder à cette page.');
      res.redirect('/sudoku');
      return;
    }

    console.log('Utilisateur connecté à une page administrateur.');

    next();
  },

  addLogin: (req, res) => {
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
        res.render('createLogin', { createLoginMessage });
        return;
      }
    }

    // vérifier que le compte actor_login n'existe pas déjà et si oui faire un render de la page de création

    dataMapper.getOneUser(actorObject.actor_login, (error, results) => {
      if (error) {
        console.log(error);
        res.status(500).send('500');
      } else if (results.length > 0) { // le compte existe déjà
        const createLoginMessage = 'ce login existe déjà en base de données.';
        res.render('createLogin', { createLoginMessage });
      } else {
          
        // crypter les données du password
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          // Controler que le hash a fonctionné sans erreur

          if (err) {
            console.log(err);
            res.status(500).send('500');
          }

          actorObject.actor_password = hash;

          // appeler datamapper.createUser pour mettre en base de données un nouveau login et lui passer un objet contenant le user_login et le user_password

          dataMapper.createUser(actorObject, (error, results) => {
            if (error) {
              req.error = error;
              console.log(`error: ${error}`);
              res.status(500).send('500');
            } else if (!results) {
              req.error = new Error('L\'insertion n\'a pas pas fonctionnée');
            } else {
              // rendre réponse pour dire que le login est créé en affichant un message sur la page de login
              const loginMessage = 'Utilisateur créé, vous pouvez désormais vous connecter.';
              res.render('login', { loginMessage });
            }
          });
        });
      }
    });
  },

  amendActor: (req, res) => {
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
        res.render('createLogin', { createLoginMessage });
        return;
      }
    }

    // lancer le dataMapper qui met à jour les données pour l'id de session en cours

    dataMapper.updateOneUser(actorObject, (error, results) => {
      if (error) {
        res.status(500).send('500');
      } else {
        // on remet à jour les données de la session et les locals

        req.session.actorConnected.login = actorObject.actor_login;
        req.session.actorConnected.name = actorObject.actor_name;
        req.session.actorConnected.surname = actorObject.actor_surname;
        req.session.actorConnected.email = actorObject.actor_email;

        res.locals.actorConnected = req.session.actorConnected; // on transmet les infos de session à EJS

        res.redirect('/sudoku');
      }
    });
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
