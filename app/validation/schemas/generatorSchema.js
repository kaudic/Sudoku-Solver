const Joi = require('joi');

module.exports = Joi.object({
    qtyNewBoard: Joi.number().integer().min(1).max(100)
        .required(),
}).required();
