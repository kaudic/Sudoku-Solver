const express = require('express');
const router = express.Router();
const handler = require('../../helpers/handler');

// TODO faire les schémas de validation avec Joi
// Import du système de validation des données au niveau applicatif
// const validate = require('../../validation/validator');
// const schema = require('../../validation/schemas/postSchema');
// Import des contrôleurs avec des alias
const { dbController: controller } = require('../../controllers/api');

// créer de nouvelles grilles en base de données
router.route('/generate')
    .get(handler(controller.dataBaseWrite));

// supprimer une grille en base de données
router.route('/:id(\\d+)')
    .delete(handler(controller.deleteBoard));

module.exports = router;
