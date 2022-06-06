-- Revert sudoku:seo_tables from pg

BEGIN;

DROP TABLE "robots";
DROP TABLE "sitemap";

COMMIT;
