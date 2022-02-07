const Joi = require('joi');

module.exports = Joi.object({
    data: Joi.string()
        .pattern(/^\[(\[([0-9],)+[0-9]\],){8}\[([0-9],){8}[0-9]\]\]$/)
        .required(),
}).required();
