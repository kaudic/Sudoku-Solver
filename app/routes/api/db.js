const express = require('express');
const handler = require('../../helpers/handler');
const { dbController: controller } = require('../../controllers/api');
const validate = require('../../validation/validator');
const schema = require('../../validation/schemas/generatorSchema');

const router = express.Router();

// créer de nouvelles grilles en base de données
router.route('/generate')
    .get(validate('query', schema), handler(controller.dataBaseWrite));

// supprimer une grille en base de données
router.route('/:id(\\d+)')
    .delete(handler(controller.deleteBoard));

module.exports = router;
