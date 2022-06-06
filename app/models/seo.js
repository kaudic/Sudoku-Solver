const client = require('../config/db');

module.exports = {

    async getSiteMapText() {
        const sqlQuery = {
            text: 'SELECT file_text FROM "sitemap" WHERE id=1',
            values: [],
        };
        const result = await client.query(sqlQuery);
        return result.rows[0];
    },
    async getRobotsText() {
        const sqlQuery = {
            text: 'SELECT file_text FROM "robots" WHERE id=1',
            values: [],
        };
        const result = await client.query(sqlQuery);
        return result.rows[0];
    },

};
