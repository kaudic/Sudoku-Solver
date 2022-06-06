const client = require('../config/db');

module.exports = {

    async getDisplaySettingsById(id) {
        const sqlQuery = {
            text: 'SELECT d.display_type, d.display_color1,d.display_color2,d.display_color3,d.display_color4,d.display_color5 FROM actor a INNER JOIN display d ON a.actor_display_id = d.display_id WHERE a.actor_id=$1',
            values: [id],
        };
        const results = await client.query(sqlQuery);
        return results.rows;
    },
    async getDefaultDisplaySettings() {
        const sqlQuery = {
            text: 'SELECT display_type, display_color1,display_color2,display_color3,display_color4,display_color5 FROM "display" WHERE display_id=1',
            values: [],
        };
        const results = await client.query(sqlQuery);
        return results.rows;
    },
    async updateDisplaySettingsById(id, displayId) {
        const sqlQuery = {
            text: 'UPDATE actor SET actor_display_id = $1 WHERE actor_id =$2',
            values: [displayId, id],
        };

        const results = await client.query(sqlQuery);
        return results.rows;
    },
    async getLegalNotice() {
        const result = await client.query('SELECT * FROM legal_notice ORDER BY id ASC LIMIT 1');
        return result.rows[0];
    },
    async getLogs() {
        const sqlQuery = {
            text: 'SELECT * FROM logs ORDER BY id DESC LIMIT 100',
            values: [],
        };
        const result = await db.query(sqlQuery);
        return result.rows;
    },
};
