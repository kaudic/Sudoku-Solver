const client = require('../config/db');

module.exports = {

    async insertNewBoards(boards) {
        // grilles doivent être séparées par des guillemets
        const transformedBoard = boards
            .replace('[[[', '[[')
            .replace(']]]', ']]')
            .split(']],')
            .join(']]]],')
            .split(']],');

        const sqlQery = {
            text: 'INSERT INTO "board" ("board_data") SELECT * FROM UNNEST ($1::text[])',
            values: [transformedBoard],
        };

        const results = await client.query(sqlQery);
        return results.rows;
    },

    async deleteOneBoardById(id) {
        const sqlQuery = {
            text: 'DELETE FROM board WHERE board_id = $1',
            values: [id],
        };

        const results = await client.query(sqlQuery);
        return results.rows;
    },

};
