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
('Killian','Audic','killianaudic@gmail.com','kaudic','$2b$10$7uwE7IKBXN.oMT1qMgGag.KWSt4NH8vYBhRe6vo.dddWSw1B82Rtq','1','1');


COMMIT;
