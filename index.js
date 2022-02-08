require('dotenv').config();
const debug = require('debug')('app:server');
const http = require('http');

const app = require('./app');

const port = process.env.PORT ?? 3000;

const server = http.createServer(app);

server.listen(port, () => {
    debug(`Listening on ${port}`);
});
