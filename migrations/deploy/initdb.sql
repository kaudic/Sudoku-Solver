-- Deploy sudoku:initdb to pg

BEGIN;

CREATE TABLE "role" (
    "role_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "role_description" TEXT NOT NULL UNIQUE
);

CREATE TABLE "display" (
    "display_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "display_type" TEXT NOT NULL UNIQUE,
    "display_color_1" TEXT,
    "display_color_2" TEXT,
    "display_color_3" TEXT,
    "display_color_4" TEXT,
    "display_color_5" TEXT
);

CREATE TABLE "board" (
  "board_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "board_data" TEXT NOT NULL UNIQUE

);

CREATE TABLE "actor" (
  "actor_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "actor_name" TEXT NOT NULL UNIQUE,
  "actor_surname" TEXT NOT NULL UNIQUE,
  "actor_email" TEXT NOT NULL UNIQUE,
  "actor_login" TEXT NOT NULL UNIQUE,
  "actor_password" TEXT NOT NULL UNIQUE,
  "actor_role_id" INT NOT NULL REFERENCES "role" ("role_id"),
  "actor_display_id" INT NOT NULL REFERENCES "display" ("display_id")
);

COMMIT;
