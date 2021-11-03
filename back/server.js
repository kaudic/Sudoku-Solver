//importation et gestion des modules
const express = require('express');
const app = express();
const fs = require('fs');


app.get('/database', (req, res) => {

    fs.readFile('./boardDatabase.js', (err, data) => {
        if (err) throw err;
        const boardData = JSON.parse(data);
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.send(boardData[1]);
    });

});

app.listen(3000, () => console.log('server running and listenning to port 3000'));
