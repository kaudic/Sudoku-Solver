const serverMethods = {

    getRandomNumber: (min, max) => {
        return Math.floor(Math.random() * (max - min) + min);

    },

    emptyCells: function (stringBoard, goalOfCellsEmptyPerLine) {

        const board = JSON.parse(stringBoard);

        //TODO on récupère l'objectif de suppression de cellules, par contre ça ne semble pas fonctionner systématiquement

        for (let line = 0; line < 9; line++) {

            let numberOfCellsEmptyPerLine = 0;

            while (numberOfCellsEmptyPerLine < goalOfCellsEmptyPerLine) {
                const randomNumber = serverMethods.getRandomNumber(0, 10);

                if (board[line][randomNumber] !== '') {
                    board[line][randomNumber] = '';
                }

                numberOfCellsEmptyPerLine = 0;

                board[line].forEach((element) => {

                    if (element === '') {

                        numberOfCellsEmptyPerLine++;
                    }
                });
            }

        }
        return board;
    },

    takeOutNumbersFromBoard: (level, board) => {

        let goalOfCellsEmptyPerLine = 0;

        switch (level) {

            case 'Facile1':

                goalOfCellsEmptyPerLine = 2; //on enlève 2 chiffres à chaque ligne
                break; //

            case 'Facile2':
                goalOfCellsEmptyPerLine = 3; //on enlève 3 chiffres à chaque ligne
                break;

            case 'Moyen':
                goalOfCellsEmptyPerLine = 4; // ...
                break;

            case 'Difficile':
                goalOfCellsEmptyPerLine = 5;
                break;

            case 'Démoniaque':
                goalOfCellsEmptyPerLine = 6;
                break;

        }
        return serverMethods.emptyCells(board, goalOfCellsEmptyPerLine);
    },

};

module.exports = serverMethods;