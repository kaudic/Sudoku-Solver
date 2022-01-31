const client = require('../config/db');
//importer les autres models si besoin
//importer les éventuelles classes d'erreur

//TODO enlever le système de callbacks et remplacer par un système async/await

module.exports = {


    getOneRandomBoard: (callback) => {

        const sqlQuery = `SELECT * FROM board ORDER BY random() LIMIT 1;`;

        client.query(sqlQuery, (error, results) => {
            if (error) {
                callback(error, false);
            } else {
                callback(undefined, results.rows[0]);
            }
        });
    },

    getOneBoardById: (id, callback) => {

        const sqlQuery = {
            text: `SELECT * FROM board WHERE board_id = $1;`,
            values: [id]
        };

        client.query(sqlQuery, (error, results) => {
            if (error) {
                callback(error, false);
            } else {
                callback(undefined, results.rows[0]);
            }
        });
    },

    getAllBoards: (callback) => {

        const sqlQuery = `SELECT COUNT(*) OVER(), board_id, board_data  FROM board;`;

        client.query(sqlQuery, (error, results) => {
            if (error) {
                callback(error, false);
            } else {

                callback(undefined, results.rows);
            }
        });
    },

};