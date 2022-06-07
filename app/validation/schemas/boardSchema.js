const Joi = require('joi');

// module.exports = Joi.object({
//     emptyCells: Joi.array().max(81).min(1)
//         .items(Joi.string()
//             .pattern(/^(\d){2}$/))
//         .required(),
//     ligne: Joi.array()
//         .items(Joi.array().items(Joi.number().integer().min(0).max(9)).length(9))
//         .length(9)
//         .required(),
//     column: Joi.array()
//         .items(Joi.array().items(Joi.number().integer().min(0).max(9)).length(9))
//         .length(9)
//         .required(),
//     square: Joi.array()
//         .items(Joi.array().items(Joi.number().integer().min(0).max(9)).length(9))
//         .length(9)
//         .required(),

// }).required();

module.exports = Joi.array()
    .items(Joi.array().items(Joi.number().integer().min(0).max(9)).length(9))
    .length(9)
    .required();
