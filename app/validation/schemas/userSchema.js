const Joi = require('joi');

module.exports = Joi.object({
    id: Joi.integer().pattern(/^(\d+)$/).required(),
    login: Joi.string().required(),
    name: Joi.string().required(),
    surname: Joi.string().required(),
    email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net'] } }).required(),
}).required();
