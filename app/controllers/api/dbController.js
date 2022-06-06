const { fork } = require('child_process');
const path = require('path');


const controller = {

    async dataBaseWrite(req, res) {
        const qty = Number(req.body.qtyNewBoard);
        const childRoute = path.normalize(__dirname + '/../../childProcess/generator');
        console.log('-----------------------------------------------------------------------------------------------')
        console.log(childRoute);
        // TODO launch a child process for generating massive boards
        const boardGeneratorChildProcess = fork(childRoute);

        boardGeneratorChildProcess.on('message', (message) => {
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
