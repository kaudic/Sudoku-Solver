const express = require('express');
const cors = require('cors');
const session = require('express-session');
const router = require('./routes');

const app = express();
require('./helpers/apiDocs')(app);

app.set('views', `${process.cwd()}/app/views`);
app.set('view engine', 'ejs');

// !cette ligne ne figure pas dans le repo de Yann
app.use(express.static('./public'));

// On active le middleware pour parser le payload JSON
app.use(express.json());
// On active le middleware pour parser le payload urlencoded
app.use(express.urlencoded({ extended: true }));

// On lève la restriction CORS pour nos amis React
app.use(cors(process.env.CORS_DOMAINS ?? '*'));

// TODO voir pour remplacer le système de session par un jwt
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
    res.locals.actorConnected = req.session.actorConnected;
    res.locals.baseUrl = `${process.env.BASEURL}:${process.env.PORT}`;
    next();
});

app.use(router);

module.exports = app;
