-- Deploy sudoku:seo_tables to pg

BEGIN;

BEGIN;

CREATE TABLE "robots"(
"id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
"file_text" TEXT NOT NULL
);

INSERT INTO "robots" ("file_text") VALUES ('Disallow : /');

CREATE TABLE "sitemap"(
"id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
"file_text" TEXT NOT NULL
);

INSERT INTO "sitemap" ("file_text") VALUES ('A compléter');

COMMIT;

COMMIT;
