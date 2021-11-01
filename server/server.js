const boardDatabase =
    [
        [
            [0, 0, 4, 6, 0, 0, 0, 8, 0], // Vraie grille mais les 0 sont normalement des ''
            [3, 0, 5, 0, 1, 0, 0, 6, 7],
            [6, 0, 0, 0, 5, 3, 9, 0, 0],
            [9, 0, 0, 0, 8, 0, 0, 0, 0],
            [0, 1, 0, 0, 2, 6, 4, 0, 0],
            [4, 0, 0, 0, 0, 0, 5, 1, 0],
            [0, 0, 6, 0, 0, 1, 0, 0, 0],
            [0, 0, 1, 7, 9, 0, 0, 0, 2],
            [0, 3, 0, 0, 6, 2, 0, 7, 0],
        ],
        [
            [1, 2, 3, 4, 5, 6, 7, 8, 9], //Grille de test
            [3, 0, 5, 0, 1, 0, 0, 6, 7],
            [6, 0, 0, 0, 5, 3, 9, 0, 0],
            [9, 0, 0, 0, 8, 0, 0, 0, 0],
            [0, 1, 0, 0, 2, 6, 4, 0, 0],
            [4, 0, 0, 0, 0, 0, 5, 1, 0],
            [0, 0, 6, 0, 0, 1, 0, 0, 0],
            [0, 0, 1, 7, 9, 0, 0, 0, 2],
            [0, 3, 0, 0, 6, 2, 0, 7, 0],
        ]
    ];


const http = require('http');

const server = http.createServer((req, res) => {

    if (req.url === '/database') {

        res.setHeader('Content-Type', 'application/json');
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.end(JSON.stringify(boardDatabase[1]));
    }

});

server.listen(3000);

console.log('server listenning port 3000...');
