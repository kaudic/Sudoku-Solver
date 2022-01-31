const express = require('express');

//TODO faire les schémas de validation avec Joi
//Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');

//Import des contrôleurs avec des alias
const { settingsController: controller } = require('../../controllers/api');

//TODO faire le handler
//Import du controllerHandler pour factoriser le try/catch et la levée des erreurs
// const controllerHandler = require('../../helpers/apiControllerHandler');

const router = express.Router();

router.route('/colors/:userId')
    .get(controller.getDisplaySettings)
    .patch(controller.updateDisplaySettings)

module.exports = router;