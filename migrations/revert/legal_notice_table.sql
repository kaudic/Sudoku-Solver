-- Revert sudoku:legal_notice_table from pg

BEGIN;

DROP TABLE "legal_notice";

COMMIT;
