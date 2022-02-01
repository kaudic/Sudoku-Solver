const express = require('express');

const router = express.Router();

// TODO faire les schémas de validation avec Joi
// Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');
// Import des contrôleurs avec des alias
const { dbController: controller } = require('../../controllers/api');

// TODO faire le handler
// Import du controllerHandler pour factoriser le try/catch et la levée des erreurs const controllerHandler = require('../../helpers/apiControllerHandler');

router.route('/generate')
  .get(controller.dataBaseWrite); // créer de nouvelles grilles en base de données

router.route('/:id')
  .delete(controller.deleteBoard); // créer de nouvelles grilles en base de données

module.exports = router;
