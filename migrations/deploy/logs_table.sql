-- Deploy sudoku:logs_table to pg

BEGIN;

CREATE TABLE "logs" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "date_of_logs" TEXT NOT NULL,
    "hostname" TEXT NOT NULL,
    "ip_address" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "headers" TEXT NOT NULL,
    "logs_error" TEXT NOT NULL
);

COMMIT;
