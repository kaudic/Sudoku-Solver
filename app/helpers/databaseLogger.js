// imports of dataMapper
const dbDatamapper = require('../models/db');

const databaseLogger = async (req, err) => {
    // calculate iso Date of today yyy-mm-dd
    const isoDate = new Date().toISOString().substring(0, 10);
    const logs = {
        date_of_logs: isoDate,
        hostname: req.hostname,
        ip_address: req.ip,
        headers: JSON.stringify(req.headers),
        url: req.originalUrl,
        logs_error: err.message,
    };
    await dbDatamapper.insertLogs(logs);
};

module.exports = databaseLogger;
