// ! not used because control of data is made in the controller itself
// ! it is easier to send the message to a proper EJS page this way
const Joi = require('joi');

module.exports = Joi.object({
    login: Joi.string().required(),
    name: Joi.string().required(),
    surname: Joi.string().required().label('Le nom de famille est obligatoire.'),
    email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net', 'fr'] } }).required(),
    password: Joi.string().required(),
}).required();
