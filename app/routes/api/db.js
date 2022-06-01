const express = require('express');
const multer = require('multer')();

const handler = require('../../helpers/handler');
const { dbController: controller } = require('../../controllers/api');
const webSiteController = require('../../controllers/website');
const validate = require('../../validation/validator');
const schema = require('../../validation/schemas/generatorSchema');

const router = express.Router();

// créer de nouvelles grilles en base de données
router.route('/generate')
    .post(handler(webSiteController.adminAuth), multer.none(), validate('body', schema), handler(controller.dataBaseWrite));

// supprimer une grille en base de données
router.route('/delete/:id(\\d+)')
    .get(handler(webSiteController.adminAuth), handler(controller.deleteBoard));

module.exports = router;
