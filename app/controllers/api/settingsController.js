const dataMapper = require('../../models/board');

const controller = {

    getDisplaySettings: (req, res) => {

        //on récupère l'ID de l'utilisateur connecté dans la session
        const id = req.session.actorConnected.id;

        //Appel du dataMapper pour rechercher les couleurs de cet utilisateur

        dataMapper.getDisplaySettingsById(id, (error, colors) => {
            if (error) {
                res.status(500).send('500');
                return;
            }
            else {

                const response = {
                    display_type: (colors[0].display_type),
                    display_color1: (colors[0].display_color1),
                    display_color2: (colors[0].display_color2),
                    display_color3: (colors[0].display_color3),
                    display_color4: (colors[0].display_color4),
                    display_color5: (colors[0].display_color5)
                };

                res.setHeader('Access-Control-Allow-Origin', '*');
                console.log('response: ' + JSON.stringify(response));
                res.send(response);

            }

        })
    },

    updateDisplaySettings: (req, res) => {

        const displayId = req.params.displayId;
        const actorId = req.session.actorConnected.id;

        console.log('displayID: ' + displayId);
        console.log('actorID: ' + actorId);

        dataMapper.updateDisplaySettingsById(actorId, displayId, (error, results) => {
            if (error) {
                res.status(500).send('500');
                return;
            }
            else {
                res.setHeader('Access-Control-Allow-Origin', '*');
                console.log('response: ' + JSON.stringify(results));
                res.send(results);

            }
        })
    },

};

module.exports = controller;