const fn = require('../functions');

const board = '[[1, 2, 3, 4, 5, 6, 7, 8, 9],[1, 2, 3, 4, 5, 6, 7, 8, 9],[1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9],[1, 2, 3, 4, 5, 6, 7, 8, 9],[1, 2, 3, 4, 5, 6, 7, 8, 9],[1, 2, 3, 4, 5, 6, 7, 8, 9],[1, 2, 3, 4, 5, 6, 7, 8, 9]]';

describe('getRandomNumber', () => {
    it('Should return an integer', () => {
        expect(typeof fn.getRandomNumber(0, 9)).toBe('number');
    });
    it('Should return an integer <= 9', () => {
        expect(fn.getRandomNumber(0, 9)).toBeLessThanOrEqual(9);
    });

    it('Should return an integer >= 0', () => {
        expect(fn.getRandomNumber(0, 9)).toBeGreaterThanOrEqual(0);
    });
});

describe('getArrayOfRandNum', () => {
    it('Should return an array', () => {
        expect(Array.isArray(fn.getArrayOfRandNum({ min: 0, max: 9, arrayLen: 4 }))).toBe(true);
    });

    it('Should return an array with a length of 4', () => {
        expect(fn.getArrayOfRandNum({ min: 0, max: 9, arrayLen: 4 })).toHaveLength(4);
    });

    it('Should return an array with unique numbers', () => {
        expect([...new Set(fn.getArrayOfRandNum({
            min: 0,
            max: 9,
            arrayLen: 4,
        }))]).toHaveLength(4);
    });
});

describe('isNumberInArray', () => {
    it('Should return boolean', () => {
        expect(typeof fn.isNumberInArray(8, [1, 2, 3, 9])).toBe('boolean');
    });
    it('Should return true', () => {
        expect(fn.isNumberInArray(3, [1, 2, 3, 9])).toBe(true);
    });

    it('Should return false if number not included in array', () => {
        expect(fn.isNumberInArray(8, [1, 2, 3, 9])).toBe(false);
    });

    it('Should return false if a string is sent instead of an array', () => {
        expect(fn.isNumberInArray('string', [1, 2, 3, 9])).toBe(false);
    });
});

describe('emptyCellsPerLevel', () => {
    it('Should return a number', () => {
        expect(typeof fn.emptyCellsPerLevel('Facile1')).toBe('number');
    });
    it('Should return 2 for param Facile1 ', () => {
        expect(fn.emptyCellsPerLevel('Facile1')).toBe(2);
    });
    it('Should return 3 for param Facile2', () => {
        expect(fn.emptyCellsPerLevel('Facile2')).toBe(3);
    });
    it('Should return 4 for param Moyen', () => {
        expect(fn.emptyCellsPerLevel('Moyen')).toBe(4);
    });
    it('Should return 5 for param Difficile', () => {
        expect(fn.emptyCellsPerLevel('Difficile')).toBe(5);
    });
    it('Should return 6 for param Démoniaque', () => {
        expect(fn.emptyCellsPerLevel('Démoniaque')).toBe(6);
    });
});

describe('wipeCells', () => {
    it('Should return an array', () => {
        expect(Array.isArray(fn.wipeCells(board, 4))).toBe(true);
    });
    it('Should have 4 empty strings in each line', () => {
        // eslint-disable-next-line max-nested-callbacks
        expect(fn.wipeCells(board, 4)[0].filter((elt) => elt === '')).toHaveLength(4);
    });
});
