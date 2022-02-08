const client = require('../config/db');

module.exports = {

    async getOneRandomBoard() {
        const results = await client.query('SELECT * FROM board ORDER BY random() LIMIT 1');
        return results.rows[0];
    },

    async getOneBoardById(id) {
        const sqlQuery = {
            text: 'SELECT * FROM board WHERE board_id = $1',
            values: [id],
        };
        const results = await client.query(sqlQuery);
        return results.rows[0];
    },

    async getAllBoards() {
        const results = await client.query('SELECT COUNT(*) OVER(), board_id, board_data  FROM board;');
        return results.rows;
    },
};
