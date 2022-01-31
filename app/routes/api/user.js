const express = require('express');

//TODO faire les schémas de validation avec Joi
//Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');

//Import des contrôleurs avec des alias
const { userController: controller } = require('../../controllers/api');

//TODO faire le handler
//Import du controllerHandler pour factoriser le try/catch et la levée des erreurs
// const controllerHandler = require('../../helpers/apiControllerHandler');

const router = express.Router();

router.route('/account/:userId')
    .post(controller.addLogin)
    .patch(controller.amendActor)
    .delete(controller.deleteActor)

router.route('/login')
    .post(controller.connect); //création d'une session après connexion utilisateur

module.exports = router;