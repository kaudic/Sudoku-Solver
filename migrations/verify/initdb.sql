-- Verify sudoku:initdb on pg

BEGIN;

SELECT "role_id", "role_description" FROM "role" WHERE false;

SELECT "display_id", "display_type", "display_color_1", "display_color_2", "display_color_3", "display_color_4", "display_color_5" FROM "display" WHERE false;

SELECT "board_id", "board_data" FROM "board" WHERE false;

SELECT "actor_id", "actor_name", "actor_surname", "actor_email", "actor_login", "actor_password","actor_role_id","actor_display_id" FROM "actor" WHERE false;

ROLLBACK;
