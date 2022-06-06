const dataMapper = require('../../models/settings');

const controller = {

    async getDisplaySettings(req, res) {
        let colors = '';
        // if we have a session we will get the actor id and get his preferred display settings
        if (req.session.actorConnected) {
            const { id } = req.session.actorConnected;
            // Appel du dataMapper pour rechercher les couleurs de cet utilisateur
            colors = await dataMapper.getDisplaySettingsById(id);
        } else {
            // if we don't have a session, we will send default display values
            colors = await dataMapper.getDefaultDisplaySettings();
        }
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
    async getCurrentLegalNotice(req, res) {
        const legalNoticeText = await dataMapper.getLegalNotice();
        if (!legalNoticeText) {
            return res.status(500).json({
                result: false,
                description: 'there is no legal notice yet in the database'
            });
        }
        return res.json({
            result: true,
            description: 'the legal notice was well got, check legalNoticeText attribute of the present json',
            legalNoticeText
        });
    },
    async renderLogs(req, res) {
        const logs = await dataMapper.getLogs();
        res.json(logs);
    }
};

module.exports = controller;
