const errorObject = {
    errorHandler: function (err, req, res, next) {

        console.log(err);
        res.status(500).send({ error: 'Internal Error Occured.' });
        return;
    },
};

module.exports = errorObject;
