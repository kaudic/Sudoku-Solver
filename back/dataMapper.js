const client = require('./bdd');

const dataMapper = {

    createUser: ({ actor_login, actor_password, actor_name, actor_surname, actor_email }, callback) => {

        const sqlQuery = {
            text: 'INSERT INTO "actor" ("actor_login", "actor_password", "actor_name","actor_surname","actor_email") VALUES ($1,$2,$3,$4,$5);',
            values: [actor_login, actor_password, actor_name, actor_surname, actor_email]
        };

        //TODO avant d'insérer la valeur il faudrait que l'on vérifie si l'utilisateur est déjà créé ou non

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

    }

};

module.exports = dataMapper;