const debug = require('debug')('Validator:log');
const SudokError = require('../errors/sudokError');

/**
 * Générateur de middleware pour la validation des boards à résoudre
 * @param {string} board - variable à vérifier
 * @param {Joi.object} schema - Le schema de validation du module Joi
 * @returns {Function} -
 * Renvoi un middleware pour express qui valide
 * le corp de la requête en utilisant le schema passé en paramètre.
 * Renvoi une erreur 400 si la validation échoue.
 */
module.exports = (schema) => async (request, _, next) => {
    try {
        debug(request.body);
        await schema.validateAsync(request.body);
        next();
    } catch (error) {
        // Je dois afficher l'erreur à l'utilisateur
        // STATUS HTTP pour une erreur de saisie : 400
        // On réhabille l'erreur en suivant notre propre normalisation
        next(new SudokError(400, error.details[0].message));
    }
};
