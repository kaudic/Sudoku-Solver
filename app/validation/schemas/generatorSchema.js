const Joi = require('joi');

module.exports = Joi.object({
    qtyNewBoard: Joi.integer()
        .pattern(/^(\d){3}$/)
        .required(),
}).required();
