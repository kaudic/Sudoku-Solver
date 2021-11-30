const express = require('express');
const router = express.Router();
const controller = require('./controller');

//variable à transmettre à EJS
router.use((req, res, next) => {
    res.locals.actorConnected = req.session.actorConnected;
    next();
});

//liste des routes GET
router.get('/sudoku/', controller.welcome); //page d'accueil
router.get('/sudoku/login', controller.login); // pas de connexion
router.get('/sudoku/deconnect', controller.deconnect); // déconnection (on shoote la session)
router.get('/sudoku/Login/FormCreation', controller.formCreation); //Formulaire de création de compte
router.get('/getBoard/:level', controller.loadBoard); //chargement d'une grille en fonction d'un level demandé
router.get('/solveBoard/:boardId', controller.loadResult); //chargement des résultats d'une grille chargée
router.get('/checkInput/:boardId/:inputId', controller.checkCellResult); //mode auto-correction, on contrôle la valeur saisie d'une cellule
router.get('/sudoku/database/', controller.adminAuth, controller.databaseRead); //TODO passer admin comme un argument de fonction
router.get('/sudoku/myAccount/:login', controller.displayAccount); //afficher les infos de compte et pouvoir les modifier
router.get('/sudoku/generate', controller.dataBaseWrite); //créer de nouvelles grilles en base de données
router.get('/sudoku/delete/:id', controller.deleteBoard); //supprimer certaines grilles de la base de données
router.get('/sudoku/displaySettings/getColors', controller.getDisplaySettings); //récupérer les valeurs choisies par l'utilisateur
router.get('/sudoku/displaySettings/update/:displayId', controller.updateDisplaySettings); //récupérer les valeurs choisies par l'utilisateur

//liste des routes POST
router.post('/solveBoard/', controller.solveBoard); //résolution récursive (solveur) d'une grille saisie
router.post('/sudoku/login/add', controller.addLogin); //enregistrement d'un nouveau compte utilisateur
router.post('/sudoku/login/modify', controller.amendActor); //modifications des données de compte utilisateur
router.post('/sudoku/login/delete', controller.deleteActor); //suppression du compte utilisateur
router.post('/sudoku/login/connect', controller.connect); //création d'une session après connexion utilisateur


//aucune route trouvée, gestion de la 404
router.use((req, res) => {
    res.status('404').render('404');
});

module.exports = router;