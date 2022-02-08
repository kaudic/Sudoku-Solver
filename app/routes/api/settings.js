const express = require('express');
const handler = require('../../helpers/handler');

// Import des contrôleurs avec des alias
const { settingsController: controller } = require('../../controllers/api');

const router = express.Router();

router.route('/colors/:userId(\\d+)')
    .get(handler(controller.getDisplaySettings))
    .patch(handler(controller.updateDisplaySettings));

module.exports = router;
