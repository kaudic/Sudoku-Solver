const express = require('express');
const cors = require('cors');
const session = require('express-session');
const favicon = require('serve-favicon');
const path = require('path');
const router = require('./routes');

const app = express();
require('./helpers/apiDocs')(app);
app.use(favicon(path.normalize(`${__dirname}/../public/images/favicon.ico`)));
app.set('views', `${process.cwd()}/app/views`);
app.set('view engine', 'ejs');

app.use(express.static('./public'));

// On active le middleware pour parser le payload JSON
app.use(express.json());
// On active le middleware pour parser le payload urlencoded
app.use(express.urlencoded({ extended: true }));

// On lève la restriction CORS pour nos amis React
app.use(cors(process.env.CORS_DOMAINS ?? '*'));

// We give the locals the NODE_ENV info to send localhost BASE_URL or prod BASE_URL
app.use((_, res, next) => {
    res.locals.NODE_ENV = process.env.NODE_ENV;
    next();
});

app.use(session({
    secret: 'sudoku style',
    resave: true,
    saveUninitialized: true,
    cookie: {
        // secure: true,
        maxAge: 60000 * 60, /* 1 hour */
    },

}));


// variable à transmettre à EJS
app.use((req, res, next) => {
    console.log('-----------------------------------------------------------------------------------------------------------');
    console.log('req.session.actorConnected: ' + req.session.actorConnected);
    res.locals.actorConnected = req.session.actorConnected;
    res.locals.baseUrl = `${process.env.BASE_URL}`;
    next();
});

app.use(router);

module.exports = app;
