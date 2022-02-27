const client = require('../config/db');

module.exports = {

    async createUser({
        login, password, name, surname, email,
    }) {
        const sqlQuery = {
            text: 'INSERT INTO "actor" ("actor_login", "actor_password", "actor_name","actor_surname","actor_email", "actor_role_id") VALUES ($1,$2,$3,$4,$5,$6) RETURNING *;',
            // le 2 fait référence à un profil VISITOR (table role)
            values: [login, password, name, surname, email, 2],
        };

        // insertion du nouveau compte puis le controller fera un render de la vue
        const results = await client.query(sqlQuery);

        if (results.rows === 0) {
            return false;
        }

        return true;
    },

    async getOneUserByIdOrEmail({ login, email }) {
        const sqlQuery = {
            text: 'SELECT * FROM actor a INNER JOIN role r ON a.actor_role_id = r.role_id WHERE actor_login = $1 OR actor_email=$2',
            values: [login, email],
        };

        const results = await client.query(sqlQuery);
        return results;
    },

    async getOnePassword(email) {
        const sqlQuery = {
            text: 'SELECT actor_password FROM actor WHERE actor_email = $1',
            values: [email],
        };

        const result = await client.query(sqlQuery);
        return result.rows[0].actor_password;
    },

    async updateOneUser({
        login, name, surname, email, password, id,
    }) {
        // j'enlève les espaces du login dans la requête car je n'arrivais pas à le faire en JS
        const sqlQuery = {
            text: `UPDATE actor
            SET actor_login = replace($1,' ',''),
            actor_name= $2,
            actor_surname= $3,
            actor_email= $4,
            actor_password=$5
            WHERE actor_id = $6`,
            values: [login, name, surname, email, password, id],
        };

        const results = await client.query(sqlQuery);
        return results;
    },

    async deleteOneUser(id) {
        const sqlQuery = {
            text: 'DELETE FROM actor WHERE actor_id = $1',
            values: [id],
        };

        const results = await client.query(sqlQuery);
        return results;
    },
};
