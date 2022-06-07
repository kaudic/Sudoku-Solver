const functions = {

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
                return 3;
            case 'Facile2':
                return 4;
            case 'Moyen':
                return 5;
            case 'Difficile':
                return 6;
            default:
                return 7;
        }
    },
    loadSolverDataColumn(lineBoard) {
        const solverDataColumn = [[], [], [], [], [], [], [], [], []];
        for (let i = 0; i < 9; i++) {
            for (let j = 0; j < 9; j++) {
                solverDataColumn[j][i] = lineBoard[i][j];
            }
        }
        return solverDataColumn;
    },
    loadSolverDataSquare(lineBoard) {
        let solverDataSquare = [[], [], [], [], [], [], [], [], []];
        for (let i = 0; i < 9; i++) {
            for (let j = 0; j < 9; j++) {
                solverDataSquare = functions.writeInSquare(i, j, lineBoard[i][j], solverDataSquare);
            }
        }
        return solverDataSquare;
    },
    loadSolverDataEmptyCells(lineBoard) {
        const solverDataEmptyCells = [];
        for (let i = 0; i < 9; i++) {
            for (let j = 0; j < 9; j++) {
                if (lineBoard[i][j] === 0) {
                    solverDataEmptyCells.push(`${i}` + `${j}`);
                }
            }
        }
        return solverDataEmptyCells;
    },
    writeInSquare(numLigne, numColumn, inputValue, arrayToLoad) {
        // Gestion des 9 carrés, cela nécessite l'emploi d'un else if
        if (numLigne <= 2 && numColumn <= 2) {
            arrayToLoad[0].push(inputValue);
        } else if (numLigne <= 2 && numColumn > 2 && numColumn <= 5) {
            arrayToLoad[1].push(inputValue);
        } else if (numLigne <= 2 && numColumn > 5) {
            arrayToLoad[2].push(inputValue);
        } else if (numLigne > 2 && numLigne <= 5 && numColumn <= 2) {
            arrayToLoad[3].push(inputValue);
        } else if (numLigne > 2 && numLigne <= 5 && numColumn > 2 && numColumn <= 5) {
            arrayToLoad[4].push(inputValue);
        } else if (numLigne > 2 && numLigne <= 5 && numColumn > 5) {
            arrayToLoad[5].push(inputValue);
        } else if (numLigne > 5 && numColumn <= 2) {
            arrayToLoad[6].push(inputValue);
        } else if (numLigne > 5 && numColumn > 2 && numColumn <= 5) {
            arrayToLoad[7].push(inputValue);
        } else if (numLigne > 5 && numColumn > 5) {
            arrayToLoad[8].push(inputValue);
        }
        return arrayToLoad;
    },

};

module.exports = functions;
