const client = require('../config/db');
//importer les autres models si besoin
//importer les éventuelles classes d'erreur

//TODO enlever le système de callbacks et remplacer par un système async/await

module.exports = {

    createUser: ({ actor_login, actor_password, actor_name, actor_surname, actor_email }) => {

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

    updateOneUser: ({ actor_login, actor_name, actor_surname, actor_email, actor_id }) => {

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









};
