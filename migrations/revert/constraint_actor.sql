-- Revert sudoku:constraint_actor from pg

BEGIN;

--ALTER TABLE actor ADD CONSTRAINT actor_actor_surname_key UNIQUE (actor_surname);
--ALTER TABLE actor ADD CONSTRAINT actor_actor_password_key UNIQUE (actor_password);
--ALTER TABLE actor ADD CONSTRAINT actor_actor_name_key UNIQUE (actor_name);

COMMIT;
