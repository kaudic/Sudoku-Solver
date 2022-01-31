//importation et gestion des modules externes
require('dotenv').config();
const http = require('http');
//TODO mettre en place le debug
// const debug = require('debug')('app:server');
const app = require('./app');

const port = process.env.PORT ?? 3000;

const server = http.createServer(app);

server.listen(port, () => {
    debug(`Listening on ${port}`);
});
