-- Revert sudoku:initdb from pg

BEGIN;

DROP TABLE "board", "actor", "display","role";


COMMIT;
