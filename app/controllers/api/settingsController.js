const dataMapper = require('../../models/settings');

const controller = {

    async getDisplaySettings(req, res) {
        // on récupère l'ID de l'utilisateur connecté dans la session
        const { id } = req.session.actorConnected;

        // Appel du dataMapper pour rechercher les couleurs de cet utilisateur
        const colors = await dataMapper.getDisplaySettingsById(id);

        return res.json({
            display_type: (colors[0].display_type),
            display_color1: (colors[0].display_color1),
            display_color2: (colors[0].display_color2),
            display_color3: (colors[0].display_color3),
            display_color4: (colors[0].display_color4),
            display_color5: (colors[0].display_color5),
        });
    },

    async updateDisplaySettings(req, res) {
        const { displayId } = req.params;
        const actorId = req.session.actorConnected.id;

        const results = await dataMapper.updateDisplaySettingsById(actorId, displayId);
        res.json(results);
    },
};

module.exports = controller;
