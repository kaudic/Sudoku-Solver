const express = require('express');
const router = express.Router();

//Importation du contrôleur dédié au website
const { websiteController: controller } = require('../../controllers/website');

//TODO faire un contrôleurHandler afin de gérer le try/catch et la levée des erreurs
//Importation du contrôleurHandler
// const controllerHandler = require('../../helpers/websiteControllerHandler');

//TODO créer les erreurs spécifiques 
//Importation des erreurs spécifiques au website
// const { WebsiteError } = require('../../helpers/errorHandler');


router.get('/', controller.home); //page d'accueil
router.get('/login', controller.login); // pas de connexion
router.get('/deconnect', controller.deconnect); // déconnection (on shoote la session)
router.get('/Login/FormCreation', controller.formCreation); //Formulaire de création de compte
router.get('/myAccount/:login', controller.displayAccount); //afficher les infos de compte et pouvoir les modifier
router.get('/database/', controller.adminAuth, controller.databaseRead); //TODO passer admin comme un argument de fonction

//TODO après création des erreurs spécifiques
// router.use(() => {
//     throw new WebsiteError(404, 'Page introuvable');
// });

module.exports = router;