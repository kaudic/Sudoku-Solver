module.exports = {

    getRandomNumber(min, max) {
        return Math.floor(Math.random() * (max - min) + min);
    },

    getArrayOfRandNum({ min, max, arrayLen }) {
        const randomNumbersArray = [];

        while (randomNumbersArray.length < arrayLen) {
            const randomNumber = this.getRandomNumber(min, max);
            if (!this.isNumberInArray(randomNumber, randomNumbersArray)) {
                randomNumbersArray.push(randomNumber);
            }
        }
        return randomNumbersArray;
    },

    isNumberInArray(number, array) {
        const isFound = array.find((element) => element === number);
        if (!isFound) {
            return false;
        }
        return true;
    },

    wipeCells(stringBoard, goalOfCellsEmptyPerLine) {
        const board = JSON.parse(stringBoard);

        board.forEach((boardLine) => {
            const arrOfRanNum = this.getArrayOfRandNum({
                min: 0,
                max: 9,
                arrayLen: goalOfCellsEmptyPerLine,
            });

            arrOfRanNum.forEach((number) => {
                boardLine[number] = '';
            });
        });
        return board;
    },

    emptyCellsPerLevel(level) {
        switch (level) {
            case 'Facile1':
                return 2;
            case 'Facile2':
                return 3;
            case 'Moyen':
                return 4;
            case 'Difficile':
                return 5;
            default:
                return 6;
        }
    },

};
