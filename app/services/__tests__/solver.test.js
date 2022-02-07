const solver = require('../solver');

// eslint-disable-next-line max-len
const trueBoard = [[1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9]];

// eslint-disable-next-line max-len
const falseBoard = [[1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 5, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9]];

describe('linesFinished', () => {
    it('Should return a boolean', () => {
        expect(typeof solver.linesFinished(trueBoard)).toBe('boolean');
    });
    it('Should return true', () => {
        expect(solver.linesFinished(trueBoard)).toBe(true);
    });
    it('Should return false', () => {
        expect(solver.linesFinished(falseBoard)).toBe(false);
    });
});

describe('columnsFinished', () => {
    it('Should return a boolean', () => {
        expect(typeof solver.columnsFinished(trueBoard)).toBe('boolean');
    });
    it('Should return true', () => {
        expect(solver.columnsFinished(trueBoard)).toBe(true);
    });
    it('Should return false', () => {
        expect(solver.columnsFinished(falseBoard)).toBe(false);
    });
});

describe('squaresFinished', () => {
    it('Should return a boolean', () => {
        expect(typeof solver.squaresFinished(trueBoard)).toBe('boolean');
    });
    it('Should return true', () => {
        expect(solver.squaresFinished(trueBoard)).toBe(true);
    });
    it('Should return false', () => {
        expect(solver.squaresFinished(falseBoard)).toBe(false);
    });
});
