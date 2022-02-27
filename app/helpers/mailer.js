const nodemailer = require('nodemailer');
const debug = require('debug')('helper:mailer');

const mailTransporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'killianaudic@gmail.com',
        pass: process.env.MAIL_PASS,
    },
});

module.exports = (contact) => {
    mailTransporter.sendMail({
        from: {
            name: 'SUDOKU SOLVER',
            address: 'killianaudic@gmail.com',
        },
        to: 'killianaudic@gmail.com',
        subject: `Nouveau compte sur Sudoku: ${contact.surname.toUpperCase()} - ${contact.firstname}`,
        html:
            `<p><b>Firstname: </b>${contact.name}</p>
         <p><b>Lastname: </b>${contact.surname.toUpperCase()}</p>
         <p><b>Email: </b>${contact.email}</p>
         <p><b>Pseudo: </b>${contact.login}</p>`,
    }, (err) => {
        if (err) {
            debug(err, err.message);
        }
    });
};
