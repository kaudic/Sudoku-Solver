require('dotenv').config();
const debug = require('debug')('app:server');
const https = require('http');
const fs = require('fs');

const app = require('./app');

const port = process.env.PORT ?? 3004;

// Get Certificate
const privateKey = fs.readFileSync('/etc/letsencrypt/live/www.planitools.com/privkey.pem', 'utf8');
const certificate = fs.readFileSync('/etc/letsencrypt/live/www.planitools.com/cert.pem', 'utf8');
const ca = fs.readFileSync('/etc/letsencrypt/live/www.planitools.com/chain.pem', 'utf8');

const credentials = {
    key: privateKey,
    cert: certificate,
    ca: ca
};

const server = https.createServer(credentials, app);

// const server = http.createServer(app);

server.listen(port, () => {
    debug(`Listening on ${port}`);
});
