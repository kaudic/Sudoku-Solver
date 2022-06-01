-- Deploy sudoku:legal_notice_table to pg

BEGIN;

CREATE TABLE "legal_notice" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "legal_notice_text" TEXT
);

COMMIT;
