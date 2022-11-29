const { fork } = require('child_process');
const path = require('path');
const dataMapper = require('../../models/db');

const controller = {

    async dataBaseWrite(req, res) {
        const qty = req.body.qtyNewBoard;
        // eslint-disable-next-line no-path-concat, prefer-template
        const childRoute = path.normalize(__dirname + '/../../childProcess/generator');

        // Launching a child process for generating massive quantities of boards
        const boardGeneratorChildProcess = fork(childRoute, [`--qtyNewBoard=${qty}`]);

        boardGeneratorChildProcess.on('message', () => {
            console.log('Board Generator Process finished');
            // Sending answer
            res.json({
                result: true,
                message: 'New boards are well generated and inserted in database'
            });
        });

        boardGeneratorChildProcess.send('START');
    },

    async deleteBoard(req, res) {
        const id = Number(req.params.id);
        await dataMapper.deleteOneBoardById(id);
        return res.redirect('/sudoku/database/');
    },
};

module.exports = controller;
