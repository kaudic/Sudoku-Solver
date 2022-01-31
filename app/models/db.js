const client = require('../config/db');
//importer les autres models si besoin
//importer les éventuelles classes d'erreur

//TODO enlever le système de callbacks et remplacer par un système async/await

module.exports = {

    insertNewBoards: (boards, callback) => {

        const transformedBoard = boards  //étapes obligatoires pour que les grilles soient séparées par des guillemets, sinon la requête préparée ne fonctionne pas
            .replace('[[[', '[[')
            .replace(']]]', ']]')
            .split(']],')
            .join(']]]],')
            .split(']],');

        // const parsedBoard = JSON.parse(transformedBoard);

        const sqlQery = {
            // text: `INSERT INTO "board" ("board_data") SELECT * FROM UNNEST ($1::text[])`,
            text: `INSERT INTO "board" ("board_data") SELECT * FROM UNNEST ($1::text[])`,
            values: [transformedBoard]
        };

        client.query(sqlQery, (error, results) => {
            if (error) {
                console.log(error);
                callback(error, false);
            } else {
                callback(undefined, results.rows);
            }
        });

    },

    deleteOneBoardById: (id, callback) => {

        const sqlQuery = {
            text: 'DELETE FROM board WHERE board_id = $1',
            values: [id]
        };

        client.query(sqlQuery, (error, results) => {
            if (error) {
                callback(error, false);
                console.log('error: ' + error);
            } else {
                callback(undefined, results.rows);
            }
        });
    },









};