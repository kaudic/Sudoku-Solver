const express = require('express');
const handler = require('../../helpers/handler');

// TODO faire les schémas de validation avec Joi
// Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');

// Import des contrôleurs avec des alias
const { settingsController: controller } = require('../../controllers/api');

const router = express.Router();

router.route('/colors/:userId')
    .get(handler(controller.getDisplaySettings))
    .patch(handler(controller.updateDisplaySettings))

module.exports = router;
