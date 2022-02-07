const express = require('express');
const handler = require('../../helpers/handler');

// TODO faire les schémas de validation avec Joi
// Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');

// Import des contrôleurs avec des alias
const { userController: controller } = require('../../controllers/api');

const router = express.Router();

router.route('/account/:userId')
    .post(handler(controller.addLogin))
    .patch(handler(controller.amendActor))
    .delete(handler(controller.deleteActor));

// création d'une session après connexion utilisateur

router.route('/login')
    .post(handler(controller.connect));

module.exports = router;
