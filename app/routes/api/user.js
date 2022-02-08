const express = require('express');
const handler = require('../../helpers/handler');
const validate = require('../../validation/validator');
const schema = require('../../validation/schemas/userSchema');
const { userController: controller } = require('../../controllers/api');

const router = express.Router();

router.route('/account/:userId(\\d+)')
    .post(validate('body', schema), handler(controller.addLogin))
    .patch(validate('body', schema), handler(controller.amendActor))
    .delete(handler(controller.deleteActor));

// création d'une session après connexion utilisateur
router.route('/login')
    .post(handler(controller.connect));

module.exports = router;
