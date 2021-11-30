const client = require('./bdd');

const dataMapper = {

    createUser: ({ actor_login, actor_password, actor_name, actor_surname, actor_email }, callback) => {

        const sqlQuery = {
            text: 'INSERT INTO "actor" ("actor_login", "actor_password", "actor_name","actor_surname","actor_email", "actor_role_id") VALUES ($1,$2,$3,$4,$5,$6);',
            values: [actor_login, actor_password, actor_name, actor_surname, actor_email, 2] //le 2 fait référence à un profil VISITOR (table role)
        };



        //insertion du nouveau compte et envoie des résultats ou erreur à la callback dans laquelle on fera un render de la vue
        client.query(sqlQuery, (err, results) => {
            console.log('results from query: ' + JSON.stringify(results.rows));
            if (err) {
                callback(err, results);
            }
            else if (results.rows === 0) {
                callback(undefined, false);
            }
            else {
                callback(undefined, true);
            }

        });

    },

    getOneUser: (login, callback) => {

        const sqlQuery = {
            text: 'SELECT * FROM actor a INNER JOIN role r ON a.actor_role_id = r.role_id WHERE actor_login = $1',
            values: [login]
        };

        client.query(sqlQuery, (error, results) => {

            if (error) {
                callback(error, results.rows);
            }
            else {
                callback(undefined, results.rows);
            }

        });
    },

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

    updateOneUser: ({ actor_login, actor_name, actor_surname, actor_email, actor_id }, callback) => {

        // j'enlève les espaces du login dans la requête car je n'arrivais pas à le faire en JS
        const sqlQuery = {
            text: `UPDATE actor 
            SET actor_login = replace($1,' ',''), 
            actor_name= $2, 
            actor_surname= $3, 
            actor_email= $4
            WHERE actor_id = $5`,
            values: [actor_login, actor_name, actor_surname, actor_email, actor_id]
        };

        client.query(sqlQuery, (error, results) => {
            if (error) {
                console.log('error: ' + error);
                callback(error, false);
            } else {
                callback(undefined, results);
            }
        });

    },

    deleteOneUser: (id, callback) => {

        const sqlQuery = {
            text: `DELETE FROM actor WHERE actor_id = $1`,
            values: [id]
        };

        client.query(sqlQuery, (error, results) => {

            if (error) {
                callback(error, false);
                return;
            } else {
                callback(undefined, results);
            }

        });

    },

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

    getDisplaySettingsById: (id, callback) => {

        const sqlQuery = {
            text: `SELECT d.display_color1,d.display_color2,d.display_color3,d.display_color4,d.display_color5
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

module.exports = dataMapper;