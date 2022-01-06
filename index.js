//importation et gestion des modules externes
require('dotenv').config();
const express = require('express');
const router = require('./app/router');
const app = express();
const cors = require('cors');
const session = require("express-session");

app.use(cors({
    origin: '*',
}));

app.set('views', './views');
app.set('view engine', 'ejs');
app.use(express.static('./public'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.use(session({
    secret: 'sudoku style',
    resave: true,
    saveUninitialized: true,
    cookie: {
        // secure: true,
        maxAge: 60000 * 60 /* 1 hour */
    }

}));

app.use((req, res, next) => {
    res.locals.actorConnected = req.session.actorConnected;
    res.locals.baseUrl = `${process.env.BASEURL}:${process.env.PORT}`;
    next();
});

app.use(router);

app.listen(3000, () => console.log('server running and listenning to port 3000'));
