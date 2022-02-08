const express = require('express');
const handler = require('../../helpers/handler');

// Import des contrôleurs avec des alias
const { settingsController: controller } = require('../../controllers/api');

const router = express.Router();

router.route('/colors/:userId(\\d+)')
    .put(handler(controller.updateDisplaySettings));

router.route('/colors/')
    .get(handler(controller.getDisplaySettings))

module.exports = router;
