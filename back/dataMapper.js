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

};

module.exports = dataMapper;