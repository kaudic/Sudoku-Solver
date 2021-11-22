//importation et gestion des modules externes
require("dotenv").config();
const express = require('express');
const router = require('./my_modules/router');
const app = express();
const session = require("express-session");

app.set('views', '../front/views');
app.set('view engine', 'ejs');
app.use(express.static('../front/assets'));

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.use(router);

app.listen(3000, () => console.log('server running and listenning to port 3000'));
