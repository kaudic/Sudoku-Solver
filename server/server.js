
// eslint-disable-next-line no-undef
const http = require('http');
// eslint-disable-next-line no-undef
const fs = require('fs');


const server = http.createServer((req, res) => {

    if (req.url === '/database') {

        fs.readFile('./boardDatabase.json', (err, data) => {
            if (err) throw err;
            console.log('boardDatabase: ' + data);
            res.setHeader('Content-Type', 'application/json');
            res.setHeader('Access-Control-Allow-Origin', '*');
            res.end(data);
        });


    }

});

server.listen(3000);

console.log('server listenning port 3000...');
