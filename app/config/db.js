//TODO passer en mode pool
const { Client } = require("pg");

// ecrire {Client} est une ecriture ES6 "destructuré" (destructuring)
// cela équivaut à const Client = require("pg").Client;
// On ce connecte à la bdd local
// (on ne cherche pas à comprendre ce que fait ce new, on vera ça en saison5)

const client = new Client({
    user: process.env.DB_USER,
    password: process.env.DB_USER_PASSWORD,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
});

client.connect();

module.exports = client;