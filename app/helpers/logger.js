const bunyan = require('bunyan');

const logger = bunyan.createLogger({
    name: 'sudoku',
    streams: [
        {
            level: 'error', // On ne conserve que les logs a partir du niveau error
            path: './app/log/error.log', // Le chemin du fichier de log (on pense à l'ignorer dans git)
            type: 'rotating-file', // on précise que l'on va faire une rotation de fichiers (Nouveau fichier dans une période défini + historique de fichiers conservés)
            period: '1d', // rotation des fichiers de log journalière
            count: 3, // On garde un historique de 3 fichiers de log (Donc ici 3 jours)
        },
    ],
});

module.exports = logger;
