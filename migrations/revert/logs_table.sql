-- Revert sudoku:logs_table from pg

BEGIN;

DROP TABLE "logs";

COMMIT;
