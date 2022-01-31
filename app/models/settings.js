const client = require('../config/db');
//importer les autres models si besoin
//importer les éventuelles classes d'erreur

//TODO enlever le système de callbacks et remplacer par un système async/await

module.exports = {

    getDisplaySettingsById: (id, callback) => {

        const sqlQuery = {
            text: `SELECT d.display_type, d.display_color1,d.display_color2,d.display_color3,d.display_color4,d.display_color5
            FROM actor a INNER JOIN display d ON a.actor_display_id = d.display_id 
            WHERE a.actor_id=$1`,
            values: [id]
        };

        client.query(sqlQuery, (error, results) => {
            if (error) {
                callback(error, false);
                console.log('error: ' + error);
                return;
            } else {
                callback(undefined, results.rows);
            }
        });

    },

    updateDisplaySettingsById: (id, displayId, callback) => {
        const sqlQuery = {
            text: `UPDATE actor SET actor_display_id = $1 WHERE actor_id =$2`,
            values: [displayId, id]
        };

        client.query(sqlQuery, (error, results) => {
            if (error) {
                callback(error, false);
                console.log('error: ' + error);
                return;
            } else {
                callback(undefined, results.rows);
            }
        });

    }


};