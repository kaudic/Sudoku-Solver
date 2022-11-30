-- Deploy sudoku:initdb to pg

BEGIN;

CREATE TABLE "role" (
    "role_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "role_description" TEXT NOT NULL UNIQUE
);

CREATE TABLE "display" (
    "display_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "display_type" TEXT NOT NULL UNIQUE,
    "display_color1" TEXT,
    "display_color2" TEXT,
    "display_color3" TEXT,
    "display_color4" TEXT,
    "display_color5" TEXT
);

CREATE TABLE "board" (
  "board_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "board_data" TEXT NOT NULL UNIQUE

);

CREATE TABLE "actor" (
  "actor_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "actor_name" TEXT NOT NULL,
  "actor_surname" TEXT NOT NULL,
  "actor_email" TEXT NOT NULL UNIQUE,
  "actor_login" TEXT NOT NULL UNIQUE,
  "actor_password" TEXT NOT NULL,
  "actor_role_id" INT NOT NULL DEFAULT 2 REFERENCES "role" ("role_id"),
  "actor_display_id" INT NOT NULL DEFAULT 1 REFERENCES "display" ("display_id")
);

--insertion des roles admin/autre
INSERT INTO "role"("role_description") VALUES ('ADMIN'),('CLIENT'),('VISITOR');

--insertion des variables bright/dark mode
INSERT INTO "display" ("display_type","display_color1","display_color2","display_color3","display_color4","display_color5")
VALUES
('DARK','orange','rgb(39, 39, 39)','yellowgreen','rgb(80, 80, 80)','white'),
('BRIGHT','orange','lightgrey','black','rgb(80, 80, 80)','white');

--insertion du profil admin
INSERT INTO "actor" ("actor_name", "actor_surname","actor_email","actor_login","actor_password","actor_role_id","actor_display_id")
VALUES
('Killian','Audic','killianaudic@gmail.com','kaudic','$2b$10$RrjOqifzG4OQzg0u58P0sONVuMuGaSiY/ZX/y4BVOcvUYpo4Imo5.','1','1');

--insert one board to get started
INSERT INTO board ("board_data") VALUES ('[[7,4,1,3,6,5,9,2,8],[9,2,6,7,4,8,3,5,1],[8,3,5,9,1,2,6,4,7],[1,6,9,4,2,3,8,7,5],[2,8,3,1,5,7,4,6,9],[5,7,4,6,8,9,1,3,2],[6,1,7,2,9,4,5,8,3],[3,9,8,5,7,6,2,1,4],[4,5,2,8,3,1,7,9,6]]');

COMMIT;
