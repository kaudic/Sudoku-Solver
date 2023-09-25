--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15 (Ubuntu 12.15-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.15 (Ubuntu 12.15-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: sqitch; Type: SCHEMA; Schema: -; Owner: sudoku
--

CREATE SCHEMA sqitch;


ALTER SCHEMA sqitch OWNER TO sudoku;

--
-- Name: SCHEMA sqitch; Type: COMMENT; Schema: -; Owner: sudoku
--

COMMENT ON SCHEMA sqitch IS 'Sqitch database deployment metadata v1.1.';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.actor (
    actor_id integer NOT NULL,
    actor_name text NOT NULL,
    actor_surname text NOT NULL,
    actor_email text NOT NULL,
    actor_login text NOT NULL,
    actor_password text NOT NULL,
    actor_role_id integer DEFAULT 2 NOT NULL,
    actor_display_id integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.actor OWNER TO sudoku;

--
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.actor ALTER COLUMN actor_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: board; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.board (
    board_id integer NOT NULL,
    board_data text NOT NULL
);


ALTER TABLE public.board OWNER TO sudoku;

--
-- Name: board_board_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.board ALTER COLUMN board_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.board_board_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: display; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.display (
    display_id integer NOT NULL,
    display_type text NOT NULL,
    display_color1 text,
    display_color2 text,
    display_color3 text,
    display_color4 text,
    display_color5 text
);


ALTER TABLE public.display OWNER TO sudoku;

--
-- Name: display_display_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.display ALTER COLUMN display_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.display_display_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: legal_notice; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.legal_notice (
    id integer NOT NULL,
    legal_notice_text text
);


ALTER TABLE public.legal_notice OWNER TO sudoku;

--
-- Name: legal_notice_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.legal_notice ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.legal_notice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: logs; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    date_of_logs text NOT NULL,
    hostname text NOT NULL,
    ip_address text NOT NULL,
    url text NOT NULL,
    headers text NOT NULL,
    logs_error text NOT NULL
);


ALTER TABLE public.logs OWNER TO sudoku;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.logs ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: robots; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.robots (
    id integer NOT NULL,
    file_text text NOT NULL
);


ALTER TABLE public.robots OWNER TO sudoku;

--
-- Name: robots_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.robots ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.robots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: role; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    role_description text NOT NULL
);


ALTER TABLE public.role OWNER TO sudoku;

--
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.role ALTER COLUMN role_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sitemap; Type: TABLE; Schema: public; Owner: sudoku
--

CREATE TABLE public.sitemap (
    id integer NOT NULL,
    file_text text NOT NULL
);


ALTER TABLE public.sitemap OWNER TO sudoku;

--
-- Name: sitemap_id_seq; Type: SEQUENCE; Schema: public; Owner: sudoku
--

ALTER TABLE public.sitemap ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sitemap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: changes; Type: TABLE; Schema: sqitch; Owner: sudoku
--

CREATE TABLE sqitch.changes (
    change_id text NOT NULL,
    script_hash text,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.changes OWNER TO sudoku;

--
-- Name: TABLE changes; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON TABLE sqitch.changes IS 'Tracks the changes currently deployed to the database.';


--
-- Name: COLUMN changes.change_id; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.change_id IS 'Change primary key.';


--
-- Name: COLUMN changes.script_hash; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.script_hash IS 'Deploy script SHA-1 hash.';


--
-- Name: COLUMN changes.change; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.change IS 'Name of a deployed change.';


--
-- Name: COLUMN changes.project; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN changes.note; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.note IS 'Description of the change.';


--
-- Name: COLUMN changes.committed_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.committed_at IS 'Date the change was deployed.';


--
-- Name: COLUMN changes.committer_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.committer_name IS 'Name of the user who deployed the change.';


--
-- Name: COLUMN changes.committer_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.committer_email IS 'Email address of the user who deployed the change.';


--
-- Name: COLUMN changes.planned_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.planned_at IS 'Date the change was added to the plan.';


--
-- Name: COLUMN changes.planner_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN changes.planner_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.changes.planner_email IS 'Email address of the user who planned the change.';


--
-- Name: dependencies; Type: TABLE; Schema: sqitch; Owner: sudoku
--

CREATE TABLE sqitch.dependencies (
    change_id text NOT NULL,
    type text NOT NULL,
    dependency text NOT NULL,
    dependency_id text,
    CONSTRAINT dependencies_check CHECK ((((type = 'require'::text) AND (dependency_id IS NOT NULL)) OR ((type = 'conflict'::text) AND (dependency_id IS NULL))))
);


ALTER TABLE sqitch.dependencies OWNER TO sudoku;

--
-- Name: TABLE dependencies; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON TABLE sqitch.dependencies IS 'Tracks the currently satisfied dependencies.';


--
-- Name: COLUMN dependencies.change_id; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.dependencies.change_id IS 'ID of the depending change.';


--
-- Name: COLUMN dependencies.type; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.dependencies.type IS 'Type of dependency.';


--
-- Name: COLUMN dependencies.dependency; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.dependencies.dependency IS 'Dependency name.';


--
-- Name: COLUMN dependencies.dependency_id; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.dependencies.dependency_id IS 'Change ID the dependency resolves to.';


--
-- Name: events; Type: TABLE; Schema: sqitch; Owner: sudoku
--

CREATE TABLE sqitch.events (
    event text NOT NULL,
    change_id text NOT NULL,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    requires text[] DEFAULT '{}'::text[] NOT NULL,
    conflicts text[] DEFAULT '{}'::text[] NOT NULL,
    tags text[] DEFAULT '{}'::text[] NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL,
    CONSTRAINT events_event_check CHECK ((event = ANY (ARRAY['deploy'::text, 'revert'::text, 'fail'::text, 'merge'::text])))
);


ALTER TABLE sqitch.events OWNER TO sudoku;

--
-- Name: TABLE events; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON TABLE sqitch.events IS 'Contains full history of all deployment events.';


--
-- Name: COLUMN events.event; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.event IS 'Type of event.';


--
-- Name: COLUMN events.change_id; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.change_id IS 'Change ID.';


--
-- Name: COLUMN events.change; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.change IS 'Change name.';


--
-- Name: COLUMN events.project; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN events.note; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.note IS 'Description of the change.';


--
-- Name: COLUMN events.requires; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.requires IS 'Array of the names of required changes.';


--
-- Name: COLUMN events.conflicts; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.conflicts IS 'Array of the names of conflicting changes.';


--
-- Name: COLUMN events.tags; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.tags IS 'Tags associated with the change.';


--
-- Name: COLUMN events.committed_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.committed_at IS 'Date the event was committed.';


--
-- Name: COLUMN events.committer_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.committer_name IS 'Name of the user who committed the event.';


--
-- Name: COLUMN events.committer_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.committer_email IS 'Email address of the user who committed the event.';


--
-- Name: COLUMN events.planned_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.planned_at IS 'Date the event was added to the plan.';


--
-- Name: COLUMN events.planner_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN events.planner_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.events.planner_email IS 'Email address of the user who plan planned the change.';


--
-- Name: projects; Type: TABLE; Schema: sqitch; Owner: sudoku
--

CREATE TABLE sqitch.projects (
    project text NOT NULL,
    uri text,
    created_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    creator_name text NOT NULL,
    creator_email text NOT NULL
);


ALTER TABLE sqitch.projects OWNER TO sudoku;

--
-- Name: TABLE projects; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON TABLE sqitch.projects IS 'Sqitch projects deployed to this database.';


--
-- Name: COLUMN projects.project; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.projects.project IS 'Unique Name of a project.';


--
-- Name: COLUMN projects.uri; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.projects.uri IS 'Optional project URI';


--
-- Name: COLUMN projects.created_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.projects.created_at IS 'Date the project was added to the database.';


--
-- Name: COLUMN projects.creator_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.projects.creator_name IS 'Name of the user who added the project.';


--
-- Name: COLUMN projects.creator_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.projects.creator_email IS 'Email address of the user who added the project.';


--
-- Name: releases; Type: TABLE; Schema: sqitch; Owner: sudoku
--

CREATE TABLE sqitch.releases (
    version real NOT NULL,
    installed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    installer_name text NOT NULL,
    installer_email text NOT NULL
);


ALTER TABLE sqitch.releases OWNER TO sudoku;

--
-- Name: TABLE releases; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON TABLE sqitch.releases IS 'Sqitch registry releases.';


--
-- Name: COLUMN releases.version; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.releases.version IS 'Version of the Sqitch registry.';


--
-- Name: COLUMN releases.installed_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.releases.installed_at IS 'Date the registry release was installed.';


--
-- Name: COLUMN releases.installer_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.releases.installer_name IS 'Name of the user who installed the registry release.';


--
-- Name: COLUMN releases.installer_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.releases.installer_email IS 'Email address of the user who installed the registry release.';


--
-- Name: tags; Type: TABLE; Schema: sqitch; Owner: sudoku
--

CREATE TABLE sqitch.tags (
    tag_id text NOT NULL,
    tag text NOT NULL,
    project text NOT NULL,
    change_id text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.tags OWNER TO sudoku;

--
-- Name: TABLE tags; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON TABLE sqitch.tags IS 'Tracks the tags currently applied to the database.';


--
-- Name: COLUMN tags.tag_id; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.tag_id IS 'Tag primary key.';


--
-- Name: COLUMN tags.tag; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.tag IS 'Project-unique tag name.';


--
-- Name: COLUMN tags.project; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.project IS 'Name of the Sqitch project to which the tag belongs.';


--
-- Name: COLUMN tags.change_id; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.change_id IS 'ID of last change deployed before the tag was applied.';


--
-- Name: COLUMN tags.note; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.note IS 'Description of the tag.';


--
-- Name: COLUMN tags.committed_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.committed_at IS 'Date the tag was applied to the database.';


--
-- Name: COLUMN tags.committer_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.committer_name IS 'Name of the user who applied the tag.';


--
-- Name: COLUMN tags.committer_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.committer_email IS 'Email address of the user who applied the tag.';


--
-- Name: COLUMN tags.planned_at; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.planned_at IS 'Date the tag was added to the plan.';


--
-- Name: COLUMN tags.planner_name; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.planner_name IS 'Name of the user who planed the tag.';


--
-- Name: COLUMN tags.planner_email; Type: COMMENT; Schema: sqitch; Owner: sudoku
--

COMMENT ON COLUMN sqitch.tags.planner_email IS 'Email address of the user who planned the tag.';


--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.actor (actor_id, actor_name, actor_surname, actor_email, actor_login, actor_password, actor_role_id, actor_display_id) FROM stdin;
1	Killian	Audic	killianaudic@gmail.com	kaudic	$2b$10$RrjOqifzG4OQzg0u58P0sONVuMuGaSiY/ZX/y4BVOcvUYpo4Imo5.	1	2
\.


--
-- Data for Name: board; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.board (board_id, board_data) FROM stdin;
1	[[7,4,1,3,6,5,9,2,8],[9,2,6,7,4,8,3,5,1],[8,3,5,9,1,2,6,4,7],[1,6,9,4,2,3,8,7,5],[2,8,3,1,5,7,4,6,9],[5,7,4,6,8,9,1,3,2],[6,1,7,2,9,4,5,8,3],[3,9,8,5,7,6,2,1,4],[4,5,2,8,3,1,7,9,6]]
6	[[5,7,6,4,2,8,9,1,3],[1,2,8,9,5,3,6,4,7],[3,4,9,1,7,6,2,5,8],[7,6,4,8,9,2,5,3,1],[2,5,1,6,3,4,7,8,9],[9,8,3,7,1,5,4,2,6],[4,3,7,2,6,1,8,9,5],[8,9,5,3,4,7,1,6,2],[6,1,2,5,8,9,3,7,4]]
7	[[7,8,2,3,4,9,1,6,5],[5,3,1,2,6,7,4,9,8],[9,6,4,5,1,8,3,2,7],[8,2,9,1,7,4,5,3,6],[6,7,5,9,8,3,2,1,4],[1,4,3,6,5,2,8,7,9],[2,5,7,4,3,6,9,8,1],[4,9,8,7,2,1,6,5,3],[3,1,6,8,9,5,7,4,2]]
8	[[7,9,4,8,2,5,3,1,6],[6,3,5,1,9,7,4,8,2],[1,8,2,3,6,4,7,5,9],[8,4,6,7,5,2,9,3,1],[9,2,3,4,1,6,5,7,8],[5,7,1,9,8,3,6,2,4],[2,5,9,6,7,1,8,4,3],[4,6,7,2,3,8,1,9,5],[3,1,8,5,4,9,2,6,7]]
10	[[2,5,6,4,9,8,3,1,7],[1,3,9,7,2,5,4,6,8],[4,8,7,6,1,3,5,2,9],[3,4,8,9,6,1,2,7,5],[9,6,5,2,8,7,1,4,3],[7,2,1,3,5,4,8,9,6],[5,9,4,8,7,2,6,3,1],[6,1,2,5,3,9,7,8,4],[8,7,3,1,4,6,9,5,2]]
11	[[3,9,4,6,1,2,5,8,7],[5,1,6,8,7,9,4,2,3],[7,2,8,3,4,5,1,9,6],[4,7,2,5,3,8,6,1,9],[9,8,5,7,6,1,2,3,4],[1,6,3,9,2,4,8,7,5],[2,3,7,1,5,6,9,4,8],[6,4,9,2,8,7,3,5,1],[8,5,1,4,9,3,7,6,2]]
12	[[4,6,2,1,3,5,7,8,9],[8,3,1,2,7,9,4,5,6],[5,7,9,4,8,6,2,3,1],[1,2,3,5,9,4,8,6,7],[7,4,6,3,1,8,9,2,5],[9,8,5,7,6,2,3,1,4],[3,5,8,9,4,1,6,7,2],[6,1,4,8,2,7,5,9,3],[2,9,7,6,5,3,1,4,8]]
14	[[7,2,5,6,9,8,1,3,4],[8,3,4,1,7,2,5,6,9],[9,1,6,3,5,4,2,8,7],[5,6,2,8,4,1,7,9,3],[1,4,8,9,3,7,6,2,5],[3,7,9,2,6,5,4,1,8],[4,8,1,5,2,9,3,7,6],[6,9,7,4,1,3,8,5,2],[2,5,3,7,8,6,9,4,1]]
15	[[3,1,5,6,4,7,2,9,8],[2,7,4,9,1,8,3,6,5],[6,9,8,3,5,2,7,4,1],[4,3,2,8,9,1,6,5,7],[8,5,7,2,6,4,9,1,3],[9,6,1,7,3,5,4,8,2],[1,2,6,5,7,9,8,3,4],[7,4,3,1,8,6,5,2,9],[5,8,9,4,2,3,1,7,6]]
16	[[2,1,5,8,6,9,3,4,7],[4,6,9,2,7,3,8,5,1],[7,3,8,4,5,1,6,2,9],[5,9,3,1,2,7,4,8,6],[1,8,7,6,3,4,5,9,2],[6,4,2,5,9,8,1,7,3],[9,7,4,3,1,5,2,6,8],[8,2,1,7,4,6,9,3,5],[3,5,6,9,8,2,7,1,4]]
17	[[9,4,1,5,8,7,2,3,6],[6,8,7,3,2,9,1,4,5],[3,2,5,4,1,6,9,7,8],[1,9,3,2,5,8,7,6,4],[8,7,2,6,4,3,5,1,9],[4,5,6,9,7,1,8,2,3],[2,3,4,1,9,5,6,8,7],[7,6,9,8,3,2,4,5,1],[5,1,8,7,6,4,3,9,2]]
18	[[9,8,5,2,4,3,1,7,6],[4,7,6,1,8,9,2,3,5],[1,3,2,7,5,6,9,4,8],[2,1,9,6,7,4,8,5,3],[8,4,7,9,3,5,6,1,2],[5,6,3,8,2,1,7,9,4],[7,5,1,3,6,2,4,8,9],[6,9,4,5,1,8,3,2,7],[3,2,8,4,9,7,5,6,1]]
19	[[2,3,9,7,1,4,6,8,5],[4,6,1,9,8,5,7,3,2],[5,8,7,2,3,6,4,9,1],[3,7,5,1,2,8,9,4,6],[1,9,6,5,4,7,8,2,3],[8,4,2,3,6,9,5,1,7],[7,5,3,4,9,2,1,6,8],[6,2,4,8,5,1,3,7,9],[9,1,8,6,7,3,2,5,4]]
20	[[4,2,1,8,5,9,6,3,7],[9,5,3,2,6,7,1,8,4],[6,7,8,1,3,4,2,5,9],[5,3,4,6,8,1,7,9,2],[7,9,2,3,4,5,8,6,1],[1,8,6,9,7,2,5,4,3],[8,6,9,7,1,3,4,2,5],[3,4,7,5,2,6,9,1,8],[2,1,5,4,9,8,3,7,6]]
21	[[6,4,8,2,7,9,1,3,5],[5,2,9,8,1,3,7,6,4],[1,7,3,4,5,6,9,8,2],[2,8,1,7,6,5,4,9,3],[9,3,7,1,2,4,6,5,8],[4,5,6,3,9,8,2,1,7],[8,6,5,9,4,2,3,7,1],[3,1,2,6,8,7,5,4,9],[7,9,4,5,3,1,8,2,6]]
22	[[5,7,8,4,6,9,3,2,1],[6,4,1,3,2,8,5,7,9],[3,2,9,1,7,5,4,6,8],[2,8,4,5,9,1,7,3,6],[1,6,5,7,8,3,9,4,2],[7,9,3,6,4,2,8,1,5],[9,3,2,8,1,4,6,5,7],[4,1,6,9,5,7,2,8,3],[8,5,7,2,3,6,1,9,4]]
23	[[4,6,1,5,8,9,2,7,3],[8,7,5,4,2,3,6,1,9],[9,3,2,6,1,7,8,4,5],[3,2,7,9,6,1,4,5,8],[1,5,4,8,3,2,9,6,7],[6,8,9,7,5,4,3,2,1],[5,9,3,1,4,6,7,8,2],[7,4,8,2,9,5,1,3,6],[2,1,6,3,7,8,5,9,4]]
24	[[6,8,2,1,4,7,5,3,9],[9,7,5,3,6,8,2,1,4],[4,1,3,2,5,9,7,8,6],[7,6,4,9,3,5,1,2,8],[1,2,8,6,7,4,9,5,3],[3,5,9,8,1,2,6,4,7],[2,9,7,5,8,3,4,6,1],[8,4,6,7,2,1,3,9,5],[5,3,1,4,9,6,8,7,2]]
25	[[6,2,9,7,5,8,3,1,4],[8,5,1,3,9,4,2,6,7],[4,7,3,1,6,2,9,8,5],[2,6,7,8,3,5,1,4,9],[1,3,4,9,7,6,5,2,8],[5,9,8,2,4,1,6,7,3],[7,4,5,6,2,9,8,3,1],[3,1,6,5,8,7,4,9,2],[9,8,2,4,1,3,7,5,6]]
26	[[6,2,9,4,1,8,7,5,3],[3,4,7,6,9,5,1,8,2],[1,5,8,3,2,7,9,6,4],[4,8,5,9,7,2,3,1,6],[2,3,6,5,4,1,8,7,9],[9,7,1,8,3,6,2,4,5],[8,6,2,1,5,9,4,3,7],[7,1,4,2,6,3,5,9,8],[5,9,3,7,8,4,6,2,1]]
27	[[5,8,3,7,9,1,2,4,6],[7,1,4,6,2,3,9,5,8],[6,2,9,4,5,8,7,3,1],[4,7,2,1,3,6,8,9,5],[8,6,5,9,4,2,1,7,3],[9,3,1,5,8,7,6,2,4],[1,4,8,2,7,5,3,6,9],[2,5,6,3,1,9,4,8,7],[3,9,7,8,6,4,5,1,2]]
28	[[7,8,5,4,9,1,3,6,2],[3,6,9,7,2,5,8,4,1],[2,4,1,6,8,3,9,5,7],[1,5,4,9,3,6,2,7,8],[9,3,8,2,4,7,6,1,5],[6,2,7,5,1,8,4,3,9],[8,1,2,3,5,4,7,9,6],[4,9,6,1,7,2,5,8,3],[5,7,3,8,6,9,1,2,4]]
29	[[1,3,7,6,4,9,2,5,8],[2,9,5,1,7,8,6,4,3],[8,6,4,2,3,5,9,1,7],[3,8,2,7,1,6,5,9,4],[5,4,9,8,2,3,1,7,6],[6,7,1,9,5,4,3,8,2],[7,5,8,3,6,1,4,2,9],[9,1,3,4,8,2,7,6,5],[4,2,6,5,9,7,8,3,1]]
30	[[3,6,8,1,5,4,7,9,2],[4,2,5,9,8,7,1,3,6],[9,1,7,2,6,3,4,5,8],[2,5,3,4,7,1,6,8,9],[8,4,1,6,9,5,2,7,3],[6,7,9,8,3,2,5,4,1],[7,8,2,3,4,6,9,1,5],[1,3,4,5,2,9,8,6,7],[5,9,6,7,1,8,3,2,4]]
31	[[5,9,1,4,3,7,8,2,6],[3,7,6,2,5,8,4,9,1],[2,4,8,6,9,1,3,7,5],[1,2,7,5,8,3,6,4,9],[8,6,3,9,2,4,1,5,7],[4,5,9,7,1,6,2,8,3],[9,3,2,1,4,5,7,6,8],[6,1,4,8,7,9,5,3,2],[7,8,5,3,6,2,9,1,4]]
32	[[9,2,6,7,3,5,4,1,8],[4,5,1,8,6,9,2,3,7],[7,3,8,4,2,1,5,6,9],[1,6,2,3,8,7,9,5,4],[5,8,4,9,1,6,7,2,3],[3,9,7,2,5,4,6,8,1],[2,1,9,5,4,8,3,7,6],[8,7,3,6,9,2,1,4,5],[6,4,5,1,7,3,8,9,2]]
33	[[2,8,6,7,1,9,5,3,4],[7,3,9,5,4,2,8,1,6],[5,4,1,6,3,8,7,9,2],[6,9,5,4,2,1,3,7,8],[1,7,4,8,6,3,2,5,9],[3,2,8,9,5,7,6,4,1],[9,5,3,2,8,4,1,6,7],[4,6,2,1,7,5,9,8,3],[8,1,7,3,9,6,4,2,5]]
34	[[8,4,5,2,9,6,1,3,7],[1,3,2,7,5,8,4,6,9],[9,6,7,4,3,1,5,8,2],[7,1,6,3,8,4,9,2,5],[5,2,8,9,1,7,3,4,6],[3,9,4,6,2,5,8,7,1],[4,7,1,5,6,3,2,9,8],[2,8,3,1,7,9,6,5,4],[6,5,9,8,4,2,7,1,3]]
35	[[1,5,4,7,3,8,2,9,6],[8,7,3,2,6,9,1,4,5],[6,2,9,5,1,4,3,7,8],[3,4,5,9,2,7,6,8,1],[2,1,7,3,8,6,9,5,4],[9,6,8,4,5,1,7,3,2],[4,3,2,6,7,5,8,1,9],[7,9,1,8,4,2,5,6,3],[5,8,6,1,9,3,4,2,7]]
36	[[1,9,7,6,2,4,3,5,8],[4,3,2,1,8,5,7,6,9],[8,6,5,9,3,7,4,1,2],[6,1,8,7,5,9,2,4,3],[3,7,9,2,4,1,5,8,6],[5,2,4,8,6,3,1,9,7],[9,5,1,3,7,8,6,2,4],[2,4,3,5,9,6,8,7,1],[7,8,6,4,1,2,9,3,5]]
37	[[4,3,9,5,1,6,7,8,2],[1,2,5,8,4,7,3,6,9],[6,7,8,3,2,9,1,5,4],[5,8,4,9,6,3,2,1,7],[7,9,6,1,8,2,5,4,3],[3,1,2,4,7,5,6,9,8],[9,5,1,7,3,4,8,2,6],[8,6,3,2,9,1,4,7,5],[2,4,7,6,5,8,9,3,1]]
38	[[3,2,1,9,5,4,6,7,8],[8,6,9,3,2,7,5,4,1],[4,7,5,6,8,1,3,9,2],[1,9,6,2,4,3,7,8,5],[5,4,7,1,9,8,2,3,6],[2,8,3,7,6,5,4,1,9],[6,1,4,8,3,2,9,5,7],[9,3,8,5,7,6,1,2,4],[7,5,2,4,1,9,8,6,3]]
39	[[9,2,7,6,1,5,3,8,4],[3,1,6,7,8,4,5,9,2],[4,8,5,2,3,9,1,7,6],[1,7,3,5,6,2,8,4,9],[6,9,4,8,7,1,2,3,5],[8,5,2,4,9,3,6,1,7],[7,4,1,3,5,6,9,2,8],[2,6,9,1,4,8,7,5,3],[5,3,8,9,2,7,4,6,1]]
40	[[1,8,6,9,2,4,7,5,3],[9,7,2,5,3,1,6,8,4],[5,4,3,8,6,7,9,2,1],[4,9,7,3,1,8,2,6,5],[2,3,8,6,5,9,1,4,7],[6,1,5,4,7,2,8,3,9],[3,2,9,1,4,6,5,7,8],[7,5,1,2,8,3,4,9,6],[8,6,4,7,9,5,3,1,2]]
41	[[4,6,9,2,3,8,5,1,7],[3,5,8,1,4,7,6,2,9],[2,7,1,9,6,5,4,3,8],[8,9,7,6,5,1,3,4,2],[6,2,4,7,9,3,1,8,5],[1,3,5,4,8,2,7,9,6],[7,4,6,3,2,9,8,5,1],[9,8,3,5,1,6,2,7,4],[5,1,2,8,7,4,9,6,3]]
42	[[5,1,7,9,3,2,6,4,8],[3,9,4,1,8,6,5,2,7],[2,8,6,7,4,5,1,9,3],[8,3,2,6,9,7,4,1,5],[6,5,1,3,2,4,7,8,9],[4,7,9,8,5,1,3,6,2],[9,4,3,5,1,8,2,7,6],[1,6,5,2,7,9,8,3,4],[7,2,8,4,6,3,9,5,1]]
43	[[5,7,8,1,4,6,3,9,2],[1,9,3,5,7,2,4,6,8],[4,2,6,3,8,9,7,1,5],[8,3,5,4,1,7,6,2,9],[9,4,2,8,6,3,1,5,7],[6,1,7,2,9,5,8,4,3],[7,5,1,6,2,8,9,3,4],[3,6,9,7,5,4,2,8,1],[2,8,4,9,3,1,5,7,6]]
44	[[9,2,7,4,5,1,6,3,8],[3,4,6,2,9,8,5,7,1],[8,1,5,7,6,3,4,9,2],[5,9,8,1,3,4,7,2,6],[6,3,1,5,2,7,9,8,4],[2,7,4,6,8,9,1,5,3],[4,8,9,3,7,6,2,1,5],[7,6,2,8,1,5,3,4,9],[1,5,3,9,4,2,8,6,7]]
45	[[1,6,2,4,3,9,7,5,8],[5,8,9,7,1,2,4,3,6],[3,4,7,6,5,8,2,1,9],[2,7,5,9,6,1,3,8,4],[8,9,1,3,4,5,6,2,7],[4,3,6,8,2,7,1,9,5],[7,5,3,2,9,6,8,4,1],[6,1,4,5,8,3,9,7,2],[9,2,8,1,7,4,5,6,3]]
46	[[2,3,5,9,1,4,8,6,7],[6,4,7,2,5,8,9,3,1],[9,8,1,7,6,3,4,5,2],[8,2,4,1,9,5,6,7,3],[7,5,6,4,3,2,1,9,8],[3,1,9,6,8,7,5,2,4],[1,9,8,3,7,6,2,4,5],[4,6,3,5,2,1,7,8,9],[5,7,2,8,4,9,3,1,6]]
47	[[4,9,8,7,5,2,3,1,6],[2,5,3,1,6,8,4,7,9],[6,7,1,3,9,4,2,5,8],[9,3,4,6,1,5,7,8,2],[5,1,2,8,7,9,6,4,3],[8,6,7,2,4,3,1,9,5],[3,4,6,5,8,7,9,2,1],[7,2,5,9,3,1,8,6,4],[1,8,9,4,2,6,5,3,7]]
48	[[6,5,4,3,8,7,9,1,2],[9,3,7,1,5,2,8,6,4],[8,1,2,9,6,4,3,7,5],[4,9,5,6,2,8,1,3,7],[2,7,3,5,1,9,6,4,8],[1,8,6,4,7,3,5,2,9],[5,4,8,7,3,1,2,9,6],[3,6,9,2,4,5,7,8,1],[7,2,1,8,9,6,4,5,3]]
49	[[5,9,3,6,8,4,1,2,7],[7,8,1,9,2,5,4,3,6],[4,6,2,1,3,7,5,8,9],[9,4,7,5,1,3,8,6,2],[6,3,5,2,4,8,9,7,1],[1,2,8,7,6,9,3,4,5],[2,5,4,3,7,1,6,9,8],[3,7,9,8,5,6,2,1,4],[8,1,6,4,9,2,7,5,3]]
50	[[4,5,1,6,8,9,3,7,2],[9,7,3,5,1,2,8,6,4],[6,2,8,4,3,7,1,5,9],[3,6,7,8,9,1,2,4,5],[2,8,9,3,5,4,6,1,7],[1,4,5,2,7,6,9,3,8],[7,1,2,9,4,3,5,8,6],[8,9,4,1,6,5,7,2,3],[5,3,6,7,2,8,4,9,1]]
51	[[9,2,6,8,4,7,5,3,1],[1,3,4,2,5,6,9,7,8],[7,5,8,9,3,1,6,4,2],[2,9,7,4,8,3,1,5,6],[4,1,5,7,6,2,3,8,9],[6,8,3,5,1,9,7,2,4],[3,7,9,6,2,4,8,1,5],[8,6,2,1,7,5,4,9,3],[5,4,1,3,9,8,2,6,7]]
52	[[8,2,9,1,7,5,3,6,4],[7,1,6,4,2,3,8,9,5],[5,4,3,9,8,6,7,1,2],[2,7,5,6,9,8,4,3,1],[1,9,8,7,3,4,5,2,6],[3,6,4,5,1,2,9,7,8],[4,5,7,2,6,9,1,8,3],[6,8,1,3,4,7,2,5,9],[9,3,2,8,5,1,6,4,7]]
53	[[7,6,8,3,2,9,4,5,1],[1,3,4,5,8,6,7,2,9],[2,5,9,1,4,7,3,6,8],[9,1,6,8,7,4,2,3,5],[8,7,5,2,1,3,6,9,4],[3,4,2,6,9,5,1,8,7],[5,9,1,4,6,2,8,7,3],[6,8,7,9,3,1,5,4,2],[4,2,3,7,5,8,9,1,6]]
54	[[3,4,8,1,5,2,6,7,9],[5,2,6,7,9,3,1,8,4],[9,7,1,6,4,8,3,2,5],[2,6,3,5,1,9,7,4,8],[4,8,9,3,2,7,5,1,6],[7,1,5,8,6,4,2,9,3],[6,9,2,4,3,1,8,5,7],[8,5,4,2,7,6,9,3,1],[1,3,7,9,8,5,4,6,2]]
55	[[4,3,2,1,5,6,8,9,7],[5,6,8,2,9,7,1,4,3],[1,9,7,8,3,4,2,6,5],[6,2,5,9,1,3,4,7,8],[3,4,9,7,2,8,5,1,6],[7,8,1,4,6,5,3,2,9],[9,1,3,5,7,2,6,8,4],[8,7,6,3,4,1,9,5,2],[2,5,4,6,8,9,7,3,1]]
56	[[2,6,8,5,7,4,1,9,3],[5,9,3,8,6,1,7,2,4],[1,4,7,2,3,9,5,8,6],[6,8,4,7,9,3,2,5,1],[3,2,1,4,8,5,9,6,7],[7,5,9,1,2,6,3,4,8],[9,7,6,3,4,2,8,1,5],[8,1,2,6,5,7,4,3,9],[4,3,5,9,1,8,6,7,2]]
57	[[9,6,7,8,3,1,2,5,4],[2,5,8,4,9,6,3,7,1],[1,3,4,2,7,5,9,8,6],[3,1,5,9,8,4,6,2,7],[6,7,9,3,5,2,4,1,8],[4,8,2,6,1,7,5,3,9],[5,2,6,1,4,8,7,9,3],[7,9,1,5,6,3,8,4,2],[8,4,3,7,2,9,1,6,5]]
58	[[8,1,5,9,7,3,2,6,4],[3,9,4,6,2,8,5,7,1],[7,2,6,5,4,1,8,9,3],[1,4,3,7,8,5,9,2,6],[9,8,7,2,3,6,1,4,5],[5,6,2,4,1,9,7,3,8],[2,3,9,1,5,4,6,8,7],[6,5,8,3,9,7,4,1,2],[4,7,1,8,6,2,3,5,9]]
59	[[7,2,6,1,3,9,8,5,4],[4,5,9,8,6,2,7,3,1],[8,3,1,7,4,5,6,9,2],[1,6,5,9,2,4,3,7,8],[2,9,8,3,7,6,1,4,5],[3,4,7,5,1,8,2,6,9],[6,1,2,4,5,3,9,8,7],[5,8,3,2,9,7,4,1,6],[9,7,4,6,8,1,5,2,3]]
60	[[9,3,6,2,5,4,7,1,8],[4,1,5,9,8,7,6,2,3],[7,8,2,6,3,1,5,9,4],[6,4,7,3,9,2,8,5,1],[2,5,8,7,1,6,3,4,9],[3,9,1,5,4,8,2,6,7],[1,2,9,8,7,5,4,3,6],[8,6,4,1,2,3,9,7,5],[5,7,3,4,6,9,1,8,2]]
61	[[7,3,1,5,8,2,6,4,9],[4,8,2,9,1,6,7,3,5],[9,5,6,4,7,3,1,2,8],[1,9,5,3,4,7,2,8,6],[3,6,7,8,2,1,9,5,4],[2,4,8,6,9,5,3,1,7],[5,1,4,2,6,9,8,7,3],[8,7,9,1,3,4,5,6,2],[6,2,3,7,5,8,4,9,1]]
62	[[2,5,8,9,7,1,4,6,3],[6,1,7,8,3,4,9,5,2],[3,4,9,6,2,5,1,7,8],[4,8,1,5,9,2,6,3,7],[9,7,2,3,6,8,5,4,1],[5,6,3,1,4,7,8,2,9],[8,3,4,2,5,9,7,1,6],[7,9,6,4,1,3,2,8,5],[1,2,5,7,8,6,3,9,4]]
63	[[5,2,6,3,4,7,9,8,1],[4,7,1,9,6,8,3,2,5],[8,3,9,5,2,1,7,4,6],[3,9,7,8,5,4,1,6,2],[6,1,4,2,7,9,5,3,8],[2,5,8,6,1,3,4,9,7],[7,8,2,4,9,5,6,1,3],[1,4,3,7,8,6,2,5,9],[9,6,5,1,3,2,8,7,4]]
64	[[7,4,1,5,6,2,8,9,3],[3,9,2,1,8,4,5,6,7],[5,6,8,7,3,9,1,2,4],[1,8,9,6,7,3,4,5,2],[2,7,3,4,5,8,6,1,9],[6,5,4,2,9,1,3,7,8],[8,2,5,3,1,7,9,4,6],[4,3,6,9,2,5,7,8,1],[9,1,7,8,4,6,2,3,5]]
65	[[2,3,4,7,1,8,9,5,6],[7,5,1,2,6,9,8,3,4],[6,9,8,3,5,4,7,1,2],[1,2,5,4,7,3,6,8,9],[4,7,9,6,8,1,3,2,5],[3,8,6,9,2,5,1,4,7],[5,6,3,8,9,2,4,7,1],[8,1,7,5,4,6,2,9,3],[9,4,2,1,3,7,5,6,8]]
66	[[2,3,5,8,6,7,9,1,4],[6,7,4,5,1,9,3,2,8],[8,1,9,3,2,4,6,5,7],[3,8,7,2,5,6,4,9,1],[4,6,2,7,9,1,8,3,5],[5,9,1,4,8,3,7,6,2],[9,2,6,1,4,8,5,7,3],[7,5,8,9,3,2,1,4,6],[1,4,3,6,7,5,2,8,9]]
67	[[1,9,3,7,6,5,2,8,4],[5,7,4,2,1,8,6,3,9],[8,6,2,9,4,3,5,1,7],[4,2,6,1,7,9,8,5,3],[9,3,8,6,5,4,1,7,2],[7,5,1,3,8,2,9,4,6],[3,1,7,5,9,6,4,2,8],[2,8,9,4,3,1,7,6,5],[6,4,5,8,2,7,3,9,1]]
68	[[2,4,7,6,1,3,9,5,8],[1,8,5,4,9,7,2,6,3],[3,9,6,8,5,2,1,4,7],[4,2,3,5,6,9,8,7,1],[7,1,9,2,8,4,6,3,5],[5,6,8,7,3,1,4,9,2],[6,7,2,1,4,5,3,8,9],[8,3,1,9,7,6,5,2,4],[9,5,4,3,2,8,7,1,6]]
69	[[7,9,1,5,8,3,4,2,6],[4,3,2,9,1,6,5,7,8],[5,8,6,7,2,4,1,9,3],[3,5,9,8,6,7,2,1,4],[8,2,4,1,5,9,3,6,7],[1,6,7,4,3,2,8,5,9],[6,7,5,3,4,1,9,8,2],[9,4,8,2,7,5,6,3,1],[2,1,3,6,9,8,7,4,5]]
70	[[3,7,6,1,4,5,8,9,2],[4,1,2,8,3,9,6,5,7],[8,5,9,2,6,7,4,3,1],[2,8,5,6,7,4,9,1,3],[9,6,1,3,2,8,5,7,4],[7,3,4,5,9,1,2,6,8],[5,9,3,4,1,2,7,8,6],[1,2,7,9,8,6,3,4,5],[6,4,8,7,5,3,1,2,9]]
71	[[2,9,6,1,4,5,8,3,7],[8,5,1,3,9,7,6,4,2],[3,7,4,8,2,6,5,1,9],[7,1,8,4,6,2,3,9,5],[6,4,5,9,7,3,2,8,1],[9,2,3,5,1,8,7,6,4],[5,6,9,7,8,4,1,2,3],[4,8,7,2,3,1,9,5,6],[1,3,2,6,5,9,4,7,8]]
72	[[5,9,2,6,3,1,8,7,4],[6,4,8,7,5,2,9,1,3],[7,3,1,9,4,8,2,6,5],[2,1,7,4,8,3,6,5,9],[4,8,6,5,7,9,1,3,2],[9,5,3,1,2,6,7,4,8],[3,6,9,8,1,5,4,2,7],[8,7,5,2,6,4,3,9,1],[1,2,4,3,9,7,5,8,6]]
73	[[3,7,4,1,5,8,6,9,2],[5,1,2,6,9,4,3,7,8],[6,9,8,2,3,7,5,4,1],[8,2,3,9,4,6,1,5,7],[7,4,9,5,1,3,8,2,6],[1,5,6,7,8,2,4,3,9],[9,6,5,4,7,1,2,8,3],[4,8,1,3,2,9,7,6,5],[2,3,7,8,6,5,9,1,4]]
74	[[5,2,7,9,4,3,1,8,6],[6,3,1,8,7,2,5,4,9],[8,4,9,5,1,6,7,3,2],[4,1,3,6,5,9,2,7,8],[9,5,6,7,2,8,3,1,4],[7,8,2,1,3,4,6,9,5],[1,7,8,4,6,5,9,2,3],[3,9,5,2,8,1,4,6,7],[2,6,4,3,9,7,8,5,1]]
75	[[9,7,1,6,8,4,2,5,3],[3,4,2,9,5,7,1,6,8],[6,5,8,2,1,3,9,4,7],[1,9,7,8,2,6,5,3,4],[2,6,4,1,3,5,7,8,9],[5,8,3,4,7,9,6,1,2],[8,3,9,5,6,2,4,7,1],[7,2,6,3,4,1,8,9,5],[4,1,5,7,9,8,3,2,6]]
76	[[8,2,3,5,7,1,6,9,4],[5,6,1,2,4,9,7,3,8],[9,4,7,8,3,6,5,2,1],[4,3,5,7,6,8,2,1,9],[2,7,6,9,1,3,4,8,5],[1,9,8,4,5,2,3,6,7],[6,1,4,3,8,5,9,7,2],[7,8,2,6,9,4,1,5,3],[3,5,9,1,2,7,8,4,6]]
77	[[8,6,9,4,7,3,1,2,5],[2,3,5,9,1,6,8,7,4],[7,4,1,5,8,2,3,9,6],[6,5,8,2,3,1,7,4,9],[3,2,4,7,9,8,6,5,1],[9,1,7,6,5,4,2,3,8],[1,7,2,8,4,5,9,6,3],[4,8,6,3,2,9,5,1,7],[5,9,3,1,6,7,4,8,2]]
78	[[4,7,9,5,2,6,3,1,8],[1,8,3,4,9,7,2,5,6],[5,6,2,1,8,3,4,7,9],[6,4,5,2,7,9,8,3,1],[8,9,7,3,4,1,5,6,2],[2,3,1,6,5,8,9,4,7],[9,5,6,8,1,4,7,2,3],[3,2,8,7,6,5,1,9,4],[7,1,4,9,3,2,6,8,5]]
79	[[3,4,9,6,2,1,8,7,5],[7,6,1,4,8,5,3,2,9],[8,2,5,7,3,9,4,6,1],[2,5,4,9,7,3,1,8,6],[1,7,3,5,6,8,9,4,2],[6,9,8,1,4,2,7,5,3],[4,1,2,8,9,6,5,3,7],[9,3,7,2,5,4,6,1,8],[5,8,6,3,1,7,2,9,4]]
80	[[9,1,3,6,7,4,5,2,8],[7,4,5,9,8,2,6,1,3],[2,6,8,3,5,1,4,7,9],[5,2,9,8,6,3,1,4,7],[6,7,1,2,4,9,8,3,5],[8,3,4,5,1,7,2,9,6],[3,9,6,1,2,8,7,5,4],[1,5,7,4,9,6,3,8,2],[4,8,2,7,3,5,9,6,1]]
81	[[7,4,6,8,9,2,1,3,5],[9,2,8,3,5,1,7,4,6],[5,1,3,4,7,6,2,9,8],[3,5,1,6,8,7,4,2,9],[8,7,4,9,2,3,6,5,1],[6,9,2,1,4,5,8,7,3],[1,8,7,5,3,4,9,6,2],[4,6,5,2,1,9,3,8,7],[2,3,9,7,6,8,5,1,4]]
82	[[3,8,9,2,7,1,4,5,6],[1,7,6,4,5,8,9,3,2],[5,2,4,9,6,3,7,8,1],[8,4,2,1,3,6,5,9,7],[6,1,7,5,4,9,8,2,3],[9,5,3,7,8,2,1,6,4],[7,9,1,6,2,5,3,4,8],[2,3,5,8,1,4,6,7,9],[4,6,8,3,9,7,2,1,5]]
83	[[6,2,7,8,3,5,4,1,9],[1,3,8,9,4,2,6,5,7],[5,4,9,7,6,1,8,2,3],[3,8,2,4,5,9,7,6,1],[4,6,5,1,8,7,3,9,2],[9,7,1,6,2,3,5,4,8],[2,1,4,5,7,8,9,3,6],[7,5,3,2,9,6,1,8,4],[8,9,6,3,1,4,2,7,5]]
84	[[7,6,4,5,8,2,3,1,9],[2,3,8,9,4,1,7,5,6],[5,1,9,7,6,3,2,4,8],[3,4,2,1,9,6,8,7,5],[1,7,6,2,5,8,9,3,4],[9,8,5,3,7,4,1,6,2],[4,9,1,8,3,5,6,2,7],[6,2,7,4,1,9,5,8,3],[8,5,3,6,2,7,4,9,1]]
85	[[3,8,2,4,5,7,6,9,1],[9,5,4,1,3,6,8,7,2],[6,1,7,2,9,8,5,4,3],[1,7,3,8,6,2,9,5,4],[8,4,5,3,7,9,1,2,6],[2,6,9,5,1,4,7,3,8],[7,2,6,9,8,3,4,1,5],[4,9,1,6,2,5,3,8,7],[5,3,8,7,4,1,2,6,9]]
86	[[7,5,8,2,3,9,1,6,4],[9,4,6,7,8,1,2,5,3],[2,3,1,5,6,4,7,9,8],[4,6,7,8,9,3,5,2,1],[5,2,3,4,1,7,6,8,9],[8,1,9,6,2,5,4,3,7],[6,9,4,1,5,8,3,7,2],[1,8,5,3,7,2,9,4,6],[3,7,2,9,4,6,8,1,5]]
87	[[8,6,1,2,5,4,9,7,3],[5,7,4,3,9,1,6,8,2],[9,3,2,6,8,7,4,1,5],[7,4,3,5,2,6,1,9,8],[2,5,8,4,1,9,3,6,7],[1,9,6,7,3,8,5,2,4],[4,8,7,1,6,5,2,3,9],[6,2,9,8,4,3,7,5,1],[3,1,5,9,7,2,8,4,6]]
88	[[6,5,8,1,2,4,3,7,9],[4,2,3,9,7,5,8,6,1],[9,7,1,8,6,3,4,5,2],[1,6,9,2,8,7,5,4,3],[5,4,2,3,1,6,7,9,8],[8,3,7,5,4,9,1,2,6],[7,9,4,6,3,1,2,8,5],[2,1,6,4,5,8,9,3,7],[3,8,5,7,9,2,6,1,4]]
89	[[9,4,5,8,3,1,6,2,7],[8,6,1,2,4,7,5,9,3],[2,3,7,6,5,9,4,8,1],[7,5,9,1,6,2,8,3,4],[3,1,6,9,8,4,2,7,5],[4,2,8,3,7,5,9,1,6],[1,7,4,5,2,8,3,6,9],[6,9,2,4,1,3,7,5,8],[5,8,3,7,9,6,1,4,2]]
90	[[9,1,8,3,7,6,2,4,5],[2,7,3,4,1,5,6,8,9],[5,6,4,2,8,9,1,3,7],[3,5,7,6,9,8,4,1,2],[1,9,6,7,2,4,8,5,3],[8,4,2,1,5,3,7,9,6],[6,8,5,9,4,2,3,7,1],[4,2,1,5,3,7,9,6,8],[7,3,9,8,6,1,5,2,4]]
91	[[8,9,5,2,1,7,4,6,3],[3,2,1,4,9,6,5,8,7],[4,7,6,8,3,5,2,9,1],[6,4,7,1,2,8,3,5,9],[2,5,3,6,7,9,8,1,4],[1,8,9,3,5,4,6,7,2],[7,6,2,9,8,3,1,4,5],[5,1,4,7,6,2,9,3,8],[9,3,8,5,4,1,7,2,6]]
92	[[1,3,4,6,2,9,5,7,8],[2,5,8,7,3,1,6,9,4],[7,6,9,8,5,4,3,2,1],[5,7,1,4,8,6,2,3,9],[9,8,3,2,7,5,1,4,6],[4,2,6,9,1,3,7,8,5],[3,9,5,1,4,7,8,6,2],[8,4,7,5,6,2,9,1,3],[6,1,2,3,9,8,4,5,7]]
93	[[8,6,2,9,4,1,7,3,5],[4,3,5,8,6,7,2,9,1],[7,1,9,3,2,5,8,4,6],[9,5,1,2,7,3,4,6,8],[3,8,4,6,5,9,1,2,7],[2,7,6,1,8,4,3,5,9],[5,2,8,7,3,6,9,1,4],[6,9,3,4,1,8,5,7,2],[1,4,7,5,9,2,6,8,3]]
94	[[7,1,8,4,9,6,2,5,3],[6,3,4,2,8,5,7,1,9],[2,5,9,1,3,7,8,4,6],[8,7,2,3,6,1,5,9,4],[5,4,1,8,7,9,3,6,2],[3,9,6,5,4,2,1,7,8],[9,2,3,7,1,4,6,8,5],[1,6,5,9,2,8,4,3,7],[4,8,7,6,5,3,9,2,1]]
95	[[8,1,4,5,3,7,9,2,6],[6,7,5,1,2,9,8,3,4],[2,3,9,4,6,8,5,1,7],[1,6,3,7,8,2,4,9,5],[7,4,2,6,9,5,3,8,1],[5,9,8,3,4,1,6,7,2],[4,2,6,8,1,3,7,5,9],[9,8,7,2,5,4,1,6,3],[3,5,1,9,7,6,2,4,8]]
96	[[6,8,1,7,4,3,5,2,9],[9,4,5,1,2,6,3,7,8],[3,7,2,9,5,8,6,1,4],[4,3,8,5,1,7,2,9,6],[2,1,7,6,3,9,4,8,5],[5,6,9,2,8,4,7,3,1],[8,9,6,4,7,2,1,5,3],[1,2,4,3,9,5,8,6,7],[7,5,3,8,6,1,9,4,2]]
97	[[1,7,2,6,3,5,8,4,9],[8,6,9,2,1,4,7,5,3],[3,4,5,8,7,9,1,6,2],[4,5,1,9,6,7,2,3,8],[7,9,8,3,5,2,6,1,4],[6,2,3,1,4,8,9,7,5],[5,8,4,7,2,1,3,9,6],[9,1,6,5,8,3,4,2,7],[2,3,7,4,9,6,5,8,1]]
98	[[1,4,5,8,7,6,3,2,9],[8,6,9,1,2,3,4,7,5],[3,7,2,4,9,5,1,8,6],[4,9,6,2,1,8,5,3,7],[2,1,8,3,5,7,9,6,4],[5,3,7,6,4,9,2,1,8],[9,5,3,7,6,2,8,4,1],[6,2,1,5,8,4,7,9,3],[7,8,4,9,3,1,6,5,2]]
99	[[2,5,7,1,6,4,8,3,9],[3,6,8,9,7,5,4,2,1],[4,1,9,8,3,2,7,5,6],[1,2,6,4,5,8,3,9,7],[9,7,3,2,1,6,5,4,8],[8,4,5,3,9,7,1,6,2],[6,9,1,7,4,3,2,8,5],[7,8,4,5,2,9,6,1,3],[5,3,2,6,8,1,9,7,4]]
100	[[3,4,9,2,7,1,6,5,8],[6,5,2,9,3,8,1,4,7],[8,1,7,5,6,4,2,3,9],[5,7,8,6,4,2,9,1,3],[4,9,1,7,5,3,8,6,2],[2,6,3,8,1,9,4,7,5],[9,3,5,1,2,6,7,8,4],[7,2,6,4,8,5,3,9,1],[1,8,4,3,9,7,5,2,6]]
101	[[2,7,1,3,5,6,9,4,8],[3,8,5,4,9,2,6,1,7],[9,4,6,7,1,8,5,2,3],[8,9,3,2,6,7,4,5,1],[5,6,7,8,4,1,3,9,2],[4,1,2,9,3,5,7,8,6],[1,5,4,6,8,3,2,7,9],[6,2,8,5,7,9,1,3,4],[7,3,9,1,2,4,8,6,5]]
102	[[9,2,6,5,8,3,7,4,1],[7,8,1,2,6,4,5,3,9],[4,3,5,9,7,1,6,2,8],[5,9,3,7,1,2,4,8,6],[8,4,2,6,3,5,1,9,7],[1,6,7,4,9,8,2,5,3],[2,7,9,8,4,6,3,1,5],[3,5,8,1,2,7,9,6,4],[6,1,4,3,5,9,8,7,2]]
103	[[1,9,6,3,2,8,4,5,7],[5,2,4,9,1,7,8,3,6],[7,3,8,5,6,4,2,9,1],[8,6,1,7,9,2,3,4,5],[3,4,9,8,5,1,7,6,2],[2,7,5,6,4,3,9,1,8],[4,8,3,1,7,6,5,2,9],[9,1,2,4,8,5,6,7,3],[6,5,7,2,3,9,1,8,4]]
104	[[4,7,2,8,5,9,1,3,6],[1,3,8,6,7,4,9,2,5],[6,5,9,3,1,2,8,4,7],[3,1,6,5,8,7,2,9,4],[2,4,5,9,3,1,7,6,8],[8,9,7,2,4,6,5,1,3],[9,2,3,7,6,5,4,8,1],[7,6,1,4,2,8,3,5,9],[5,8,4,1,9,3,6,7,2]]
105	[[7,1,6,9,5,3,2,8,4],[5,9,8,4,2,6,7,1,3],[4,3,2,7,1,8,9,6,5],[8,5,3,2,7,4,1,9,6],[1,4,7,3,6,9,8,5,2],[2,6,9,1,8,5,4,3,7],[9,2,4,6,3,1,5,7,8],[3,8,1,5,4,7,6,2,9],[6,7,5,8,9,2,3,4,1]]
106	[[4,7,2,5,1,8,6,9,3],[5,6,9,3,2,4,8,7,1],[1,8,3,6,7,9,2,5,4],[9,2,1,7,6,3,4,8,5],[3,4,7,1,8,5,9,2,6],[6,5,8,9,4,2,1,3,7],[7,9,4,2,5,6,3,1,8],[8,3,5,4,9,1,7,6,2],[2,1,6,8,3,7,5,4,9]]
107	[[1,8,5,2,6,7,9,4,3],[9,7,4,8,5,3,6,2,1],[3,2,6,9,1,4,7,5,8],[7,9,1,3,4,6,5,8,2],[2,4,3,5,8,9,1,7,6],[5,6,8,7,2,1,3,9,4],[8,3,2,1,7,5,4,6,9],[6,1,7,4,9,2,8,3,5],[4,5,9,6,3,8,2,1,7]]
108	[[9,6,7,1,4,8,3,2,5],[3,4,1,5,2,7,8,9,6],[2,8,5,6,3,9,1,4,7],[5,2,8,3,7,4,9,6,1],[4,7,3,9,1,6,2,5,8],[1,9,6,8,5,2,7,3,4],[6,3,4,2,8,1,5,7,9],[7,1,2,4,9,5,6,8,3],[8,5,9,7,6,3,4,1,2]]
109	[[8,5,6,7,2,3,4,9,1],[7,3,1,5,4,9,2,6,8],[4,9,2,6,1,8,7,3,5],[2,7,4,3,9,1,5,8,6],[5,1,9,8,6,7,3,4,2],[6,8,3,4,5,2,9,1,7],[9,4,8,1,7,5,6,2,3],[1,6,5,2,3,4,8,7,9],[3,2,7,9,8,6,1,5,4]]
110	[[5,7,3,9,8,1,4,6,2],[9,2,8,4,6,7,3,1,5],[1,6,4,5,3,2,8,9,7],[6,4,2,8,1,3,5,7,9],[7,3,9,6,4,5,1,2,8],[8,5,1,7,2,9,6,3,4],[4,1,7,3,9,8,2,5,6],[2,8,5,1,7,6,9,4,3],[3,9,6,2,5,4,7,8,1]]
111	[[1,2,3,6,9,4,5,7,8],[8,4,6,7,5,3,2,1,9],[7,5,9,2,1,8,3,4,6],[2,3,1,4,8,9,7,6,5],[5,8,7,1,3,6,9,2,4],[6,9,4,5,2,7,8,3,1],[9,7,5,3,6,1,4,8,2],[3,6,2,8,4,5,1,9,7],[4,1,8,9,7,2,6,5,3]]
112	[[7,3,4,8,5,6,9,1,2],[5,1,2,9,4,3,7,6,8],[6,9,8,1,2,7,3,4,5],[9,7,1,5,3,8,6,2,4],[2,5,3,6,9,4,1,8,7],[8,4,6,2,7,1,5,3,9],[1,8,5,7,6,2,4,9,3],[4,6,9,3,8,5,2,7,1],[3,2,7,4,1,9,8,5,6]]
113	[[9,3,1,5,2,8,7,4,6],[8,2,6,7,4,9,1,5,3],[7,5,4,6,3,1,2,8,9],[6,4,2,8,1,3,9,7,5],[3,7,9,4,6,5,8,2,1],[1,8,5,9,7,2,3,6,4],[2,6,7,3,9,4,5,1,8],[5,1,3,2,8,6,4,9,7],[4,9,8,1,5,7,6,3,2]]
114	[[1,9,4,8,7,3,2,6,5],[3,7,8,6,5,2,1,4,9],[6,5,2,9,4,1,3,8,7],[4,2,1,5,8,7,6,9,3],[7,8,9,3,1,6,4,5,2],[5,6,3,4,2,9,7,1,8],[8,1,7,2,6,5,9,3,4],[9,4,6,7,3,8,5,2,1],[2,3,5,1,9,4,8,7,6]]
115	[[7,9,3,5,1,2,6,8,4],[4,1,5,6,8,9,2,3,7],[2,8,6,4,3,7,5,9,1],[9,3,7,1,2,6,4,5,8],[6,4,2,9,5,8,1,7,3],[8,5,1,3,7,4,9,2,6],[3,6,9,7,4,5,8,1,2],[5,7,8,2,6,1,3,4,9],[1,2,4,8,9,3,7,6,5]]
116	[[4,2,9,8,7,1,6,5,3],[3,5,6,2,9,4,7,8,1],[1,7,8,5,6,3,4,9,2],[7,6,5,3,4,8,2,1,9],[9,8,3,6,1,2,5,4,7],[2,4,1,9,5,7,8,3,6],[6,1,7,4,3,5,9,2,8],[8,9,4,1,2,6,3,7,5],[5,3,2,7,8,9,1,6,4]]
117	[[5,4,2,6,8,9,1,3,7],[1,3,9,4,7,5,6,2,8],[7,8,6,1,2,3,4,5,9],[8,9,5,7,6,2,3,4,1],[6,2,1,3,9,4,7,8,5],[4,7,3,8,5,1,2,9,6],[2,6,7,5,4,8,9,1,3],[3,5,4,9,1,6,8,7,2],[9,1,8,2,3,7,5,6,4]]
118	[[5,1,4,3,8,7,6,2,9],[9,7,3,6,2,1,5,4,8],[2,8,6,9,4,5,1,7,3],[4,5,8,7,1,2,9,3,6],[7,9,1,8,6,3,2,5,4],[3,6,2,4,5,9,7,8,1],[8,2,5,1,3,6,4,9,7],[6,4,9,2,7,8,3,1,5],[1,3,7,5,9,4,8,6,2]]
119	[[5,9,7,1,8,6,3,4,2],[1,6,2,3,4,7,8,9,5],[3,4,8,5,2,9,1,7,6],[8,3,6,9,7,5,2,1,4],[4,1,9,6,3,2,7,5,8],[7,2,5,8,1,4,6,3,9],[6,5,3,2,9,1,4,8,7],[2,8,4,7,5,3,9,6,1],[9,7,1,4,6,8,5,2,3]]
120	[[8,5,9,3,7,2,1,4,6],[6,1,7,4,5,8,2,3,9],[4,3,2,6,9,1,5,7,8],[2,7,3,8,4,6,9,1,5],[9,4,1,5,2,3,6,8,7],[5,6,8,9,1,7,4,2,3],[3,2,4,7,6,5,8,9,1],[7,9,5,1,8,4,3,6,2],[1,8,6,2,3,9,7,5,4]]
121	[[4,7,2,3,5,1,6,8,9],[8,1,9,4,6,7,2,5,3],[3,5,6,8,2,9,4,1,7],[1,2,8,7,9,3,5,4,6],[9,3,5,6,4,2,1,7,8],[6,4,7,1,8,5,3,9,2],[2,8,3,9,1,4,7,6,5],[5,9,1,2,7,6,8,3,4],[7,6,4,5,3,8,9,2,1]]
122	[[8,7,3,5,4,9,2,1,6],[6,1,4,8,7,2,5,9,3],[5,2,9,1,3,6,4,8,7],[4,5,7,2,1,3,8,6,9],[2,6,8,7,9,4,3,5,1],[9,3,1,6,5,8,7,2,4],[3,8,2,4,6,1,9,7,5],[1,4,5,9,8,7,6,3,2],[7,9,6,3,2,5,1,4,8]]
123	[[2,3,4,6,5,1,9,8,7],[8,6,7,9,3,2,5,1,4],[9,1,5,7,8,4,2,6,3],[6,7,1,5,2,9,4,3,8],[3,8,9,1,4,7,6,2,5],[4,5,2,3,6,8,7,9,1],[1,2,3,4,7,6,8,5,9],[7,9,8,2,1,5,3,4,6],[5,4,6,8,9,3,1,7,2]]
124	[[9,6,3,2,4,7,8,1,5],[5,4,7,8,1,3,2,9,6],[2,8,1,6,5,9,4,3,7],[4,2,8,9,6,5,3,7,1],[1,7,9,4,3,8,6,5,2],[6,3,5,7,2,1,9,8,4],[7,1,6,3,9,4,5,2,8],[8,9,4,5,7,2,1,6,3],[3,5,2,1,8,6,7,4,9]]
125	[[6,4,7,2,8,1,5,9,3],[2,9,8,3,7,5,4,6,1],[3,1,5,4,9,6,8,2,7],[5,2,3,7,1,9,6,8,4],[9,6,4,8,3,2,1,7,5],[7,8,1,6,5,4,9,3,2],[8,5,2,1,6,3,7,4,9],[1,3,6,9,4,7,2,5,8],[4,7,9,5,2,8,3,1,6]]
126	[[4,9,3,6,8,1,5,2,7],[6,2,1,9,7,5,8,3,4],[5,7,8,2,4,3,6,9,1],[8,4,9,1,2,7,3,6,5],[2,1,6,5,3,4,9,7,8],[7,3,5,8,6,9,1,4,2],[9,8,7,3,1,2,4,5,6],[1,5,2,4,9,6,7,8,3],[3,6,4,7,5,8,2,1,9]]
127	[[4,9,5,3,8,7,6,2,1],[3,7,6,2,5,1,8,4,9],[1,8,2,4,6,9,7,3,5],[7,2,4,9,1,3,5,8,6],[6,5,1,8,7,2,4,9,3],[8,3,9,6,4,5,2,1,7],[5,6,3,1,2,4,9,7,8],[9,4,7,5,3,8,1,6,2],[2,1,8,7,9,6,3,5,4]]
128	[[9,1,6,5,8,3,7,2,4],[7,5,4,2,9,6,1,8,3],[3,8,2,7,4,1,9,5,6],[5,4,3,1,6,2,8,9,7],[2,7,9,8,5,4,3,6,1],[1,6,8,9,3,7,5,4,2],[6,9,1,3,2,8,4,7,5],[8,2,7,4,1,5,6,3,9],[4,3,5,6,7,9,2,1,8]]
129	[[1,8,6,4,9,5,7,3,2],[9,7,5,6,2,3,8,4,1],[3,4,2,1,8,7,5,6,9],[7,1,4,8,3,9,2,5,6],[2,6,9,5,1,4,3,7,8],[8,5,3,2,7,6,1,9,4],[4,9,1,3,5,2,6,8,7],[6,3,8,7,4,1,9,2,5],[5,2,7,9,6,8,4,1,3]]
130	[[9,4,2,5,3,8,6,1,7],[7,3,5,9,1,6,4,2,8],[8,1,6,2,4,7,3,9,5],[6,2,4,1,8,5,9,7,3],[1,9,8,7,2,3,5,6,4],[5,7,3,4,6,9,1,8,2],[2,5,9,6,7,4,8,3,1],[3,6,1,8,5,2,7,4,9],[4,8,7,3,9,1,2,5,6]]
131	[[4,9,1,3,6,8,7,2,5],[5,3,8,7,1,2,9,4,6],[7,2,6,5,9,4,3,8,1],[1,5,7,4,3,9,8,6,2],[2,6,9,1,8,7,5,3,4],[3,8,4,2,5,6,1,7,9],[8,1,3,6,2,5,4,9,7],[9,7,2,8,4,1,6,5,3],[6,4,5,9,7,3,2,1,8]]
132	[[4,7,3,8,1,2,5,6,9],[2,9,5,7,3,6,4,8,1],[1,8,6,5,9,4,7,3,2],[6,4,9,2,5,7,3,1,8],[8,5,1,6,4,3,2,9,7],[7,3,2,9,8,1,6,4,5],[3,1,7,4,2,9,8,5,6],[5,2,4,1,6,8,9,7,3],[9,6,8,3,7,5,1,2,4]]
133	[[5,2,7,6,1,4,8,9,3],[3,1,6,8,9,7,5,2,4],[9,4,8,3,2,5,6,7,1],[4,7,3,1,5,6,2,8,9],[1,9,2,4,7,8,3,5,6],[8,6,5,9,3,2,1,4,7],[6,5,9,7,8,1,4,3,2],[2,3,1,5,4,9,7,6,8],[7,8,4,2,6,3,9,1,5]]
134	[[4,6,9,8,3,7,2,5,1],[5,3,7,6,2,1,9,4,8],[1,8,2,4,5,9,7,6,3],[3,4,8,2,6,5,1,9,7],[9,7,5,3,1,8,4,2,6],[2,1,6,9,7,4,3,8,5],[6,9,3,1,8,2,5,7,4],[7,2,1,5,4,6,8,3,9],[8,5,4,7,9,3,6,1,2]]
135	[[9,6,2,7,3,5,8,1,4],[8,5,7,4,1,9,3,2,6],[4,1,3,2,8,6,7,9,5],[7,3,4,9,2,8,5,6,1],[6,2,5,1,4,3,9,7,8],[1,8,9,5,6,7,2,4,3],[3,4,8,6,9,2,1,5,7],[2,7,1,3,5,4,6,8,9],[5,9,6,8,7,1,4,3,2]]
136	[[3,8,9,2,1,7,5,4,6],[7,4,1,8,6,5,3,2,9],[2,5,6,4,3,9,7,8,1],[6,3,8,7,4,1,2,9,5],[4,9,7,5,2,6,8,1,3],[5,1,2,3,9,8,4,6,7],[8,6,4,1,7,3,9,5,2],[9,2,3,6,5,4,1,7,8],[1,7,5,9,8,2,6,3,4]]
137	[[4,6,3,9,8,1,7,5,2],[9,2,1,7,4,5,6,3,8],[8,7,5,3,6,2,1,4,9],[5,1,7,4,2,3,9,8,6],[3,9,6,8,1,7,5,2,4],[2,4,8,6,5,9,3,7,1],[1,3,9,2,7,4,8,6,5],[6,5,2,1,3,8,4,9,7],[7,8,4,5,9,6,2,1,3]]
138	[[2,9,6,7,5,1,4,3,8],[3,5,7,4,8,9,1,2,6],[4,8,1,6,3,2,7,9,5],[1,4,9,2,6,7,5,8,3],[5,2,3,9,4,8,6,1,7],[6,7,8,3,1,5,9,4,2],[7,1,5,8,2,4,3,6,9],[8,6,4,5,9,3,2,7,1],[9,3,2,1,7,6,8,5,4]]
139	[[6,2,4,5,8,7,1,9,3],[7,3,9,2,1,4,6,5,8],[1,8,5,6,9,3,2,4,7],[5,4,1,7,6,9,8,3,2],[9,6,2,3,5,8,7,1,4],[8,7,3,4,2,1,5,6,9],[2,1,8,9,3,5,4,7,6],[4,9,6,1,7,2,3,8,5],[3,5,7,8,4,6,9,2,1]]
140	[[6,9,4,3,1,8,2,7,5],[7,8,2,9,6,5,1,4,3],[1,5,3,7,4,2,9,8,6],[9,7,8,5,3,6,4,2,1],[4,3,5,8,2,1,7,6,9],[2,1,6,4,7,9,5,3,8],[3,4,9,1,8,7,6,5,2],[5,6,7,2,9,3,8,1,4],[8,2,1,6,5,4,3,9,7]]
141	[[4,1,6,7,9,2,3,8,5],[3,2,7,4,8,5,9,1,6],[8,9,5,6,1,3,7,4,2],[7,6,8,5,4,1,2,3,9],[1,3,2,9,7,8,6,5,4],[9,5,4,2,3,6,8,7,1],[6,4,3,1,2,7,5,9,8],[5,8,1,3,6,9,4,2,7],[2,7,9,8,5,4,1,6,3]]
142	[[1,7,2,5,4,3,8,9,6],[8,5,9,6,2,1,4,7,3],[6,4,3,8,9,7,2,1,5],[7,8,6,3,1,5,9,4,2],[4,3,1,9,7,2,6,5,8],[9,2,5,4,6,8,1,3,7],[2,9,4,7,3,6,5,8,1],[5,6,7,1,8,4,3,2,9],[3,1,8,2,5,9,7,6,4]]
143	[[5,7,8,4,2,6,9,1,3],[2,9,6,1,7,3,8,5,4],[3,4,1,8,5,9,2,6,7],[1,5,7,6,9,2,4,3,8],[4,2,9,5,3,8,6,7,1],[6,8,3,7,1,4,5,2,9],[9,6,2,3,8,1,7,4,5],[7,1,4,9,6,5,3,8,2],[8,3,5,2,4,7,1,9,6]]
144	[[5,3,1,7,4,9,6,2,8],[9,2,7,1,6,8,3,4,5],[6,8,4,3,2,5,7,1,9],[3,4,9,2,8,7,5,6,1],[1,7,8,5,9,6,4,3,2],[2,5,6,4,1,3,8,9,7],[8,6,3,9,5,2,1,7,4],[4,9,5,6,7,1,2,8,3],[7,1,2,8,3,4,9,5,6]]
145	[[5,6,2,3,7,1,4,9,8],[4,1,8,2,5,9,6,7,3],[3,9,7,8,4,6,5,1,2],[2,5,1,7,6,4,8,3,9],[6,8,3,5,9,2,1,4,7],[9,7,4,1,3,8,2,6,5],[7,4,5,6,8,3,9,2,1],[1,3,9,4,2,5,7,8,6],[8,2,6,9,1,7,3,5,4]]
146	[[2,8,5,1,4,6,3,7,9],[3,6,9,5,2,7,1,8,4],[4,1,7,3,9,8,5,2,6],[5,7,6,4,1,9,2,3,8],[9,2,3,7,8,5,6,4,1],[8,4,1,6,3,2,9,5,7],[7,9,8,2,5,1,4,6,3],[1,5,4,8,6,3,7,9,2],[6,3,2,9,7,4,8,1,5]]
147	[[8,4,1,5,2,6,3,7,9],[2,7,5,3,9,4,6,1,8],[3,9,6,1,7,8,4,2,5],[1,5,9,2,4,3,7,8,6],[4,6,3,7,8,5,1,9,2],[7,8,2,6,1,9,5,4,3],[9,3,7,4,5,2,8,6,1],[5,1,8,9,6,7,2,3,4],[6,2,4,8,3,1,9,5,7]]
148	[[6,9,8,2,3,5,7,1,4],[3,7,2,1,4,9,6,8,5],[5,1,4,7,8,6,3,2,9],[1,5,3,9,6,7,8,4,2],[2,8,9,4,1,3,5,6,7],[4,6,7,5,2,8,9,3,1],[7,2,6,8,5,1,4,9,3],[9,3,1,6,7,4,2,5,8],[8,4,5,3,9,2,1,7,6]]
149	[[9,1,8,7,4,6,5,3,2],[6,7,2,5,9,3,4,1,8],[3,5,4,1,8,2,6,7,9],[5,9,3,4,1,8,2,6,7],[8,6,1,2,7,9,3,5,4],[2,4,7,3,6,5,8,9,1],[7,3,5,8,2,1,9,4,6],[4,8,6,9,5,7,1,2,3],[1,2,9,6,3,4,7,8,5]]
150	[[1,5,7,6,2,4,8,9,3],[2,8,6,9,3,1,7,5,4],[3,9,4,5,7,8,1,2,6],[5,4,2,8,9,3,6,1,7],[8,6,3,7,1,2,9,4,5],[7,1,9,4,6,5,2,3,8],[6,2,1,3,4,7,5,8,9],[9,3,5,1,8,6,4,7,2],[4,7,8,2,5,9,3,6,1]]
151	[[6,9,3,1,2,8,4,5,7],[2,7,5,6,3,4,8,1,9],[1,8,4,5,7,9,2,3,6],[5,4,2,7,9,3,6,8,1],[8,6,9,4,1,5,7,2,3],[7,3,1,8,6,2,5,9,4],[4,2,7,3,5,1,9,6,8],[3,5,6,9,8,7,1,4,2],[9,1,8,2,4,6,3,7,5]]
152	[[4,6,3,8,2,1,9,7,5],[2,9,1,5,4,7,3,6,8],[7,8,5,6,9,3,1,4,2],[9,5,7,2,1,4,6,8,3],[3,1,8,7,5,6,2,9,4],[6,4,2,3,8,9,7,5,1],[8,3,4,9,6,2,5,1,7],[5,2,6,1,7,8,4,3,9],[1,7,9,4,3,5,8,2,6]]
153	[[4,1,7,5,8,6,2,3,9],[5,2,3,9,7,4,6,1,8],[6,8,9,2,3,1,4,5,7],[8,3,6,1,9,5,7,2,4],[9,7,1,8,4,2,5,6,3],[2,4,5,7,6,3,9,8,1],[1,6,4,3,5,9,8,7,2],[3,5,8,4,2,7,1,9,6],[7,9,2,6,1,8,3,4,5]]
154	[[1,9,7,5,8,2,6,4,3],[2,5,4,1,3,6,7,8,9],[6,8,3,4,9,7,5,1,2],[8,3,6,9,2,4,1,5,7],[5,7,9,8,6,1,3,2,4],[4,1,2,7,5,3,8,9,6],[7,2,5,3,4,8,9,6,1],[9,6,1,2,7,5,4,3,8],[3,4,8,6,1,9,2,7,5]]
155	[[5,3,1,2,4,6,8,9,7],[7,9,2,3,8,5,1,6,4],[6,4,8,1,7,9,2,3,5],[4,1,5,9,3,2,6,7,8],[8,2,9,6,5,7,3,4,1],[3,6,7,8,1,4,5,2,9],[1,7,4,5,2,3,9,8,6],[9,5,3,4,6,8,7,1,2],[2,8,6,7,9,1,4,5,3]]
156	[[8,3,2,5,6,9,4,1,7],[4,7,1,2,3,8,6,5,9],[6,5,9,4,7,1,3,2,8],[5,2,3,7,8,4,1,9,6],[1,9,6,3,5,2,8,7,4],[7,4,8,1,9,6,2,3,5],[2,1,5,8,4,7,9,6,3],[9,8,7,6,1,3,5,4,2],[3,6,4,9,2,5,7,8,1]]
157	[[1,2,6,7,9,4,8,3,5],[4,9,5,8,3,1,7,2,6],[3,7,8,2,6,5,4,1,9],[9,8,1,4,2,7,5,6,3],[6,5,7,3,1,8,2,9,4],[2,3,4,6,5,9,1,8,7],[5,6,9,1,7,2,3,4,8],[7,4,2,9,8,3,6,5,1],[8,1,3,5,4,6,9,7,2]]
158	[[1,6,2,7,8,9,5,4,3],[3,7,5,4,6,2,8,1,9],[9,8,4,3,5,1,7,2,6],[6,2,8,9,3,5,1,7,4],[5,3,7,1,2,4,6,9,8],[4,1,9,8,7,6,3,5,2],[2,5,1,6,9,8,4,3,7],[7,4,6,2,1,3,9,8,5],[8,9,3,5,4,7,2,6,1]]
159	[[3,8,5,9,6,4,1,2,7],[9,6,7,5,2,1,4,3,8],[2,1,4,8,7,3,5,6,9],[6,2,9,3,1,7,8,4,5],[7,5,1,2,4,8,6,9,3],[8,4,3,6,9,5,2,7,1],[4,9,8,7,5,2,3,1,6],[5,7,2,1,3,6,9,8,4],[1,3,6,4,8,9,7,5,2]]
160	[[9,5,8,7,6,1,2,4,3],[6,7,1,3,2,4,8,5,9],[4,2,3,9,8,5,1,7,6],[7,4,2,8,3,9,5,6,1],[3,9,5,6,1,7,4,8,2],[8,1,6,4,5,2,3,9,7],[2,6,9,5,4,3,7,1,8],[1,8,4,2,7,6,9,3,5],[5,3,7,1,9,8,6,2,4]]
161	[[1,4,7,6,5,2,3,8,9],[2,8,5,4,3,9,7,1,6],[6,3,9,1,8,7,4,5,2],[7,5,3,9,4,8,2,6,1],[4,1,2,3,6,5,8,9,7],[9,6,8,7,2,1,5,3,4],[3,7,6,5,9,4,1,2,8],[5,2,1,8,7,6,9,4,3],[8,9,4,2,1,3,6,7,5]]
162	[[3,8,6,2,7,1,9,4,5],[4,5,2,6,9,3,8,1,7],[7,9,1,8,5,4,3,2,6],[1,2,7,3,8,6,4,5,9],[5,6,9,7,4,2,1,8,3],[8,3,4,9,1,5,6,7,2],[6,7,5,1,3,8,2,9,4],[2,4,8,5,6,9,7,3,1],[9,1,3,4,2,7,5,6,8]]
163	[[5,1,4,6,8,2,3,9,7],[6,8,9,7,1,3,2,5,4],[3,2,7,5,4,9,1,6,8],[9,7,6,3,2,1,4,8,5],[2,4,3,8,9,5,6,7,1],[1,5,8,4,7,6,9,3,2],[8,3,5,1,6,4,7,2,9],[7,9,1,2,3,8,5,4,6],[4,6,2,9,5,7,8,1,3]]
164	[[4,6,3,9,8,5,7,2,1],[7,8,5,1,6,2,9,3,4],[9,2,1,4,7,3,8,6,5],[6,9,4,3,5,7,1,8,2],[5,7,8,2,9,1,3,4,6],[1,3,2,6,4,8,5,7,9],[3,1,9,7,2,4,6,5,8],[2,5,6,8,3,9,4,1,7],[8,4,7,5,1,6,2,9,3]]
165	[[5,2,3,1,7,4,8,9,6],[7,9,6,3,5,8,1,4,2],[8,4,1,9,2,6,5,7,3],[4,3,5,2,8,9,6,1,7],[2,8,7,6,3,1,9,5,4],[6,1,9,7,4,5,3,2,8],[3,5,8,4,1,7,2,6,9],[1,6,4,8,9,2,7,3,5],[9,7,2,5,6,3,4,8,1]]
166	[[2,5,8,3,4,1,7,9,6],[4,6,3,7,9,2,5,8,1],[9,7,1,5,8,6,4,3,2],[5,3,2,9,1,4,8,6,7],[8,1,9,2,6,7,3,4,5],[6,4,7,8,5,3,1,2,9],[3,2,4,6,7,5,9,1,8],[7,9,6,1,3,8,2,5,4],[1,8,5,4,2,9,6,7,3]]
167	[[7,9,3,4,5,8,2,6,1],[2,6,1,9,3,7,5,4,8],[8,5,4,6,2,1,7,3,9],[5,1,2,3,8,6,4,9,7],[4,8,7,1,9,2,6,5,3],[9,3,6,7,4,5,8,1,2],[6,7,9,8,1,4,3,2,5],[3,2,8,5,6,9,1,7,4],[1,4,5,2,7,3,9,8,6]]
168	[[2,1,4,9,3,8,5,7,6],[7,8,9,2,6,5,1,4,3],[6,3,5,7,1,4,2,9,8],[9,4,8,5,2,6,3,1,7],[5,6,3,4,7,1,9,8,2],[1,2,7,8,9,3,6,5,4],[4,5,6,1,8,2,7,3,9],[8,7,2,3,5,9,4,6,1],[3,9,1,6,4,7,8,2,5]]
169	[[6,4,9,7,2,8,1,3,5],[1,2,3,6,5,4,7,8,9],[8,7,5,9,3,1,2,4,6],[3,1,6,2,8,9,4,5,7],[7,9,8,5,4,3,6,2,1],[4,5,2,1,6,7,8,9,3],[2,3,7,4,1,5,9,6,8],[9,8,4,3,7,6,5,1,2],[5,6,1,8,9,2,3,7,4]]
170	[[6,8,5,3,1,4,9,7,2],[9,4,1,6,7,2,3,8,5],[2,7,3,9,5,8,6,4,1],[4,2,9,8,3,7,1,5,6],[3,6,8,5,2,1,7,9,4],[5,1,7,4,9,6,2,3,8],[1,3,4,7,6,5,8,2,9],[8,9,2,1,4,3,5,6,7],[7,5,6,2,8,9,4,1,3]]
171	[[8,4,1,7,3,9,6,2,5],[7,3,2,8,6,5,4,1,9],[5,6,9,2,4,1,3,8,7],[2,9,3,6,1,4,7,5,8],[4,1,7,5,2,8,9,3,6],[6,8,5,3,9,7,1,4,2],[3,7,6,4,5,2,8,9,1],[9,5,8,1,7,3,2,6,4],[1,2,4,9,8,6,5,7,3]]
172	[[8,3,2,1,7,5,4,9,6],[9,6,7,3,4,2,1,8,5],[1,5,4,6,8,9,3,2,7],[4,8,6,7,5,3,9,1,2],[5,1,3,9,2,8,7,6,4],[2,7,9,4,1,6,8,5,3],[3,9,1,2,6,4,5,7,8],[7,2,8,5,3,1,6,4,9],[6,4,5,8,9,7,2,3,1]]
173	[[8,1,3,4,5,7,9,6,2],[6,2,5,3,9,1,4,8,7],[9,7,4,2,8,6,3,5,1],[3,5,6,7,4,2,1,9,8],[7,4,9,1,6,8,2,3,5],[1,8,2,5,3,9,7,4,6],[5,9,7,8,2,3,6,1,4],[2,6,8,9,1,4,5,7,3],[4,3,1,6,7,5,8,2,9]]
174	[[1,6,4,8,2,9,5,3,7],[2,3,8,4,5,7,9,1,6],[7,9,5,1,6,3,2,4,8],[5,8,6,9,1,4,7,2,3],[3,2,1,7,8,5,4,6,9],[9,4,7,6,3,2,8,5,1],[6,7,9,2,4,1,3,8,5],[8,5,2,3,9,6,1,7,4],[4,1,3,5,7,8,6,9,2]]
175	[[8,3,4,9,7,6,2,1,5],[5,7,1,4,2,3,8,6,9],[6,9,2,1,8,5,4,7,3],[3,6,5,2,1,8,7,9,4],[9,1,8,7,5,4,6,3,2],[2,4,7,6,3,9,5,8,1],[1,8,9,5,6,2,3,4,7],[4,2,6,3,9,7,1,5,8],[7,5,3,8,4,1,9,2,6]]
176	[[3,7,6,5,8,9,2,1,4],[1,4,9,3,7,2,5,8,6],[2,5,8,1,6,4,9,3,7],[4,6,3,8,5,1,7,2,9],[9,1,7,2,3,6,8,4,5],[8,2,5,4,9,7,1,6,3],[7,3,2,9,4,8,6,5,1],[5,9,1,6,2,3,4,7,8],[6,8,4,7,1,5,3,9,2]]
177	[[5,7,9,1,8,4,3,6,2],[8,2,6,7,9,3,1,4,5],[3,4,1,6,5,2,9,8,7],[1,8,4,9,3,7,5,2,6],[9,3,2,4,6,5,7,1,8],[6,5,7,2,1,8,4,3,9],[7,9,8,3,4,6,2,5,1],[2,6,3,5,7,1,8,9,4],[4,1,5,8,2,9,6,7,3]]
178	[[7,3,9,4,6,8,5,1,2],[1,6,2,3,7,5,8,9,4],[4,8,5,2,9,1,6,7,3],[2,7,3,9,4,6,1,8,5],[9,1,6,5,8,3,2,4,7],[5,4,8,1,2,7,3,6,9],[8,9,4,6,5,2,7,3,1],[6,5,1,7,3,4,9,2,8],[3,2,7,8,1,9,4,5,6]]
179	[[1,3,6,7,4,8,5,9,2],[9,7,8,2,5,3,4,6,1],[2,5,4,9,1,6,7,3,8],[8,6,5,1,3,7,2,4,9],[4,2,3,6,8,9,1,7,5],[7,1,9,5,2,4,3,8,6],[3,9,1,8,7,2,6,5,4],[6,4,2,3,9,5,8,1,7],[5,8,7,4,6,1,9,2,3]]
180	[[7,6,2,9,5,3,4,1,8],[8,1,5,4,7,2,3,6,9],[9,3,4,8,1,6,7,5,2],[2,4,3,6,9,7,5,8,1],[1,5,8,2,3,4,6,9,7],[6,7,9,5,8,1,2,4,3],[4,8,6,3,2,9,1,7,5],[3,9,1,7,6,5,8,2,4],[5,2,7,1,4,8,9,3,6]]
181	[[5,3,4,9,8,2,7,1,6],[1,6,9,5,3,7,8,2,4],[7,8,2,6,4,1,3,9,5],[3,4,8,1,5,9,2,6,7],[2,9,5,7,6,4,1,3,8],[6,7,1,3,2,8,5,4,9],[4,5,3,8,1,6,9,7,2],[9,1,6,2,7,5,4,8,3],[8,2,7,4,9,3,6,5,1]]
182	[[5,2,4,6,1,8,7,9,3],[6,9,3,7,2,5,4,8,1],[7,1,8,9,4,3,2,5,6],[4,8,2,5,9,1,3,6,7],[3,6,1,8,7,2,5,4,9],[9,7,5,3,6,4,1,2,8],[1,4,9,2,3,6,8,7,5],[2,5,7,1,8,9,6,3,4],[8,3,6,4,5,7,9,1,2]]
183	[[4,5,6,1,2,7,9,8,3],[1,8,7,6,3,9,2,4,5],[9,3,2,4,8,5,6,1,7],[3,6,8,5,9,4,7,2,1],[2,1,9,7,6,3,8,5,4],[7,4,5,2,1,8,3,6,9],[8,7,1,3,4,2,5,9,6],[6,2,3,9,5,1,4,7,8],[5,9,4,8,7,6,1,3,2]]
184	[[9,8,6,4,2,7,1,5,3],[3,7,4,9,5,1,2,8,6],[2,1,5,3,8,6,9,4,7],[8,2,9,7,1,5,3,6,4],[7,4,3,2,6,9,5,1,8],[5,6,1,8,4,3,7,2,9],[6,9,8,1,3,2,4,7,5],[4,3,2,5,7,8,6,9,1],[1,5,7,6,9,4,8,3,2]]
185	[[6,3,1,8,2,5,4,7,9],[5,7,8,9,1,4,6,3,2],[2,4,9,6,7,3,8,1,5],[1,8,5,7,6,9,3,2,4],[4,6,2,3,5,8,1,9,7],[7,9,3,1,4,2,5,8,6],[8,2,6,5,3,7,9,4,1],[3,1,7,4,9,6,2,5,8],[9,5,4,2,8,1,7,6,3]]
186	[[9,4,1,6,2,8,3,7,5],[8,5,6,7,3,9,1,2,4],[3,2,7,4,1,5,9,6,8],[6,7,4,5,9,2,8,3,1],[2,8,9,1,7,3,5,4,6],[5,1,3,8,6,4,7,9,2],[4,6,8,3,5,7,2,1,9],[1,3,2,9,8,6,4,5,7],[7,9,5,2,4,1,6,8,3]]
187	[[4,6,7,9,8,2,3,5,1],[5,9,3,6,4,1,8,2,7],[1,8,2,7,3,5,6,4,9],[8,1,9,4,6,3,5,7,2],[7,3,5,2,1,9,4,8,6],[6,2,4,8,5,7,9,1,3],[9,7,8,3,2,4,1,6,5],[3,5,6,1,7,8,2,9,4],[2,4,1,5,9,6,7,3,8]]
188	[[2,3,7,9,8,4,1,6,5],[6,8,1,3,2,5,9,7,4],[4,9,5,1,6,7,3,8,2],[5,6,9,2,4,3,7,1,8],[1,7,4,6,9,8,5,2,3],[3,2,8,7,5,1,6,4,9],[9,5,2,4,1,6,8,3,7],[7,4,6,8,3,9,2,5,1],[8,1,3,5,7,2,4,9,6]]
189	[[8,6,3,5,9,7,2,1,4],[2,9,4,8,1,6,3,5,7],[7,5,1,4,2,3,6,8,9],[1,3,5,7,6,9,8,4,2],[9,2,7,1,8,4,5,3,6],[6,4,8,3,5,2,7,9,1],[3,1,2,6,4,8,9,7,5],[5,7,6,9,3,1,4,2,8],[4,8,9,2,7,5,1,6,3]]
190	[[7,1,2,5,3,9,6,4,8],[4,9,6,8,1,2,5,3,7],[5,3,8,4,6,7,9,2,1],[1,7,3,2,9,6,8,5,4],[2,4,5,1,7,8,3,6,9],[6,8,9,3,4,5,1,7,2],[3,2,1,6,8,4,7,9,5],[9,6,4,7,5,1,2,8,3],[8,5,7,9,2,3,4,1,6]]
191	[[8,3,6,9,2,5,4,7,1],[2,4,9,1,7,6,8,5,3],[5,7,1,4,3,8,9,6,2],[9,1,4,5,8,7,3,2,6],[6,5,2,3,9,1,7,8,4],[7,8,3,6,4,2,1,9,5],[1,9,7,2,6,4,5,3,8],[3,2,5,8,1,9,6,4,7],[4,6,8,7,5,3,2,1,9]]
192	[[7,6,4,5,1,2,9,3,8],[1,3,5,8,6,9,2,4,7],[2,8,9,3,4,7,5,1,6],[5,9,6,4,7,3,1,8,2],[4,7,1,9,2,8,6,5,3],[3,2,8,1,5,6,4,7,9],[9,4,2,7,3,5,8,6,1],[8,1,7,6,9,4,3,2,5],[6,5,3,2,8,1,7,9,4]]
193	[[1,6,4,7,3,5,8,9,2],[5,2,8,6,9,1,7,4,3],[9,3,7,8,4,2,6,1,5],[3,1,2,4,7,9,5,8,6],[4,9,6,5,2,8,1,3,7],[8,7,5,1,6,3,4,2,9],[7,5,9,3,8,4,2,6,1],[6,8,3,2,1,7,9,5,4],[2,4,1,9,5,6,3,7,8]]
194	[[8,2,1,3,7,4,5,9,6],[7,9,3,1,5,6,4,2,8],[6,4,5,8,9,2,7,3,1],[9,5,7,6,8,3,2,1,4],[3,1,8,2,4,5,6,7,9],[4,6,2,9,1,7,3,8,5],[1,3,6,5,2,9,8,4,7],[2,8,4,7,6,1,9,5,3],[5,7,9,4,3,8,1,6,2]]
195	[[5,6,2,8,1,4,7,9,3],[7,9,1,3,6,5,4,2,8],[8,4,3,7,9,2,6,5,1],[4,8,6,2,5,3,1,7,9],[2,5,7,9,4,1,8,3,6],[3,1,9,6,7,8,5,4,2],[6,2,4,1,3,7,9,8,5],[9,7,8,5,2,6,3,1,4],[1,3,5,4,8,9,2,6,7]]
196	[[8,9,7,6,4,2,1,5,3],[6,3,1,7,9,5,4,2,8],[4,5,2,1,3,8,6,7,9],[7,4,3,2,8,6,9,1,5],[5,8,9,3,1,7,2,4,6],[2,1,6,9,5,4,3,8,7],[3,7,5,4,6,1,8,9,2],[1,6,8,5,2,9,7,3,4],[9,2,4,8,7,3,5,6,1]]
197	[[4,5,1,6,2,3,9,7,8],[2,3,9,8,7,1,6,4,5],[8,6,7,4,5,9,3,2,1],[7,9,4,5,8,2,1,6,3],[1,8,3,9,4,6,2,5,7],[6,2,5,1,3,7,8,9,4],[9,7,8,2,1,4,5,3,6],[5,4,6,3,9,8,7,1,2],[3,1,2,7,6,5,4,8,9]]
198	[[1,4,3,6,5,9,8,7,2],[6,7,9,1,2,8,4,5,3],[5,8,2,7,3,4,6,9,1],[3,9,4,5,8,6,1,2,7],[2,1,6,9,4,7,3,8,5],[7,5,8,2,1,3,9,4,6],[9,3,7,8,6,2,5,1,4],[8,6,1,4,7,5,2,3,9],[4,2,5,3,9,1,7,6,8]]
199	[[1,7,4,8,5,6,2,9,3],[5,6,9,2,3,4,7,1,8],[2,3,8,9,7,1,4,5,6],[9,2,1,4,6,8,5,3,7],[4,5,3,1,9,7,8,6,2],[7,8,6,3,2,5,9,4,1],[3,4,5,6,8,2,1,7,9],[6,1,2,7,4,9,3,8,5],[8,9,7,5,1,3,6,2,4]]
200	[[3,2,1,9,4,7,6,5,8],[6,7,4,5,2,8,9,3,1],[5,9,8,1,3,6,7,4,2],[8,1,7,4,6,2,5,9,3],[2,5,9,7,1,3,8,6,4],[4,6,3,8,9,5,2,1,7],[7,3,6,2,5,4,1,8,9],[1,4,2,6,8,9,3,7,5],[9,8,5,3,7,1,4,2,6]]
201	[[8,6,9,5,7,4,2,1,3],[3,5,1,9,8,2,4,7,6],[7,2,4,6,1,3,5,8,9],[9,7,5,2,3,1,6,4,8],[2,3,8,7,4,6,1,9,5],[4,1,6,8,5,9,3,2,7],[1,9,3,4,6,7,8,5,2],[5,4,7,3,2,8,9,6,1],[6,8,2,1,9,5,7,3,4]]
202	[[5,3,2,9,4,6,7,1,8],[7,1,4,8,3,2,6,5,9],[8,9,6,5,7,1,3,2,4],[6,4,7,2,1,9,8,3,5],[1,8,5,3,6,7,9,4,2],[9,2,3,4,8,5,1,7,6],[4,7,8,6,5,3,2,9,1],[3,6,9,1,2,4,5,8,7],[2,5,1,7,9,8,4,6,3]]
203	[[3,6,2,4,5,7,1,8,9],[8,9,7,3,6,1,2,5,4],[5,1,4,9,8,2,6,7,3],[7,8,5,2,4,6,3,9,1],[2,4,9,1,3,8,5,6,7],[1,3,6,5,7,9,4,2,8],[6,5,8,7,1,4,9,3,2],[4,2,3,8,9,5,7,1,6],[9,7,1,6,2,3,8,4,5]]
204	[[6,5,3,4,1,9,7,8,2],[2,8,1,5,6,7,3,4,9],[4,7,9,3,2,8,1,6,5],[3,2,8,1,4,6,9,5,7],[9,1,7,8,5,3,6,2,4],[5,6,4,9,7,2,8,1,3],[1,9,2,7,8,4,5,3,6],[7,4,5,6,3,1,2,9,8],[8,3,6,2,9,5,4,7,1]]
205	[[1,4,9,2,8,6,5,3,7],[6,5,8,3,4,7,9,1,2],[2,7,3,5,9,1,6,8,4],[4,6,2,9,5,3,8,7,1],[7,8,1,4,6,2,3,9,5],[9,3,5,7,1,8,2,4,6],[3,2,4,8,7,5,1,6,9],[5,9,6,1,3,4,7,2,8],[8,1,7,6,2,9,4,5,3]]
206	[[1,2,9,7,5,4,8,6,3],[3,8,6,1,2,9,5,7,4],[4,5,7,8,6,3,9,2,1],[6,1,8,4,9,7,2,3,5],[2,7,3,5,8,1,4,9,6],[9,4,5,6,3,2,7,1,8],[5,3,4,9,7,6,1,8,2],[7,6,1,2,4,8,3,5,9],[8,9,2,3,1,5,6,4,7]]
207	[[1,5,7,4,3,8,6,2,9],[6,3,2,5,1,9,8,7,4],[8,4,9,2,6,7,5,3,1],[7,8,6,3,5,1,4,9,2],[2,1,4,9,8,6,3,5,7],[5,9,3,7,2,4,1,6,8],[4,2,8,6,7,3,9,1,5],[3,7,1,8,9,5,2,4,6],[9,6,5,1,4,2,7,8,3]]
208	[[9,2,5,8,4,1,3,6,7],[7,6,1,5,2,3,8,9,4],[4,8,3,7,9,6,1,5,2],[1,5,4,9,8,2,6,7,3],[3,9,2,6,7,4,5,8,1],[8,7,6,3,1,5,4,2,9],[5,1,9,2,3,8,7,4,6],[2,3,8,4,6,7,9,1,5],[6,4,7,1,5,9,2,3,8]]
209	[[3,2,4,7,5,8,6,9,1],[9,8,7,2,1,6,5,4,3],[1,5,6,3,4,9,7,8,2],[4,1,9,5,7,3,8,2,6],[7,6,2,9,8,4,1,3,5],[8,3,5,6,2,1,9,7,4],[2,9,3,8,6,5,4,1,7],[6,7,1,4,9,2,3,5,8],[5,4,8,1,3,7,2,6,9]]
210	[[1,5,2,6,7,3,4,9,8],[6,9,7,8,4,5,1,3,2],[3,4,8,9,1,2,5,7,6],[9,1,4,7,2,8,3,6,5],[2,6,3,1,5,4,9,8,7],[7,8,5,3,9,6,2,4,1],[4,2,6,5,8,9,7,1,3],[5,3,1,4,6,7,8,2,9],[8,7,9,2,3,1,6,5,4]]
211	[[6,4,2,8,9,5,1,3,7],[5,9,7,2,3,1,6,4,8],[3,8,1,6,4,7,2,9,5],[9,2,5,1,6,3,8,7,4],[8,6,3,7,5,4,9,2,1],[7,1,4,9,8,2,3,5,6],[1,5,9,4,2,8,7,6,3],[2,3,8,5,7,6,4,1,9],[4,7,6,3,1,9,5,8,2]]
212	[[3,6,7,1,9,5,8,4,2],[9,5,8,4,2,3,6,1,7],[2,1,4,6,7,8,3,5,9],[7,4,3,2,6,1,9,8,5],[6,8,1,7,5,9,2,3,4],[5,2,9,8,3,4,7,6,1],[4,9,5,3,8,7,1,2,6],[1,3,2,9,4,6,5,7,8],[8,7,6,5,1,2,4,9,3]]
213	[[7,4,2,5,8,1,9,3,6],[8,6,1,3,9,4,2,7,5],[3,5,9,2,6,7,4,8,1],[4,3,7,9,5,2,6,1,8],[2,1,8,7,3,6,5,4,9],[6,9,5,4,1,8,3,2,7],[9,8,6,1,4,3,7,5,2],[1,7,3,6,2,5,8,9,4],[5,2,4,8,7,9,1,6,3]]
214	[[9,6,3,5,1,4,2,8,7],[4,2,8,6,7,3,1,5,9],[1,7,5,9,8,2,6,4,3],[2,9,6,8,3,1,5,7,4],[8,3,1,7,4,5,9,2,6],[5,4,7,2,6,9,8,3,1],[7,8,4,1,5,6,3,9,2],[6,5,9,3,2,7,4,1,8],[3,1,2,4,9,8,7,6,5]]
215	[[9,2,1,3,8,7,4,5,6],[4,5,7,1,9,6,3,8,2],[8,6,3,5,4,2,9,1,7],[2,7,4,8,1,5,6,3,9],[5,9,8,2,6,3,7,4,1],[3,1,6,4,7,9,8,2,5],[6,3,2,9,5,8,1,7,4],[7,4,5,6,3,1,2,9,8],[1,8,9,7,2,4,5,6,3]]
216	[[9,6,5,1,7,3,8,2,4],[4,8,3,9,2,6,7,1,5],[2,7,1,4,8,5,6,9,3],[1,5,8,7,9,4,3,6,2],[6,3,4,2,5,8,1,7,9],[7,2,9,6,3,1,5,4,8],[5,1,7,3,4,9,2,8,6],[3,4,6,8,1,2,9,5,7],[8,9,2,5,6,7,4,3,1]]
217	[[8,7,1,9,6,4,5,2,3],[2,6,9,8,5,3,4,7,1],[3,4,5,2,7,1,9,8,6],[4,8,7,6,1,5,2,3,9],[5,9,6,3,2,8,1,4,7],[1,2,3,4,9,7,8,6,5],[6,3,4,5,8,9,7,1,2],[9,1,2,7,4,6,3,5,8],[7,5,8,1,3,2,6,9,4]]
218	[[4,8,5,6,2,1,9,7,3],[1,3,6,9,8,7,5,2,4],[7,9,2,5,3,4,6,8,1],[2,5,3,4,7,6,8,1,9],[6,1,9,8,5,2,4,3,7],[8,4,7,3,1,9,2,5,6],[3,7,4,2,6,5,1,9,8],[5,6,8,1,9,3,7,4,2],[9,2,1,7,4,8,3,6,5]]
219	[[5,4,7,1,3,8,9,2,6],[9,6,1,5,4,2,3,8,7],[8,2,3,9,7,6,5,4,1],[1,7,9,3,8,5,4,6,2],[2,3,8,4,6,9,7,1,5],[4,5,6,2,1,7,8,9,3],[3,8,4,7,2,1,6,5,9],[7,9,2,6,5,4,1,3,8],[6,1,5,8,9,3,2,7,4]]
220	[[8,4,2,7,5,1,9,6,3],[1,5,9,2,6,3,8,4,7],[3,7,6,8,9,4,1,2,5],[2,9,7,5,1,8,4,3,6],[4,8,3,6,2,7,5,1,9],[6,1,5,4,3,9,2,7,8],[5,6,4,9,7,2,3,8,1],[7,2,1,3,8,5,6,9,4],[9,3,8,1,4,6,7,5,2]]
221	[[2,1,9,6,4,5,7,8,3],[6,8,5,9,3,7,1,4,2],[7,4,3,8,1,2,5,9,6],[5,6,1,3,2,8,4,7,9],[4,2,7,5,6,9,3,1,8],[3,9,8,4,7,1,6,2,5],[8,3,2,7,5,4,9,6,1],[9,5,4,1,8,6,2,3,7],[1,7,6,2,9,3,8,5,4]]
222	[[8,7,2,4,1,3,5,9,6],[5,6,4,9,2,7,8,1,3],[1,9,3,6,5,8,4,7,2],[4,8,1,7,3,9,2,6,5],[9,3,7,5,6,2,1,4,8],[2,5,6,1,8,4,9,3,7],[3,1,8,2,9,6,7,5,4],[6,4,5,8,7,1,3,2,9],[7,2,9,3,4,5,6,8,1]]
223	[[3,6,7,2,5,1,8,4,9],[4,9,1,3,6,8,7,5,2],[2,8,5,9,4,7,6,3,1],[9,3,8,7,1,4,2,6,5],[1,2,6,5,9,3,4,8,7],[5,7,4,6,8,2,9,1,3],[8,4,9,1,7,5,3,2,6],[6,1,2,8,3,9,5,7,4],[7,5,3,4,2,6,1,9,8]]
224	[[6,5,7,4,2,3,9,8,1],[4,1,2,9,7,8,6,5,3],[3,9,8,5,1,6,4,2,7],[9,2,5,1,6,4,3,7,8],[8,3,4,7,9,2,5,1,6],[7,6,1,3,8,5,2,9,4],[5,8,9,6,3,7,1,4,2],[2,4,3,8,5,1,7,6,9],[1,7,6,2,4,9,8,3,5]]
225	[[7,1,3,9,5,4,2,6,8],[9,8,6,7,2,3,4,1,5],[4,5,2,6,1,8,7,9,3],[2,9,4,1,7,5,3,8,6],[1,7,8,2,3,6,9,5,4],[3,6,5,4,8,9,1,2,7],[5,2,1,3,6,7,8,4,9],[6,4,7,8,9,1,5,3,2],[8,3,9,5,4,2,6,7,1]]
226	[[3,1,9,7,5,8,4,6,2],[2,8,7,4,6,3,1,5,9],[6,5,4,9,1,2,7,3,8],[5,4,3,6,2,7,9,8,1],[1,2,6,8,9,4,5,7,3],[7,9,8,1,3,5,6,2,4],[9,7,1,3,8,6,2,4,5],[8,6,5,2,4,1,3,9,7],[4,3,2,5,7,9,8,1,6]]
227	[[8,1,3,2,4,7,5,6,9],[9,5,7,1,6,8,2,3,4],[2,4,6,3,9,5,8,1,7],[1,3,4,8,7,2,6,9,5],[6,2,9,5,3,4,7,8,1],[7,8,5,6,1,9,3,4,2],[3,6,2,4,5,1,9,7,8],[4,9,8,7,2,6,1,5,3],[5,7,1,9,8,3,4,2,6]]
228	[[1,6,7,8,4,2,9,3,5],[3,5,2,1,9,7,8,4,6],[8,4,9,5,6,3,2,7,1],[7,1,6,2,3,9,4,5,8],[5,3,8,4,7,1,6,9,2],[2,9,4,6,8,5,3,1,7],[6,7,3,9,1,8,5,2,4],[9,8,5,7,2,4,1,6,3],[4,2,1,3,5,6,7,8,9]]
229	[[6,3,7,5,2,1,8,9,4],[9,5,2,8,4,6,3,1,7],[4,8,1,7,3,9,2,6,5],[1,2,8,3,5,4,9,7,6],[3,9,5,6,7,8,4,2,1],[7,4,6,1,9,2,5,3,8],[5,6,3,2,8,7,1,4,9],[8,1,4,9,6,3,7,5,2],[2,7,9,4,1,5,6,8,3]]
230	[[6,3,4,7,9,8,2,1,5],[8,9,2,5,3,1,6,7,4],[1,7,5,2,4,6,3,9,8],[2,6,7,4,8,3,1,5,9],[9,5,8,1,6,7,4,2,3],[4,1,3,9,2,5,7,8,6],[3,8,1,6,7,9,5,4,2],[5,2,9,3,1,4,8,6,7],[7,4,6,8,5,2,9,3,1]]
231	[[4,7,9,2,5,6,3,8,1],[2,3,6,4,8,1,5,7,9],[5,1,8,9,7,3,4,2,6],[6,9,1,7,4,8,2,5,3],[8,2,7,6,3,5,1,9,4],[3,4,5,1,2,9,8,6,7],[9,8,3,5,1,7,6,4,2],[7,5,4,3,6,2,9,1,8],[1,6,2,8,9,4,7,3,5]]
232	[[8,1,2,5,6,9,7,3,4],[4,7,5,3,1,8,2,9,6],[3,9,6,2,7,4,5,1,8],[1,3,7,4,8,2,6,5,9],[2,6,9,7,5,3,8,4,1],[5,4,8,6,9,1,3,2,7],[6,2,1,8,4,5,9,7,3],[7,5,4,9,3,6,1,8,2],[9,8,3,1,2,7,4,6,5]]
233	[[7,3,8,4,9,1,6,2,5],[6,4,9,8,2,5,3,1,7],[5,1,2,6,7,3,4,8,9],[1,9,6,2,5,8,7,4,3],[3,8,4,9,6,7,2,5,1],[2,5,7,1,3,4,9,6,8],[9,6,3,5,1,2,8,7,4],[4,7,5,3,8,6,1,9,2],[8,2,1,7,4,9,5,3,6]]
234	[[7,5,4,9,8,1,3,6,2],[3,2,1,7,6,5,8,4,9],[8,9,6,3,2,4,5,7,1],[9,7,5,4,1,3,2,8,6],[1,6,3,2,7,8,4,9,5],[2,4,8,6,5,9,1,3,7],[6,8,7,5,4,2,9,1,3],[5,1,9,8,3,6,7,2,4],[4,3,2,1,9,7,6,5,8]]
235	[[6,9,4,8,5,2,7,3,1],[5,3,1,4,6,7,9,2,8],[2,8,7,9,1,3,5,6,4],[7,5,9,3,2,8,4,1,6],[1,2,3,5,4,6,8,9,7],[4,6,8,7,9,1,2,5,3],[3,4,2,1,7,5,6,8,9],[8,7,6,2,3,9,1,4,5],[9,1,5,6,8,4,3,7,2]]
236	[[2,1,8,9,6,7,5,4,3],[3,7,6,4,1,5,2,8,9],[9,4,5,8,2,3,7,6,1],[1,5,2,7,4,8,9,3,6],[6,3,9,1,5,2,4,7,8],[4,8,7,3,9,6,1,5,2],[7,2,3,5,8,9,6,1,4],[8,9,1,6,7,4,3,2,5],[5,6,4,2,3,1,8,9,7]]
237	[[3,9,1,6,4,5,2,8,7],[8,2,4,1,3,7,6,9,5],[5,7,6,8,9,2,4,1,3],[6,3,7,9,5,4,8,2,1],[4,8,9,2,7,1,5,3,6],[1,5,2,3,8,6,7,4,9],[2,4,5,7,1,3,9,6,8],[7,1,8,4,6,9,3,5,2],[9,6,3,5,2,8,1,7,4]]
238	[[9,5,1,7,8,4,2,6,3],[4,6,2,3,5,9,1,8,7],[3,7,8,6,2,1,5,9,4],[7,8,9,2,6,3,4,1,5],[5,1,6,8,4,7,3,2,9],[2,3,4,9,1,5,8,7,6],[6,4,5,1,9,8,7,3,2],[8,2,7,4,3,6,9,5,1],[1,9,3,5,7,2,6,4,8]]
239	[[8,5,4,1,6,7,9,2,3],[9,3,7,4,8,2,5,1,6],[1,2,6,5,3,9,4,7,8],[2,9,3,6,5,8,1,4,7],[4,6,1,9,7,3,8,5,2],[5,7,8,2,1,4,3,6,9],[6,8,9,7,4,5,2,3,1],[7,4,2,3,9,1,6,8,5],[3,1,5,8,2,6,7,9,4]]
240	[[5,8,3,4,6,7,2,1,9],[4,7,1,2,8,9,3,6,5],[9,2,6,3,1,5,8,4,7],[3,6,2,5,7,8,1,9,4],[8,9,5,1,2,4,6,7,3],[1,4,7,9,3,6,5,8,2],[7,3,9,8,5,1,4,2,6],[2,1,4,6,9,3,7,5,8],[6,5,8,7,4,2,9,3,1]]
241	[[2,8,4,7,1,5,6,3,9],[3,1,5,4,6,9,2,8,7],[7,6,9,2,8,3,5,4,1],[9,5,3,8,4,1,7,2,6],[6,2,1,9,3,7,4,5,8],[4,7,8,5,2,6,9,1,3],[8,9,2,1,7,4,3,6,5],[1,3,7,6,5,2,8,9,4],[5,4,6,3,9,8,1,7,2]]
242	[[3,5,7,6,4,1,8,9,2],[2,9,4,7,8,5,6,1,3],[8,6,1,3,2,9,5,4,7],[4,2,3,8,9,7,1,6,5],[1,7,6,4,5,2,9,3,8],[5,8,9,1,6,3,7,2,4],[7,1,5,2,3,6,4,8,9],[6,4,2,9,7,8,3,5,1],[9,3,8,5,1,4,2,7,6]]
243	[[8,2,7,6,9,4,1,3,5],[1,5,9,3,8,2,6,4,7],[3,6,4,1,7,5,8,2,9],[9,4,5,2,1,8,3,7,6],[6,1,8,5,3,7,2,9,4],[7,3,2,9,4,6,5,8,1],[4,7,1,8,6,3,9,5,2],[2,9,3,7,5,1,4,6,8],[5,8,6,4,2,9,7,1,3]]
244	[[3,7,8,4,1,9,2,5,6],[1,6,2,5,3,8,9,4,7],[5,9,4,6,2,7,1,3,8],[6,8,7,1,5,4,3,2,9],[2,4,1,9,7,3,8,6,5],[9,3,5,2,8,6,7,1,4],[4,1,3,7,9,5,6,8,2],[7,2,6,8,4,1,5,9,3],[8,5,9,3,6,2,4,7,1]]
245	[[7,8,1,2,4,3,9,6,5],[3,9,2,7,5,6,8,1,4],[6,5,4,1,8,9,2,3,7],[1,4,8,9,3,7,5,2,6],[5,7,6,4,1,2,3,8,9],[2,3,9,5,6,8,4,7,1],[4,2,5,8,7,1,6,9,3],[9,1,3,6,2,5,7,4,8],[8,6,7,3,9,4,1,5,2]]
246	[[7,3,8,2,1,6,5,9,4],[4,6,1,9,3,5,7,2,8],[9,5,2,7,8,4,3,1,6],[3,8,9,6,4,2,1,7,5],[5,1,6,3,7,9,4,8,2],[2,4,7,8,5,1,9,6,3],[1,2,5,4,9,8,6,3,7],[6,7,4,1,2,3,8,5,9],[8,9,3,5,6,7,2,4,1]]
247	[[5,2,3,9,1,7,4,8,6],[7,9,1,8,6,4,3,2,5],[6,4,8,2,3,5,1,7,9],[2,8,5,6,9,3,7,1,4],[4,3,9,7,8,1,5,6,2],[1,7,6,5,4,2,8,9,3],[9,1,4,3,7,6,2,5,8],[3,6,2,1,5,8,9,4,7],[8,5,7,4,2,9,6,3,1]]
248	[[8,3,4,1,5,7,2,9,6],[1,5,2,6,8,9,7,4,3],[6,9,7,3,4,2,8,1,5],[2,6,1,4,7,5,3,8,9],[5,8,3,2,9,1,4,6,7],[4,7,9,8,6,3,5,2,1],[3,2,6,5,1,8,9,7,4],[9,1,5,7,2,4,6,3,8],[7,4,8,9,3,6,1,5,2]]
249	[[8,3,1,4,2,7,6,5,9],[4,9,7,6,8,5,1,2,3],[2,5,6,9,3,1,8,4,7],[5,7,3,1,4,2,9,6,8],[1,8,4,5,6,9,3,7,2],[6,2,9,8,7,3,4,1,5],[7,1,8,2,9,6,5,3,4],[3,4,5,7,1,8,2,9,6],[9,6,2,3,5,4,7,8,1]]
250	[[2,5,6,1,4,7,3,9,8],[8,1,9,2,3,5,6,7,4],[7,3,4,8,9,6,2,1,5],[9,7,2,3,5,4,1,8,6],[3,8,5,9,6,1,7,4,2],[6,4,1,7,2,8,9,5,3],[1,2,3,4,8,9,5,6,7],[4,6,7,5,1,3,8,2,9],[5,9,8,6,7,2,4,3,1]]
251	[[5,3,6,2,7,9,1,4,8],[2,7,4,5,8,1,6,9,3],[8,1,9,3,6,4,2,5,7],[3,8,1,4,5,7,9,2,6],[6,4,7,1,9,2,3,8,5],[9,2,5,8,3,6,7,1,4],[4,6,3,9,1,8,5,7,2],[1,5,2,7,4,3,8,6,9],[7,9,8,6,2,5,4,3,1]]
252	[[8,7,5,1,6,2,4,9,3],[4,3,2,7,5,9,8,1,6],[6,1,9,4,8,3,7,5,2],[1,6,3,2,7,4,5,8,9],[5,2,7,6,9,8,3,4,1],[9,4,8,3,1,5,2,6,7],[7,9,4,8,3,6,1,2,5],[3,8,6,5,2,1,9,7,4],[2,5,1,9,4,7,6,3,8]]
253	[[7,8,6,4,2,9,5,3,1],[5,2,9,6,1,3,4,8,7],[1,3,4,5,7,8,6,9,2],[8,9,3,2,4,5,7,1,6],[4,1,5,8,6,7,3,2,9],[6,7,2,9,3,1,8,4,5],[9,4,8,7,5,2,1,6,3],[3,6,7,1,9,4,2,5,8],[2,5,1,3,8,6,9,7,4]]
254	[[7,5,6,1,9,3,8,2,4],[9,2,1,8,4,6,3,7,5],[4,3,8,2,5,7,1,6,9],[6,8,4,5,7,2,9,1,3],[5,1,7,6,3,9,4,8,2],[3,9,2,4,8,1,6,5,7],[2,7,9,3,1,8,5,4,6],[1,6,5,9,2,4,7,3,8],[8,4,3,7,6,5,2,9,1]]
255	[[3,8,9,6,1,2,5,4,7],[2,7,5,3,9,4,6,8,1],[1,6,4,8,5,7,2,9,3],[7,2,3,1,6,8,9,5,4],[6,5,1,2,4,9,7,3,8],[4,9,8,7,3,5,1,6,2],[5,3,2,9,8,1,4,7,6],[8,4,7,5,2,6,3,1,9],[9,1,6,4,7,3,8,2,5]]
256	[[1,3,4,8,2,7,5,9,6],[5,8,7,3,6,9,1,4,2],[9,2,6,4,1,5,7,8,3],[8,1,9,7,3,6,4,2,5],[7,4,3,5,8,2,6,1,9],[2,6,5,1,9,4,8,3,7],[6,5,8,2,4,3,9,7,1],[3,9,1,6,7,8,2,5,4],[4,7,2,9,5,1,3,6,8]]
257	[[1,2,9,4,5,3,6,8,7],[6,3,5,7,1,8,9,2,4],[7,8,4,9,6,2,5,1,3],[5,1,6,3,8,4,7,9,2],[3,4,7,2,9,5,8,6,1],[2,9,8,6,7,1,3,4,5],[9,7,1,5,4,6,2,3,8],[4,5,2,8,3,9,1,7,6],[8,6,3,1,2,7,4,5,9]]
258	[[2,3,9,5,6,7,1,4,8],[1,7,6,4,3,8,9,5,2],[8,5,4,1,2,9,6,3,7],[3,2,8,7,5,1,4,6,9],[9,4,1,2,8,6,3,7,5],[5,6,7,3,9,4,8,2,1],[6,1,2,8,4,5,7,9,3],[4,8,3,9,7,2,5,1,6],[7,9,5,6,1,3,2,8,4]]
259	[[4,6,1,9,7,2,8,3,5],[8,5,2,1,4,3,9,7,6],[9,7,3,6,5,8,1,4,2],[1,8,5,4,9,6,3,2,7],[3,9,4,2,8,7,6,5,1],[6,2,7,3,1,5,4,8,9],[7,4,6,5,3,9,2,1,8],[2,1,8,7,6,4,5,9,3],[5,3,9,8,2,1,7,6,4]]
260	[[1,4,8,7,3,2,6,5,9],[7,6,5,9,4,1,3,2,8],[3,9,2,6,5,8,4,1,7],[9,5,7,4,8,6,2,3,1],[8,3,1,5,2,9,7,6,4],[4,2,6,3,1,7,9,8,5],[6,1,4,8,7,3,5,9,2],[5,8,3,2,9,4,1,7,6],[2,7,9,1,6,5,8,4,3]]
261	[[9,7,5,3,2,8,1,6,4],[6,2,1,9,4,5,7,8,3],[3,4,8,7,1,6,5,2,9],[2,9,3,6,5,7,8,4,1],[4,8,6,1,3,2,9,5,7],[1,5,7,8,9,4,2,3,6],[5,1,9,4,8,3,6,7,2],[7,3,2,5,6,9,4,1,8],[8,6,4,2,7,1,3,9,5]]
262	[[3,1,4,6,5,9,2,8,7],[6,8,9,1,7,2,5,3,4],[2,5,7,4,3,8,6,9,1],[5,3,8,7,1,6,4,2,9],[4,7,6,2,9,5,8,1,3],[1,9,2,3,8,4,7,5,6],[8,2,1,9,6,7,3,4,5],[9,6,5,8,4,3,1,7,2],[7,4,3,5,2,1,9,6,8]]
263	[[3,1,9,5,8,7,2,6,4],[5,7,2,3,4,6,9,8,1],[8,6,4,2,9,1,7,3,5],[1,5,6,7,2,9,8,4,3],[2,4,8,6,5,3,1,7,9],[7,9,3,8,1,4,5,2,6],[9,3,1,4,7,8,6,5,2],[4,2,7,1,6,5,3,9,8],[6,8,5,9,3,2,4,1,7]]
264	[[8,3,7,2,9,4,5,1,6],[2,9,1,5,6,8,4,3,7],[4,6,5,3,1,7,2,8,9],[5,4,2,8,7,1,9,6,3],[3,7,9,6,4,5,8,2,1],[1,8,6,9,3,2,7,4,5],[9,2,4,1,5,3,6,7,8],[6,1,8,7,2,9,3,5,4],[7,5,3,4,8,6,1,9,2]]
265	[[4,2,3,8,9,5,1,6,7],[7,5,6,1,3,4,9,2,8],[9,1,8,6,2,7,4,3,5],[5,9,1,3,7,2,6,8,4],[6,3,7,4,8,9,5,1,2],[8,4,2,5,6,1,3,7,9],[3,6,9,7,4,8,2,5,1],[2,8,5,9,1,3,7,4,6],[1,7,4,2,5,6,8,9,3]]
266	[[8,1,7,6,5,4,2,3,9],[2,4,6,3,9,1,5,8,7],[9,5,3,8,7,2,1,4,6],[3,9,8,4,2,5,7,6,1],[4,6,2,1,3,7,8,9,5],[1,7,5,9,8,6,3,2,4],[6,3,4,7,1,8,9,5,2],[7,2,9,5,4,3,6,1,8],[5,8,1,2,6,9,4,7,3]]
267	[[4,3,9,1,2,7,8,5,6],[6,5,2,8,3,9,1,4,7],[8,1,7,4,5,6,2,9,3],[3,8,1,2,9,4,6,7,5],[7,9,6,5,1,3,4,2,8],[5,2,4,6,7,8,3,1,9],[9,4,5,3,6,1,7,8,2],[2,6,8,7,4,5,9,3,1],[1,7,3,9,8,2,5,6,4]]
268	[[5,4,6,8,1,9,2,3,7],[3,2,9,6,4,7,5,1,8],[1,7,8,5,2,3,6,4,9],[9,3,4,7,6,5,8,2,1],[7,6,2,1,3,8,4,9,5],[8,5,1,4,9,2,7,6,3],[2,1,7,3,8,6,9,5,4],[4,9,5,2,7,1,3,8,6],[6,8,3,9,5,4,1,7,2]]
269	[[4,8,7,6,5,3,9,2,1],[9,5,2,8,1,7,3,4,6],[1,3,6,2,9,4,7,5,8],[6,7,1,3,4,9,5,8,2],[8,9,5,1,6,2,4,3,7],[2,4,3,5,7,8,6,1,9],[3,1,9,4,2,6,8,7,5],[5,6,4,7,8,1,2,9,3],[7,2,8,9,3,5,1,6,4]]
270	[[8,4,9,7,1,6,2,5,3],[1,5,3,2,4,8,9,6,7],[7,6,2,9,3,5,1,4,8],[2,9,8,4,6,7,3,1,5],[5,3,7,1,8,9,4,2,6],[6,1,4,3,5,2,8,7,9],[4,8,1,6,7,3,5,9,2],[9,7,5,8,2,4,6,3,1],[3,2,6,5,9,1,7,8,4]]
271	[[7,4,1,9,2,6,3,5,8],[9,5,8,7,4,3,1,6,2],[3,6,2,8,5,1,7,4,9],[4,9,6,1,8,5,2,7,3],[8,7,3,4,9,2,5,1,6],[2,1,5,3,6,7,9,8,4],[5,8,7,2,3,4,6,9,1],[1,3,4,6,7,9,8,2,5],[6,2,9,5,1,8,4,3,7]]
272	[[4,7,6,2,1,3,5,8,9],[5,9,1,7,8,6,3,4,2],[8,3,2,5,9,4,6,1,7],[7,1,3,4,6,2,9,5,8],[6,2,5,9,7,8,1,3,4],[9,8,4,3,5,1,2,7,6],[2,6,7,8,3,5,4,9,1],[3,4,8,1,2,9,7,6,5],[1,5,9,6,4,7,8,2,3]]
273	[[6,4,2,1,3,5,9,7,8],[8,5,7,6,2,9,1,3,4],[3,1,9,7,8,4,6,5,2],[1,8,3,4,9,7,5,2,6],[2,9,6,3,5,1,8,4,7],[5,7,4,2,6,8,3,1,9],[7,6,1,8,4,3,2,9,5],[9,3,8,5,7,2,4,6,1],[4,2,5,9,1,6,7,8,3]]
274	[[9,1,3,6,4,7,2,5,8],[7,4,5,2,8,1,9,3,6],[8,2,6,5,9,3,7,4,1],[2,7,1,3,6,8,5,9,4],[4,6,8,7,5,9,1,2,3],[5,3,9,4,1,2,6,8,7],[3,5,2,1,7,4,8,6,9],[1,8,4,9,2,6,3,7,5],[6,9,7,8,3,5,4,1,2]]
275	[[8,3,1,4,7,5,9,6,2],[4,9,2,1,6,8,7,5,3],[6,7,5,9,2,3,8,4,1],[5,6,4,2,9,1,3,7,8],[2,8,7,6,3,4,5,1,9],[9,1,3,5,8,7,6,2,4],[7,5,8,3,4,2,1,9,6],[3,4,6,7,1,9,2,8,5],[1,2,9,8,5,6,4,3,7]]
276	[[5,9,1,7,6,2,8,3,4],[2,7,3,8,4,1,5,6,9],[4,6,8,9,3,5,2,7,1],[3,2,4,6,9,8,7,1,5],[7,8,9,1,5,3,4,2,6],[1,5,6,2,7,4,3,9,8],[8,3,7,5,1,9,6,4,2],[6,1,2,4,8,7,9,5,3],[9,4,5,3,2,6,1,8,7]]
277	[[5,9,3,1,4,6,2,8,7],[8,7,1,3,9,2,5,6,4],[4,6,2,7,5,8,9,3,1],[6,2,4,8,1,5,7,9,3],[3,5,8,4,7,9,6,1,2],[9,1,7,2,6,3,4,5,8],[2,8,9,6,3,4,1,7,5],[7,3,6,5,2,1,8,4,9],[1,4,5,9,8,7,3,2,6]]
278	[[5,8,9,3,4,7,2,6,1],[3,2,4,6,9,1,8,7,5],[7,1,6,5,2,8,3,4,9],[8,6,1,2,7,5,4,9,3],[4,9,5,1,8,3,6,2,7],[2,7,3,9,6,4,5,1,8],[1,4,2,8,3,9,7,5,6],[9,3,7,4,5,6,1,8,2],[6,5,8,7,1,2,9,3,4]]
279	[[7,5,9,3,1,8,6,4,2],[3,4,6,2,9,7,1,5,8],[1,2,8,4,5,6,7,9,3],[6,3,7,1,2,4,5,8,9],[2,9,5,8,6,3,4,7,1],[8,1,4,5,7,9,3,2,6],[9,6,1,7,4,2,8,3,5],[5,7,3,9,8,1,2,6,4],[4,8,2,6,3,5,9,1,7]]
280	[[4,3,1,2,7,5,6,8,9],[5,6,8,3,4,9,1,7,2],[9,7,2,8,6,1,4,5,3],[1,8,9,5,3,4,2,6,7],[6,4,3,9,2,7,8,1,5],[2,5,7,1,8,6,3,9,4],[3,2,6,7,5,8,9,4,1],[7,1,4,6,9,3,5,2,8],[8,9,5,4,1,2,7,3,6]]
281	[[6,1,2,7,5,8,3,9,4],[3,4,9,2,1,6,5,7,8],[7,8,5,3,4,9,1,2,6],[5,7,6,8,3,1,2,4,9],[4,9,1,6,2,5,7,8,3],[2,3,8,9,7,4,6,5,1],[9,5,3,1,8,7,4,6,2],[1,6,7,4,9,2,8,3,5],[8,2,4,5,6,3,9,1,7]]
282	[[4,5,2,6,3,1,9,7,8],[6,8,9,7,5,4,1,2,3],[7,3,1,8,2,9,5,6,4],[8,1,6,2,7,3,4,5,9],[3,7,5,4,9,6,8,1,2],[2,9,4,5,1,8,6,3,7],[5,6,3,9,4,2,7,8,1],[9,2,7,1,8,5,3,4,6],[1,4,8,3,6,7,2,9,5]]
283	[[1,4,5,8,2,6,7,9,3],[6,3,9,4,1,7,2,8,5],[7,8,2,5,9,3,6,1,4],[9,5,3,1,7,4,8,6,2],[2,7,1,6,8,5,3,4,9],[8,6,4,2,3,9,1,5,7],[4,1,8,7,5,2,9,3,6],[3,2,6,9,4,8,5,7,1],[5,9,7,3,6,1,4,2,8]]
284	[[5,7,3,9,4,8,2,6,1],[8,6,4,2,3,1,9,7,5],[9,1,2,6,7,5,3,4,8],[4,2,9,8,6,3,1,5,7],[6,5,8,1,2,7,4,9,3],[7,3,1,4,5,9,6,8,2],[3,4,5,7,1,6,8,2,9],[1,9,6,5,8,2,7,3,4],[2,8,7,3,9,4,5,1,6]]
285	[[1,2,4,5,8,3,6,9,7],[8,9,7,4,6,2,1,3,5],[3,6,5,9,7,1,4,2,8],[7,1,9,2,3,8,5,4,6],[2,4,8,6,5,9,7,1,3],[5,3,6,1,4,7,2,8,9],[6,7,1,3,9,4,8,5,2],[4,5,3,8,2,6,9,7,1],[9,8,2,7,1,5,3,6,4]]
286	[[5,2,9,6,4,7,1,3,8],[3,8,6,2,9,1,7,5,4],[4,1,7,8,5,3,2,6,9],[8,4,2,5,7,6,3,9,1],[9,3,5,1,2,4,8,7,6],[7,6,1,9,3,8,4,2,5],[6,7,3,4,8,9,5,1,2],[1,5,4,3,6,2,9,8,7],[2,9,8,7,1,5,6,4,3]]
287	[[7,5,6,1,9,3,2,4,8],[4,1,9,8,2,5,7,6,3],[2,8,3,4,7,6,1,9,5],[6,3,1,2,4,7,5,8,9],[5,7,8,6,1,9,3,2,4],[9,2,4,3,5,8,6,7,1],[3,6,7,9,8,1,4,5,2],[1,9,2,5,6,4,8,3,7],[8,4,5,7,3,2,9,1,6]]
288	[[5,6,1,3,4,2,7,9,8],[8,4,9,5,1,7,6,2,3],[2,3,7,8,6,9,4,5,1],[1,5,6,2,9,8,3,7,4],[9,8,3,1,7,4,5,6,2],[4,7,2,6,5,3,1,8,9],[6,2,5,4,8,1,9,3,7],[7,1,8,9,3,6,2,4,5],[3,9,4,7,2,5,8,1,6]]
289	[[8,5,3,9,2,1,6,4,7],[2,7,6,5,4,8,3,9,1],[4,1,9,3,6,7,2,5,8],[3,8,2,6,9,4,1,7,5],[6,9,1,7,8,5,4,2,3],[7,4,5,1,3,2,8,6,9],[9,6,7,2,1,3,5,8,4],[1,2,4,8,5,9,7,3,6],[5,3,8,4,7,6,9,1,2]]
290	[[3,7,2,4,9,6,5,1,8],[4,8,9,7,5,1,3,2,6],[1,6,5,8,3,2,9,7,4],[5,4,6,9,2,7,1,8,3],[9,1,7,5,8,3,6,4,2],[2,3,8,1,6,4,7,5,9],[6,2,1,3,7,8,4,9,5],[8,5,4,6,1,9,2,3,7],[7,9,3,2,4,5,8,6,1]]
291	[[2,7,8,1,3,9,5,4,6],[3,4,6,5,7,8,9,2,1],[9,5,1,2,6,4,3,7,8],[8,6,9,7,1,3,2,5,4],[4,2,7,8,9,5,1,6,3],[5,1,3,4,2,6,8,9,7],[1,3,2,6,5,7,4,8,9],[6,9,4,3,8,2,7,1,5],[7,8,5,9,4,1,6,3,2]]
292	[[3,2,5,7,1,9,4,6,8],[1,7,6,4,3,8,2,9,5],[8,4,9,2,6,5,7,3,1],[9,6,1,8,4,2,3,5,7],[4,8,3,5,7,1,9,2,6],[7,5,2,6,9,3,8,1,4],[5,9,4,3,8,6,1,7,2],[2,1,8,9,5,7,6,4,3],[6,3,7,1,2,4,5,8,9]]
293	[[1,7,3,4,2,6,9,5,8],[2,5,8,1,9,7,3,6,4],[4,9,6,8,5,3,1,7,2],[8,6,4,5,7,1,2,9,3],[9,3,1,6,8,2,5,4,7],[5,2,7,9,3,4,8,1,6],[6,8,5,2,4,9,7,3,1],[7,4,2,3,1,5,6,8,9],[3,1,9,7,6,8,4,2,5]]
294	[[9,2,8,5,4,1,7,6,3],[1,5,4,7,6,3,2,8,9],[6,3,7,8,2,9,5,4,1],[4,6,2,9,3,7,8,1,5],[3,8,9,4,1,5,6,2,7],[5,7,1,2,8,6,9,3,4],[7,4,3,6,5,8,1,9,2],[8,1,5,3,9,2,4,7,6],[2,9,6,1,7,4,3,5,8]]
295	[[6,1,9,8,4,5,3,7,2],[3,7,8,2,6,9,1,4,5],[2,4,5,3,1,7,6,9,8],[9,3,4,1,7,8,2,5,6],[1,6,7,4,5,2,8,3,9],[5,8,2,9,3,6,4,1,7],[7,9,3,6,8,4,5,2,1],[4,5,6,7,2,1,9,8,3],[8,2,1,5,9,3,7,6,4]]
296	[[6,7,5,2,8,1,4,3,9],[2,3,9,7,5,4,1,6,8],[1,8,4,6,3,9,5,2,7],[3,9,1,4,7,5,2,8,6],[7,4,2,3,6,8,9,5,1],[5,6,8,9,1,2,7,4,3],[8,5,7,1,2,6,3,9,4],[4,1,6,5,9,3,8,7,2],[9,2,3,8,4,7,6,1,5]]
297	[[9,7,2,1,6,4,3,5,8],[3,6,1,5,9,8,7,2,4],[5,8,4,2,3,7,9,1,6],[4,9,5,7,1,2,6,8,3],[6,1,3,9,8,5,2,4,7],[8,2,7,6,4,3,5,9,1],[1,3,9,4,5,6,8,7,2],[7,5,6,8,2,1,4,3,9],[2,4,8,3,7,9,1,6,5]]
298	[[3,1,8,5,2,9,7,6,4],[4,9,7,3,6,1,5,2,8],[2,6,5,8,4,7,3,1,9],[7,8,2,9,5,6,4,3,1],[5,4,6,1,7,3,8,9,2],[9,3,1,2,8,4,6,5,7],[1,7,4,6,9,5,2,8,3],[8,5,9,4,3,2,1,7,6],[6,2,3,7,1,8,9,4,5]]
299	[[3,7,6,8,5,9,4,2,1],[9,2,1,3,7,4,6,8,5],[4,5,8,1,6,2,7,3,9],[7,6,2,5,8,1,9,4,3],[5,1,3,9,4,7,2,6,8],[8,9,4,2,3,6,1,5,7],[6,3,9,7,2,5,8,1,4],[2,8,7,4,1,3,5,9,6],[1,4,5,6,9,8,3,7,2]]
300	[[7,4,8,6,3,9,5,1,2],[5,2,1,7,8,4,9,6,3],[9,6,3,5,2,1,4,8,7],[1,9,5,8,4,7,2,3,6],[3,8,4,2,9,6,1,7,5],[6,7,2,3,1,5,8,9,4],[4,3,9,1,7,2,6,5,8],[8,1,6,4,5,3,7,2,9],[2,5,7,9,6,8,3,4,1]]
301	[[9,6,8,7,5,1,2,3,4],[3,5,7,2,4,9,6,8,1],[2,1,4,6,8,3,7,5,9],[7,4,1,5,2,6,3,9,8],[5,9,6,1,3,8,4,2,7],[8,2,3,4,9,7,5,1,6],[4,8,5,9,7,2,1,6,3],[6,7,9,3,1,5,8,4,2],[1,3,2,8,6,4,9,7,5]]
302	[[5,2,3,7,9,1,4,6,8],[4,6,1,5,8,3,7,9,2],[9,7,8,4,6,2,3,1,5],[3,8,5,9,4,6,1,2,7],[6,9,2,3,1,7,5,8,4],[1,4,7,2,5,8,9,3,6],[2,3,6,1,7,5,8,4,9],[7,1,4,8,2,9,6,5,3],[8,5,9,6,3,4,2,7,1]]
303	[[2,7,8,3,5,4,1,6,9],[1,5,4,9,2,6,7,3,8],[6,3,9,1,7,8,5,4,2],[4,6,7,8,9,5,2,1,3],[9,8,2,7,3,1,4,5,6],[5,1,3,6,4,2,8,9,7],[3,4,1,2,8,9,6,7,5],[7,2,5,4,6,3,9,8,1],[8,9,6,5,1,7,3,2,4]]
304	[[8,6,9,3,1,2,5,7,4],[4,5,3,8,9,7,1,6,2],[7,2,1,4,5,6,8,9,3],[3,1,2,6,7,9,4,5,8],[5,4,6,1,3,8,7,2,9],[9,7,8,5,2,4,6,3,1],[6,8,7,2,4,3,9,1,5],[1,3,4,9,6,5,2,8,7],[2,9,5,7,8,1,3,4,6]]
305	[[4,5,6,9,2,1,3,7,8],[2,3,9,5,8,7,6,1,4],[1,8,7,4,3,6,5,2,9],[9,4,3,1,7,8,2,6,5],[5,6,1,2,4,9,7,8,3],[8,7,2,6,5,3,9,4,1],[6,2,5,3,1,4,8,9,7],[3,1,8,7,9,2,4,5,6],[7,9,4,8,6,5,1,3,2]]
306	[[8,3,1,9,2,6,7,5,4],[4,2,9,3,5,7,8,6,1],[7,6,5,8,1,4,9,3,2],[2,1,4,5,6,9,3,7,8],[3,5,7,2,4,8,1,9,6],[6,9,8,7,3,1,4,2,5],[5,4,3,1,9,2,6,8,7],[1,8,2,6,7,3,5,4,9],[9,7,6,4,8,5,2,1,3]]
307	[[8,4,7,2,9,5,6,1,3],[1,3,2,4,8,6,9,5,7],[9,6,5,7,1,3,2,8,4],[3,7,1,8,6,2,4,9,5],[2,5,9,3,7,4,8,6,1],[6,8,4,1,5,9,7,3,2],[4,9,3,5,2,8,1,7,6],[5,1,8,6,4,7,3,2,9],[7,2,6,9,3,1,5,4,8]]
308	[[9,5,4,8,6,7,1,3,2],[6,1,8,3,2,4,5,7,9],[3,7,2,5,9,1,6,8,4],[8,9,6,2,1,3,7,4,5],[5,3,7,9,4,6,2,1,8],[4,2,1,7,5,8,9,6,3],[2,4,3,6,7,5,8,9,1],[7,8,9,1,3,2,4,5,6],[1,6,5,4,8,9,3,2,7]]
309	[[2,7,3,9,1,4,6,8,5],[4,5,1,8,6,7,3,9,2],[8,9,6,2,3,5,4,1,7],[5,3,8,1,4,6,2,7,9],[9,6,7,5,8,2,1,4,3],[1,2,4,7,9,3,5,6,8],[3,1,9,4,2,8,7,5,6],[6,8,5,3,7,1,9,2,4],[7,4,2,6,5,9,8,3,1]]
310	[[6,1,3,8,9,2,4,7,5],[5,2,8,7,4,3,6,9,1],[4,7,9,5,1,6,8,2,3],[2,5,6,1,7,9,3,8,4],[7,3,4,2,5,8,1,6,9],[9,8,1,3,6,4,2,5,7],[3,4,2,9,8,7,5,1,6],[1,6,7,4,2,5,9,3,8],[8,9,5,6,3,1,7,4,2]]
311	[[4,6,7,1,3,5,2,9,8],[8,3,9,7,2,6,4,1,5],[1,2,5,9,4,8,6,3,7],[9,1,3,4,7,2,8,5,6],[7,8,6,5,9,1,3,2,4],[2,5,4,6,8,3,1,7,9],[5,4,8,3,1,7,9,6,2],[6,9,1,2,5,4,7,8,3],[3,7,2,8,6,9,5,4,1]]
312	[[8,5,7,4,3,6,2,1,9],[9,2,4,1,7,5,3,6,8],[6,1,3,2,9,8,4,5,7],[5,3,8,9,6,7,1,4,2],[1,7,6,3,2,4,9,8,5],[4,9,2,5,8,1,6,7,3],[3,6,5,7,4,9,8,2,1],[2,4,1,8,5,3,7,9,6],[7,8,9,6,1,2,5,3,4]]
313	[[3,9,2,7,8,6,5,1,4],[4,5,6,3,9,1,2,8,7],[8,1,7,5,2,4,9,6,3],[7,8,1,9,4,3,6,2,5],[2,4,9,1,6,5,7,3,8],[6,3,5,2,7,8,1,4,9],[5,7,4,6,3,2,8,9,1],[9,6,3,8,1,7,4,5,2],[1,2,8,4,5,9,3,7,6]]
314	[[4,2,3,7,5,6,9,8,1],[5,8,6,2,1,9,7,4,3],[7,9,1,8,4,3,5,6,2],[3,1,2,6,7,5,4,9,8],[8,6,4,3,9,2,1,5,7],[9,7,5,4,8,1,2,3,6],[1,5,8,9,6,7,3,2,4],[2,4,7,5,3,8,6,1,9],[6,3,9,1,2,4,8,7,5]]
315	[[6,5,2,3,9,1,8,7,4],[4,1,3,7,8,5,6,2,9],[8,9,7,2,4,6,5,3,1],[2,8,5,6,1,3,9,4,7],[9,7,1,4,2,8,3,5,6],[3,6,4,9,5,7,1,8,2],[7,4,8,5,6,9,2,1,3],[5,2,6,1,3,4,7,9,8],[1,3,9,8,7,2,4,6,5]]
316	[[4,7,1,3,9,6,8,5,2],[8,5,9,2,1,4,6,7,3],[3,2,6,7,5,8,1,9,4],[6,4,5,1,2,7,9,3,8],[7,9,2,8,4,3,5,6,1],[1,3,8,9,6,5,2,4,7],[9,8,4,5,7,1,3,2,6],[2,6,3,4,8,9,7,1,5],[5,1,7,6,3,2,4,8,9]]
317	[[4,1,3,7,5,8,6,9,2],[2,6,7,9,1,4,3,5,8],[9,5,8,6,2,3,1,7,4],[1,2,4,8,7,6,5,3,9],[3,8,6,4,9,5,2,1,7],[5,7,9,2,3,1,8,4,6],[7,3,2,5,8,9,4,6,1],[6,9,1,3,4,2,7,8,5],[8,4,5,1,6,7,9,2,3]]
318	[[2,6,5,8,3,4,7,1,9],[9,4,7,2,5,1,6,3,8],[1,3,8,9,6,7,2,4,5],[8,5,4,6,7,9,1,2,3],[7,2,9,4,1,3,8,5,6],[3,1,6,5,2,8,4,9,7],[6,7,2,1,9,5,3,8,4],[5,8,3,7,4,2,9,6,1],[4,9,1,3,8,6,5,7,2]]
319	[[5,7,4,9,3,6,1,8,2],[8,6,9,1,7,2,5,4,3],[3,2,1,5,4,8,7,9,6],[2,1,7,8,9,3,4,6,5],[6,9,5,2,1,4,3,7,8],[4,8,3,7,6,5,2,1,9],[1,4,2,3,8,9,6,5,7],[9,5,6,4,2,7,8,3,1],[7,3,8,6,5,1,9,2,4]]
320	[[9,2,5,7,8,4,3,1,6],[7,4,6,9,3,1,5,2,8],[8,3,1,5,6,2,4,9,7],[3,7,4,2,5,9,6,8,1],[6,8,2,1,7,3,9,4,5],[5,1,9,8,4,6,7,3,2],[4,9,7,6,1,8,2,5,3],[2,6,8,3,9,5,1,7,4],[1,5,3,4,2,7,8,6,9]]
321	[[4,1,2,7,3,6,9,8,5],[3,8,5,1,9,2,6,7,4],[6,9,7,5,4,8,2,3,1],[1,7,9,6,8,4,5,2,3],[8,2,4,3,5,9,7,1,6],[5,6,3,2,7,1,4,9,8],[7,5,8,4,2,3,1,6,9],[2,3,1,9,6,5,8,4,7],[9,4,6,8,1,7,3,5,2]]
322	[[6,5,1,2,3,4,7,8,9],[2,7,3,8,9,1,4,5,6],[8,9,4,5,6,7,1,3,2],[1,8,6,3,5,9,2,7,4],[5,4,2,1,7,6,3,9,8],[9,3,7,4,2,8,5,6,1],[7,2,8,6,1,5,9,4,3],[3,6,5,9,4,2,8,1,7],[4,1,9,7,8,3,6,2,5]]
323	[[8,5,2,9,1,6,4,3,7],[7,9,6,8,3,4,1,5,2],[3,4,1,7,2,5,8,6,9],[2,7,9,5,8,3,6,1,4],[6,1,5,4,7,2,9,8,3],[4,3,8,1,6,9,2,7,5],[9,8,4,6,5,7,3,2,1],[5,6,3,2,4,1,7,9,8],[1,2,7,3,9,8,5,4,6]]
324	[[2,4,7,3,9,1,5,6,8],[1,9,8,5,2,6,4,3,7],[6,3,5,4,7,8,9,2,1],[8,7,9,1,4,2,3,5,6],[3,1,6,8,5,9,2,7,4],[4,5,2,7,6,3,8,1,9],[5,8,3,9,1,7,6,4,2],[9,2,1,6,3,4,7,8,5],[7,6,4,2,8,5,1,9,3]]
325	[[5,9,4,7,3,6,1,2,8],[2,3,1,4,8,9,6,7,5],[6,7,8,1,5,2,9,3,4],[3,4,9,8,6,7,5,1,2],[8,2,5,3,9,1,7,4,6],[1,6,7,2,4,5,8,9,3],[9,8,3,6,7,4,2,5,1],[4,5,2,9,1,8,3,6,7],[7,1,6,5,2,3,4,8,9]]
326	[[4,6,3,8,1,9,7,5,2],[5,7,8,3,6,2,1,9,4],[9,1,2,7,5,4,6,8,3],[8,3,1,6,2,5,9,4,7],[7,4,9,1,3,8,5,2,6],[2,5,6,9,4,7,3,1,8],[1,8,5,2,7,3,4,6,9],[3,2,4,5,9,6,8,7,1],[6,9,7,4,8,1,2,3,5]]
327	[[9,7,8,1,4,5,6,3,2],[1,6,4,8,2,3,5,9,7],[5,2,3,6,9,7,8,4,1],[2,3,6,7,1,8,9,5,4],[7,4,9,2,5,6,1,8,3],[8,5,1,4,3,9,2,7,6],[4,8,2,9,7,1,3,6,5],[3,9,7,5,6,2,4,1,8],[6,1,5,3,8,4,7,2,9]]
328	[[8,4,9,7,2,6,3,1,5],[3,2,7,1,4,5,6,9,8],[5,1,6,8,9,3,7,4,2],[4,9,2,5,8,7,1,6,3],[6,7,5,9,3,1,2,8,4],[1,8,3,2,6,4,9,5,7],[7,3,4,6,1,8,5,2,9],[9,5,1,4,7,2,8,3,6],[2,6,8,3,5,9,4,7,1]]
329	[[5,8,9,6,4,3,7,2,1],[1,2,6,7,9,8,5,3,4],[7,3,4,1,2,5,9,8,6],[9,6,2,3,7,1,8,4,5],[3,5,1,9,8,4,6,7,2],[8,4,7,2,5,6,3,1,9],[4,9,8,5,3,2,1,6,7],[6,7,3,4,1,9,2,5,8],[2,1,5,8,6,7,4,9,3]]
330	[[3,4,8,1,5,9,6,2,7],[6,7,2,4,8,3,5,9,1],[1,9,5,6,2,7,4,3,8],[8,5,1,2,6,4,9,7,3],[4,3,6,9,7,8,2,1,5],[9,2,7,3,1,5,8,4,6],[2,1,3,8,9,6,7,5,4],[5,6,4,7,3,2,1,8,9],[7,8,9,5,4,1,3,6,2]]
331	[[2,5,4,1,7,3,6,9,8],[1,6,7,9,8,4,3,2,5],[3,9,8,6,2,5,1,4,7],[9,7,5,4,6,2,8,1,3],[6,2,3,7,1,8,4,5,9],[4,8,1,5,3,9,7,6,2],[8,4,9,3,5,6,2,7,1],[7,3,6,2,9,1,5,8,4],[5,1,2,8,4,7,9,3,6]]
332	[[3,8,9,7,5,1,6,4,2],[1,7,5,2,6,4,3,8,9],[2,4,6,3,9,8,7,5,1],[6,9,3,8,4,5,2,1,7],[4,2,1,6,7,3,5,9,8],[8,5,7,1,2,9,4,6,3],[5,3,4,9,1,2,8,7,6],[7,1,2,4,8,6,9,3,5],[9,6,8,5,3,7,1,2,4]]
333	[[7,4,5,6,8,1,3,9,2],[9,6,8,7,2,3,1,4,5],[1,2,3,9,5,4,8,6,7],[5,9,2,1,4,8,6,7,3],[4,7,1,2,3,6,5,8,9],[8,3,6,5,9,7,4,2,1],[2,1,9,4,6,5,7,3,8],[3,5,4,8,7,9,2,1,6],[6,8,7,3,1,2,9,5,4]]
334	[[3,9,1,2,6,4,8,5,7],[7,2,6,8,5,1,9,3,4],[4,5,8,3,9,7,6,2,1],[8,3,7,4,2,9,5,1,6],[1,4,9,6,8,5,2,7,3],[2,6,5,7,1,3,4,8,9],[9,1,4,5,3,2,7,6,8],[5,8,3,9,7,6,1,4,2],[6,7,2,1,4,8,3,9,5]]
335	[[8,6,1,4,7,3,9,5,2],[4,7,2,9,5,6,8,3,1],[9,3,5,1,2,8,6,7,4],[5,4,3,2,8,9,1,6,7],[6,9,8,7,1,5,4,2,3],[2,1,7,6,3,4,5,8,9],[1,5,9,3,6,7,2,4,8],[7,8,4,5,9,2,3,1,6],[3,2,6,8,4,1,7,9,5]]
336	[[6,1,2,3,7,4,9,8,5],[4,7,3,5,9,8,2,6,1],[9,8,5,2,6,1,4,7,3],[3,6,7,8,4,5,1,2,9],[5,2,1,7,3,9,6,4,8],[8,4,9,1,2,6,5,3,7],[1,3,4,9,8,2,7,5,6],[2,9,8,6,5,7,3,1,4],[7,5,6,4,1,3,8,9,2]]
337	[[9,5,1,3,2,6,8,4,7],[2,4,7,8,1,9,6,3,5],[3,8,6,7,5,4,1,9,2],[5,7,4,1,3,8,2,6,9],[6,3,2,9,7,5,4,8,1],[1,9,8,4,6,2,5,7,3],[8,2,9,5,4,3,7,1,6],[4,1,5,6,9,7,3,2,8],[7,6,3,2,8,1,9,5,4]]
338	[[2,9,6,5,3,4,1,8,7],[1,8,3,2,6,7,5,9,4],[7,4,5,9,8,1,6,2,3],[6,7,4,8,5,3,9,1,2],[3,2,8,1,7,9,4,5,6],[5,1,9,4,2,6,7,3,8],[8,5,1,7,4,2,3,6,9],[4,3,2,6,9,5,8,7,1],[9,6,7,3,1,8,2,4,5]]
339	[[7,5,1,4,6,8,9,3,2],[8,4,2,1,3,9,6,7,5],[6,3,9,2,7,5,8,4,1],[2,8,6,7,5,4,3,1,9],[3,9,5,8,1,2,7,6,4],[1,7,4,6,9,3,5,2,8],[9,1,3,5,2,6,4,8,7],[4,6,7,9,8,1,2,5,3],[5,2,8,3,4,7,1,9,6]]
340	[[8,1,9,6,4,2,7,3,5],[2,3,7,1,5,9,8,6,4],[6,4,5,7,8,3,1,2,9],[7,8,4,2,3,5,9,1,6],[5,6,2,9,1,7,3,4,8],[1,9,3,8,6,4,5,7,2],[9,2,1,5,7,6,4,8,3],[4,5,8,3,2,1,6,9,7],[3,7,6,4,9,8,2,5,1]]
341	[[1,5,2,7,4,6,8,3,9],[6,8,3,2,5,9,7,1,4],[4,7,9,8,1,3,2,5,6],[7,9,8,3,2,1,4,6,5],[2,1,6,4,9,5,3,7,8],[3,4,5,6,8,7,1,9,2],[9,2,1,5,7,4,6,8,3],[5,3,4,1,6,8,9,2,7],[8,6,7,9,3,2,5,4,1]]
342	[[6,2,5,3,7,1,4,8,9],[9,3,7,8,4,5,6,1,2],[8,4,1,9,6,2,5,3,7],[5,1,9,4,8,6,2,7,3],[2,7,8,1,5,3,9,6,4],[4,6,3,2,9,7,8,5,1],[7,8,2,6,1,9,3,4,5],[1,9,6,5,3,4,7,2,8],[3,5,4,7,2,8,1,9,6]]
343	[[3,7,5,9,8,4,1,6,2],[1,8,4,3,6,2,9,5,7],[2,6,9,7,1,5,8,4,3],[5,1,6,4,2,7,3,9,8],[9,4,8,5,3,1,2,7,6],[7,3,2,6,9,8,4,1,5],[6,5,1,2,4,3,7,8,9],[8,2,7,1,5,9,6,3,4],[4,9,3,8,7,6,5,2,1]]
344	[[5,8,6,4,9,1,7,2,3],[9,1,3,2,5,7,8,6,4],[7,4,2,3,6,8,1,9,5],[1,2,9,5,8,3,4,7,6],[6,7,5,1,4,2,3,8,9],[8,3,4,9,7,6,5,1,2],[3,9,7,6,1,4,2,5,8],[4,5,1,8,2,9,6,3,7],[2,6,8,7,3,5,9,4,1]]
345	[[9,3,5,2,6,4,1,7,8],[7,8,4,9,1,5,6,3,2],[6,2,1,8,3,7,9,5,4],[2,4,3,5,7,6,8,9,1],[5,9,6,3,8,1,4,2,7],[1,7,8,4,2,9,5,6,3],[3,6,9,7,4,8,2,1,5],[8,1,2,6,5,3,7,4,9],[4,5,7,1,9,2,3,8,6]]
346	[[8,6,3,7,4,2,1,9,5],[5,7,9,1,3,6,2,8,4],[4,2,1,5,9,8,7,3,6],[7,4,5,9,6,3,8,2,1],[3,1,2,8,5,7,4,6,9],[9,8,6,4,2,1,5,7,3],[1,3,7,6,8,5,9,4,2],[2,5,4,3,7,9,6,1,8],[6,9,8,2,1,4,3,5,7]]
347	[[7,1,2,3,9,8,5,4,6],[3,4,6,5,2,7,1,8,9],[5,8,9,4,1,6,3,2,7],[6,2,7,9,8,3,4,5,1],[8,5,4,2,7,1,6,9,3],[1,9,3,6,5,4,8,7,2],[2,6,1,7,4,5,9,3,8],[9,3,5,8,6,2,7,1,4],[4,7,8,1,3,9,2,6,5]]
348	[[4,8,7,5,2,9,3,1,6],[5,9,3,1,7,6,2,8,4],[2,6,1,8,4,3,9,5,7],[1,7,6,9,3,5,8,4,2],[9,4,5,2,1,8,7,6,3],[8,3,2,4,6,7,5,9,1],[6,2,9,3,8,4,1,7,5],[7,1,8,6,5,2,4,3,9],[3,5,4,7,9,1,6,2,8]]
349	[[3,1,5,4,6,9,2,7,8],[6,8,7,3,2,5,4,9,1],[4,9,2,7,8,1,5,3,6],[2,4,3,1,7,8,9,6,5],[1,6,9,5,3,4,7,8,2],[5,7,8,2,9,6,3,1,4],[9,3,1,8,5,2,6,4,7],[7,2,4,6,1,3,8,5,9],[8,5,6,9,4,7,1,2,3]]
350	[[4,9,2,7,1,3,8,6,5],[6,7,3,8,4,5,1,2,9],[8,1,5,2,9,6,3,7,4],[1,5,6,4,3,2,7,9,8],[7,2,4,9,5,8,6,3,1],[9,3,8,6,7,1,4,5,2],[3,4,9,5,8,7,2,1,6],[2,8,7,1,6,9,5,4,3],[5,6,1,3,2,4,9,8,7]]
351	[[6,9,2,8,1,3,4,7,5],[3,7,5,9,4,6,8,1,2],[4,1,8,5,2,7,3,6,9],[8,3,4,1,6,2,9,5,7],[7,6,9,3,8,5,2,4,1],[2,5,1,4,7,9,6,8,3],[5,4,6,2,3,1,7,9,8],[1,8,3,7,9,4,5,2,6],[9,2,7,6,5,8,1,3,4]]
352	[[5,6,3,7,2,1,8,4,9],[8,9,1,6,4,3,5,7,2],[7,4,2,5,9,8,3,6,1],[1,8,7,9,6,2,4,5,3],[9,2,6,4,3,5,1,8,7],[4,3,5,8,1,7,9,2,6],[3,1,4,2,5,6,7,9,8],[6,5,8,1,7,9,2,3,4],[2,7,9,3,8,4,6,1,5]]
353	[[9,1,6,3,4,2,7,8,5],[5,3,8,1,6,7,4,2,9],[2,4,7,9,5,8,6,1,3],[1,9,2,6,8,4,5,3,7],[6,5,4,2,7,3,1,9,8],[8,7,3,5,9,1,2,4,6],[7,2,1,8,3,6,9,5,4],[3,6,5,4,1,9,8,7,2],[4,8,9,7,2,5,3,6,1]]
354	[[3,8,2,1,7,5,9,4,6],[1,9,7,6,8,4,3,5,2],[4,5,6,2,3,9,8,7,1],[6,3,8,5,9,7,1,2,4],[9,1,5,4,2,6,7,3,8],[2,7,4,3,1,8,5,6,9],[8,6,1,7,5,2,4,9,3],[5,2,9,8,4,3,6,1,7],[7,4,3,9,6,1,2,8,5]]
355	[[5,7,8,4,1,2,3,6,9],[1,9,6,5,3,7,2,8,4],[2,4,3,6,9,8,5,1,7],[8,5,7,9,6,4,1,3,2],[4,6,1,8,2,3,7,9,5],[3,2,9,1,7,5,6,4,8],[7,1,5,3,8,9,4,2,6],[6,8,2,7,4,1,9,5,3],[9,3,4,2,5,6,8,7,1]]
356	[[7,2,5,3,6,9,8,1,4],[8,4,6,7,1,5,3,2,9],[9,1,3,8,4,2,7,6,5],[5,9,1,2,3,8,4,7,6],[4,6,8,9,7,1,2,5,3],[3,7,2,6,5,4,9,8,1],[1,8,9,5,2,3,6,4,7],[2,5,7,4,9,6,1,3,8],[6,3,4,1,8,7,5,9,2]]
357	[[6,9,5,2,4,1,7,8,3],[1,7,4,3,8,5,2,9,6],[8,3,2,9,6,7,1,4,5],[2,4,6,5,9,8,3,1,7],[9,1,7,4,3,6,5,2,8],[3,5,8,7,1,2,4,6,9],[7,6,9,1,2,3,8,5,4],[4,2,3,8,5,9,6,7,1],[5,8,1,6,7,4,9,3,2]]
358	[[8,2,7,3,5,1,9,4,6],[1,4,3,9,6,2,5,8,7],[9,6,5,4,8,7,2,1,3],[6,1,9,5,4,8,3,7,2],[4,7,8,2,9,3,1,6,5],[5,3,2,7,1,6,8,9,4],[7,8,6,1,3,5,4,2,9],[2,5,4,8,7,9,6,3,1],[3,9,1,6,2,4,7,5,8]]
359	[[9,4,6,5,2,7,1,8,3],[2,1,7,4,8,3,9,5,6],[5,8,3,1,9,6,2,7,4],[1,6,9,8,5,4,7,3,2],[7,5,2,6,3,1,4,9,8],[8,3,4,9,7,2,5,6,1],[6,9,5,2,4,8,3,1,7],[3,2,8,7,1,9,6,4,5],[4,7,1,3,6,5,8,2,9]]
360	[[7,6,1,9,5,3,8,2,4],[2,5,9,4,6,8,3,7,1],[4,3,8,2,1,7,5,6,9],[6,7,3,5,9,1,2,4,8],[9,8,2,3,4,6,7,1,5],[5,1,4,8,7,2,9,3,6],[1,9,6,7,3,5,4,8,2],[3,2,5,6,8,4,1,9,7],[8,4,7,1,2,9,6,5,3]]
361	[[1,8,6,5,9,3,2,7,4],[5,3,9,4,2,7,6,8,1],[7,2,4,6,1,8,9,5,3],[6,7,3,8,5,9,1,4,2],[2,1,8,3,7,4,5,6,9],[4,9,5,1,6,2,7,3,8],[3,5,1,9,8,6,4,2,7],[8,6,7,2,4,1,3,9,5],[9,4,2,7,3,5,8,1,6]]
362	[[3,5,4,1,7,6,2,8,9],[6,2,7,9,8,3,5,1,4],[1,8,9,4,5,2,6,7,3],[9,1,2,5,3,7,4,6,8],[5,7,8,6,4,9,3,2,1],[4,3,6,8,2,1,9,5,7],[8,9,5,2,1,4,7,3,6],[2,4,3,7,6,8,1,9,5],[7,6,1,3,9,5,8,4,2]]
363	[[3,4,8,2,5,6,7,9,1],[5,2,9,4,1,7,8,3,6],[7,1,6,9,3,8,4,2,5],[8,6,1,5,9,3,2,7,4],[4,9,3,7,6,2,1,5,8],[2,5,7,8,4,1,3,6,9],[6,8,4,3,2,5,9,1,7],[1,7,2,6,8,9,5,4,3],[9,3,5,1,7,4,6,8,2]]
364	[[3,6,4,5,1,2,8,9,7],[8,2,1,4,7,9,6,3,5],[7,9,5,8,3,6,2,1,4],[1,3,6,2,5,7,4,8,9],[9,5,8,1,6,4,7,2,3],[4,7,2,3,9,8,5,6,1],[2,4,3,7,8,1,9,5,6],[5,8,9,6,4,3,1,7,2],[6,1,7,9,2,5,3,4,8]]
365	[[8,6,2,7,9,3,5,4,1],[4,3,9,5,6,1,2,7,8],[7,1,5,4,2,8,9,3,6],[6,9,4,1,3,2,8,5,7],[2,7,3,6,8,5,1,9,4],[5,8,1,9,4,7,3,6,2],[1,4,8,3,7,9,6,2,5],[3,2,6,8,5,4,7,1,9],[9,5,7,2,1,6,4,8,3]]
366	[[7,6,2,8,4,5,1,3,9],[9,5,1,6,7,3,4,2,8],[8,3,4,2,1,9,7,5,6],[2,1,9,3,8,4,6,7,5],[6,4,8,9,5,7,3,1,2],[3,7,5,1,6,2,9,8,4],[1,2,3,5,9,6,8,4,7],[5,9,7,4,3,8,2,6,1],[4,8,6,7,2,1,5,9,3]]
367	[[3,2,8,1,4,7,9,6,5],[4,5,9,3,6,2,7,1,8],[6,1,7,5,9,8,4,2,3],[5,3,6,9,8,1,2,4,7],[9,4,1,2,7,3,5,8,6],[7,8,2,4,5,6,1,3,9],[2,7,3,8,1,5,6,9,4],[8,6,4,7,2,9,3,5,1],[1,9,5,6,3,4,8,7,2]]
368	[[8,2,5,9,3,7,4,6,1],[1,7,6,2,4,5,9,8,3],[3,9,4,6,1,8,5,7,2],[5,1,9,8,7,3,6,2,4],[4,6,2,5,9,1,8,3,7],[7,8,3,4,6,2,1,9,5],[2,4,1,3,8,6,7,5,9],[6,3,7,1,5,9,2,4,8],[9,5,8,7,2,4,3,1,6]]
369	[[2,8,6,1,7,9,5,4,3],[5,3,4,8,2,6,7,9,1],[1,7,9,5,4,3,6,2,8],[6,4,7,2,5,1,8,3,9],[3,9,1,4,6,8,2,5,7],[8,2,5,9,3,7,4,1,6],[4,1,3,6,8,5,9,7,2],[7,6,2,3,9,4,1,8,5],[9,5,8,7,1,2,3,6,4]]
370	[[1,6,9,4,2,5,8,3,7],[3,8,4,7,1,6,5,2,9],[2,5,7,9,3,8,1,6,4],[5,2,1,3,4,7,6,9,8],[8,4,6,2,5,9,3,7,1],[9,7,3,6,8,1,4,5,2],[6,9,8,5,7,4,2,1,3],[4,3,5,1,9,2,7,8,6],[7,1,2,8,6,3,9,4,5]]
371	[[2,5,3,6,7,1,8,9,4],[7,1,8,4,2,9,6,5,3],[6,4,9,3,5,8,2,1,7],[8,3,6,7,9,5,4,2,1],[9,7,4,1,3,2,5,6,8],[1,2,5,8,6,4,3,7,9],[3,8,7,5,1,6,9,4,2],[5,9,1,2,4,3,7,8,6],[4,6,2,9,8,7,1,3,5]]
372	[[7,3,5,1,8,6,4,9,2],[8,2,9,4,7,5,3,6,1],[4,1,6,3,2,9,7,5,8],[9,4,8,7,5,1,6,2,3],[1,5,2,6,3,4,9,8,7],[3,6,7,2,9,8,1,4,5],[2,9,1,8,6,3,5,7,4],[5,7,3,9,4,2,8,1,6],[6,8,4,5,1,7,2,3,9]]
373	[[5,2,4,3,7,1,9,6,8],[1,6,8,2,4,9,7,5,3],[3,9,7,6,5,8,4,1,2],[7,8,9,4,2,6,1,3,5],[2,3,1,5,8,7,6,4,9],[6,4,5,1,9,3,2,8,7],[9,7,6,8,3,4,5,2,1],[8,1,2,9,6,5,3,7,4],[4,5,3,7,1,2,8,9,6]]
374	[[5,1,3,7,8,2,9,4,6],[7,2,8,9,6,4,5,3,1],[4,9,6,5,3,1,7,2,8],[9,3,5,6,7,8,2,1,4],[1,8,7,2,4,9,3,6,5],[6,4,2,3,1,5,8,7,9],[2,6,4,8,9,7,1,5,3],[3,5,9,1,2,6,4,8,7],[8,7,1,4,5,3,6,9,2]]
375	[[9,5,2,4,6,8,1,3,7],[1,3,7,5,2,9,6,4,8],[6,4,8,1,3,7,2,9,5],[5,8,1,6,7,3,9,2,4],[4,9,6,8,1,2,7,5,3],[2,7,3,9,5,4,8,1,6],[7,2,9,3,8,5,4,6,1],[8,6,5,2,4,1,3,7,9],[3,1,4,7,9,6,5,8,2]]
376	[[4,9,1,6,3,8,2,7,5],[2,8,6,5,9,7,3,1,4],[7,3,5,4,1,2,6,9,8],[8,1,7,9,5,6,4,3,2],[3,5,9,1,2,4,7,8,6],[6,4,2,7,8,3,1,5,9],[9,7,4,8,6,1,5,2,3],[1,2,8,3,4,5,9,6,7],[5,6,3,2,7,9,8,4,1]]
377	[[9,1,4,7,3,8,5,2,6],[6,3,7,2,1,5,4,9,8],[2,8,5,4,9,6,1,3,7],[4,2,6,1,8,3,9,7,5],[3,5,9,6,4,7,2,8,1],[1,7,8,5,2,9,3,6,4],[8,4,2,3,6,1,7,5,9],[5,6,1,9,7,2,8,4,3],[7,9,3,8,5,4,6,1,2]]
378	[[9,7,8,2,3,1,6,4,5],[3,2,6,7,5,4,1,8,9],[4,1,5,9,8,6,2,3,7],[7,4,1,3,6,2,5,9,8],[6,3,9,5,4,8,7,2,1],[8,5,2,1,7,9,3,6,4],[1,9,3,4,2,7,8,5,6],[5,6,7,8,9,3,4,1,2],[2,8,4,6,1,5,9,7,3]]
379	[[1,8,9,7,6,4,3,2,5],[7,3,5,9,2,8,4,1,6],[6,4,2,5,3,1,7,8,9],[9,1,3,8,7,2,5,6,4],[5,6,7,4,1,3,2,9,8],[4,2,8,6,9,5,1,3,7],[2,7,6,3,4,9,8,5,1],[3,5,4,1,8,6,9,7,2],[8,9,1,2,5,7,6,4,3]]
380	[[1,6,3,7,4,5,8,2,9],[9,7,5,8,2,3,1,6,4],[8,4,2,6,1,9,3,7,5],[5,1,7,3,8,6,9,4,2],[2,9,8,1,7,4,6,5,3],[4,3,6,5,9,2,7,8,1],[3,2,1,4,6,7,5,9,8],[6,5,4,9,3,8,2,1,7],[7,8,9,2,5,1,4,3,6]]
381	[[7,3,1,6,9,8,4,5,2],[4,5,6,7,2,3,9,8,1],[9,2,8,1,4,5,6,3,7],[8,6,4,2,5,7,3,1,9],[3,9,5,8,1,6,2,7,4],[2,1,7,9,3,4,5,6,8],[6,4,9,5,7,1,8,2,3],[1,8,2,3,6,9,7,4,5],[5,7,3,4,8,2,1,9,6]]
382	[[7,5,8,2,6,3,9,1,4],[3,9,2,8,4,1,6,7,5],[6,1,4,5,9,7,2,8,3],[2,6,7,3,8,4,5,9,1],[5,4,3,1,2,9,8,6,7],[1,8,9,7,5,6,4,3,2],[4,3,6,9,1,2,7,5,8],[9,7,5,4,3,8,1,2,6],[8,2,1,6,7,5,3,4,9]]
383	[[3,7,4,1,2,5,6,9,8],[5,2,6,7,8,9,1,3,4],[8,9,1,3,6,4,2,5,7],[1,3,7,5,4,8,9,6,2],[6,8,5,2,9,7,3,4,1],[9,4,2,6,3,1,8,7,5],[2,5,9,4,1,3,7,8,6],[4,6,8,9,7,2,5,1,3],[7,1,3,8,5,6,4,2,9]]
384	[[1,5,4,2,8,6,7,9,3],[6,7,8,9,1,3,5,4,2],[2,3,9,5,4,7,8,6,1],[9,2,7,1,6,4,3,5,8],[8,6,5,3,9,2,4,1,7],[4,1,3,8,7,5,9,2,6],[5,4,2,7,3,1,6,8,9],[3,8,1,6,5,9,2,7,4],[7,9,6,4,2,8,1,3,5]]
385	[[1,5,7,2,4,9,3,8,6],[3,9,8,5,7,6,1,2,4],[2,6,4,3,1,8,5,7,9],[9,3,2,1,8,7,4,6,5],[8,4,5,6,2,3,7,9,1],[6,7,1,9,5,4,8,3,2],[5,8,6,4,3,2,9,1,7],[4,2,3,7,9,1,6,5,8],[7,1,9,8,6,5,2,4,3]]
386	[[4,6,9,1,7,3,8,2,5],[7,5,1,2,8,6,3,4,9],[2,8,3,5,4,9,1,6,7],[6,3,2,9,5,4,7,1,8],[8,7,5,6,2,1,9,3,4],[1,9,4,7,3,8,2,5,6],[3,2,8,4,6,7,5,9,1],[9,4,7,3,1,5,6,8,2],[5,1,6,8,9,2,4,7,3]]
387	[[2,3,8,7,9,1,4,5,6],[5,4,9,3,8,6,2,1,7],[7,1,6,4,2,5,8,9,3],[9,7,2,6,4,3,1,8,5],[1,6,3,2,5,8,7,4,9],[8,5,4,1,7,9,6,3,2],[3,9,7,8,1,2,5,6,4],[4,8,5,9,6,7,3,2,1],[6,2,1,5,3,4,9,7,8]]
388	[[6,3,5,8,7,4,1,2,9],[9,1,8,2,3,6,7,4,5],[4,7,2,9,5,1,8,6,3],[5,9,6,1,8,2,4,3,7],[7,8,3,5,4,9,6,1,2],[2,4,1,3,6,7,9,5,8],[8,5,4,7,1,3,2,9,6],[3,6,9,4,2,8,5,7,1],[1,2,7,6,9,5,3,8,4]]
389	[[9,2,4,8,1,5,7,6,3],[8,3,6,9,2,7,4,1,5],[7,5,1,3,4,6,2,8,9],[1,4,7,6,5,8,3,9,2],[2,6,3,1,9,4,8,5,7],[5,9,8,7,3,2,6,4,1],[3,8,5,4,7,9,1,2,6],[4,1,9,2,6,3,5,7,8],[6,7,2,5,8,1,9,3,4]]
390	[[3,5,8,1,9,4,2,6,7],[7,6,2,3,8,5,4,1,9],[9,1,4,2,6,7,8,3,5],[1,8,7,6,4,9,5,2,3],[4,9,3,5,7,2,1,8,6],[5,2,6,8,3,1,9,7,4],[2,3,5,4,1,6,7,9,8],[6,4,9,7,2,8,3,5,1],[8,7,1,9,5,3,6,4,2]]
391	[[3,5,7,8,4,9,2,6,1],[2,6,4,3,1,5,8,9,7],[8,1,9,2,7,6,3,5,4],[9,3,2,6,8,4,7,1,5],[4,7,5,1,9,2,6,8,3],[6,8,1,7,5,3,4,2,9],[1,9,6,4,3,8,5,7,2],[7,2,3,5,6,1,9,4,8],[5,4,8,9,2,7,1,3,6]]
392	[[2,1,4,5,7,6,9,3,8],[7,6,9,3,2,8,1,5,4],[5,3,8,1,4,9,7,6,2],[6,8,5,2,1,4,3,7,9],[1,7,2,9,8,3,6,4,5],[4,9,3,6,5,7,8,2,1],[8,5,7,4,6,1,2,9,3],[3,4,1,7,9,2,5,8,6],[9,2,6,8,3,5,4,1,7]]
393	[[5,8,3,6,9,2,1,7,4],[9,6,4,1,7,5,3,8,2],[1,7,2,8,3,4,5,9,6],[7,2,8,5,4,6,9,3,1],[4,3,5,9,2,1,8,6,7],[6,9,1,7,8,3,4,2,5],[2,4,9,3,1,7,6,5,8],[8,5,7,4,6,9,2,1,3],[3,1,6,2,5,8,7,4,9]]
394	[[7,5,1,2,3,9,6,4,8],[3,9,4,8,6,5,1,2,7],[6,2,8,4,7,1,3,5,9],[8,7,3,6,4,2,5,9,1],[2,6,9,1,5,7,8,3,4],[4,1,5,3,9,8,7,6,2],[1,3,2,9,8,6,4,7,5],[9,4,7,5,1,3,2,8,6],[5,8,6,7,2,4,9,1,3]]
395	[[7,8,9,6,4,5,1,2,3],[3,5,6,8,1,2,4,7,9],[1,2,4,9,3,7,5,8,6],[4,3,8,5,2,1,6,9,7],[5,1,2,7,9,6,8,3,4],[6,9,7,4,8,3,2,1,5],[9,6,5,2,7,8,3,4,1],[2,4,1,3,6,9,7,5,8],[8,7,3,1,5,4,9,6,2]]
396	[[8,9,3,7,1,4,2,6,5],[4,5,1,6,3,2,9,7,8],[2,6,7,9,5,8,3,4,1],[7,8,9,2,4,3,5,1,6],[1,3,4,5,6,9,7,8,2],[6,2,5,8,7,1,4,9,3],[3,7,2,4,8,6,1,5,9],[9,4,8,1,2,5,6,3,7],[5,1,6,3,9,7,8,2,4]]
397	[[8,6,2,1,4,7,5,3,9],[5,7,4,9,3,2,1,6,8],[9,3,1,5,6,8,2,7,4],[6,9,8,7,5,1,3,4,2],[2,5,7,3,8,4,6,9,1],[4,1,3,6,2,9,8,5,7],[3,4,9,2,1,5,7,8,6],[1,8,6,4,7,3,9,2,5],[7,2,5,8,9,6,4,1,3]]
398	[[3,2,6,4,5,8,9,7,1],[5,7,8,1,9,6,3,2,4],[4,1,9,7,2,3,6,8,5],[8,9,5,3,4,2,7,1,6],[7,6,1,5,8,9,2,4,3],[2,4,3,6,7,1,8,5,9],[1,3,2,8,6,5,4,9,7],[6,8,7,9,1,4,5,3,2],[9,5,4,2,3,7,1,6,8]]
399	[[8,9,3,4,6,5,1,2,7],[7,5,4,2,8,1,3,6,9],[2,6,1,7,3,9,8,4,5],[4,1,7,8,9,6,5,3,2],[6,8,5,3,1,2,9,7,4],[9,3,2,5,4,7,6,1,8],[5,7,8,1,2,3,4,9,6],[1,2,6,9,5,4,7,8,3],[3,4,9,6,7,8,2,5,1]]
400	[[7,1,2,3,8,5,9,6,4],[8,4,3,6,1,9,5,2,7],[9,5,6,2,7,4,8,3,1],[3,7,8,4,6,1,2,9,5],[5,2,1,7,9,8,3,4,6],[4,6,9,5,3,2,7,1,8],[2,8,4,1,5,3,6,7,9],[6,3,5,9,4,7,1,8,2],[1,9,7,8,2,6,4,5,3]]
401	[[1,5,4,7,9,3,2,6,8],[6,8,7,2,1,4,9,5,3],[9,2,3,5,6,8,7,1,4],[7,4,5,6,3,2,8,9,1],[8,9,6,1,5,7,3,4,2],[2,3,1,4,8,9,5,7,6],[3,1,8,9,7,6,4,2,5],[5,7,2,3,4,1,6,8,9],[4,6,9,8,2,5,1,3,7]]
402	[[6,7,4,9,8,5,2,3,1],[2,8,3,4,7,1,5,6,9],[5,9,1,3,6,2,8,4,7],[8,2,9,6,1,3,4,7,5],[3,4,6,5,9,7,1,8,2],[7,1,5,2,4,8,6,9,3],[1,6,7,8,2,9,3,5,4],[4,3,2,7,5,6,9,1,8],[9,5,8,1,3,4,7,2,6]]
403	[[7,4,6,8,1,9,2,3,5],[8,3,2,4,5,7,6,1,9],[5,1,9,2,6,3,8,7,4],[4,9,5,7,3,8,1,6,2],[1,2,3,9,4,6,7,5,8],[6,7,8,1,2,5,9,4,3],[9,6,4,5,8,1,3,2,7],[2,8,1,3,7,4,5,9,6],[3,5,7,6,9,2,4,8,1]]
404	[[1,4,2,6,3,8,5,7,9],[6,8,7,2,5,9,1,3,4],[5,9,3,1,4,7,6,2,8],[8,2,1,7,9,3,4,5,6],[4,6,9,8,2,5,3,1,7],[3,7,5,4,6,1,9,8,2],[2,3,4,5,8,6,7,9,1],[9,1,6,3,7,2,8,4,5],[7,5,8,9,1,4,2,6,3]]
405	[[1,2,4,7,5,9,8,6,3],[5,9,6,3,8,1,2,7,4],[3,8,7,4,2,6,5,1,9],[7,5,9,1,4,8,3,2,6],[2,6,1,9,3,5,4,8,7],[4,3,8,6,7,2,9,5,1],[6,4,2,8,1,3,7,9,5],[9,7,5,2,6,4,1,3,8],[8,1,3,5,9,7,6,4,2]]
406	[[6,5,2,9,7,1,8,3,4],[8,4,9,5,3,2,6,7,1],[1,3,7,4,8,6,5,2,9],[2,1,3,8,6,4,9,5,7],[9,8,4,7,2,5,1,6,3],[5,7,6,1,9,3,2,4,8],[7,6,8,2,4,9,3,1,5],[3,9,5,6,1,7,4,8,2],[4,2,1,3,5,8,7,9,6]]
407	[[7,9,6,8,1,5,3,4,2],[5,8,2,3,4,7,9,6,1],[4,1,3,2,6,9,7,8,5],[1,3,4,5,9,8,6,2,7],[9,6,7,4,3,2,5,1,8],[8,2,5,1,7,6,4,3,9],[2,4,8,9,5,3,1,7,6],[6,5,1,7,2,4,8,9,3],[3,7,9,6,8,1,2,5,4]]
408	[[8,1,7,4,5,2,6,3,9],[6,4,9,8,3,7,2,1,5],[5,2,3,6,1,9,8,7,4],[1,8,2,5,7,6,9,4,3],[3,5,4,1,9,8,7,6,2],[7,9,6,3,2,4,5,8,1],[2,6,1,9,8,3,4,5,7],[9,3,8,7,4,5,1,2,6],[4,7,5,2,6,1,3,9,8]]
409	[[9,3,2,1,7,6,8,4,5],[4,7,1,8,3,5,6,9,2],[6,8,5,2,9,4,1,3,7],[3,9,7,5,4,1,2,8,6],[1,6,4,3,2,8,5,7,9],[5,2,8,9,6,7,3,1,4],[2,4,6,7,8,3,9,5,1],[7,1,3,6,5,9,4,2,8],[8,5,9,4,1,2,7,6,3]]
410	[[9,2,7,4,3,6,8,5,1],[8,3,1,5,2,7,6,9,4],[6,4,5,9,8,1,3,2,7],[4,8,3,6,5,2,1,7,9],[7,1,9,3,4,8,2,6,5],[2,5,6,7,1,9,4,3,8],[5,9,8,1,6,3,7,4,2],[1,6,4,2,7,5,9,8,3],[3,7,2,8,9,4,5,1,6]]
411	[[8,6,5,7,3,2,4,9,1],[3,2,4,9,1,8,7,6,5],[7,9,1,5,6,4,2,8,3],[1,8,9,3,5,7,6,4,2],[4,7,6,1,2,9,5,3,8],[2,5,3,4,8,6,9,1,7],[9,3,7,8,4,5,1,2,6],[6,4,8,2,7,1,3,5,9],[5,1,2,6,9,3,8,7,4]]
412	[[2,7,3,5,9,8,4,1,6],[4,9,5,6,1,7,2,3,8],[8,6,1,4,2,3,5,9,7],[1,2,6,7,8,9,3,5,4],[9,5,4,3,6,1,8,7,2],[3,8,7,2,4,5,9,6,1],[7,4,9,8,3,6,1,2,5],[6,1,8,9,5,2,7,4,3],[5,3,2,1,7,4,6,8,9]]
413	[[1,2,6,3,8,9,5,7,4],[3,7,9,4,5,2,6,8,1],[4,8,5,1,6,7,9,2,3],[7,6,2,8,1,3,4,5,9],[5,1,3,9,2,4,7,6,8],[9,4,8,5,7,6,1,3,2],[8,5,7,2,9,1,3,4,6],[2,3,1,6,4,5,8,9,7],[6,9,4,7,3,8,2,1,5]]
414	[[8,6,3,9,4,7,5,1,2],[2,5,4,8,6,1,7,3,9],[1,9,7,2,3,5,4,8,6],[7,4,1,6,8,2,3,9,5],[5,2,9,7,1,3,6,4,8],[3,8,6,5,9,4,1,2,7],[6,1,2,3,7,9,8,5,4],[4,7,5,1,2,8,9,6,3],[9,3,8,4,5,6,2,7,1]]
415	[[6,4,7,2,8,1,3,5,9],[9,1,5,4,3,6,2,7,8],[2,8,3,9,7,5,6,1,4],[7,5,1,8,6,9,4,2,3],[4,6,8,1,2,3,7,9,5],[3,2,9,5,4,7,8,6,1],[1,3,4,7,5,2,9,8,6],[5,7,6,3,9,8,1,4,2],[8,9,2,6,1,4,5,3,7]]
416	[[3,8,9,1,7,2,6,4,5],[7,5,1,4,6,8,3,9,2],[2,4,6,9,5,3,1,7,8],[6,3,5,8,2,9,4,1,7],[9,1,7,5,3,4,2,8,6],[4,2,8,6,1,7,9,5,3],[8,7,3,2,4,1,5,6,9],[5,9,4,3,8,6,7,2,1],[1,6,2,7,9,5,8,3,4]]
417	[[9,1,2,3,7,5,4,6,8],[6,7,4,1,8,2,3,5,9],[3,5,8,9,6,4,7,1,2],[4,3,7,8,2,1,6,9,5],[2,8,5,7,9,6,1,4,3],[1,9,6,4,5,3,8,2,7],[7,6,9,5,4,8,2,3,1],[8,4,1,2,3,9,5,7,6],[5,2,3,6,1,7,9,8,4]]
418	[[8,5,7,4,6,2,9,3,1],[6,3,9,8,5,1,7,2,4],[1,4,2,7,9,3,5,8,6],[5,9,6,2,4,7,3,1,8],[7,1,4,3,8,6,2,5,9],[2,8,3,5,1,9,6,4,7],[4,6,1,9,2,5,8,7,3],[9,7,5,1,3,8,4,6,2],[3,2,8,6,7,4,1,9,5]]
419	[[4,6,3,1,5,8,7,9,2],[7,8,5,9,2,3,1,4,6],[9,1,2,6,7,4,8,3,5],[5,4,6,7,1,2,3,8,9],[3,7,9,4,8,5,2,6,1],[1,2,8,3,6,9,4,5,7],[8,3,1,2,9,6,5,7,4],[2,9,4,5,3,7,6,1,8],[6,5,7,8,4,1,9,2,3]]
420	[[5,1,2,7,4,6,3,8,9],[7,3,4,9,8,5,2,1,6],[8,6,9,3,1,2,7,4,5],[2,9,6,1,5,3,4,7,8],[1,5,7,4,9,8,6,2,3],[3,4,8,6,2,7,5,9,1],[9,2,3,5,7,1,8,6,4],[4,8,5,2,6,9,1,3,7],[6,7,1,8,3,4,9,5,2]]
421	[[3,6,2,8,4,7,1,5,9],[9,7,4,1,2,5,3,6,8],[8,1,5,3,6,9,4,7,2],[1,4,9,5,8,6,7,2,3],[7,2,8,9,3,4,6,1,5],[6,5,3,7,1,2,9,8,4],[4,9,6,2,7,8,5,3,1],[5,8,1,6,9,3,2,4,7],[2,3,7,4,5,1,8,9,6]]
422	[[3,4,8,1,7,9,6,5,2],[6,7,1,8,2,5,3,4,9],[9,2,5,6,3,4,8,7,1],[7,3,9,4,1,8,2,6,5],[2,5,6,3,9,7,1,8,4],[1,8,4,5,6,2,9,3,7],[4,6,3,2,5,1,7,9,8],[8,9,2,7,4,3,5,1,6],[5,1,7,9,8,6,4,2,3]]
423	[[4,5,7,8,6,3,9,1,2],[2,6,3,5,9,1,8,7,4],[8,1,9,2,7,4,5,6,3],[3,7,5,4,2,6,1,8,9],[9,8,4,7,1,5,2,3,6],[1,2,6,3,8,9,7,4,5],[7,3,2,9,4,8,6,5,1],[5,9,1,6,3,7,4,2,8],[6,4,8,1,5,2,3,9,7]]
424	[[1,4,7,6,9,5,2,3,8],[9,8,2,1,3,7,5,4,6],[5,3,6,2,4,8,9,7,1],[2,5,8,3,1,9,7,6,4],[6,9,1,7,2,4,8,5,3],[3,7,4,8,5,6,1,2,9],[7,6,5,4,8,1,3,9,2],[8,2,9,5,6,3,4,1,7],[4,1,3,9,7,2,6,8,5]]
425	[[7,1,5,3,4,2,9,6,8],[3,6,4,5,8,9,7,1,2],[9,2,8,1,6,7,4,3,5],[4,5,1,6,7,3,2,8,9],[2,3,7,8,9,4,1,5,6],[6,8,9,2,5,1,3,4,7],[5,9,2,4,3,6,8,7,1],[8,7,3,9,1,5,6,2,4],[1,4,6,7,2,8,5,9,3]]
426	[[5,3,7,1,9,6,8,4,2],[2,6,4,8,7,3,9,1,5],[8,1,9,5,4,2,3,6,7],[1,9,5,7,8,4,2,3,6],[4,8,6,3,2,1,7,5,9],[3,7,2,6,5,9,1,8,4],[6,2,8,4,1,7,5,9,3],[7,4,1,9,3,5,6,2,8],[9,5,3,2,6,8,4,7,1]]
427	[[9,1,4,8,5,7,2,3,6],[7,3,5,2,1,6,8,9,4],[2,6,8,3,4,9,7,1,5],[8,4,6,7,3,1,9,5,2],[3,5,9,6,2,4,1,8,7],[1,2,7,9,8,5,6,4,3],[5,9,2,1,7,3,4,6,8],[6,8,3,4,9,2,5,7,1],[4,7,1,5,6,8,3,2,9]]
428	[[3,1,6,4,5,9,7,2,8],[7,2,8,3,6,1,4,5,9],[9,4,5,2,8,7,1,3,6],[6,8,3,1,2,5,9,7,4],[4,5,7,8,9,3,2,6,1],[2,9,1,6,7,4,5,8,3],[1,7,2,9,3,8,6,4,5],[5,3,4,7,1,6,8,9,2],[8,6,9,5,4,2,3,1,7]]
429	[[3,1,7,8,2,6,5,4,9],[5,2,9,3,4,7,1,6,8],[6,8,4,5,9,1,2,3,7],[1,4,8,6,3,9,7,5,2],[9,3,2,7,1,5,6,8,4],[7,6,5,2,8,4,3,9,1],[4,5,1,9,7,3,8,2,6],[2,9,6,1,5,8,4,7,3],[8,7,3,4,6,2,9,1,5]]
430	[[5,3,1,4,6,2,9,7,8],[8,6,7,9,1,3,4,5,2],[9,4,2,7,5,8,6,1,3],[3,7,6,5,8,4,1,2,9],[4,8,5,1,2,9,3,6,7],[2,1,9,3,7,6,5,8,4],[1,9,8,2,3,5,7,4,6],[7,2,4,6,9,1,8,3,5],[6,5,3,8,4,7,2,9,1]]
431	[[5,6,9,2,1,4,7,3,8],[7,3,4,5,8,6,1,2,9],[2,8,1,7,9,3,5,4,6],[1,2,7,9,4,8,6,5,3],[8,5,3,6,2,1,4,9,7],[4,9,6,3,5,7,8,1,2],[3,4,5,8,7,9,2,6,1],[9,7,2,1,6,5,3,8,4],[6,1,8,4,3,2,9,7,5]]
432	[[4,8,5,1,2,6,7,9,3],[9,7,2,8,3,4,6,1,5],[3,6,1,5,9,7,8,4,2],[7,4,9,3,8,5,2,6,1],[8,2,3,4,6,1,5,7,9],[1,5,6,9,7,2,4,3,8],[2,9,7,6,5,3,1,8,4],[6,3,4,2,1,8,9,5,7],[5,1,8,7,4,9,3,2,6]]
433	[[9,6,4,8,5,1,2,3,7],[2,5,8,7,6,3,1,9,4],[7,3,1,4,2,9,5,8,6],[8,9,2,6,4,5,3,7,1],[3,1,6,9,7,8,4,5,2],[4,7,5,1,3,2,9,6,8],[6,2,7,3,9,4,8,1,5],[5,8,9,2,1,7,6,4,3],[1,4,3,5,8,6,7,2,9]]
434	[[5,2,7,4,1,9,3,6,8],[6,4,1,8,5,3,9,2,7],[3,9,8,6,7,2,5,4,1],[9,8,3,1,6,4,2,7,5],[4,7,2,9,8,5,1,3,6],[1,6,5,3,2,7,4,8,9],[8,3,6,2,9,1,7,5,4],[7,1,4,5,3,6,8,9,2],[2,5,9,7,4,8,6,1,3]]
435	[[5,7,1,9,2,8,4,3,6],[8,9,6,5,4,3,2,7,1],[3,2,4,6,1,7,9,8,5],[1,5,7,3,6,4,8,2,9],[4,6,9,8,7,2,1,5,3],[2,3,8,1,5,9,6,4,7],[7,1,5,2,8,6,3,9,4],[9,4,2,7,3,1,5,6,8],[6,8,3,4,9,5,7,1,2]]
436	[[9,8,7,4,1,5,3,6,2],[4,1,2,7,6,3,8,9,5],[6,5,3,8,9,2,1,4,7],[5,7,6,9,3,4,2,8,1],[2,4,9,1,8,7,5,3,6],[8,3,1,2,5,6,4,7,9],[3,6,4,5,7,1,9,2,8],[7,9,5,3,2,8,6,1,4],[1,2,8,6,4,9,7,5,3]]
437	[[4,8,2,9,6,5,1,7,3],[9,1,6,3,8,7,2,4,5],[5,7,3,2,4,1,6,8,9],[6,9,4,1,3,2,7,5,8],[7,2,5,8,9,6,3,1,4],[8,3,1,5,7,4,9,6,2],[2,6,7,4,5,3,8,9,1],[1,5,8,7,2,9,4,3,6],[3,4,9,6,1,8,5,2,7]]
438	[[7,1,4,6,5,9,3,2,8],[3,6,2,8,4,7,9,5,1],[8,9,5,3,1,2,4,6,7],[4,5,6,9,8,3,1,7,2],[1,7,9,4,2,5,8,3,6],[2,3,8,1,7,6,5,9,4],[6,8,3,2,9,1,7,4,5],[5,2,1,7,3,4,6,8,9],[9,4,7,5,6,8,2,1,3]]
439	[[6,7,9,5,1,2,3,8,4],[4,2,3,7,9,8,6,5,1],[8,5,1,6,4,3,7,2,9],[9,3,5,2,8,7,4,1,6],[2,4,7,1,6,9,8,3,5],[1,8,6,3,5,4,2,9,7],[5,6,4,8,2,1,9,7,3],[3,1,2,9,7,6,5,4,8],[7,9,8,4,3,5,1,6,2]]
440	[[8,2,3,7,4,6,9,1,5],[9,1,5,2,8,3,7,6,4],[4,7,6,9,1,5,3,2,8],[6,8,1,4,5,9,2,7,3],[5,3,2,1,6,7,8,4,9],[7,4,9,8,3,2,1,5,6],[2,6,8,3,7,4,5,9,1],[1,9,4,5,2,8,6,3,7],[3,5,7,6,9,1,4,8,2]]
441	[[4,7,3,8,1,2,6,9,5],[1,2,9,5,4,6,8,3,7],[6,8,5,3,9,7,1,4,2],[3,5,4,7,8,1,9,2,6],[9,6,8,4,2,5,7,1,3],[2,1,7,9,6,3,5,8,4],[7,3,1,2,5,9,4,6,8],[5,4,6,1,3,8,2,7,9],[8,9,2,6,7,4,3,5,1]]
442	[[5,2,8,3,6,7,1,4,9],[9,7,4,1,8,2,6,5,3],[3,1,6,5,9,4,2,7,8],[8,5,2,4,1,6,9,3,7],[1,9,7,2,3,5,4,8,6],[6,4,3,9,7,8,5,1,2],[2,8,5,6,4,3,7,9,1],[4,3,9,7,2,1,8,6,5],[7,6,1,8,5,9,3,2,4]]
443	[[7,4,3,1,5,8,6,2,9],[6,9,8,7,4,2,3,5,1],[5,2,1,6,3,9,7,8,4],[4,7,6,8,9,5,1,3,2],[9,1,2,3,6,7,8,4,5],[8,3,5,4,2,1,9,6,7],[2,8,4,9,7,3,5,1,6],[3,6,7,5,1,4,2,9,8],[1,5,9,2,8,6,4,7,3]]
444	[[2,7,3,5,8,4,1,9,6],[1,9,5,3,7,6,8,4,2],[6,8,4,9,1,2,7,3,5],[4,2,6,7,3,9,5,1,8],[9,5,7,8,2,1,4,6,3],[8,3,1,6,4,5,2,7,9],[5,4,2,1,9,3,6,8,7],[7,1,9,2,6,8,3,5,4],[3,6,8,4,5,7,9,2,1]]
445	[[9,5,7,6,1,4,3,8,2],[8,2,6,5,3,9,7,1,4],[4,1,3,7,8,2,6,5,9],[6,3,9,1,4,5,2,7,8],[2,7,1,8,9,3,5,4,6],[5,4,8,2,7,6,9,3,1],[7,9,2,4,5,1,8,6,3],[1,6,5,3,2,8,4,9,7],[3,8,4,9,6,7,1,2,5]]
446	[[6,5,2,7,3,4,9,8,1],[7,9,1,2,5,8,4,6,3],[8,4,3,9,1,6,7,2,5],[1,8,6,3,4,5,2,7,9],[9,2,5,8,6,7,1,3,4],[3,7,4,1,2,9,6,5,8],[2,3,7,4,8,1,5,9,6],[5,1,9,6,7,3,8,4,2],[4,6,8,5,9,2,3,1,7]]
447	[[3,1,2,7,5,6,4,8,9],[4,5,6,9,8,2,7,1,3],[7,9,8,1,3,4,6,2,5],[2,6,9,8,1,3,5,4,7],[5,4,3,6,2,7,1,9,8],[8,7,1,4,9,5,3,6,2],[6,2,7,5,4,9,8,3,1],[9,8,4,3,7,1,2,5,6],[1,3,5,2,6,8,9,7,4]]
448	[[9,4,1,6,5,3,2,8,7],[6,2,3,9,8,7,5,1,4],[5,7,8,1,2,4,3,9,6],[2,5,7,8,9,1,4,6,3],[1,6,4,7,3,2,8,5,9],[8,3,9,5,4,6,7,2,1],[4,8,6,2,7,9,1,3,5],[7,9,2,3,1,5,6,4,8],[3,1,5,4,6,8,9,7,2]]
449	[[4,7,9,3,8,2,6,1,5],[8,3,2,6,5,1,9,4,7],[5,6,1,9,4,7,8,3,2],[3,2,4,7,9,6,1,5,8],[6,9,8,4,1,5,7,2,3],[7,1,5,2,3,8,4,9,6],[1,8,7,5,2,9,3,6,4],[9,5,3,8,6,4,2,7,1],[2,4,6,1,7,3,5,8,9]]
450	[[5,6,7,8,4,1,3,9,2],[9,1,8,5,2,3,4,7,6],[3,4,2,7,6,9,5,1,8],[7,3,6,2,8,4,1,5,9],[1,2,5,9,7,6,8,3,4],[8,9,4,3,1,5,6,2,7],[6,7,1,4,5,2,9,8,3],[2,5,3,6,9,8,7,4,1],[4,8,9,1,3,7,2,6,5]]
451	[[6,9,3,5,1,4,8,7,2],[1,2,7,8,9,3,6,4,5],[5,8,4,7,6,2,9,1,3],[7,3,6,4,2,8,1,5,9],[8,1,5,3,7,9,4,2,6],[9,4,2,1,5,6,7,3,8],[3,6,8,2,4,1,5,9,7],[4,5,9,6,3,7,2,8,1],[2,7,1,9,8,5,3,6,4]]
452	[[9,1,4,6,3,5,8,7,2],[6,2,3,1,7,8,4,5,9],[7,5,8,2,4,9,6,1,3],[8,4,6,3,5,7,9,2,1],[3,9,2,4,6,1,5,8,7],[1,7,5,8,9,2,3,4,6],[4,8,9,7,2,6,1,3,5],[5,3,7,9,1,4,2,6,8],[2,6,1,5,8,3,7,9,4]]
453	[[5,6,2,1,9,3,7,4,8],[1,9,4,2,7,8,3,6,5],[7,3,8,6,4,5,9,1,2],[4,2,7,9,6,1,5,8,3],[6,8,3,7,5,2,1,9,4],[9,1,5,8,3,4,6,2,7],[8,4,9,5,1,7,2,3,6],[3,5,1,4,2,6,8,7,9],[2,7,6,3,8,9,4,5,1]]
454	[[4,3,1,2,8,5,9,7,6],[6,8,2,3,7,9,4,1,5],[5,9,7,1,4,6,2,8,3],[1,7,5,9,3,4,6,2,8],[8,4,3,6,1,2,7,5,9],[9,2,6,8,5,7,1,3,4],[3,5,4,7,9,1,8,6,2],[7,6,9,5,2,8,3,4,1],[2,1,8,4,6,3,5,9,7]]
455	[[9,4,7,5,2,3,1,6,8],[1,5,8,6,7,9,4,2,3],[3,6,2,1,4,8,5,9,7],[5,2,6,9,3,7,8,4,1],[8,9,3,4,1,5,6,7,2],[7,1,4,2,8,6,9,3,5],[4,8,5,3,6,2,7,1,9],[6,3,9,7,5,1,2,8,4],[2,7,1,8,9,4,3,5,6]]
456	[[6,3,8,4,1,7,5,2,9],[2,4,5,9,3,6,1,8,7],[9,1,7,2,8,5,4,3,6],[3,2,6,5,4,1,7,9,8],[7,9,1,3,2,8,6,5,4],[5,8,4,6,7,9,3,1,2],[1,6,3,7,9,2,8,4,5],[8,7,9,1,5,4,2,6,3],[4,5,2,8,6,3,9,7,1]]
457	[[4,7,9,6,1,2,5,3,8],[6,3,5,8,7,4,2,1,9],[2,8,1,5,9,3,7,4,6],[3,1,6,9,5,8,4,7,2],[5,2,7,4,6,1,8,9,3],[9,4,8,3,2,7,6,5,1],[1,5,2,7,8,9,3,6,4],[8,6,3,1,4,5,9,2,7],[7,9,4,2,3,6,1,8,5]]
458	[[4,7,1,9,2,3,6,8,5],[6,3,8,4,5,7,2,1,9],[5,9,2,6,8,1,4,3,7],[8,2,7,3,1,4,9,5,6],[9,5,3,8,6,2,7,4,1],[1,4,6,7,9,5,3,2,8],[7,1,9,2,4,8,5,6,3],[2,6,5,1,3,9,8,7,4],[3,8,4,5,7,6,1,9,2]]
459	[[5,9,7,4,8,6,3,1,2],[6,3,1,9,2,7,8,4,5],[4,8,2,3,1,5,9,7,6],[2,4,9,5,6,8,7,3,1],[1,6,3,7,9,2,5,8,4],[8,7,5,1,4,3,2,6,9],[7,1,4,8,5,9,6,2,3],[3,5,6,2,7,1,4,9,8],[9,2,8,6,3,4,1,5,7]]
460	[[6,5,3,9,1,4,8,2,7],[7,1,4,2,6,8,3,5,9],[9,2,8,7,3,5,4,1,6],[5,3,9,6,8,2,1,7,4],[8,7,2,5,4,1,9,6,3],[4,6,1,3,7,9,5,8,2],[3,9,6,1,5,7,2,4,8],[2,4,5,8,9,6,7,3,1],[1,8,7,4,2,3,6,9,5]]
461	[[8,9,2,5,4,3,1,7,6],[7,4,3,1,8,6,9,2,5],[1,5,6,7,2,9,8,4,3],[9,6,8,2,7,1,3,5,4],[3,7,5,4,9,8,2,6,1],[4,2,1,3,6,5,7,8,9],[6,8,4,9,1,2,5,3,7],[5,1,7,8,3,4,6,9,2],[2,3,9,6,5,7,4,1,8]]
462	[[2,7,1,4,9,8,5,3,6],[3,5,8,6,2,1,4,7,9],[4,9,6,5,3,7,1,8,2],[5,6,4,9,8,3,7,2,1],[9,8,2,7,1,4,3,6,5],[1,3,7,2,5,6,9,4,8],[8,4,3,1,6,5,2,9,7],[6,1,9,3,7,2,8,5,4],[7,2,5,8,4,9,6,1,3]]
463	[[9,7,3,8,6,2,1,4,5],[5,8,1,9,7,4,3,6,2],[4,2,6,3,5,1,8,7,9],[8,5,2,1,4,7,6,9,3],[7,6,9,2,8,3,5,1,4],[3,1,4,5,9,6,2,8,7],[1,9,8,4,3,5,7,2,6],[6,4,5,7,2,8,9,3,1],[2,3,7,6,1,9,4,5,8]]
464	[[5,2,8,7,1,9,6,3,4],[4,3,7,6,8,2,1,5,9],[1,9,6,3,4,5,7,8,2],[7,5,3,1,9,6,4,2,8],[9,8,2,4,7,3,5,1,6],[6,1,4,5,2,8,9,7,3],[8,6,1,9,3,7,2,4,5],[2,4,5,8,6,1,3,9,7],[3,7,9,2,5,4,8,6,1]]
465	[[7,4,2,8,6,3,5,1,9],[9,3,5,4,7,1,2,6,8],[6,8,1,9,5,2,3,4,7],[3,6,8,5,1,9,4,7,2],[2,5,4,6,3,7,9,8,1],[1,9,7,2,4,8,6,5,3],[8,2,6,7,9,4,1,3,5],[5,7,3,1,2,6,8,9,4],[4,1,9,3,8,5,7,2,6]]
466	[[4,6,3,7,8,1,5,2,9],[7,5,2,6,9,4,8,3,1],[9,1,8,3,2,5,7,4,6],[6,3,1,2,5,9,4,7,8],[8,2,7,4,1,3,6,9,5],[5,4,9,8,7,6,3,1,2],[1,7,6,5,3,2,9,8,4],[2,8,4,9,6,7,1,5,3],[3,9,5,1,4,8,2,6,7]]
467	[[5,6,8,2,4,3,9,1,7],[9,7,4,6,8,1,2,3,5],[2,3,1,5,7,9,4,8,6],[3,1,2,9,5,8,7,6,4],[4,8,6,7,1,2,5,9,3],[7,5,9,3,6,4,8,2,1],[6,2,3,4,9,7,1,5,8],[1,4,5,8,2,6,3,7,9],[8,9,7,1,3,5,6,4,2]]
468	[[1,8,5,3,7,9,6,4,2],[9,4,7,2,5,6,8,3,1],[6,2,3,4,8,1,7,9,5],[2,3,9,1,4,8,5,7,6],[8,5,6,9,2,7,4,1,3],[4,7,1,6,3,5,2,8,9],[3,6,4,8,9,2,1,5,7],[5,9,2,7,1,4,3,6,8],[7,1,8,5,6,3,9,2,4]]
469	[[3,8,1,7,4,2,9,6,5],[9,2,5,3,8,6,4,7,1],[4,6,7,9,1,5,3,8,2],[8,5,4,6,2,9,1,3,7],[2,1,3,4,7,8,5,9,6],[7,9,6,5,3,1,8,2,4],[5,3,9,2,6,4,7,1,8],[6,7,8,1,5,3,2,4,9],[1,4,2,8,9,7,6,5,3]]
470	[[3,4,6,5,7,2,8,9,1],[5,2,8,9,1,6,7,3,4],[1,9,7,4,3,8,5,6,2],[9,6,1,8,4,7,3,2,5],[2,7,4,3,5,1,6,8,9],[8,3,5,2,6,9,4,1,7],[4,8,2,6,9,5,1,7,3],[6,1,3,7,2,4,9,5,8],[7,5,9,1,8,3,2,4,6]]
471	[[8,1,2,5,6,9,7,3,4],[4,6,5,7,3,2,8,9,1],[3,7,9,1,4,8,6,2,5],[7,5,8,3,2,1,9,4,6],[2,9,6,4,7,5,3,1,8],[1,3,4,8,9,6,2,5,7],[5,2,1,9,8,7,4,6,3],[6,8,3,2,5,4,1,7,9],[9,4,7,6,1,3,5,8,2]]
472	[[5,2,9,6,4,1,7,8,3],[8,3,1,7,5,2,9,4,6],[6,4,7,9,3,8,1,2,5],[7,8,2,1,9,5,3,6,4],[3,9,5,4,7,6,2,1,8],[4,1,6,8,2,3,5,7,9],[1,7,3,5,6,4,8,9,2],[2,6,8,3,1,9,4,5,7],[9,5,4,2,8,7,6,3,1]]
473	[[6,3,1,2,5,9,7,8,4],[5,4,2,1,7,8,9,6,3],[7,8,9,4,3,6,5,1,2],[4,1,5,3,8,2,6,7,9],[3,9,6,7,1,5,2,4,8],[2,7,8,6,9,4,1,3,5],[1,5,3,8,2,7,4,9,6],[8,2,4,9,6,1,3,5,7],[9,6,7,5,4,3,8,2,1]]
474	[[4,7,6,9,2,1,3,5,8],[5,9,2,8,3,4,7,6,1],[8,1,3,6,5,7,4,2,9],[1,2,5,7,4,9,8,3,6],[6,8,4,3,1,2,5,9,7],[9,3,7,5,8,6,1,4,2],[7,4,9,1,6,3,2,8,5],[2,5,1,4,9,8,6,7,3],[3,6,8,2,7,5,9,1,4]]
475	[[4,2,3,6,7,9,8,1,5],[5,8,6,1,3,2,7,4,9],[1,7,9,4,8,5,3,2,6],[3,9,1,7,2,4,6,5,8],[7,4,8,9,5,6,1,3,2],[6,5,2,3,1,8,4,9,7],[9,1,4,5,6,7,2,8,3],[8,3,7,2,9,1,5,6,4],[2,6,5,8,4,3,9,7,1]]
476	[[4,8,2,1,3,6,9,7,5],[6,7,5,2,9,8,1,3,4],[3,9,1,5,7,4,6,2,8],[5,3,8,4,1,9,7,6,2],[2,1,7,6,8,3,5,4,9],[9,6,4,7,2,5,3,8,1],[7,5,6,9,4,2,8,1,3],[1,4,3,8,5,7,2,9,6],[8,2,9,3,6,1,4,5,7]]
477	[[5,1,2,4,3,8,7,6,9],[9,7,8,1,6,2,3,4,5],[6,4,3,5,7,9,8,1,2],[3,5,6,2,4,7,1,9,8],[1,8,4,6,9,5,2,7,3],[2,9,7,8,1,3,6,5,4],[4,2,5,7,8,1,9,3,6],[8,3,1,9,5,6,4,2,7],[7,6,9,3,2,4,5,8,1]]
478	[[4,3,1,6,8,9,7,5,2],[2,9,6,4,7,5,8,3,1],[7,5,8,3,1,2,9,4,6],[1,7,2,9,3,8,5,6,4],[5,6,9,7,2,4,3,1,8],[3,8,4,5,6,1,2,7,9],[8,1,3,2,4,7,6,9,5],[6,2,5,1,9,3,4,8,7],[9,4,7,8,5,6,1,2,3]]
479	[[7,6,5,8,4,1,3,9,2],[3,4,2,9,5,7,8,6,1],[1,8,9,2,3,6,7,4,5],[2,5,8,3,7,9,6,1,4],[9,1,7,4,6,5,2,8,3],[4,3,6,1,2,8,9,5,7],[6,7,1,5,9,3,4,2,8],[8,2,3,6,1,4,5,7,9],[5,9,4,7,8,2,1,3,6]]
480	[[9,1,5,6,3,4,2,7,8],[8,7,3,1,2,5,6,4,9],[6,2,4,8,9,7,3,1,5],[4,3,9,7,5,6,1,8,2],[2,5,8,3,1,9,7,6,4],[1,6,7,2,4,8,5,9,3],[3,8,1,9,6,2,4,5,7],[5,9,6,4,7,3,8,2,1],[7,4,2,5,8,1,9,3,6]]
481	[[5,2,7,8,3,9,6,1,4],[6,1,9,5,2,4,7,8,3],[4,3,8,6,7,1,5,9,2],[3,7,2,9,6,5,1,4,8],[9,4,6,3,1,8,2,5,7],[1,8,5,7,4,2,3,6,9],[2,6,4,1,8,3,9,7,5],[7,9,3,4,5,6,8,2,1],[8,5,1,2,9,7,4,3,6]]
482	[[1,9,8,3,5,4,7,6,2],[3,7,4,6,2,9,8,5,1],[6,5,2,8,1,7,4,9,3],[8,1,9,7,4,6,2,3,5],[5,4,6,9,3,2,1,7,8],[2,3,7,1,8,5,6,4,9],[4,2,1,5,6,3,9,8,7],[9,8,3,4,7,1,5,2,6],[7,6,5,2,9,8,3,1,4]]
483	[[4,7,3,6,8,9,1,2,5],[1,2,6,5,7,4,3,8,9],[9,8,5,1,2,3,6,4,7],[7,1,8,4,6,5,2,9,3],[3,4,2,8,9,7,5,6,1],[6,5,9,3,1,2,4,7,8],[5,9,7,2,3,6,8,1,4],[8,6,4,7,5,1,9,3,2],[2,3,1,9,4,8,7,5,6]]
484	[[5,9,6,8,4,2,3,7,1],[1,3,8,7,9,5,2,6,4],[4,2,7,3,1,6,5,8,9],[8,4,3,9,7,1,6,5,2],[6,5,9,2,3,4,7,1,8],[2,7,1,5,6,8,4,9,3],[9,1,5,6,2,3,8,4,7],[7,6,2,4,8,9,1,3,5],[3,8,4,1,5,7,9,2,6]]
485	[[4,6,7,8,2,3,1,5,9],[1,8,5,9,6,7,3,2,4],[3,9,2,5,1,4,8,7,6],[2,3,8,1,4,9,5,6,7],[6,7,1,2,3,5,9,4,8],[9,5,4,7,8,6,2,3,1],[7,2,6,3,9,1,4,8,5],[8,4,9,6,5,2,7,1,3],[5,1,3,4,7,8,6,9,2]]
486	[[6,2,9,4,8,3,1,5,7],[5,4,8,6,1,7,2,3,9],[3,1,7,9,2,5,8,4,6],[8,9,2,3,6,4,5,7,1],[7,3,4,1,5,9,6,2,8],[1,5,6,8,7,2,4,9,3],[9,6,3,2,4,1,7,8,5],[4,7,1,5,3,8,9,6,2],[2,8,5,7,9,6,3,1,4]]
487	[[3,4,7,8,1,5,9,2,6],[8,2,6,7,9,4,3,1,5],[9,5,1,6,2,3,8,4,7],[6,1,8,3,7,9,2,5,4],[2,7,3,5,4,8,1,6,9],[5,9,4,2,6,1,7,3,8],[4,3,9,1,5,7,6,8,2],[1,6,5,9,8,2,4,7,3],[7,8,2,4,3,6,5,9,1]]
488	[[8,4,2,5,9,1,3,6,7],[1,6,3,4,2,7,9,5,8],[5,7,9,6,8,3,2,4,1],[7,3,1,9,5,2,6,8,4],[6,9,8,3,7,4,5,1,2],[2,5,4,1,6,8,7,9,3],[3,2,6,8,1,5,4,7,9],[4,1,5,7,3,9,8,2,6],[9,8,7,2,4,6,1,3,5]]
489	[[1,4,3,2,5,9,8,7,6],[8,2,9,6,3,7,1,5,4],[5,7,6,1,8,4,9,3,2],[9,8,5,7,2,1,6,4,3],[4,6,7,3,9,8,5,2,1],[2,3,1,5,4,6,7,8,9],[7,9,8,4,6,2,3,1,5],[6,5,2,8,1,3,4,9,7],[3,1,4,9,7,5,2,6,8]]
490	[[6,3,9,8,2,7,4,1,5],[2,8,1,5,4,3,7,9,6],[4,7,5,1,6,9,3,8,2],[1,4,2,9,3,5,8,6,7],[9,6,8,2,7,1,5,4,3],[3,5,7,6,8,4,9,2,1],[7,1,3,4,9,2,6,5,8],[8,2,4,3,5,6,1,7,9],[5,9,6,7,1,8,2,3,4]]
491	[[9,3,6,1,5,7,4,2,8],[8,4,2,6,9,3,5,1,7],[7,1,5,2,4,8,6,9,3],[4,6,1,5,8,2,3,7,9],[5,8,3,7,6,9,2,4,1],[2,9,7,3,1,4,8,5,6],[1,5,8,9,2,6,7,3,4],[6,7,9,4,3,5,1,8,2],[3,2,4,8,7,1,9,6,5]]
492	[[4,1,8,3,6,2,9,7,5],[3,2,9,7,5,1,4,6,8],[7,5,6,9,8,4,2,1,3],[9,3,1,5,2,7,8,4,6],[5,6,7,8,4,3,1,2,9],[8,4,2,6,1,9,3,5,7],[1,9,3,2,7,6,5,8,4],[6,8,4,1,3,5,7,9,2],[2,7,5,4,9,8,6,3,1]]
493	[[9,8,7,1,4,6,3,2,5],[5,4,3,9,2,8,6,7,1],[2,1,6,5,3,7,9,4,8],[8,9,1,3,5,2,4,6,7],[3,6,5,7,9,4,8,1,2],[4,7,2,8,6,1,5,3,9],[7,5,4,2,8,3,1,9,6],[6,2,9,4,1,5,7,8,3],[1,3,8,6,7,9,2,5,4]]
494	[[7,1,6,3,4,8,2,5,9],[3,5,4,1,9,2,6,7,8],[9,2,8,6,7,5,3,1,4],[6,3,9,8,1,7,4,2,5],[1,4,2,9,5,3,8,6,7],[5,8,7,4,2,6,1,9,3],[4,6,1,7,8,9,5,3,2],[2,7,3,5,6,4,9,8,1],[8,9,5,2,3,1,7,4,6]]
495	[[1,2,9,5,6,7,8,4,3],[4,3,8,9,1,2,5,6,7],[6,5,7,8,4,3,1,9,2],[9,1,3,6,7,4,2,8,5],[7,4,2,3,8,5,6,1,9],[8,6,5,2,9,1,3,7,4],[3,8,4,1,2,9,7,5,6],[2,7,1,4,5,6,9,3,8],[5,9,6,7,3,8,4,2,1]]
496	[[5,9,8,3,7,4,6,2,1],[1,7,2,6,8,5,9,4,3],[3,4,6,1,2,9,8,5,7],[2,8,3,5,6,1,4,7,9],[4,1,9,8,3,7,2,6,5],[6,5,7,9,4,2,3,1,8],[9,6,1,4,5,8,7,3,2],[8,2,4,7,1,3,5,9,6],[7,3,5,2,9,6,1,8,4]]
497	[[4,1,2,7,6,3,8,9,5],[5,6,9,1,4,8,2,3,7],[8,3,7,9,5,2,4,6,1],[6,5,8,4,9,7,1,2,3],[9,2,3,8,1,6,5,7,4],[1,7,4,2,3,5,9,8,6],[3,4,1,6,2,9,7,5,8],[2,8,5,3,7,4,6,1,9],[7,9,6,5,8,1,3,4,2]]
498	[[8,4,3,5,9,1,7,2,6],[9,1,7,2,6,8,5,4,3],[2,5,6,4,7,3,8,1,9],[3,9,5,1,8,7,2,6,4],[7,6,8,9,4,2,3,5,1],[4,2,1,6,3,5,9,7,8],[1,8,2,3,5,6,4,9,7],[5,3,9,7,1,4,6,8,2],[6,7,4,8,2,9,1,3,5]]
499	[[7,4,2,3,1,6,9,5,8],[9,6,5,7,8,4,3,1,2],[1,8,3,2,5,9,4,7,6],[6,7,8,5,9,3,2,4,1],[3,2,9,8,4,1,7,6,5],[5,1,4,6,7,2,8,3,9],[2,9,1,4,3,5,6,8,7],[8,3,6,1,2,7,5,9,4],[4,5,7,9,6,8,1,2,3]]
500	[[4,2,5,7,8,6,3,9,1],[9,7,6,4,3,1,2,8,5],[1,8,3,5,2,9,6,4,7],[3,6,4,1,9,2,5,7,8],[8,5,9,3,6,7,4,1,2],[7,1,2,8,4,5,9,6,3],[2,9,8,6,7,3,1,5,4],[6,4,1,2,5,8,7,3,9],[5,3,7,9,1,4,8,2,6]]
501	[[1,7,3,6,5,2,9,4,8],[8,2,6,9,7,4,1,5,3],[5,9,4,8,3,1,7,6,2],[6,5,9,4,1,3,8,2,7],[7,8,2,5,6,9,4,3,1],[4,3,1,2,8,7,6,9,5],[2,1,8,3,4,6,5,7,9],[3,4,5,7,9,8,2,1,6],[9,6,7,1,2,5,3,8,4]]
502	[[6,2,1,5,4,8,3,9,7],[5,7,4,3,9,2,1,8,6],[9,8,3,6,7,1,2,5,4],[8,5,7,1,2,3,4,6,9],[1,9,2,4,8,6,7,3,5],[3,4,6,9,5,7,8,1,2],[4,6,8,7,3,9,5,2,1],[2,1,5,8,6,4,9,7,3],[7,3,9,2,1,5,6,4,8]]
503	[[6,8,7,5,3,1,2,4,9],[9,4,5,6,2,7,3,1,8],[1,2,3,8,4,9,6,5,7],[8,1,9,3,5,4,7,2,6],[2,3,6,7,1,8,5,9,4],[5,7,4,9,6,2,8,3,1],[7,5,2,1,9,6,4,8,3],[4,9,8,2,7,3,1,6,5],[3,6,1,4,8,5,9,7,2]]
504	[[4,7,5,2,3,6,8,1,9],[8,6,1,4,5,9,7,2,3],[9,2,3,8,7,1,6,4,5],[3,8,4,6,2,5,1,9,7],[2,5,7,1,9,4,3,6,8],[6,1,9,7,8,3,4,5,2],[1,3,2,5,6,8,9,7,4],[5,4,8,9,1,7,2,3,6],[7,9,6,3,4,2,5,8,1]]
505	[[3,4,9,8,7,6,2,5,1],[2,8,1,3,5,9,6,4,7],[5,6,7,1,2,4,3,9,8],[4,1,3,2,9,8,7,6,5],[6,9,2,7,3,5,1,8,4],[7,5,8,4,6,1,9,2,3],[1,2,6,5,4,3,8,7,9],[9,3,5,6,8,7,4,1,2],[8,7,4,9,1,2,5,3,6]]
506	[[3,6,9,4,2,5,1,8,7],[5,4,8,1,9,7,3,6,2],[2,1,7,3,8,6,5,9,4],[6,3,1,9,7,8,4,2,5],[4,9,2,6,5,3,7,1,8],[7,8,5,2,4,1,6,3,9],[8,2,3,5,6,4,9,7,1],[1,7,4,8,3,9,2,5,6],[9,5,6,7,1,2,8,4,3]]
507	[[5,3,7,8,1,2,6,4,9],[4,1,2,9,5,6,7,8,3],[8,6,9,7,4,3,1,2,5],[2,4,8,6,7,9,3,5,1],[6,5,3,1,8,4,9,7,2],[7,9,1,3,2,5,4,6,8],[1,8,5,4,9,7,2,3,6],[3,2,4,5,6,1,8,9,7],[9,7,6,2,3,8,5,1,4]]
508	[[9,7,3,5,2,4,1,8,6],[4,6,1,8,3,9,2,5,7],[8,2,5,1,6,7,3,4,9],[2,3,6,4,7,5,8,9,1],[7,8,9,6,1,2,4,3,5],[5,1,4,3,9,8,6,7,2],[6,5,7,2,8,3,9,1,4],[1,9,8,7,4,6,5,2,3],[3,4,2,9,5,1,7,6,8]]
509	[[6,5,3,1,4,7,2,8,9],[4,9,7,3,2,8,5,6,1],[2,8,1,9,6,5,3,4,7],[5,3,4,2,8,1,7,9,6],[8,2,9,7,3,6,4,1,5],[7,1,6,5,9,4,8,3,2],[9,7,8,6,5,3,1,2,4],[1,4,2,8,7,9,6,5,3],[3,6,5,4,1,2,9,7,8]]
510	[[7,3,2,9,5,4,1,8,6],[9,1,8,6,2,3,5,7,4],[5,6,4,1,8,7,9,2,3],[8,4,1,3,9,6,2,5,7],[3,7,9,2,4,5,8,6,1],[2,5,6,8,7,1,3,4,9],[4,2,3,5,6,9,7,1,8],[6,9,5,7,1,8,4,3,2],[1,8,7,4,3,2,6,9,5]]
511	[[6,7,1,8,3,4,9,5,2],[2,9,4,1,6,5,3,8,7],[3,8,5,2,7,9,4,6,1],[4,5,6,9,1,7,2,3,8],[8,1,7,4,2,3,6,9,5],[9,2,3,5,8,6,1,7,4],[1,3,9,7,5,2,8,4,6],[5,6,8,3,4,1,7,2,9],[7,4,2,6,9,8,5,1,3]]
512	[[6,5,8,3,4,7,1,9,2],[1,4,2,6,5,9,8,7,3],[7,3,9,1,8,2,4,5,6],[8,9,7,2,6,4,5,3,1],[5,1,4,9,7,3,2,6,8],[3,2,6,8,1,5,9,4,7],[4,8,1,7,9,6,3,2,5],[2,6,5,4,3,1,7,8,9],[9,7,3,5,2,8,6,1,4]]
513	[[3,4,2,5,8,6,9,7,1],[1,6,8,7,3,9,4,2,5],[5,9,7,4,1,2,8,6,3],[4,1,3,2,5,8,6,9,7],[7,2,6,3,9,4,1,5,8],[9,8,5,6,7,1,3,4,2],[8,5,1,9,4,7,2,3,6],[2,3,4,1,6,5,7,8,9],[6,7,9,8,2,3,5,1,4]]
514	[[3,7,2,8,6,5,4,9,1],[5,9,4,2,3,1,7,6,8],[8,6,1,4,9,7,3,5,2],[1,2,6,9,4,8,5,7,3],[7,3,9,5,2,6,8,1,4],[4,8,5,7,1,3,9,2,6],[6,1,7,3,8,9,2,4,5],[2,5,3,6,7,4,1,8,9],[9,4,8,1,5,2,6,3,7]]
515	[[1,5,3,8,9,6,2,7,4],[7,8,4,2,3,5,6,9,1],[9,2,6,7,1,4,5,8,3],[8,3,5,6,4,9,1,2,7],[6,9,7,1,2,8,4,3,5],[2,4,1,3,5,7,9,6,8],[3,6,2,5,8,1,7,4,9],[4,1,8,9,7,2,3,5,6],[5,7,9,4,6,3,8,1,2]]
516	[[4,9,6,3,7,8,2,5,1],[2,3,8,4,1,5,9,6,7],[7,5,1,2,9,6,3,4,8],[9,8,4,1,3,7,6,2,5],[6,1,3,8,5,2,4,7,9],[5,2,7,9,6,4,1,8,3],[1,4,5,7,2,9,8,3,6],[8,7,9,6,4,3,5,1,2],[3,6,2,5,8,1,7,9,4]]
517	[[3,1,6,2,8,4,9,7,5],[8,2,4,9,5,7,6,1,3],[5,7,9,3,6,1,2,4,8],[2,5,1,4,7,3,8,6,9],[6,8,7,5,2,9,1,3,4],[4,9,3,6,1,8,5,2,7],[1,3,8,7,9,6,4,5,2],[9,4,2,1,3,5,7,8,6],[7,6,5,8,4,2,3,9,1]]
518	[[6,8,3,5,9,2,1,7,4],[4,7,5,6,1,3,2,9,8],[9,1,2,8,4,7,5,3,6],[8,2,9,7,6,1,3,4,5],[7,4,6,3,2,5,8,1,9],[3,5,1,4,8,9,7,6,2],[2,9,7,1,5,6,4,8,3],[5,3,4,9,7,8,6,2,1],[1,6,8,2,3,4,9,5,7]]
519	[[6,7,9,1,8,3,5,2,4],[3,2,8,7,4,5,1,9,6],[1,4,5,9,6,2,3,7,8],[9,6,3,8,1,4,2,5,7],[5,1,2,6,3,7,8,4,9],[7,8,4,2,5,9,6,1,3],[4,5,6,3,7,1,9,8,2],[8,9,1,4,2,6,7,3,5],[2,3,7,5,9,8,4,6,1]]
520	[[5,9,7,8,6,1,3,4,2],[4,6,3,2,9,7,8,1,5],[8,2,1,3,5,4,9,7,6],[6,7,2,5,8,3,1,9,4],[9,1,5,7,4,6,2,8,3],[3,4,8,9,1,2,5,6,7],[7,8,9,6,3,5,4,2,1],[2,3,4,1,7,8,6,5,9],[1,5,6,4,2,9,7,3,8]]
521	[[2,3,4,1,5,9,7,8,6],[7,1,8,4,3,6,5,9,2],[6,9,5,2,7,8,1,4,3],[1,2,9,7,6,4,3,5,8],[3,5,6,8,1,2,9,7,4],[8,4,7,5,9,3,2,6,1],[4,7,2,9,8,1,6,3,5],[5,8,3,6,2,7,4,1,9],[9,6,1,3,4,5,8,2,7]]
522	[[4,8,1,5,2,3,7,6,9],[5,9,2,8,6,7,1,3,4],[6,3,7,9,1,4,2,5,8],[1,7,9,4,8,5,3,2,6],[3,6,4,7,9,2,8,1,5],[2,5,8,6,3,1,4,9,7],[7,1,6,3,5,8,9,4,2],[9,4,3,2,7,6,5,8,1],[8,2,5,1,4,9,6,7,3]]
523	[[3,4,2,6,9,8,1,5,7],[8,9,1,5,7,2,3,6,4],[7,5,6,4,1,3,9,8,2],[6,7,5,1,8,4,2,3,9],[4,3,8,9,2,5,6,7,1],[2,1,9,7,3,6,8,4,5],[9,2,3,8,4,7,5,1,6],[1,6,4,3,5,9,7,2,8],[5,8,7,2,6,1,4,9,3]]
524	[[5,6,2,3,8,9,1,4,7],[8,7,9,4,1,6,5,2,3],[3,4,1,2,5,7,8,6,9],[6,2,5,9,7,4,3,1,8],[7,8,4,5,3,1,2,9,6],[1,9,3,6,2,8,4,7,5],[9,1,6,8,4,5,7,3,2],[4,3,8,7,6,2,9,5,1],[2,5,7,1,9,3,6,8,4]]
525	[[8,2,1,3,4,7,9,6,5],[3,6,4,5,9,1,2,7,8],[7,9,5,8,6,2,4,3,1],[2,1,3,9,5,8,7,4,6],[5,4,9,2,7,6,1,8,3],[6,7,8,1,3,4,5,2,9],[9,5,2,7,8,3,6,1,4],[1,3,6,4,2,5,8,9,7],[4,8,7,6,1,9,3,5,2]]
526	[[4,3,1,7,9,8,6,2,5],[5,7,9,3,2,6,4,1,8],[2,6,8,1,4,5,9,7,3],[7,1,3,6,5,9,2,8,4],[8,4,6,2,7,1,3,5,9],[9,2,5,4,8,3,1,6,7],[1,5,4,8,3,2,7,9,6],[6,9,7,5,1,4,8,3,2],[3,8,2,9,6,7,5,4,1]]
527	[[5,7,4,6,9,3,1,8,2],[3,6,2,5,8,1,4,9,7],[9,8,1,2,4,7,3,6,5],[4,3,6,9,2,5,8,7,1],[1,9,8,3,7,6,2,5,4],[2,5,7,8,1,4,6,3,9],[8,4,5,7,3,2,9,1,6],[7,1,3,4,6,9,5,2,8],[6,2,9,1,5,8,7,4,3]]
528	[[7,6,3,2,8,5,9,1,4],[5,2,1,4,7,9,6,8,3],[8,9,4,3,1,6,7,2,5],[6,7,9,1,3,8,5,4,2],[4,1,5,6,2,7,8,3,9],[2,3,8,9,5,4,1,6,7],[3,5,2,8,9,1,4,7,6],[1,4,7,5,6,3,2,9,8],[9,8,6,7,4,2,3,5,1]]
529	[[9,2,8,6,7,1,5,4,3],[6,5,4,2,8,3,1,9,7],[3,7,1,9,5,4,8,6,2],[1,6,7,8,9,5,3,2,4],[4,8,5,3,2,7,6,1,9],[2,3,9,1,4,6,7,5,8],[7,1,3,4,6,9,2,8,5],[8,4,6,5,3,2,9,7,1],[5,9,2,7,1,8,4,3,6]]
530	[[9,2,1,4,8,6,3,7,5],[7,3,5,1,2,9,6,4,8],[8,6,4,3,5,7,2,1,9],[5,9,6,7,3,8,4,2,1],[2,4,3,6,1,5,9,8,7],[1,8,7,2,9,4,5,3,6],[3,5,2,9,7,1,8,6,4],[6,7,8,5,4,3,1,9,2],[4,1,9,8,6,2,7,5,3]]
531	[[6,3,8,7,2,5,1,4,9],[4,7,9,6,3,1,2,5,8],[1,5,2,9,8,4,6,3,7],[3,9,6,4,5,8,7,1,2],[7,8,5,1,9,2,4,6,3],[2,1,4,3,7,6,8,9,5],[5,2,1,8,6,9,3,7,4],[8,4,7,5,1,3,9,2,6],[9,6,3,2,4,7,5,8,1]]
532	[[9,8,5,4,2,7,3,1,6],[3,4,2,5,1,6,7,9,8],[6,1,7,9,8,3,5,4,2],[8,3,1,2,7,5,4,6,9],[4,2,6,8,3,9,1,7,5],[7,5,9,1,6,4,2,8,3],[1,9,4,3,5,8,6,2,7],[2,6,3,7,9,1,8,5,4],[5,7,8,6,4,2,9,3,1]]
533	[[5,8,6,2,3,9,1,4,7],[7,3,9,4,5,1,8,2,6],[2,1,4,8,7,6,3,5,9],[1,9,3,5,2,4,7,6,8],[8,6,2,7,9,3,4,1,5],[4,7,5,1,6,8,2,9,3],[3,2,8,9,4,5,6,7,1],[6,5,7,3,1,2,9,8,4],[9,4,1,6,8,7,5,3,2]]
534	[[1,4,5,6,7,3,9,8,2],[9,2,3,4,8,5,6,1,7],[8,6,7,9,1,2,3,5,4],[3,1,8,2,6,7,4,9,5],[6,7,4,8,5,9,2,3,1],[2,5,9,3,4,1,7,6,8],[5,8,6,7,3,4,1,2,9],[4,3,2,1,9,8,5,7,6],[7,9,1,5,2,6,8,4,3]]
535	[[3,1,2,7,4,5,9,6,8],[9,7,6,8,3,1,4,5,2],[5,4,8,2,9,6,1,3,7],[7,6,4,1,5,3,8,2,9],[8,9,3,6,7,2,5,4,1],[2,5,1,4,8,9,6,7,3],[4,2,9,5,1,7,3,8,6],[6,3,5,9,2,8,7,1,4],[1,8,7,3,6,4,2,9,5]]
536	[[9,7,4,5,8,6,1,2,3],[2,1,8,3,4,9,5,6,7],[5,6,3,1,2,7,4,8,9],[7,8,2,9,6,1,3,5,4],[3,5,9,8,7,4,6,1,2],[1,4,6,2,3,5,9,7,8],[6,2,7,4,1,3,8,9,5],[8,3,5,6,9,2,7,4,1],[4,9,1,7,5,8,2,3,6]]
537	[[7,1,6,4,8,9,5,3,2],[8,2,4,5,1,3,6,7,9],[3,9,5,6,2,7,8,1,4],[4,8,9,7,5,2,3,6,1],[2,6,3,1,4,8,9,5,7],[5,7,1,9,3,6,4,2,8],[9,4,2,3,7,5,1,8,6],[1,3,7,8,6,4,2,9,5],[6,5,8,2,9,1,7,4,3]]
538	[[2,5,6,8,3,9,7,1,4],[8,4,3,2,7,1,6,5,9],[7,1,9,5,4,6,8,2,3],[9,8,1,6,5,3,2,4,7],[4,6,2,9,8,7,1,3,5],[3,7,5,1,2,4,9,6,8],[5,3,8,7,6,2,4,9,1],[6,9,4,3,1,8,5,7,2],[1,2,7,4,9,5,3,8,6]]
539	[[3,6,5,7,8,9,1,4,2],[1,4,9,5,6,2,7,3,8],[2,8,7,3,1,4,6,5,9],[4,3,6,2,5,7,9,8,1],[7,9,2,8,4,1,3,6,5],[8,5,1,6,9,3,4,2,7],[9,2,4,1,3,8,5,7,6],[5,7,3,9,2,6,8,1,4],[6,1,8,4,7,5,2,9,3]]
540	[[3,5,4,1,2,8,7,6,9],[7,1,8,6,9,4,5,3,2],[6,2,9,5,3,7,8,4,1],[5,7,3,8,6,9,1,2,4],[4,9,2,7,1,3,6,5,8],[8,6,1,4,5,2,3,9,7],[1,3,7,2,4,5,9,8,6],[2,8,5,9,7,6,4,1,3],[9,4,6,3,8,1,2,7,5]]
541	[[4,5,3,9,8,1,2,6,7],[2,6,1,4,7,3,9,8,5],[8,7,9,2,6,5,1,4,3],[5,3,6,1,2,8,4,7,9],[9,8,2,5,4,7,6,3,1],[7,1,4,3,9,6,5,2,8],[6,2,8,7,5,9,3,1,4],[3,4,5,8,1,2,7,9,6],[1,9,7,6,3,4,8,5,2]]
542	[[9,1,5,7,6,4,3,2,8],[7,2,3,1,8,9,4,6,5],[4,6,8,3,5,2,9,1,7],[8,4,2,9,3,7,6,5,1],[3,7,6,5,1,8,2,4,9],[1,5,9,4,2,6,7,8,3],[5,3,4,2,7,1,8,9,6],[2,8,1,6,9,3,5,7,4],[6,9,7,8,4,5,1,3,2]]
543	[[3,9,8,5,4,6,1,7,2],[6,5,7,3,2,1,8,4,9],[4,1,2,8,9,7,3,6,5],[1,7,6,4,3,2,5,9,8],[5,2,4,9,1,8,7,3,6],[9,8,3,6,7,5,4,2,1],[8,4,1,2,6,3,9,5,7],[7,6,9,1,5,4,2,8,3],[2,3,5,7,8,9,6,1,4]]
544	[[1,7,3,5,6,2,4,8,9],[5,2,9,4,8,3,7,1,6],[6,8,4,1,7,9,2,5,3],[9,4,2,6,1,7,5,3,8],[3,6,8,2,4,5,1,9,7],[7,1,5,9,3,8,6,4,2],[4,3,6,8,2,1,9,7,5],[8,9,1,7,5,6,3,2,4],[2,5,7,3,9,4,8,6,1]]
545	[[3,9,2,4,7,6,8,5,1],[8,4,7,5,2,1,9,3,6],[1,5,6,9,3,8,2,4,7],[6,8,9,7,1,5,4,2,3],[2,7,3,8,6,4,1,9,5],[4,1,5,2,9,3,7,6,8],[5,2,4,6,8,7,3,1,9],[9,3,8,1,5,2,6,7,4],[7,6,1,3,4,9,5,8,2]]
546	[[9,1,3,7,6,2,8,5,4],[6,5,8,9,4,1,7,3,2],[4,2,7,8,5,3,9,1,6],[7,3,2,6,8,4,1,9,5],[8,9,6,1,3,5,2,4,7],[5,4,1,2,9,7,6,8,3],[2,7,4,3,1,9,5,6,8],[1,6,5,4,7,8,3,2,9],[3,8,9,5,2,6,4,7,1]]
547	[[7,9,1,5,6,2,3,8,4],[2,4,5,3,8,1,9,6,7],[6,8,3,4,7,9,1,5,2],[5,7,6,2,1,4,8,9,3],[4,1,8,9,3,6,2,7,5],[3,2,9,7,5,8,6,4,1],[9,3,4,6,2,7,5,1,8],[8,5,7,1,9,3,4,2,6],[1,6,2,8,4,5,7,3,9]]
548	[[1,3,7,9,5,8,2,6,4],[9,5,4,6,1,2,8,7,3],[6,2,8,3,4,7,1,5,9],[3,9,2,8,6,5,4,1,7],[7,8,1,4,2,3,6,9,5],[4,6,5,1,7,9,3,8,2],[2,1,6,7,9,4,5,3,8],[5,7,3,2,8,1,9,4,6],[8,4,9,5,3,6,7,2,1]]
549	[[3,7,8,2,1,6,5,9,4],[4,9,1,5,3,7,2,8,6],[5,2,6,8,4,9,3,7,1],[9,3,5,1,7,4,6,2,8],[1,4,2,6,5,8,7,3,9],[8,6,7,9,2,3,1,4,5],[2,8,9,7,6,5,4,1,3],[6,1,3,4,9,2,8,5,7],[7,5,4,3,8,1,9,6,2]]
550	[[3,2,9,1,6,8,4,5,7],[6,7,4,9,3,5,2,8,1],[5,1,8,4,2,7,6,3,9],[2,6,1,3,5,4,7,9,8],[8,5,7,2,9,6,3,1,4],[4,9,3,8,7,1,5,2,6],[1,3,5,7,4,9,8,6,2],[7,8,6,5,1,2,9,4,3],[9,4,2,6,8,3,1,7,5]]
551	[[4,2,1,7,9,3,6,8,5],[5,8,3,6,1,2,7,9,4],[6,7,9,8,4,5,2,3,1],[3,9,5,1,6,8,4,2,7],[1,4,8,2,5,7,9,6,3],[7,6,2,9,3,4,5,1,8],[8,5,4,3,2,9,1,7,6],[2,3,6,4,7,1,8,5,9],[9,1,7,5,8,6,3,4,2]]
552	[[1,6,2,8,7,3,5,9,4],[5,4,9,6,1,2,8,7,3],[8,7,3,4,9,5,2,1,6],[7,9,5,2,3,4,1,6,8],[3,2,8,5,6,1,7,4,9],[6,1,4,9,8,7,3,5,2],[4,3,6,1,5,8,9,2,7],[9,5,7,3,2,6,4,8,1],[2,8,1,7,4,9,6,3,5]]
553	[[2,1,3,6,9,8,7,4,5],[6,5,7,3,2,4,8,9,1],[8,4,9,5,7,1,2,6,3],[4,2,6,9,8,5,3,1,7],[9,3,1,2,6,7,4,5,8],[5,7,8,4,1,3,6,2,9],[1,6,5,8,3,2,9,7,4],[3,9,4,7,5,6,1,8,2],[7,8,2,1,4,9,5,3,6]]
554	[[2,4,7,3,9,6,1,5,8],[6,1,5,8,7,2,9,4,3],[9,8,3,1,5,4,6,7,2],[3,9,2,7,4,5,8,6,1],[5,6,1,9,2,8,4,3,7],[8,7,4,6,3,1,5,2,9],[4,3,9,5,1,7,2,8,6],[1,5,8,2,6,3,7,9,4],[7,2,6,4,8,9,3,1,5]]
555	[[8,9,3,1,5,2,7,6,4],[4,1,2,6,7,8,5,3,9],[5,7,6,9,4,3,1,2,8],[1,2,7,4,8,9,6,5,3],[3,4,5,2,1,6,8,9,7],[6,8,9,5,3,7,4,1,2],[2,3,1,8,6,4,9,7,5],[7,5,8,3,9,1,2,4,6],[9,6,4,7,2,5,3,8,1]]
556	[[1,6,3,7,8,2,4,5,9],[8,2,4,9,5,6,3,7,1],[7,9,5,3,4,1,8,6,2],[5,8,2,4,1,3,7,9,6],[9,4,1,2,6,7,5,8,3],[3,7,6,5,9,8,2,1,4],[4,5,7,6,2,9,1,3,8],[2,1,9,8,3,5,6,4,7],[6,3,8,1,7,4,9,2,5]]
557	[[2,3,9,8,7,5,6,1,4],[6,1,4,9,2,3,7,5,8],[8,5,7,6,1,4,3,2,9],[4,2,1,3,9,7,8,6,5],[9,6,5,2,8,1,4,3,7],[3,7,8,5,4,6,1,9,2],[5,4,2,1,6,8,9,7,3],[7,9,6,4,3,2,5,8,1],[1,8,3,7,5,9,2,4,6]]
558	[[7,4,3,9,1,5,6,2,8],[5,6,1,4,8,2,9,7,3],[9,2,8,7,6,3,1,4,5],[8,1,5,6,2,7,3,9,4],[4,7,2,5,3,9,8,6,1],[6,3,9,1,4,8,2,5,7],[2,5,6,3,7,1,4,8,9],[3,8,7,2,9,4,5,1,6],[1,9,4,8,5,6,7,3,2]]
559	[[4,7,2,8,1,9,5,6,3],[8,1,5,6,3,7,2,4,9],[6,3,9,2,5,4,1,7,8],[9,8,7,5,4,3,6,1,2],[5,2,6,7,8,1,9,3,4],[3,4,1,9,2,6,7,8,5],[2,5,3,1,6,8,4,9,7],[1,9,4,3,7,2,8,5,6],[7,6,8,4,9,5,3,2,1]]
560	[[7,8,5,2,3,6,1,9,4],[2,3,1,5,9,4,8,6,7],[4,6,9,1,8,7,2,5,3],[1,4,7,8,6,9,3,2,5],[9,5,6,3,2,1,4,7,8],[3,2,8,4,7,5,6,1,9],[6,7,4,9,1,8,5,3,2],[8,9,3,6,5,2,7,4,1],[5,1,2,7,4,3,9,8,6]]
561	[[1,7,6,4,9,3,5,2,8],[8,9,3,6,5,2,4,7,1],[5,2,4,1,7,8,3,9,6],[4,6,5,3,2,1,7,8,9],[9,8,1,7,4,6,2,3,5],[2,3,7,5,8,9,1,6,4],[6,4,9,2,3,5,8,1,7],[7,1,2,8,6,4,9,5,3],[3,5,8,9,1,7,6,4,2]]
562	[[8,4,3,9,7,2,1,6,5],[5,2,1,3,8,6,4,7,9],[7,6,9,4,5,1,2,3,8],[1,3,7,6,4,8,9,5,2],[2,9,4,5,1,7,6,8,3],[6,8,5,2,3,9,7,1,4],[9,5,2,1,6,3,8,4,7],[4,1,8,7,9,5,3,2,6],[3,7,6,8,2,4,5,9,1]]
563	[[7,1,2,5,4,9,8,3,6],[3,4,5,1,8,6,2,7,9],[9,6,8,3,7,2,1,4,5],[5,3,9,7,6,1,4,2,8],[8,2,1,4,9,3,6,5,7],[4,7,6,2,5,8,9,1,3],[6,5,7,9,2,4,3,8,1],[2,8,3,6,1,5,7,9,4],[1,9,4,8,3,7,5,6,2]]
564	[[6,3,2,8,1,5,4,9,7],[1,4,5,7,2,9,3,8,6],[7,9,8,3,6,4,1,2,5],[4,6,7,1,5,2,9,3,8],[3,2,1,9,8,6,5,7,4],[8,5,9,4,3,7,6,1,2],[9,1,4,5,7,8,2,6,3],[2,7,3,6,4,1,8,5,9],[5,8,6,2,9,3,7,4,1]]
565	[[4,1,5,9,8,3,7,2,6],[6,7,8,1,5,2,9,4,3],[3,9,2,7,4,6,1,8,5],[1,8,4,2,6,7,3,5,9],[7,2,3,5,9,1,8,6,4],[9,5,6,4,3,8,2,7,1],[2,4,7,6,1,9,5,3,8],[8,6,9,3,2,5,4,1,7],[5,3,1,8,7,4,6,9,2]]
566	[[8,3,2,1,5,7,4,6,9],[7,1,6,9,4,3,5,2,8],[5,4,9,2,8,6,1,3,7],[1,2,8,6,9,5,3,7,4],[3,5,7,4,2,8,9,1,6],[9,6,4,3,7,1,8,5,2],[4,9,1,5,6,2,7,8,3],[2,7,3,8,1,9,6,4,5],[6,8,5,7,3,4,2,9,1]]
567	[[3,9,1,8,7,5,2,4,6],[8,6,2,9,4,3,7,5,1],[5,7,4,1,2,6,3,9,8],[4,1,7,2,3,9,6,8,5],[2,5,8,6,1,4,9,3,7],[9,3,6,5,8,7,4,1,2],[1,4,3,7,6,8,5,2,9],[6,2,5,3,9,1,8,7,4],[7,8,9,4,5,2,1,6,3]]
568	[[6,3,2,7,8,1,9,4,5],[7,9,5,6,2,4,8,3,1],[1,8,4,5,9,3,7,2,6],[5,4,7,8,1,6,3,9,2],[8,6,3,9,4,2,5,1,7],[9,2,1,3,7,5,6,8,4],[4,5,6,2,3,8,1,7,9],[3,1,9,4,6,7,2,5,8],[2,7,8,1,5,9,4,6,3]]
569	[[3,9,4,7,1,2,6,8,5],[6,2,7,8,4,5,3,1,9],[1,5,8,9,6,3,7,2,4],[9,6,5,2,7,1,4,3,8],[2,7,1,4,3,8,5,9,6],[8,4,3,5,9,6,1,7,2],[4,8,2,3,5,7,9,6,1],[5,3,6,1,2,9,8,4,7],[7,1,9,6,8,4,2,5,3]]
570	[[7,4,9,8,5,6,2,1,3],[2,8,3,1,7,4,6,9,5],[6,5,1,3,9,2,8,4,7],[8,2,6,4,1,5,7,3,9],[1,3,5,9,2,7,4,6,8],[9,7,4,6,8,3,1,5,2],[4,6,2,7,3,9,5,8,1],[3,1,7,5,4,8,9,2,6],[5,9,8,2,6,1,3,7,4]]
571	[[3,5,9,7,1,2,8,4,6],[1,7,8,3,6,4,5,2,9],[4,6,2,9,5,8,7,3,1],[8,9,7,1,2,3,4,6,5],[5,4,3,6,8,7,9,1,2],[2,1,6,5,4,9,3,8,7],[7,8,4,2,9,6,1,5,3],[9,2,5,4,3,1,6,7,8],[6,3,1,8,7,5,2,9,4]]
572	[[3,2,1,6,8,7,9,4,5],[7,4,9,5,2,3,8,1,6],[8,6,5,1,4,9,2,7,3],[9,1,6,2,7,4,5,3,8],[2,3,4,9,5,8,1,6,7],[5,8,7,3,1,6,4,9,2],[4,7,2,8,6,1,3,5,9],[1,5,3,7,9,2,6,8,4],[6,9,8,4,3,5,7,2,1]]
573	[[2,9,1,3,5,4,6,7,8],[6,5,8,7,9,2,1,3,4],[3,7,4,1,8,6,2,5,9],[5,8,2,4,6,9,3,1,7],[4,3,7,8,1,5,9,6,2],[1,6,9,2,7,3,4,8,5],[8,4,6,9,3,7,5,2,1],[7,2,3,5,4,1,8,9,6],[9,1,5,6,2,8,7,4,3]]
574	[[6,8,1,4,9,2,5,3,7],[9,2,3,1,7,5,6,8,4],[5,4,7,3,8,6,2,9,1],[4,7,8,6,5,3,9,1,2],[2,1,5,9,4,8,7,6,3],[3,9,6,7,2,1,8,4,5],[1,3,2,8,6,7,4,5,9],[7,6,9,5,3,4,1,2,8],[8,5,4,2,1,9,3,7,6]]
575	[[9,8,5,1,2,3,6,4,7],[7,3,1,4,6,8,2,9,5],[2,4,6,5,9,7,3,1,8],[3,6,9,8,4,1,7,5,2],[4,7,8,2,5,9,1,6,3],[1,5,2,7,3,6,4,8,9],[6,9,4,3,8,2,5,7,1],[5,2,7,9,1,4,8,3,6],[8,1,3,6,7,5,9,2,4]]
576	[[7,6,8,5,1,4,9,3,2],[2,5,9,7,8,3,4,6,1],[4,1,3,6,9,2,5,8,7],[6,3,5,4,2,7,1,9,8],[1,2,4,8,6,9,3,7,5],[9,8,7,1,3,5,2,4,6],[5,4,6,3,7,1,8,2,9],[3,7,2,9,5,8,6,1,4],[8,9,1,2,4,6,7,5,3]]
577	[[8,4,6,9,5,3,1,2,7],[5,1,9,7,6,2,4,3,8],[3,2,7,4,1,8,6,5,9],[2,3,8,5,4,9,7,6,1],[6,9,1,2,8,7,5,4,3],[4,7,5,6,3,1,9,8,2],[9,6,3,1,2,5,8,7,4],[1,5,2,8,7,4,3,9,6],[7,8,4,3,9,6,2,1,5]]
578	[[6,7,1,8,4,3,5,2,9],[2,4,8,7,5,9,1,3,6],[3,9,5,6,1,2,4,7,8],[9,2,3,1,8,5,6,4,7],[1,6,7,3,9,4,8,5,2],[5,8,4,2,6,7,3,9,1],[7,1,9,4,3,8,2,6,5],[8,3,2,5,7,6,9,1,4],[4,5,6,9,2,1,7,8,3]]
579	[[7,2,1,6,9,3,4,5,8],[8,4,5,7,2,1,9,6,3],[9,3,6,5,8,4,7,1,2],[1,8,2,9,4,7,5,3,6],[6,5,9,2,3,8,1,4,7],[3,7,4,1,6,5,8,2,9],[5,6,8,4,7,2,3,9,1],[2,1,7,3,5,9,6,8,4],[4,9,3,8,1,6,2,7,5]]
580	[[8,3,7,5,6,2,9,4,1],[5,1,6,9,8,4,2,3,7],[2,4,9,3,1,7,5,8,6],[7,9,4,1,2,6,8,5,3],[1,2,3,4,5,8,6,7,9],[6,8,5,7,9,3,4,1,2],[4,6,8,2,7,1,3,9,5],[3,5,1,6,4,9,7,2,8],[9,7,2,8,3,5,1,6,4]]
581	[[3,7,9,1,4,6,5,8,2],[4,8,5,3,2,7,6,1,9],[1,6,2,9,5,8,7,3,4],[2,5,7,6,1,9,3,4,8],[9,3,4,8,7,5,1,2,6],[8,1,6,4,3,2,9,7,5],[7,2,8,5,9,3,4,6,1],[5,4,3,2,6,1,8,9,7],[6,9,1,7,8,4,2,5,3]]
582	[[4,9,2,7,1,5,8,3,6],[8,1,3,6,4,2,7,9,5],[5,7,6,9,3,8,4,2,1],[2,4,8,1,5,6,3,7,9],[1,3,9,2,7,4,5,6,8],[7,6,5,8,9,3,2,1,4],[9,2,1,4,8,7,6,5,3],[3,8,7,5,6,9,1,4,2],[6,5,4,3,2,1,9,8,7]]
583	[[6,8,3,9,7,5,4,1,2],[9,5,2,4,1,3,6,7,8],[1,7,4,8,2,6,5,3,9],[8,6,1,2,5,4,3,9,7],[2,3,5,7,6,9,8,4,1],[7,4,9,1,3,8,2,5,6],[5,1,6,3,9,2,7,8,4],[4,2,7,5,8,1,9,6,3],[3,9,8,6,4,7,1,2,5]]
584	[[9,1,2,8,3,4,7,6,5],[7,5,4,1,9,6,3,2,8],[8,3,6,7,2,5,4,1,9],[6,8,9,3,4,2,1,5,7],[3,4,7,5,1,9,2,8,6],[5,2,1,6,7,8,9,3,4],[1,9,5,4,6,3,8,7,2],[4,7,8,2,5,1,6,9,3],[2,6,3,9,8,7,5,4,1]]
585	[[1,2,7,8,5,9,4,3,6],[3,4,8,1,6,2,9,7,5],[6,9,5,3,4,7,8,1,2],[5,7,6,4,3,8,2,9,1],[9,8,4,2,7,1,6,5,3],[2,1,3,5,9,6,7,4,8],[8,3,1,7,2,4,5,6,9],[7,5,9,6,8,3,1,2,4],[4,6,2,9,1,5,3,8,7]]
586	[[9,2,3,4,6,1,5,8,7],[4,7,1,2,8,5,9,6,3],[6,8,5,7,9,3,2,1,4],[7,9,6,5,3,4,8,2,1],[1,3,2,8,7,6,4,5,9],[8,5,4,9,1,2,7,3,6],[2,1,7,6,5,9,3,4,8],[5,6,9,3,4,8,1,7,2],[3,4,8,1,2,7,6,9,5]]
587	[[3,4,1,6,8,5,7,2,9],[5,9,2,3,4,7,8,6,1],[8,6,7,2,1,9,3,4,5],[4,8,3,9,6,1,5,7,2],[9,2,5,7,3,8,6,1,4],[1,7,6,5,2,4,9,3,8],[7,1,8,4,9,6,2,5,3],[6,3,4,8,5,2,1,9,7],[2,5,9,1,7,3,4,8,6]]
588	[[9,7,5,1,3,4,2,6,8],[1,8,6,5,7,2,4,3,9],[2,4,3,9,8,6,1,7,5],[3,1,7,6,9,5,8,2,4],[6,5,4,8,2,7,3,9,1],[8,2,9,4,1,3,6,5,7],[7,9,2,3,4,1,5,8,6],[5,3,1,7,6,8,9,4,2],[4,6,8,2,5,9,7,1,3]]
589	[[9,1,5,4,2,8,6,3,7],[3,4,7,1,5,6,9,2,8],[6,2,8,9,7,3,1,4,5],[8,7,4,2,6,1,3,5,9],[1,3,9,5,4,7,2,8,6],[2,5,6,3,8,9,4,7,1],[4,9,2,7,1,5,8,6,3],[5,8,1,6,3,4,7,9,2],[7,6,3,8,9,2,5,1,4]]
590	[[8,5,6,3,7,2,9,4,1],[3,1,7,9,5,4,6,2,8],[9,2,4,1,6,8,3,7,5],[4,6,9,2,8,3,5,1,7],[7,3,2,4,1,5,8,9,6],[5,8,1,6,9,7,4,3,2],[6,7,3,8,2,9,1,5,4],[2,4,8,5,3,1,7,6,9],[1,9,5,7,4,6,2,8,3]]
591	[[3,6,9,5,1,4,7,2,8],[2,4,8,6,9,7,3,1,5],[7,5,1,3,8,2,4,6,9],[9,3,5,8,7,1,2,4,6],[1,2,6,4,5,3,9,8,7],[4,8,7,9,2,6,5,3,1],[8,9,3,2,6,5,1,7,4],[6,7,4,1,3,9,8,5,2],[5,1,2,7,4,8,6,9,3]]
592	[[8,2,9,1,4,3,7,5,6],[4,7,5,9,2,6,1,8,3],[6,1,3,5,7,8,4,9,2],[1,8,6,3,9,7,2,4,5],[2,5,7,4,6,1,8,3,9],[9,3,4,2,8,5,6,1,7],[5,4,2,7,1,9,3,6,8],[3,6,1,8,5,2,9,7,4],[7,9,8,6,3,4,5,2,1]]
593	[[5,4,8,3,9,1,2,6,7],[3,7,2,6,5,4,8,1,9],[1,9,6,8,2,7,4,3,5],[8,2,5,9,1,3,6,7,4],[4,6,3,5,7,2,1,9,8],[7,1,9,4,8,6,3,5,2],[2,5,4,1,6,9,7,8,3],[6,8,7,2,3,5,9,4,1],[9,3,1,7,4,8,5,2,6]]
594	[[9,5,2,1,8,6,4,3,7],[7,3,6,5,9,4,2,8,1],[8,4,1,7,2,3,6,9,5],[2,7,4,3,6,9,1,5,8],[6,1,3,4,5,8,7,2,9],[5,9,8,2,7,1,3,4,6],[3,8,5,6,1,2,9,7,4],[1,2,9,8,4,7,5,6,3],[4,6,7,9,3,5,8,1,2]]
595	[[7,4,1,8,3,6,5,9,2],[5,3,2,7,9,1,8,4,6],[8,6,9,2,5,4,1,3,7],[2,8,5,9,6,3,4,7,1],[4,1,3,5,8,7,2,6,9],[6,9,7,1,4,2,3,5,8],[9,2,4,3,7,8,6,1,5],[1,7,6,4,2,5,9,8,3],[3,5,8,6,1,9,7,2,4]]
596	[[7,5,4,1,2,3,8,6,9],[9,2,3,6,7,8,1,4,5],[6,1,8,5,4,9,7,2,3],[3,7,2,9,6,5,4,1,8],[8,4,9,3,1,7,2,5,6],[1,6,5,4,8,2,9,3,7],[5,3,1,8,9,4,6,7,2],[2,9,6,7,5,1,3,8,4],[4,8,7,2,3,6,5,9,1]]
597	[[8,7,2,4,9,6,1,3,5],[6,1,5,7,3,8,9,2,4],[4,3,9,2,5,1,7,8,6],[1,4,6,3,2,5,8,7,9],[9,2,3,8,6,7,4,5,1],[7,5,8,9,1,4,3,6,2],[3,6,7,1,4,2,5,9,8],[5,9,4,6,8,3,2,1,7],[2,8,1,5,7,9,6,4,3]]
598	[[6,5,9,8,3,1,2,4,7],[1,7,2,4,9,5,8,6,3],[8,4,3,7,2,6,5,9,1],[7,6,5,1,8,3,4,2,9],[3,2,4,5,6,9,1,7,8],[9,8,1,2,4,7,3,5,6],[5,3,7,6,1,2,9,8,4],[2,1,8,9,7,4,6,3,5],[4,9,6,3,5,8,7,1,2]]
599	[[6,4,7,3,2,8,5,9,1],[9,3,2,1,5,4,6,8,7],[8,1,5,7,6,9,2,3,4],[3,9,6,8,7,1,4,2,5],[2,8,1,4,3,5,7,6,9],[5,7,4,6,9,2,3,1,8],[7,5,9,2,8,6,1,4,3],[1,2,8,5,4,3,9,7,6],[4,6,3,9,1,7,8,5,2]]
600	[[3,1,4,7,5,8,9,6,2],[5,2,9,4,3,6,1,8,7],[8,7,6,1,9,2,5,3,4],[2,3,7,6,1,4,8,5,9],[6,9,1,8,2,5,4,7,3],[4,5,8,3,7,9,2,1,6],[7,4,5,2,6,1,3,9,8],[9,6,2,5,8,3,7,4,1],[1,8,3,9,4,7,6,2,5]]
601	[[1,4,3,2,8,6,5,9,7],[6,7,2,5,9,3,4,8,1],[9,5,8,7,4,1,6,3,2],[7,2,6,4,5,8,9,1,3],[3,9,4,1,7,2,8,6,5],[5,8,1,6,3,9,2,7,4],[4,6,5,9,1,7,3,2,8],[8,1,9,3,2,5,7,4,6],[2,3,7,8,6,4,1,5,9]]
602	[[1,5,8,3,6,2,4,9,7],[9,6,3,8,7,4,1,2,5],[2,4,7,5,9,1,6,3,8],[5,1,6,7,3,9,2,8,4],[7,8,9,2,4,6,5,1,3],[3,2,4,1,8,5,7,6,9],[4,7,1,9,2,3,8,5,6],[6,9,5,4,1,8,3,7,2],[8,3,2,6,5,7,9,4,1]]
603	[[9,5,8,2,4,3,6,1,7],[2,7,1,8,5,6,9,4,3],[6,3,4,7,1,9,8,5,2],[5,1,3,4,8,2,7,6,9],[4,6,9,3,7,1,2,8,5],[8,2,7,9,6,5,1,3,4],[3,9,6,1,2,4,5,7,8],[1,8,2,5,3,7,4,9,6],[7,4,5,6,9,8,3,2,1]]
604	[[4,8,5,1,7,2,6,3,9],[2,1,6,9,5,3,8,4,7],[7,9,3,8,6,4,5,1,2],[8,3,9,7,4,5,2,6,1],[1,5,4,2,8,6,9,7,3],[6,7,2,3,1,9,4,8,5],[3,4,8,5,2,7,1,9,6],[5,6,7,4,9,1,3,2,8],[9,2,1,6,3,8,7,5,4]]
605	[[2,7,5,6,4,9,3,8,1],[3,4,1,2,8,7,6,9,5],[8,6,9,3,5,1,4,7,2],[4,3,8,9,1,6,2,5,7],[5,2,7,8,3,4,9,1,6],[1,9,6,5,7,2,8,3,4],[6,5,4,1,9,3,7,2,8],[9,1,2,7,6,8,5,4,3],[7,8,3,4,2,5,1,6,9]]
606	[[6,9,5,4,7,3,2,8,1],[3,7,2,8,1,9,5,4,6],[8,4,1,6,2,5,9,3,7],[1,5,3,9,6,7,8,2,4],[4,2,7,1,5,8,3,6,9],[9,6,8,2,3,4,1,7,5],[7,3,4,5,8,1,6,9,2],[2,1,9,3,4,6,7,5,8],[5,8,6,7,9,2,4,1,3]]
607	[[6,3,2,5,7,9,1,8,4],[8,4,7,6,2,1,3,9,5],[5,1,9,4,3,8,7,2,6],[1,6,4,8,9,5,2,3,7],[9,7,5,3,4,2,8,6,1],[2,8,3,7,1,6,4,5,9],[7,9,8,2,6,4,5,1,3],[3,2,1,9,5,7,6,4,8],[4,5,6,1,8,3,9,7,2]]
608	[[5,1,2,6,8,9,4,3,7],[6,9,3,4,1,7,8,2,5],[4,8,7,5,3,2,6,1,9],[8,2,9,3,5,6,7,4,1],[3,7,6,1,9,4,5,8,2],[1,4,5,2,7,8,3,9,6],[9,5,1,8,6,3,2,7,4],[2,6,8,7,4,1,9,5,3],[7,3,4,9,2,5,1,6,8]]
609	[[3,7,1,6,8,2,9,5,4],[5,2,9,1,3,4,8,6,7],[8,4,6,9,5,7,3,1,2],[9,8,7,3,6,1,4,2,5],[6,3,4,2,9,5,1,7,8],[2,1,5,4,7,8,6,3,9],[1,9,8,5,2,6,7,4,3],[4,5,3,7,1,9,2,8,6],[7,6,2,8,4,3,5,9,1]]
610	[[2,4,5,6,7,8,9,1,3],[3,6,9,1,5,2,8,7,4],[8,7,1,3,9,4,5,6,2],[6,8,4,5,1,3,2,9,7],[5,3,7,2,6,9,4,8,1],[1,9,2,4,8,7,3,5,6],[9,2,6,7,4,5,1,3,8],[4,1,8,9,3,6,7,2,5],[7,5,3,8,2,1,6,4,9]]
611	[[7,5,1,6,2,8,3,4,9],[9,2,6,1,4,3,5,7,8],[4,8,3,5,9,7,1,6,2],[1,4,7,9,6,5,2,8,3],[8,6,9,7,3,2,4,1,5],[2,3,5,8,1,4,6,9,7],[3,9,2,4,7,1,8,5,6],[6,1,8,2,5,9,7,3,4],[5,7,4,3,8,6,9,2,1]]
612	[[3,5,4,6,9,8,2,7,1],[7,8,9,1,2,5,6,3,4],[2,1,6,4,3,7,5,8,9],[1,2,8,3,6,4,7,9,5],[9,6,7,5,8,1,4,2,3],[5,4,3,2,7,9,1,6,8],[8,3,1,7,5,2,9,4,6],[4,9,2,8,1,6,3,5,7],[6,7,5,9,4,3,8,1,2]]
613	[[1,9,4,5,8,7,3,2,6],[3,5,2,4,6,9,1,7,8],[6,8,7,1,3,2,4,5,9],[7,6,3,2,9,4,8,1,5],[5,2,9,3,1,8,7,6,4],[8,4,1,7,5,6,9,3,2],[4,3,8,6,2,1,5,9,7],[2,7,5,9,4,3,6,8,1],[9,1,6,8,7,5,2,4,3]]
614	[[5,7,8,4,2,1,3,6,9],[2,6,1,3,5,9,7,8,4],[4,3,9,6,7,8,2,1,5],[6,9,5,2,8,7,1,4,3],[8,1,7,5,4,3,6,9,2],[3,2,4,1,9,6,8,5,7],[1,8,2,9,3,5,4,7,6],[9,4,6,7,1,2,5,3,8],[7,5,3,8,6,4,9,2,1]]
615	[[5,2,9,8,1,7,6,4,3],[4,1,6,2,9,3,8,5,7],[7,3,8,5,4,6,9,2,1],[1,9,5,4,3,8,7,6,2],[6,7,2,9,5,1,4,3,8],[8,4,3,7,6,2,5,1,9],[3,5,1,6,7,9,2,8,4],[2,6,7,3,8,4,1,9,5],[9,8,4,1,2,5,3,7,6]]
616	[[1,7,5,9,6,4,3,2,8],[6,8,4,3,5,2,7,1,9],[3,2,9,1,8,7,6,5,4],[8,3,2,7,1,5,9,4,6],[9,1,6,8,4,3,5,7,2],[5,4,7,2,9,6,8,3,1],[7,9,3,4,2,8,1,6,5],[2,5,8,6,7,1,4,9,3],[4,6,1,5,3,9,2,8,7]]
617	[[1,9,5,6,4,2,3,7,8],[2,3,7,9,1,8,5,6,4],[6,8,4,7,3,5,1,2,9],[7,1,9,4,6,3,2,8,5],[5,6,3,2,8,1,4,9,7],[8,4,2,5,9,7,6,3,1],[9,2,8,3,5,4,7,1,6],[3,5,6,1,7,9,8,4,2],[4,7,1,8,2,6,9,5,3]]
618	[[1,6,7,3,4,5,2,9,8],[8,4,9,1,2,6,7,3,5],[5,3,2,7,9,8,1,4,6],[4,7,8,9,5,1,3,6,2],[9,2,5,4,6,3,8,7,1],[3,1,6,8,7,2,9,5,4],[2,9,3,6,1,4,5,8,7],[6,8,1,5,3,7,4,2,9],[7,5,4,2,8,9,6,1,3]]
619	[[9,1,7,6,4,5,8,2,3],[2,3,4,1,7,8,9,5,6],[6,8,5,3,2,9,1,7,4],[1,9,2,7,5,3,4,6,8],[5,7,6,4,8,1,2,3,9],[3,4,8,2,9,6,5,1,7],[4,6,3,9,1,2,7,8,5],[7,5,1,8,6,4,3,9,2],[8,2,9,5,3,7,6,4,1]]
620	[[9,5,1,4,2,7,3,8,6],[4,7,8,6,3,9,5,2,1],[3,6,2,1,5,8,7,4,9],[7,9,4,3,8,1,6,5,2],[8,2,6,5,9,4,1,7,3],[1,3,5,7,6,2,8,9,4],[5,1,9,2,7,6,4,3,8],[2,4,3,8,1,5,9,6,7],[6,8,7,9,4,3,2,1,5]]
621	[[8,7,3,6,9,1,5,4,2],[5,6,1,7,2,4,8,3,9],[9,2,4,3,8,5,1,7,6],[6,5,7,8,3,2,4,9,1],[3,8,2,4,1,9,6,5,7],[1,4,9,5,6,7,2,8,3],[4,9,6,1,7,8,3,2,5],[2,3,5,9,4,6,7,1,8],[7,1,8,2,5,3,9,6,4]]
622	[[2,9,1,7,4,5,8,3,6],[4,5,8,6,2,3,1,7,9],[7,6,3,1,9,8,2,5,4],[8,2,6,4,3,9,5,1,7],[5,4,7,2,1,6,3,9,8],[3,1,9,5,8,7,6,4,2],[1,3,4,9,6,2,7,8,5],[9,7,2,8,5,1,4,6,3],[6,8,5,3,7,4,9,2,1]]
623	[[4,2,1,3,6,7,5,8,9],[6,3,5,2,9,8,4,7,1],[9,7,8,4,5,1,6,2,3],[3,8,6,5,2,4,9,1,7],[5,9,7,8,1,6,2,3,4],[2,1,4,9,7,3,8,5,6],[1,6,2,7,8,9,3,4,5],[7,5,3,6,4,2,1,9,8],[8,4,9,1,3,5,7,6,2]]
624	[[2,6,5,8,1,3,4,7,9],[8,9,7,4,2,6,5,1,3],[3,4,1,5,9,7,6,2,8],[7,3,2,1,6,5,9,8,4],[5,1,9,7,8,4,2,3,6],[6,8,4,2,3,9,7,5,1],[1,7,8,6,4,2,3,9,5],[9,5,6,3,7,8,1,4,2],[4,2,3,9,5,1,8,6,7]]
625	[[8,4,1,7,2,9,3,6,5],[3,7,2,5,6,4,8,9,1],[5,9,6,1,8,3,2,4,7],[9,6,3,2,4,7,1,5,8],[2,1,5,3,9,8,6,7,4],[7,8,4,6,5,1,9,2,3],[1,5,9,8,7,6,4,3,2],[4,3,7,9,1,2,5,8,6],[6,2,8,4,3,5,7,1,9]]
626	[[6,5,1,9,8,4,2,3,7],[4,9,2,7,3,6,5,1,8],[3,8,7,5,2,1,4,6,9],[8,4,6,2,1,9,3,7,5],[5,1,9,4,7,3,6,8,2],[7,2,3,6,5,8,1,9,4],[9,6,5,3,4,7,8,2,1],[2,3,8,1,9,5,7,4,6],[1,7,4,8,6,2,9,5,3]]
627	[[7,8,1,5,4,3,9,2,6],[6,2,5,7,8,9,4,1,3],[4,3,9,6,1,2,8,5,7],[1,5,4,8,2,6,3,7,9],[2,9,8,3,7,4,5,6,1],[3,7,6,9,5,1,2,8,4],[5,6,7,4,9,8,1,3,2],[9,1,3,2,6,5,7,4,8],[8,4,2,1,3,7,6,9,5]]
628	[[9,4,8,6,3,2,7,5,1],[7,6,5,1,4,8,2,3,9],[2,3,1,9,7,5,8,6,4],[1,5,3,8,9,6,4,2,7],[8,7,6,2,5,4,1,9,3],[4,9,2,7,1,3,5,8,6],[6,8,9,4,2,1,3,7,5],[3,2,4,5,6,7,9,1,8],[5,1,7,3,8,9,6,4,2]]
629	[[5,1,6,9,8,2,7,3,4],[9,3,8,5,7,4,1,6,2],[4,2,7,3,6,1,5,8,9],[8,6,5,4,2,9,3,7,1],[1,9,2,7,3,5,6,4,8],[3,7,4,8,1,6,2,9,5],[7,4,1,6,5,8,9,2,3],[2,8,3,1,9,7,4,5,6],[6,5,9,2,4,3,8,1,7]]
630	[[7,8,5,1,4,3,6,2,9],[3,4,9,7,2,6,5,8,1],[2,6,1,8,5,9,7,3,4],[8,1,6,9,7,4,2,5,3],[5,2,4,3,6,8,1,9,7],[9,7,3,2,1,5,8,4,6],[4,5,8,6,9,1,3,7,2],[1,9,7,5,3,2,4,6,8],[6,3,2,4,8,7,9,1,5]]
631	[[6,4,7,3,2,1,9,5,8],[2,8,1,5,6,9,3,7,4],[3,5,9,7,4,8,6,1,2],[9,7,8,6,5,4,1,2,3],[4,1,3,8,9,2,7,6,5],[5,6,2,1,7,3,8,4,9],[7,3,6,4,8,5,2,9,1],[1,2,5,9,3,6,4,8,7],[8,9,4,2,1,7,5,3,6]]
632	[[3,2,8,5,6,1,9,7,4],[4,9,5,2,8,7,6,3,1],[1,7,6,3,9,4,2,5,8],[8,6,2,4,7,5,3,1,9],[9,4,7,6,1,3,8,2,5],[5,1,3,8,2,9,4,6,7],[2,8,1,7,4,6,5,9,3],[7,5,4,9,3,2,1,8,6],[6,3,9,1,5,8,7,4,2]]
633	[[8,1,7,2,6,5,4,3,9],[5,9,6,3,4,1,7,8,2],[3,2,4,8,9,7,1,6,5],[2,3,8,9,7,4,6,5,1],[1,7,9,6,5,3,8,2,4],[6,4,5,1,2,8,9,7,3],[9,5,2,4,8,6,3,1,7],[4,6,3,7,1,2,5,9,8],[7,8,1,5,3,9,2,4,6]]
634	[[7,1,6,3,5,2,4,8,9],[4,8,3,1,6,9,5,7,2],[2,5,9,8,4,7,3,6,1],[3,2,7,6,1,8,9,5,4],[1,9,5,2,7,4,6,3,8],[6,4,8,5,9,3,2,1,7],[5,3,4,7,2,1,8,9,6],[9,6,1,4,8,5,7,2,3],[8,7,2,9,3,6,1,4,5]]
635	[[4,1,7,3,9,2,6,8,5],[3,8,2,6,5,1,4,9,7],[6,9,5,4,7,8,3,2,1],[5,3,9,1,2,7,8,4,6],[8,2,1,9,6,4,5,7,3],[7,4,6,5,8,3,2,1,9],[1,7,4,8,3,6,9,5,2],[9,6,8,2,1,5,7,3,4],[2,5,3,7,4,9,1,6,8]]
636	[[5,1,6,4,9,3,2,8,7],[9,7,8,1,6,2,5,4,3],[2,4,3,7,5,8,1,6,9],[7,8,9,5,3,6,4,2,1],[6,2,1,9,8,4,7,3,5],[3,5,4,2,1,7,6,9,8],[8,6,7,3,2,5,9,1,4],[1,3,5,6,4,9,8,7,2],[4,9,2,8,7,1,3,5,6]]
637	[[3,4,8,7,2,6,1,5,9],[6,7,2,5,1,9,4,3,8],[5,9,1,4,8,3,7,2,6],[8,5,3,9,4,2,6,7,1],[7,2,9,6,5,1,8,4,3],[4,1,6,3,7,8,2,9,5],[2,8,5,1,9,7,3,6,4],[9,3,7,8,6,4,5,1,2],[1,6,4,2,3,5,9,8,7]]
638	[[9,2,8,1,4,3,5,6,7],[4,3,6,8,7,5,1,9,2],[5,1,7,2,6,9,3,4,8],[8,9,2,6,3,7,4,5,1],[6,7,4,5,9,1,2,8,3],[3,5,1,4,2,8,6,7,9],[2,8,3,7,5,4,9,1,6],[1,4,9,3,8,6,7,2,5],[7,6,5,9,1,2,8,3,4]]
639	[[6,8,5,7,2,3,4,9,1],[1,9,2,8,6,4,5,3,7],[7,3,4,1,9,5,2,8,6],[5,6,7,9,3,8,1,4,2],[4,1,9,6,7,2,3,5,8],[3,2,8,5,4,1,7,6,9],[2,5,6,4,1,9,8,7,3],[9,4,3,2,8,7,6,1,5],[8,7,1,3,5,6,9,2,4]]
640	[[2,5,7,1,8,4,3,6,9],[6,8,1,3,2,9,7,5,4],[4,9,3,7,6,5,1,2,8],[9,2,8,6,5,3,4,7,1],[7,1,5,2,4,8,9,3,6],[3,6,4,9,1,7,5,8,2],[8,4,2,5,3,1,6,9,7],[1,3,9,8,7,6,2,4,5],[5,7,6,4,9,2,8,1,3]]
641	[[4,7,5,9,8,2,1,3,6],[6,3,1,7,4,5,9,2,8],[9,2,8,1,6,3,7,5,4],[3,6,9,8,7,1,2,4,5],[8,4,2,6,5,9,3,7,1],[5,1,7,3,2,4,6,8,9],[2,8,3,4,1,6,5,9,7],[1,5,4,2,9,7,8,6,3],[7,9,6,5,3,8,4,1,2]]
642	[[6,1,7,9,2,3,4,8,5],[9,3,8,5,6,4,1,7,2],[2,4,5,8,7,1,9,6,3],[5,6,2,1,3,8,7,4,9],[7,8,3,4,9,2,5,1,6],[4,9,1,6,5,7,2,3,8],[1,2,4,3,8,5,6,9,7],[3,7,9,2,1,6,8,5,4],[8,5,6,7,4,9,3,2,1]]
643	[[5,4,6,8,1,7,2,3,9],[9,2,7,3,5,4,6,1,8],[8,1,3,9,2,6,5,4,7],[2,6,9,1,7,3,4,8,5],[4,7,8,2,6,5,1,9,3],[1,3,5,4,9,8,7,2,6],[7,9,4,6,8,2,3,5,1],[3,5,1,7,4,9,8,6,2],[6,8,2,5,3,1,9,7,4]]
644	[[9,5,4,8,6,7,1,2,3],[2,3,1,4,9,5,8,6,7],[6,8,7,3,1,2,9,4,5],[5,9,6,2,8,3,7,1,4],[1,4,3,5,7,9,2,8,6],[8,7,2,1,4,6,3,5,9],[7,1,5,6,3,8,4,9,2],[3,2,8,9,5,4,6,7,1],[4,6,9,7,2,1,5,3,8]]
645	[[2,9,5,6,7,1,8,3,4],[1,8,3,5,4,2,7,9,6],[4,7,6,9,8,3,1,5,2],[6,1,8,3,2,9,5,4,7],[9,2,7,1,5,4,3,6,8],[3,5,4,8,6,7,9,2,1],[7,4,1,2,9,5,6,8,3],[8,3,9,4,1,6,2,7,5],[5,6,2,7,3,8,4,1,9]]
646	[[8,6,7,3,2,9,4,5,1],[9,5,1,4,7,6,2,8,3],[4,2,3,1,5,8,9,6,7],[5,7,4,2,8,1,6,3,9],[3,8,9,7,6,4,5,1,2],[2,1,6,9,3,5,7,4,8],[6,9,5,8,1,7,3,2,4],[7,3,8,6,4,2,1,9,5],[1,4,2,5,9,3,8,7,6]]
647	[[7,8,1,6,9,2,3,5,4],[4,9,5,1,3,7,8,6,2],[6,2,3,8,4,5,7,9,1],[5,6,9,2,7,8,1,4,3],[3,4,8,5,1,9,6,2,7],[2,1,7,3,6,4,9,8,5],[1,7,4,9,5,6,2,3,8],[9,5,2,7,8,3,4,1,6],[8,3,6,4,2,1,5,7,9]]
648	[[3,4,8,9,1,2,5,7,6],[5,2,7,3,6,4,8,9,1],[6,1,9,8,7,5,3,2,4],[4,7,2,1,5,3,6,8,9],[8,5,3,2,9,6,4,1,7],[9,6,1,7,4,8,2,3,5],[2,9,4,5,3,1,7,6,8],[1,8,5,6,2,7,9,4,3],[7,3,6,4,8,9,1,5,2]]
649	[[8,1,3,6,4,5,9,2,7],[7,4,5,1,2,9,8,6,3],[2,6,9,8,3,7,1,5,4],[1,7,6,9,5,2,4,3,8],[4,3,2,7,8,1,6,9,5],[9,5,8,4,6,3,7,1,2],[6,2,4,5,9,8,3,7,1],[3,8,1,2,7,6,5,4,9],[5,9,7,3,1,4,2,8,6]]
650	[[7,8,1,3,4,5,6,9,2],[6,4,5,9,8,2,3,1,7],[3,2,9,1,7,6,8,5,4],[5,3,8,6,9,7,2,4,1],[1,7,4,2,3,8,5,6,9],[2,9,6,5,1,4,7,3,8],[8,6,7,4,5,9,1,2,3],[4,1,2,7,6,3,9,8,5],[9,5,3,8,2,1,4,7,6]]
651	[[2,9,5,4,7,3,6,8,1],[4,7,6,9,1,8,5,3,2],[3,8,1,2,6,5,7,4,9],[9,5,8,6,2,1,3,7,4],[1,6,4,3,9,7,2,5,8],[7,3,2,8,5,4,9,1,6],[8,2,7,5,4,6,1,9,3],[5,4,9,1,3,2,8,6,7],[6,1,3,7,8,9,4,2,5]]
652	[[5,1,7,8,6,2,3,4,9],[9,6,2,3,4,7,5,1,8],[8,3,4,5,1,9,7,6,2],[3,4,8,7,5,1,2,9,6],[7,5,9,6,2,4,1,8,3],[1,2,6,9,3,8,4,7,5],[4,8,1,2,9,5,6,3,7],[6,9,5,4,7,3,8,2,1],[2,7,3,1,8,6,9,5,4]]
653	[[8,5,7,3,6,2,1,9,4],[3,1,4,8,5,9,2,6,7],[2,6,9,4,1,7,5,3,8],[5,2,1,9,4,8,6,7,3],[4,7,8,6,3,1,9,5,2],[6,9,3,2,7,5,8,4,1],[9,4,2,5,8,3,7,1,6],[7,3,5,1,2,6,4,8,9],[1,8,6,7,9,4,3,2,5]]
654	[[8,7,5,6,3,2,4,9,1],[2,1,3,7,9,4,6,8,5],[6,4,9,8,5,1,3,7,2],[4,3,2,9,1,8,5,6,7],[1,5,6,2,4,7,9,3,8],[9,8,7,5,6,3,1,2,4],[7,9,4,3,2,5,8,1,6],[3,2,1,4,8,6,7,5,9],[5,6,8,1,7,9,2,4,3]]
655	[[2,1,5,9,6,8,4,7,3],[4,6,3,7,2,5,9,8,1],[8,9,7,4,3,1,2,6,5],[9,4,6,5,8,2,1,3,7],[5,2,8,1,7,3,6,4,9],[7,3,1,6,9,4,5,2,8],[1,7,2,3,5,6,8,9,4],[6,5,9,8,4,7,3,1,2],[3,8,4,2,1,9,7,5,6]]
656	[[1,4,8,6,2,7,5,3,9],[2,5,7,4,9,3,8,1,6],[6,3,9,8,5,1,4,7,2],[5,7,1,3,8,9,2,6,4],[8,9,4,1,6,2,3,5,7],[3,6,2,7,4,5,9,8,1],[9,2,6,5,7,8,1,4,3],[4,1,5,2,3,6,7,9,8],[7,8,3,9,1,4,6,2,5]]
657	[[8,2,7,6,3,5,9,4,1],[9,6,5,1,4,8,3,7,2],[1,3,4,9,7,2,5,8,6],[6,7,2,8,9,1,4,3,5],[4,8,9,5,6,3,2,1,7],[5,1,3,7,2,4,8,6,9],[7,4,1,3,5,9,6,2,8],[3,5,8,2,1,6,7,9,4],[2,9,6,4,8,7,1,5,3]]
658	[[9,3,1,4,8,6,5,2,7],[5,4,7,9,1,2,3,8,6],[6,2,8,7,5,3,1,4,9],[8,1,3,6,4,9,2,7,5],[2,5,4,1,3,7,6,9,8],[7,6,9,5,2,8,4,3,1],[3,7,2,8,6,5,9,1,4],[1,8,6,2,9,4,7,5,3],[4,9,5,3,7,1,8,6,2]]
659	[[5,4,1,7,6,9,2,3,8],[7,2,6,4,8,3,9,1,5],[3,8,9,2,5,1,4,7,6],[2,3,8,9,4,5,1,6,7],[6,1,7,3,2,8,5,4,9],[4,9,5,1,7,6,8,2,3],[1,7,3,5,9,2,6,8,4],[9,6,4,8,1,7,3,5,2],[8,5,2,6,3,4,7,9,1]]
660	[[9,4,8,2,5,7,1,3,6],[5,7,6,3,1,9,8,4,2],[2,3,1,6,4,8,5,7,9],[8,1,9,5,7,2,4,6,3],[3,6,2,4,9,1,7,8,5],[4,5,7,8,6,3,9,2,1],[6,9,5,7,2,4,3,1,8],[7,2,3,1,8,5,6,9,4],[1,8,4,9,3,6,2,5,7]]
661	[[2,5,4,3,1,7,9,8,6],[1,7,8,6,2,9,4,5,3],[6,3,9,8,5,4,2,7,1],[7,8,1,4,9,2,6,3,5],[3,9,6,1,8,5,7,4,2],[5,4,2,7,3,6,8,1,9],[4,1,7,9,6,3,5,2,8],[8,6,5,2,7,1,3,9,4],[9,2,3,5,4,8,1,6,7]]
662	[[3,2,8,9,7,5,4,1,6],[7,1,6,4,3,8,9,5,2],[5,4,9,1,2,6,8,3,7],[6,5,1,7,8,9,3,2,4],[2,8,3,6,4,1,5,7,9],[9,7,4,3,5,2,6,8,1],[1,6,5,8,9,7,2,4,3],[4,9,2,5,1,3,7,6,8],[8,3,7,2,6,4,1,9,5]]
663	[[8,5,4,9,6,7,3,1,2],[7,1,9,3,5,2,6,4,8],[3,6,2,4,8,1,5,7,9],[1,7,8,6,4,9,2,5,3],[4,3,5,1,2,8,9,6,7],[2,9,6,5,7,3,1,8,4],[5,2,7,8,9,6,4,3,1],[6,8,1,2,3,4,7,9,5],[9,4,3,7,1,5,8,2,6]]
664	[[1,3,6,2,5,8,9,4,7],[8,9,4,6,7,1,5,3,2],[7,2,5,4,3,9,8,6,1],[3,7,2,9,4,5,1,8,6],[6,5,9,8,1,3,7,2,4],[4,1,8,7,2,6,3,9,5],[9,4,3,1,6,7,2,5,8],[5,6,1,3,8,2,4,7,9],[2,8,7,5,9,4,6,1,3]]
665	[[4,2,6,8,1,3,5,7,9],[7,9,8,5,4,2,6,1,3],[3,1,5,7,9,6,8,4,2],[2,3,4,9,8,5,1,6,7],[6,7,9,1,2,4,3,8,5],[8,5,1,6,3,7,9,2,4],[5,4,7,3,6,1,2,9,8],[1,8,2,4,5,9,7,3,6],[9,6,3,2,7,8,4,5,1]]
666	[[7,5,9,3,1,4,2,8,6],[8,1,3,7,6,2,5,9,4],[4,6,2,5,8,9,1,7,3],[3,9,6,1,7,8,4,5,2],[1,2,8,6,4,5,7,3,9],[5,7,4,2,9,3,6,1,8],[6,8,7,4,3,1,9,2,5],[9,4,5,8,2,7,3,6,1],[2,3,1,9,5,6,8,4,7]]
667	[[7,2,4,9,5,1,6,3,8],[1,5,3,2,6,8,9,7,4],[8,6,9,3,4,7,1,2,5],[5,7,6,4,2,9,8,1,3],[9,4,8,1,3,6,7,5,2],[3,1,2,7,8,5,4,9,6],[6,3,1,8,7,2,5,4,9],[4,8,7,5,9,3,2,6,1],[2,9,5,6,1,4,3,8,7]]
668	[[7,5,4,9,2,8,3,1,6],[2,6,8,3,1,7,9,4,5],[9,1,3,6,4,5,8,7,2],[6,4,7,8,5,2,1,9,3],[1,8,2,4,9,3,6,5,7],[3,9,5,1,7,6,4,2,8],[4,7,6,2,3,1,5,8,9],[5,3,1,7,8,9,2,6,4],[8,2,9,5,6,4,7,3,1]]
669	[[3,1,8,9,5,4,2,6,7],[6,2,5,7,3,8,4,1,9],[4,7,9,6,1,2,3,8,5],[8,5,6,2,9,7,1,3,4],[7,9,1,3,4,6,8,5,2],[2,3,4,5,8,1,7,9,6],[9,4,3,1,7,5,6,2,8],[1,8,2,4,6,9,5,7,3],[5,6,7,8,2,3,9,4,1]]
670	[[8,5,6,1,7,4,9,2,3],[1,4,3,9,2,5,7,6,8],[2,9,7,6,3,8,1,4,5],[3,6,5,7,9,1,2,8,4],[4,2,1,8,5,3,6,7,9],[9,7,8,4,6,2,5,3,1],[5,3,9,2,8,7,4,1,6],[7,8,4,5,1,6,3,9,2],[6,1,2,3,4,9,8,5,7]]
671	[[9,3,5,8,7,4,1,6,2],[6,1,4,3,9,2,8,7,5],[8,2,7,6,1,5,3,9,4],[2,9,8,1,4,7,6,5,3],[5,4,3,9,8,6,7,2,1],[1,7,6,2,5,3,4,8,9],[4,8,9,7,2,1,5,3,6],[7,6,1,5,3,9,2,4,8],[3,5,2,4,6,8,9,1,7]]
672	[[9,4,3,1,5,6,8,7,2],[5,7,1,2,9,8,6,4,3],[8,6,2,4,7,3,9,5,1],[7,9,6,8,1,2,4,3,5],[3,1,4,7,6,5,2,8,9],[2,5,8,9,3,4,1,6,7],[4,3,5,6,2,1,7,9,8],[1,8,7,3,4,9,5,2,6],[6,2,9,5,8,7,3,1,4]]
673	[[2,3,1,7,5,4,9,6,8],[8,6,5,2,1,9,4,3,7],[7,9,4,6,3,8,1,2,5],[3,4,2,9,6,7,8,5,1],[9,5,6,4,8,1,2,7,3],[1,7,8,5,2,3,6,9,4],[4,1,9,3,7,2,5,8,6],[5,8,7,1,9,6,3,4,2],[6,2,3,8,4,5,7,1,9]]
674	[[4,1,3,6,5,9,8,2,7],[8,5,9,7,3,2,1,6,4],[2,7,6,4,8,1,3,9,5],[3,2,7,1,4,6,9,5,8],[9,8,1,3,2,5,4,7,6],[6,4,5,8,9,7,2,3,1],[1,9,2,5,7,8,6,4,3],[5,3,8,9,6,4,7,1,2],[7,6,4,2,1,3,5,8,9]]
675	[[3,8,7,2,1,4,5,9,6],[2,5,1,9,7,6,4,8,3],[4,6,9,8,3,5,7,2,1],[7,4,3,1,5,9,2,6,8],[9,2,8,7,6,3,1,5,4],[5,1,6,4,2,8,9,3,7],[6,7,2,5,8,1,3,4,9],[8,9,5,3,4,7,6,1,2],[1,3,4,6,9,2,8,7,5]]
676	[[5,3,6,2,7,4,1,9,8],[4,9,7,1,3,8,2,6,5],[8,1,2,6,5,9,7,3,4],[9,6,4,7,1,5,3,8,2],[2,7,5,3,8,6,4,1,9],[1,8,3,9,4,2,6,5,7],[7,5,1,4,9,3,8,2,6],[3,2,8,5,6,7,9,4,1],[6,4,9,8,2,1,5,7,3]]
677	[[8,1,2,5,4,7,6,3,9],[4,7,9,2,3,6,8,5,1],[6,5,3,9,1,8,2,4,7],[2,4,1,6,7,5,9,8,3],[9,8,6,1,2,3,4,7,5],[5,3,7,8,9,4,1,2,6],[1,9,4,3,5,2,7,6,8],[3,2,8,7,6,1,5,9,4],[7,6,5,4,8,9,3,1,2]]
678	[[9,6,5,8,2,1,7,3,4],[4,8,1,3,9,7,2,6,5],[3,7,2,6,5,4,1,9,8],[7,9,8,2,4,5,3,1,6],[1,5,6,9,7,3,4,8,2],[2,4,3,1,8,6,5,7,9],[6,2,4,7,3,8,9,5,1],[8,3,9,5,1,2,6,4,7],[5,1,7,4,6,9,8,2,3]]
679	[[6,5,2,4,7,1,9,3,8],[7,3,8,6,9,5,1,2,4],[4,9,1,2,8,3,5,7,6],[5,8,6,3,4,9,7,1,2],[1,2,3,8,5,7,4,6,9],[9,4,7,1,2,6,8,5,3],[8,7,5,9,3,2,6,4,1],[3,1,9,7,6,4,2,8,5],[2,6,4,5,1,8,3,9,7]]
680	[[2,5,6,4,7,1,3,9,8],[8,1,4,6,3,9,7,5,2],[3,7,9,5,8,2,4,1,6],[6,8,5,2,9,3,1,4,7],[1,4,3,7,5,8,2,6,9],[9,2,7,1,6,4,8,3,5],[4,6,2,8,1,5,9,7,3],[7,9,1,3,2,6,5,8,4],[5,3,8,9,4,7,6,2,1]]
681	[[7,9,6,5,8,1,3,4,2],[2,1,4,7,6,3,8,5,9],[8,5,3,9,2,4,1,7,6],[4,2,9,1,3,5,7,6,8],[5,3,1,8,7,6,2,9,4],[6,8,7,2,4,9,5,1,3],[3,7,5,4,9,8,6,2,1],[9,6,2,3,1,7,4,8,5],[1,4,8,6,5,2,9,3,7]]
682	[[5,8,7,9,6,2,3,1,4],[2,1,6,4,3,8,5,9,7],[4,3,9,1,5,7,2,6,8],[6,4,5,2,8,1,7,3,9],[3,2,1,7,9,6,8,4,5],[9,7,8,5,4,3,6,2,1],[1,6,2,8,7,4,9,5,3],[7,9,4,3,2,5,1,8,6],[8,5,3,6,1,9,4,7,2]]
683	[[9,3,8,7,5,4,2,6,1],[5,2,1,9,8,6,7,3,4],[7,6,4,1,3,2,9,5,8],[4,7,6,2,1,8,3,9,5],[1,8,2,3,9,5,4,7,6],[3,9,5,4,6,7,8,1,2],[8,1,7,5,2,3,6,4,9],[2,5,3,6,4,9,1,8,7],[6,4,9,8,7,1,5,2,3]]
684	[[7,6,1,8,5,4,3,2,9],[8,3,5,9,2,1,7,4,6],[9,4,2,3,6,7,8,1,5],[5,7,8,4,3,6,1,9,2],[1,9,4,2,7,8,5,6,3],[3,2,6,1,9,5,4,8,7],[6,1,3,5,8,9,2,7,4],[4,5,9,7,1,2,6,3,8],[2,8,7,6,4,3,9,5,1]]
685	[[9,1,6,5,2,3,8,4,7],[4,2,7,1,6,8,5,9,3],[5,8,3,4,9,7,6,1,2],[8,6,5,3,7,9,4,2,1],[1,3,9,2,4,6,7,5,8],[7,4,2,8,1,5,9,3,6],[3,9,8,7,5,2,1,6,4],[6,7,1,9,3,4,2,8,5],[2,5,4,6,8,1,3,7,9]]
686	[[2,5,9,8,1,6,3,4,7],[7,6,1,3,9,4,2,5,8],[3,8,4,7,2,5,6,1,9],[4,3,2,1,8,7,9,6,5],[6,1,8,9,5,3,7,2,4],[9,7,5,4,6,2,8,3,1],[8,2,6,5,7,1,4,9,3],[5,4,7,2,3,9,1,8,6],[1,9,3,6,4,8,5,7,2]]
687	[[9,4,3,6,7,8,2,1,5],[1,2,5,3,4,9,7,6,8],[7,6,8,2,1,5,4,3,9],[3,5,6,9,8,7,1,2,4],[4,9,2,1,5,3,8,7,6],[8,1,7,4,2,6,9,5,3],[2,3,9,7,6,4,5,8,1],[6,8,1,5,9,2,3,4,7],[5,7,4,8,3,1,6,9,2]]
688	[[7,8,5,9,3,4,1,6,2],[3,9,1,6,2,5,7,8,4],[4,6,2,7,8,1,9,3,5],[1,4,3,8,5,6,2,9,7],[6,5,9,4,7,2,8,1,3],[2,7,8,1,9,3,4,5,6],[8,3,4,5,1,7,6,2,9],[5,1,6,2,4,9,3,7,8],[9,2,7,3,6,8,5,4,1]]
689	[[8,2,1,5,7,3,6,9,4],[4,5,9,1,6,2,3,8,7],[3,7,6,8,4,9,2,1,5],[6,9,7,3,2,1,4,5,8],[5,4,3,7,9,8,1,6,2],[2,1,8,6,5,4,7,3,9],[9,6,5,2,1,7,8,4,3],[1,8,2,4,3,5,9,7,6],[7,3,4,9,8,6,5,2,1]]
690	[[4,1,9,7,2,3,5,6,8],[7,2,8,9,5,6,4,3,1],[3,6,5,1,4,8,9,2,7],[9,8,3,2,1,4,7,5,6],[2,5,1,6,3,7,8,4,9],[6,7,4,8,9,5,2,1,3],[8,4,7,5,6,1,3,9,2],[1,3,2,4,8,9,6,7,5],[5,9,6,3,7,2,1,8,4]]
691	[[1,6,5,9,8,2,7,3,4],[9,2,3,1,7,4,8,5,6],[8,7,4,6,5,3,2,1,9],[2,3,9,8,1,5,6,4,7],[6,8,1,2,4,7,5,9,3],[4,5,7,3,6,9,1,8,2],[3,4,6,5,2,1,9,7,8],[5,9,2,7,3,8,4,6,1],[7,1,8,4,9,6,3,2,5]]
692	[[6,8,1,7,3,4,2,5,9],[9,3,7,2,8,5,6,1,4],[2,5,4,9,6,1,8,7,3],[4,7,6,1,2,9,5,3,8],[5,9,2,8,4,3,1,6,7],[3,1,8,5,7,6,4,9,2],[1,2,9,3,5,8,7,4,6],[7,4,3,6,1,2,9,8,5],[8,6,5,4,9,7,3,2,1]]
693	[[9,7,4,1,6,5,2,8,3],[3,6,1,2,8,9,5,4,7],[5,8,2,4,3,7,1,9,6],[8,2,3,6,4,1,7,5,9],[4,1,7,5,9,8,6,3,2],[6,5,9,7,2,3,4,1,8],[1,4,8,3,7,6,9,2,5],[7,3,5,9,1,2,8,6,4],[2,9,6,8,5,4,3,7,1]]
694	[[8,4,3,1,9,6,2,5,7],[5,2,9,3,7,4,8,1,6],[1,7,6,2,5,8,9,3,4],[2,6,5,9,3,1,7,4,8],[3,9,7,4,8,5,1,6,2],[4,8,1,6,2,7,5,9,3],[9,5,4,8,6,2,3,7,1],[7,1,2,5,4,3,6,8,9],[6,3,8,7,1,9,4,2,5]]
695	[[2,7,5,4,3,6,8,1,9],[3,1,4,9,7,8,6,5,2],[9,6,8,5,2,1,4,3,7],[4,9,1,6,8,5,2,7,3],[7,3,6,2,1,4,5,9,8],[8,5,2,3,9,7,1,6,4],[5,8,9,1,4,3,7,2,6],[1,4,3,7,6,2,9,8,5],[6,2,7,8,5,9,3,4,1]]
696	[[5,4,2,1,6,7,9,3,8],[6,8,3,4,9,5,2,7,1],[9,1,7,3,8,2,5,4,6],[2,7,5,6,4,8,3,1,9],[3,9,8,5,7,1,4,6,2],[4,6,1,9,2,3,7,8,5],[7,2,4,8,1,9,6,5,3],[1,3,6,2,5,4,8,9,7],[8,5,9,7,3,6,1,2,4]]
697	[[7,2,6,5,8,3,1,9,4],[5,4,9,6,1,2,3,7,8],[3,8,1,4,7,9,2,5,6],[8,9,4,2,6,7,5,3,1],[6,5,7,9,3,1,4,8,2],[2,1,3,8,5,4,9,6,7],[4,7,8,1,9,5,6,2,3],[1,6,5,3,2,8,7,4,9],[9,3,2,7,4,6,8,1,5]]
698	[[5,4,3,1,7,2,8,6,9],[7,8,6,4,5,9,2,3,1],[2,1,9,6,8,3,4,7,5],[8,3,4,9,1,6,7,5,2],[6,2,5,3,4,7,1,9,8],[9,7,1,5,2,8,3,4,6],[3,5,8,2,9,4,6,1,7],[1,6,7,8,3,5,9,2,4],[4,9,2,7,6,1,5,8,3]]
699	[[3,9,4,1,8,7,5,6,2],[2,5,7,3,9,6,8,1,4],[1,6,8,5,2,4,7,3,9],[4,7,5,2,6,3,1,9,8],[6,1,9,7,5,8,4,2,3],[8,2,3,4,1,9,6,7,5],[9,4,1,6,3,5,2,8,7],[5,3,6,8,7,2,9,4,1],[7,8,2,9,4,1,3,5,6]]
700	[[2,8,4,1,9,6,7,5,3],[7,5,9,2,8,3,1,6,4],[6,3,1,4,7,5,9,2,8],[9,1,2,3,5,8,6,4,7],[8,6,5,7,1,4,3,9,2],[4,7,3,9,6,2,8,1,5],[1,4,7,5,3,9,2,8,6],[5,9,6,8,2,7,4,3,1],[3,2,8,6,4,1,5,7,9]]
701	[[6,3,8,2,4,5,1,7,9],[1,5,7,9,8,3,6,2,4],[4,9,2,1,6,7,8,3,5],[8,1,5,4,7,6,3,9,2],[3,4,6,8,2,9,5,1,7],[2,7,9,3,5,1,4,6,8],[5,2,1,6,9,4,7,8,3],[9,6,4,7,3,8,2,5,1],[7,8,3,5,1,2,9,4,6]]
702	[[9,3,6,5,7,2,8,1,4],[1,8,5,6,4,9,7,3,2],[2,7,4,1,8,3,9,6,5],[4,9,7,2,6,1,5,8,3],[6,2,1,8,3,5,4,9,7],[8,5,3,7,9,4,1,2,6],[5,1,8,3,2,7,6,4,9],[7,4,2,9,1,6,3,5,8],[3,6,9,4,5,8,2,7,1]]
703	[[8,2,7,3,4,5,1,6,9],[3,9,5,6,7,1,4,2,8],[6,1,4,9,2,8,3,5,7],[1,3,2,8,6,4,9,7,5],[7,6,9,2,5,3,8,4,1],[5,4,8,1,9,7,6,3,2],[4,7,3,5,8,9,2,1,6],[2,8,1,7,3,6,5,9,4],[9,5,6,4,1,2,7,8,3]]
704	[[7,6,5,2,9,8,3,1,4],[3,9,1,5,7,4,2,8,6],[8,2,4,3,1,6,5,7,9],[5,7,9,6,3,2,8,4,1],[1,8,6,9,4,5,7,2,3],[4,3,2,7,8,1,6,9,5],[2,4,8,1,6,3,9,5,7],[6,1,7,8,5,9,4,3,2],[9,5,3,4,2,7,1,6,8]]
705	[[1,3,2,8,9,5,4,6,7],[7,4,9,6,3,1,5,2,8],[5,6,8,4,7,2,3,1,9],[6,8,1,9,5,4,7,3,2],[3,9,7,2,8,6,1,4,5],[2,5,4,7,1,3,9,8,6],[9,2,3,5,4,8,6,7,1],[8,1,5,3,6,7,2,9,4],[4,7,6,1,2,9,8,5,3]]
706	[[9,7,6,5,1,3,8,4,2],[3,5,4,8,2,7,9,1,6],[1,2,8,6,9,4,3,7,5],[2,6,7,1,8,9,4,5,3],[8,3,9,4,5,6,1,2,7],[4,1,5,3,7,2,6,8,9],[5,4,2,9,6,1,7,3,8],[6,8,1,7,3,5,2,9,4],[7,9,3,2,4,8,5,6,1]]
707	[[5,9,8,7,4,1,3,2,6],[2,4,3,6,9,8,1,7,5],[6,1,7,3,5,2,8,4,9],[3,2,1,9,8,4,6,5,7],[9,8,5,2,6,7,4,1,3],[4,7,6,1,3,5,2,9,8],[8,6,2,5,1,9,7,3,4],[7,3,9,4,2,6,5,8,1],[1,5,4,8,7,3,9,6,2]]
708	[[2,6,1,7,5,8,9,3,4],[8,3,4,6,9,1,2,5,7],[5,7,9,4,2,3,8,6,1],[4,2,3,9,8,5,1,7,6],[9,5,7,2,1,6,3,4,8],[6,1,8,3,7,4,5,2,9],[3,9,2,1,6,7,4,8,5],[1,8,6,5,4,2,7,9,3],[7,4,5,8,3,9,6,1,2]]
709	[[6,9,3,1,5,7,8,4,2],[7,2,1,6,8,4,9,5,3],[8,4,5,9,3,2,1,7,6],[9,8,4,5,1,6,2,3,7],[3,1,6,7,2,9,5,8,4],[5,7,2,8,4,3,6,9,1],[2,5,8,4,7,1,3,6,9],[1,6,7,3,9,8,4,2,5],[4,3,9,2,6,5,7,1,8]]
710	[[3,9,1,8,5,7,4,6,2],[7,4,8,2,9,6,1,5,3],[5,6,2,1,4,3,7,8,9],[1,3,4,6,2,5,8,9,7],[6,7,9,4,3,8,5,2,1],[2,8,5,9,7,1,6,3,4],[4,1,3,5,6,9,2,7,8],[9,2,6,7,8,4,3,1,5],[8,5,7,3,1,2,9,4,6]]
711	[[2,5,9,8,1,7,4,3,6],[7,8,6,3,4,2,1,5,9],[3,4,1,9,5,6,2,7,8],[5,2,8,6,9,1,3,4,7],[1,9,3,4,7,8,5,6,2],[4,6,7,5,2,3,8,9,1],[9,1,2,7,3,5,6,8,4],[8,3,4,2,6,9,7,1,5],[6,7,5,1,8,4,9,2,3]]
712	[[1,3,7,9,6,5,8,2,4],[4,2,6,3,8,1,7,5,9],[8,5,9,4,2,7,1,6,3],[2,6,5,1,9,4,3,7,8],[9,7,4,8,3,6,5,1,2],[3,1,8,5,7,2,9,4,6],[6,9,1,7,4,3,2,8,5],[5,8,2,6,1,9,4,3,7],[7,4,3,2,5,8,6,9,1]]
713	[[7,1,8,2,3,9,6,4,5],[3,4,5,8,7,6,9,2,1],[9,2,6,4,1,5,8,7,3],[8,3,9,5,2,7,4,1,6],[5,7,4,1,6,3,2,8,9],[1,6,2,9,4,8,5,3,7],[2,8,3,6,5,1,7,9,4],[4,5,1,7,9,2,3,6,8],[6,9,7,3,8,4,1,5,2]]
714	[[5,2,9,8,3,1,7,4,6],[6,1,8,5,7,4,3,2,9],[7,4,3,2,6,9,1,5,8],[9,3,2,6,4,8,5,7,1],[8,6,5,3,1,7,2,9,4],[4,7,1,9,5,2,8,6,3],[2,5,4,1,9,3,6,8,7],[3,8,7,4,2,6,9,1,5],[1,9,6,7,8,5,4,3,2]]
715	[[8,2,6,4,9,1,7,3,5],[3,1,9,5,7,6,2,4,8],[4,7,5,3,8,2,1,9,6],[5,3,2,8,6,9,4,1,7],[9,6,1,7,2,4,5,8,3],[7,4,8,1,5,3,6,2,9],[2,8,4,6,3,5,9,7,1],[1,5,3,9,4,7,8,6,2],[6,9,7,2,1,8,3,5,4]]
716	[[4,1,3,6,2,5,9,7,8],[7,6,9,1,8,4,2,3,5],[5,8,2,3,7,9,4,1,6],[8,3,5,2,4,1,7,6,9],[1,9,7,5,3,6,8,2,4],[2,4,6,7,9,8,1,5,3],[3,7,8,9,6,2,5,4,1],[9,2,1,4,5,3,6,8,7],[6,5,4,8,1,7,3,9,2]]
717	[[9,6,3,5,8,7,1,2,4],[5,2,7,9,1,4,6,8,3],[8,4,1,6,3,2,9,7,5],[2,7,9,8,5,1,3,4,6],[3,5,4,7,9,6,2,1,8],[6,1,8,4,2,3,7,5,9],[1,8,2,3,6,5,4,9,7],[7,9,6,1,4,8,5,3,2],[4,3,5,2,7,9,8,6,1]]
718	[[8,3,5,7,1,4,6,9,2],[7,9,1,2,6,3,8,4,5],[6,2,4,9,5,8,3,1,7],[5,7,6,4,8,2,9,3,1],[2,4,3,5,9,1,7,6,8],[1,8,9,6,3,7,5,2,4],[4,6,8,3,2,5,1,7,9],[9,5,7,1,4,6,2,8,3],[3,1,2,8,7,9,4,5,6]]
719	[[9,4,6,5,3,1,2,7,8],[3,5,8,2,7,4,1,9,6],[1,7,2,8,9,6,5,4,3],[8,3,1,9,4,7,6,2,5],[4,2,5,1,6,8,7,3,9],[7,6,9,3,2,5,8,1,4],[2,9,7,6,5,3,4,8,1],[6,8,3,4,1,2,9,5,7],[5,1,4,7,8,9,3,6,2]]
720	[[7,3,1,5,8,9,6,4,2],[9,2,5,4,6,3,7,8,1],[4,8,6,1,7,2,3,9,5],[6,5,7,9,4,1,8,2,3],[2,9,4,8,3,5,1,6,7],[8,1,3,6,2,7,9,5,4],[5,4,9,7,1,6,2,3,8],[1,6,2,3,5,8,4,7,9],[3,7,8,2,9,4,5,1,6]]
721	[[9,8,5,6,7,2,1,4,3],[1,3,2,8,4,9,5,7,6],[6,7,4,1,3,5,2,8,9],[8,1,3,2,5,7,6,9,4],[2,6,9,4,8,1,7,3,5],[4,5,7,3,9,6,8,2,1],[5,4,6,9,2,8,3,1,7],[7,9,8,5,1,3,4,6,2],[3,2,1,7,6,4,9,5,8]]
722	[[2,4,8,9,1,3,7,6,5],[7,5,6,8,4,2,3,1,9],[9,1,3,5,6,7,4,2,8],[6,2,4,1,7,9,5,8,3],[8,3,1,4,2,5,9,7,6],[5,7,9,3,8,6,1,4,2],[1,6,5,2,9,4,8,3,7],[4,9,2,7,3,8,6,5,1],[3,8,7,6,5,1,2,9,4]]
723	[[7,6,9,4,3,8,1,2,5],[2,1,4,5,9,6,8,7,3],[8,5,3,7,2,1,6,4,9],[1,2,6,8,4,9,5,3,7],[9,4,7,6,5,3,2,1,8],[3,8,5,2,1,7,9,6,4],[5,7,1,3,8,2,4,9,6],[4,3,2,9,6,5,7,8,1],[6,9,8,1,7,4,3,5,2]]
724	[[3,8,5,6,9,4,2,1,7],[7,2,9,5,1,8,3,6,4],[1,6,4,2,7,3,9,5,8],[5,1,8,4,3,7,6,2,9],[6,4,3,9,5,2,7,8,1],[2,9,7,1,8,6,4,3,5],[4,3,1,7,2,5,8,9,6],[8,5,6,3,4,9,1,7,2],[9,7,2,8,6,1,5,4,3]]
725	[[1,2,3,6,7,8,4,5,9],[7,6,8,9,5,4,1,2,3],[4,5,9,3,2,1,6,7,8],[2,7,6,5,8,3,9,1,4],[5,3,4,1,9,2,7,8,6],[9,8,1,4,6,7,5,3,2],[3,1,7,8,4,9,2,6,5],[8,9,5,2,1,6,3,4,7],[6,4,2,7,3,5,8,9,1]]
726	[[2,3,7,8,4,5,6,1,9],[6,4,9,3,7,1,8,5,2],[1,8,5,9,2,6,3,4,7],[8,1,3,4,9,7,5,2,6],[9,5,6,1,3,2,4,7,8],[4,7,2,6,5,8,9,3,1],[7,9,8,5,1,3,2,6,4],[5,6,1,2,8,4,7,9,3],[3,2,4,7,6,9,1,8,5]]
727	[[9,6,8,5,2,3,1,7,4],[2,7,5,1,4,9,6,8,3],[1,3,4,7,6,8,2,5,9],[6,5,3,4,1,7,9,2,8],[4,9,2,6,8,5,3,1,7],[7,8,1,9,3,2,4,6,5],[8,4,7,2,9,6,5,3,1],[5,2,9,3,7,1,8,4,6],[3,1,6,8,5,4,7,9,2]]
728	[[1,8,6,3,4,7,2,5,9],[3,2,5,8,6,9,4,1,7],[4,9,7,5,2,1,6,3,8],[8,6,2,4,1,3,9,7,5],[9,5,3,7,8,6,1,2,4],[7,4,1,9,5,2,3,8,6],[5,1,4,6,3,8,7,9,2],[2,7,8,1,9,4,5,6,3],[6,3,9,2,7,5,8,4,1]]
729	[[4,8,1,3,9,5,7,2,6],[5,6,2,7,4,1,3,8,9],[3,9,7,8,6,2,4,1,5],[1,4,5,6,3,8,2,9,7],[6,2,8,9,1,7,5,3,4],[7,3,9,5,2,4,8,6,1],[2,7,6,1,5,3,9,4,8],[8,1,3,4,7,9,6,5,2],[9,5,4,2,8,6,1,7,3]]
730	[[3,6,4,9,7,5,8,2,1],[1,2,5,6,3,8,9,7,4],[8,9,7,1,4,2,6,3,5],[9,3,8,5,2,4,1,6,7],[7,1,2,3,9,6,5,4,8],[5,4,6,8,1,7,3,9,2],[4,8,1,2,6,3,7,5,9],[2,5,3,7,8,9,4,1,6],[6,7,9,4,5,1,2,8,3]]
731	[[2,6,1,5,9,4,8,7,3],[8,5,3,6,7,2,9,4,1],[4,9,7,1,3,8,6,2,5],[6,8,5,4,2,9,1,3,7],[7,4,9,3,1,6,5,8,2],[3,1,2,7,8,5,4,9,6],[9,3,4,2,5,1,7,6,8],[5,2,8,9,6,7,3,1,4],[1,7,6,8,4,3,2,5,9]]
732	[[4,3,6,2,7,8,1,5,9],[8,5,9,1,6,3,2,4,7],[1,2,7,5,9,4,8,6,3],[5,9,2,7,3,1,6,8,4],[3,1,8,4,2,6,9,7,5],[7,6,4,8,5,9,3,2,1],[9,7,3,6,8,5,4,1,2],[2,8,1,9,4,7,5,3,6],[6,4,5,3,1,2,7,9,8]]
733	[[5,9,4,2,6,7,3,1,8],[2,3,6,4,1,8,5,7,9],[7,8,1,3,5,9,2,4,6],[4,6,3,5,7,2,9,8,1],[8,5,7,1,9,3,6,2,4],[9,1,2,6,8,4,7,3,5],[1,7,5,8,2,6,4,9,3],[3,2,8,9,4,5,1,6,7],[6,4,9,7,3,1,8,5,2]]
734	[[7,9,2,8,3,6,4,5,1],[4,8,6,9,5,1,2,7,3],[3,1,5,2,4,7,8,9,6],[1,6,4,5,8,9,3,2,7],[2,3,8,1,7,4,9,6,5],[9,5,7,6,2,3,1,4,8],[6,2,9,7,1,8,5,3,4],[5,4,1,3,6,2,7,8,9],[8,7,3,4,9,5,6,1,2]]
735	[[5,9,8,3,4,7,6,2,1],[6,1,7,5,2,9,4,8,3],[4,2,3,8,6,1,9,7,5],[3,6,2,1,8,4,7,5,9],[9,8,1,7,3,5,2,4,6],[7,4,5,6,9,2,3,1,8],[8,7,6,2,1,3,5,9,4],[2,3,9,4,5,8,1,6,7],[1,5,4,9,7,6,8,3,2]]
736	[[2,5,1,7,9,4,6,3,8],[3,8,6,2,1,5,9,4,7],[9,4,7,6,3,8,2,5,1],[4,6,5,8,7,1,3,9,2],[1,7,2,9,4,3,5,8,6],[8,3,9,5,6,2,7,1,4],[7,9,8,1,5,6,4,2,3],[6,1,4,3,2,9,8,7,5],[5,2,3,4,8,7,1,6,9]]
737	[[7,9,1,6,3,5,4,8,2],[8,5,3,2,4,1,6,7,9],[4,6,2,8,9,7,1,5,3],[9,3,4,5,2,8,7,1,6],[1,8,5,3,7,6,9,2,4],[6,2,7,4,1,9,5,3,8],[2,7,8,1,6,4,3,9,5],[5,1,6,9,8,3,2,4,7],[3,4,9,7,5,2,8,6,1]]
738	[[2,7,4,5,9,6,3,1,8],[8,5,9,3,1,7,2,6,4],[3,1,6,2,4,8,7,5,9],[6,9,1,4,5,3,8,7,2],[4,2,3,8,7,1,6,9,5],[5,8,7,9,6,2,4,3,1],[1,4,2,6,3,5,9,8,7],[7,3,8,1,2,9,5,4,6],[9,6,5,7,8,4,1,2,3]]
739	[[6,5,9,7,2,4,8,1,3],[3,8,2,9,6,1,4,5,7],[4,7,1,8,3,5,2,6,9],[7,9,3,6,5,8,1,2,4],[5,1,6,3,4,2,9,7,8],[8,2,4,1,9,7,5,3,6],[1,4,7,2,8,6,3,9,5],[9,6,8,5,1,3,7,4,2],[2,3,5,4,7,9,6,8,1]]
740	[[1,7,5,8,9,3,4,2,6],[3,2,8,6,4,7,1,9,5],[6,4,9,2,5,1,8,7,3],[4,6,7,3,1,8,2,5,9],[9,5,2,4,7,6,3,1,8],[8,3,1,5,2,9,6,4,7],[5,8,4,7,3,2,9,6,1],[2,1,3,9,6,5,7,8,4],[7,9,6,1,8,4,5,3,2]]
741	[[1,3,2,5,4,7,6,8,9],[4,7,9,6,2,8,3,5,1],[5,6,8,1,9,3,2,7,4],[9,1,3,7,6,5,4,2,8],[6,4,5,2,8,1,9,3,7],[2,8,7,9,3,4,5,1,6],[3,5,6,8,7,9,1,4,2],[7,9,4,3,1,2,8,6,5],[8,2,1,4,5,6,7,9,3]]
742	[[6,3,1,7,9,8,2,4,5],[5,8,2,1,3,4,7,6,9],[4,9,7,6,5,2,1,8,3],[3,1,4,5,2,7,6,9,8],[7,2,5,9,8,6,3,1,4],[9,6,8,4,1,3,5,2,7],[8,4,3,2,7,1,9,5,6],[1,7,9,8,6,5,4,3,2],[2,5,6,3,4,9,8,7,1]]
743	[[5,4,3,1,6,7,9,2,8],[8,7,2,4,9,5,1,3,6],[1,9,6,2,3,8,7,4,5],[4,5,1,3,2,9,8,6,7],[6,2,9,8,7,4,3,5,1],[3,8,7,5,1,6,2,9,4],[7,1,4,9,5,3,6,8,2],[2,3,8,6,4,1,5,7,9],[9,6,5,7,8,2,4,1,3]]
744	[[7,5,1,2,8,4,6,3,9],[6,8,3,1,9,7,2,4,5],[4,9,2,5,6,3,8,7,1],[3,6,8,7,5,1,4,9,2],[2,7,9,4,3,6,5,1,8],[1,4,5,8,2,9,7,6,3],[5,1,6,3,4,2,9,8,7],[9,2,7,6,1,8,3,5,4],[8,3,4,9,7,5,1,2,6]]
745	[[8,7,5,9,2,1,3,6,4],[6,4,1,8,3,7,2,5,9],[2,9,3,4,6,5,1,7,8],[7,1,2,5,4,6,9,8,3],[4,5,9,3,1,8,6,2,7],[3,8,6,2,7,9,4,1,5],[9,2,8,6,5,4,7,3,1],[5,3,7,1,9,2,8,4,6],[1,6,4,7,8,3,5,9,2]]
746	[[8,9,5,4,3,2,7,1,6],[1,6,2,5,8,7,9,4,3],[3,7,4,6,9,1,2,8,5],[7,1,3,8,2,9,6,5,4],[4,5,9,7,6,3,1,2,8],[2,8,6,1,4,5,3,9,7],[9,4,1,3,5,6,8,7,2],[6,2,8,9,7,4,5,3,1],[5,3,7,2,1,8,4,6,9]]
747	[[7,8,6,9,2,5,1,3,4],[9,1,2,4,6,3,5,7,8],[5,3,4,7,8,1,9,2,6],[3,2,7,1,4,8,6,9,5],[1,9,5,2,3,6,8,4,7],[6,4,8,5,9,7,2,1,3],[4,5,3,6,1,2,7,8,9],[2,7,9,8,5,4,3,6,1],[8,6,1,3,7,9,4,5,2]]
748	[[9,7,4,2,8,1,3,6,5],[8,5,6,9,7,3,2,4,1],[1,3,2,4,6,5,9,8,7],[2,6,8,3,1,9,7,5,4],[5,1,9,7,4,2,8,3,6],[3,4,7,8,5,6,1,2,9],[6,2,5,1,9,8,4,7,3],[4,9,3,5,2,7,6,1,8],[7,8,1,6,3,4,5,9,2]]
749	[[1,6,4,3,7,5,9,8,2],[9,2,7,4,8,1,3,6,5],[5,8,3,2,9,6,4,1,7],[4,3,1,9,5,2,6,7,8],[2,5,9,7,6,8,1,3,4],[8,7,6,1,4,3,2,5,9],[7,1,5,6,2,4,8,9,3],[6,4,8,5,3,9,7,2,1],[3,9,2,8,1,7,5,4,6]]
750	[[1,3,5,4,7,9,8,2,6],[7,9,6,2,8,1,3,4,5],[2,8,4,5,3,6,7,9,1],[3,1,2,6,9,5,4,7,8],[8,4,7,1,2,3,5,6,9],[6,5,9,7,4,8,2,1,3],[4,6,8,9,5,2,1,3,7],[5,7,1,3,6,4,9,8,2],[9,2,3,8,1,7,6,5,4]]
751	[[3,1,9,8,4,7,2,6,5],[6,5,2,1,9,3,8,4,7],[7,8,4,5,6,2,9,3,1],[1,9,6,3,7,4,5,8,2],[8,3,7,2,5,6,1,9,4],[2,4,5,9,1,8,3,7,6],[4,2,3,7,8,5,6,1,9],[9,6,8,4,2,1,7,5,3],[5,7,1,6,3,9,4,2,8]]
752	[[5,1,7,8,9,6,4,3,2],[6,8,4,3,5,2,1,9,7],[2,9,3,4,1,7,6,8,5],[7,5,9,2,6,3,8,1,4],[4,3,6,5,8,1,7,2,9],[1,2,8,7,4,9,5,6,3],[3,6,2,1,7,4,9,5,8],[8,7,1,9,2,5,3,4,6],[9,4,5,6,3,8,2,7,1]]
753	[[8,2,3,1,4,6,5,7,9],[7,9,4,5,8,3,6,2,1],[5,6,1,7,9,2,8,4,3],[2,4,6,3,1,5,9,8,7],[9,7,5,4,2,8,1,3,6],[3,1,8,6,7,9,2,5,4],[1,8,2,9,3,4,7,6,5],[4,5,9,2,6,7,3,1,8],[6,3,7,8,5,1,4,9,2]]
754	[[4,2,7,1,9,3,6,8,5],[3,5,1,7,8,6,2,4,9],[9,6,8,5,4,2,3,1,7],[1,4,5,6,2,9,8,7,3],[6,7,3,8,5,1,9,2,4],[8,9,2,3,7,4,5,6,1],[2,3,4,9,1,8,7,5,6],[7,1,6,2,3,5,4,9,8],[5,8,9,4,6,7,1,3,2]]
755	[[1,8,2,3,5,4,9,7,6],[5,4,3,6,7,9,1,8,2],[7,6,9,8,2,1,4,5,3],[9,7,6,5,8,2,3,4,1],[4,2,8,9,1,3,7,6,5],[3,5,1,7,4,6,8,2,9],[8,9,5,2,3,7,6,1,4],[6,1,7,4,9,5,2,3,8],[2,3,4,1,6,8,5,9,7]]
756	[[2,8,9,5,6,3,7,1,4],[1,6,3,9,4,7,2,8,5],[7,4,5,2,8,1,9,6,3],[8,2,4,3,9,5,1,7,6],[5,7,1,6,2,8,4,3,9],[3,9,6,1,7,4,8,5,2],[6,3,8,4,1,2,5,9,7],[9,1,2,7,5,6,3,4,8],[4,5,7,8,3,9,6,2,1]]
757	[[7,1,6,5,9,8,2,4,3],[2,8,3,6,7,4,5,9,1],[9,4,5,3,1,2,6,8,7],[8,3,7,1,2,5,4,6,9],[1,6,2,9,4,3,7,5,8],[4,5,9,7,8,6,1,3,2],[6,9,8,2,5,7,3,1,4],[5,7,4,8,3,1,9,2,6],[3,2,1,4,6,9,8,7,5]]
758	[[7,4,1,2,6,3,9,8,5],[2,5,3,8,9,7,1,6,4],[9,8,6,5,4,1,7,2,3],[6,3,5,4,1,8,2,7,9],[4,2,9,6,7,5,3,1,8],[8,1,7,3,2,9,5,4,6],[5,9,4,1,8,2,6,3,7],[3,6,2,7,5,4,8,9,1],[1,7,8,9,3,6,4,5,2]]
759	[[4,9,8,5,7,3,1,6,2],[1,5,7,6,9,2,8,4,3],[3,2,6,8,1,4,5,9,7],[5,4,1,9,6,7,3,2,8],[6,7,3,2,8,1,4,5,9],[2,8,9,3,4,5,6,7,1],[9,6,4,7,3,8,2,1,5],[7,3,2,1,5,6,9,8,4],[8,1,5,4,2,9,7,3,6]]
760	[[9,5,7,3,2,4,8,6,1],[2,8,6,5,7,1,4,3,9],[1,4,3,9,8,6,2,5,7],[5,9,1,7,4,3,6,2,8],[6,3,2,8,1,9,7,4,5],[8,7,4,6,5,2,9,1,3],[4,2,8,1,3,7,5,9,6],[7,1,9,2,6,5,3,8,4],[3,6,5,4,9,8,1,7,2]]
761	[[4,5,7,1,3,9,2,6,8],[1,9,2,5,8,6,4,7,3],[3,6,8,4,2,7,5,1,9],[7,4,9,3,6,1,8,5,2],[8,3,5,2,7,4,1,9,6],[6,2,1,8,9,5,7,3,4],[9,1,6,7,4,2,3,8,5],[2,7,3,6,5,8,9,4,1],[5,8,4,9,1,3,6,2,7]]
762	[[5,6,9,2,1,4,3,7,8],[7,8,1,5,3,9,2,6,4],[3,2,4,6,7,8,1,5,9],[2,9,3,7,4,1,6,8,5],[1,7,6,8,5,2,4,9,3],[4,5,8,9,6,3,7,2,1],[8,1,7,3,9,6,5,4,2],[6,3,2,4,8,5,9,1,7],[9,4,5,1,2,7,8,3,6]]
763	[[7,2,1,3,6,5,8,4,9],[4,5,9,1,8,2,7,3,6],[8,3,6,9,4,7,1,2,5],[3,6,2,8,9,4,5,7,1],[5,9,4,2,7,1,6,8,3],[1,7,8,5,3,6,2,9,4],[6,8,7,4,1,3,9,5,2],[2,1,3,7,5,9,4,6,8],[9,4,5,6,2,8,3,1,7]]
764	[[3,6,8,2,7,4,9,1,5],[9,2,7,1,5,3,8,4,6],[5,1,4,8,6,9,3,2,7],[4,5,3,9,8,2,7,6,1],[1,7,9,3,4,6,5,8,2],[6,8,2,7,1,5,4,9,3],[8,3,1,4,2,7,6,5,9],[7,4,6,5,9,1,2,3,8],[2,9,5,6,3,8,1,7,4]]
765	[[9,3,6,1,5,4,7,2,8],[5,7,4,2,8,6,1,3,9],[2,8,1,3,9,7,4,5,6],[8,6,5,7,4,2,3,9,1],[4,9,3,6,1,8,5,7,2],[7,1,2,5,3,9,6,8,4],[1,4,7,8,2,5,9,6,3],[6,2,9,4,7,3,8,1,5],[3,5,8,9,6,1,2,4,7]]
766	[[2,7,5,4,9,6,8,1,3],[3,9,1,7,8,2,4,6,5],[4,6,8,3,5,1,7,2,9],[6,5,9,2,1,4,3,7,8],[7,8,3,9,6,5,2,4,1],[1,4,2,8,7,3,9,5,6],[8,1,4,5,2,9,6,3,7],[5,3,7,6,4,8,1,9,2],[9,2,6,1,3,7,5,8,4]]
767	[[3,7,9,2,1,4,5,8,6],[8,4,1,6,5,3,2,9,7],[6,5,2,9,8,7,1,3,4],[2,3,5,1,9,6,7,4,8],[1,9,7,8,4,2,6,5,3],[4,8,6,3,7,5,9,1,2],[7,1,4,5,6,8,3,2,9],[9,2,8,7,3,1,4,6,5],[5,6,3,4,2,9,8,7,1]]
768	[[8,9,3,7,5,2,1,4,6],[7,2,4,9,1,6,3,5,8],[5,6,1,3,8,4,2,7,9],[4,5,7,2,3,9,6,8,1],[9,3,8,6,7,1,4,2,5],[6,1,2,5,4,8,9,3,7],[3,7,6,4,9,5,8,1,2],[2,8,5,1,6,3,7,9,4],[1,4,9,8,2,7,5,6,3]]
769	[[1,5,9,4,7,8,2,6,3],[3,2,4,1,5,6,7,9,8],[6,7,8,9,2,3,1,4,5],[7,3,1,2,6,9,5,8,4],[8,9,6,5,4,7,3,2,1],[5,4,2,3,8,1,6,7,9],[4,8,7,6,3,5,9,1,2],[2,1,5,7,9,4,8,3,6],[9,6,3,8,1,2,4,5,7]]
770	[[5,7,8,1,3,4,6,2,9],[4,1,6,2,5,9,8,7,3],[2,3,9,7,6,8,1,5,4],[9,8,3,4,2,6,5,1,7],[7,2,4,8,1,5,9,3,6],[6,5,1,3,9,7,4,8,2],[1,4,7,9,8,2,3,6,5],[8,9,5,6,7,3,2,4,1],[3,6,2,5,4,1,7,9,8]]
771	[[3,1,8,2,7,4,5,9,6],[5,4,6,1,9,3,7,8,2],[2,7,9,8,5,6,4,1,3],[4,6,1,5,3,2,8,7,9],[7,5,3,9,8,1,2,6,4],[8,9,2,6,4,7,3,5,1],[6,2,4,7,1,8,9,3,5],[1,8,5,3,2,9,6,4,7],[9,3,7,4,6,5,1,2,8]]
772	[[3,4,9,2,5,6,8,1,7],[1,7,6,3,9,8,4,5,2],[8,5,2,1,4,7,6,9,3],[9,3,7,5,8,4,1,2,6],[5,6,1,7,2,9,3,8,4],[2,8,4,6,1,3,5,7,9],[7,2,8,4,3,1,9,6,5],[6,9,3,8,7,5,2,4,1],[4,1,5,9,6,2,7,3,8]]
773	[[4,7,9,5,6,2,3,1,8],[2,1,5,9,3,8,4,6,7],[8,6,3,7,4,1,2,5,9],[9,5,4,1,2,7,8,3,6],[6,2,1,4,8,3,9,7,5],[3,8,7,6,9,5,1,2,4],[7,4,6,3,1,9,5,8,2],[5,3,8,2,7,4,6,9,1],[1,9,2,8,5,6,7,4,3]]
774	[[6,5,3,4,8,7,2,1,9],[7,2,8,6,9,1,4,5,3],[1,4,9,2,5,3,8,6,7],[3,6,2,1,7,8,9,4,5],[4,9,7,5,2,6,1,3,8],[5,8,1,9,3,4,7,2,6],[2,7,4,3,6,9,5,8,1],[9,1,6,8,4,5,3,7,2],[8,3,5,7,1,2,6,9,4]]
775	[[9,1,6,8,3,2,5,4,7],[3,5,7,1,6,4,9,8,2],[4,2,8,7,5,9,3,6,1],[1,6,9,4,7,5,8,2,3],[5,7,3,2,9,8,4,1,6],[2,8,4,6,1,3,7,5,9],[7,9,2,5,4,6,1,3,8],[6,3,5,9,8,1,2,7,4],[8,4,1,3,2,7,6,9,5]]
776	[[3,1,6,2,4,8,7,5,9],[8,2,4,5,7,9,3,1,6],[5,7,9,1,3,6,4,8,2],[4,9,1,8,6,3,5,2,7],[2,3,5,7,1,4,9,6,8],[7,6,8,9,2,5,1,4,3],[9,8,2,3,5,1,6,7,4],[6,5,3,4,8,7,2,9,1],[1,4,7,6,9,2,8,3,5]]
777	[[1,3,5,7,6,8,9,4,2],[6,7,4,5,2,9,8,1,3],[9,8,2,1,3,4,6,5,7],[5,1,3,8,4,6,2,7,9],[2,6,8,9,1,7,5,3,4],[4,9,7,2,5,3,1,6,8],[7,5,1,3,9,2,4,8,6],[3,4,9,6,8,5,7,2,1],[8,2,6,4,7,1,3,9,5]]
778	[[5,8,4,1,6,9,7,2,3],[2,7,1,3,8,5,9,4,6],[6,3,9,2,4,7,8,5,1],[3,1,8,6,7,4,2,9,5],[4,2,5,8,9,1,6,3,7],[9,6,7,5,3,2,4,1,8],[1,4,3,7,2,6,5,8,9],[7,5,2,9,1,8,3,6,4],[8,9,6,4,5,3,1,7,2]]
779	[[3,8,5,4,7,9,1,2,6],[2,4,6,1,5,8,7,3,9],[9,7,1,3,2,6,4,5,8],[6,2,8,7,3,5,9,4,1],[1,9,7,6,4,2,5,8,3],[4,5,3,8,9,1,6,7,2],[8,3,4,9,1,7,2,6,5],[7,1,2,5,6,3,8,9,4],[5,6,9,2,8,4,3,1,7]]
780	[[3,8,4,2,7,6,1,5,9],[9,6,5,8,3,1,7,4,2],[2,7,1,4,9,5,6,3,8],[7,1,2,6,5,8,4,9,3],[5,9,6,3,4,2,8,7,1],[8,4,3,7,1,9,5,2,6],[1,3,7,9,6,4,2,8,5],[4,5,8,1,2,3,9,6,7],[6,2,9,5,8,7,3,1,4]]
781	[[6,9,4,1,3,7,8,2,5],[5,8,3,6,2,4,1,9,7],[1,2,7,8,9,5,3,4,6],[4,3,1,7,5,2,6,8,9],[7,5,8,3,6,9,2,1,4],[2,6,9,4,1,8,7,5,3],[9,1,2,5,7,3,4,6,8],[8,7,5,2,4,6,9,3,1],[3,4,6,9,8,1,5,7,2]]
782	[[3,5,2,4,8,1,9,6,7],[1,9,6,3,7,2,4,8,5],[8,7,4,5,9,6,1,3,2],[5,1,3,7,4,8,2,9,6],[9,4,7,6,2,3,5,1,8],[6,2,8,1,5,9,7,4,3],[2,6,5,9,3,4,8,7,1],[4,8,1,2,6,7,3,5,9],[7,3,9,8,1,5,6,2,4]]
783	[[8,1,4,3,6,2,5,7,9],[5,9,6,4,7,8,3,1,2],[7,2,3,5,9,1,4,8,6],[2,6,1,9,8,3,7,4,5],[9,4,8,6,5,7,1,2,3],[3,7,5,1,2,4,6,9,8],[4,5,7,2,3,9,8,6,1],[6,8,2,7,1,5,9,3,4],[1,3,9,8,4,6,2,5,7]]
784	[[1,3,2,7,6,5,9,4,8],[9,4,7,3,8,1,5,2,6],[5,6,8,9,2,4,1,3,7],[2,9,4,5,1,8,7,6,3],[6,5,3,2,7,9,8,1,4],[8,7,1,4,3,6,2,5,9],[3,1,6,8,9,2,4,7,5],[4,2,9,6,5,7,3,8,1],[7,8,5,1,4,3,6,9,2]]
785	[[2,1,7,3,6,8,9,4,5],[9,5,6,4,1,2,7,8,3],[8,3,4,5,9,7,6,2,1],[6,4,8,9,7,5,1,3,2],[1,9,5,6,2,3,4,7,8],[7,2,3,1,8,4,5,9,6],[3,7,9,2,5,1,8,6,4],[5,8,2,7,4,6,3,1,9],[4,6,1,8,3,9,2,5,7]]
786	[[5,1,2,4,7,6,3,8,9],[7,6,9,5,3,8,1,4,2],[4,8,3,2,9,1,5,7,6],[3,5,4,8,6,9,7,2,1],[2,7,6,1,4,3,9,5,8],[8,9,1,7,5,2,4,6,3],[6,3,7,9,8,5,2,1,4],[9,2,5,6,1,4,8,3,7],[1,4,8,3,2,7,6,9,5]]
787	[[1,8,2,6,7,5,9,3,4],[5,4,3,8,1,9,7,6,2],[7,9,6,3,2,4,1,5,8],[9,6,4,5,8,1,2,7,3],[8,2,5,7,9,3,4,1,6],[3,1,7,4,6,2,8,9,5],[2,3,1,9,4,6,5,8,7],[4,5,8,1,3,7,6,2,9],[6,7,9,2,5,8,3,4,1]]
788	[[9,2,5,6,3,4,7,8,1],[4,6,7,2,1,8,5,3,9],[3,1,8,7,5,9,4,6,2],[5,8,4,9,7,1,3,2,6],[2,7,1,3,4,6,8,9,5],[6,9,3,5,8,2,1,4,7],[7,5,6,8,2,3,9,1,4],[1,3,2,4,9,7,6,5,8],[8,4,9,1,6,5,2,7,3]]
789	[[6,1,4,5,8,3,2,7,9],[5,8,7,2,9,4,1,3,6],[3,2,9,6,7,1,4,5,8],[8,5,2,7,6,9,3,1,4],[7,6,1,3,4,2,8,9,5],[4,9,3,1,5,8,7,6,2],[9,4,5,8,1,7,6,2,3],[2,7,6,4,3,5,9,8,1],[1,3,8,9,2,6,5,4,7]]
790	[[6,9,1,4,7,2,5,3,8],[2,8,4,6,5,3,1,7,9],[3,7,5,9,1,8,2,4,6],[4,2,7,5,8,9,6,1,3],[8,5,6,7,3,1,4,9,2],[1,3,9,2,6,4,7,8,5],[9,4,3,1,2,6,8,5,7],[5,6,8,3,4,7,9,2,1],[7,1,2,8,9,5,3,6,4]]
791	[[7,2,8,6,3,5,9,1,4],[3,9,1,7,4,8,6,5,2],[5,6,4,9,2,1,3,7,8],[4,5,7,3,8,6,1,2,9],[1,3,2,5,9,4,8,6,7],[6,8,9,2,1,7,4,3,5],[8,7,3,1,5,9,2,4,6],[9,1,5,4,6,2,7,8,3],[2,4,6,8,7,3,5,9,1]]
792	[[3,6,9,7,5,8,2,1,4],[1,7,4,9,2,3,6,5,8],[5,8,2,1,6,4,7,3,9],[9,3,8,2,4,1,5,6,7],[6,1,7,5,8,9,4,2,3],[4,2,5,3,7,6,9,8,1],[2,4,6,8,1,7,3,9,5],[7,9,1,6,3,5,8,4,2],[8,5,3,4,9,2,1,7,6]]
793	[[5,6,7,9,2,3,4,1,8],[3,1,8,6,5,4,7,2,9],[2,4,9,8,1,7,3,5,6],[8,9,6,2,3,1,5,4,7],[4,2,5,7,9,6,1,8,3],[7,3,1,4,8,5,9,6,2],[1,8,3,5,7,2,6,9,4],[9,7,4,1,6,8,2,3,5],[6,5,2,3,4,9,8,7,1]]
794	[[4,3,9,5,6,2,1,7,8],[5,7,8,1,3,4,9,2,6],[1,2,6,7,9,8,3,4,5],[2,1,4,9,8,5,6,3,7],[7,6,5,2,1,3,4,8,9],[8,9,3,6,4,7,2,5,1],[3,4,1,8,7,9,5,6,2],[9,8,2,4,5,6,7,1,3],[6,5,7,3,2,1,8,9,4]]
795	[[1,4,3,6,2,5,8,9,7],[8,2,9,7,3,1,6,5,4],[5,7,6,9,4,8,1,2,3],[7,3,5,1,6,9,4,8,2],[4,9,1,2,8,7,3,6,5],[2,6,8,3,5,4,9,7,1],[6,1,2,5,9,3,7,4,8],[3,5,4,8,7,6,2,1,9],[9,8,7,4,1,2,5,3,6]]
796	[[4,3,2,6,7,1,5,9,8],[7,9,6,8,5,2,3,4,1],[8,5,1,4,9,3,7,2,6],[3,4,9,1,2,5,6,8,7],[5,2,7,9,6,8,1,3,4],[1,6,8,7,3,4,9,5,2],[2,7,3,5,4,6,8,1,9],[9,8,5,2,1,7,4,6,3],[6,1,4,3,8,9,2,7,5]]
797	[[9,7,2,6,3,8,4,1,5],[3,6,1,9,5,4,8,2,7],[4,5,8,1,2,7,3,9,6],[6,9,5,4,7,2,1,8,3],[7,8,4,3,6,1,9,5,2],[1,2,3,8,9,5,7,6,4],[8,1,7,5,4,6,2,3,9],[5,4,9,2,8,3,6,7,1],[2,3,6,7,1,9,5,4,8]]
798	[[8,3,5,4,7,9,6,1,2],[6,7,9,1,2,8,3,4,5],[2,1,4,6,5,3,7,8,9],[3,6,7,9,1,2,4,5,8],[4,9,8,3,6,5,1,2,7],[1,5,2,7,8,4,9,3,6],[9,8,1,5,3,7,2,6,4],[5,4,6,2,9,1,8,7,3],[7,2,3,8,4,6,5,9,1]]
799	[[6,1,8,4,7,5,2,3,9],[7,4,2,3,6,9,8,1,5],[3,5,9,1,2,8,4,6,7],[1,2,5,6,8,3,9,7,4],[4,9,6,5,1,7,3,2,8],[8,7,3,2,9,4,1,5,6],[2,8,4,7,5,1,6,9,3],[5,3,1,9,4,6,7,8,2],[9,6,7,8,3,2,5,4,1]]
800	[[8,9,7,1,3,2,6,4,5],[4,1,6,7,5,9,3,8,2],[2,3,5,4,8,6,9,1,7],[9,2,1,5,7,3,4,6,8],[5,8,3,2,6,4,1,7,9],[7,6,4,9,1,8,5,2,3],[1,4,9,8,2,5,7,3,6],[3,5,2,6,4,7,8,9,1],[6,7,8,3,9,1,2,5,4]]
801	[[3,6,2,5,7,4,9,8,1],[5,9,8,3,1,2,6,7,4],[1,7,4,9,6,8,3,5,2],[8,2,9,4,5,1,7,3,6],[4,1,5,7,3,6,2,9,8],[6,3,7,8,2,9,4,1,5],[2,5,6,1,9,3,8,4,7],[7,8,3,6,4,5,1,2,9],[9,4,1,2,8,7,5,6,3]]
802	[[3,4,6,8,5,9,1,7,2],[9,1,8,6,7,2,4,5,3],[5,7,2,4,3,1,9,6,8],[8,2,1,9,6,3,7,4,5],[7,6,3,5,2,4,8,1,9],[4,9,5,1,8,7,2,3,6],[6,3,9,7,1,8,5,2,4],[1,5,4,2,9,6,3,8,7],[2,8,7,3,4,5,6,9,1]]
803	[[9,6,2,1,5,8,4,7,3],[1,4,7,6,2,3,5,8,9],[5,8,3,4,9,7,6,1,2],[7,5,8,3,1,9,2,4,6],[6,3,4,5,8,2,7,9,1],[2,9,1,7,4,6,3,5,8],[3,7,5,9,6,1,8,2,4],[4,2,9,8,3,5,1,6,7],[8,1,6,2,7,4,9,3,5]]
804	[[5,7,2,3,6,8,1,9,4],[4,1,8,5,9,7,2,3,6],[6,3,9,2,1,4,5,8,7],[3,4,6,1,2,5,8,7,9],[1,9,7,6,8,3,4,5,2],[8,2,5,7,4,9,3,6,1],[2,8,3,9,7,1,6,4,5],[9,5,1,4,3,6,7,2,8],[7,6,4,8,5,2,9,1,3]]
805	[[4,9,8,6,7,3,5,2,1],[2,1,5,9,4,8,7,3,6],[7,3,6,5,2,1,4,9,8],[6,8,4,7,1,9,2,5,3],[1,7,3,4,5,2,6,8,9],[9,5,2,8,3,6,1,4,7],[5,6,9,2,8,7,3,1,4],[8,4,1,3,6,5,9,7,2],[3,2,7,1,9,4,8,6,5]]
806	[[6,7,1,4,2,9,5,3,8],[5,8,2,3,1,6,4,7,9],[9,3,4,7,8,5,1,6,2],[7,2,5,6,9,1,8,4,3],[4,9,8,5,3,2,7,1,6],[1,6,3,8,7,4,9,2,5],[8,1,9,2,6,7,3,5,4],[2,5,7,9,4,3,6,8,1],[3,4,6,1,5,8,2,9,7]]
807	[[2,5,9,1,4,7,8,3,6],[3,6,1,9,2,8,5,4,7],[8,4,7,5,6,3,1,9,2],[6,7,3,4,8,1,2,5,9],[9,8,4,2,5,6,7,1,3],[1,2,5,3,7,9,6,8,4],[7,9,2,8,3,5,4,6,1],[5,3,6,7,1,4,9,2,8],[4,1,8,6,9,2,3,7,5]]
808	[[4,5,9,6,8,7,1,2,3],[3,1,7,4,2,9,6,8,5],[6,8,2,5,1,3,4,9,7],[2,4,8,1,3,5,9,7,6],[5,9,1,7,6,2,8,3,4],[7,6,3,8,9,4,2,5,1],[9,2,5,3,4,1,7,6,8],[1,3,6,2,7,8,5,4,9],[8,7,4,9,5,6,3,1,2]]
809	[[7,6,2,1,3,5,8,4,9],[4,9,5,6,8,7,1,2,3],[1,8,3,2,4,9,5,6,7],[8,4,6,9,7,3,2,5,1],[2,3,9,5,1,8,6,7,4],[5,7,1,4,2,6,3,9,8],[9,1,4,3,5,2,7,8,6],[6,2,8,7,9,1,4,3,5],[3,5,7,8,6,4,9,1,2]]
810	[[1,4,9,7,2,5,6,3,8],[6,5,3,8,1,4,2,7,9],[2,8,7,9,3,6,5,4,1],[8,9,5,3,4,7,1,6,2],[4,7,6,2,8,1,3,9,5],[3,1,2,5,6,9,4,8,7],[9,3,1,4,7,2,8,5,6],[5,2,4,6,9,8,7,1,3],[7,6,8,1,5,3,9,2,4]]
811	[[3,5,2,4,9,1,6,7,8],[8,7,4,5,3,6,1,9,2],[6,1,9,8,2,7,5,3,4],[7,4,5,9,6,2,8,1,3],[9,3,6,1,5,8,4,2,7],[2,8,1,3,7,4,9,5,6],[1,6,7,2,4,5,3,8,9],[4,9,8,7,1,3,2,6,5],[5,2,3,6,8,9,7,4,1]]
812	[[9,7,5,2,8,6,1,4,3],[1,2,8,5,3,4,7,9,6],[4,3,6,9,1,7,5,8,2],[8,4,9,6,7,2,3,5,1],[3,5,7,1,4,9,2,6,8],[6,1,2,8,5,3,4,7,9],[5,9,1,7,2,8,6,3,4],[2,8,3,4,6,5,9,1,7],[7,6,4,3,9,1,8,2,5]]
813	[[9,3,2,1,6,4,5,7,8],[1,4,6,7,8,5,3,2,9],[5,8,7,2,3,9,6,4,1],[3,7,1,6,4,8,9,5,2],[6,5,8,9,2,3,4,1,7],[4,2,9,5,1,7,8,6,3],[2,1,4,3,9,6,7,8,5],[7,6,3,8,5,2,1,9,4],[8,9,5,4,7,1,2,3,6]]
814	[[7,2,9,6,4,1,8,3,5],[3,8,1,7,5,9,2,4,6],[5,4,6,3,8,2,9,7,1],[9,1,5,4,7,8,3,6,2],[2,3,8,9,1,6,4,5,7],[6,7,4,2,3,5,1,9,8],[4,6,3,1,2,7,5,8,9],[8,9,2,5,6,4,7,1,3],[1,5,7,8,9,3,6,2,4]]
815	[[2,3,8,7,4,6,9,1,5],[7,9,6,1,5,8,3,4,2],[1,5,4,3,9,2,8,6,7],[9,6,5,4,3,7,1,2,8],[8,2,1,9,6,5,4,7,3],[4,7,3,8,2,1,5,9,6],[5,4,7,2,8,9,6,3,1],[3,8,2,6,1,4,7,5,9],[6,1,9,5,7,3,2,8,4]]
816	[[7,3,1,9,8,4,2,6,5],[5,9,6,7,3,2,1,4,8],[2,4,8,5,1,6,7,9,3],[9,8,5,3,6,1,4,2,7],[6,2,7,8,4,9,3,5,1],[4,1,3,2,5,7,6,8,9],[8,5,2,4,7,3,9,1,6],[3,6,4,1,9,5,8,7,2],[1,7,9,6,2,8,5,3,4]]
817	[[1,6,4,9,8,3,2,7,5],[7,9,5,1,4,2,3,8,6],[8,3,2,7,6,5,4,9,1],[4,8,3,2,7,6,1,5,9],[5,1,9,8,3,4,6,2,7],[6,2,7,5,1,9,8,3,4],[9,5,8,6,2,1,7,4,3],[2,4,1,3,5,7,9,6,8],[3,7,6,4,9,8,5,1,2]]
818	[[2,5,1,7,9,4,6,3,8],[6,4,3,5,8,1,7,2,9],[7,8,9,6,2,3,1,5,4],[3,9,8,1,4,6,5,7,2],[1,2,7,9,3,5,4,8,6],[5,6,4,2,7,8,9,1,3],[8,7,6,3,1,9,2,4,5],[9,3,2,4,5,7,8,6,1],[4,1,5,8,6,2,3,9,7]]
819	[[8,6,4,2,7,1,3,9,5],[3,5,9,4,6,8,1,2,7],[2,7,1,3,9,5,6,4,8],[4,9,2,5,8,6,7,1,3],[6,3,7,1,4,2,8,5,9],[5,1,8,9,3,7,2,6,4],[7,4,3,6,1,9,5,8,2],[9,2,6,8,5,3,4,7,1],[1,8,5,7,2,4,9,3,6]]
820	[[1,3,4,7,6,2,8,5,9],[9,2,6,8,1,5,7,4,3],[7,5,8,3,9,4,2,1,6],[6,4,2,1,5,9,3,8,7],[8,9,3,2,4,7,1,6,5],[5,7,1,6,8,3,9,2,4],[3,8,7,4,2,6,5,9,1],[2,6,9,5,7,1,4,3,8],[4,1,5,9,3,8,6,7,2]]
821	[[5,7,4,2,1,3,9,6,8],[9,8,3,4,5,6,1,7,2],[1,6,2,8,7,9,4,3,5],[6,4,7,5,3,8,2,9,1],[2,1,8,6,9,7,3,5,4],[3,9,5,1,4,2,6,8,7],[7,3,1,9,2,5,8,4,6],[4,5,6,3,8,1,7,2,9],[8,2,9,7,6,4,5,1,3]]
822	[[2,4,8,5,3,6,7,1,9],[3,9,5,1,7,2,8,6,4],[1,6,7,8,4,9,2,5,3],[7,2,1,6,9,4,5,3,8],[6,8,9,3,1,5,4,7,2],[5,3,4,7,2,8,6,9,1],[9,5,6,4,8,3,1,2,7],[8,1,3,2,5,7,9,4,6],[4,7,2,9,6,1,3,8,5]]
823	[[6,1,7,8,4,3,5,9,2],[4,8,3,2,9,5,1,7,6],[2,5,9,7,6,1,3,4,8],[3,2,6,5,8,4,9,1,7],[9,7,5,1,2,6,4,8,3],[8,4,1,3,7,9,6,2,5],[1,6,8,4,5,7,2,3,9],[7,9,4,6,3,2,8,5,1],[5,3,2,9,1,8,7,6,4]]
824	[[7,1,5,6,2,4,9,8,3],[4,6,3,1,8,9,7,5,2],[8,2,9,3,5,7,4,1,6],[5,3,2,4,9,6,8,7,1],[9,7,6,8,1,2,5,3,4],[1,4,8,7,3,5,2,6,9],[2,5,1,9,6,8,3,4,7],[3,9,4,5,7,1,6,2,8],[6,8,7,2,4,3,1,9,5]]
825	[[2,9,4,6,5,1,7,3,8],[6,5,7,3,8,9,1,2,4],[1,8,3,4,7,2,9,5,6],[4,7,5,2,9,3,6,8,1],[9,3,6,8,1,5,2,4,7],[8,1,2,7,6,4,3,9,5],[3,6,8,5,2,7,4,1,9],[7,2,1,9,4,8,5,6,3],[5,4,9,1,3,6,8,7,2]]
826	[[2,1,9,7,8,5,6,3,4],[7,6,8,4,1,3,9,5,2],[4,5,3,6,2,9,7,1,8],[8,4,5,1,7,6,3,2,9],[9,2,7,3,5,8,4,6,1],[1,3,6,2,9,4,5,8,7],[3,9,2,5,4,1,8,7,6],[6,7,4,8,3,2,1,9,5],[5,8,1,9,6,7,2,4,3]]
827	[[4,3,9,1,7,2,5,6,8],[1,6,8,4,9,5,7,2,3],[7,2,5,8,6,3,1,4,9],[9,8,1,7,2,4,6,3,5],[3,4,7,6,5,9,2,8,1],[6,5,2,3,1,8,4,9,7],[8,1,4,2,3,7,9,5,6],[5,7,3,9,4,6,8,1,2],[2,9,6,5,8,1,3,7,4]]
828	[[5,3,7,6,1,4,8,2,9],[6,1,8,2,5,9,4,3,7],[9,4,2,8,7,3,6,5,1],[7,6,4,3,9,1,2,8,5],[8,9,1,5,4,2,3,7,6],[3,2,5,7,8,6,9,1,4],[2,7,6,9,3,5,1,4,8],[4,5,9,1,2,8,7,6,3],[1,8,3,4,6,7,5,9,2]]
829	[[5,3,9,6,4,1,8,7,2],[4,6,8,9,7,2,1,3,5],[7,1,2,3,5,8,9,4,6],[1,7,4,5,6,3,2,8,9],[9,2,6,7,8,4,3,5,1],[3,8,5,1,2,9,4,6,7],[2,9,7,4,3,5,6,1,8],[6,4,1,8,9,7,5,2,3],[8,5,3,2,1,6,7,9,4]]
830	[[3,6,5,4,2,9,8,7,1],[2,9,8,7,1,3,4,6,5],[1,7,4,6,8,5,9,2,3],[5,8,6,9,4,1,2,3,7],[4,1,2,8,3,7,6,5,9],[7,3,9,5,6,2,1,8,4],[6,5,7,2,9,4,3,1,8],[8,4,1,3,7,6,5,9,2],[9,2,3,1,5,8,7,4,6]]
831	[[5,7,1,9,4,3,6,2,8],[6,8,3,5,1,2,4,9,7],[2,4,9,8,6,7,3,5,1],[3,1,2,7,8,9,5,4,6],[9,5,4,1,3,6,8,7,2],[8,6,7,2,5,4,9,1,3],[1,9,6,3,7,5,2,8,4],[7,3,5,4,2,8,1,6,9],[4,2,8,6,9,1,7,3,5]]
832	[[5,1,8,2,3,6,4,9,7],[6,2,3,7,9,4,1,8,5],[9,4,7,5,1,8,2,6,3],[3,6,9,4,5,1,8,7,2],[8,7,1,6,2,9,5,3,4],[2,5,4,8,7,3,9,1,6],[1,3,5,9,6,2,7,4,8],[7,8,6,1,4,5,3,2,9],[4,9,2,3,8,7,6,5,1]]
833	[[6,4,1,8,2,3,7,9,5],[3,8,9,7,1,5,6,4,2],[5,7,2,6,4,9,1,8,3],[4,2,3,5,6,1,8,7,9],[7,1,5,9,8,2,4,3,6],[9,6,8,3,7,4,2,5,1],[1,3,4,2,5,7,9,6,8],[2,9,6,4,3,8,5,1,7],[8,5,7,1,9,6,3,2,4]]
834	[[9,1,6,5,4,2,3,7,8],[5,8,3,1,6,7,2,9,4],[7,2,4,8,3,9,6,1,5],[6,4,1,7,9,8,5,3,2],[3,9,5,2,1,6,4,8,7],[8,7,2,3,5,4,9,6,1],[2,5,7,6,8,3,1,4,9],[1,6,9,4,7,5,8,2,3],[4,3,8,9,2,1,7,5,6]]
835	[[4,1,6,9,8,7,2,3,5],[8,2,7,3,5,6,9,1,4],[3,9,5,4,1,2,7,8,6],[5,8,4,1,7,3,6,2,9],[1,7,2,8,6,9,4,5,3],[6,3,9,5,2,4,8,7,1],[2,6,3,7,4,5,1,9,8],[7,5,8,6,9,1,3,4,2],[9,4,1,2,3,8,5,6,7]]
836	[[8,2,6,5,7,3,9,4,1],[7,3,5,4,1,9,6,2,8],[1,4,9,8,2,6,5,3,7],[3,6,1,2,9,8,7,5,4],[4,9,2,7,6,5,8,1,3],[5,8,7,1,3,4,2,6,9],[6,1,3,9,5,7,4,8,2],[9,5,8,3,4,2,1,7,6],[2,7,4,6,8,1,3,9,5]]
837	[[4,3,7,2,5,6,1,8,9],[2,8,9,4,7,1,3,5,6],[5,1,6,8,3,9,4,2,7],[6,4,8,9,1,5,7,3,2],[9,2,1,3,8,7,5,6,4],[7,5,3,6,4,2,9,1,8],[3,7,4,5,6,8,2,9,1],[8,9,5,1,2,4,6,7,3],[1,6,2,7,9,3,8,4,5]]
838	[[4,2,8,5,7,1,6,3,9],[6,3,7,9,8,4,2,1,5],[1,9,5,2,6,3,8,4,7],[3,8,9,4,2,7,5,6,1],[5,1,2,6,3,9,4,7,8],[7,6,4,8,1,5,9,2,3],[9,4,3,7,5,6,1,8,2],[2,7,6,1,9,8,3,5,4],[8,5,1,3,4,2,7,9,6]]
839	[[6,9,8,5,3,7,1,2,4],[3,4,1,6,8,2,7,9,5],[2,5,7,1,9,4,8,6,3],[9,7,6,4,5,8,2,3,1],[8,1,2,9,7,3,4,5,6],[4,3,5,2,6,1,9,8,7],[1,6,4,3,2,9,5,7,8],[7,2,3,8,1,5,6,4,9],[5,8,9,7,4,6,3,1,2]]
840	[[1,7,4,8,2,3,6,5,9],[3,5,6,1,7,9,8,4,2],[8,2,9,5,4,6,1,3,7],[5,3,8,2,6,4,7,9,1],[7,9,1,3,5,8,4,2,6],[4,6,2,7,9,1,5,8,3],[9,8,7,4,1,2,3,6,5],[2,1,3,6,8,5,9,7,4],[6,4,5,9,3,7,2,1,8]]
841	[[3,6,8,7,4,1,9,5,2],[9,7,2,3,6,5,8,4,1],[4,5,1,8,9,2,3,7,6],[7,8,6,2,5,9,1,3,4],[2,9,3,4,1,7,6,8,5],[5,1,4,6,3,8,7,2,9],[6,2,7,1,8,4,5,9,3],[8,3,5,9,2,6,4,1,7],[1,4,9,5,7,3,2,6,8]]
842	[[8,1,7,6,5,3,2,9,4],[4,2,5,9,8,1,6,7,3],[6,9,3,2,7,4,8,5,1],[9,7,8,1,2,6,4,3,5],[1,5,2,3,4,7,9,6,8],[3,4,6,8,9,5,1,2,7],[7,8,4,5,6,9,3,1,2],[5,3,9,4,1,2,7,8,6],[2,6,1,7,3,8,5,4,9]]
843	[[7,2,3,9,6,5,4,1,8],[6,5,8,7,4,1,3,9,2],[4,1,9,2,8,3,7,6,5],[9,6,2,8,3,4,1,5,7],[3,7,5,6,1,2,9,8,4],[1,8,4,5,7,9,2,3,6],[8,3,6,1,2,7,5,4,9],[2,9,1,4,5,6,8,7,3],[5,4,7,3,9,8,6,2,1]]
844	[[1,6,2,3,4,7,8,5,9],[4,7,5,2,9,8,1,3,6],[3,9,8,5,1,6,4,2,7],[6,3,4,9,2,1,5,7,8],[5,8,1,7,6,3,2,9,4],[9,2,7,4,8,5,3,6,1],[8,4,3,6,5,9,7,1,2],[2,5,9,1,7,4,6,8,3],[7,1,6,8,3,2,9,4,5]]
845	[[7,3,8,9,1,6,5,4,2],[1,9,4,2,3,5,6,8,7],[6,5,2,4,7,8,3,1,9],[9,4,7,6,2,1,8,3,5],[2,1,6,8,5,3,7,9,4],[3,8,5,7,4,9,2,6,1],[8,6,1,5,9,2,4,7,3],[5,7,9,3,6,4,1,2,8],[4,2,3,1,8,7,9,5,6]]
846	[[7,2,8,4,5,3,1,6,9],[4,6,1,2,8,9,7,3,5],[5,9,3,7,1,6,8,2,4],[3,7,4,9,6,2,5,8,1],[8,1,6,3,4,5,2,9,7],[2,5,9,8,7,1,3,4,6],[9,3,5,1,2,4,6,7,8],[1,4,7,6,3,8,9,5,2],[6,8,2,5,9,7,4,1,3]]
847	[[7,2,4,1,6,8,3,5,9],[8,1,5,7,3,9,6,4,2],[3,9,6,2,4,5,8,1,7],[2,4,8,6,1,7,5,9,3],[1,6,7,5,9,3,2,8,4],[9,5,3,4,8,2,7,6,1],[4,7,9,3,5,6,1,2,8],[5,3,1,8,2,4,9,7,6],[6,8,2,9,7,1,4,3,5]]
848	[[5,9,6,8,2,1,7,3,4],[4,7,2,9,5,3,6,1,8],[3,8,1,4,7,6,9,5,2],[7,6,4,5,1,8,2,9,3],[8,1,9,3,4,2,5,7,6],[2,3,5,7,6,9,8,4,1],[9,5,3,6,8,4,1,2,7],[6,2,7,1,3,5,4,8,9],[1,4,8,2,9,7,3,6,5]]
849	[[7,1,6,9,4,3,8,5,2],[5,3,4,8,2,1,9,7,6],[8,2,9,6,5,7,4,1,3],[2,9,1,3,7,6,5,4,8],[4,6,7,5,8,2,3,9,1],[3,8,5,1,9,4,2,6,7],[6,4,2,7,3,5,1,8,9],[1,5,8,2,6,9,7,3,4],[9,7,3,4,1,8,6,2,5]]
850	[[9,8,3,5,1,6,2,4,7],[5,4,7,9,3,2,1,8,6],[6,2,1,8,7,4,5,3,9],[4,7,6,2,8,1,9,5,3],[1,3,5,6,9,7,4,2,8],[2,9,8,4,5,3,6,7,1],[7,5,4,1,6,8,3,9,2],[8,6,9,3,2,5,7,1,4],[3,1,2,7,4,9,8,6,5]]
851	[[2,8,9,4,6,7,5,1,3],[4,3,1,5,2,9,6,7,8],[6,7,5,8,1,3,4,9,2],[7,9,4,3,5,8,2,6,1],[5,1,8,6,7,2,9,3,4],[3,6,2,9,4,1,8,5,7],[1,4,6,2,3,5,7,8,9],[8,2,3,7,9,6,1,4,5],[9,5,7,1,8,4,3,2,6]]
852	[[5,8,2,6,1,9,3,7,4],[9,1,6,4,7,3,5,8,2],[4,3,7,2,8,5,6,1,9],[1,9,4,7,6,8,2,5,3],[2,6,8,5,3,1,4,9,7],[3,7,5,9,4,2,1,6,8],[6,2,9,8,5,4,7,3,1],[7,4,1,3,9,6,8,2,5],[8,5,3,1,2,7,9,4,6]]
853	[[3,2,7,8,4,6,5,1,9],[6,4,9,5,1,7,2,8,3],[8,1,5,3,9,2,4,6,7],[2,5,6,7,3,8,1,9,4],[4,7,3,1,2,9,6,5,8],[1,9,8,4,6,5,3,7,2],[7,8,1,2,5,4,9,3,6],[9,3,4,6,8,1,7,2,5],[5,6,2,9,7,3,8,4,1]]
854	[[4,5,2,1,8,3,6,7,9],[1,9,8,6,4,7,3,5,2],[7,6,3,5,9,2,8,1,4],[6,3,4,7,5,9,2,8,1],[5,2,7,8,6,1,4,9,3],[8,1,9,3,2,4,5,6,7],[2,7,5,9,3,6,1,4,8],[9,4,6,2,1,8,7,3,5],[3,8,1,4,7,5,9,2,6]]
855	[[1,7,8,6,3,5,4,2,9],[5,9,3,8,4,2,6,1,7],[4,2,6,9,7,1,3,5,8],[8,3,9,1,2,6,7,4,5],[7,1,5,3,9,4,2,8,6],[6,4,2,5,8,7,1,9,3],[3,5,4,7,1,9,8,6,2],[2,6,7,4,5,8,9,3,1],[9,8,1,2,6,3,5,7,4]]
856	[[6,8,5,3,2,4,7,1,9],[4,7,2,5,1,9,8,3,6],[1,9,3,7,6,8,4,5,2],[8,3,1,9,7,6,2,4,5],[5,6,4,2,8,1,3,9,7],[9,2,7,4,3,5,6,8,1],[7,5,8,1,4,2,9,6,3],[3,4,9,6,5,7,1,2,8],[2,1,6,8,9,3,5,7,4]]
857	[[9,6,4,1,2,5,7,3,8],[2,8,3,7,6,9,4,1,5],[1,7,5,8,4,3,2,6,9],[7,3,9,6,1,4,8,5,2],[5,2,6,3,9,8,1,4,7],[4,1,8,5,7,2,6,9,3],[8,4,2,9,5,6,3,7,1],[3,5,1,4,8,7,9,2,6],[6,9,7,2,3,1,5,8,4]]
858	[[7,5,3,9,6,1,2,4,8],[4,8,1,5,2,7,3,6,9],[2,6,9,8,3,4,1,5,7],[5,4,8,3,1,9,6,7,2],[1,9,7,2,8,6,4,3,5],[3,2,6,7,4,5,8,9,1],[6,1,5,4,9,8,7,2,3],[9,3,4,1,7,2,5,8,6],[8,7,2,6,5,3,9,1,4]]
859	[[9,8,5,2,6,7,3,1,4],[7,3,6,1,4,9,5,8,2],[2,1,4,3,8,5,6,7,9],[1,4,3,8,2,6,9,5,7],[6,2,9,5,7,3,1,4,8],[5,7,8,9,1,4,2,6,3],[4,5,1,7,9,2,8,3,6],[8,9,7,6,3,1,4,2,5],[3,6,2,4,5,8,7,9,1]]
860	[[7,6,4,2,3,5,8,9,1],[9,8,5,4,6,1,2,7,3],[3,2,1,7,8,9,5,6,4],[5,7,3,8,1,4,6,2,9],[6,4,2,3,9,7,1,5,8],[1,9,8,5,2,6,4,3,7],[8,5,9,1,7,2,3,4,6],[2,3,6,9,4,8,7,1,5],[4,1,7,6,5,3,9,8,2]]
861	[[5,4,3,1,8,7,2,9,6],[8,2,1,9,6,3,5,4,7],[9,6,7,4,2,5,3,8,1],[3,7,4,2,9,1,6,5,8],[6,8,5,7,3,4,1,2,9],[2,1,9,6,5,8,7,3,4],[4,3,6,8,7,2,9,1,5],[7,5,8,3,1,9,4,6,2],[1,9,2,5,4,6,8,7,3]]
862	[[7,4,3,1,2,6,5,8,9],[8,5,6,7,9,4,1,2,3],[9,1,2,5,8,3,4,6,7],[4,2,9,8,3,5,7,1,6],[1,3,8,4,6,7,9,5,2],[6,7,5,2,1,9,3,4,8],[2,9,7,6,4,1,8,3,5],[3,6,4,9,5,8,2,7,1],[5,8,1,3,7,2,6,9,4]]
863	[[9,2,8,1,6,4,7,3,5],[6,5,4,3,7,8,1,9,2],[7,1,3,5,2,9,6,4,8],[3,8,2,6,4,5,9,7,1],[5,9,6,7,1,3,8,2,4],[1,4,7,9,8,2,5,6,3],[8,6,5,2,3,7,4,1,9],[2,7,9,4,5,1,3,8,6],[4,3,1,8,9,6,2,5,7]]
864	[[3,2,8,7,4,9,1,6,5],[5,6,9,2,1,3,4,8,7],[7,4,1,5,8,6,3,2,9],[9,7,4,1,6,2,8,5,3],[6,5,3,4,9,8,2,7,1],[1,8,2,3,5,7,6,9,4],[2,1,5,8,7,4,9,3,6],[8,9,7,6,3,1,5,4,2],[4,3,6,9,2,5,7,1,8]]
865	[[9,2,5,3,8,1,7,6,4],[3,8,7,5,4,6,1,9,2],[6,4,1,7,2,9,3,5,8],[7,9,4,6,3,8,2,1,5],[1,5,3,4,9,2,8,7,6],[2,6,8,1,5,7,9,4,3],[4,1,2,9,6,3,5,8,7],[5,3,9,8,7,4,6,2,1],[8,7,6,2,1,5,4,3,9]]
866	[[8,6,9,5,7,3,1,2,4],[1,7,3,6,2,4,5,9,8],[2,4,5,1,9,8,7,3,6],[5,1,2,9,6,7,8,4,3],[3,8,7,4,1,2,6,5,9],[4,9,6,3,8,5,2,7,1],[6,3,4,2,5,1,9,8,7],[7,5,1,8,4,9,3,6,2],[9,2,8,7,3,6,4,1,5]]
867	[[2,6,3,5,4,1,9,8,7],[5,4,9,7,8,3,1,6,2],[1,8,7,9,2,6,4,3,5],[7,1,6,3,5,4,8,2,9],[3,2,8,1,9,7,5,4,6],[9,5,4,8,6,2,7,1,3],[8,9,2,6,1,5,3,7,4],[6,3,1,4,7,9,2,5,8],[4,7,5,2,3,8,6,9,1]]
868	[[4,6,7,9,1,5,8,2,3],[9,2,8,3,7,6,4,5,1],[3,1,5,4,2,8,9,7,6],[2,8,6,5,9,1,3,4,7],[1,4,3,2,6,7,5,8,9],[7,5,9,8,4,3,1,6,2],[8,9,4,6,3,2,7,1,5],[6,3,1,7,5,4,2,9,8],[5,7,2,1,8,9,6,3,4]]
869	[[8,3,4,1,9,6,2,7,5],[7,9,5,8,2,3,6,4,1],[1,6,2,5,4,7,3,8,9],[6,5,9,7,3,4,1,2,8],[2,7,8,9,6,1,5,3,4],[4,1,3,2,8,5,9,6,7],[3,8,1,6,7,9,4,5,2],[9,2,6,4,5,8,7,1,3],[5,4,7,3,1,2,8,9,6]]
870	[[2,5,7,1,6,8,3,4,9],[3,9,8,2,4,5,1,6,7],[4,6,1,3,9,7,2,8,5],[8,3,5,9,2,6,7,1,4],[7,2,4,8,1,3,5,9,6],[9,1,6,5,7,4,8,3,2],[1,4,3,6,5,2,9,7,8],[5,7,9,4,8,1,6,2,3],[6,8,2,7,3,9,4,5,1]]
871	[[4,5,8,3,2,9,6,7,1],[2,1,7,4,8,6,3,9,5],[3,6,9,5,1,7,4,8,2],[1,2,3,9,4,8,7,5,6],[9,8,5,7,6,3,2,1,4],[7,4,6,2,5,1,8,3,9],[6,3,2,8,9,5,1,4,7],[8,9,4,1,7,2,5,6,3],[5,7,1,6,3,4,9,2,8]]
872	[[9,8,3,4,6,5,2,7,1],[7,2,4,1,8,3,6,5,9],[5,1,6,2,9,7,8,4,3],[6,4,2,9,5,8,1,3,7],[8,9,7,3,1,4,5,6,2],[1,3,5,6,7,2,4,9,8],[2,6,1,7,4,9,3,8,5],[3,7,8,5,2,6,9,1,4],[4,5,9,8,3,1,7,2,6]]
873	[[4,6,1,3,9,2,5,8,7],[2,7,5,8,1,6,3,4,9],[8,3,9,4,5,7,1,2,6],[7,4,6,1,2,3,9,5,8],[1,2,3,9,8,5,7,6,4],[9,5,8,6,7,4,2,1,3],[5,9,2,7,4,8,6,3,1],[6,1,4,2,3,9,8,7,5],[3,8,7,5,6,1,4,9,2]]
874	[[6,9,1,3,4,8,5,7,2],[3,7,2,5,9,6,4,8,1],[5,8,4,2,1,7,3,6,9],[9,3,7,4,8,2,1,5,6],[8,4,6,1,7,5,9,2,3],[1,2,5,6,3,9,8,4,7],[4,6,3,7,5,1,2,9,8],[7,5,9,8,2,3,6,1,4],[2,1,8,9,6,4,7,3,5]]
875	[[9,2,6,5,1,3,8,4,7],[1,7,8,4,9,2,3,6,5],[5,3,4,8,6,7,2,9,1],[4,1,3,2,8,6,7,5,9],[7,9,2,1,4,5,6,8,3],[8,6,5,3,7,9,1,2,4],[6,8,7,9,5,1,4,3,2],[3,4,9,7,2,8,5,1,6],[2,5,1,6,3,4,9,7,8]]
876	[[4,6,9,7,2,3,1,5,8],[3,8,2,5,1,6,9,7,4],[5,7,1,8,4,9,3,6,2],[6,9,3,1,5,2,8,4,7],[8,4,5,3,6,7,2,1,9],[2,1,7,4,9,8,5,3,6],[1,3,8,2,7,4,6,9,5],[7,5,6,9,8,1,4,2,3],[9,2,4,6,3,5,7,8,1]]
877	[[2,6,5,7,4,1,9,3,8],[8,1,3,9,2,5,6,4,7],[4,9,7,8,3,6,5,1,2],[3,5,4,2,8,7,1,6,9],[7,8,6,3,1,9,2,5,4],[9,2,1,6,5,4,7,8,3],[6,3,8,1,9,2,4,7,5],[1,4,2,5,7,8,3,9,6],[5,7,9,4,6,3,8,2,1]]
878	[[9,7,1,8,4,6,5,3,2],[6,3,8,1,5,2,4,9,7],[5,2,4,3,9,7,6,1,8],[8,6,5,4,3,1,2,7,9],[2,4,7,6,8,9,3,5,1],[1,9,3,2,7,5,8,6,4],[4,1,2,7,6,3,9,8,5],[7,5,6,9,2,8,1,4,3],[3,8,9,5,1,4,7,2,6]]
879	[[6,8,5,7,3,9,2,1,4],[2,9,3,4,1,8,5,6,7],[1,4,7,2,5,6,8,3,9],[3,6,8,5,4,1,9,7,2],[9,5,2,3,6,7,1,4,8],[4,7,1,9,8,2,3,5,6],[7,1,4,8,9,3,6,2,5],[5,3,9,6,2,4,7,8,1],[8,2,6,1,7,5,4,9,3]]
880	[[3,4,8,1,5,7,9,6,2],[7,6,9,8,2,3,1,5,4],[5,1,2,6,4,9,7,3,8],[6,3,1,2,8,4,5,7,9],[4,9,7,3,1,5,2,8,6],[8,2,5,7,9,6,3,4,1],[2,7,3,4,6,1,8,9,5],[9,8,6,5,3,2,4,1,7],[1,5,4,9,7,8,6,2,3]]
881	[[9,1,7,3,4,5,6,2,8],[5,4,6,2,7,8,9,3,1],[8,2,3,9,6,1,7,5,4],[7,3,9,8,1,4,2,6,5],[1,5,2,6,9,7,8,4,3],[4,6,8,5,2,3,1,7,9],[2,8,5,7,3,9,4,1,6],[6,9,1,4,5,2,3,8,7],[3,7,4,1,8,6,5,9,2]]
882	[[4,2,7,3,1,6,8,5,9],[3,8,6,2,5,9,1,7,4],[5,9,1,4,7,8,3,2,6],[6,5,9,8,2,1,4,3,7],[7,1,3,9,4,5,2,6,8],[2,4,8,7,6,3,9,1,5],[1,6,4,5,9,2,7,8,3],[8,7,5,1,3,4,6,9,2],[9,3,2,6,8,7,5,4,1]]
883	[[4,8,2,7,5,1,6,3,9],[9,1,6,2,8,3,4,5,7],[3,5,7,6,4,9,1,2,8],[7,6,9,1,2,4,3,8,5],[2,3,1,8,9,5,7,6,4],[5,4,8,3,6,7,9,1,2],[1,2,4,5,7,6,8,9,3],[8,9,3,4,1,2,5,7,6],[6,7,5,9,3,8,2,4,1]]
884	[[3,9,7,4,1,8,6,2,5],[1,5,4,2,6,3,7,8,9],[2,8,6,5,9,7,1,3,4],[5,4,3,8,2,1,9,7,6],[6,7,2,9,3,4,8,5,1],[8,1,9,6,7,5,3,4,2],[4,6,8,3,5,9,2,1,7],[9,3,1,7,4,2,5,6,8],[7,2,5,1,8,6,4,9,3]]
885	[[4,7,8,6,9,5,3,1,2],[9,2,1,8,3,4,6,5,7],[6,3,5,7,1,2,8,4,9],[5,8,4,3,2,6,7,9,1],[2,6,9,1,8,7,5,3,4],[7,1,3,4,5,9,2,6,8],[3,5,2,9,4,8,1,7,6],[8,4,7,5,6,1,9,2,3],[1,9,6,2,7,3,4,8,5]]
886	[[1,8,9,4,7,5,3,2,6],[6,4,3,2,8,1,9,7,5],[7,5,2,6,9,3,4,1,8],[5,1,6,7,3,8,2,4,9],[4,3,8,9,6,2,1,5,7],[9,2,7,1,5,4,6,8,3],[3,7,4,5,1,6,8,9,2],[8,9,1,3,2,7,5,6,4],[2,6,5,8,4,9,7,3,1]]
887	[[3,2,5,7,1,9,4,6,8],[4,6,9,5,3,8,2,1,7],[1,7,8,4,2,6,3,5,9],[6,4,1,9,7,2,8,3,5],[8,3,2,6,5,4,7,9,1],[9,5,7,1,8,3,6,2,4],[2,1,3,8,4,5,9,7,6],[7,9,4,3,6,1,5,8,2],[5,8,6,2,9,7,1,4,3]]
888	[[3,5,9,1,4,2,7,8,6],[7,4,8,9,6,3,1,5,2],[6,1,2,7,5,8,3,9,4],[4,8,7,5,3,1,6,2,9],[5,3,1,6,2,9,4,7,8],[2,9,6,4,8,7,5,1,3],[9,6,3,8,7,5,2,4,1],[1,7,4,2,9,6,8,3,5],[8,2,5,3,1,4,9,6,7]]
889	[[7,1,6,3,5,9,4,8,2],[5,4,9,2,7,8,3,1,6],[2,3,8,6,4,1,5,7,9],[8,7,3,9,6,5,2,4,1],[9,5,2,8,1,4,6,3,7],[1,6,4,7,2,3,9,5,8],[6,8,1,4,3,2,7,9,5],[3,2,5,1,9,7,8,6,4],[4,9,7,5,8,6,1,2,3]]
890	[[7,8,1,2,4,6,5,9,3],[2,3,4,5,9,8,7,1,6],[6,5,9,3,1,7,4,8,2],[8,9,6,4,2,3,1,7,5],[3,1,5,8,7,9,6,2,4],[4,7,2,1,6,5,8,3,9],[5,6,3,7,8,2,9,4,1],[1,2,7,9,5,4,3,6,8],[9,4,8,6,3,1,2,5,7]]
891	[[6,1,8,5,3,9,2,4,7],[9,5,4,6,2,7,3,8,1],[7,2,3,1,4,8,5,6,9],[5,8,2,4,9,1,6,7,3],[3,6,1,7,8,2,4,9,5],[4,9,7,3,5,6,1,2,8],[2,7,5,9,6,3,8,1,4],[1,4,6,8,7,5,9,3,2],[8,3,9,2,1,4,7,5,6]]
892	[[8,5,2,6,7,1,3,4,9],[1,9,3,2,8,4,5,7,6],[7,4,6,3,9,5,2,8,1],[2,8,5,1,6,7,9,3,4],[6,3,4,9,5,2,8,1,7],[9,7,1,4,3,8,6,2,5],[5,6,7,8,4,3,1,9,2],[3,2,9,7,1,6,4,5,8],[4,1,8,5,2,9,7,6,3]]
893	[[1,8,2,3,4,5,9,6,7],[5,7,6,8,9,1,2,3,4],[9,3,4,2,7,6,5,8,1],[4,6,7,9,3,2,1,5,8],[2,1,5,4,6,8,7,9,3],[3,9,8,1,5,7,4,2,6],[8,4,1,6,2,9,3,7,5],[7,2,3,5,8,4,6,1,9],[6,5,9,7,1,3,8,4,2]]
894	[[7,2,9,5,3,8,1,4,6],[6,1,4,7,2,9,3,5,8],[3,5,8,1,4,6,2,7,9],[5,8,7,6,9,2,4,3,1],[9,6,3,4,1,7,5,8,2],[2,4,1,3,8,5,6,9,7],[1,9,5,8,6,3,7,2,4],[8,7,6,2,5,4,9,1,3],[4,3,2,9,7,1,8,6,5]]
895	[[3,2,4,7,1,9,8,5,6],[6,5,9,3,4,8,7,2,1],[1,8,7,5,2,6,9,3,4],[9,4,1,8,5,7,3,6,2],[8,3,6,2,9,1,4,7,5],[5,7,2,4,6,3,1,8,9],[7,9,5,1,3,2,6,4,8],[2,6,3,9,8,4,5,1,7],[4,1,8,6,7,5,2,9,3]]
896	[[8,4,5,9,2,7,3,6,1],[3,7,9,1,6,5,8,4,2],[2,6,1,8,4,3,9,7,5],[1,9,2,5,7,8,6,3,4],[7,3,6,4,9,2,5,1,8],[4,5,8,3,1,6,7,2,9],[5,2,7,6,8,4,1,9,3],[6,1,3,2,5,9,4,8,7],[9,8,4,7,3,1,2,5,6]]
897	[[2,7,3,8,4,6,9,5,1],[6,1,9,2,7,5,3,8,4],[4,8,5,1,9,3,6,7,2],[3,5,7,4,1,2,8,9,6],[8,4,2,9,6,7,5,1,3],[9,6,1,3,5,8,2,4,7],[1,3,8,7,2,9,4,6,5],[5,9,4,6,3,1,7,2,8],[7,2,6,5,8,4,1,3,9]]
898	[[6,8,2,5,1,3,4,7,9],[5,1,9,4,2,7,3,8,6],[3,4,7,9,6,8,5,2,1],[2,3,5,6,9,1,8,4,7],[9,7,4,3,8,5,1,6,2],[1,6,8,7,4,2,9,3,5],[4,5,1,8,7,6,2,9,3],[7,9,3,2,5,4,6,1,8],[8,2,6,1,3,9,7,5,4]]
899	[[1,5,4,6,2,3,7,8,9],[2,6,9,8,5,7,1,4,3],[7,8,3,1,4,9,5,6,2],[6,4,2,3,7,5,8,9,1],[8,7,1,2,9,6,3,5,4],[9,3,5,4,1,8,2,7,6],[4,9,8,5,3,1,6,2,7],[3,2,6,7,8,4,9,1,5],[5,1,7,9,6,2,4,3,8]]
900	[[9,6,1,3,5,8,2,7,4],[8,5,3,4,2,7,9,1,6],[4,2,7,6,9,1,3,5,8],[1,8,2,9,6,5,4,3,7],[7,4,9,8,1,3,6,2,5],[6,3,5,2,7,4,8,9,1],[5,9,8,7,4,2,1,6,3],[2,1,4,5,3,6,7,8,9],[3,7,6,1,8,9,5,4,2]]
901	[[4,8,2,7,9,3,5,6,1],[1,5,7,8,2,6,3,4,9],[3,6,9,4,5,1,2,7,8],[7,1,8,9,3,5,4,2,6],[9,2,3,6,1,4,7,8,5],[6,4,5,2,8,7,1,9,3],[5,7,6,3,4,8,9,1,2],[2,3,4,1,6,9,8,5,7],[8,9,1,5,7,2,6,3,4]]
902	[[1,2,7,4,8,6,5,9,3],[6,9,4,7,5,3,8,2,1],[3,5,8,1,9,2,6,4,7],[7,8,5,2,1,4,3,6,9],[2,6,3,9,7,8,4,1,5],[4,1,9,6,3,5,2,7,8],[8,4,1,3,6,7,9,5,2],[5,7,2,8,4,9,1,3,6],[9,3,6,5,2,1,7,8,4]]
903	[[1,3,5,7,4,8,2,9,6],[6,7,8,2,1,9,3,4,5],[4,2,9,6,5,3,7,1,8],[2,6,7,9,3,4,5,8,1],[8,9,4,5,2,1,6,7,3],[3,5,1,8,6,7,4,2,9],[5,8,6,1,7,2,9,3,4],[9,4,2,3,8,5,1,6,7],[7,1,3,4,9,6,8,5,2]]
904	[[5,8,2,1,3,6,4,7,9],[6,9,4,8,7,5,3,2,1],[7,3,1,9,4,2,5,6,8],[9,6,8,7,5,3,1,4,2],[1,2,7,6,9,4,8,3,5],[3,4,5,2,1,8,7,9,6],[2,7,9,4,8,1,6,5,3],[8,5,6,3,2,7,9,1,4],[4,1,3,5,6,9,2,8,7]]
905	[[3,6,8,7,5,1,9,4,2],[5,9,7,6,4,2,1,8,3],[4,2,1,8,3,9,5,7,6],[6,3,5,2,1,7,4,9,8],[7,1,4,3,9,8,2,6,5],[9,8,2,4,6,5,3,1,7],[1,4,3,5,7,6,8,2,9],[2,7,9,1,8,3,6,5,4],[8,5,6,9,2,4,7,3,1]]
906	[[5,4,3,8,6,1,9,7,2],[9,8,2,7,4,3,1,6,5],[1,7,6,9,2,5,4,3,8],[4,9,7,3,5,2,6,8,1],[3,2,1,6,9,8,5,4,7],[6,5,8,1,7,4,2,9,3],[8,3,4,2,1,9,7,5,6],[2,6,5,4,3,7,8,1,9],[7,1,9,5,8,6,3,2,4]]
907	[[5,6,4,2,8,9,7,1,3],[3,7,9,5,6,1,8,4,2],[2,8,1,7,4,3,5,6,9],[4,2,6,1,9,7,3,8,5],[1,9,8,3,5,4,2,7,6],[7,3,5,6,2,8,1,9,4],[8,5,2,9,1,6,4,3,7],[6,1,7,4,3,2,9,5,8],[9,4,3,8,7,5,6,2,1]]
908	[[7,3,5,9,4,6,8,2,1],[6,9,8,1,2,3,4,7,5],[1,2,4,8,7,5,9,6,3],[8,5,3,6,1,7,2,4,9],[2,6,1,4,9,8,3,5,7],[4,7,9,3,5,2,6,1,8],[5,8,7,2,3,4,1,9,6],[3,1,2,7,6,9,5,8,4],[9,4,6,5,8,1,7,3,2]]
909	[[9,3,1,5,2,4,6,8,7],[7,2,6,1,3,8,5,4,9],[5,4,8,9,7,6,3,1,2],[6,7,4,3,8,2,1,9,5],[2,9,5,6,1,7,8,3,4],[8,1,3,4,5,9,2,7,6],[4,5,7,8,6,1,9,2,3],[1,6,2,7,9,3,4,5,8],[3,8,9,2,4,5,7,6,1]]
910	[[2,7,4,1,9,3,6,5,8],[5,1,3,2,8,6,9,4,7],[8,9,6,5,7,4,1,2,3],[3,5,8,6,2,9,4,7,1],[7,6,1,4,3,5,2,8,9],[9,4,2,8,1,7,3,6,5],[1,8,9,7,4,2,5,3,6],[6,2,7,3,5,1,8,9,4],[4,3,5,9,6,8,7,1,2]]
911	[[2,9,5,6,8,7,3,4,1],[4,3,6,5,9,1,7,2,8],[1,8,7,3,2,4,9,6,5],[6,7,3,9,1,2,5,8,4],[9,1,4,8,3,5,6,7,2],[5,2,8,7,4,6,1,3,9],[3,5,1,2,6,8,4,9,7],[8,4,9,1,7,3,2,5,6],[7,6,2,4,5,9,8,1,3]]
912	[[3,5,4,9,7,6,1,2,8],[7,9,8,1,5,2,3,4,6],[1,2,6,4,3,8,7,9,5],[5,1,9,2,8,7,4,6,3],[2,8,7,6,4,3,9,5,1],[6,4,3,5,9,1,8,7,2],[9,3,2,8,6,4,5,1,7],[8,6,5,7,1,9,2,3,4],[4,7,1,3,2,5,6,8,9]]
913	[[8,7,1,3,4,9,2,5,6],[4,2,5,1,6,8,9,7,3],[6,9,3,5,2,7,4,1,8],[1,4,7,8,5,3,6,2,9],[9,3,2,6,1,4,5,8,7],[5,6,8,9,7,2,3,4,1],[2,1,4,7,3,6,8,9,5],[7,8,6,2,9,5,1,3,4],[3,5,9,4,8,1,7,6,2]]
914	[[5,8,3,7,1,9,2,4,6],[4,2,7,3,6,8,5,1,9],[1,6,9,5,2,4,3,8,7],[8,9,1,4,3,2,7,6,5],[3,4,6,9,5,7,1,2,8],[7,5,2,1,8,6,9,3,4],[9,7,8,2,4,1,6,5,3],[6,1,5,8,9,3,4,7,2],[2,3,4,6,7,5,8,9,1]]
915	[[9,5,1,7,4,3,8,2,6],[7,2,4,6,1,8,9,3,5],[3,8,6,9,2,5,4,1,7],[6,1,2,8,3,7,5,9,4],[4,9,5,2,6,1,3,7,8],[8,7,3,5,9,4,1,6,2],[2,3,8,4,7,9,6,5,1],[1,4,7,3,5,6,2,8,9],[5,6,9,1,8,2,7,4,3]]
916	[[3,9,6,4,8,5,2,1,7],[2,7,5,3,6,1,8,4,9],[4,1,8,2,9,7,3,6,5],[9,8,2,1,7,4,5,3,6],[6,3,4,8,5,9,7,2,1],[7,5,1,6,3,2,4,9,8],[5,4,3,7,1,6,9,8,2],[8,6,7,9,2,3,1,5,4],[1,2,9,5,4,8,6,7,3]]
917	[[2,8,6,9,3,1,4,7,5],[3,4,7,5,2,6,9,8,1],[1,9,5,8,7,4,6,3,2],[7,6,2,3,1,8,5,4,9],[5,3,8,4,6,9,2,1,7],[4,1,9,7,5,2,8,6,3],[6,7,1,2,4,5,3,9,8],[9,5,4,1,8,3,7,2,6],[8,2,3,6,9,7,1,5,4]]
918	[[6,4,7,8,3,2,5,9,1],[5,2,8,1,9,7,3,4,6],[9,3,1,5,6,4,8,2,7],[7,1,6,2,8,9,4,5,3],[8,5,3,7,4,1,2,6,9],[4,9,2,3,5,6,7,1,8],[1,8,4,6,7,5,9,3,2],[3,6,5,9,2,8,1,7,4],[2,7,9,4,1,3,6,8,5]]
919	[[6,3,4,1,9,8,7,5,2],[1,7,2,4,5,3,9,6,8],[8,9,5,6,7,2,4,1,3],[7,8,1,3,6,9,2,4,5],[5,2,6,7,1,4,3,8,9],[3,4,9,8,2,5,1,7,6],[9,5,8,2,4,1,6,3,7],[4,6,3,9,8,7,5,2,1],[2,1,7,5,3,6,8,9,4]]
920	[[7,6,4,5,3,8,1,2,9],[8,5,1,9,4,2,6,3,7],[9,3,2,6,7,1,8,5,4],[2,1,7,8,9,3,4,6,5],[6,8,9,2,5,4,3,7,1],[3,4,5,7,1,6,2,9,8],[1,7,8,3,2,9,5,4,6],[5,2,6,4,8,7,9,1,3],[4,9,3,1,6,5,7,8,2]]
921	[[3,8,7,2,9,4,6,1,5],[4,2,5,6,7,1,9,3,8],[9,6,1,3,8,5,4,2,7],[1,4,8,5,3,2,7,9,6],[2,3,9,8,6,7,1,5,4],[7,5,6,4,1,9,2,8,3],[6,9,4,1,5,3,8,7,2],[5,7,2,9,4,8,3,6,1],[8,1,3,7,2,6,5,4,9]]
922	[[1,2,8,4,6,3,7,9,5],[6,4,5,7,9,2,3,1,8],[9,7,3,8,1,5,4,2,6],[3,9,1,6,2,4,8,5,7],[7,6,4,1,5,8,9,3,2],[5,8,2,3,7,9,6,4,1],[4,5,7,2,3,6,1,8,9],[8,1,9,5,4,7,2,6,3],[2,3,6,9,8,1,5,7,4]]
923	[[7,5,1,6,9,2,8,3,4],[2,9,6,3,8,4,7,1,5],[3,4,8,5,7,1,6,2,9],[6,2,4,9,1,7,3,5,8],[8,7,3,4,6,5,1,9,2],[5,1,9,2,3,8,4,6,7],[1,3,7,8,2,9,5,4,6],[4,8,2,1,5,6,9,7,3],[9,6,5,7,4,3,2,8,1]]
924	[[5,4,6,2,9,1,3,7,8],[3,9,2,4,7,8,1,6,5],[7,8,1,3,6,5,9,4,2],[8,1,7,6,2,3,5,9,4],[2,3,9,7,5,4,6,8,1],[6,5,4,8,1,9,7,2,3],[9,7,3,5,4,2,8,1,6],[4,6,5,1,8,7,2,3,9],[1,2,8,9,3,6,4,5,7]]
925	[[2,9,3,1,4,7,8,6,5],[1,8,7,5,2,6,3,9,4],[4,6,5,3,8,9,2,1,7],[8,2,4,9,3,1,5,7,6],[3,7,1,6,5,2,4,8,9],[9,5,6,4,7,8,1,3,2],[6,3,9,2,1,4,7,5,8],[5,4,8,7,6,3,9,2,1],[7,1,2,8,9,5,6,4,3]]
926	[[9,3,5,7,6,1,4,2,8],[8,6,7,9,2,4,1,3,5],[4,2,1,3,8,5,7,9,6],[7,8,2,4,9,3,5,6,1],[3,1,4,6,5,8,2,7,9],[6,5,9,2,1,7,3,8,4],[2,4,6,5,7,9,8,1,3],[5,9,8,1,3,2,6,4,7],[1,7,3,8,4,6,9,5,2]]
927	[[4,7,3,2,1,8,6,9,5],[1,8,5,9,4,6,7,3,2],[9,2,6,3,7,5,8,4,1],[7,3,4,5,8,2,1,6,9],[2,5,9,1,6,7,3,8,4],[8,6,1,4,3,9,2,5,7],[3,4,7,8,9,1,5,2,6],[5,1,8,6,2,4,9,7,3],[6,9,2,7,5,3,4,1,8]]
928	[[5,7,3,6,4,8,9,2,1],[1,8,4,5,2,9,7,3,6],[9,2,6,7,1,3,5,4,8],[7,1,2,3,9,4,6,8,5],[4,9,8,1,6,5,2,7,3],[3,6,5,2,8,7,4,1,9],[2,5,1,4,3,6,8,9,7],[8,3,7,9,5,2,1,6,4],[6,4,9,8,7,1,3,5,2]]
929	[[2,7,6,3,9,1,5,4,8],[4,8,3,2,7,5,6,1,9],[9,1,5,4,6,8,7,3,2],[5,6,9,1,4,3,8,2,7],[7,3,2,9,8,6,4,5,1],[8,4,1,7,5,2,9,6,3],[3,9,7,5,1,4,2,8,6],[1,5,8,6,2,7,3,9,4],[6,2,4,8,3,9,1,7,5]]
930	[[5,7,6,2,9,8,3,1,4],[1,2,4,7,3,5,9,6,8],[9,8,3,4,6,1,7,2,5],[6,9,1,5,8,2,4,3,7],[7,5,8,1,4,3,2,9,6],[4,3,2,6,7,9,8,5,1],[8,1,5,3,2,7,6,4,9],[2,6,7,9,5,4,1,8,3],[3,4,9,8,1,6,5,7,2]]
931	[[4,1,9,2,3,6,8,7,5],[5,8,2,7,4,9,6,3,1],[7,6,3,1,8,5,4,2,9],[6,5,7,4,1,8,2,9,3],[9,3,1,6,2,7,5,4,8],[2,4,8,5,9,3,1,6,7],[3,7,6,8,5,2,9,1,4],[1,2,5,9,7,4,3,8,6],[8,9,4,3,6,1,7,5,2]]
932	[[7,9,8,3,5,2,4,1,6],[1,6,5,8,9,4,2,7,3],[2,3,4,6,7,1,9,8,5],[6,2,9,7,1,8,3,5,4],[5,8,1,4,3,9,6,2,7],[4,7,3,2,6,5,8,9,1],[8,5,6,1,2,3,7,4,9],[9,4,7,5,8,6,1,3,2],[3,1,2,9,4,7,5,6,8]]
933	[[9,3,2,7,8,6,4,5,1],[7,4,5,1,2,3,8,6,9],[6,8,1,5,9,4,3,2,7],[8,2,7,6,3,1,5,9,4],[4,1,6,9,5,7,2,3,8],[3,5,9,2,4,8,1,7,6],[2,7,4,8,6,5,9,1,3],[1,9,3,4,7,2,6,8,5],[5,6,8,3,1,9,7,4,2]]
934	[[3,5,7,2,6,1,9,8,4],[4,1,2,8,7,9,5,6,3],[9,8,6,3,4,5,2,1,7],[1,4,3,6,9,2,7,5,8],[7,2,9,5,3,8,6,4,1],[5,6,8,4,1,7,3,2,9],[2,3,5,9,8,4,1,7,6],[6,7,4,1,5,3,8,9,2],[8,9,1,7,2,6,4,3,5]]
935	[[3,8,6,1,4,7,9,5,2],[9,7,5,2,6,3,8,4,1],[2,4,1,8,5,9,3,6,7],[1,6,3,9,7,5,4,2,8],[8,9,7,4,1,2,6,3,5],[4,5,2,6,3,8,1,7,9],[7,1,8,3,2,6,5,9,4],[6,2,4,5,9,1,7,8,3],[5,3,9,7,8,4,2,1,6]]
936	[[6,1,7,5,4,2,3,8,9],[8,9,5,7,3,6,1,4,2],[3,2,4,8,9,1,5,6,7],[1,5,3,4,2,8,9,7,6],[7,6,8,9,5,3,4,2,1],[9,4,2,1,6,7,8,5,3],[5,8,1,6,7,9,2,3,4],[4,3,6,2,1,5,7,9,8],[2,7,9,3,8,4,6,1,5]]
937	[[6,5,8,1,3,7,4,2,9],[2,3,9,8,4,5,1,7,6],[4,7,1,6,2,9,5,8,3],[1,9,6,2,5,3,7,4,8],[8,4,3,9,7,1,6,5,2],[5,2,7,4,6,8,3,9,1],[3,6,4,7,8,2,9,1,5],[9,8,5,3,1,4,2,6,7],[7,1,2,5,9,6,8,3,4]]
938	[[4,6,2,3,7,1,8,5,9],[7,1,5,8,6,9,2,4,3],[8,3,9,4,2,5,6,1,7],[9,4,6,7,1,8,3,2,5],[2,8,7,5,4,3,1,9,6],[3,5,1,6,9,2,4,7,8],[5,9,4,2,3,6,7,8,1],[6,7,8,1,5,4,9,3,2],[1,2,3,9,8,7,5,6,4]]
939	[[3,7,4,5,2,1,6,8,9],[9,5,8,3,6,4,2,1,7],[1,6,2,9,8,7,3,5,4],[5,8,6,7,4,9,1,3,2],[7,1,9,8,3,2,5,4,6],[2,4,3,1,5,6,9,7,8],[6,2,1,4,7,3,8,9,5],[4,3,5,2,9,8,7,6,1],[8,9,7,6,1,5,4,2,3]]
940	[[1,2,3,8,4,9,7,5,6],[5,7,6,1,3,2,8,9,4],[8,4,9,5,7,6,3,1,2],[6,9,2,7,8,4,1,3,5],[4,5,7,9,1,3,6,2,8],[3,8,1,2,6,5,4,7,9],[7,1,5,4,2,8,9,6,3],[2,3,8,6,9,7,5,4,1],[9,6,4,3,5,1,2,8,7]]
941	[[2,8,6,7,5,1,9,3,4],[9,4,1,2,8,3,6,5,7],[3,7,5,9,4,6,1,2,8],[5,6,4,8,1,2,3,7,9],[7,9,8,3,6,5,2,4,1],[1,3,2,4,9,7,8,6,5],[6,5,9,1,3,4,7,8,2],[4,1,7,6,2,8,5,9,3],[8,2,3,5,7,9,4,1,6]]
942	[[1,8,3,9,4,7,2,6,5],[6,9,2,5,3,1,8,4,7],[7,5,4,6,2,8,9,1,3],[3,4,8,2,6,9,5,7,1],[2,7,6,4,1,5,3,8,9],[5,1,9,8,7,3,4,2,6],[8,6,1,3,5,4,7,9,2],[4,3,7,1,9,2,6,5,8],[9,2,5,7,8,6,1,3,4]]
943	[[9,6,4,3,8,2,5,1,7],[1,5,2,7,4,6,9,3,8],[7,3,8,9,5,1,2,6,4],[6,8,9,2,1,7,3,4,5],[2,4,7,5,6,3,1,8,9],[3,1,5,8,9,4,7,2,6],[5,7,3,6,2,8,4,9,1],[4,2,6,1,7,9,8,5,3],[8,9,1,4,3,5,6,7,2]]
944	[[8,9,3,6,2,5,7,1,4],[5,1,7,8,9,4,3,6,2],[4,6,2,3,1,7,8,9,5],[9,8,6,5,7,3,2,4,1],[2,4,5,9,8,1,6,7,3],[7,3,1,2,4,6,5,8,9],[1,7,8,4,3,2,9,5,6],[6,2,9,1,5,8,4,3,7],[3,5,4,7,6,9,1,2,8]]
945	[[5,7,3,2,6,1,4,8,9],[8,2,4,5,3,9,6,7,1],[1,9,6,4,8,7,3,5,2],[2,6,1,7,5,4,9,3,8],[7,4,8,9,2,3,5,1,6],[9,3,5,6,1,8,7,2,4],[6,8,7,1,9,5,2,4,3],[4,1,9,3,7,2,8,6,5],[3,5,2,8,4,6,1,9,7]]
946	[[9,2,1,3,8,5,7,4,6],[8,4,6,7,2,9,5,3,1],[5,7,3,4,6,1,2,9,8],[6,8,4,2,5,3,9,1,7],[2,1,5,9,7,4,8,6,3],[3,9,7,8,1,6,4,2,5],[1,6,9,5,4,7,3,8,2],[4,5,2,6,3,8,1,7,9],[7,3,8,1,9,2,6,5,4]]
947	[[7,2,4,3,8,6,5,9,1],[9,6,3,5,1,7,4,8,2],[5,8,1,4,2,9,7,3,6],[2,5,9,7,4,3,6,1,8],[4,1,6,9,5,8,2,7,3],[8,3,7,2,6,1,9,5,4],[1,9,5,6,3,2,8,4,7],[6,4,8,1,7,5,3,2,9],[3,7,2,8,9,4,1,6,5]]
948	[[6,4,5,2,1,7,3,9,8],[7,9,1,8,6,3,4,2,5],[2,8,3,5,9,4,1,6,7],[3,5,2,7,4,8,6,1,9],[4,7,9,6,2,1,8,5,3],[8,1,6,3,5,9,7,4,2],[5,2,8,1,3,6,9,7,4],[9,6,7,4,8,5,2,3,1],[1,3,4,9,7,2,5,8,6]]
949	[[8,4,1,5,3,7,6,2,9],[5,2,3,6,8,9,7,1,4],[7,6,9,4,2,1,5,8,3],[2,1,8,3,5,4,9,6,7],[3,7,6,9,1,8,2,4,5],[9,5,4,7,6,2,1,3,8],[4,3,2,1,7,5,8,9,6],[6,8,5,2,9,3,4,7,1],[1,9,7,8,4,6,3,5,2]]
950	[[9,4,3,2,8,1,7,6,5],[8,5,6,9,3,7,2,1,4],[1,2,7,4,6,5,8,3,9],[2,6,8,5,9,3,1,4,7],[7,3,9,1,4,6,5,8,2],[5,1,4,7,2,8,6,9,3],[6,8,5,3,7,4,9,2,1],[3,7,2,8,1,9,4,5,6],[4,9,1,6,5,2,3,7,8]]
951	[[9,8,6,3,1,4,5,2,7],[3,7,5,6,2,8,9,4,1],[1,2,4,7,9,5,8,3,6],[4,3,2,9,8,7,6,1,5],[5,1,9,4,6,3,2,7,8],[8,6,7,1,5,2,4,9,3],[6,5,3,2,4,1,7,8,9],[2,9,1,8,7,6,3,5,4],[7,4,8,5,3,9,1,6,2]]
952	[[3,2,9,8,1,5,6,4,7],[6,4,5,7,9,3,8,2,1],[1,7,8,2,6,4,3,9,5],[5,6,1,4,3,9,7,8,2],[8,9,4,1,7,2,5,6,3],[2,3,7,5,8,6,9,1,4],[9,5,2,6,4,7,1,3,8],[4,1,6,3,5,8,2,7,9],[7,8,3,9,2,1,4,5,6]]
953	[[9,6,1,2,5,3,8,4,7],[3,4,2,9,8,7,1,5,6],[5,7,8,4,6,1,9,3,2],[8,5,6,1,2,9,4,7,3],[4,2,7,8,3,6,5,9,1],[1,9,3,5,7,4,2,6,8],[7,8,9,3,1,5,6,2,4],[2,3,5,6,4,8,7,1,9],[6,1,4,7,9,2,3,8,5]]
954	[[7,4,3,9,6,1,2,5,8],[6,9,2,8,7,5,1,3,4],[5,8,1,2,3,4,7,9,6],[4,6,8,3,9,7,5,2,1],[1,2,9,6,5,8,3,4,7],[3,5,7,1,4,2,6,8,9],[8,3,5,7,1,9,4,6,2],[2,7,6,4,8,3,9,1,5],[9,1,4,5,2,6,8,7,3]]
955	[[5,8,3,4,9,7,6,2,1],[9,4,2,6,1,3,7,5,8],[7,6,1,2,5,8,9,4,3],[1,3,8,5,6,2,4,9,7],[6,9,7,1,3,4,5,8,2],[4,2,5,8,7,9,3,1,6],[3,5,4,7,8,1,2,6,9],[8,7,6,9,2,5,1,3,4],[2,1,9,3,4,6,8,7,5]]
956	[[2,3,5,9,1,4,8,6,7],[1,4,8,2,7,6,5,9,3],[6,9,7,8,5,3,2,4,1],[3,6,1,5,2,7,4,8,9],[4,7,2,6,8,9,1,3,5],[8,5,9,3,4,1,6,7,2],[9,1,3,4,6,5,7,2,8],[7,8,4,1,9,2,3,5,6],[5,2,6,7,3,8,9,1,4]]
957	[[8,6,4,5,9,2,1,3,7],[2,1,3,4,7,6,5,8,9],[9,5,7,1,3,8,2,6,4],[5,7,6,9,8,1,4,2,3],[3,8,1,2,4,5,9,7,6],[4,9,2,3,6,7,8,1,5],[7,3,5,8,1,9,6,4,2],[1,4,9,6,2,3,7,5,8],[6,2,8,7,5,4,3,9,1]]
958	[[1,8,6,9,4,7,2,5,3],[5,4,2,6,1,3,9,8,7],[3,9,7,2,5,8,4,1,6],[9,2,3,4,6,1,8,7,5],[8,1,5,7,3,9,6,4,2],[7,6,4,8,2,5,3,9,1],[6,3,9,5,7,4,1,2,8],[4,5,1,3,8,2,7,6,9],[2,7,8,1,9,6,5,3,4]]
959	[[5,2,7,1,3,4,9,8,6],[4,1,3,8,6,9,7,2,5],[6,9,8,2,7,5,1,4,3],[2,3,5,4,9,8,6,7,1],[1,7,6,5,2,3,4,9,8],[9,8,4,6,1,7,5,3,2],[3,4,2,7,5,6,8,1,9],[8,6,9,3,4,1,2,5,7],[7,5,1,9,8,2,3,6,4]]
960	[[9,7,8,6,3,2,5,4,1],[1,4,6,9,5,8,7,2,3],[5,2,3,4,7,1,6,9,8],[6,1,2,7,4,3,8,5,9],[4,3,5,2,8,9,1,6,7],[8,9,7,5,1,6,4,3,2],[3,5,4,8,9,7,2,1,6],[7,6,9,1,2,4,3,8,5],[2,8,1,3,6,5,9,7,4]]
961	[[2,8,4,9,6,3,1,5,7],[1,7,9,4,2,5,3,6,8],[3,6,5,1,7,8,4,9,2],[5,9,2,6,4,7,8,3,1],[7,3,6,5,8,1,9,2,4],[8,4,1,2,3,9,5,7,6],[9,2,7,3,1,4,6,8,5],[6,1,3,8,5,2,7,4,9],[4,5,8,7,9,6,2,1,3]]
962	[[9,4,8,2,3,7,1,6,5],[3,2,6,1,5,8,9,7,4],[1,7,5,6,9,4,2,8,3],[6,3,2,9,4,5,8,1,7],[7,8,1,3,6,2,5,4,9],[4,5,9,8,7,1,3,2,6],[5,1,4,7,8,9,6,3,2],[2,9,3,4,1,6,7,5,8],[8,6,7,5,2,3,4,9,1]]
963	[[9,7,3,2,5,8,1,4,6],[5,8,4,6,7,1,2,3,9],[6,1,2,9,3,4,7,8,5],[4,9,1,7,2,5,3,6,8],[3,5,8,1,6,9,4,2,7],[2,6,7,4,8,3,9,5,1],[1,2,9,5,4,6,8,7,3],[7,3,5,8,1,2,6,9,4],[8,4,6,3,9,7,5,1,2]]
964	[[1,7,5,2,4,9,6,8,3],[4,3,9,5,6,8,7,2,1],[6,2,8,1,7,3,9,5,4],[5,9,7,4,8,1,3,6,2],[3,4,1,7,2,6,5,9,8],[8,6,2,3,9,5,4,1,7],[2,5,6,8,3,7,1,4,9],[9,8,3,6,1,4,2,7,5],[7,1,4,9,5,2,8,3,6]]
965	[[1,2,8,4,6,7,3,9,5],[4,9,7,3,1,5,6,8,2],[6,5,3,2,9,8,4,1,7],[5,7,1,9,3,2,8,6,4],[3,6,4,7,8,1,5,2,9],[2,8,9,6,5,4,1,7,3],[7,1,6,5,2,3,9,4,8],[8,4,5,1,7,9,2,3,6],[9,3,2,8,4,6,7,5,1]]
966	[[7,2,8,5,9,4,3,6,1],[4,9,5,3,6,1,7,2,8],[6,1,3,2,8,7,5,4,9],[3,4,1,7,2,6,9,8,5],[5,6,9,8,4,3,1,7,2],[8,7,2,9,1,5,4,3,6],[2,8,4,1,7,9,6,5,3],[1,3,6,4,5,2,8,9,7],[9,5,7,6,3,8,2,1,4]]
967	[[3,5,7,6,2,4,8,1,9],[1,6,8,7,5,9,2,3,4],[4,2,9,8,1,3,7,6,5],[8,3,2,5,6,7,4,9,1],[6,4,1,3,9,2,5,7,8],[9,7,5,4,8,1,6,2,3],[7,9,4,2,3,8,1,5,6],[2,1,6,9,4,5,3,8,7],[5,8,3,1,7,6,9,4,2]]
968	[[3,5,7,8,4,6,1,2,9],[8,4,1,7,2,9,3,6,5],[2,9,6,3,5,1,4,7,8],[1,2,9,5,7,8,6,4,3],[6,7,3,2,9,4,5,8,1],[5,8,4,1,6,3,2,9,7],[4,3,2,9,1,7,8,5,6],[9,1,5,6,8,2,7,3,4],[7,6,8,4,3,5,9,1,2]]
969	[[9,2,4,3,1,8,5,6,7],[1,7,3,2,5,6,9,4,8],[5,6,8,4,9,7,1,2,3],[6,4,5,1,3,2,7,8,9],[8,1,7,9,6,4,2,3,5],[3,9,2,8,7,5,6,1,4],[7,8,6,5,4,1,3,9,2],[4,5,9,6,2,3,8,7,1],[2,3,1,7,8,9,4,5,6]]
970	[[2,5,1,7,4,3,8,6,9],[6,7,8,2,9,1,5,3,4],[4,3,9,6,5,8,1,2,7],[5,4,6,9,8,2,3,7,1],[9,8,3,1,7,6,2,4,5],[7,1,2,5,3,4,6,9,8],[3,9,5,8,6,7,4,1,2],[1,6,7,4,2,5,9,8,3],[8,2,4,3,1,9,7,5,6]]
971	[[2,4,5,8,9,3,6,7,1],[3,6,8,7,2,1,5,4,9],[7,9,1,4,6,5,8,3,2],[6,8,4,3,1,9,2,5,7],[1,2,3,5,8,7,4,9,6],[5,7,9,6,4,2,3,1,8],[9,5,2,1,3,8,7,6,4],[8,3,6,9,7,4,1,2,5],[4,1,7,2,5,6,9,8,3]]
972	[[8,9,4,2,7,6,3,1,5],[7,1,2,3,5,4,9,6,8],[5,3,6,1,8,9,2,7,4],[3,7,5,9,6,8,1,4,2],[9,4,8,7,1,2,5,3,6],[2,6,1,4,3,5,7,8,9],[6,8,7,5,2,3,4,9,1],[4,5,3,8,9,1,6,2,7],[1,2,9,6,4,7,8,5,3]]
973	[[2,1,8,7,6,5,3,4,9],[5,4,7,9,2,3,1,6,8],[3,9,6,8,1,4,5,7,2],[7,6,1,4,5,2,9,8,3],[9,8,3,6,7,1,4,2,5],[4,5,2,3,8,9,7,1,6],[8,7,5,1,3,6,2,9,4],[6,3,9,2,4,7,8,5,1],[1,2,4,5,9,8,6,3,7]]
974	[[8,2,4,9,7,6,3,1,5],[3,7,5,1,4,2,6,9,8],[6,9,1,5,3,8,7,4,2],[7,3,9,2,1,4,5,8,6],[4,5,2,8,6,7,1,3,9],[1,6,8,3,9,5,2,7,4],[5,8,7,4,2,1,9,6,3],[2,1,3,6,8,9,4,5,7],[9,4,6,7,5,3,8,2,1]]
975	[[4,5,3,8,1,2,6,7,9],[6,2,7,5,3,9,1,4,8],[9,8,1,4,7,6,2,3,5],[7,9,4,2,6,8,3,5,1],[3,6,8,1,5,7,9,2,4],[2,1,5,9,4,3,8,6,7],[5,4,2,6,8,1,7,9,3],[1,7,9,3,2,5,4,8,6],[8,3,6,7,9,4,5,1,2]]
976	[[7,5,6,4,9,1,8,2,3],[2,9,3,7,8,5,4,1,6],[8,4,1,3,2,6,7,5,9],[4,6,8,5,7,3,2,9,1],[3,7,5,9,1,2,6,4,8],[1,2,9,6,4,8,5,3,7],[5,8,7,1,3,4,9,6,2],[9,1,4,2,6,7,3,8,5],[6,3,2,8,5,9,1,7,4]]
977	[[6,5,2,1,4,8,9,7,3],[1,3,8,5,9,7,2,6,4],[4,9,7,3,6,2,5,8,1],[2,1,6,7,8,9,3,4,5],[8,4,9,6,3,5,7,1,2],[3,7,5,4,2,1,8,9,6],[9,8,3,2,1,4,6,5,7],[7,6,1,8,5,3,4,2,9],[5,2,4,9,7,6,1,3,8]]
978	[[8,5,4,9,1,3,6,2,7],[2,1,7,8,5,6,4,9,3],[3,6,9,4,7,2,8,1,5],[7,3,2,6,4,8,1,5,9],[5,9,6,1,2,7,3,8,4],[1,4,8,3,9,5,2,7,6],[6,7,3,2,8,9,5,4,1],[4,8,5,7,6,1,9,3,2],[9,2,1,5,3,4,7,6,8]]
979	[[2,4,1,8,3,6,5,9,7],[9,3,8,7,5,2,4,1,6],[5,7,6,4,1,9,8,2,3],[3,6,4,2,9,8,7,5,1],[7,9,5,1,6,4,3,8,2],[1,8,2,3,7,5,6,4,9],[4,5,3,6,2,1,9,7,8],[6,2,9,5,8,7,1,3,4],[8,1,7,9,4,3,2,6,5]]
980	[[8,4,6,3,1,9,7,2,5],[1,2,3,4,5,7,8,6,9],[9,7,5,2,8,6,1,3,4],[2,5,9,6,7,3,4,8,1],[3,6,1,5,4,8,2,9,7],[7,8,4,9,2,1,6,5,3],[5,1,7,8,3,2,9,4,6],[6,3,8,1,9,4,5,7,2],[4,9,2,7,6,5,3,1,8]]
981	[[8,1,6,5,4,3,2,7,9],[4,9,7,8,6,2,1,5,3],[2,5,3,9,7,1,8,4,6],[1,8,2,4,5,6,9,3,7],[6,3,4,1,9,7,5,2,8],[5,7,9,2,3,8,4,6,1],[7,4,8,3,2,9,6,1,5],[9,6,5,7,1,4,3,8,2],[3,2,1,6,8,5,7,9,4]]
982	[[8,4,3,2,1,9,5,6,7],[6,7,1,3,4,5,2,9,8],[5,9,2,6,8,7,1,3,4],[1,8,4,9,5,6,3,7,2],[2,6,9,7,3,4,8,1,5],[7,3,5,8,2,1,9,4,6],[4,5,8,1,7,3,6,2,9],[9,1,7,5,6,2,4,8,3],[3,2,6,4,9,8,7,5,1]]
983	[[2,5,1,4,6,9,3,8,7],[8,7,4,3,2,1,6,5,9],[3,6,9,7,8,5,4,1,2],[1,8,3,2,7,4,9,6,5],[7,4,5,9,1,6,2,3,8],[6,9,2,8,5,3,1,7,4],[9,1,6,5,4,8,7,2,3],[4,2,8,1,3,7,5,9,6],[5,3,7,6,9,2,8,4,1]]
984	[[5,7,2,1,6,8,4,3,9],[4,8,1,7,9,3,2,5,6],[9,6,3,2,5,4,1,8,7],[7,5,9,3,1,6,8,2,4],[2,3,4,8,7,9,5,6,1],[6,1,8,5,4,2,7,9,3],[3,4,7,6,2,5,9,1,8],[8,9,5,4,3,1,6,7,2],[1,2,6,9,8,7,3,4,5]]
985	[[3,8,5,4,9,7,2,1,6],[6,1,4,8,2,5,7,3,9],[9,7,2,3,6,1,5,4,8],[5,3,6,2,7,8,1,9,4],[2,9,1,6,5,4,3,8,7],[8,4,7,9,1,3,6,2,5],[7,6,3,1,8,9,4,5,2],[1,2,8,5,4,6,9,7,3],[4,5,9,7,3,2,8,6,1]]
986	[[2,1,7,3,4,6,5,9,8],[3,8,6,1,9,5,4,2,7],[5,9,4,7,2,8,3,6,1],[7,4,2,6,8,9,1,5,3],[6,5,8,4,3,1,2,7,9],[1,3,9,5,7,2,8,4,6],[4,2,3,9,1,7,6,8,5],[8,7,5,2,6,3,9,1,4],[9,6,1,8,5,4,7,3,2]]
987	[[8,1,4,5,2,7,3,9,6],[2,7,3,9,6,4,5,1,8],[9,5,6,8,1,3,2,7,4],[6,3,9,2,7,5,8,4,1],[5,4,7,3,8,1,6,2,9],[1,8,2,4,9,6,7,5,3],[3,2,1,6,5,9,4,8,7],[4,9,5,7,3,8,1,6,2],[7,6,8,1,4,2,9,3,5]]
988	[[5,6,2,3,8,4,7,1,9],[4,9,7,1,6,5,3,2,8],[3,8,1,9,2,7,5,4,6],[1,4,5,6,3,8,2,9,7],[9,7,3,4,5,2,6,8,1],[6,2,8,7,1,9,4,5,3],[2,1,6,5,9,3,8,7,4],[8,3,4,2,7,1,9,6,5],[7,5,9,8,4,6,1,3,2]]
989	[[9,6,4,7,1,3,2,5,8],[3,8,7,2,6,5,1,9,4],[1,5,2,4,8,9,3,6,7],[4,2,5,1,3,8,6,7,9],[6,7,3,5,9,4,8,2,1],[8,1,9,6,7,2,5,4,3],[7,4,1,3,2,6,9,8,5],[5,9,6,8,4,1,7,3,2],[2,3,8,9,5,7,4,1,6]]
990	[[1,7,8,4,6,3,9,5,2],[3,9,6,7,5,2,1,8,4],[2,4,5,9,1,8,6,3,7],[4,8,9,3,7,5,2,1,6],[6,2,3,1,8,4,5,7,9],[5,1,7,6,2,9,8,4,3],[9,3,1,5,4,6,7,2,8],[8,5,4,2,9,7,3,6,1],[7,6,2,8,3,1,4,9,5]]
991	[[4,9,1,8,2,6,7,5,3],[6,3,8,9,5,7,4,1,2],[5,7,2,3,4,1,6,9,8],[8,1,4,6,9,2,3,7,5],[9,2,5,4,7,3,8,6,1],[3,6,7,5,1,8,2,4,9],[1,8,9,7,3,4,5,2,6],[2,4,6,1,8,5,9,3,7],[7,5,3,2,6,9,1,8,4]]
992	[[5,6,7,8,2,9,1,3,4],[3,8,9,4,5,1,2,7,6],[1,2,4,3,6,7,8,5,9],[7,3,8,2,4,5,6,9,1],[9,5,2,6,1,3,7,4,8],[6,4,1,7,9,8,5,2,3],[2,1,6,9,7,4,3,8,5],[8,9,5,1,3,2,4,6,7],[4,7,3,5,8,6,9,1,2]]
993	[[7,3,1,8,6,5,9,4,2],[5,6,9,2,3,4,8,1,7],[8,2,4,9,1,7,3,6,5],[6,1,3,4,5,2,7,9,8],[9,5,7,1,8,3,6,2,4],[2,4,8,7,9,6,1,5,3],[1,7,5,3,2,9,4,8,6],[3,8,2,6,4,1,5,7,9],[4,9,6,5,7,8,2,3,1]]
994	[[5,3,9,7,8,6,1,2,4],[2,1,6,3,9,4,7,8,5],[7,8,4,2,1,5,9,3,6],[4,2,7,8,5,9,3,6,1],[3,9,8,1,6,2,4,5,7],[1,6,5,4,3,7,8,9,2],[8,5,1,6,7,3,2,4,9],[9,4,3,5,2,1,6,7,8],[6,7,2,9,4,8,5,1,3]]
995	[[5,3,4,1,2,7,8,9,6],[7,8,6,9,3,5,1,4,2],[2,9,1,6,8,4,7,3,5],[9,7,8,2,5,6,3,1,4],[4,6,5,8,1,3,9,2,7],[1,2,3,4,7,9,6,5,8],[6,1,2,3,4,8,5,7,9],[8,4,7,5,9,1,2,6,3],[3,5,9,7,6,2,4,8,1]]
996	[[4,1,6,8,7,5,3,2,9],[7,8,3,9,2,6,4,5,1],[5,2,9,1,4,3,6,7,8],[9,4,7,6,5,8,2,1,3],[1,3,5,2,9,7,8,4,6],[8,6,2,3,1,4,7,9,5],[3,9,4,7,6,1,5,8,2],[2,5,8,4,3,9,1,6,7],[6,7,1,5,8,2,9,3,4]]
997	[[2,5,3,9,4,1,7,6,8],[1,6,8,2,5,7,3,9,4],[9,7,4,6,8,3,2,5,1],[6,1,7,4,9,8,5,2,3],[8,9,2,1,3,5,6,4,7],[4,3,5,7,2,6,1,8,9],[7,4,1,8,6,2,9,3,5],[3,2,9,5,1,4,8,7,6],[5,8,6,3,7,9,4,1,2]]
998	[[8,5,1,6,2,9,3,7,4],[9,7,2,3,5,4,1,6,8],[6,4,3,8,7,1,5,9,2],[5,8,6,4,9,3,7,2,1],[3,2,4,7,1,6,8,5,9],[7,1,9,2,8,5,4,3,6],[4,6,5,1,3,2,9,8,7],[2,3,8,9,4,7,6,1,5],[1,9,7,5,6,8,2,4,3]]
999	[[2,5,4,1,9,3,7,6,8],[8,1,6,2,4,7,5,9,3],[7,9,3,8,6,5,4,2,1],[6,8,2,3,5,9,1,4,7],[1,3,9,7,8,4,6,5,2],[4,7,5,6,2,1,3,8,9],[9,6,7,5,3,2,8,1,4],[5,2,1,4,7,8,9,3,6],[3,4,8,9,1,6,2,7,5]]
1000	[[4,5,6,7,9,3,1,2,8],[2,7,8,6,4,1,3,5,9],[1,3,9,2,8,5,6,4,7],[3,9,7,4,5,6,2,8,1],[6,2,5,8,1,9,4,7,3],[8,1,4,3,2,7,5,9,6],[7,8,2,1,3,4,9,6,5],[5,6,1,9,7,2,8,3,4],[9,4,3,5,6,8,7,1,2]]
1001	[[6,4,9,1,3,7,2,5,8],[2,7,1,8,4,5,6,9,3],[3,5,8,2,9,6,4,7,1],[4,8,7,6,2,3,9,1,5],[5,6,3,7,1,9,8,4,2],[1,9,2,5,8,4,7,3,6],[7,2,6,9,5,1,3,8,4],[9,3,5,4,6,8,1,2,7],[8,1,4,3,7,2,5,6,9]]
1002	[[7,4,8,6,1,3,9,5,2],[5,9,3,2,7,8,4,6,1],[2,1,6,4,9,5,3,7,8],[9,8,1,3,6,7,2,4,5],[3,7,5,8,2,4,6,1,9],[4,6,2,9,5,1,7,8,3],[8,2,7,5,4,9,1,3,6],[6,5,4,1,3,2,8,9,7],[1,3,9,7,8,6,5,2,4]]
1003	[[5,1,9,7,6,3,2,4,8],[2,3,4,1,8,9,7,5,6],[6,7,8,4,5,2,9,3,1],[4,6,7,3,2,1,5,8,9],[9,5,1,6,7,8,3,2,4],[8,2,3,5,9,4,6,1,7],[3,8,5,9,4,6,1,7,2],[7,9,2,8,1,5,4,6,3],[1,4,6,2,3,7,8,9,5]]
1004	[[2,4,1,3,5,6,9,7,8],[7,5,3,9,8,2,1,6,4],[8,9,6,4,1,7,2,3,5],[5,2,9,6,7,8,4,1,3],[3,6,7,1,2,4,8,5,9],[4,1,8,5,3,9,7,2,6],[1,8,5,7,4,3,6,9,2],[9,7,4,2,6,5,3,8,1],[6,3,2,8,9,1,5,4,7]]
1005	[[3,8,7,4,6,1,2,5,9],[9,5,1,8,7,2,6,3,4],[4,6,2,9,3,5,1,8,7],[2,3,9,1,4,6,8,7,5],[8,7,5,3,2,9,4,6,1],[1,4,6,7,5,8,9,2,3],[5,2,3,6,9,4,7,1,8],[6,1,4,5,8,7,3,9,2],[7,9,8,2,1,3,5,4,6]]
1006	[[3,9,2,8,5,7,4,1,6],[8,6,4,2,1,3,7,9,5],[7,1,5,6,4,9,3,2,8],[6,7,9,4,2,8,1,5,3],[1,4,8,5,3,6,2,7,9],[2,5,3,7,9,1,6,8,4],[9,2,7,3,8,4,5,6,1],[4,8,6,1,7,5,9,3,2],[5,3,1,9,6,2,8,4,7]]
1007	[[9,1,5,2,3,6,7,8,4],[4,7,6,8,5,1,2,3,9],[2,3,8,9,7,4,5,1,6],[3,4,1,5,8,7,9,6,2],[8,9,7,6,4,2,1,5,3],[6,5,2,3,1,9,8,4,7],[7,8,4,1,9,3,6,2,5],[1,6,9,4,2,5,3,7,8],[5,2,3,7,6,8,4,9,1]]
1008	[[7,3,1,4,6,2,9,8,5],[2,9,6,5,8,7,4,1,3],[8,5,4,3,9,1,2,6,7],[9,7,5,6,2,4,1,3,8],[1,8,2,9,3,5,7,4,6],[4,6,3,1,7,8,5,9,2],[5,4,8,2,1,6,3,7,9],[3,1,7,8,5,9,6,2,4],[6,2,9,7,4,3,8,5,1]]
1009	[[3,8,1,2,7,4,9,5,6],[9,6,2,3,1,5,4,7,8],[4,5,7,9,6,8,3,1,2],[5,2,8,6,9,1,7,3,4],[1,4,3,8,5,7,2,6,9],[7,9,6,4,3,2,1,8,5],[2,3,5,7,4,6,8,9,1],[8,1,9,5,2,3,6,4,7],[6,7,4,1,8,9,5,2,3]]
1010	[[9,3,1,2,6,8,4,5,7],[4,2,5,7,1,3,6,9,8],[8,7,6,4,5,9,2,1,3],[2,1,8,9,7,5,3,6,4],[7,6,9,1,3,4,5,8,2],[3,5,4,8,2,6,1,7,9],[1,4,2,6,9,7,8,3,5],[5,8,7,3,4,1,9,2,6],[6,9,3,5,8,2,7,4,1]]
1011	[[6,1,5,8,9,7,4,2,3],[3,7,8,1,4,2,9,5,6],[4,2,9,5,6,3,8,7,1],[7,8,6,2,1,9,5,3,4],[9,3,4,6,5,8,7,1,2],[1,5,2,3,7,4,6,9,8],[2,6,7,9,8,1,3,4,5],[5,4,3,7,2,6,1,8,9],[8,9,1,4,3,5,2,6,7]]
1012	[[1,8,5,3,7,9,6,2,4],[4,2,9,5,6,8,1,3,7],[3,6,7,1,4,2,5,8,9],[2,5,1,4,9,6,3,7,8],[6,7,4,8,3,5,9,1,2],[8,9,3,7,2,1,4,5,6],[7,3,8,6,1,4,2,9,5],[5,4,2,9,8,3,7,6,1],[9,1,6,2,5,7,8,4,3]]
1013	[[4,3,6,9,7,1,5,2,8],[8,9,2,4,5,3,1,6,7],[5,7,1,2,6,8,9,3,4],[6,1,4,7,2,9,3,8,5],[9,5,3,1,8,6,7,4,2],[7,2,8,3,4,5,6,9,1],[3,8,9,5,1,4,2,7,6],[1,4,7,6,3,2,8,5,9],[2,6,5,8,9,7,4,1,3]]
1014	[[7,6,4,9,2,8,1,5,3],[9,1,3,5,7,6,2,4,8],[2,8,5,4,1,3,7,9,6],[1,7,2,3,5,9,6,8,4],[6,3,8,2,4,1,5,7,9],[4,5,9,8,6,7,3,1,2],[8,2,1,7,3,4,9,6,5],[5,4,6,1,9,2,8,3,7],[3,9,7,6,8,5,4,2,1]]
1015	[[4,7,5,1,9,3,8,2,6],[1,8,9,6,2,4,5,7,3],[3,2,6,8,7,5,9,1,4],[9,5,2,3,4,6,1,8,7],[7,6,1,2,5,8,3,4,9],[8,3,4,9,1,7,2,6,5],[2,1,3,7,6,9,4,5,8],[6,4,8,5,3,2,7,9,1],[5,9,7,4,8,1,6,3,2]]
1016	[[1,9,6,4,5,8,2,7,3],[4,2,5,7,3,6,1,9,8],[7,3,8,1,2,9,5,4,6],[8,5,7,6,4,2,3,1,9],[3,6,9,8,1,7,4,5,2],[2,4,1,5,9,3,6,8,7],[9,1,3,2,7,4,8,6,5],[5,8,2,9,6,1,7,3,4],[6,7,4,3,8,5,9,2,1]]
1017	[[8,7,4,2,1,9,6,3,5],[5,9,6,3,4,8,2,7,1],[2,1,3,5,6,7,9,8,4],[6,2,7,9,8,5,1,4,3],[1,5,9,7,3,4,8,2,6],[4,3,8,1,2,6,5,9,7],[3,8,2,4,5,1,7,6,9],[7,6,1,8,9,3,4,5,2],[9,4,5,6,7,2,3,1,8]]
1018	[[6,3,9,8,2,4,7,5,1],[8,7,1,5,6,9,2,3,4],[5,4,2,3,1,7,9,6,8],[1,2,3,6,7,8,5,4,9],[4,5,8,2,9,3,6,1,7],[9,6,7,1,4,5,3,8,2],[3,1,4,7,5,2,8,9,6],[7,9,5,4,8,6,1,2,3],[2,8,6,9,3,1,4,7,5]]
1019	[[8,2,3,4,5,7,6,1,9],[9,4,5,2,6,1,7,3,8],[1,6,7,3,8,9,2,5,4],[2,5,6,9,1,3,4,8,7],[4,3,9,8,7,6,1,2,5],[7,8,1,5,2,4,3,9,6],[5,1,4,7,9,2,8,6,3],[3,9,2,6,4,8,5,7,1],[6,7,8,1,3,5,9,4,2]]
1020	[[4,9,8,3,2,1,7,6,5],[7,6,3,8,4,5,9,1,2],[2,5,1,7,9,6,3,4,8],[6,3,7,4,1,8,2,5,9],[5,1,2,9,7,3,4,8,6],[9,8,4,5,6,2,1,7,3],[1,2,5,6,3,7,8,9,4],[3,4,6,1,8,9,5,2,7],[8,7,9,2,5,4,6,3,1]]
1021	[[3,5,4,2,8,6,9,7,1],[9,7,1,5,3,4,6,2,8],[6,8,2,1,7,9,4,3,5],[5,9,7,4,2,1,3,8,6],[2,4,8,6,9,3,1,5,7],[1,3,6,8,5,7,2,4,9],[4,2,5,9,1,8,7,6,3],[7,6,9,3,4,5,8,1,2],[8,1,3,7,6,2,5,9,4]]
1022	[[8,5,6,9,4,7,2,1,3],[4,1,2,8,5,3,9,7,6],[7,3,9,6,1,2,8,5,4],[9,4,8,1,6,5,3,2,7],[1,6,3,2,7,8,4,9,5],[2,7,5,4,3,9,6,8,1],[3,9,7,5,2,6,1,4,8],[6,2,1,7,8,4,5,3,9],[5,8,4,3,9,1,7,6,2]]
1023	[[1,8,7,2,6,3,4,5,9],[9,3,2,5,1,4,6,7,8],[5,4,6,8,9,7,1,2,3],[4,2,3,7,8,6,5,9,1],[7,6,5,9,4,1,3,8,2],[8,1,9,3,5,2,7,4,6],[6,5,4,1,2,9,8,3,7],[3,9,1,4,7,8,2,6,5],[2,7,8,6,3,5,9,1,4]]
1024	[[7,3,8,4,2,5,1,9,6],[9,6,2,7,1,3,4,5,8],[5,4,1,8,9,6,3,7,2],[3,8,6,9,7,2,5,1,4],[2,5,4,1,3,8,7,6,9],[1,9,7,5,6,4,8,2,3],[6,2,5,3,8,1,9,4,7],[8,1,9,6,4,7,2,3,5],[4,7,3,2,5,9,6,8,1]]
1025	[[5,7,8,9,3,4,2,6,1],[2,3,9,6,1,5,8,4,7],[4,6,1,2,8,7,3,5,9],[7,1,4,8,2,6,5,9,3],[3,2,5,1,4,9,6,7,8],[8,9,6,7,5,3,4,1,2],[6,5,7,3,9,8,1,2,4],[9,8,2,4,6,1,7,3,5],[1,4,3,5,7,2,9,8,6]]
1026	[[4,3,9,1,8,6,7,5,2],[1,5,6,2,7,4,8,9,3],[7,8,2,5,9,3,6,4,1],[3,7,1,4,5,8,2,6,9],[6,2,5,3,1,9,4,8,7],[8,9,4,6,2,7,3,1,5],[2,6,7,9,4,5,1,3,8],[5,4,8,7,3,1,9,2,6],[9,1,3,8,6,2,5,7,4]]
1027	[[1,9,6,4,2,5,8,3,7],[5,2,7,1,8,3,9,6,4],[8,4,3,6,9,7,1,2,5],[9,6,5,2,4,8,3,7,1],[7,8,2,3,1,6,5,4,9],[3,1,4,7,5,9,2,8,6],[6,5,9,8,7,2,4,1,3],[2,3,1,5,6,4,7,9,8],[4,7,8,9,3,1,6,5,2]]
1028	[[4,2,9,6,7,8,3,1,5],[5,1,3,4,2,9,8,6,7],[7,8,6,3,5,1,9,4,2],[9,7,8,2,3,6,1,5,4],[2,4,1,7,8,5,6,3,9],[6,3,5,1,9,4,2,7,8],[8,5,4,9,6,3,7,2,1],[1,6,2,8,4,7,5,9,3],[3,9,7,5,1,2,4,8,6]]
1029	[[5,4,7,6,2,1,8,3,9],[1,3,9,7,8,4,2,6,5],[8,2,6,9,5,3,7,4,1],[6,5,3,8,7,9,4,1,2],[7,8,1,2,4,5,6,9,3],[2,9,4,3,1,6,5,7,8],[9,1,8,5,6,7,3,2,4],[4,7,2,1,3,8,9,5,6],[3,6,5,4,9,2,1,8,7]]
1030	[[4,8,2,9,6,3,5,7,1],[3,6,1,2,5,7,8,9,4],[9,5,7,1,4,8,2,6,3],[5,1,3,7,2,4,9,8,6],[6,9,8,3,1,5,4,2,7],[7,2,4,8,9,6,3,1,5],[2,7,9,4,3,1,6,5,8],[1,3,5,6,8,2,7,4,9],[8,4,6,5,7,9,1,3,2]]
1031	[[5,9,8,7,6,1,2,4,3],[4,6,3,2,5,9,1,8,7],[2,1,7,8,4,3,9,5,6],[3,5,9,4,2,7,8,6,1],[6,7,2,3,1,8,5,9,4],[8,4,1,6,9,5,3,7,2],[9,3,5,1,7,4,6,2,8],[7,8,6,5,3,2,4,1,9],[1,2,4,9,8,6,7,3,5]]
1032	[[7,1,6,9,8,3,2,4,5],[5,4,3,1,2,7,9,8,6],[8,2,9,5,4,6,3,1,7],[3,5,1,2,7,8,6,9,4],[9,7,4,6,5,1,8,3,2],[2,6,8,4,3,9,7,5,1],[6,3,7,8,1,4,5,2,9],[4,9,5,3,6,2,1,7,8],[1,8,2,7,9,5,4,6,3]]
1033	[[1,2,5,4,9,6,8,7,3],[8,6,7,5,3,2,4,1,9],[3,4,9,7,1,8,5,6,2],[2,9,3,6,5,1,7,4,8],[4,7,6,2,8,9,1,3,5],[5,1,8,3,4,7,2,9,6],[6,3,1,8,7,5,9,2,4],[9,8,2,1,6,4,3,5,7],[7,5,4,9,2,3,6,8,1]]
1034	[[5,9,6,2,3,8,4,1,7],[7,8,3,5,4,1,9,6,2],[1,2,4,9,7,6,3,5,8],[4,6,1,8,9,7,2,3,5],[8,5,7,3,2,4,1,9,6],[9,3,2,6,1,5,7,8,4],[3,1,8,7,6,2,5,4,9],[2,4,5,1,8,9,6,7,3],[6,7,9,4,5,3,8,2,1]]
1035	[[6,3,8,2,9,4,5,7,1],[4,2,1,6,5,7,8,3,9],[5,7,9,8,1,3,2,4,6],[3,1,6,7,8,2,9,5,4],[2,9,4,3,6,5,7,1,8],[8,5,7,9,4,1,3,6,2],[7,6,2,4,3,8,1,9,5],[9,8,5,1,7,6,4,2,3],[1,4,3,5,2,9,6,8,7]]
1036	[[7,8,4,6,2,3,9,5,1],[3,9,2,8,5,1,4,6,7],[5,1,6,4,7,9,3,8,2],[6,7,9,1,3,4,5,2,8],[8,3,1,5,9,2,7,4,6],[2,4,5,7,6,8,1,9,3],[1,2,3,9,4,6,8,7,5],[9,5,8,2,1,7,6,3,4],[4,6,7,3,8,5,2,1,9]]
1037	[[4,9,5,3,6,2,1,8,7],[8,1,6,4,7,5,9,2,3],[3,2,7,1,8,9,4,5,6],[5,4,1,9,2,3,6,7,8],[6,8,9,5,4,7,2,3,1],[7,3,2,6,1,8,5,4,9],[9,7,4,2,3,6,8,1,5],[1,6,3,8,5,4,7,9,2],[2,5,8,7,9,1,3,6,4]]
1038	[[9,5,8,4,7,2,3,1,6],[4,1,2,3,5,6,8,7,9],[6,7,3,1,9,8,5,4,2],[7,6,5,2,1,3,9,8,4],[8,2,1,5,4,9,6,3,7],[3,4,9,6,8,7,2,5,1],[1,9,7,8,2,5,4,6,3],[5,3,4,9,6,1,7,2,8],[2,8,6,7,3,4,1,9,5]]
1039	[[8,4,9,2,6,3,7,1,5],[6,1,7,4,5,9,2,3,8],[2,3,5,8,1,7,6,9,4],[1,5,2,3,4,6,8,7,9],[4,9,8,1,7,5,3,6,2],[7,6,3,9,8,2,5,4,1],[3,7,1,5,2,4,9,8,6],[9,2,4,6,3,8,1,5,7],[5,8,6,7,9,1,4,2,3]]
1040	[[8,3,6,2,4,5,1,7,9],[5,9,2,3,1,7,4,6,8],[1,7,4,8,6,9,3,5,2],[3,6,5,9,8,1,2,4,7],[2,8,1,7,3,4,5,9,6],[9,4,7,6,5,2,8,3,1],[7,1,8,5,9,3,6,2,4],[4,2,3,1,7,6,9,8,5],[6,5,9,4,2,8,7,1,3]]
1041	[[3,2,5,6,9,1,8,7,4],[1,8,7,4,3,5,9,6,2],[6,9,4,2,7,8,1,5,3],[5,1,9,7,6,2,4,3,8],[8,3,6,9,5,4,7,2,1],[7,4,2,8,1,3,6,9,5],[2,7,1,5,8,9,3,4,6],[9,5,3,1,4,6,2,8,7],[4,6,8,3,2,7,5,1,9]]
1042	[[7,1,5,4,9,3,8,6,2],[6,3,4,2,8,7,5,9,1],[8,9,2,6,5,1,4,7,3],[9,5,6,3,4,2,7,1,8],[3,7,1,9,6,8,2,4,5],[4,2,8,1,7,5,6,3,9],[1,8,9,7,2,6,3,5,4],[2,6,3,5,1,4,9,8,7],[5,4,7,8,3,9,1,2,6]]
1043	[[4,2,6,8,9,7,1,5,3],[5,9,8,1,3,4,2,7,6],[1,3,7,6,2,5,4,8,9],[8,1,2,9,7,3,5,6,4],[7,4,3,5,8,6,9,1,2],[9,6,5,4,1,2,8,3,7],[3,7,1,2,5,9,6,4,8],[2,5,4,3,6,8,7,9,1],[6,8,9,7,4,1,3,2,5]]
1044	[[9,7,8,6,5,1,3,2,4],[1,2,4,3,9,8,7,5,6],[3,6,5,2,4,7,1,8,9],[2,1,3,9,7,6,5,4,8],[8,4,6,5,1,3,9,7,2],[5,9,7,8,2,4,6,3,1],[7,3,2,1,8,9,4,6,5],[6,5,1,4,3,2,8,9,7],[4,8,9,7,6,5,2,1,3]]
1045	[[6,5,3,4,9,8,7,1,2],[2,8,7,1,3,6,5,9,4],[4,9,1,7,5,2,8,6,3],[7,6,5,9,1,3,2,4,8],[8,1,4,2,6,7,9,3,5],[9,3,2,5,8,4,1,7,6],[5,4,8,3,7,1,6,2,9],[1,2,6,8,4,9,3,5,7],[3,7,9,6,2,5,4,8,1]]
1046	[[3,9,8,7,1,5,6,2,4],[4,5,6,3,2,8,1,7,9],[2,7,1,4,9,6,3,8,5],[8,3,9,2,7,1,4,5,6],[1,6,7,5,8,4,9,3,2],[5,2,4,9,6,3,8,1,7],[9,1,3,6,5,7,2,4,8],[7,8,2,1,4,9,5,6,3],[6,4,5,8,3,2,7,9,1]]
1047	[[8,4,7,2,5,1,6,9,3],[2,9,3,4,6,7,8,5,1],[6,1,5,3,8,9,2,7,4],[1,3,6,7,2,4,5,8,9],[9,8,4,5,3,6,7,1,2],[5,7,2,1,9,8,4,3,6],[4,5,8,9,1,2,3,6,7],[3,2,9,6,7,5,1,4,8],[7,6,1,8,4,3,9,2,5]]
1048	[[3,7,5,9,4,2,6,1,8],[6,8,1,7,3,5,9,2,4],[9,4,2,1,6,8,5,7,3],[5,9,8,2,1,6,3,4,7],[2,1,6,3,7,4,8,9,5],[7,3,4,5,8,9,1,6,2],[1,2,3,6,5,7,4,8,9],[8,6,7,4,9,3,2,5,1],[4,5,9,8,2,1,7,3,6]]
1049	[[9,1,5,6,8,3,4,7,2],[4,8,2,5,7,9,3,1,6],[6,7,3,1,2,4,9,8,5],[2,9,1,4,3,7,5,6,8],[5,3,8,9,6,1,2,4,7],[7,4,6,8,5,2,1,3,9],[8,2,9,3,1,6,7,5,4],[1,5,7,2,4,8,6,9,3],[3,6,4,7,9,5,8,2,1]]
1050	[[6,9,5,7,4,8,3,2,1],[3,1,4,2,9,6,7,5,8],[8,7,2,1,5,3,4,6,9],[7,5,8,9,2,1,6,3,4],[9,2,1,6,3,4,8,7,5],[4,6,3,5,8,7,1,9,2],[5,4,7,3,1,2,9,8,6],[2,8,6,4,7,9,5,1,3],[1,3,9,8,6,5,2,4,7]]
1051	[[8,2,5,6,3,1,7,4,9],[7,4,6,5,9,8,1,2,3],[3,1,9,7,2,4,8,6,5],[4,6,8,9,1,3,5,7,2],[5,9,3,8,7,2,6,1,4],[2,7,1,4,6,5,3,9,8],[9,3,2,1,5,6,4,8,7],[1,5,4,2,8,7,9,3,6],[6,8,7,3,4,9,2,5,1]]
1052	[[4,5,1,7,6,2,8,9,3],[2,3,7,8,5,9,1,6,4],[6,9,8,1,4,3,5,7,2],[5,1,9,4,3,7,2,8,6],[7,4,6,9,2,8,3,1,5],[8,2,3,6,1,5,9,4,7],[1,7,2,3,9,4,6,5,8],[3,6,4,5,8,1,7,2,9],[9,8,5,2,7,6,4,3,1]]
1053	[[4,6,5,2,7,8,3,9,1],[1,9,7,3,6,5,4,8,2],[8,2,3,4,9,1,7,6,5],[3,1,4,6,8,9,2,5,7],[9,5,6,7,1,2,8,4,3],[2,7,8,5,4,3,6,1,9],[5,4,1,8,3,7,9,2,6],[6,3,2,9,5,4,1,7,8],[7,8,9,1,2,6,5,3,4]]
1054	[[7,8,2,3,4,5,9,6,1],[3,4,6,1,8,9,2,7,5],[5,1,9,7,6,2,3,4,8],[6,9,7,4,1,3,8,5,2],[1,5,8,6,2,7,4,9,3],[4,2,3,5,9,8,7,1,6],[9,3,4,2,5,6,1,8,7],[2,6,1,8,7,4,5,3,9],[8,7,5,9,3,1,6,2,4]]
1055	[[2,3,5,6,9,8,1,4,7],[7,1,6,4,3,2,8,5,9],[8,4,9,5,1,7,6,2,3],[4,9,7,8,2,3,5,6,1],[5,2,1,7,6,4,3,9,8],[6,8,3,1,5,9,2,7,4],[3,5,8,9,7,6,4,1,2],[1,7,4,2,8,5,9,3,6],[9,6,2,3,4,1,7,8,5]]
1056	[[3,6,4,8,5,7,1,9,2],[7,8,1,2,4,9,3,5,6],[5,2,9,6,3,1,4,8,7],[1,3,5,9,7,6,8,2,4],[4,9,8,5,1,2,6,7,3],[2,7,6,4,8,3,5,1,9],[6,1,3,7,2,8,9,4,5],[9,4,7,1,6,5,2,3,8],[8,5,2,3,9,4,7,6,1]]
1057	[[5,3,1,8,9,6,4,2,7],[8,4,7,5,1,2,6,3,9],[6,2,9,3,4,7,1,8,5],[1,6,2,4,3,9,5,7,8],[4,5,3,7,2,8,9,1,6],[9,7,8,6,5,1,2,4,3],[2,8,4,9,6,3,7,5,1],[7,1,6,2,8,5,3,9,4],[3,9,5,1,7,4,8,6,2]]
1058	[[4,7,2,5,8,3,9,6,1],[9,8,3,6,1,7,4,2,5],[5,1,6,4,2,9,8,7,3],[6,4,5,1,9,8,2,3,7],[2,3,1,7,4,6,5,9,8],[8,9,7,3,5,2,6,1,4],[1,6,8,9,7,5,3,4,2],[3,2,4,8,6,1,7,5,9],[7,5,9,2,3,4,1,8,6]]
1059	[[6,9,1,3,8,4,2,5,7],[4,8,2,7,6,5,9,3,1],[7,5,3,1,2,9,4,8,6],[9,6,8,2,5,1,3,7,4],[1,2,5,4,3,7,8,6,9],[3,4,7,8,9,6,5,1,2],[2,7,4,5,1,8,6,9,3],[8,1,6,9,4,3,7,2,5],[5,3,9,6,7,2,1,4,8]]
1060	[[8,7,9,1,6,5,4,3,2],[2,6,5,4,8,3,1,9,7],[4,1,3,2,7,9,5,6,8],[9,4,7,3,5,2,6,8,1],[1,5,8,7,9,6,3,2,4],[3,2,6,8,4,1,9,7,5],[5,3,4,9,2,8,7,1,6],[7,9,2,6,1,4,8,5,3],[6,8,1,5,3,7,2,4,9]]
1061	[[8,6,7,5,1,2,4,3,9],[5,9,3,8,4,6,2,7,1],[4,1,2,7,3,9,8,5,6],[7,4,5,6,2,1,3,9,8],[9,2,1,3,8,4,5,6,7],[6,3,8,9,5,7,1,4,2],[2,7,4,1,6,3,9,8,5],[3,8,6,2,9,5,7,1,4],[1,5,9,4,7,8,6,2,3]]
1062	[[6,2,7,9,4,3,5,1,8],[4,5,3,8,1,2,9,6,7],[8,1,9,5,7,6,3,4,2],[2,4,8,6,3,9,7,5,1],[3,7,6,1,5,4,8,2,9],[5,9,1,2,8,7,4,3,6],[1,3,2,7,9,5,6,8,4],[7,8,5,4,6,1,2,9,3],[9,6,4,3,2,8,1,7,5]]
1063	[[5,9,1,8,4,6,7,2,3],[8,3,4,9,2,7,5,1,6],[6,2,7,3,5,1,9,8,4],[7,1,8,5,3,4,6,9,2],[9,4,5,7,6,2,8,3,1],[2,6,3,1,8,9,4,7,5],[4,7,2,6,1,8,3,5,9],[1,5,9,4,7,3,2,6,8],[3,8,6,2,9,5,1,4,7]]
1064	[[9,1,2,8,4,3,6,7,5],[5,4,6,7,9,1,2,3,8],[7,3,8,5,6,2,4,1,9],[8,2,3,6,5,9,7,4,1],[4,6,5,1,2,7,8,9,3],[1,9,7,4,3,8,5,2,6],[3,5,4,2,1,6,9,8,7],[6,8,9,3,7,4,1,5,2],[2,7,1,9,8,5,3,6,4]]
1065	[[2,5,1,9,3,6,4,7,8],[4,7,9,8,2,1,3,5,6],[3,6,8,7,5,4,2,9,1],[5,3,2,4,1,8,7,6,9],[1,9,7,2,6,5,8,4,3],[8,4,6,3,9,7,1,2,5],[7,2,5,6,8,3,9,1,4],[9,1,3,5,4,2,6,8,7],[6,8,4,1,7,9,5,3,2]]
1066	[[3,8,6,4,2,9,1,5,7],[1,2,7,5,8,3,9,4,6],[4,5,9,6,7,1,2,3,8],[2,7,4,1,5,6,8,9,3],[5,3,8,7,9,2,4,6,1],[6,9,1,3,4,8,5,7,2],[7,4,3,2,1,5,6,8,9],[8,6,2,9,3,4,7,1,5],[9,1,5,8,6,7,3,2,4]]
1067	[[5,2,1,8,9,6,7,4,3],[9,4,7,2,3,1,6,5,8],[3,6,8,5,7,4,1,2,9],[8,9,3,7,6,5,2,1,4],[2,5,4,9,1,8,3,6,7],[1,7,6,4,2,3,9,8,5],[7,8,2,6,5,9,4,3,1],[4,1,9,3,8,2,5,7,6],[6,3,5,1,4,7,8,9,2]]
1068	[[9,5,8,4,6,7,2,1,3],[1,7,3,9,2,5,6,4,8],[4,2,6,8,3,1,7,5,9],[2,6,5,3,7,8,4,9,1],[3,4,9,5,1,6,8,2,7],[8,1,7,2,9,4,3,6,5],[7,8,1,6,4,9,5,3,2],[6,9,2,7,5,3,1,8,4],[5,3,4,1,8,2,9,7,6]]
1069	[[2,4,8,6,1,3,9,5,7],[7,3,6,5,9,8,1,4,2],[9,5,1,7,4,2,3,6,8],[1,8,7,4,2,6,5,3,9],[4,2,9,3,7,5,8,1,6],[5,6,3,1,8,9,7,2,4],[6,9,4,8,5,1,2,7,3],[3,1,2,9,6,7,4,8,5],[8,7,5,2,3,4,6,9,1]]
1070	[[7,4,8,5,3,2,9,6,1],[5,1,6,8,9,4,2,3,7],[3,9,2,1,7,6,5,8,4],[6,2,9,7,4,5,8,1,3],[8,3,4,2,1,9,7,5,6],[1,5,7,6,8,3,4,9,2],[4,6,5,3,2,8,1,7,9],[2,8,1,9,6,7,3,4,5],[9,7,3,4,5,1,6,2,8]]
1071	[[1,6,2,3,4,7,8,9,5],[3,9,5,6,1,8,4,2,7],[7,8,4,5,2,9,1,3,6],[5,4,6,1,7,2,3,8,9],[9,3,7,4,8,5,2,6,1],[2,1,8,9,6,3,7,5,4],[6,2,3,7,5,1,9,4,8],[4,7,9,8,3,6,5,1,2],[8,5,1,2,9,4,6,7,3]]
1072	[[4,3,2,9,1,5,7,6,8],[5,1,6,8,7,2,9,3,4],[7,9,8,4,6,3,2,1,5],[6,2,9,3,4,7,5,8,1],[1,5,3,2,8,9,4,7,6],[8,4,7,6,5,1,3,2,9],[3,7,5,1,9,6,8,4,2],[2,8,1,5,3,4,6,9,7],[9,6,4,7,2,8,1,5,3]]
1073	[[6,2,5,3,1,9,8,4,7],[8,3,7,6,4,2,1,9,5],[1,9,4,5,7,8,3,2,6],[5,8,1,7,9,6,2,3,4],[2,4,9,1,5,3,6,7,8],[3,7,6,8,2,4,9,5,1],[4,6,8,9,3,7,5,1,2],[7,1,3,2,6,5,4,8,9],[9,5,2,4,8,1,7,6,3]]
1074	[[7,8,5,1,6,3,2,9,4],[6,9,4,8,2,7,3,1,5],[2,1,3,9,5,4,6,8,7],[8,2,9,7,3,1,5,4,6],[1,5,6,4,8,2,9,7,3],[4,3,7,6,9,5,1,2,8],[3,7,2,5,1,8,4,6,9],[5,6,8,2,4,9,7,3,1],[9,4,1,3,7,6,8,5,2]]
1075	[[7,5,3,9,8,4,1,6,2],[8,2,1,6,5,3,7,4,9],[9,4,6,2,1,7,5,3,8],[2,3,9,4,7,6,8,1,5],[1,6,5,3,2,8,4,9,7],[4,8,7,1,9,5,3,2,6],[5,1,4,8,6,9,2,7,3],[3,9,8,7,4,2,6,5,1],[6,7,2,5,3,1,9,8,4]]
1076	[[5,3,7,1,8,6,9,2,4],[4,8,9,2,7,5,6,1,3],[6,2,1,4,3,9,5,7,8],[8,4,2,6,5,1,3,9,7],[3,1,6,7,9,8,2,4,5],[9,7,5,3,2,4,8,6,1],[1,6,8,5,4,2,7,3,9],[2,9,3,8,1,7,4,5,6],[7,5,4,9,6,3,1,8,2]]
1077	[[1,7,3,2,5,4,9,8,6],[2,9,8,1,6,7,5,3,4],[4,5,6,9,8,3,1,2,7],[6,2,1,3,4,9,8,7,5],[3,8,7,6,1,5,4,9,2],[9,4,5,8,7,2,6,1,3],[7,1,9,5,3,6,2,4,8],[8,6,4,7,2,1,3,5,9],[5,3,2,4,9,8,7,6,1]]
1078	[[2,1,3,8,4,9,6,7,5],[8,6,4,5,7,3,2,9,1],[5,9,7,2,1,6,4,8,3],[6,2,5,4,9,7,1,3,8],[9,4,1,3,2,8,7,5,6],[3,7,8,1,6,5,9,2,4],[1,5,2,9,3,4,8,6,7],[7,3,9,6,8,1,5,4,2],[4,8,6,7,5,2,3,1,9]]
1079	[[5,1,6,7,2,4,8,3,9],[2,4,8,9,3,5,6,7,1],[9,3,7,8,6,1,4,2,5],[6,9,4,2,5,7,3,1,8],[8,2,1,3,4,6,5,9,7],[7,5,3,1,9,8,2,4,6],[4,8,9,6,1,3,7,5,2],[1,7,5,4,8,2,9,6,3],[3,6,2,5,7,9,1,8,4]]
1080	[[6,3,9,7,8,5,4,2,1],[7,5,4,1,2,6,9,3,8],[1,2,8,3,9,4,5,7,6],[4,6,5,2,1,3,8,9,7],[8,1,3,6,7,9,2,5,4],[9,7,2,5,4,8,1,6,3],[2,4,6,8,5,7,3,1,9],[3,8,1,9,6,2,7,4,5],[5,9,7,4,3,1,6,8,2]]
1081	[[2,6,3,8,4,9,7,1,5],[5,8,9,1,7,6,2,4,3],[4,1,7,5,2,3,9,6,8],[8,4,6,2,1,7,5,3,9],[3,2,1,9,8,5,6,7,4],[7,9,5,3,6,4,8,2,1],[1,5,4,7,9,2,3,8,6],[6,3,2,4,5,8,1,9,7],[9,7,8,6,3,1,4,5,2]]
1082	[[1,2,3,5,6,9,7,8,4],[4,6,8,3,7,1,2,5,9],[9,7,5,8,2,4,1,6,3],[7,5,4,2,3,8,9,1,6],[2,1,6,9,4,7,8,3,5],[3,8,9,1,5,6,4,2,7],[5,9,2,4,1,3,6,7,8],[6,4,1,7,8,5,3,9,2],[8,3,7,6,9,2,5,4,1]]
1083	[[9,6,3,5,7,2,4,8,1],[1,5,2,8,4,3,6,9,7],[7,8,4,9,1,6,2,5,3],[3,4,8,6,2,9,7,1,5],[5,2,1,4,8,7,3,6,9],[6,7,9,3,5,1,8,2,4],[8,3,5,2,9,4,1,7,6],[2,1,6,7,3,5,9,4,8],[4,9,7,1,6,8,5,3,2]]
1084	[[1,8,3,2,7,5,9,4,6],[6,2,7,9,4,8,3,1,5],[4,9,5,6,3,1,2,8,7],[8,7,6,3,1,4,5,2,9],[9,5,1,8,2,6,4,7,3],[3,4,2,7,5,9,1,6,8],[5,6,4,1,8,3,7,9,2],[7,1,9,5,6,2,8,3,4],[2,3,8,4,9,7,6,5,1]]
1085	[[3,9,6,2,5,7,8,4,1],[8,4,5,9,1,3,2,6,7],[2,1,7,6,8,4,9,3,5],[1,2,3,8,4,9,7,5,6],[4,6,9,5,7,2,3,1,8],[5,7,8,1,3,6,4,2,9],[6,8,4,7,2,5,1,9,3],[7,5,2,3,9,1,6,8,4],[9,3,1,4,6,8,5,7,2]]
1086	[[3,1,9,5,4,7,2,6,8],[8,4,2,9,6,3,5,1,7],[6,5,7,2,1,8,3,4,9],[1,6,4,7,2,9,8,5,3],[2,9,8,3,5,1,6,7,4],[7,3,5,4,8,6,9,2,1],[9,7,6,1,3,2,4,8,5],[4,8,1,6,9,5,7,3,2],[5,2,3,8,7,4,1,9,6]]
1087	[[3,9,5,7,8,1,4,6,2],[6,2,7,5,4,3,8,9,1],[8,1,4,6,9,2,5,3,7],[7,8,2,4,3,5,6,1,9],[4,3,6,9,1,7,2,5,8],[9,5,1,8,2,6,3,7,4],[1,6,3,2,7,4,9,8,5],[2,7,9,3,5,8,1,4,6],[5,4,8,1,6,9,7,2,3]]
1088	[[5,6,2,1,7,3,4,8,9],[7,8,1,5,9,4,3,2,6],[9,3,4,8,2,6,7,5,1],[1,4,9,7,3,5,8,6,2],[6,5,8,4,1,2,9,3,7],[2,7,3,9,6,8,1,4,5],[4,2,7,6,8,9,5,1,3],[8,1,6,3,5,7,2,9,4],[3,9,5,2,4,1,6,7,8]]
1089	[[4,9,5,2,6,7,3,1,8],[3,6,8,9,5,1,2,4,7],[1,7,2,8,3,4,6,5,9],[8,4,9,7,2,6,1,3,5],[2,5,7,3,1,8,4,9,6],[6,3,1,5,4,9,8,7,2],[5,8,3,4,9,2,7,6,1],[7,1,4,6,8,5,9,2,3],[9,2,6,1,7,3,5,8,4]]
1090	[[7,6,3,1,5,4,2,8,9],[4,2,5,6,9,8,3,7,1],[1,8,9,2,3,7,6,5,4],[5,9,7,3,6,2,1,4,8],[2,3,4,8,1,5,9,6,7],[8,1,6,4,7,9,5,2,3],[6,4,8,9,2,1,7,3,5],[3,5,1,7,8,6,4,9,2],[9,7,2,5,4,3,8,1,6]]
1091	[[5,9,8,3,4,1,6,2,7],[3,4,1,6,7,2,8,5,9],[7,2,6,5,8,9,1,3,4],[2,1,7,8,6,3,4,9,5],[9,8,4,7,1,5,3,6,2],[6,5,3,2,9,4,7,1,8],[8,3,9,1,2,7,5,4,6],[1,7,2,4,5,6,9,8,3],[4,6,5,9,3,8,2,7,1]]
1092	[[2,4,8,6,9,3,7,5,1],[7,6,3,8,1,5,4,2,9],[5,9,1,4,7,2,6,3,8],[6,3,7,1,5,8,9,4,2],[4,8,5,2,6,9,1,7,3],[9,1,2,7,3,4,8,6,5],[3,5,6,9,4,1,2,8,7],[1,2,4,5,8,7,3,9,6],[8,7,9,3,2,6,5,1,4]]
1093	[[4,5,1,3,7,6,8,2,9],[9,7,3,1,2,8,5,4,6],[8,2,6,9,4,5,7,1,3],[2,6,8,5,1,4,9,3,7],[5,9,7,6,3,2,4,8,1],[3,1,4,8,9,7,2,6,5],[1,4,5,2,6,9,3,7,8],[6,8,2,7,5,3,1,9,4],[7,3,9,4,8,1,6,5,2]]
1094	[[8,9,4,7,3,6,5,2,1],[6,1,2,8,5,9,4,7,3],[3,7,5,1,4,2,8,9,6],[1,4,7,6,9,3,2,5,8],[9,8,6,2,1,5,7,3,4],[5,2,3,4,7,8,1,6,9],[7,3,8,9,2,4,6,1,5],[2,6,9,5,8,1,3,4,7],[4,5,1,3,6,7,9,8,2]]
1095	[[9,3,6,5,4,8,1,2,7],[1,8,7,3,2,6,5,4,9],[5,2,4,7,1,9,3,8,6],[3,5,1,9,7,2,8,6,4],[6,4,2,8,3,5,7,9,1],[7,9,8,4,6,1,2,5,3],[4,1,9,2,8,7,6,3,5],[8,6,3,1,5,4,9,7,2],[2,7,5,6,9,3,4,1,8]]
1096	[[8,6,2,1,4,9,7,3,5],[3,1,5,7,6,2,8,4,9],[9,7,4,8,3,5,1,6,2],[4,5,6,9,2,7,3,8,1],[2,8,3,5,1,4,9,7,6],[1,9,7,3,8,6,2,5,4],[5,3,1,4,9,8,6,2,7],[6,4,9,2,7,3,5,1,8],[7,2,8,6,5,1,4,9,3]]
1097	[[1,6,7,4,8,2,9,3,5],[8,5,3,9,7,1,2,4,6],[2,4,9,3,5,6,8,7,1],[9,7,6,5,3,8,4,1,2],[3,2,5,1,9,4,7,6,8],[4,1,8,2,6,7,3,5,9],[5,9,4,8,1,3,6,2,7],[7,3,1,6,2,9,5,8,4],[6,8,2,7,4,5,1,9,3]]
1098	[[5,1,6,3,4,2,7,9,8],[7,2,9,8,6,5,3,1,4],[8,3,4,7,9,1,6,5,2],[3,8,7,4,2,9,5,6,1],[6,4,1,5,3,8,2,7,9],[2,9,5,1,7,6,4,8,3],[1,6,2,9,5,3,8,4,7],[9,7,3,6,8,4,1,2,5],[4,5,8,2,1,7,9,3,6]]
1099	[[6,7,9,5,2,4,1,3,8],[1,3,8,6,9,7,5,2,4],[4,5,2,8,3,1,7,9,6],[8,6,1,9,5,3,2,4,7],[2,9,7,4,8,6,3,1,5],[5,4,3,7,1,2,8,6,9],[9,2,4,1,7,5,6,8,3],[7,1,6,3,4,8,9,5,2],[3,8,5,2,6,9,4,7,1]]
1100	[[6,5,7,3,1,4,9,8,2],[1,3,2,8,9,5,6,4,7],[8,4,9,7,6,2,1,5,3],[2,8,1,9,5,7,3,6,4],[3,7,6,4,2,1,8,9,5],[4,9,5,6,3,8,2,7,1],[5,2,4,1,8,6,7,3,9],[9,1,8,5,7,3,4,2,6],[7,6,3,2,4,9,5,1,8]]
1101	[[5,7,6,3,4,2,1,8,9],[2,9,8,6,1,5,7,3,4],[4,3,1,9,7,8,5,6,2],[3,6,4,2,9,7,8,1,5],[1,8,2,4,5,6,9,7,3],[9,5,7,1,8,3,4,2,6],[6,4,5,8,2,1,3,9,7],[7,1,3,5,6,9,2,4,8],[8,2,9,7,3,4,6,5,1]]
1102	[[6,5,4,3,8,9,7,2,1],[2,1,3,4,5,7,8,6,9],[8,9,7,2,1,6,4,3,5],[3,7,6,9,2,1,5,4,8],[1,2,5,8,7,4,3,9,6],[4,8,9,5,6,3,2,1,7],[5,6,1,7,4,2,9,8,3],[7,3,2,6,9,8,1,5,4],[9,4,8,1,3,5,6,7,2]]
1103	[[6,7,5,8,9,3,1,4,2],[3,1,4,7,2,5,9,6,8],[8,2,9,4,1,6,3,7,5],[4,3,7,1,6,2,8,5,9],[2,6,8,9,5,4,7,1,3],[5,9,1,3,7,8,4,2,6],[7,8,2,6,4,9,5,3,1],[9,4,6,5,3,1,2,8,7],[1,5,3,2,8,7,6,9,4]]
1104	[[2,4,3,8,5,1,6,9,7],[6,1,9,3,4,7,8,5,2],[8,7,5,2,9,6,1,3,4],[7,3,6,5,2,9,4,8,1],[9,8,1,7,6,4,3,2,5],[4,5,2,1,8,3,9,7,6],[3,6,8,4,7,5,2,1,9],[5,2,4,9,1,8,7,6,3],[1,9,7,6,3,2,5,4,8]]
1105	[[5,2,1,4,8,3,6,9,7],[9,7,3,1,2,6,5,4,8],[8,4,6,9,5,7,2,3,1],[3,9,4,7,1,5,8,6,2],[2,8,5,6,9,4,1,7,3],[1,6,7,8,3,2,9,5,4],[6,3,9,2,4,8,7,1,5],[4,1,8,5,7,9,3,2,6],[7,5,2,3,6,1,4,8,9]]
1106	[[6,3,4,7,1,8,5,9,2],[7,8,9,2,3,5,1,6,4],[5,1,2,6,9,4,8,7,3],[9,7,6,8,4,2,3,5,1],[1,2,8,3,5,9,7,4,6],[3,4,5,1,6,7,9,2,8],[4,9,3,5,8,6,2,1,7],[2,5,1,4,7,3,6,8,9],[8,6,7,9,2,1,4,3,5]]
1107	[[8,1,9,6,5,3,7,4,2],[7,3,2,1,8,4,9,5,6],[6,5,4,7,2,9,1,8,3],[3,8,1,4,7,5,6,2,9],[9,2,5,8,1,6,3,7,4],[4,6,7,3,9,2,8,1,5],[5,4,8,9,6,1,2,3,7],[1,9,3,2,4,7,5,6,8],[2,7,6,5,3,8,4,9,1]]
1108	[[9,5,1,8,4,2,6,7,3],[8,4,7,5,6,3,9,1,2],[2,3,6,9,1,7,5,8,4],[7,1,2,4,3,9,8,5,6],[3,9,5,6,7,8,2,4,1],[4,6,8,1,2,5,3,9,7],[5,7,3,2,9,4,1,6,8],[1,8,4,3,5,6,7,2,9],[6,2,9,7,8,1,4,3,5]]
1109	[[7,1,2,6,8,3,5,4,9],[8,9,6,4,5,7,3,2,1],[5,3,4,1,2,9,7,8,6],[4,5,1,2,9,8,6,3,7],[3,8,7,5,6,1,4,9,2],[2,6,9,7,3,4,1,5,8],[6,7,3,8,4,2,9,1,5],[1,4,8,9,7,5,2,6,3],[9,2,5,3,1,6,8,7,4]]
1110	[[6,2,1,7,8,3,5,9,4],[8,4,7,2,5,9,3,6,1],[3,5,9,6,1,4,2,7,8],[9,8,5,4,7,1,6,2,3],[1,6,3,9,2,8,4,5,7],[2,7,4,5,3,6,8,1,9],[5,1,8,3,9,2,7,4,6],[7,3,6,1,4,5,9,8,2],[4,9,2,8,6,7,1,3,5]]
1111	[[1,8,9,7,4,5,3,2,6],[7,3,2,6,8,1,4,9,5],[5,6,4,2,9,3,1,7,8],[4,1,6,9,5,7,2,8,3],[2,7,8,3,6,4,5,1,9],[9,5,3,1,2,8,7,6,4],[6,2,5,4,1,9,8,3,7],[8,9,7,5,3,2,6,4,1],[3,4,1,8,7,6,9,5,2]]
1112	[[5,2,9,3,4,8,6,7,1],[7,8,1,2,9,6,4,5,3],[3,4,6,5,7,1,9,8,2],[9,3,7,1,8,4,5,2,6],[8,6,2,7,5,9,1,3,4],[1,5,4,6,3,2,7,9,8],[6,9,3,4,2,5,8,1,7],[2,1,5,8,6,7,3,4,9],[4,7,8,9,1,3,2,6,5]]
1113	[[8,4,1,6,7,2,3,9,5],[2,9,6,3,1,5,4,8,7],[5,3,7,9,4,8,6,1,2],[6,7,2,1,3,9,5,4,8],[4,5,8,7,2,6,9,3,1],[9,1,3,8,5,4,7,2,6],[7,8,9,2,6,3,1,5,4],[3,6,5,4,8,1,2,7,9],[1,2,4,5,9,7,8,6,3]]
1114	[[9,5,4,1,7,2,6,8,3],[2,7,1,3,8,6,4,9,5],[3,6,8,9,5,4,1,7,2],[6,4,2,5,9,3,7,1,8],[7,1,3,6,4,8,5,2,9],[5,8,9,7,2,1,3,4,6],[1,3,7,2,6,9,8,5,4],[4,9,6,8,1,5,2,3,7],[8,2,5,4,3,7,9,6,1]]
1115	[[4,2,6,1,3,8,5,9,7],[1,8,7,9,5,4,2,3,6],[9,3,5,7,2,6,4,8,1],[3,4,8,2,9,7,6,1,5],[5,7,9,6,8,1,3,2,4],[6,1,2,5,4,3,9,7,8],[7,9,1,3,6,5,8,4,2],[8,5,3,4,7,2,1,6,9],[2,6,4,8,1,9,7,5,3]]
1116	[[9,7,8,1,6,3,2,4,5],[6,3,4,2,7,5,9,1,8],[5,2,1,4,8,9,3,7,6],[1,4,5,7,9,2,6,8,3],[7,9,3,8,5,6,1,2,4],[8,6,2,3,4,1,7,5,9],[4,1,7,6,3,8,5,9,2],[3,8,9,5,2,7,4,6,1],[2,5,6,9,1,4,8,3,7]]
1117	[[8,2,4,6,7,9,1,5,3],[1,3,6,5,8,2,7,9,4],[5,9,7,1,3,4,8,2,6],[7,4,9,3,2,5,6,8,1],[2,6,8,4,1,7,5,3,9],[3,5,1,9,6,8,4,7,2],[9,1,5,8,4,3,2,6,7],[6,8,2,7,9,1,3,4,5],[4,7,3,2,5,6,9,1,8]]
1118	[[1,9,7,2,3,8,5,4,6],[3,6,4,1,5,9,2,8,7],[8,2,5,7,4,6,3,9,1],[5,1,2,6,8,7,4,3,9],[7,4,3,5,9,2,1,6,8],[6,8,9,4,1,3,7,2,5],[4,7,8,3,6,1,9,5,2],[9,5,1,8,2,4,6,7,3],[2,3,6,9,7,5,8,1,4]]
1119	[[5,9,1,7,4,6,3,2,8],[8,2,7,3,9,5,1,4,6],[6,4,3,2,1,8,5,7,9],[4,1,5,6,2,9,7,8,3],[3,6,8,5,7,1,4,9,2],[9,7,2,8,3,4,6,5,1],[2,3,9,4,6,7,8,1,5],[7,8,6,1,5,2,9,3,4],[1,5,4,9,8,3,2,6,7]]
1120	[[4,3,7,9,5,6,2,8,1],[1,5,6,8,2,7,9,4,3],[8,2,9,1,4,3,7,6,5],[5,9,3,4,7,1,6,2,8],[2,4,8,6,9,5,1,3,7],[7,6,1,3,8,2,4,5,9],[3,7,5,2,6,9,8,1,4],[6,1,4,7,3,8,5,9,2],[9,8,2,5,1,4,3,7,6]]
1121	[[7,8,4,2,9,1,5,3,6],[2,3,9,5,6,7,4,1,8],[1,5,6,3,8,4,2,9,7],[3,4,8,6,2,5,1,7,9],[9,7,5,1,4,3,6,8,2],[6,1,2,9,7,8,3,4,5],[5,2,3,7,1,9,8,6,4],[8,6,7,4,3,2,9,5,1],[4,9,1,8,5,6,7,2,3]]
1122	[[1,4,5,7,6,3,2,9,8],[9,3,7,8,4,2,6,5,1],[6,8,2,5,1,9,7,4,3],[7,2,3,1,5,6,4,8,9],[4,9,1,3,8,7,5,2,6],[8,5,6,2,9,4,3,1,7],[5,6,9,4,7,1,8,3,2],[3,1,4,6,2,8,9,7,5],[2,7,8,9,3,5,1,6,4]]
1123	[[4,7,6,8,1,3,2,5,9],[2,1,8,6,5,9,4,3,7],[3,5,9,2,7,4,8,1,6],[1,9,2,5,8,7,3,6,4],[8,6,4,3,2,1,9,7,5],[5,3,7,4,9,6,1,2,8],[9,2,1,7,6,8,5,4,3],[7,8,3,1,4,5,6,9,2],[6,4,5,9,3,2,7,8,1]]
1124	[[8,9,1,5,7,4,3,2,6],[6,2,7,9,8,3,1,4,5],[3,4,5,1,2,6,9,7,8],[7,5,6,4,3,1,8,9,2],[4,8,3,2,5,9,6,1,7],[9,1,2,7,6,8,4,5,3],[5,6,9,3,1,2,7,8,4],[1,7,8,6,4,5,2,3,9],[2,3,4,8,9,7,5,6,1]]
1125	[[5,2,3,6,4,1,8,9,7],[1,4,9,8,3,7,6,2,5],[7,6,8,5,9,2,4,1,3],[4,9,2,7,1,3,5,6,8],[6,3,1,9,5,8,2,7,4],[8,7,5,4,2,6,1,3,9],[2,5,6,3,7,4,9,8,1],[9,8,7,1,6,5,3,4,2],[3,1,4,2,8,9,7,5,6]]
1126	[[3,4,2,7,5,1,9,8,6],[7,8,1,9,2,6,3,4,5],[6,5,9,3,8,4,2,1,7],[9,2,7,1,4,3,6,5,8],[5,6,8,2,9,7,4,3,1],[4,1,3,5,6,8,7,9,2],[2,9,6,4,1,5,8,7,3],[1,3,4,8,7,2,5,6,9],[8,7,5,6,3,9,1,2,4]]
1127	[[1,5,9,8,7,4,6,3,2],[3,4,6,5,9,2,7,1,8],[8,7,2,3,6,1,5,4,9],[5,2,7,4,8,3,1,9,6],[4,9,8,1,5,6,2,7,3],[6,1,3,9,2,7,4,8,5],[7,8,5,2,1,9,3,6,4],[2,3,1,6,4,8,9,5,7],[9,6,4,7,3,5,8,2,1]]
1128	[[5,2,7,3,9,1,8,6,4],[1,8,4,6,7,5,9,3,2],[3,6,9,4,2,8,5,7,1],[9,4,6,5,3,2,1,8,7],[8,5,3,9,1,7,4,2,6],[7,1,2,8,4,6,3,9,5],[4,3,1,7,6,9,2,5,8],[6,9,5,2,8,4,7,1,3],[2,7,8,1,5,3,6,4,9]]
1129	[[7,6,2,1,4,9,8,3,5],[8,4,5,3,7,2,1,6,9],[9,1,3,5,8,6,7,4,2],[5,3,9,7,6,1,2,8,4],[4,7,6,8,2,3,5,9,1],[1,2,8,9,5,4,3,7,6],[3,8,4,2,9,5,6,1,7],[6,5,1,4,3,7,9,2,8],[2,9,7,6,1,8,4,5,3]]
1130	[[7,3,2,9,5,1,6,4,8],[6,1,4,3,8,7,5,9,2],[8,9,5,2,6,4,7,1,3],[3,6,9,4,2,8,1,5,7],[1,2,7,5,3,9,4,8,6],[5,4,8,1,7,6,2,3,9],[4,8,1,6,9,2,3,7,5],[9,5,6,7,1,3,8,2,4],[2,7,3,8,4,5,9,6,1]]
1131	[[3,2,7,6,9,4,5,8,1],[9,8,5,1,7,3,4,6,2],[4,1,6,5,8,2,3,9,7],[8,6,2,4,3,1,9,7,5],[5,9,3,8,6,7,2,1,4],[1,7,4,9,2,5,6,3,8],[7,5,1,3,4,9,8,2,6],[2,3,8,7,5,6,1,4,9],[6,4,9,2,1,8,7,5,3]]
1132	[[3,9,4,1,2,8,7,5,6],[7,2,8,5,6,3,4,1,9],[1,6,5,4,9,7,2,3,8],[5,1,9,7,3,4,6,8,2],[8,4,2,6,1,9,5,7,3],[6,7,3,8,5,2,1,9,4],[2,3,6,9,7,1,8,4,5],[9,8,7,2,4,5,3,6,1],[4,5,1,3,8,6,9,2,7]]
1133	[[2,6,9,8,7,4,5,1,3],[3,8,5,2,1,9,4,7,6],[7,4,1,5,6,3,8,2,9],[9,1,2,6,5,8,7,3,4],[8,5,4,3,2,7,6,9,1],[6,3,7,9,4,1,2,5,8],[4,2,3,7,9,6,1,8,5],[5,9,6,1,8,2,3,4,7],[1,7,8,4,3,5,9,6,2]]
1134	[[5,9,1,3,2,6,7,4,8],[8,3,7,9,4,1,6,2,5],[6,2,4,5,7,8,3,9,1],[7,1,3,2,8,5,4,6,9],[2,8,9,4,6,3,5,1,7],[4,5,6,7,1,9,8,3,2],[3,4,2,1,5,7,9,8,6],[9,7,8,6,3,2,1,5,4],[1,6,5,8,9,4,2,7,3]]
1135	[[2,3,6,9,7,5,4,1,8],[5,8,4,2,1,6,3,9,7],[1,9,7,3,8,4,2,6,5],[4,5,9,7,2,3,1,8,6],[7,2,3,8,6,1,9,5,4],[8,6,1,4,5,9,7,2,3],[9,4,2,5,3,8,6,7,1],[6,7,5,1,4,2,8,3,9],[3,1,8,6,9,7,5,4,2]]
1136	[[1,5,7,8,2,3,6,4,9],[6,2,9,7,1,4,5,8,3],[8,4,3,9,6,5,2,1,7],[3,7,2,1,4,9,8,5,6],[5,6,4,3,7,8,1,9,2],[9,1,8,2,5,6,7,3,4],[7,3,1,5,9,2,4,6,8],[2,8,6,4,3,1,9,7,5],[4,9,5,6,8,7,3,2,1]]
1137	[[4,3,5,9,1,7,6,8,2],[9,7,6,5,2,8,1,4,3],[8,2,1,3,4,6,7,9,5],[2,4,8,1,5,9,3,6,7],[1,5,7,6,3,4,8,2,9],[3,6,9,8,7,2,5,1,4],[6,9,4,7,8,3,2,5,1],[5,8,3,2,9,1,4,7,6],[7,1,2,4,6,5,9,3,8]]
1138	[[2,6,5,3,8,1,4,7,9],[4,3,1,6,7,9,2,8,5],[9,8,7,5,4,2,6,1,3],[1,9,4,8,2,6,5,3,7],[3,2,8,9,5,7,1,6,4],[5,7,6,4,1,3,9,2,8],[6,4,9,1,3,8,7,5,2],[7,1,3,2,9,5,8,4,6],[8,5,2,7,6,4,3,9,1]]
1139	[[1,2,8,6,7,9,4,5,3],[7,9,3,5,2,4,1,8,6],[6,4,5,3,1,8,9,2,7],[5,6,4,7,9,1,8,3,2],[8,7,9,4,3,2,5,6,1],[3,1,2,8,5,6,7,9,4],[4,3,1,2,8,5,6,7,9],[2,5,6,9,4,7,3,1,8],[9,8,7,1,6,3,2,4,5]]
1140	[[2,1,8,3,6,7,4,5,9],[7,5,9,2,4,1,8,6,3],[6,4,3,5,9,8,7,2,1],[3,6,7,4,5,9,1,8,2],[9,8,4,1,3,2,5,7,6],[1,2,5,7,8,6,3,9,4],[4,7,1,9,2,5,6,3,8],[5,9,6,8,1,3,2,4,7],[8,3,2,6,7,4,9,1,5]]
1141	[[8,9,5,2,7,6,1,4,3],[4,7,3,9,1,5,2,8,6],[1,2,6,4,8,3,5,7,9],[9,5,2,6,3,4,7,1,8],[3,4,1,8,2,7,6,9,5],[6,8,7,1,5,9,3,2,4],[2,1,4,3,6,8,9,5,7],[5,6,8,7,9,2,4,3,1],[7,3,9,5,4,1,8,6,2]]
1142	[[6,8,2,7,5,1,4,9,3],[1,5,3,9,2,4,6,8,7],[7,4,9,6,8,3,5,1,2],[9,6,5,1,7,8,2,3,4],[3,1,8,2,4,5,7,6,9],[4,2,7,3,6,9,1,5,8],[2,3,1,5,9,7,8,4,6],[5,7,4,8,3,6,9,2,1],[8,9,6,4,1,2,3,7,5]]
1143	[[6,7,1,5,9,3,8,2,4],[3,4,5,6,8,2,9,1,7],[9,8,2,1,4,7,6,3,5],[1,3,7,8,2,6,5,4,9],[4,9,8,7,1,5,2,6,3],[5,2,6,9,3,4,7,8,1],[7,5,3,2,6,1,4,9,8],[8,6,4,3,5,9,1,7,2],[2,1,9,4,7,8,3,5,6]]
1144	[[1,9,4,8,7,2,6,3,5],[3,2,7,5,6,4,1,8,9],[6,5,8,1,3,9,4,7,2],[8,1,6,2,5,3,9,4,7],[5,7,2,4,9,1,3,6,8],[9,4,3,6,8,7,2,5,1],[4,3,5,9,1,8,7,2,6],[7,6,1,3,2,5,8,9,4],[2,8,9,7,4,6,5,1,3]]
1145	[[2,5,9,3,4,7,1,6,8],[3,1,6,5,8,2,4,9,7],[8,7,4,9,1,6,5,3,2],[7,4,1,6,3,5,8,2,9],[5,3,8,2,9,4,7,1,6],[9,6,2,8,7,1,3,5,4],[1,8,5,4,6,9,2,7,3],[6,2,3,7,5,8,9,4,1],[4,9,7,1,2,3,6,8,5]]
1146	[[2,3,1,4,8,7,5,6,9],[6,9,8,1,3,5,4,2,7],[4,5,7,6,2,9,1,3,8],[7,4,5,3,6,8,2,9,1],[3,8,2,9,5,1,6,7,4],[1,6,9,7,4,2,8,5,3],[5,2,4,8,7,3,9,1,6],[9,7,6,5,1,4,3,8,2],[8,1,3,2,9,6,7,4,5]]
1147	[[3,2,6,5,7,9,1,8,4],[9,8,7,1,6,4,5,3,2],[5,4,1,8,2,3,6,7,9],[8,3,5,7,1,2,4,9,6],[1,9,2,3,4,6,7,5,8],[7,6,4,9,5,8,2,1,3],[4,5,9,6,3,1,8,2,7],[6,7,8,2,9,5,3,4,1],[2,1,3,4,8,7,9,6,5]]
1148	[[4,9,7,1,5,3,6,2,8],[6,8,1,9,2,7,3,5,4],[3,2,5,8,6,4,9,7,1],[8,6,9,3,4,5,7,1,2],[1,5,4,7,9,2,8,6,3],[2,7,3,6,8,1,4,9,5],[7,1,2,4,3,6,5,8,9],[9,3,6,5,1,8,2,4,7],[5,4,8,2,7,9,1,3,6]]
1149	[[3,4,7,9,8,1,5,2,6],[9,6,1,2,5,4,7,8,3],[5,8,2,6,7,3,9,1,4],[4,9,8,5,6,7,1,3,2],[6,7,3,1,2,8,4,5,9],[2,1,5,4,3,9,8,6,7],[1,5,9,3,4,6,2,7,8],[7,3,4,8,1,2,6,9,5],[8,2,6,7,9,5,3,4,1]]
1150	[[5,6,4,3,7,2,8,1,9],[7,8,9,4,6,1,5,3,2],[3,2,1,8,9,5,4,7,6],[6,1,7,2,3,4,9,8,5],[4,9,2,5,8,7,1,6,3],[8,5,3,9,1,6,7,2,4],[1,3,8,6,5,9,2,4,7],[2,7,5,1,4,3,6,9,8],[9,4,6,7,2,8,3,5,1]]
1151	[[7,5,4,6,2,8,9,1,3],[2,6,1,3,5,9,8,4,7],[9,3,8,1,7,4,2,5,6],[8,9,5,7,3,6,1,2,4],[3,4,2,5,9,1,6,7,8],[1,7,6,4,8,2,5,3,9],[5,2,3,8,6,7,4,9,1],[6,1,9,2,4,3,7,8,5],[4,8,7,9,1,5,3,6,2]]
1152	[[5,7,4,1,9,6,8,2,3],[1,2,8,3,5,7,4,9,6],[3,6,9,4,8,2,7,5,1],[8,1,3,2,7,4,9,6,5],[9,4,6,5,3,1,2,7,8],[2,5,7,9,6,8,1,3,4],[7,8,2,6,4,5,3,1,9],[6,3,1,8,2,9,5,4,7],[4,9,5,7,1,3,6,8,2]]
1153	[[5,1,4,2,9,3,8,6,7],[7,9,8,5,6,4,1,2,3],[2,3,6,7,1,8,5,9,4],[4,7,3,1,8,6,9,5,2],[9,8,2,4,5,7,6,3,1],[1,6,5,9,3,2,4,7,8],[6,2,1,3,4,9,7,8,5],[3,4,9,8,7,5,2,1,6],[8,5,7,6,2,1,3,4,9]]
1154	[[2,4,7,1,8,5,9,3,6],[3,6,1,9,7,2,4,5,8],[5,9,8,4,6,3,1,2,7],[9,3,4,8,1,7,2,6,5],[1,5,6,2,3,4,7,8,9],[7,8,2,5,9,6,3,4,1],[6,7,9,3,4,8,5,1,2],[8,2,3,7,5,1,6,9,4],[4,1,5,6,2,9,8,7,3]]
1155	[[2,5,9,7,4,1,6,8,3],[7,6,1,3,5,8,9,2,4],[3,4,8,2,6,9,7,5,1],[9,1,2,4,3,7,5,6,8],[6,8,4,9,1,5,3,7,2],[5,3,7,8,2,6,4,1,9],[8,2,5,6,9,3,1,4,7],[4,9,6,1,7,2,8,3,5],[1,7,3,5,8,4,2,9,6]]
1156	[[1,3,2,4,7,5,8,6,9],[5,8,9,1,6,3,2,4,7],[7,6,4,8,9,2,1,5,3],[4,5,7,3,1,8,9,2,6],[3,9,8,7,2,6,4,1,5],[2,1,6,5,4,9,3,7,8],[9,4,1,6,8,7,5,3,2],[6,2,5,9,3,4,7,8,1],[8,7,3,2,5,1,6,9,4]]
1157	[[7,4,9,1,2,3,5,8,6],[2,1,5,8,7,6,3,4,9],[3,6,8,9,5,4,2,1,7],[6,9,2,7,1,5,8,3,4],[5,7,4,3,8,9,6,2,1],[8,3,1,4,6,2,9,7,5],[4,8,6,5,3,7,1,9,2],[9,5,3,2,4,1,7,6,8],[1,2,7,6,9,8,4,5,3]]
1158	[[3,1,8,4,2,9,7,5,6],[6,2,5,1,7,3,8,4,9],[4,9,7,6,8,5,3,2,1],[5,6,3,2,9,4,1,8,7],[9,7,4,8,1,6,5,3,2],[2,8,1,3,5,7,6,9,4],[8,4,6,7,3,2,9,1,5],[7,3,9,5,4,1,2,6,8],[1,5,2,9,6,8,4,7,3]]
1159	[[3,7,6,4,2,5,8,9,1],[5,1,8,3,7,9,4,6,2],[2,9,4,6,8,1,3,5,7],[1,6,9,7,3,2,5,4,8],[8,5,7,9,6,4,1,2,3],[4,2,3,1,5,8,9,7,6],[9,3,2,8,4,6,7,1,5],[7,4,5,2,1,3,6,8,9],[6,8,1,5,9,7,2,3,4]]
1160	[[5,9,1,4,8,7,6,2,3],[2,8,6,1,3,5,9,4,7],[3,4,7,9,2,6,8,5,1],[7,5,4,3,6,2,1,8,9],[6,2,9,8,5,1,7,3,4],[1,3,8,7,9,4,2,6,5],[4,7,5,6,1,8,3,9,2],[8,1,3,2,4,9,5,7,6],[9,6,2,5,7,3,4,1,8]]
1161	[[5,3,8,2,9,1,7,6,4],[6,9,7,5,8,4,1,3,2],[2,4,1,6,3,7,8,9,5],[4,6,5,9,7,3,2,1,8],[9,8,2,4,1,6,3,5,7],[1,7,3,8,5,2,9,4,6],[8,1,4,3,2,5,6,7,9],[7,5,9,1,6,8,4,2,3],[3,2,6,7,4,9,5,8,1]]
1162	[[6,8,9,5,7,3,4,1,2],[2,3,7,1,4,8,5,9,6],[1,5,4,2,6,9,7,8,3],[5,2,6,8,9,1,3,4,7],[8,9,3,4,5,7,2,6,1],[4,7,1,6,3,2,8,5,9],[7,1,5,3,8,6,9,2,4],[9,4,2,7,1,5,6,3,8],[3,6,8,9,2,4,1,7,5]]
1163	[[8,3,4,2,1,7,6,5,9],[5,6,9,8,3,4,7,2,1],[2,7,1,5,6,9,8,4,3],[4,2,5,9,7,1,3,8,6],[1,8,6,3,5,2,9,7,4],[7,9,3,4,8,6,5,1,2],[3,1,7,6,2,5,4,9,8],[9,5,8,1,4,3,2,6,7],[6,4,2,7,9,8,1,3,5]]
1164	[[8,9,6,3,1,4,7,2,5],[3,5,4,7,6,2,9,1,8],[1,2,7,9,5,8,3,4,6],[9,8,1,5,7,3,2,6,4],[5,6,3,4,2,1,8,9,7],[4,7,2,8,9,6,5,3,1],[7,3,5,1,4,9,6,8,2],[6,1,8,2,3,7,4,5,9],[2,4,9,6,8,5,1,7,3]]
1165	[[4,1,3,6,7,8,5,2,9],[9,8,7,5,4,2,1,3,6],[2,6,5,9,1,3,7,4,8],[3,9,4,2,5,1,8,6,7],[1,5,8,3,6,7,2,9,4],[7,2,6,4,8,9,3,1,5],[5,4,2,8,3,6,9,7,1],[6,3,1,7,9,5,4,8,2],[8,7,9,1,2,4,6,5,3]]
1166	[[1,7,3,2,5,8,9,6,4],[6,9,5,3,1,4,2,7,8],[8,4,2,6,9,7,1,3,5],[5,1,9,4,6,3,8,2,7],[7,3,8,9,2,5,6,4,1],[2,6,4,7,8,1,3,5,9],[3,2,1,5,4,9,7,8,6],[4,8,7,1,3,6,5,9,2],[9,5,6,8,7,2,4,1,3]]
1167	[[5,4,6,2,7,8,9,3,1],[2,1,3,9,5,6,4,7,8],[8,9,7,1,3,4,5,2,6],[4,6,8,5,9,7,3,1,2],[9,7,2,4,1,3,8,6,5],[3,5,1,6,8,2,7,9,4],[7,2,5,3,4,1,6,8,9],[6,3,4,8,2,9,1,5,7],[1,8,9,7,6,5,2,4,3]]
1168	[[2,5,8,3,7,6,4,9,1],[4,7,1,8,9,2,3,5,6],[9,3,6,1,5,4,8,7,2],[6,1,3,2,8,9,7,4,5],[8,4,9,5,1,7,6,2,3],[7,2,5,4,6,3,9,1,8],[1,9,2,6,4,8,5,3,7],[3,6,4,7,2,5,1,8,9],[5,8,7,9,3,1,2,6,4]]
1169	[[7,9,3,8,1,2,5,4,6],[5,2,8,4,6,9,7,1,3],[6,1,4,3,7,5,9,8,2],[3,8,5,2,4,6,1,9,7],[4,7,2,5,9,1,6,3,8],[1,6,9,7,3,8,2,5,4],[8,3,1,6,5,7,4,2,9],[9,4,7,1,2,3,8,6,5],[2,5,6,9,8,4,3,7,1]]
1170	[[4,6,1,9,5,7,8,3,2],[5,3,9,4,2,8,7,6,1],[8,2,7,6,3,1,9,5,4],[7,8,5,2,4,6,3,1,9],[9,1,6,8,7,3,4,2,5],[2,4,3,1,9,5,6,7,8],[1,9,4,7,6,2,5,8,3],[3,7,8,5,1,9,2,4,6],[6,5,2,3,8,4,1,9,7]]
1171	[[8,1,7,3,9,5,2,4,6],[6,9,2,4,7,8,1,3,5],[3,5,4,1,6,2,9,8,7],[1,2,9,5,3,7,4,6,8],[4,7,8,6,2,1,3,5,9],[5,3,6,8,4,9,7,2,1],[7,6,1,2,5,4,8,9,3],[9,4,5,7,8,3,6,1,2],[2,8,3,9,1,6,5,7,4]]
1172	[[3,7,5,4,1,8,2,6,9],[4,8,2,3,6,9,5,1,7],[9,1,6,7,2,5,4,3,8],[1,9,7,2,5,4,3,8,6],[5,6,4,8,9,3,1,7,2],[8,2,3,1,7,6,9,5,4],[7,3,9,6,4,1,8,2,5],[2,4,8,5,3,7,6,9,1],[6,5,1,9,8,2,7,4,3]]
1173	[[1,7,4,8,2,9,3,5,6],[8,3,5,6,7,1,4,2,9],[6,9,2,4,5,3,1,7,8],[4,8,3,1,9,5,2,6,7],[2,5,9,3,6,7,8,1,4],[7,6,1,2,4,8,9,3,5],[5,4,7,9,3,2,6,8,1],[9,2,8,5,1,6,7,4,3],[3,1,6,7,8,4,5,9,2]]
1174	[[5,7,9,8,6,2,1,4,3],[6,2,4,7,1,3,5,8,9],[1,8,3,4,9,5,7,2,6],[9,6,8,5,3,4,2,1,7],[7,3,2,9,8,1,4,6,5],[4,1,5,6,2,7,3,9,8],[2,9,1,3,5,8,6,7,4],[8,5,7,2,4,6,9,3,1],[3,4,6,1,7,9,8,5,2]]
1175	[[9,7,4,3,5,2,6,1,8],[1,8,2,4,7,6,3,9,5],[6,3,5,8,9,1,2,7,4],[4,1,3,2,8,5,9,6,7],[2,6,8,9,4,7,5,3,1],[5,9,7,1,6,3,4,8,2],[3,5,1,6,2,8,7,4,9],[8,2,9,7,3,4,1,5,6],[7,4,6,5,1,9,8,2,3]]
1176	[[2,1,5,4,7,6,8,9,3],[3,8,6,1,2,9,7,4,5],[7,4,9,3,5,8,6,2,1],[1,7,3,5,9,4,2,6,8],[6,5,8,2,1,7,4,3,9],[9,2,4,8,6,3,5,1,7],[8,9,2,7,4,1,3,5,6],[5,6,7,9,3,2,1,8,4],[4,3,1,6,8,5,9,7,2]]
1177	[[1,8,9,6,7,4,3,2,5],[3,6,4,2,5,9,1,7,8],[5,7,2,8,1,3,9,6,4],[2,5,1,9,3,7,4,8,6],[8,3,6,5,4,2,7,9,1],[4,9,7,1,8,6,2,5,3],[7,4,5,3,2,8,6,1,9],[9,2,8,4,6,1,5,3,7],[6,1,3,7,9,5,8,4,2]]
1178	[[6,2,1,9,4,8,5,7,3],[5,7,3,6,2,1,8,4,9],[8,9,4,7,3,5,1,6,2],[7,1,2,3,5,9,6,8,4],[4,3,8,1,6,2,9,5,7],[9,5,6,4,8,7,2,3,1],[3,4,5,2,1,6,7,9,8],[2,6,9,8,7,3,4,1,5],[1,8,7,5,9,4,3,2,6]]
1179	[[6,7,5,1,9,3,4,2,8],[1,3,2,8,7,4,5,9,6],[9,8,4,5,6,2,1,3,7],[3,4,7,6,2,9,8,5,1],[5,2,1,7,3,8,9,6,4],[8,9,6,4,5,1,3,7,2],[4,5,9,2,1,6,7,8,3],[2,1,3,9,8,7,6,4,5],[7,6,8,3,4,5,2,1,9]]
1180	[[9,7,8,6,1,2,4,3,5],[4,3,6,7,5,9,1,2,8],[1,2,5,8,3,4,7,6,9],[3,4,7,2,9,1,5,8,6],[5,6,2,3,8,7,9,1,4],[8,1,9,4,6,5,2,7,3],[7,8,1,9,4,6,3,5,2],[6,5,4,1,2,3,8,9,7],[2,9,3,5,7,8,6,4,1]]
1181	[[4,6,7,5,8,2,9,3,1],[1,8,2,6,9,3,4,7,5],[9,3,5,7,4,1,2,6,8],[2,5,8,9,6,4,7,1,3],[7,9,6,3,1,5,8,2,4],[3,1,4,2,7,8,6,5,9],[6,4,3,1,2,9,5,8,7],[8,7,1,4,5,6,3,9,2],[5,2,9,8,3,7,1,4,6]]
1182	[[2,8,3,4,9,5,7,1,6],[1,4,7,3,2,6,9,8,5],[5,9,6,8,7,1,3,2,4],[9,5,8,6,1,2,4,3,7],[3,7,4,5,8,9,2,6,1],[6,1,2,7,4,3,5,9,8],[4,6,5,2,3,8,1,7,9],[8,3,9,1,5,7,6,4,2],[7,2,1,9,6,4,8,5,3]]
1183	[[9,8,7,3,1,4,6,2,5],[6,3,1,9,5,2,7,8,4],[2,5,4,8,7,6,9,1,3],[8,7,5,1,4,3,2,9,6],[4,9,3,6,2,7,8,5,1],[1,6,2,5,9,8,4,3,7],[7,4,8,2,3,5,1,6,9],[5,1,6,7,8,9,3,4,2],[3,2,9,4,6,1,5,7,8]]
1184	[[4,8,1,5,9,3,7,2,6],[3,5,9,6,7,2,1,8,4],[7,6,2,4,8,1,3,5,9],[8,3,6,2,4,9,5,1,7],[2,1,7,8,6,5,4,9,3],[9,4,5,1,3,7,8,6,2],[6,7,3,9,5,8,2,4,1],[1,9,8,7,2,4,6,3,5],[5,2,4,3,1,6,9,7,8]]
1185	[[2,5,9,6,3,7,8,1,4],[1,6,4,8,5,9,7,3,2],[3,8,7,1,4,2,6,5,9],[7,2,8,5,1,3,9,4,6],[4,3,6,7,9,8,5,2,1],[5,9,1,4,2,6,3,7,8],[6,1,3,9,7,4,2,8,5],[9,4,2,3,8,5,1,6,7],[8,7,5,2,6,1,4,9,3]]
1186	[[3,9,6,2,4,1,7,5,8],[5,2,1,9,8,7,4,3,6],[7,8,4,5,6,3,2,1,9],[8,3,5,1,7,4,9,6,2],[4,7,9,6,5,2,3,8,1],[1,6,2,8,3,9,5,7,4],[2,1,3,7,9,6,8,4,5],[9,4,8,3,1,5,6,2,7],[6,5,7,4,2,8,1,9,3]]
1187	[[2,9,3,5,8,7,6,1,4],[5,8,6,2,1,4,7,3,9],[7,1,4,3,6,9,2,5,8],[4,2,5,7,3,8,1,9,6],[3,7,9,6,2,1,4,8,5],[1,6,8,4,9,5,3,2,7],[9,3,7,1,5,6,8,4,2],[6,5,1,8,4,2,9,7,3],[8,4,2,9,7,3,5,6,1]]
1188	[[7,8,6,9,3,5,1,2,4],[3,1,4,2,8,7,9,6,5],[9,2,5,6,1,4,8,3,7],[8,4,2,3,5,6,7,9,1],[5,3,7,1,4,9,6,8,2],[1,6,9,8,7,2,4,5,3],[4,5,3,7,9,8,2,1,6],[2,7,8,5,6,1,3,4,9],[6,9,1,4,2,3,5,7,8]]
1189	[[1,8,3,2,6,9,7,4,5],[7,2,5,4,1,3,9,8,6],[4,9,6,8,5,7,3,2,1],[9,4,8,6,2,1,5,3,7],[5,7,2,9,3,4,6,1,8],[6,3,1,7,8,5,4,9,2],[3,6,4,1,7,2,8,5,9],[2,5,7,3,9,8,1,6,4],[8,1,9,5,4,6,2,7,3]]
1190	[[6,5,8,9,4,7,3,1,2],[2,1,9,6,8,3,4,7,5],[3,7,4,2,1,5,8,6,9],[9,3,1,5,2,4,6,8,7],[5,4,7,3,6,8,2,9,1],[8,6,2,7,9,1,5,3,4],[4,2,6,8,7,9,1,5,3],[7,8,3,1,5,2,9,4,6],[1,9,5,4,3,6,7,2,8]]
1191	[[3,9,8,5,1,6,2,4,7],[1,5,7,2,8,4,6,3,9],[2,4,6,3,9,7,5,8,1],[7,1,5,9,6,3,8,2,4],[6,8,2,7,4,1,3,9,5],[9,3,4,8,2,5,7,1,6],[8,6,1,4,5,2,9,7,3],[5,7,9,1,3,8,4,6,2],[4,2,3,6,7,9,1,5,8]]
1192	[[9,7,1,2,3,6,4,8,5],[4,5,6,7,1,8,2,9,3],[2,3,8,9,4,5,6,1,7],[8,4,5,3,6,9,7,2,1],[6,9,2,5,7,1,3,4,8],[3,1,7,4,8,2,9,5,6],[1,2,9,6,5,3,8,7,4],[5,6,4,8,9,7,1,3,2],[7,8,3,1,2,4,5,6,9]]
1193	[[4,5,8,9,3,2,7,6,1],[2,6,9,7,4,1,3,5,8],[7,1,3,6,8,5,2,4,9],[5,8,7,4,1,3,9,2,6],[6,9,1,8,2,7,5,3,4],[3,4,2,5,6,9,1,8,7],[1,2,6,3,9,4,8,7,5],[9,7,4,2,5,8,6,1,3],[8,3,5,1,7,6,4,9,2]]
1194	[[4,3,2,1,6,5,9,8,7],[8,7,5,3,4,9,6,2,1],[9,1,6,8,2,7,3,5,4],[5,2,9,7,3,6,1,4,8],[6,4,3,2,8,1,7,9,5],[1,8,7,5,9,4,2,6,3],[2,5,4,6,7,3,8,1,9],[7,6,1,9,5,8,4,3,2],[3,9,8,4,1,2,5,7,6]]
1195	[[2,4,8,7,5,6,1,3,9],[1,7,3,8,2,9,6,4,5],[5,9,6,1,3,4,8,7,2],[3,2,7,4,8,1,9,5,6],[8,6,5,2,9,7,3,1,4],[4,1,9,3,6,5,2,8,7],[9,5,1,6,4,8,7,2,3],[7,3,4,9,1,2,5,6,8],[6,8,2,5,7,3,4,9,1]]
1196	[[4,7,8,2,3,6,9,5,1],[1,3,2,5,8,9,4,6,7],[6,9,5,1,4,7,3,2,8],[2,4,6,3,9,8,1,7,5],[9,8,1,6,7,5,2,3,4],[7,5,3,4,2,1,8,9,6],[8,6,9,7,1,2,5,4,3],[3,2,7,8,5,4,6,1,9],[5,1,4,9,6,3,7,8,2]]
1197	[[8,9,3,6,4,5,1,7,2],[1,2,6,8,7,3,4,9,5],[7,5,4,9,1,2,3,8,6],[6,7,2,5,9,1,8,4,3],[4,3,5,7,6,8,9,2,1],[9,8,1,3,2,4,5,6,7],[5,4,8,2,3,6,7,1,9],[2,1,7,4,5,9,6,3,8],[3,6,9,1,8,7,2,5,4]]
1198	[[4,9,3,2,1,8,7,6,5],[5,8,2,9,6,7,4,1,3],[1,6,7,5,3,4,2,9,8],[2,5,9,8,4,6,1,3,7],[8,3,1,7,2,9,5,4,6],[7,4,6,1,5,3,8,2,9],[9,7,4,6,8,1,3,5,2],[3,2,8,4,9,5,6,7,1],[6,1,5,3,7,2,9,8,4]]
1199	[[4,1,5,7,6,3,8,2,9],[8,6,7,2,9,5,3,1,4],[9,2,3,8,1,4,5,7,6],[7,5,1,6,3,2,4,9,8],[6,9,2,4,8,7,1,3,5],[3,4,8,1,5,9,7,6,2],[2,8,9,3,4,1,6,5,7],[5,3,4,9,7,6,2,8,1],[1,7,6,5,2,8,9,4,3]]
1200	[[4,5,2,1,8,7,3,9,6],[1,3,6,9,2,4,7,8,5],[7,9,8,5,6,3,2,4,1],[2,1,9,4,3,6,8,5,7],[8,7,3,2,1,5,9,6,4],[5,6,4,7,9,8,1,2,3],[3,4,1,8,5,2,6,7,9],[6,2,5,3,7,9,4,1,8],[9,8,7,6,4,1,5,3,2]]
1201	[[8,9,2,7,6,5,3,1,4],[3,7,5,4,9,1,8,6,2],[4,1,6,8,3,2,5,9,7],[7,6,1,5,2,9,4,3,8],[2,5,8,3,4,6,9,7,1],[9,3,4,1,7,8,2,5,6],[5,8,9,6,1,4,7,2,3],[6,2,3,9,8,7,1,4,5],[1,4,7,2,5,3,6,8,9]]
1202	[[8,1,3,9,2,5,7,4,6],[7,6,2,8,3,4,5,9,1],[9,4,5,6,7,1,3,2,8],[1,3,4,2,5,9,6,8,7],[2,8,7,1,6,3,4,5,9],[5,9,6,7,4,8,2,1,3],[4,7,1,3,8,2,9,6,5],[6,2,8,5,9,7,1,3,4],[3,5,9,4,1,6,8,7,2]]
1203	[[5,4,8,2,1,6,9,7,3],[2,1,6,7,9,3,4,8,5],[9,7,3,8,5,4,1,2,6],[4,3,1,9,7,2,5,6,8],[8,9,7,1,6,5,3,4,2],[6,5,2,4,3,8,7,9,1],[7,2,5,6,4,1,8,3,9],[1,8,9,3,2,7,6,5,4],[3,6,4,5,8,9,2,1,7]]
1204	[[4,6,3,2,8,5,9,1,7],[5,1,7,3,9,6,8,4,2],[9,2,8,1,4,7,5,6,3],[8,3,6,9,2,1,7,5,4],[1,5,4,7,6,3,2,8,9],[7,9,2,4,5,8,6,3,1],[2,7,5,6,1,4,3,9,8],[3,8,1,5,7,9,4,2,6],[6,4,9,8,3,2,1,7,5]]
1205	[[5,6,2,1,3,8,4,7,9],[8,3,1,4,7,9,2,6,5],[9,4,7,2,5,6,3,8,1],[1,2,6,3,8,7,5,9,4],[4,7,8,9,1,5,6,3,2],[3,5,9,6,4,2,7,1,8],[7,8,3,5,9,4,1,2,6],[2,9,4,7,6,1,8,5,3],[6,1,5,8,2,3,9,4,7]]
1206	[[1,9,6,4,2,3,8,5,7],[8,5,4,6,9,7,2,3,1],[7,3,2,8,1,5,6,9,4],[6,4,8,7,5,9,1,2,3],[9,2,7,3,8,1,5,4,6],[5,1,3,2,6,4,7,8,9],[2,7,9,1,4,8,3,6,5],[3,6,5,9,7,2,4,1,8],[4,8,1,5,3,6,9,7,2]]
1207	[[2,6,9,4,5,3,8,1,7],[7,4,1,6,8,9,2,3,5],[8,5,3,7,2,1,4,9,6],[6,3,2,1,7,5,9,4,8],[9,1,5,2,4,8,6,7,3],[4,7,8,3,9,6,1,5,2],[5,9,7,8,6,4,3,2,1],[3,8,4,5,1,2,7,6,9],[1,2,6,9,3,7,5,8,4]]
1208	[[2,8,6,9,1,7,5,3,4],[9,4,5,3,8,2,7,6,1],[1,7,3,4,5,6,8,9,2],[7,3,1,5,2,4,6,8,9],[4,5,8,6,3,9,2,1,7],[6,9,2,8,7,1,3,4,5],[5,6,7,1,4,3,9,2,8],[8,1,9,2,6,5,4,7,3],[3,2,4,7,9,8,1,5,6]]
1209	[[9,5,3,7,4,8,1,6,2],[7,6,4,5,1,2,3,8,9],[2,8,1,6,3,9,5,7,4],[1,3,8,2,7,6,9,4,5],[5,7,6,1,9,4,2,3,8],[4,9,2,3,8,5,7,1,6],[8,1,9,4,2,3,6,5,7],[6,2,7,8,5,1,4,9,3],[3,4,5,9,6,7,8,2,1]]
1210	[[2,8,1,4,6,7,3,5,9],[4,6,5,3,9,1,7,2,8],[3,9,7,2,8,5,4,6,1],[1,3,8,5,4,9,6,7,2],[5,7,9,1,2,6,8,4,3],[6,2,4,7,3,8,9,1,5],[9,5,6,8,1,4,2,3,7],[8,1,3,6,7,2,5,9,4],[7,4,2,9,5,3,1,8,6]]
1211	[[6,7,4,1,5,3,8,9,2],[9,8,1,4,2,6,3,5,7],[2,3,5,9,8,7,6,1,4],[3,6,2,7,9,1,4,8,5],[5,9,7,3,4,8,2,6,1],[1,4,8,5,6,2,7,3,9],[7,2,6,8,1,5,9,4,3],[4,1,3,6,7,9,5,2,8],[8,5,9,2,3,4,1,7,6]]
1212	[[6,7,3,1,8,9,5,4,2],[5,1,9,6,4,2,8,7,3],[2,8,4,3,7,5,6,1,9],[3,6,1,7,9,4,2,5,8],[4,5,2,8,3,1,7,9,6],[8,9,7,5,2,6,4,3,1],[1,4,8,9,6,7,3,2,5],[7,3,5,2,1,8,9,6,4],[9,2,6,4,5,3,1,8,7]]
1213	[[1,5,3,8,2,9,4,6,7],[7,4,8,3,5,6,9,1,2],[2,6,9,1,4,7,8,5,3],[6,8,1,4,7,5,3,2,9],[4,3,7,2,9,1,5,8,6],[9,2,5,6,8,3,7,4,1],[8,1,2,7,3,4,6,9,5],[3,9,4,5,6,2,1,7,8],[5,7,6,9,1,8,2,3,4]]
1214	[[6,7,9,3,8,1,2,5,4],[1,3,4,2,5,9,8,7,6],[8,2,5,7,6,4,1,9,3],[3,8,2,9,4,5,7,6,1],[7,4,6,8,1,2,9,3,5],[9,5,1,6,3,7,4,2,8],[2,1,3,5,9,8,6,4,7],[4,6,7,1,2,3,5,8,9],[5,9,8,4,7,6,3,1,2]]
1215	[[4,7,1,8,2,3,9,5,6],[8,2,6,9,1,5,4,7,3],[5,9,3,6,4,7,1,8,2],[3,8,2,4,5,6,7,9,1],[1,4,7,3,8,9,2,6,5],[6,5,9,1,7,2,3,4,8],[2,1,5,7,9,8,6,3,4],[7,3,4,5,6,1,8,2,9],[9,6,8,2,3,4,5,1,7]]
1216	[[5,7,8,4,3,9,1,2,6],[1,4,2,5,6,8,3,7,9],[6,9,3,1,2,7,5,8,4],[8,6,5,7,9,2,4,3,1],[7,3,1,8,5,4,6,9,2],[9,2,4,6,1,3,8,5,7],[2,8,9,3,4,6,7,1,5],[4,5,7,2,8,1,9,6,3],[3,1,6,9,7,5,2,4,8]]
1217	[[4,9,1,7,5,2,8,6,3],[8,3,2,1,4,6,5,7,9],[5,7,6,9,8,3,2,4,1],[7,5,9,6,2,8,3,1,4],[6,1,4,3,9,5,7,2,8],[3,2,8,4,1,7,9,5,6],[2,4,5,8,6,9,1,3,7],[9,6,7,2,3,1,4,8,5],[1,8,3,5,7,4,6,9,2]]
1218	[[7,6,9,3,4,8,1,2,5],[3,5,1,2,9,7,8,6,4],[4,8,2,1,5,6,9,3,7],[1,2,5,8,7,9,6,4,3],[6,7,8,4,1,3,2,5,9],[9,3,4,6,2,5,7,8,1],[5,4,6,9,8,1,3,7,2],[2,1,3,7,6,4,5,9,8],[8,9,7,5,3,2,4,1,6]]
1219	[[4,1,3,5,8,7,9,6,2],[5,8,6,1,2,9,3,7,4],[2,7,9,4,6,3,1,5,8],[1,2,4,8,9,6,7,3,5],[7,9,8,3,4,5,6,2,1],[3,6,5,2,7,1,8,4,9],[8,3,7,9,5,4,2,1,6],[6,4,2,7,1,8,5,9,3],[9,5,1,6,3,2,4,8,7]]
1220	[[1,9,8,7,3,2,6,4,5],[6,3,4,8,5,1,7,9,2],[5,7,2,9,4,6,8,3,1],[3,4,9,2,1,8,5,6,7],[8,5,6,3,7,9,2,1,4],[2,1,7,5,6,4,9,8,3],[7,8,5,1,9,3,4,2,6],[9,6,1,4,2,5,3,7,8],[4,2,3,6,8,7,1,5,9]]
1221	[[5,6,9,8,4,1,7,3,2],[4,3,8,7,9,2,6,1,5],[7,1,2,3,6,5,8,9,4],[9,2,3,6,8,4,5,7,1],[6,5,4,2,1,7,9,8,3],[1,8,7,9,5,3,4,2,6],[8,4,6,1,3,9,2,5,7],[3,7,5,4,2,8,1,6,9],[2,9,1,5,7,6,3,4,8]]
1222	[[2,8,1,9,5,3,4,6,7],[7,3,4,6,1,2,9,8,5],[6,5,9,4,8,7,2,3,1],[3,7,6,1,4,9,5,2,8],[9,1,2,5,3,8,6,7,4],[8,4,5,2,7,6,1,9,3],[5,2,7,3,6,4,8,1,9],[1,6,3,8,9,5,7,4,2],[4,9,8,7,2,1,3,5,6]]
1223	[[3,8,2,1,4,6,7,9,5],[1,5,9,7,3,2,8,6,4],[4,7,6,8,5,9,3,2,1],[7,2,4,6,9,8,5,1,3],[8,3,5,4,2,1,9,7,6],[6,9,1,3,7,5,2,4,8],[5,1,7,2,6,3,4,8,9],[2,6,3,9,8,4,1,5,7],[9,4,8,5,1,7,6,3,2]]
1224	[[2,7,4,3,1,5,6,9,8],[6,9,8,7,4,2,5,1,3],[5,1,3,6,9,8,4,2,7],[9,8,5,1,7,4,2,3,6],[4,2,7,8,6,3,1,5,9],[3,6,1,5,2,9,7,8,4],[7,3,9,4,5,1,8,6,2],[1,4,2,9,8,6,3,7,5],[8,5,6,2,3,7,9,4,1]]
1225	[[6,1,5,9,7,3,4,2,8],[3,8,4,2,5,1,7,6,9],[9,7,2,4,8,6,5,1,3],[8,3,6,5,4,2,1,9,7],[2,4,9,6,1,7,8,3,5],[7,5,1,8,3,9,2,4,6],[5,2,3,7,6,4,9,8,1],[4,6,7,1,9,8,3,5,2],[1,9,8,3,2,5,6,7,4]]
1226	[[4,9,2,3,5,7,8,1,6],[8,5,6,2,1,4,3,7,9],[1,7,3,8,9,6,4,2,5],[3,1,7,4,8,5,6,9,2],[2,4,9,6,3,1,7,5,8],[6,8,5,7,2,9,1,3,4],[7,3,4,5,6,2,9,8,1],[5,6,1,9,7,8,2,4,3],[9,2,8,1,4,3,5,6,7]]
1227	[[8,4,1,7,2,3,5,6,9],[6,7,3,9,5,1,2,8,4],[2,5,9,8,4,6,3,7,1],[4,8,6,3,9,5,7,1,2],[3,2,7,6,1,8,9,4,5],[9,1,5,2,7,4,8,3,6],[7,3,2,4,6,9,1,5,8],[5,6,8,1,3,2,4,9,7],[1,9,4,5,8,7,6,2,3]]
1228	[[1,9,2,3,5,6,7,4,8],[6,7,4,8,9,1,2,3,5],[3,5,8,7,2,4,6,1,9],[2,3,9,6,1,5,4,8,7],[8,4,7,2,3,9,1,5,6],[5,1,6,4,8,7,3,9,2],[9,6,3,1,7,8,5,2,4],[4,2,5,9,6,3,8,7,1],[7,8,1,5,4,2,9,6,3]]
1229	[[5,6,4,8,3,2,7,1,9],[9,3,2,5,7,1,4,6,8],[1,7,8,6,4,9,3,2,5],[8,4,5,1,9,6,2,7,3],[7,2,1,4,5,3,9,8,6],[6,9,3,2,8,7,1,5,4],[2,5,9,7,6,4,8,3,1],[4,1,6,3,2,8,5,9,7],[3,8,7,9,1,5,6,4,2]]
1230	[[3,4,8,9,2,1,5,6,7],[7,6,1,8,5,3,9,2,4],[2,9,5,7,6,4,8,1,3],[8,5,7,4,1,6,3,9,2],[4,2,3,5,8,9,1,7,6],[9,1,6,3,7,2,4,5,8],[5,3,2,1,4,7,6,8,9],[6,8,9,2,3,5,7,4,1],[1,7,4,6,9,8,2,3,5]]
1231	[[1,8,7,4,6,5,3,9,2],[3,6,2,1,9,7,5,8,4],[4,5,9,3,2,8,6,1,7],[5,9,1,8,7,2,4,6,3],[6,2,8,5,4,3,1,7,9],[7,3,4,6,1,9,2,5,8],[8,1,6,7,3,4,9,2,5],[9,4,5,2,8,6,7,3,1],[2,7,3,9,5,1,8,4,6]]
1232	[[3,2,1,8,5,6,7,9,4],[8,7,5,4,1,9,2,3,6],[6,4,9,2,7,3,5,1,8],[7,1,8,6,3,5,4,2,9],[9,3,6,7,4,2,8,5,1],[2,5,4,9,8,1,3,6,7],[1,6,7,3,2,8,9,4,5],[4,9,2,5,6,7,1,8,3],[5,8,3,1,9,4,6,7,2]]
1233	[[1,5,7,9,6,2,3,8,4],[8,3,6,4,5,7,2,9,1],[4,9,2,3,8,1,7,5,6],[2,6,4,5,7,3,8,1,9],[3,7,1,8,4,9,5,6,2],[9,8,5,2,1,6,4,3,7],[6,4,3,1,2,8,9,7,5],[5,1,9,7,3,4,6,2,8],[7,2,8,6,9,5,1,4,3]]
1234	[[8,5,9,1,3,2,4,6,7],[3,1,4,7,6,5,9,2,8],[2,6,7,8,4,9,5,1,3],[1,7,8,5,9,4,2,3,6],[4,2,5,6,7,3,8,9,1],[6,9,3,2,8,1,7,4,5],[5,3,2,4,1,7,6,8,9],[7,8,1,9,2,6,3,5,4],[9,4,6,3,5,8,1,7,2]]
1235	[[4,7,5,2,6,1,3,9,8],[9,1,6,3,8,5,4,7,2],[2,3,8,4,9,7,5,1,6],[8,6,3,1,5,4,7,2,9],[1,2,9,8,7,3,6,4,5],[5,4,7,9,2,6,8,3,1],[3,8,2,5,4,9,1,6,7],[7,9,1,6,3,8,2,5,4],[6,5,4,7,1,2,9,8,3]]
1236	[[2,6,4,3,7,8,9,5,1],[8,1,5,2,9,6,4,7,3],[3,9,7,4,5,1,2,8,6],[6,2,3,1,8,9,5,4,7],[4,8,9,5,3,7,6,1,2],[5,7,1,6,4,2,3,9,8],[1,5,6,7,2,4,8,3,9],[9,4,2,8,1,3,7,6,5],[7,3,8,9,6,5,1,2,4]]
1237	[[3,8,6,4,7,2,5,9,1],[9,7,4,6,5,1,2,8,3],[2,5,1,8,3,9,6,7,4],[7,2,9,1,6,3,4,5,8],[8,6,3,5,4,7,1,2,9],[4,1,5,9,2,8,3,6,7],[5,9,8,2,1,4,7,3,6],[6,4,7,3,9,5,8,1,2],[1,3,2,7,8,6,9,4,5]]
1238	[[9,2,3,1,5,4,7,6,8],[6,7,1,8,2,3,9,5,4],[4,8,5,7,9,6,2,3,1],[3,1,4,6,8,9,5,2,7],[5,6,8,2,1,7,4,9,3],[2,9,7,3,4,5,8,1,6],[1,4,9,5,3,8,6,7,2],[7,5,2,4,6,1,3,8,9],[8,3,6,9,7,2,1,4,5]]
1239	[[8,9,5,6,7,1,4,3,2],[2,1,6,4,3,5,7,8,9],[3,4,7,9,8,2,6,5,1],[5,7,1,8,9,4,2,6,3],[4,8,3,2,1,6,9,7,5],[6,2,9,7,5,3,8,1,4],[1,6,8,3,4,9,5,2,7],[9,5,2,1,6,7,3,4,8],[7,3,4,5,2,8,1,9,6]]
1240	[[8,7,6,3,4,5,1,9,2],[9,5,4,6,1,2,3,8,7],[1,3,2,9,7,8,5,4,6],[3,9,5,7,2,1,8,6,4],[2,8,7,4,5,6,9,3,1],[6,4,1,8,3,9,7,2,5],[4,2,8,5,9,7,6,1,3],[7,1,9,2,6,3,4,5,8],[5,6,3,1,8,4,2,7,9]]
1241	[[1,2,8,9,7,6,5,4,3],[3,6,9,8,5,4,2,7,1],[7,5,4,1,3,2,6,9,8],[6,3,1,4,8,7,9,5,2],[9,4,7,2,1,5,3,8,6],[2,8,5,6,9,3,7,1,4],[8,1,2,7,6,9,4,3,5],[4,9,3,5,2,8,1,6,7],[5,7,6,3,4,1,8,2,9]]
1242	[[7,2,8,6,4,3,1,5,9],[5,3,6,9,1,8,4,7,2],[1,9,4,2,5,7,3,6,8],[2,6,1,3,7,9,5,8,4],[3,4,7,5,8,2,6,9,1],[9,8,5,4,6,1,2,3,7],[4,7,2,8,3,6,9,1,5],[6,1,9,7,2,5,8,4,3],[8,5,3,1,9,4,7,2,6]]
1243	[[6,7,9,4,3,2,5,1,8],[8,2,3,1,6,5,4,9,7],[5,4,1,7,8,9,2,6,3],[4,9,5,2,1,7,3,8,6],[7,3,8,5,9,6,1,2,4],[1,6,2,8,4,3,7,5,9],[2,1,6,9,7,4,8,3,5],[3,5,4,6,2,8,9,7,1],[9,8,7,3,5,1,6,4,2]]
1244	[[3,8,1,4,2,5,9,6,7],[2,7,4,1,9,6,5,8,3],[6,9,5,8,3,7,2,4,1],[5,3,9,7,1,4,8,2,6],[8,4,7,2,6,3,1,9,5],[1,2,6,5,8,9,7,3,4],[4,1,3,9,5,8,6,7,2],[9,6,2,3,7,1,4,5,8],[7,5,8,6,4,2,3,1,9]]
1245	[[1,8,2,9,5,4,6,3,7],[9,7,3,6,2,8,4,5,1],[6,5,4,1,7,3,2,8,9],[4,9,8,3,1,2,5,7,6],[2,6,1,5,8,7,3,9,4],[7,3,5,4,9,6,1,2,8],[3,1,9,8,6,5,7,4,2],[5,2,6,7,4,9,8,1,3],[8,4,7,2,3,1,9,6,5]]
1246	[[3,6,5,9,2,7,1,4,8],[9,8,2,4,1,5,3,6,7],[1,4,7,6,3,8,5,2,9],[4,3,6,7,5,1,9,8,2],[7,5,9,8,4,2,6,3,1],[2,1,8,3,6,9,4,7,5],[5,2,3,1,8,6,7,9,4],[6,7,1,2,9,4,8,5,3],[8,9,4,5,7,3,2,1,6]]
1247	[[7,3,5,1,4,8,2,9,6],[8,6,4,2,5,9,3,1,7],[1,9,2,3,6,7,4,5,8],[3,8,9,5,1,6,7,4,2],[5,2,7,4,9,3,8,6,1],[6,4,1,8,7,2,9,3,5],[2,7,6,9,3,1,5,8,4],[9,5,8,6,2,4,1,7,3],[4,1,3,7,8,5,6,2,9]]
1248	[[5,8,2,3,9,7,6,1,4],[4,3,7,6,5,1,2,9,8],[1,9,6,4,8,2,7,3,5],[6,7,5,2,3,8,1,4,9],[3,2,4,1,7,9,5,8,6],[8,1,9,5,4,6,3,2,7],[7,4,1,9,6,3,8,5,2],[2,5,8,7,1,4,9,6,3],[9,6,3,8,2,5,4,7,1]]
1249	[[2,6,3,7,8,1,4,9,5],[7,5,1,4,6,9,8,3,2],[4,9,8,5,3,2,7,1,6],[6,7,5,2,9,4,1,8,3],[3,1,2,8,5,7,6,4,9],[9,8,4,3,1,6,2,5,7],[5,3,6,1,7,8,9,2,4],[1,4,7,9,2,5,3,6,8],[8,2,9,6,4,3,5,7,1]]
1250	[[5,3,1,7,6,9,4,2,8],[4,8,2,5,1,3,6,7,9],[7,6,9,4,8,2,5,3,1],[2,7,5,6,9,1,8,4,3],[6,9,8,3,4,5,2,1,7],[1,4,3,2,7,8,9,6,5],[3,1,4,8,5,6,7,9,2],[8,2,7,9,3,4,1,5,6],[9,5,6,1,2,7,3,8,4]]
1251	[[2,3,5,8,6,4,9,7,1],[8,9,4,2,1,7,6,3,5],[1,6,7,5,3,9,2,8,4],[3,7,8,4,2,1,5,6,9],[4,5,6,9,7,8,3,1,2],[9,2,1,3,5,6,8,4,7],[5,4,9,7,8,3,1,2,6],[7,1,3,6,9,2,4,5,8],[6,8,2,1,4,5,7,9,3]]
1252	[[5,6,4,8,7,9,3,1,2],[8,7,3,4,1,2,6,9,5],[2,1,9,3,5,6,4,7,8],[3,5,1,6,9,8,2,4,7],[7,2,8,5,4,3,1,6,9],[9,4,6,1,2,7,8,5,3],[4,8,2,7,6,5,9,3,1],[1,9,5,2,3,4,7,8,6],[6,3,7,9,8,1,5,2,4]]
1253	[[6,8,4,2,1,9,5,3,7],[7,9,3,5,6,4,8,2,1],[1,2,5,3,7,8,9,4,6],[4,6,9,7,3,1,2,5,8],[8,7,2,9,5,6,4,1,3],[3,5,1,8,4,2,7,6,9],[2,3,7,6,9,5,1,8,4],[5,4,6,1,8,7,3,9,2],[9,1,8,4,2,3,6,7,5]]
1254	[[1,2,3,5,8,9,7,4,6],[4,6,5,3,1,7,2,9,8],[7,9,8,6,2,4,1,3,5],[2,1,4,7,5,8,9,6,3],[5,7,9,1,3,6,8,2,4],[8,3,6,4,9,2,5,7,1],[6,4,2,8,7,1,3,5,9],[9,5,1,2,4,3,6,8,7],[3,8,7,9,6,5,4,1,2]]
1255	[[2,7,6,5,3,9,1,4,8],[4,5,9,6,1,8,3,7,2],[1,8,3,4,2,7,6,9,5],[9,1,5,2,6,3,4,8,7],[7,6,2,8,4,5,9,1,3],[8,3,4,7,9,1,2,5,6],[6,4,8,9,5,2,7,3,1],[5,2,1,3,7,4,8,6,9],[3,9,7,1,8,6,5,2,4]]
1256	[[8,9,6,1,4,3,7,5,2],[1,7,4,2,9,5,6,3,8],[5,2,3,8,6,7,9,1,4],[7,4,5,9,2,6,3,8,1],[2,1,9,4,3,8,5,7,6],[6,3,8,5,7,1,2,4,9],[9,8,1,3,5,2,4,6,7],[3,6,2,7,8,4,1,9,5],[4,5,7,6,1,9,8,2,3]]
1257	[[5,2,4,7,3,8,9,6,1],[1,7,9,6,5,4,2,3,8],[8,6,3,2,1,9,7,4,5],[3,5,7,8,6,2,4,1,9],[6,9,8,4,7,1,5,2,3],[2,4,1,3,9,5,8,7,6],[7,1,5,9,4,6,3,8,2],[4,8,6,5,2,3,1,9,7],[9,3,2,1,8,7,6,5,4]]
1258	[[2,8,3,6,4,7,5,1,9],[1,9,4,5,2,3,7,6,8],[5,6,7,8,9,1,4,2,3],[4,1,5,2,6,8,9,3,7],[9,7,2,3,5,4,1,8,6],[8,3,6,7,1,9,2,4,5],[3,2,8,1,7,5,6,9,4],[6,5,9,4,3,2,8,7,1],[7,4,1,9,8,6,3,5,2]]
1259	[[8,1,5,3,6,2,4,9,7],[6,2,3,9,4,7,5,1,8],[4,9,7,8,5,1,2,6,3],[1,3,2,5,7,4,6,8,9],[7,5,4,6,9,8,1,3,2],[9,8,6,2,1,3,7,4,5],[2,6,9,4,3,5,8,7,1],[3,7,8,1,2,6,9,5,4],[5,4,1,7,8,9,3,2,6]]
1260	[[6,2,3,4,9,1,5,7,8],[5,7,4,6,2,8,3,9,1],[1,8,9,5,3,7,2,6,4],[8,6,5,9,7,3,4,1,2],[4,3,1,2,8,6,7,5,9],[2,9,7,1,5,4,6,8,3],[7,1,6,3,4,9,8,2,5],[3,5,8,7,1,2,9,4,6],[9,4,2,8,6,5,1,3,7]]
1261	[[3,5,2,7,6,8,4,1,9],[6,8,1,9,3,4,2,5,7],[4,9,7,2,1,5,6,3,8],[5,1,6,3,7,2,9,8,4],[8,7,4,5,9,1,3,6,2],[9,2,3,4,8,6,1,7,5],[7,4,5,6,2,3,8,9,1],[1,6,9,8,4,7,5,2,3],[2,3,8,1,5,9,7,4,6]]
1262	[[3,8,9,1,4,5,6,7,2],[5,7,6,3,8,2,4,9,1],[2,4,1,7,9,6,8,3,5],[8,9,5,2,6,7,1,4,3],[6,3,7,9,1,4,5,2,8],[1,2,4,5,3,8,9,6,7],[7,6,2,4,5,1,3,8,9],[9,1,8,6,7,3,2,5,4],[4,5,3,8,2,9,7,1,6]]
1263	[[5,4,6,3,2,9,7,1,8],[1,7,9,8,4,6,2,3,5],[3,8,2,5,1,7,4,9,6],[2,3,7,1,6,4,8,5,9],[6,9,1,2,5,8,3,4,7],[8,5,4,9,7,3,6,2,1],[4,2,8,7,9,5,1,6,3],[7,6,5,4,3,1,9,8,2],[9,1,3,6,8,2,5,7,4]]
1264	[[1,4,2,6,9,7,5,3,8],[7,9,8,5,3,2,6,4,1],[6,5,3,1,8,4,2,7,9],[2,1,4,9,5,6,7,8,3],[5,3,7,2,1,8,9,6,4],[8,6,9,4,7,3,1,2,5],[9,7,6,3,4,5,8,1,2],[4,8,5,7,2,1,3,9,6],[3,2,1,8,6,9,4,5,7]]
1265	[[7,5,2,1,9,8,3,6,4],[6,9,1,5,4,3,7,8,2],[3,4,8,7,2,6,1,9,5],[8,3,5,2,6,7,4,1,9],[1,7,9,4,8,5,6,2,3],[2,6,4,3,1,9,5,7,8],[4,1,7,8,5,2,9,3,6],[5,8,6,9,3,1,2,4,7],[9,2,3,6,7,4,8,5,1]]
1266	[[6,3,2,4,8,9,1,5,7],[4,5,7,6,1,3,8,9,2],[1,9,8,7,5,2,4,6,3],[7,2,3,9,4,6,5,1,8],[5,6,4,1,3,8,2,7,9],[9,8,1,5,2,7,3,4,6],[8,1,6,2,7,5,9,3,4],[3,4,9,8,6,1,7,2,5],[2,7,5,3,9,4,6,8,1]]
1267	[[4,7,8,1,6,9,3,2,5],[2,5,1,3,7,8,9,6,4],[6,9,3,2,4,5,1,7,8],[9,8,4,7,5,6,2,1,3],[1,3,6,8,2,4,7,5,9],[7,2,5,9,3,1,4,8,6],[3,6,7,4,8,2,5,9,1],[8,4,9,5,1,7,6,3,2],[5,1,2,6,9,3,8,4,7]]
1268	[[4,5,3,6,8,7,2,1,9],[6,9,2,5,3,1,4,7,8],[8,7,1,2,9,4,3,6,5],[5,4,9,7,2,3,6,8,1],[2,1,6,8,4,5,7,9,3],[3,8,7,9,1,6,5,2,4],[7,6,8,4,5,9,1,3,2],[9,3,4,1,7,2,8,5,6],[1,2,5,3,6,8,9,4,7]]
1269	[[7,8,4,3,6,2,1,9,5],[9,3,2,7,1,5,8,4,6],[6,5,1,8,4,9,2,3,7],[8,7,6,9,5,4,3,2,1],[4,2,3,1,8,7,5,6,9],[1,9,5,2,3,6,4,7,8],[2,4,8,6,9,1,7,5,3],[3,6,7,5,2,8,9,1,4],[5,1,9,4,7,3,6,8,2]]
1270	[[7,3,5,6,2,9,4,1,8],[2,4,1,3,7,8,5,9,6],[6,8,9,5,4,1,3,2,7],[5,7,3,2,8,4,1,6,9],[9,1,8,7,6,3,2,4,5],[4,6,2,9,1,5,8,7,3],[8,9,6,1,3,2,7,5,4],[1,5,4,8,9,7,6,3,2],[3,2,7,4,5,6,9,8,1]]
1271	[[7,9,5,3,4,2,1,6,8],[6,2,3,5,8,1,7,9,4],[4,8,1,9,6,7,2,5,3],[2,5,6,7,3,4,9,8,1],[1,4,8,6,5,9,3,7,2],[3,7,9,1,2,8,5,4,6],[5,1,4,2,7,6,8,3,9],[8,3,2,4,9,5,6,1,7],[9,6,7,8,1,3,4,2,5]]
1272	[[3,6,4,8,5,9,1,2,7],[1,2,8,7,6,4,9,5,3],[7,9,5,2,3,1,4,8,6],[9,5,3,1,2,6,8,7,4],[4,8,7,3,9,5,2,6,1],[6,1,2,4,7,8,3,9,5],[2,4,1,5,8,7,6,3,9],[5,3,9,6,1,2,7,4,8],[8,7,6,9,4,3,5,1,2]]
1273	[[2,5,1,7,9,6,3,4,8],[7,6,4,5,8,3,9,1,2],[9,3,8,4,2,1,7,5,6],[8,2,3,9,7,5,1,6,4],[4,1,9,3,6,8,5,2,7],[6,7,5,2,1,4,8,3,9],[1,4,6,8,5,9,2,7,3],[3,8,2,1,4,7,6,9,5],[5,9,7,6,3,2,4,8,1]]
1274	[[8,4,2,3,1,5,6,9,7],[5,6,3,9,7,4,2,1,8],[1,7,9,6,2,8,5,3,4],[3,1,8,7,6,9,4,5,2],[9,5,6,4,3,2,7,8,1],[4,2,7,8,5,1,9,6,3],[2,3,5,1,9,7,8,4,6],[6,9,4,2,8,3,1,7,5],[7,8,1,5,4,6,3,2,9]]
1275	[[5,6,9,4,8,7,1,3,2],[2,8,1,3,5,9,7,6,4],[4,3,7,1,6,2,8,5,9],[7,1,2,6,3,8,9,4,5],[3,5,4,2,9,1,6,8,7],[6,9,8,5,7,4,2,1,3],[8,2,3,7,1,5,4,9,6],[9,4,6,8,2,3,5,7,1],[1,7,5,9,4,6,3,2,8]]
1276	[[6,8,5,4,7,3,9,1,2],[3,1,9,8,2,5,4,7,6],[2,4,7,9,1,6,5,8,3],[8,7,3,2,9,4,1,6,5],[9,5,1,3,6,8,7,2,4],[4,6,2,7,5,1,3,9,8],[5,3,6,1,8,7,2,4,9],[7,9,8,5,4,2,6,3,1],[1,2,4,6,3,9,8,5,7]]
1277	[[1,7,5,8,4,3,6,2,9],[3,8,9,5,2,6,4,7,1],[6,2,4,1,9,7,8,3,5],[9,3,8,7,6,2,1,5,4],[2,6,7,4,1,5,9,8,3],[4,5,1,9,3,8,2,6,7],[7,9,6,2,5,1,3,4,8],[8,1,2,3,7,4,5,9,6],[5,4,3,6,8,9,7,1,2]]
1278	[[3,6,1,8,5,2,4,7,9],[2,9,4,7,3,6,5,1,8],[7,8,5,9,4,1,2,6,3],[5,7,6,3,2,8,1,9,4],[8,3,9,1,7,4,6,2,5],[1,4,2,6,9,5,3,8,7],[4,5,8,2,1,9,7,3,6],[9,2,3,5,6,7,8,4,1],[6,1,7,4,8,3,9,5,2]]
1279	[[9,4,8,5,3,2,1,6,7],[5,6,7,1,4,9,8,3,2],[3,1,2,8,6,7,4,5,9],[6,5,9,3,2,1,7,8,4],[2,8,1,4,7,5,6,9,3],[7,3,4,6,9,8,2,1,5],[8,9,3,7,1,4,5,2,6],[1,7,6,2,5,3,9,4,8],[4,2,5,9,8,6,3,7,1]]
1280	[[5,8,9,1,3,4,2,6,7],[6,3,4,2,7,9,5,8,1],[2,7,1,8,6,5,4,3,9],[1,4,7,5,9,8,3,2,6],[9,5,3,6,2,1,8,7,4],[8,2,6,7,4,3,9,1,5],[3,9,8,4,1,6,7,5,2],[4,6,2,3,5,7,1,9,8],[7,1,5,9,8,2,6,4,3]]
1281	[[4,7,6,2,3,5,8,1,9],[8,9,5,6,1,4,3,2,7],[2,1,3,8,7,9,4,5,6],[6,5,1,9,2,3,7,4,8],[7,2,4,1,8,6,5,9,3],[3,8,9,4,5,7,2,6,1],[1,4,7,5,6,8,9,3,2],[5,3,2,7,9,1,6,8,4],[9,6,8,3,4,2,1,7,5]]
1282	[[2,5,8,6,4,3,7,9,1],[1,9,3,8,7,5,4,2,6],[6,4,7,9,1,2,3,5,8],[8,1,5,3,6,9,2,4,7],[7,3,6,4,2,8,5,1,9],[9,2,4,1,5,7,6,8,3],[3,6,1,2,9,4,8,7,5],[5,8,2,7,3,1,9,6,4],[4,7,9,5,8,6,1,3,2]]
1283	[[5,2,6,8,1,4,9,3,7],[9,1,4,3,7,6,2,8,5],[7,8,3,2,5,9,4,1,6],[1,4,7,6,9,8,5,2,3],[3,6,8,1,2,5,7,4,9],[2,9,5,4,3,7,8,6,1],[4,5,1,7,8,3,6,9,2],[8,7,2,9,6,1,3,5,4],[6,3,9,5,4,2,1,7,8]]
1284	[[5,7,4,3,9,8,6,1,2],[6,1,3,7,5,2,4,8,9],[9,2,8,6,1,4,3,5,7],[3,9,5,4,2,1,8,7,6],[7,4,2,5,8,6,9,3,1],[1,8,6,9,3,7,5,2,4],[2,3,9,1,6,5,7,4,8],[8,6,7,2,4,3,1,9,5],[4,5,1,8,7,9,2,6,3]]
1285	[[4,2,7,5,3,9,1,8,6],[6,3,5,1,8,4,7,2,9],[9,1,8,7,2,6,3,4,5],[1,6,4,3,5,7,2,9,8],[8,9,3,2,6,1,4,5,7],[5,7,2,9,4,8,6,3,1],[2,8,1,4,7,5,9,6,3],[7,4,6,8,9,3,5,1,2],[3,5,9,6,1,2,8,7,4]]
1286	[[2,5,7,4,8,9,6,1,3],[3,4,1,5,7,6,2,8,9],[8,6,9,1,2,3,7,5,4],[1,7,3,2,6,4,5,9,8],[4,9,8,3,5,7,1,6,2],[5,2,6,8,9,1,3,4,7],[6,8,2,7,4,5,9,3,1],[9,1,4,6,3,2,8,7,5],[7,3,5,9,1,8,4,2,6]]
1287	[[7,1,2,3,6,4,9,5,8],[4,3,5,9,2,8,7,1,6],[6,8,9,1,7,5,3,2,4],[8,4,6,5,1,3,2,9,7],[9,5,1,2,4,7,6,8,3],[2,7,3,8,9,6,5,4,1],[5,6,4,7,8,2,1,3,9],[3,9,8,6,5,1,4,7,2],[1,2,7,4,3,9,8,6,5]]
1288	[[7,3,6,2,1,5,4,8,9],[9,2,4,3,8,6,5,1,7],[5,8,1,7,9,4,2,3,6],[3,4,9,5,6,2,8,7,1],[6,1,2,8,7,3,9,4,5],[8,5,7,1,4,9,3,6,2],[2,7,5,4,3,1,6,9,8],[1,9,3,6,2,8,7,5,4],[4,6,8,9,5,7,1,2,3]]
1289	[[9,6,5,7,2,3,1,8,4],[3,2,7,4,8,1,5,9,6],[1,4,8,6,5,9,7,3,2],[2,1,4,5,6,8,9,7,3],[5,9,6,3,7,4,2,1,8],[7,8,3,9,1,2,6,4,5],[4,5,2,1,3,7,8,6,9],[6,7,9,8,4,5,3,2,1],[8,3,1,2,9,6,4,5,7]]
1290	[[2,9,4,1,6,8,5,3,7],[7,8,1,3,9,5,2,4,6],[5,6,3,2,7,4,8,9,1],[4,7,8,6,3,9,1,5,2],[6,5,2,7,4,1,3,8,9],[3,1,9,8,5,2,6,7,4],[8,3,7,4,2,6,9,1,5],[9,4,6,5,1,3,7,2,8],[1,2,5,9,8,7,4,6,3]]
1291	[[9,1,7,8,3,2,4,6,5],[5,8,2,4,1,6,3,9,7],[3,4,6,9,7,5,8,1,2],[4,9,5,6,2,3,7,8,1],[7,2,8,1,5,9,6,4,3],[1,6,3,7,4,8,5,2,9],[8,3,4,5,9,1,2,7,6],[2,7,1,3,6,4,9,5,8],[6,5,9,2,8,7,1,3,4]]
1292	[[7,4,1,6,9,2,8,5,3],[6,3,2,8,5,1,7,9,4],[8,9,5,7,4,3,6,2,1],[9,5,8,1,2,4,3,7,6],[4,2,6,5,3,7,1,8,9],[1,7,3,9,8,6,5,4,2],[2,8,4,3,6,5,9,1,7],[5,6,7,2,1,9,4,3,8],[3,1,9,4,7,8,2,6,5]]
1293	[[2,3,1,4,9,6,7,8,5],[6,9,4,5,7,8,1,3,2],[7,8,5,1,3,2,4,9,6],[8,5,2,7,4,3,9,6,1],[1,6,9,8,2,5,3,7,4],[3,4,7,6,1,9,5,2,8],[4,1,8,3,6,7,2,5,9],[9,7,6,2,5,1,8,4,3],[5,2,3,9,8,4,6,1,7]]
1294	[[7,8,9,5,2,3,1,6,4],[2,4,5,1,8,6,9,7,3],[6,3,1,4,9,7,8,2,5],[5,1,7,2,6,4,3,8,9],[3,6,4,8,1,9,2,5,7],[9,2,8,7,3,5,4,1,6],[4,7,2,3,5,8,6,9,1],[8,5,6,9,4,1,7,3,2],[1,9,3,6,7,2,5,4,8]]
1295	[[1,2,6,8,3,5,9,7,4],[7,4,9,6,1,2,3,5,8],[8,3,5,7,4,9,1,2,6],[9,6,1,2,7,4,8,3,5],[2,7,3,5,9,8,6,4,1],[5,8,4,3,6,1,2,9,7],[3,1,2,4,5,6,7,8,9],[4,9,7,1,8,3,5,6,2],[6,5,8,9,2,7,4,1,3]]
1296	[[1,7,6,4,8,2,9,5,3],[3,5,2,9,7,1,4,8,6],[8,4,9,6,3,5,2,7,1],[4,8,1,5,2,3,6,9,7],[6,9,5,7,4,8,1,3,2],[2,3,7,1,6,9,5,4,8],[7,1,4,8,9,6,3,2,5],[5,2,8,3,1,4,7,6,9],[9,6,3,2,5,7,8,1,4]]
1297	[[4,2,1,5,6,8,3,9,7],[9,6,7,2,3,1,8,4,5],[3,8,5,4,7,9,1,2,6],[1,7,9,3,5,4,2,6,8],[6,4,3,1,8,2,7,5,9],[2,5,8,7,9,6,4,3,1],[8,3,4,9,1,5,6,7,2],[5,1,2,6,4,7,9,8,3],[7,9,6,8,2,3,5,1,4]]
1298	[[6,5,3,7,2,8,1,9,4],[9,4,7,3,1,6,5,8,2],[1,8,2,9,4,5,7,3,6],[4,7,6,5,3,1,9,2,8],[3,9,1,8,7,2,4,6,5],[8,2,5,6,9,4,3,1,7],[2,3,8,1,5,7,6,4,9],[5,6,9,4,8,3,2,7,1],[7,1,4,2,6,9,8,5,3]]
1299	[[3,7,9,6,5,4,2,1,8],[6,1,8,9,3,2,7,5,4],[5,4,2,8,7,1,3,6,9],[7,2,3,4,1,5,8,9,6],[1,8,4,3,9,6,5,7,2],[9,5,6,7,2,8,1,4,3],[8,9,5,2,4,7,6,3,1],[2,3,1,5,6,9,4,8,7],[4,6,7,1,8,3,9,2,5]]
1300	[[9,4,3,5,2,1,6,7,8],[7,2,6,4,3,8,1,5,9],[1,8,5,9,7,6,3,4,2],[8,9,2,3,1,5,4,6,7],[3,7,1,6,4,9,2,8,5],[6,5,4,2,8,7,9,3,1],[4,1,8,7,6,2,5,9,3],[2,3,9,8,5,4,7,1,6],[5,6,7,1,9,3,8,2,4]]
1301	[[2,8,5,4,1,6,9,7,3],[6,3,4,9,7,8,2,5,1],[7,1,9,2,5,3,6,8,4],[4,5,2,8,3,1,7,9,6],[8,9,6,5,4,7,1,3,2],[1,7,3,6,9,2,8,4,5],[3,2,7,1,8,4,5,6,9],[9,4,1,7,6,5,3,2,8],[5,6,8,3,2,9,4,1,7]]
1302	[[3,4,7,5,9,6,8,1,2],[6,1,5,7,2,8,9,4,3],[9,2,8,1,4,3,7,6,5],[8,3,9,4,5,7,1,2,6],[7,5,2,9,6,1,3,8,4],[1,6,4,8,3,2,5,7,9],[2,9,1,6,8,5,4,3,7],[4,7,3,2,1,9,6,5,8],[5,8,6,3,7,4,2,9,1]]
1303	[[1,9,8,5,4,6,2,3,7],[3,4,6,8,2,7,5,1,9],[2,5,7,9,1,3,4,6,8],[8,7,3,4,5,9,6,2,1],[4,1,9,3,6,2,8,7,5],[5,6,2,7,8,1,9,4,3],[9,2,5,1,7,4,3,8,6],[6,3,1,2,9,8,7,5,4],[7,8,4,6,3,5,1,9,2]]
1304	[[2,7,6,8,9,4,5,1,3],[3,1,5,2,7,6,4,9,8],[8,4,9,3,1,5,7,6,2],[9,3,8,6,5,2,1,4,7],[4,2,7,1,8,9,6,3,5],[6,5,1,4,3,7,8,2,9],[5,8,4,9,6,3,2,7,1],[1,9,2,7,4,8,3,5,6],[7,6,3,5,2,1,9,8,4]]
1305	[[8,7,4,3,1,6,2,5,9],[5,9,2,4,8,7,1,3,6],[6,1,3,9,2,5,7,4,8],[2,8,5,6,9,4,3,1,7],[3,4,9,2,7,1,6,8,5],[7,6,1,8,5,3,9,2,4],[4,2,7,5,3,9,8,6,1],[9,3,6,1,4,8,5,7,2],[1,5,8,7,6,2,4,9,3]]
1306	[[6,2,7,3,4,1,9,5,8],[4,5,8,2,7,9,3,6,1],[3,9,1,8,6,5,2,4,7],[8,3,5,1,9,4,6,7,2],[9,4,2,7,3,6,8,1,5],[1,7,6,5,2,8,4,3,9],[7,8,3,6,5,2,1,9,4],[2,6,9,4,1,7,5,8,3],[5,1,4,9,8,3,7,2,6]]
1307	[[7,2,1,3,4,8,5,6,9],[6,3,4,9,1,5,7,2,8],[8,5,9,7,6,2,1,3,4],[9,8,7,5,3,4,6,1,2],[4,6,2,8,7,1,9,5,3],[3,1,5,6,2,9,8,4,7],[2,9,3,1,8,6,4,7,5],[1,4,8,2,5,7,3,9,6],[5,7,6,4,9,3,2,8,1]]
1308	[[6,5,9,8,3,2,1,4,7],[3,1,7,4,5,9,2,6,8],[4,8,2,7,1,6,5,3,9],[8,4,6,9,2,5,3,7,1],[9,7,1,3,6,4,8,5,2],[2,3,5,1,7,8,6,9,4],[1,9,3,5,8,7,4,2,6],[5,2,4,6,9,1,7,8,3],[7,6,8,2,4,3,9,1,5]]
1309	[[6,2,5,7,4,3,9,1,8],[8,4,7,5,1,9,3,2,6],[9,3,1,8,2,6,5,7,4],[3,1,2,9,8,7,6,4,5],[5,7,6,4,3,1,2,8,9],[4,9,8,6,5,2,7,3,1],[2,6,9,1,7,4,8,5,3],[1,5,3,2,9,8,4,6,7],[7,8,4,3,6,5,1,9,2]]
1310	[[9,7,3,8,4,1,2,6,5],[1,8,5,6,3,2,9,4,7],[6,2,4,5,9,7,8,1,3],[2,5,6,4,7,8,3,9,1],[4,9,7,1,6,3,5,2,8],[8,3,1,9,2,5,6,7,4],[5,6,9,7,8,4,1,3,2],[7,1,2,3,5,6,4,8,9],[3,4,8,2,1,9,7,5,6]]
1311	[[6,4,8,3,5,9,2,1,7],[3,7,2,8,1,4,9,6,5],[1,5,9,7,6,2,3,8,4],[5,3,6,4,9,1,8,7,2],[8,9,7,2,3,5,1,4,6],[4,2,1,6,7,8,5,3,9],[2,1,3,5,4,6,7,9,8],[7,8,4,9,2,3,6,5,1],[9,6,5,1,8,7,4,2,3]]
1312	[[4,8,6,3,2,9,1,7,5],[2,5,7,6,1,4,8,3,9],[1,3,9,7,5,8,2,4,6],[6,9,4,2,3,7,5,1,8],[7,1,5,9,8,6,3,2,4],[3,2,8,1,4,5,6,9,7],[9,6,3,5,7,1,4,8,2],[5,4,1,8,9,2,7,6,3],[8,7,2,4,6,3,9,5,1]]
1313	[[6,2,1,7,5,3,9,8,4],[8,5,4,9,1,6,2,7,3],[7,3,9,8,4,2,5,1,6],[4,1,5,6,9,7,8,3,2],[2,9,6,3,8,5,1,4,7],[3,8,7,1,2,4,6,9,5],[5,4,8,2,3,9,7,6,1],[1,6,3,5,7,8,4,2,9],[9,7,2,4,6,1,3,5,8]]
1314	[[3,6,8,4,1,5,2,7,9],[2,7,1,6,9,3,4,8,5],[4,5,9,7,8,2,3,1,6],[5,9,3,8,2,7,1,6,4],[1,2,6,9,3,4,8,5,7],[7,8,4,5,6,1,9,2,3],[6,1,5,2,4,9,7,3,8],[9,3,7,1,5,8,6,4,2],[8,4,2,3,7,6,5,9,1]]
1315	[[8,5,1,9,3,6,4,2,7],[6,7,4,2,5,1,8,3,9],[2,9,3,4,7,8,1,6,5],[3,4,9,8,6,7,2,5,1],[1,2,7,3,4,5,9,8,6],[5,8,6,1,9,2,7,4,3],[9,6,8,5,1,4,3,7,2],[7,3,2,6,8,9,5,1,4],[4,1,5,7,2,3,6,9,8]]
1316	[[7,6,4,3,8,1,5,2,9],[3,2,9,5,6,4,1,7,8],[5,1,8,2,9,7,3,4,6],[2,5,7,4,3,6,9,8,1],[1,8,6,9,7,2,4,3,5],[4,9,3,1,5,8,2,6,7],[9,7,1,8,4,3,6,5,2],[6,4,5,7,2,9,8,1,3],[8,3,2,6,1,5,7,9,4]]
1317	[[3,5,7,9,2,1,8,4,6],[6,1,2,8,5,4,9,3,7],[4,8,9,6,3,7,5,2,1],[5,7,1,2,4,3,6,9,8],[2,9,3,1,6,8,4,7,5],[8,6,4,5,7,9,2,1,3],[7,3,5,4,8,2,1,6,9],[9,2,6,7,1,5,3,8,4],[1,4,8,3,9,6,7,5,2]]
1318	[[9,2,5,6,4,8,3,7,1],[1,8,6,3,5,7,9,4,2],[3,4,7,1,9,2,6,8,5],[7,3,4,2,8,1,5,6,9],[2,1,8,5,6,9,4,3,7],[6,5,9,4,7,3,2,1,8],[5,7,3,8,2,6,1,9,4],[4,9,1,7,3,5,8,2,6],[8,6,2,9,1,4,7,5,3]]
1319	[[1,7,2,9,4,8,5,3,6],[4,8,6,3,5,7,1,9,2],[9,5,3,1,6,2,7,4,8],[8,4,7,5,2,3,6,1,9],[6,9,1,7,8,4,3,2,5],[2,3,5,6,9,1,8,7,4],[7,2,9,8,1,5,4,6,3],[5,1,4,2,3,6,9,8,7],[3,6,8,4,7,9,2,5,1]]
1320	[[6,7,3,2,5,1,4,8,9],[8,2,5,4,9,3,1,6,7],[1,4,9,7,8,6,2,5,3],[3,9,4,1,2,8,5,7,6],[2,6,8,9,7,5,3,4,1],[7,5,1,3,6,4,8,9,2],[4,8,7,6,3,2,9,1,5],[9,1,2,5,4,7,6,3,8],[5,3,6,8,1,9,7,2,4]]
1321	[[8,4,3,5,2,9,6,7,1],[9,7,1,6,3,4,2,5,8],[2,6,5,8,1,7,3,9,4],[4,2,6,1,9,3,7,8,5],[7,1,8,2,6,5,9,4,3],[5,3,9,7,4,8,1,2,6],[6,8,7,3,5,2,4,1,9],[1,9,2,4,8,6,5,3,7],[3,5,4,9,7,1,8,6,2]]
1322	[[3,1,8,6,7,9,5,4,2],[6,4,5,3,1,2,7,8,9],[9,2,7,8,4,5,3,1,6],[4,5,9,2,6,7,8,3,1],[8,7,1,9,3,4,6,2,5],[2,6,3,5,8,1,4,9,7],[1,3,4,7,9,6,2,5,8],[7,9,2,4,5,8,1,6,3],[5,8,6,1,2,3,9,7,4]]
1323	[[3,4,8,5,1,7,6,9,2],[7,5,9,8,6,2,3,1,4],[2,1,6,3,4,9,8,5,7],[1,8,4,7,5,6,2,3,9],[5,9,3,2,8,1,4,7,6],[6,2,7,9,3,4,1,8,5],[4,3,2,1,9,5,7,6,8],[9,7,1,6,2,8,5,4,3],[8,6,5,4,7,3,9,2,1]]
1324	[[1,8,2,5,3,9,4,7,6],[6,7,9,8,2,4,3,1,5],[3,5,4,7,6,1,8,2,9],[4,2,5,6,8,7,1,9,3],[9,1,3,2,4,5,6,8,7],[7,6,8,9,1,3,2,5,4],[5,3,1,4,7,8,9,6,2],[2,4,7,1,9,6,5,3,8],[8,9,6,3,5,2,7,4,1]]
1325	[[1,4,7,3,6,5,8,9,2],[8,5,3,4,2,9,6,7,1],[6,9,2,7,8,1,5,3,4],[4,3,1,9,5,6,7,2,8],[5,2,8,1,7,4,3,6,9],[9,7,6,2,3,8,4,1,5],[3,6,4,8,1,2,9,5,7],[2,8,5,6,9,7,1,4,3],[7,1,9,5,4,3,2,8,6]]
1326	[[9,4,1,5,6,8,7,2,3],[3,6,8,7,4,2,9,5,1],[7,5,2,9,3,1,8,4,6],[2,3,6,1,7,9,4,8,5],[4,8,7,2,5,6,1,3,9],[5,1,9,4,8,3,2,6,7],[1,9,4,3,2,5,6,7,8],[6,2,5,8,9,7,3,1,4],[8,7,3,6,1,4,5,9,2]]
1327	[[8,1,7,5,9,3,4,2,6],[3,9,6,7,4,2,1,5,8],[4,2,5,1,8,6,9,7,3],[5,6,8,9,1,7,2,3,4],[2,4,9,3,5,8,6,1,7],[7,3,1,2,6,4,8,9,5],[1,7,4,6,3,9,5,8,2],[9,8,3,4,2,5,7,6,1],[6,5,2,8,7,1,3,4,9]]
1328	[[6,5,8,2,9,4,7,1,3],[1,2,7,6,8,3,4,9,5],[4,3,9,5,7,1,6,2,8],[3,8,2,1,6,7,5,4,9],[7,1,5,4,2,9,3,8,6],[9,6,4,3,5,8,2,7,1],[5,9,3,8,4,2,1,6,7],[2,7,6,9,1,5,8,3,4],[8,4,1,7,3,6,9,5,2]]
1329	[[5,1,8,2,9,6,4,7,3],[9,2,4,7,3,8,5,6,1],[3,7,6,1,5,4,9,2,8],[2,4,9,5,8,1,7,3,6],[1,8,3,6,7,9,2,4,5],[6,5,7,4,2,3,1,8,9],[4,6,5,8,1,7,3,9,2],[8,9,2,3,4,5,6,1,7],[7,3,1,9,6,2,8,5,4]]
1330	[[2,3,8,5,4,6,7,1,9],[5,6,1,7,3,9,4,2,8],[7,4,9,8,1,2,5,3,6],[8,9,7,4,6,3,2,5,1],[6,1,5,9,2,7,8,4,3],[4,2,3,1,8,5,6,9,7],[3,8,2,6,9,4,1,7,5],[9,7,6,2,5,1,3,8,4],[1,5,4,3,7,8,9,6,2]]
1331	[[4,2,3,8,6,9,7,5,1],[5,7,1,4,3,2,9,8,6],[8,6,9,1,5,7,2,3,4],[9,4,6,3,7,8,1,2,5],[2,8,5,9,1,6,4,7,3],[1,3,7,2,4,5,8,6,9],[7,5,4,6,2,1,3,9,8],[3,9,2,5,8,4,6,1,7],[6,1,8,7,9,3,5,4,2]]
1332	[[7,2,4,9,8,5,1,3,6],[9,8,3,1,6,7,4,2,5],[6,5,1,2,3,4,7,9,8],[1,3,7,5,4,8,9,6,2],[2,4,8,6,1,9,5,7,3],[5,6,9,3,7,2,8,4,1],[3,7,5,8,9,6,2,1,4],[4,1,2,7,5,3,6,8,9],[8,9,6,4,2,1,3,5,7]]
1333	[[5,3,4,2,1,6,7,9,8],[1,9,2,8,5,7,4,6,3],[8,7,6,3,4,9,2,5,1],[6,2,3,4,7,5,1,8,9],[7,4,8,9,3,1,5,2,6],[9,1,5,6,2,8,3,4,7],[3,8,7,5,9,4,6,1,2],[4,6,1,7,8,2,9,3,5],[2,5,9,1,6,3,8,7,4]]
1334	[[5,8,7,2,6,9,4,1,3],[6,4,2,5,3,1,9,8,7],[9,3,1,8,4,7,2,6,5],[2,5,4,1,7,6,3,9,8],[8,6,9,3,5,2,7,4,1],[7,1,3,4,9,8,5,2,6],[3,2,5,6,1,4,8,7,9],[1,7,8,9,2,5,6,3,4],[4,9,6,7,8,3,1,5,2]]
1335	[[2,1,3,5,7,4,8,6,9],[8,6,4,2,3,9,1,5,7],[9,7,5,1,6,8,4,2,3],[5,4,1,8,9,2,7,3,6],[3,2,9,7,4,6,5,1,8],[6,8,7,3,5,1,2,9,4],[4,3,8,9,1,5,6,7,2],[7,5,2,6,8,3,9,4,1],[1,9,6,4,2,7,3,8,5]]
1336	[[5,8,4,9,7,3,2,1,6],[6,2,1,8,5,4,3,7,9],[9,7,3,1,2,6,8,5,4],[7,3,8,4,1,2,9,6,5],[4,5,2,3,6,9,1,8,7],[1,9,6,5,8,7,4,3,2],[3,1,9,6,4,5,7,2,8],[2,4,5,7,3,8,6,9,1],[8,6,7,2,9,1,5,4,3]]
1337	[[2,8,9,6,4,5,7,1,3],[4,1,6,2,3,7,5,8,9],[5,7,3,8,9,1,6,2,4],[7,5,2,9,1,4,8,3,6],[6,9,8,3,7,2,4,5,1],[3,4,1,5,8,6,9,7,2],[8,2,5,4,6,3,1,9,7],[9,6,7,1,2,8,3,4,5],[1,3,4,7,5,9,2,6,8]]
1338	[[2,8,9,7,3,4,1,5,6],[6,7,1,5,8,9,4,3,2],[5,3,4,1,6,2,7,8,9],[8,1,6,9,2,3,5,4,7],[7,4,2,6,1,5,3,9,8],[9,5,3,8,4,7,2,6,1],[4,2,8,3,9,1,6,7,5],[1,9,7,4,5,6,8,2,3],[3,6,5,2,7,8,9,1,4]]
1339	[[4,7,2,1,5,3,9,8,6],[5,3,9,2,6,8,7,1,4],[8,1,6,4,9,7,5,2,3],[9,6,7,8,1,2,3,4,5],[3,8,4,5,7,9,1,6,2],[2,5,1,3,4,6,8,7,9],[6,9,8,7,2,5,4,3,1],[7,4,5,6,3,1,2,9,8],[1,2,3,9,8,4,6,5,7]]
1340	[[4,5,3,7,9,6,8,1,2],[8,1,6,2,5,4,9,7,3],[7,2,9,3,8,1,5,4,6],[5,4,1,8,6,3,2,9,7],[3,7,8,4,2,9,1,6,5],[9,6,2,5,1,7,4,3,8],[1,9,5,6,7,2,3,8,4],[2,3,7,1,4,8,6,5,9],[6,8,4,9,3,5,7,2,1]]
1341	[[5,2,1,7,8,3,9,4,6],[9,4,7,5,6,1,2,8,3],[3,8,6,9,4,2,1,5,7],[8,7,5,3,1,4,6,9,2],[2,3,9,6,7,8,4,1,5],[6,1,4,2,9,5,3,7,8],[7,6,8,1,2,9,5,3,4],[1,5,2,4,3,7,8,6,9],[4,9,3,8,5,6,7,2,1]]
1342	[[4,2,7,6,5,3,1,9,8],[5,3,9,7,8,1,2,4,6],[1,6,8,4,9,2,7,3,5],[3,5,1,8,4,7,6,2,9],[8,4,6,2,3,9,5,1,7],[7,9,2,1,6,5,3,8,4],[6,7,4,3,2,8,9,5,1],[2,8,5,9,1,6,4,7,3],[9,1,3,5,7,4,8,6,2]]
1343	[[9,3,2,7,6,4,1,8,5],[7,6,8,5,2,1,9,4,3],[4,1,5,8,3,9,2,7,6],[3,2,6,4,5,8,7,9,1],[8,4,9,3,1,7,6,5,2],[1,5,7,6,9,2,4,3,8],[2,7,3,9,8,6,5,1,4],[6,8,4,1,7,5,3,2,9],[5,9,1,2,4,3,8,6,7]]
1344	[[9,2,5,4,3,1,6,8,7],[3,7,1,6,8,2,5,4,9],[8,4,6,9,5,7,1,2,3],[2,3,9,5,1,6,4,7,8],[5,1,4,3,7,8,2,9,6],[6,8,7,2,9,4,3,1,5],[1,6,8,7,4,3,9,5,2],[4,5,2,8,6,9,7,3,1],[7,9,3,1,2,5,8,6,4]]
1345	[[3,5,7,2,6,9,8,4,1],[1,4,6,5,3,8,2,9,7],[2,8,9,4,1,7,5,6,3],[5,6,1,7,8,3,4,2,9],[7,9,4,1,2,6,3,5,8],[8,3,2,9,5,4,7,1,6],[9,2,3,6,7,5,1,8,4],[4,1,8,3,9,2,6,7,5],[6,7,5,8,4,1,9,3,2]]
1346	[[3,8,4,5,7,1,2,6,9],[7,6,9,3,4,2,5,1,8],[2,5,1,9,6,8,7,3,4],[1,7,2,8,3,5,4,9,6],[9,4,8,1,2,6,3,5,7],[5,3,6,4,9,7,8,2,1],[6,2,3,7,1,4,9,8,5],[8,1,7,2,5,9,6,4,3],[4,9,5,6,8,3,1,7,2]]
1347	[[6,5,8,4,2,3,1,9,7],[2,9,3,6,1,7,4,8,5],[7,4,1,8,9,5,6,3,2],[8,1,5,3,6,4,7,2,9],[9,2,4,5,7,1,3,6,8],[3,7,6,2,8,9,5,4,1],[1,3,9,7,4,8,2,5,6],[5,8,2,1,3,6,9,7,4],[4,6,7,9,5,2,8,1,3]]
1348	[[7,3,6,4,5,1,2,9,8],[4,9,1,2,8,7,3,6,5],[2,8,5,3,6,9,1,4,7],[8,4,7,6,3,2,5,1,9],[6,5,2,9,1,8,7,3,4],[3,1,9,5,7,4,8,2,6],[9,6,8,1,2,5,4,7,3],[1,7,4,8,9,3,6,5,2],[5,2,3,7,4,6,9,8,1]]
1349	[[3,1,5,8,2,7,4,6,9],[7,6,4,5,3,9,1,2,8],[9,2,8,4,6,1,3,5,7],[2,7,6,3,4,8,9,1,5],[8,9,3,2,1,5,7,4,6],[5,4,1,9,7,6,8,3,2],[6,3,7,1,9,2,5,8,4],[4,8,9,6,5,3,2,7,1],[1,5,2,7,8,4,6,9,3]]
1350	[[5,2,3,6,9,7,8,1,4],[7,4,8,1,5,3,6,9,2],[6,9,1,2,8,4,5,3,7],[8,7,6,9,3,2,4,5,1],[3,1,4,5,7,8,2,6,9],[2,5,9,4,6,1,3,7,8],[1,6,2,3,4,9,7,8,5],[4,8,5,7,1,6,9,2,3],[9,3,7,8,2,5,1,4,6]]
1351	[[5,1,4,3,7,2,6,8,9],[2,8,7,6,4,9,5,3,1],[9,3,6,8,5,1,2,4,7],[7,5,1,9,8,6,3,2,4],[3,2,9,5,1,4,7,6,8],[4,6,8,2,3,7,1,9,5],[6,4,5,1,9,3,8,7,2],[1,7,3,4,2,8,9,5,6],[8,9,2,7,6,5,4,1,3]]
1352	[[5,6,3,9,2,4,8,7,1],[9,8,4,1,7,6,2,5,3],[1,2,7,3,8,5,6,4,9],[3,9,2,8,1,7,4,6,5],[8,1,6,5,4,3,9,2,7],[7,4,5,6,9,2,3,1,8],[4,5,8,7,6,9,1,3,2],[6,3,1,2,5,8,7,9,4],[2,7,9,4,3,1,5,8,6]]
1353	[[8,2,3,7,5,4,1,9,6],[4,6,5,9,1,2,8,7,3],[7,1,9,6,8,3,2,4,5],[1,4,2,3,9,6,7,5,8],[5,8,6,2,7,1,9,3,4],[3,9,7,5,4,8,6,2,1],[6,3,4,8,2,7,5,1,9],[9,7,1,4,6,5,3,8,2],[2,5,8,1,3,9,4,6,7]]
1354	[[3,2,6,4,8,9,7,5,1],[7,9,8,5,3,1,4,2,6],[4,5,1,2,6,7,3,9,8],[8,4,3,9,1,6,5,7,2],[6,7,9,3,2,5,1,8,4],[2,1,5,8,7,4,6,3,9],[1,8,2,7,4,3,9,6,5],[9,3,4,6,5,2,8,1,7],[5,6,7,1,9,8,2,4,3]]
1355	[[2,4,8,3,1,5,7,6,9],[1,9,5,6,8,7,4,3,2],[3,7,6,2,4,9,5,1,8],[4,1,7,5,9,2,6,8,3],[6,5,9,8,3,4,2,7,1],[8,2,3,7,6,1,9,5,4],[5,3,2,9,7,8,1,4,6],[9,6,1,4,5,3,8,2,7],[7,8,4,1,2,6,3,9,5]]
1356	[[6,3,2,7,1,4,5,9,8],[4,5,9,2,6,8,3,7,1],[7,1,8,5,9,3,4,2,6],[8,2,6,4,3,5,7,1,9],[3,4,1,9,8,7,6,5,2],[5,9,7,1,2,6,8,3,4],[1,7,5,6,4,2,9,8,3],[9,6,3,8,5,1,2,4,7],[2,8,4,3,7,9,1,6,5]]
1357	[[1,4,8,5,6,3,9,7,2],[5,2,7,9,4,8,3,6,1],[6,9,3,7,2,1,8,4,5],[4,5,2,6,1,9,7,3,8],[8,7,1,2,3,4,6,5,9],[9,3,6,8,5,7,2,1,4],[7,6,5,4,8,2,1,9,3],[2,1,4,3,9,6,5,8,7],[3,8,9,1,7,5,4,2,6]]
1358	[[5,8,6,7,2,9,3,4,1],[7,1,2,3,4,5,6,8,9],[3,9,4,1,8,6,5,7,2],[1,2,3,4,7,8,9,5,6],[6,4,9,2,5,3,8,1,7],[8,7,5,9,6,1,4,2,3],[4,6,1,8,9,2,7,3,5],[9,3,7,5,1,4,2,6,8],[2,5,8,6,3,7,1,9,4]]
1359	[[4,3,9,6,7,2,1,5,8],[1,5,6,8,9,4,3,2,7],[2,8,7,5,1,3,4,9,6],[5,4,2,3,6,1,8,7,9],[6,7,8,4,2,9,5,1,3],[3,9,1,7,5,8,6,4,2],[8,2,4,9,3,5,7,6,1],[7,1,3,2,4,6,9,8,5],[9,6,5,1,8,7,2,3,4]]
1360	[[8,6,9,5,1,7,2,4,3],[2,1,7,4,3,8,5,9,6],[4,3,5,9,6,2,1,8,7],[3,9,2,6,7,1,4,5,8],[7,5,4,8,9,3,6,1,2],[1,8,6,2,4,5,7,3,9],[9,2,8,7,5,4,3,6,1],[5,7,3,1,8,6,9,2,4],[6,4,1,3,2,9,8,7,5]]
1361	[[8,6,2,9,7,4,5,1,3],[7,9,5,3,2,1,4,6,8],[3,1,4,8,6,5,7,9,2],[1,2,9,6,3,7,8,5,4],[5,4,7,1,9,8,2,3,6],[6,3,8,5,4,2,1,7,9],[4,5,6,2,1,3,9,8,7],[9,7,1,4,8,6,3,2,5],[2,8,3,7,5,9,6,4,1]]
1362	[[1,4,8,5,2,7,9,6,3],[9,3,5,6,4,8,7,1,2],[2,6,7,1,3,9,5,4,8],[7,8,1,9,5,6,2,3,4],[3,5,9,2,8,4,1,7,6],[4,2,6,7,1,3,8,9,5],[5,9,2,3,6,1,4,8,7],[8,1,3,4,7,5,6,2,9],[6,7,4,8,9,2,3,5,1]]
1363	[[3,2,7,6,5,4,1,8,9],[9,5,4,2,1,8,7,6,3],[1,6,8,9,3,7,2,4,5],[4,9,1,7,6,5,3,2,8],[2,3,6,8,4,9,5,1,7],[7,8,5,3,2,1,6,9,4],[8,1,2,4,7,3,9,5,6],[5,4,3,1,9,6,8,7,2],[6,7,9,5,8,2,4,3,1]]
1364	[[3,5,8,6,4,2,7,1,9],[2,6,1,9,8,7,4,3,5],[4,7,9,3,1,5,8,2,6],[1,2,7,5,9,4,6,8,3],[5,9,3,7,6,8,2,4,1],[8,4,6,2,3,1,5,9,7],[6,1,4,8,5,3,9,7,2],[9,3,2,4,7,6,1,5,8],[7,8,5,1,2,9,3,6,4]]
1365	[[2,9,4,8,5,1,7,6,3],[6,5,1,7,9,3,4,8,2],[8,7,3,6,2,4,9,1,5],[1,8,9,3,7,5,6,2,4],[5,4,7,2,1,6,3,9,8],[3,2,6,9,4,8,1,5,7],[9,3,8,5,6,7,2,4,1],[4,6,5,1,3,2,8,7,9],[7,1,2,4,8,9,5,3,6]]
1366	[[6,4,9,5,1,3,8,2,7],[8,3,5,7,2,6,9,1,4],[2,1,7,4,8,9,5,6,3],[9,5,8,1,7,4,6,3,2],[3,2,1,6,9,5,4,7,8],[7,6,4,8,3,2,1,9,5],[5,7,6,2,4,1,3,8,9],[1,8,3,9,5,7,2,4,6],[4,9,2,3,6,8,7,5,1]]
1367	[[2,4,7,5,6,3,8,9,1],[6,8,3,9,1,7,2,4,5],[9,1,5,2,4,8,3,6,7],[4,3,9,8,7,6,1,5,2],[8,5,6,1,3,2,4,7,9],[1,7,2,4,5,9,6,3,8],[7,6,8,3,9,1,5,2,4],[3,2,4,7,8,5,9,1,6],[5,9,1,6,2,4,7,8,3]]
1368	[[8,4,6,2,3,5,7,1,9],[9,3,7,1,4,8,5,2,6],[1,5,2,7,6,9,3,8,4],[7,8,5,4,2,6,1,9,3],[6,2,3,5,9,1,4,7,8],[4,9,1,3,8,7,6,5,2],[3,1,8,6,5,2,9,4,7],[5,6,9,8,7,4,2,3,1],[2,7,4,9,1,3,8,6,5]]
1369	[[6,4,3,2,5,7,9,1,8],[8,5,9,6,3,1,7,4,2],[7,1,2,4,9,8,5,6,3],[3,9,5,8,1,4,6,2,7],[2,6,4,9,7,3,1,8,5],[1,8,7,5,2,6,4,3,9],[5,2,1,3,4,9,8,7,6],[4,3,6,7,8,5,2,9,1],[9,7,8,1,6,2,3,5,4]]
1370	[[7,8,2,5,9,6,4,1,3],[4,3,6,1,2,8,7,5,9],[9,1,5,7,4,3,2,8,6],[1,2,3,4,8,7,6,9,5],[8,5,4,3,6,9,1,2,7],[6,9,7,2,1,5,8,3,4],[5,6,9,8,7,1,3,4,2],[3,4,1,6,5,2,9,7,8],[2,7,8,9,3,4,5,6,1]]
1371	[[5,4,6,7,1,9,8,2,3],[9,7,8,3,2,6,5,1,4],[3,1,2,4,5,8,6,7,9],[7,8,3,6,9,5,1,4,2],[2,5,9,1,3,4,7,6,8],[1,6,4,2,8,7,9,3,5],[6,2,5,9,4,1,3,8,7],[4,9,1,8,7,3,2,5,6],[8,3,7,5,6,2,4,9,1]]
1372	[[1,8,4,2,6,9,7,5,3],[7,3,6,5,8,4,1,9,2],[9,2,5,1,3,7,8,4,6],[4,1,3,6,7,5,9,2,8],[5,6,2,8,9,1,3,7,4],[8,9,7,4,2,3,6,1,5],[2,7,1,3,4,6,5,8,9],[6,4,9,7,5,8,2,3,1],[3,5,8,9,1,2,4,6,7]]
1373	[[1,2,9,4,6,3,8,5,7],[6,7,4,2,8,5,3,9,1],[3,5,8,9,1,7,2,6,4],[2,3,6,8,9,1,7,4,5],[7,4,1,5,3,2,9,8,6],[8,9,5,7,4,6,1,3,2],[9,6,3,1,2,4,5,7,8],[4,1,7,3,5,8,6,2,9],[5,8,2,6,7,9,4,1,3]]
1374	[[3,6,2,8,5,4,1,9,7],[5,8,9,1,7,6,4,2,3],[1,7,4,9,2,3,6,8,5],[6,1,5,3,9,8,7,4,2],[8,2,3,7,4,1,5,6,9],[9,4,7,2,6,5,8,3,1],[2,3,1,4,8,7,9,5,6],[7,5,8,6,3,9,2,1,4],[4,9,6,5,1,2,3,7,8]]
1375	[[2,4,6,5,1,9,7,8,3],[8,1,7,4,3,6,9,2,5],[5,9,3,8,2,7,1,6,4],[7,3,1,2,5,4,8,9,6],[6,5,4,9,7,8,2,3,1],[9,8,2,3,6,1,5,4,7],[1,2,5,6,9,3,4,7,8],[3,7,8,1,4,2,6,5,9],[4,6,9,7,8,5,3,1,2]]
1376	[[9,5,8,4,7,6,1,2,3],[6,3,2,5,8,1,9,7,4],[4,7,1,9,2,3,8,5,6],[3,1,6,2,9,7,4,8,5],[5,4,7,3,6,8,2,9,1],[8,2,9,1,5,4,3,6,7],[7,6,3,8,1,9,5,4,2],[2,8,4,7,3,5,6,1,9],[1,9,5,6,4,2,7,3,8]]
1377	[[3,8,2,1,9,4,5,7,6],[7,6,4,2,8,5,1,3,9],[9,1,5,3,6,7,4,2,8],[1,3,6,8,5,2,9,4,7],[8,2,7,9,4,3,6,1,5],[4,5,9,7,1,6,3,8,2],[6,7,3,4,2,9,8,5,1],[2,9,1,5,3,8,7,6,4],[5,4,8,6,7,1,2,9,3]]
1378	[[3,6,9,7,2,5,4,1,8],[5,7,8,1,4,3,9,6,2],[2,1,4,8,9,6,5,3,7],[8,9,1,4,3,7,2,5,6],[6,3,7,2,5,8,1,9,4],[4,5,2,9,6,1,7,8,3],[7,8,3,5,1,4,6,2,9],[1,2,6,3,7,9,8,4,5],[9,4,5,6,8,2,3,7,1]]
1379	[[8,7,1,5,3,4,6,9,2],[3,6,5,8,9,2,1,7,4],[4,2,9,1,6,7,8,3,5],[1,9,3,7,2,8,4,5,6],[6,8,4,9,1,5,3,2,7],[7,5,2,3,4,6,9,1,8],[9,4,8,2,5,1,7,6,3],[5,1,6,4,7,3,2,8,9],[2,3,7,6,8,9,5,4,1]]
1380	[[2,7,6,1,5,8,9,4,3],[1,4,3,9,6,7,2,8,5],[5,9,8,2,3,4,7,6,1],[9,3,2,8,1,6,5,7,4],[6,1,4,5,7,3,8,9,2],[7,8,5,4,9,2,1,3,6],[4,2,7,6,8,1,3,5,9],[8,5,1,3,4,9,6,2,7],[3,6,9,7,2,5,4,1,8]]
1381	[[1,2,9,6,5,7,3,4,8],[3,5,7,8,2,4,9,1,6],[4,6,8,1,3,9,2,5,7],[2,7,4,5,8,3,6,9,1],[5,1,6,9,7,2,8,3,4],[8,9,3,4,6,1,7,2,5],[6,4,2,7,9,5,1,8,3],[7,3,1,2,4,8,5,6,9],[9,8,5,3,1,6,4,7,2]]
1382	[[7,2,5,8,1,9,3,6,4],[4,6,8,7,3,5,9,2,1],[9,1,3,4,6,2,7,5,8],[1,3,9,6,5,8,4,7,2],[6,4,7,3,2,1,8,9,5],[8,5,2,9,4,7,1,3,6],[5,8,4,2,7,3,6,1,9],[2,7,6,1,9,4,5,8,3],[3,9,1,5,8,6,2,4,7]]
1383	[[2,4,6,3,9,5,8,7,1],[5,8,9,1,4,7,3,2,6],[3,1,7,2,6,8,5,9,4],[1,3,2,9,7,4,6,5,8],[4,9,8,6,5,3,7,1,2],[7,6,5,8,2,1,9,4,3],[8,5,4,7,1,6,2,3,9],[9,7,3,4,8,2,1,6,5],[6,2,1,5,3,9,4,8,7]]
1384	[[5,3,7,4,6,8,9,1,2],[8,2,6,1,3,9,4,7,5],[4,1,9,7,2,5,3,8,6],[1,5,4,8,7,6,2,3,9],[7,6,3,9,5,2,1,4,8],[9,8,2,3,4,1,6,5,7],[3,4,5,2,9,7,8,6,1],[2,7,1,6,8,4,5,9,3],[6,9,8,5,1,3,7,2,4]]
1385	[[4,1,6,3,8,9,5,7,2],[5,7,9,1,2,6,3,4,8],[8,3,2,5,7,4,6,9,1],[9,2,8,7,6,3,1,5,4],[7,4,5,2,1,8,9,3,6],[1,6,3,4,9,5,2,8,7],[6,8,4,9,3,2,7,1,5],[3,5,1,6,4,7,8,2,9],[2,9,7,8,5,1,4,6,3]]
1386	[[2,8,5,1,4,9,7,3,6],[7,3,9,8,6,5,2,1,4],[4,1,6,2,7,3,9,5,8],[3,2,8,9,5,6,4,7,1],[6,5,7,3,1,4,8,2,9],[9,4,1,7,2,8,3,6,5],[1,9,4,5,3,7,6,8,2],[5,6,3,4,8,2,1,9,7],[8,7,2,6,9,1,5,4,3]]
1387	[[6,8,9,5,3,7,1,4,2],[5,2,4,6,1,8,9,7,3],[3,1,7,2,4,9,5,6,8],[2,7,1,9,8,3,4,5,6],[9,3,5,4,7,6,8,2,1],[8,4,6,1,5,2,7,3,9],[7,5,2,3,9,1,6,8,4],[1,6,8,7,2,4,3,9,5],[4,9,3,8,6,5,2,1,7]]
1388	[[8,6,4,9,7,1,5,2,3],[2,1,3,8,5,6,9,7,4],[5,9,7,2,3,4,1,8,6],[4,7,2,5,8,3,6,9,1],[6,3,1,4,2,9,8,5,7],[9,8,5,1,6,7,3,4,2],[1,2,8,3,4,5,7,6,9],[7,5,9,6,1,2,4,3,8],[3,4,6,7,9,8,2,1,5]]
1389	[[8,7,9,1,2,3,4,6,5],[1,4,2,6,9,5,8,3,7],[5,6,3,4,7,8,9,1,2],[9,8,4,7,6,1,5,2,3],[3,2,1,5,8,4,6,7,9],[6,5,7,2,3,9,1,4,8],[4,1,8,3,5,2,7,9,6],[7,3,5,9,1,6,2,8,4],[2,9,6,8,4,7,3,5,1]]
1390	[[8,2,9,5,6,4,7,3,1],[3,6,7,1,2,8,9,4,5],[1,5,4,3,7,9,6,8,2],[5,9,3,2,8,1,4,6,7],[2,4,8,7,9,6,1,5,3],[7,1,6,4,5,3,8,2,9],[6,3,2,8,1,7,5,9,4],[9,7,5,6,4,2,3,1,8],[4,8,1,9,3,5,2,7,6]]
1391	[[8,1,3,4,2,7,6,9,5],[5,2,9,6,8,3,4,7,1],[7,4,6,9,5,1,8,2,3],[3,8,2,7,9,4,1,5,6],[9,6,5,8,1,2,3,4,7],[4,7,1,5,3,6,9,8,2],[6,5,7,1,4,8,2,3,9],[2,9,8,3,6,5,7,1,4],[1,3,4,2,7,9,5,6,8]]
1392	[[7,1,9,2,6,3,8,5,4],[6,2,4,5,8,1,3,9,7],[3,8,5,9,7,4,6,2,1],[4,3,8,1,2,7,5,6,9],[2,9,1,6,5,8,4,7,3],[5,7,6,3,4,9,1,8,2],[8,6,3,4,9,2,7,1,5],[1,5,2,7,3,6,9,4,8],[9,4,7,8,1,5,2,3,6]]
1393	[[9,5,4,2,8,7,1,6,3],[1,6,2,5,9,3,4,8,7],[7,8,3,6,4,1,5,9,2],[6,1,9,8,5,2,3,7,4],[4,2,7,3,6,9,8,5,1],[8,3,5,1,7,4,9,2,6],[2,7,1,9,3,5,6,4,8],[3,9,6,4,2,8,7,1,5],[5,4,8,7,1,6,2,3,9]]
1394	[[8,7,9,2,1,3,5,4,6],[3,4,2,8,5,6,9,1,7],[1,5,6,9,7,4,3,2,8],[7,2,5,4,8,9,1,6,3],[6,1,8,7,3,2,4,5,9],[4,9,3,1,6,5,8,7,2],[5,3,4,6,2,8,7,9,1],[9,6,1,3,4,7,2,8,5],[2,8,7,5,9,1,6,3,4]]
1395	[[2,1,5,6,8,9,3,4,7],[7,8,3,2,5,4,1,6,9],[9,6,4,3,7,1,2,5,8],[1,4,9,7,3,5,6,8,2],[8,3,6,9,1,2,5,7,4],[5,2,7,4,6,8,9,3,1],[3,9,2,5,4,7,8,1,6],[4,5,8,1,9,6,7,2,3],[6,7,1,8,2,3,4,9,5]]
1396	[[6,9,2,1,7,5,8,3,4],[8,1,3,2,6,4,7,9,5],[4,7,5,8,3,9,6,1,2],[7,3,8,5,4,1,9,2,6],[1,5,4,9,2,6,3,8,7],[9,2,6,3,8,7,5,4,1],[3,8,1,6,5,2,4,7,9],[5,4,9,7,1,3,2,6,8],[2,6,7,4,9,8,1,5,3]]
1397	[[1,9,8,7,6,3,2,4,5],[7,6,2,4,8,5,1,9,3],[5,4,3,9,2,1,7,6,8],[6,2,7,8,3,4,9,5,1],[8,5,4,1,9,6,3,2,7],[9,3,1,2,5,7,4,8,6],[3,1,9,6,4,8,5,7,2],[4,7,6,5,1,2,8,3,9],[2,8,5,3,7,9,6,1,4]]
1398	[[5,9,7,6,2,8,4,1,3],[8,6,4,1,3,7,5,2,9],[2,1,3,9,4,5,8,7,6],[1,8,5,2,7,3,9,6,4],[4,3,9,5,1,6,2,8,7],[6,7,2,4,8,9,1,3,5],[9,4,8,3,6,1,7,5,2],[7,5,6,8,9,2,3,4,1],[3,2,1,7,5,4,6,9,8]]
1399	[[7,2,8,5,9,6,4,1,3],[6,4,9,1,2,3,5,8,7],[5,1,3,7,8,4,9,6,2],[1,8,6,3,4,2,7,5,9],[9,7,2,6,1,5,8,3,4],[4,3,5,9,7,8,1,2,6],[8,5,4,2,6,9,3,7,1],[2,9,1,8,3,7,6,4,5],[3,6,7,4,5,1,2,9,8]]
1400	[[6,5,9,1,3,2,8,4,7],[3,1,4,8,9,7,2,6,5],[8,7,2,4,5,6,3,1,9],[7,2,1,9,8,3,4,5,6],[9,6,5,7,2,4,1,8,3],[4,3,8,6,1,5,9,7,2],[1,8,7,3,6,9,5,2,4],[5,4,3,2,7,1,6,9,8],[2,9,6,5,4,8,7,3,1]]
1401	[[4,2,6,8,7,1,5,9,3],[1,8,3,9,5,2,6,4,7],[7,9,5,3,4,6,2,1,8],[9,6,4,2,3,8,7,5,1],[2,5,1,4,6,7,3,8,9],[3,7,8,5,1,9,4,6,2],[5,1,7,6,9,3,8,2,4],[6,3,2,1,8,4,9,7,5],[8,4,9,7,2,5,1,3,6]]
1402	[[8,1,6,5,7,3,9,2,4],[4,2,7,8,9,6,3,5,1],[5,9,3,2,4,1,7,8,6],[1,7,2,9,3,4,5,6,8],[3,5,8,1,6,2,4,9,7],[6,4,9,7,8,5,1,3,2],[9,6,5,4,1,8,2,7,3],[2,3,4,6,5,7,8,1,9],[7,8,1,3,2,9,6,4,5]]
1403	[[5,2,4,3,8,6,9,1,7],[7,9,3,5,1,4,2,6,8],[6,1,8,7,9,2,5,3,4],[9,4,7,2,5,3,1,8,6],[1,3,2,6,7,8,4,9,5],[8,6,5,9,4,1,7,2,3],[2,5,9,8,6,7,3,4,1],[3,8,1,4,2,5,6,7,9],[4,7,6,1,3,9,8,5,2]]
1404	[[9,6,8,3,5,2,7,1,4],[7,5,3,4,1,9,2,8,6],[2,1,4,8,6,7,3,5,9],[3,8,2,9,4,5,1,6,7],[1,4,5,7,3,6,8,9,2],[6,7,9,1,2,8,4,3,5],[4,9,6,2,8,1,5,7,3],[5,2,1,6,7,3,9,4,8],[8,3,7,5,9,4,6,2,1]]
1405	[[2,3,5,8,9,6,1,7,4],[1,6,8,7,4,3,9,5,2],[4,7,9,2,1,5,3,8,6],[8,2,7,4,3,9,5,6,1],[6,1,4,5,2,8,7,9,3],[9,5,3,1,6,7,4,2,8],[7,9,6,3,8,4,2,1,5],[5,4,1,6,7,2,8,3,9],[3,8,2,9,5,1,6,4,7]]
1406	[[3,6,4,9,8,1,5,2,7],[1,7,5,6,4,2,9,3,8],[8,2,9,5,3,7,6,4,1],[4,5,3,2,7,9,8,1,6],[7,8,6,3,1,5,2,9,4],[2,9,1,8,6,4,7,5,3],[5,4,8,7,9,3,1,6,2],[6,1,2,4,5,8,3,7,9],[9,3,7,1,2,6,4,8,5]]
1407	[[8,5,1,2,6,9,3,7,4],[9,7,3,8,1,4,6,2,5],[6,4,2,5,7,3,8,9,1],[2,8,4,9,5,1,7,6,3],[3,6,5,4,8,7,9,1,2],[1,9,7,3,2,6,5,4,8],[5,1,9,6,3,2,4,8,7],[7,3,6,1,4,8,2,5,9],[4,2,8,7,9,5,1,3,6]]
1408	[[2,7,3,9,1,8,6,5,4],[5,1,8,4,6,3,9,2,7],[6,9,4,2,7,5,3,1,8],[8,4,9,6,2,1,5,7,3],[7,5,6,3,4,9,1,8,2],[3,2,1,5,8,7,4,9,6],[9,8,7,1,3,4,2,6,5],[1,3,2,7,5,6,8,4,9],[4,6,5,8,9,2,7,3,1]]
1409	[[1,4,5,8,2,6,3,7,9],[3,8,7,9,4,1,6,2,5],[2,9,6,7,3,5,8,4,1],[7,5,3,6,8,4,9,1,2],[4,6,9,2,1,3,7,5,8],[8,1,2,5,9,7,4,6,3],[9,3,4,1,7,2,5,8,6],[6,7,1,3,5,8,2,9,4],[5,2,8,4,6,9,1,3,7]]
1410	[[7,2,3,1,6,9,8,5,4],[8,9,1,5,2,4,3,7,6],[5,6,4,7,3,8,1,9,2],[6,1,2,3,4,5,9,8,7],[9,3,8,6,1,7,2,4,5],[4,7,5,9,8,2,6,1,3],[2,4,9,8,7,3,5,6,1],[3,8,6,4,5,1,7,2,9],[1,5,7,2,9,6,4,3,8]]
1411	[[9,6,3,1,8,2,5,7,4],[5,7,2,9,6,4,8,1,3],[4,1,8,5,3,7,9,6,2],[3,4,7,2,1,8,6,5,9],[2,5,6,4,7,9,1,3,8],[1,8,9,3,5,6,4,2,7],[8,3,1,7,4,5,2,9,6],[6,2,5,8,9,3,7,4,1],[7,9,4,6,2,1,3,8,5]]
1412	[[5,6,2,4,3,8,7,9,1],[9,4,7,5,1,2,8,3,6],[3,1,8,9,7,6,4,2,5],[1,9,6,8,4,5,3,7,2],[7,2,4,1,6,3,5,8,9],[8,3,5,2,9,7,6,1,4],[2,7,1,3,5,4,9,6,8],[6,5,9,7,8,1,2,4,3],[4,8,3,6,2,9,1,5,7]]
1413	[[8,7,4,6,9,3,5,2,1],[6,5,3,1,7,2,9,4,8],[9,2,1,5,4,8,6,3,7],[4,6,7,2,8,1,3,5,9],[3,9,2,7,5,6,8,1,4],[5,1,8,4,3,9,2,7,6],[2,4,9,8,1,5,7,6,3],[7,8,5,3,6,4,1,9,2],[1,3,6,9,2,7,4,8,5]]
1414	[[5,2,4,8,7,3,9,6,1],[6,9,7,1,4,2,8,3,5],[3,8,1,5,9,6,7,2,4],[1,7,2,3,6,5,4,9,8],[4,5,3,9,8,7,2,1,6],[8,6,9,4,2,1,3,5,7],[7,4,6,2,5,9,1,8,3],[2,3,8,6,1,4,5,7,9],[9,1,5,7,3,8,6,4,2]]
1415	[[2,1,8,9,3,6,4,7,5],[7,9,4,5,2,8,6,1,3],[5,6,3,4,1,7,8,9,2],[1,4,9,6,8,5,2,3,7],[6,3,5,7,9,2,1,4,8],[8,2,7,1,4,3,5,6,9],[9,7,6,8,5,4,3,2,1],[4,5,2,3,7,1,9,8,6],[3,8,1,2,6,9,7,5,4]]
1416	[[2,9,5,7,1,8,6,4,3],[1,4,8,9,6,3,5,7,2],[6,7,3,4,5,2,8,1,9],[5,3,7,6,8,9,1,2,4],[4,8,2,5,7,1,3,9,6],[9,1,6,2,3,4,7,5,8],[3,2,1,8,4,5,9,6,7],[7,5,4,3,9,6,2,8,1],[8,6,9,1,2,7,4,3,5]]
1417	[[9,8,6,2,7,4,1,3,5],[3,4,5,6,1,8,7,9,2],[1,7,2,5,3,9,6,4,8],[4,6,9,8,5,1,3,2,7],[8,3,1,7,9,2,5,6,4],[2,5,7,3,4,6,8,1,9],[7,2,3,4,6,5,9,8,1],[6,1,8,9,2,7,4,5,3],[5,9,4,1,8,3,2,7,6]]
1418	[[9,7,5,6,8,3,1,2,4],[8,3,6,2,4,1,9,5,7],[2,1,4,9,5,7,6,3,8],[5,8,7,4,6,9,2,1,3],[1,9,3,7,2,5,8,4,6],[4,6,2,1,3,8,5,7,9],[7,4,1,5,9,6,3,8,2],[3,5,9,8,7,2,4,6,1],[6,2,8,3,1,4,7,9,5]]
1419	[[3,6,8,7,2,4,9,5,1],[7,2,1,3,5,9,6,4,8],[9,4,5,6,1,8,2,3,7],[2,1,3,9,7,5,4,8,6],[4,7,9,8,3,6,1,2,5],[8,5,6,2,4,1,3,7,9],[6,9,2,5,8,3,7,1,4],[5,3,4,1,9,7,8,6,2],[1,8,7,4,6,2,5,9,3]]
1420	[[7,4,1,9,8,2,3,5,6],[2,3,8,6,4,5,9,1,7],[5,9,6,3,7,1,4,8,2],[9,5,3,7,1,8,6,2,4],[4,1,2,5,6,9,7,3,8],[8,6,7,2,3,4,5,9,1],[1,8,5,4,9,7,2,6,3],[6,2,4,1,5,3,8,7,9],[3,7,9,8,2,6,1,4,5]]
1421	[[4,2,1,5,9,8,7,3,6],[3,5,7,6,2,4,8,1,9],[9,8,6,3,7,1,4,5,2],[8,1,4,7,5,6,2,9,3],[5,3,2,4,1,9,6,8,7],[6,7,9,2,8,3,1,4,5],[7,4,3,1,6,5,9,2,8],[1,6,8,9,3,2,5,7,4],[2,9,5,8,4,7,3,6,1]]
1422	[[5,7,8,6,4,1,3,2,9],[2,1,4,3,7,9,5,6,8],[9,3,6,2,8,5,1,7,4],[6,9,3,5,2,4,7,8,1],[7,5,1,9,3,8,2,4,6],[8,4,2,7,1,6,9,3,5],[4,6,7,1,5,2,8,9,3],[1,2,9,8,6,3,4,5,7],[3,8,5,4,9,7,6,1,2]]
1423	[[7,4,2,9,8,5,3,6,1],[3,8,1,4,6,2,7,9,5],[6,9,5,3,1,7,8,2,4],[1,5,8,6,4,9,2,3,7],[4,6,7,2,3,1,5,8,9],[2,3,9,7,5,8,4,1,6],[9,1,3,8,7,4,6,5,2],[8,2,4,5,9,6,1,7,3],[5,7,6,1,2,3,9,4,8]]
1424	[[1,9,2,4,8,5,3,7,6],[6,5,3,2,7,9,4,1,8],[7,4,8,6,1,3,2,9,5],[8,7,4,3,2,6,9,5,1],[3,2,5,7,9,1,8,6,4],[9,6,1,8,5,4,7,3,2],[4,3,7,5,6,8,1,2,9],[5,8,9,1,3,2,6,4,7],[2,1,6,9,4,7,5,8,3]]
1425	[[9,3,5,6,1,8,2,7,4],[7,8,4,2,5,3,1,9,6],[6,1,2,4,7,9,5,3,8],[1,9,3,7,8,6,4,2,5],[5,2,8,1,9,4,3,6,7],[4,7,6,3,2,5,9,8,1],[3,5,1,9,6,7,8,4,2],[8,6,9,5,4,2,7,1,3],[2,4,7,8,3,1,6,5,9]]
1426	[[7,2,8,6,1,5,4,3,9],[5,3,4,8,9,7,2,1,6],[1,9,6,2,3,4,7,5,8],[8,4,9,3,5,2,1,6,7],[3,1,2,7,6,9,5,8,4],[6,7,5,4,8,1,3,9,2],[2,8,1,5,7,6,9,4,3],[9,6,7,1,4,3,8,2,5],[4,5,3,9,2,8,6,7,1]]
1427	[[7,5,8,2,9,4,1,6,3],[9,6,3,5,1,8,4,7,2],[4,1,2,3,6,7,9,8,5],[8,2,6,9,4,5,7,3,1],[3,9,5,6,7,1,2,4,8],[1,4,7,8,2,3,5,9,6],[6,3,9,4,5,2,8,1,7],[5,7,4,1,8,6,3,2,9],[2,8,1,7,3,9,6,5,4]]
1428	[[2,9,5,7,8,1,4,6,3],[7,6,4,3,9,2,1,8,5],[1,8,3,6,5,4,9,7,2],[3,7,9,4,2,5,8,1,6],[6,5,8,9,1,3,2,4,7],[4,2,1,8,7,6,3,5,9],[5,4,2,1,3,7,6,9,8],[9,3,6,5,4,8,7,2,1],[8,1,7,2,6,9,5,3,4]]
1429	[[2,4,8,1,5,7,6,3,9],[6,7,3,2,9,4,5,8,1],[5,9,1,8,3,6,4,7,2],[3,2,9,4,7,1,8,5,6],[7,1,5,9,6,8,3,2,4],[8,6,4,3,2,5,1,9,7],[4,5,6,7,8,2,9,1,3],[9,8,2,6,1,3,7,4,5],[1,3,7,5,4,9,2,6,8]]
1430	[[1,4,6,5,9,2,7,3,8],[7,5,3,4,8,6,1,2,9],[8,2,9,3,1,7,5,4,6],[2,9,5,8,3,4,6,1,7],[3,7,8,6,5,1,4,9,2],[6,1,4,2,7,9,3,8,5],[5,3,1,9,6,8,2,7,4],[4,8,7,1,2,5,9,6,3],[9,6,2,7,4,3,8,5,1]]
1431	[[9,7,4,3,2,1,5,8,6],[2,8,5,4,9,6,1,3,7],[1,6,3,8,5,7,2,4,9],[7,5,2,6,8,3,4,9,1],[4,9,8,7,1,2,6,5,3],[6,3,1,5,4,9,8,7,2],[3,4,9,1,6,5,7,2,8],[8,1,7,2,3,4,9,6,5],[5,2,6,9,7,8,3,1,4]]
1432	[[5,8,1,6,2,4,9,3,7],[9,3,4,8,7,1,6,2,5],[2,6,7,5,9,3,8,1,4],[1,5,6,4,3,8,2,7,9],[3,7,9,2,6,5,1,4,8],[4,2,8,9,1,7,3,5,6],[8,1,3,7,4,9,5,6,2],[7,9,2,1,5,6,4,8,3],[6,4,5,3,8,2,7,9,1]]
1433	[[7,5,4,8,9,2,1,6,3],[3,1,2,7,5,6,4,9,8],[9,8,6,4,3,1,7,5,2],[4,2,8,5,1,9,6,3,7],[5,3,1,6,7,8,9,2,4],[6,7,9,2,4,3,5,8,1],[8,4,3,9,6,7,2,1,5],[1,9,7,3,2,5,8,4,6],[2,6,5,1,8,4,3,7,9]]
1434	[[5,4,7,1,2,6,3,8,9],[6,2,8,9,3,5,4,1,7],[9,1,3,4,8,7,2,6,5],[8,6,4,5,9,3,7,2,1],[7,3,5,2,6,1,8,9,4],[1,9,2,8,7,4,5,3,6],[2,7,1,3,4,9,6,5,8],[3,5,6,7,1,8,9,4,2],[4,8,9,6,5,2,1,7,3]]
1435	[[4,7,9,3,2,5,1,8,6],[8,3,5,6,1,4,9,2,7],[6,2,1,9,7,8,4,3,5],[2,4,6,7,8,3,5,1,9],[5,9,8,2,6,1,3,7,4],[3,1,7,5,4,9,2,6,8],[9,5,2,8,3,7,6,4,1],[7,6,4,1,9,2,8,5,3],[1,8,3,4,5,6,7,9,2]]
1436	[[4,1,3,8,6,2,5,9,7],[9,5,6,3,7,1,4,8,2],[8,2,7,5,9,4,6,3,1],[7,8,2,4,3,6,9,1,5],[6,3,9,1,5,8,2,7,4],[1,4,5,9,2,7,3,6,8],[2,6,1,7,4,9,8,5,3],[3,9,8,2,1,5,7,4,6],[5,7,4,6,8,3,1,2,9]]
1437	[[6,8,9,4,3,1,5,2,7],[7,1,2,8,5,9,4,3,6],[3,5,4,2,7,6,1,8,9],[2,9,8,1,6,7,3,5,4],[5,7,1,3,4,8,6,9,2],[4,3,6,9,2,5,8,7,1],[9,2,3,6,8,4,7,1,5],[8,6,7,5,1,2,9,4,3],[1,4,5,7,9,3,2,6,8]]
1438	[[6,8,7,9,1,3,4,5,2],[5,2,9,7,4,6,1,8,3],[1,3,4,2,8,5,7,6,9],[7,9,2,4,6,8,3,1,5],[3,6,1,5,9,7,8,2,4],[8,4,5,3,2,1,6,9,7],[4,5,8,1,7,9,2,3,6],[2,1,3,6,5,4,9,7,8],[9,7,6,8,3,2,5,4,1]]
1439	[[3,8,7,9,1,2,4,6,5],[6,9,5,3,7,4,2,8,1],[4,1,2,8,6,5,9,7,3],[5,3,9,1,4,7,6,2,8],[7,6,4,2,5,8,1,3,9],[8,2,1,6,3,9,5,4,7],[1,5,3,7,2,6,8,9,4],[9,7,6,4,8,1,3,5,2],[2,4,8,5,9,3,7,1,6]]
1440	[[4,1,6,5,7,2,8,9,3],[9,7,5,1,3,8,4,6,2],[3,8,2,9,6,4,5,7,1],[6,4,8,2,9,3,7,1,5],[5,9,3,7,8,1,2,4,6],[7,2,1,4,5,6,3,8,9],[1,5,9,3,4,7,6,2,8],[2,6,4,8,1,5,9,3,7],[8,3,7,6,2,9,1,5,4]]
1441	[[5,3,6,9,8,4,1,7,2],[2,1,9,7,5,3,4,8,6],[4,7,8,2,6,1,5,3,9],[3,8,4,6,7,5,9,2,1],[6,2,7,8,1,9,3,5,4],[1,9,5,3,4,2,8,6,7],[8,6,1,5,9,7,2,4,3],[7,4,3,1,2,8,6,9,5],[9,5,2,4,3,6,7,1,8]]
1442	[[3,8,4,5,7,9,1,6,2],[6,5,2,3,8,1,7,9,4],[1,9,7,4,6,2,8,5,3],[2,7,9,6,1,4,5,3,8],[8,6,5,7,9,3,2,4,1],[4,3,1,2,5,8,6,7,9],[5,1,3,8,4,6,9,2,7],[7,2,8,9,3,5,4,1,6],[9,4,6,1,2,7,3,8,5]]
1443	[[6,1,3,2,9,5,4,7,8],[9,2,5,4,7,8,3,6,1],[8,4,7,1,6,3,5,2,9],[1,8,2,3,5,7,9,4,6],[4,5,6,9,8,1,2,3,7],[3,7,9,6,4,2,1,8,5],[7,6,1,5,3,4,8,9,2],[5,3,8,7,2,9,6,1,4],[2,9,4,8,1,6,7,5,3]]
1444	[[3,1,8,6,2,7,9,5,4],[5,6,7,8,4,9,3,1,2],[9,2,4,1,3,5,8,7,6],[7,4,3,2,8,1,5,6,9],[1,8,2,5,9,6,7,4,3],[6,5,9,3,7,4,1,2,8],[4,9,5,7,6,3,2,8,1],[2,7,6,9,1,8,4,3,5],[8,3,1,4,5,2,6,9,7]]
1445	[[6,2,1,4,8,5,3,7,9],[3,9,5,2,1,7,4,6,8],[4,7,8,6,9,3,2,1,5],[1,5,4,3,2,8,7,9,6],[8,6,2,9,7,1,5,3,4],[9,3,7,5,4,6,8,2,1],[2,4,6,8,3,9,1,5,7],[5,1,3,7,6,4,9,8,2],[7,8,9,1,5,2,6,4,3]]
1446	[[1,3,2,8,7,5,4,9,6],[6,5,9,4,2,3,7,1,8],[7,8,4,1,6,9,5,3,2],[3,4,8,2,1,6,9,7,5],[2,9,1,5,4,7,8,6,3],[5,6,7,3,9,8,1,2,4],[8,7,5,6,3,1,2,4,9],[4,1,3,9,5,2,6,8,7],[9,2,6,7,8,4,3,5,1]]
1447	[[1,8,3,5,6,9,7,2,4],[5,4,6,8,2,7,3,9,1],[9,7,2,3,1,4,6,8,5],[3,1,8,2,5,6,4,7,9],[6,5,4,7,9,1,2,3,8],[7,2,9,4,8,3,1,5,6],[4,6,7,9,3,5,8,1,2],[2,9,1,6,7,8,5,4,3],[8,3,5,1,4,2,9,6,7]]
1448	[[1,2,9,6,4,7,3,5,8],[4,7,5,9,8,3,1,2,6],[6,3,8,2,1,5,7,9,4],[7,8,6,3,2,1,9,4,5],[5,4,1,8,6,9,2,7,3],[3,9,2,5,7,4,6,8,1],[8,6,4,1,9,2,5,3,7],[2,1,3,7,5,8,4,6,9],[9,5,7,4,3,6,8,1,2]]
1449	[[8,1,6,9,4,3,5,7,2],[7,3,2,5,1,8,6,9,4],[4,5,9,2,6,7,1,3,8],[1,6,7,4,3,5,2,8,9],[5,2,3,6,8,9,7,4,1],[9,4,8,1,7,2,3,5,6],[6,9,1,3,5,4,8,2,7],[2,8,5,7,9,1,4,6,3],[3,7,4,8,2,6,9,1,5]]
1450	[[2,4,8,3,6,5,7,9,1],[5,1,7,4,8,9,3,2,6],[3,6,9,7,1,2,5,8,4],[7,2,1,9,3,6,8,4,5],[4,5,3,8,2,1,9,6,7],[8,9,6,5,4,7,1,3,2],[9,7,4,6,5,3,2,1,8],[6,3,2,1,7,8,4,5,9],[1,8,5,2,9,4,6,7,3]]
1451	[[7,5,1,9,4,2,3,8,6],[6,3,2,7,8,1,9,4,5],[8,4,9,6,5,3,1,7,2],[1,2,6,4,9,8,7,5,3],[9,8,4,3,7,5,6,2,1],[5,7,3,2,1,6,8,9,4],[2,1,7,5,3,9,4,6,8],[4,6,8,1,2,7,5,3,9],[3,9,5,8,6,4,2,1,7]]
1452	[[2,6,8,3,4,5,7,1,9],[5,9,7,1,6,8,3,2,4],[1,3,4,2,9,7,6,5,8],[6,8,2,9,5,1,4,3,7],[3,4,1,8,7,6,2,9,5],[7,5,9,4,2,3,8,6,1],[4,1,3,5,8,2,9,7,6],[8,7,5,6,3,9,1,4,2],[9,2,6,7,1,4,5,8,3]]
1453	[[7,4,6,3,2,8,5,9,1],[5,8,2,1,9,6,7,4,3],[1,3,9,7,5,4,6,2,8],[3,5,7,4,1,9,8,6,2],[6,9,8,5,7,2,3,1,4],[2,1,4,8,6,3,9,5,7],[8,2,3,9,4,5,1,7,6],[4,7,5,6,3,1,2,8,9],[9,6,1,2,8,7,4,3,5]]
1454	[[2,7,9,6,8,1,3,4,5],[4,5,8,2,9,3,1,6,7],[3,6,1,5,4,7,9,2,8],[1,3,7,4,5,6,2,8,9],[8,9,5,7,3,2,6,1,4],[6,4,2,8,1,9,7,5,3],[9,8,3,1,6,5,4,7,2],[7,1,4,3,2,8,5,9,6],[5,2,6,9,7,4,8,3,1]]
1455	[[8,3,5,9,4,6,2,1,7],[6,2,1,8,3,7,5,4,9],[4,7,9,2,1,5,8,3,6],[2,1,4,3,7,8,9,6,5],[7,9,3,6,5,2,1,8,4],[5,8,6,1,9,4,7,2,3],[1,4,7,5,2,3,6,9,8],[3,6,2,7,8,9,4,5,1],[9,5,8,4,6,1,3,7,2]]
1456	[[8,7,6,3,1,5,2,4,9],[3,1,2,6,9,4,8,7,5],[9,5,4,8,7,2,1,3,6],[5,2,3,4,8,7,9,6,1],[4,9,7,1,5,6,3,2,8],[1,6,8,2,3,9,7,5,4],[7,3,9,5,6,8,4,1,2],[2,8,5,7,4,1,6,9,3],[6,4,1,9,2,3,5,8,7]]
1457	[[5,1,3,9,2,4,8,7,6],[2,6,8,7,5,1,3,4,9],[4,7,9,3,8,6,2,5,1],[7,3,5,6,4,2,1,9,8],[8,9,4,1,3,7,5,6,2],[1,2,6,5,9,8,4,3,7],[6,8,7,4,1,5,9,2,3],[9,5,1,2,6,3,7,8,4],[3,4,2,8,7,9,6,1,5]]
1458	[[1,6,7,4,5,3,2,9,8],[4,8,3,6,2,9,7,5,1],[5,2,9,1,8,7,3,6,4],[2,9,8,5,6,1,4,3,7],[7,1,6,3,9,4,8,2,5],[3,4,5,2,7,8,9,1,6],[6,7,4,9,3,5,1,8,2],[8,3,2,7,1,6,5,4,9],[9,5,1,8,4,2,6,7,3]]
1459	[[8,6,5,3,9,7,1,4,2],[1,7,2,8,6,4,3,5,9],[9,4,3,5,2,1,7,8,6],[7,3,8,9,5,6,2,1,4],[4,1,6,7,8,2,5,9,3],[5,2,9,4,1,3,8,6,7],[3,8,7,1,4,9,6,2,5],[6,9,1,2,7,5,4,3,8],[2,5,4,6,3,8,9,7,1]]
1460	[[6,1,4,5,7,3,8,9,2],[7,5,2,1,9,8,4,6,3],[3,9,8,6,4,2,7,5,1],[8,4,1,2,5,9,3,7,6],[5,7,9,3,6,1,2,4,8],[2,3,6,4,8,7,5,1,9],[9,6,5,8,2,4,1,3,7],[4,8,3,7,1,6,9,2,5],[1,2,7,9,3,5,6,8,4]]
1461	[[6,5,7,1,2,8,3,9,4],[3,1,8,4,6,9,5,2,7],[9,2,4,3,5,7,6,1,8],[1,3,6,5,9,4,7,8,2],[8,7,5,2,1,6,4,3,9],[2,4,9,8,7,3,1,5,6],[4,6,3,9,8,5,2,7,1],[5,8,1,7,4,2,9,6,3],[7,9,2,6,3,1,8,4,5]]
1462	[[8,3,1,7,9,5,2,4,6],[5,2,6,8,3,4,7,1,9],[9,4,7,2,6,1,8,5,3],[7,9,4,3,2,8,5,6,1],[1,6,8,4,5,7,9,3,2],[2,5,3,9,1,6,4,8,7],[6,8,2,1,4,9,3,7,5],[4,1,9,5,7,3,6,2,8],[3,7,5,6,8,2,1,9,4]]
1463	[[1,6,3,9,7,5,2,4,8],[4,8,2,6,3,1,7,5,9],[7,5,9,8,4,2,1,3,6],[8,4,1,5,6,7,3,9,2],[6,9,7,1,2,3,4,8,5],[2,3,5,4,8,9,6,1,7],[9,2,4,7,1,8,5,6,3],[5,7,6,3,9,4,8,2,1],[3,1,8,2,5,6,9,7,4]]
1464	[[6,1,8,4,5,2,9,7,3],[5,7,4,9,3,1,6,2,8],[3,2,9,8,6,7,4,5,1],[8,4,3,6,2,5,1,9,7],[9,6,2,1,7,8,5,3,4],[7,5,1,3,9,4,8,6,2],[1,3,5,7,8,9,2,4,6],[2,8,7,5,4,6,3,1,9],[4,9,6,2,1,3,7,8,5]]
1465	[[2,7,5,6,3,8,1,9,4],[3,1,4,2,5,9,8,6,7],[8,9,6,4,7,1,2,3,5],[6,2,9,7,4,3,5,1,8],[1,8,3,5,9,2,7,4,6],[4,5,7,8,1,6,3,2,9],[5,3,2,9,6,7,4,8,1],[9,4,1,3,8,5,6,7,2],[7,6,8,1,2,4,9,5,3]]
1466	[[5,1,3,9,6,4,8,7,2],[9,6,8,5,7,2,3,4,1],[2,4,7,8,1,3,5,9,6],[6,9,1,3,8,5,4,2,7],[3,7,4,2,9,6,1,5,8],[8,2,5,7,4,1,6,3,9],[4,3,9,6,2,8,7,1,5],[7,5,6,1,3,9,2,8,4],[1,8,2,4,5,7,9,6,3]]
1467	[[6,3,1,8,2,4,9,5,7],[8,5,7,1,9,3,6,2,4],[2,4,9,5,6,7,8,3,1],[3,9,6,7,8,2,1,4,5],[5,1,2,3,4,9,7,6,8],[7,8,4,6,1,5,3,9,2],[1,2,5,9,3,8,4,7,6],[4,6,3,2,7,1,5,8,9],[9,7,8,4,5,6,2,1,3]]
1468	[[8,3,6,5,9,2,4,7,1],[7,9,1,3,4,6,8,5,2],[5,2,4,7,8,1,9,3,6],[3,8,2,1,6,5,7,4,9],[6,1,9,4,7,8,3,2,5],[4,7,5,2,3,9,1,6,8],[9,5,3,6,1,4,2,8,7],[1,6,7,8,2,3,5,9,4],[2,4,8,9,5,7,6,1,3]]
1469	[[2,1,3,6,8,9,7,5,4],[5,6,8,1,4,7,3,9,2],[9,4,7,2,3,5,8,1,6],[8,9,4,3,1,6,5,2,7],[1,5,6,7,9,2,4,3,8],[7,3,2,4,5,8,1,6,9],[6,8,9,5,7,1,2,4,3],[3,7,1,9,2,4,6,8,5],[4,2,5,8,6,3,9,7,1]]
1470	[[3,8,9,5,1,7,6,4,2],[2,4,7,3,8,6,1,9,5],[5,6,1,9,4,2,8,7,3],[7,9,8,6,3,5,2,1,4],[1,5,2,4,9,8,3,6,7],[4,3,6,2,7,1,5,8,9],[9,1,4,8,5,3,7,2,6],[6,7,3,1,2,9,4,5,8],[8,2,5,7,6,4,9,3,1]]
1471	[[8,5,1,2,7,6,3,4,9],[3,4,9,5,1,8,7,6,2],[2,7,6,9,4,3,1,8,5],[5,6,7,8,3,1,9,2,4],[4,3,2,7,5,9,6,1,8],[9,1,8,4,6,2,5,3,7],[7,8,3,1,9,4,2,5,6],[1,2,5,6,8,7,4,9,3],[6,9,4,3,2,5,8,7,1]]
1472	[[7,2,3,5,6,1,4,9,8],[9,1,4,8,2,3,5,7,6],[5,6,8,9,4,7,1,3,2],[3,5,2,6,9,4,7,8,1],[4,7,1,3,8,5,6,2,9],[6,8,9,1,7,2,3,5,4],[2,3,6,7,1,9,8,4,5],[8,4,5,2,3,6,9,1,7],[1,9,7,4,5,8,2,6,3]]
1473	[[2,9,3,7,4,1,6,8,5],[4,1,6,2,5,8,3,7,9],[7,8,5,9,3,6,4,2,1],[1,4,7,8,6,9,2,5,3],[3,2,9,4,7,5,8,1,6],[5,6,8,1,2,3,9,4,7],[6,7,4,5,9,2,1,3,8],[9,5,1,3,8,4,7,6,2],[8,3,2,6,1,7,5,9,4]]
1474	[[7,8,1,9,6,2,5,4,3],[9,5,2,4,8,3,1,6,7],[4,6,3,7,1,5,9,8,2],[5,9,6,1,3,8,2,7,4],[3,2,7,6,4,9,8,5,1],[1,4,8,2,5,7,6,3,9],[8,3,9,5,2,4,7,1,6],[6,7,5,3,9,1,4,2,8],[2,1,4,8,7,6,3,9,5]]
1475	[[6,1,4,3,2,5,8,9,7],[2,9,3,8,7,4,1,5,6],[5,8,7,1,6,9,3,2,4],[3,6,5,7,9,2,4,8,1],[1,7,8,4,5,3,9,6,2],[4,2,9,6,1,8,7,3,5],[9,4,1,2,3,6,5,7,8],[8,3,6,5,4,7,2,1,9],[7,5,2,9,8,1,6,4,3]]
1476	[[1,9,7,2,4,3,8,6,5],[8,6,2,9,7,5,3,4,1],[5,4,3,6,8,1,9,2,7],[3,1,6,8,5,2,7,9,4],[7,5,4,3,9,6,1,8,2],[2,8,9,4,1,7,5,3,6],[6,7,8,1,3,4,2,5,9],[4,3,1,5,2,9,6,7,8],[9,2,5,7,6,8,4,1,3]]
1477	[[1,8,6,5,2,3,4,7,9],[2,5,4,1,9,7,3,8,6],[9,7,3,4,6,8,2,1,5],[4,1,9,8,3,2,5,6,7],[8,2,7,6,5,9,1,4,3],[3,6,5,7,1,4,8,9,2],[7,3,8,9,4,5,6,2,1],[5,4,1,2,7,6,9,3,8],[6,9,2,3,8,1,7,5,4]]
1478	[[4,9,7,3,6,5,8,1,2],[8,1,5,7,2,9,4,3,6],[2,3,6,1,8,4,9,5,7],[7,6,4,5,3,2,1,9,8],[1,2,8,9,4,6,5,7,3],[9,5,3,8,1,7,2,6,4],[5,4,9,2,7,3,6,8,1],[3,8,2,6,9,1,7,4,5],[6,7,1,4,5,8,3,2,9]]
1479	[[6,8,9,3,4,5,1,7,2],[1,3,7,8,2,9,5,6,4],[4,2,5,7,1,6,8,9,3],[2,1,3,9,6,7,4,5,8],[5,4,6,2,3,8,9,1,7],[7,9,8,1,5,4,2,3,6],[8,6,2,5,7,1,3,4,9],[3,7,1,4,9,2,6,8,5],[9,5,4,6,8,3,7,2,1]]
1480	[[1,3,7,9,2,5,6,4,8],[4,5,8,7,1,6,9,2,3],[2,6,9,4,3,8,5,1,7],[7,4,2,8,9,3,1,6,5],[3,8,1,6,5,4,2,7,9],[6,9,5,1,7,2,3,8,4],[5,7,3,2,4,1,8,9,6],[8,1,4,3,6,9,7,5,2],[9,2,6,5,8,7,4,3,1]]
1481	[[8,2,7,3,5,9,1,6,4],[1,9,4,2,8,6,3,5,7],[3,6,5,1,7,4,2,9,8],[5,3,9,7,6,2,8,4,1],[6,1,2,8,4,5,7,3,9],[7,4,8,9,3,1,5,2,6],[2,8,3,6,9,7,4,1,5],[9,5,1,4,2,8,6,7,3],[4,7,6,5,1,3,9,8,2]]
1482	[[6,4,3,2,9,8,5,7,1],[1,9,2,5,4,7,8,6,3],[5,8,7,3,6,1,4,2,9],[2,6,1,8,5,9,7,3,4],[9,7,5,6,3,4,2,1,8],[8,3,4,1,7,2,6,9,5],[4,2,9,7,1,5,3,8,6],[3,5,8,9,2,6,1,4,7],[7,1,6,4,8,3,9,5,2]]
1483	[[2,3,7,4,1,5,8,9,6],[1,4,8,3,9,6,2,5,7],[5,9,6,7,8,2,4,1,3],[7,6,2,5,3,1,9,8,4],[4,8,1,2,6,9,3,7,5],[9,5,3,8,7,4,6,2,1],[3,2,4,1,5,8,7,6,9],[6,7,5,9,2,3,1,4,8],[8,1,9,6,4,7,5,3,2]]
1484	[[5,2,4,7,9,1,6,3,8],[7,8,1,2,6,3,9,4,5],[6,3,9,5,4,8,2,7,1],[2,4,5,8,1,9,7,6,3],[3,7,8,4,2,6,1,5,9],[1,9,6,3,5,7,8,2,4],[4,5,7,1,8,2,3,9,6],[9,1,2,6,3,4,5,8,7],[8,6,3,9,7,5,4,1,2]]
1485	[[3,2,6,8,7,5,4,1,9],[8,7,9,4,1,2,6,5,3],[5,1,4,9,3,6,2,7,8],[7,8,3,1,6,9,5,4,2],[2,9,1,5,8,4,3,6,7],[6,4,5,7,2,3,9,8,1],[4,6,8,3,9,1,7,2,5],[1,3,2,6,5,7,8,9,4],[9,5,7,2,4,8,1,3,6]]
1486	[[8,1,2,3,4,5,6,7,9],[5,6,9,1,2,7,3,4,8],[7,4,3,6,9,8,5,2,1],[6,2,4,8,7,3,1,9,5],[9,5,8,4,1,6,2,3,7],[3,7,1,2,5,9,4,8,6],[2,9,5,7,3,1,8,6,4],[4,8,7,5,6,2,9,1,3],[1,3,6,9,8,4,7,5,2]]
1487	[[9,4,6,7,5,3,2,8,1],[2,3,1,8,4,6,5,9,7],[7,8,5,1,9,2,4,3,6],[8,2,3,9,1,5,7,6,4],[6,9,4,3,2,7,1,5,8],[1,5,7,4,6,8,9,2,3],[5,1,8,2,3,4,6,7,9],[3,6,9,5,7,1,8,4,2],[4,7,2,6,8,9,3,1,5]]
1488	[[7,9,3,6,2,4,8,1,5],[5,1,4,7,9,8,3,6,2],[8,2,6,5,3,1,9,4,7],[4,6,5,3,1,7,2,8,9],[1,3,8,9,5,2,4,7,6],[2,7,9,8,4,6,1,5,3],[9,4,1,2,6,5,7,3,8],[6,8,2,1,7,3,5,9,4],[3,5,7,4,8,9,6,2,1]]
1489	[[4,2,3,9,5,1,8,6,7],[7,8,5,6,4,2,1,9,3],[9,6,1,7,8,3,4,5,2],[2,5,4,3,7,8,9,1,6],[6,9,7,1,2,5,3,4,8],[3,1,8,4,9,6,7,2,5],[8,3,9,5,6,4,2,7,1],[5,7,2,8,1,9,6,3,4],[1,4,6,2,3,7,5,8,9]]
1490	[[9,7,4,2,3,6,1,5,8],[3,8,1,5,4,9,7,2,6],[2,6,5,7,8,1,3,4,9],[5,3,9,1,7,8,2,6,4],[7,4,8,6,2,3,9,1,5],[1,2,6,4,9,5,8,7,3],[4,1,3,8,5,2,6,9,7],[6,9,7,3,1,4,5,8,2],[8,5,2,9,6,7,4,3,1]]
1491	[[3,4,8,9,5,1,7,2,6],[6,9,7,3,2,8,1,4,5],[2,5,1,6,4,7,3,9,8],[9,3,2,4,8,6,5,1,7],[5,7,6,2,1,9,8,3,4],[1,8,4,5,7,3,2,6,9],[4,1,3,7,6,5,9,8,2],[8,2,5,1,9,4,6,7,3],[7,6,9,8,3,2,4,5,1]]
1492	[[4,9,5,6,3,7,2,8,1],[1,8,2,9,5,4,6,7,3],[6,3,7,2,8,1,9,5,4],[5,1,4,8,9,2,7,3,6],[9,2,6,3,7,5,4,1,8],[8,7,3,1,4,6,5,2,9],[3,5,9,4,2,8,1,6,7],[7,4,1,5,6,3,8,9,2],[2,6,8,7,1,9,3,4,5]]
1493	[[2,5,4,1,8,6,3,7,9],[9,7,3,2,4,5,8,6,1],[1,8,6,9,7,3,2,4,5],[8,4,9,3,5,7,1,2,6],[5,2,1,6,9,8,7,3,4],[6,3,7,4,2,1,9,5,8],[7,9,5,8,3,4,6,1,2],[3,1,2,5,6,9,4,8,7],[4,6,8,7,1,2,5,9,3]]
1494	[[5,2,7,1,9,8,3,6,4],[6,9,4,7,3,5,8,1,2],[1,3,8,2,4,6,7,9,5],[9,1,6,4,7,2,5,8,3],[3,7,5,6,8,9,4,2,1],[4,8,2,3,5,1,6,7,9],[2,5,1,8,6,3,9,4,7],[7,6,3,9,2,4,1,5,8],[8,4,9,5,1,7,2,3,6]]
1495	[[1,5,4,7,2,8,6,3,9],[8,2,3,9,1,6,7,5,4],[9,7,6,5,4,3,1,2,8],[3,8,1,6,7,4,5,9,2],[6,9,7,3,5,2,8,4,1],[5,4,2,1,8,9,3,7,6],[7,6,9,2,3,1,4,8,5],[2,3,8,4,6,5,9,1,7],[4,1,5,8,9,7,2,6,3]]
1496	[[2,5,3,6,4,7,1,9,8],[9,6,7,1,8,5,4,3,2],[4,8,1,3,9,2,6,7,5],[3,2,8,4,6,1,7,5,9],[5,4,6,2,7,9,8,1,3],[7,1,9,8,5,3,2,4,6],[6,9,4,5,1,8,3,2,7],[1,3,5,7,2,6,9,8,4],[8,7,2,9,3,4,5,6,1]]
1497	[[9,8,2,4,5,1,6,3,7],[3,7,4,6,2,9,8,5,1],[5,1,6,8,7,3,9,4,2],[4,6,3,1,9,5,7,2,8],[8,5,7,2,6,4,3,1,9],[1,2,9,7,3,8,4,6,5],[7,4,1,5,8,6,2,9,3],[6,3,8,9,1,2,5,7,4],[2,9,5,3,4,7,1,8,6]]
1498	[[8,5,9,2,1,4,7,6,3],[2,3,1,5,7,6,8,9,4],[4,7,6,8,3,9,2,1,5],[5,9,4,7,6,1,3,2,8],[6,1,8,3,4,2,5,7,9],[7,2,3,9,5,8,1,4,6],[3,6,5,1,9,7,4,8,2],[1,4,2,6,8,3,9,5,7],[9,8,7,4,2,5,6,3,1]]
1499	[[1,2,8,9,3,6,5,7,4],[9,5,7,4,1,8,3,6,2],[3,6,4,5,7,2,9,8,1],[4,3,6,1,9,5,7,2,8],[5,7,2,6,8,3,4,1,9],[8,9,1,2,4,7,6,5,3],[2,4,9,7,5,1,8,3,6],[6,8,5,3,2,4,1,9,7],[7,1,3,8,6,9,2,4,5]]
1500	[[6,8,4,5,1,7,9,2,3],[7,5,3,4,9,2,8,6,1],[2,1,9,6,3,8,7,4,5],[3,4,5,9,7,1,2,8,6],[1,9,7,8,2,6,5,3,4],[8,6,2,3,4,5,1,7,9],[5,3,6,2,8,9,4,1,7],[4,2,1,7,5,3,6,9,8],[9,7,8,1,6,4,3,5,2]]
1501	[[3,8,4,9,6,1,5,2,7],[2,5,6,3,7,8,4,9,1],[9,1,7,5,4,2,8,6,3],[1,2,5,6,8,9,7,3,4],[7,9,8,4,3,5,2,1,6],[4,6,3,1,2,7,9,5,8],[8,7,1,2,5,3,6,4,9],[5,4,9,7,1,6,3,8,2],[6,3,2,8,9,4,1,7,5]]
1502	[[6,1,7,4,8,2,5,3,9],[2,4,5,3,9,1,8,7,6],[8,3,9,7,6,5,2,1,4],[4,2,6,8,5,7,3,9,1],[3,5,8,9,1,4,7,6,2],[7,9,1,2,3,6,4,8,5],[9,8,2,1,4,3,6,5,7],[5,7,3,6,2,9,1,4,8],[1,6,4,5,7,8,9,2,3]]
1503	[[4,5,1,7,9,3,6,2,8],[7,8,6,4,1,2,9,5,3],[3,9,2,8,6,5,7,4,1],[9,4,3,1,7,6,2,8,5],[6,2,8,5,3,9,1,7,4],[5,1,7,2,8,4,3,6,9],[2,6,5,3,4,1,8,9,7],[1,7,4,9,2,8,5,3,6],[8,3,9,6,5,7,4,1,2]]
1504	[[6,4,7,9,2,1,3,5,8],[5,8,2,6,7,3,9,1,4],[1,9,3,8,4,5,7,6,2],[8,3,9,5,1,7,2,4,6],[7,2,1,4,3,6,5,8,9],[4,5,6,2,9,8,1,7,3],[3,7,4,1,8,2,6,9,5],[9,1,5,3,6,4,8,2,7],[2,6,8,7,5,9,4,3,1]]
1505	[[8,3,4,6,7,5,1,9,2],[9,2,5,8,1,4,6,3,7],[1,7,6,2,9,3,4,8,5],[7,9,8,1,4,2,3,5,6],[5,1,2,9,3,6,7,4,8],[4,6,3,7,5,8,2,1,9],[3,8,9,4,6,7,5,2,1],[6,4,1,5,2,9,8,7,3],[2,5,7,3,8,1,9,6,4]]
1506	[[4,3,8,1,5,2,7,9,6],[9,7,2,8,4,6,1,5,3],[1,6,5,9,7,3,4,8,2],[2,9,6,5,1,8,3,4,7],[7,4,3,6,2,9,8,1,5],[5,8,1,7,3,4,6,2,9],[6,5,9,3,8,1,2,7,4],[8,2,7,4,6,5,9,3,1],[3,1,4,2,9,7,5,6,8]]
1507	[[9,3,7,5,6,2,1,4,8],[2,1,4,3,7,8,5,6,9],[6,8,5,1,4,9,2,3,7],[8,2,3,4,1,7,6,9,5],[4,9,1,6,8,5,3,7,2],[7,5,6,9,2,3,4,8,1],[5,7,8,2,3,4,9,1,6],[1,4,9,7,5,6,8,2,3],[3,6,2,8,9,1,7,5,4]]
1508	[[2,9,6,3,7,1,8,5,4],[3,8,5,2,6,4,1,7,9],[4,7,1,8,5,9,6,3,2],[8,4,2,5,9,6,7,1,3],[6,1,3,7,4,2,5,9,8],[9,5,7,1,8,3,2,4,6],[5,2,4,9,1,8,3,6,7],[1,6,8,4,3,7,9,2,5],[7,3,9,6,2,5,4,8,1]]
1509	[[1,8,3,9,2,7,5,4,6],[2,6,5,8,4,3,1,7,9],[4,9,7,1,6,5,3,2,8],[8,5,9,2,3,6,7,1,4],[3,1,4,7,5,9,8,6,2],[7,2,6,4,8,1,9,3,5],[9,4,2,3,1,8,6,5,7],[6,3,8,5,7,2,4,9,1],[5,7,1,6,9,4,2,8,3]]
1510	[[3,8,6,7,1,2,5,4,9],[5,1,7,3,9,4,2,8,6],[2,9,4,5,8,6,3,7,1],[8,6,3,9,5,7,1,2,4],[1,5,2,4,6,3,8,9,7],[4,7,9,1,2,8,6,5,3],[9,3,5,8,4,1,7,6,2],[6,4,1,2,7,5,9,3,8],[7,2,8,6,3,9,4,1,5]]
1511	[[7,5,1,8,2,9,4,3,6],[3,8,4,5,7,6,2,9,1],[2,6,9,1,4,3,7,5,8],[4,7,2,9,1,8,3,6,5],[6,9,3,4,5,7,8,1,2],[5,1,8,3,6,2,9,7,4],[1,3,7,2,8,5,6,4,9],[9,2,5,6,3,4,1,8,7],[8,4,6,7,9,1,5,2,3]]
1512	[[3,5,8,1,9,4,6,2,7],[9,2,4,3,7,6,5,1,8],[7,1,6,2,5,8,4,9,3],[1,8,7,6,2,9,3,4,5],[5,4,9,8,3,1,2,7,6],[6,3,2,7,4,5,1,8,9],[8,6,3,4,1,7,9,5,2],[4,7,5,9,6,2,8,3,1],[2,9,1,5,8,3,7,6,4]]
1513	[[1,5,9,7,3,8,2,4,6],[6,2,7,1,5,4,3,8,9],[4,3,8,2,9,6,5,7,1],[7,9,5,3,8,1,4,6,2],[3,1,2,6,4,9,7,5,8],[8,6,4,5,7,2,9,1,3],[2,7,1,4,6,3,8,9,5],[5,8,3,9,1,7,6,2,4],[9,4,6,8,2,5,1,3,7]]
1514	[[1,7,5,4,8,2,3,9,6],[2,9,8,1,6,3,4,5,7],[6,3,4,7,9,5,2,8,1],[7,5,9,2,3,8,6,1,4],[8,2,1,6,4,7,5,3,9],[3,4,6,5,1,9,8,7,2],[5,1,3,9,2,6,7,4,8],[9,8,2,3,7,4,1,6,5],[4,6,7,8,5,1,9,2,3]]
1515	[[1,5,2,4,7,8,9,3,6],[3,9,8,5,1,6,4,2,7],[4,7,6,9,3,2,1,8,5],[9,4,3,2,5,7,8,6,1],[8,2,7,3,6,1,5,4,9],[6,1,5,8,9,4,2,7,3],[2,3,1,6,8,9,7,5,4],[7,6,4,1,2,5,3,9,8],[5,8,9,7,4,3,6,1,2]]
1516	[[4,6,8,9,5,3,7,1,2],[2,3,5,1,7,6,8,9,4],[7,9,1,4,8,2,6,5,3],[9,1,4,3,2,7,5,8,6],[8,2,3,6,9,5,1,4,7],[6,5,7,8,1,4,2,3,9],[1,7,2,5,3,9,4,6,8],[3,8,6,2,4,1,9,7,5],[5,4,9,7,6,8,3,2,1]]
1517	[[7,3,1,4,2,5,8,6,9],[9,6,4,8,1,7,2,3,5],[8,2,5,3,6,9,7,4,1],[6,5,8,9,3,1,4,2,7],[2,4,9,5,7,8,3,1,6],[3,1,7,6,4,2,5,9,8],[4,7,2,1,5,6,9,8,3],[5,9,6,2,8,3,1,7,4],[1,8,3,7,9,4,6,5,2]]
1518	[[9,5,7,1,4,8,3,6,2],[1,4,6,5,2,3,9,8,7],[3,8,2,9,7,6,5,4,1],[2,3,4,8,9,5,1,7,6],[5,1,9,7,6,4,2,3,8],[6,7,8,2,3,1,4,5,9],[8,2,5,4,1,7,6,9,3],[7,9,3,6,5,2,8,1,4],[4,6,1,3,8,9,7,2,5]]
1519	[[1,3,2,7,5,8,6,4,9],[5,7,9,1,4,6,3,2,8],[4,6,8,3,9,2,7,5,1],[7,1,3,6,2,4,8,9,5],[8,5,4,9,1,3,2,6,7],[9,2,6,8,7,5,4,1,3],[2,8,1,5,6,7,9,3,4],[3,4,5,2,8,9,1,7,6],[6,9,7,4,3,1,5,8,2]]
1520	[[4,6,2,7,1,8,5,9,3],[3,5,1,4,9,6,7,2,8],[8,7,9,3,5,2,6,4,1],[1,9,3,5,6,7,4,8,2],[5,2,4,8,3,9,1,6,7],[7,8,6,2,4,1,3,5,9],[6,3,7,9,2,4,8,1,5],[9,1,5,6,8,3,2,7,4],[2,4,8,1,7,5,9,3,6]]
1521	[[6,1,9,7,4,8,5,2,3],[8,3,2,6,9,5,1,4,7],[7,5,4,1,3,2,6,8,9],[3,4,5,2,1,7,8,9,6],[9,8,7,3,6,4,2,5,1],[1,2,6,8,5,9,7,3,4],[2,9,8,4,7,1,3,6,5],[4,6,1,5,2,3,9,7,8],[5,7,3,9,8,6,4,1,2]]
1522	[[5,4,3,6,1,7,2,9,8],[1,9,6,4,8,2,3,5,7],[8,7,2,5,9,3,4,6,1],[6,5,7,2,4,9,1,8,3],[4,2,8,3,5,1,9,7,6],[3,1,9,7,6,8,5,4,2],[7,6,1,9,3,5,8,2,4],[2,8,5,1,7,4,6,3,9],[9,3,4,8,2,6,7,1,5]]
1523	[[5,9,3,4,2,8,7,6,1],[1,2,6,3,5,7,4,8,9],[7,8,4,1,9,6,2,3,5],[4,7,1,5,8,3,9,2,6],[9,3,8,6,7,2,5,1,4],[6,5,2,9,1,4,3,7,8],[3,1,7,8,4,5,6,9,2],[8,6,5,2,3,9,1,4,7],[2,4,9,7,6,1,8,5,3]]
1524	[[5,6,2,1,7,4,3,8,9],[7,1,9,8,6,3,2,5,4],[3,8,4,5,9,2,7,6,1],[9,4,3,6,5,7,8,1,2],[8,7,1,3,2,9,5,4,6],[2,5,6,4,8,1,9,7,3],[4,2,5,7,3,6,1,9,8],[6,3,8,9,1,5,4,2,7],[1,9,7,2,4,8,6,3,5]]
1525	[[4,7,2,5,1,3,8,6,9],[1,3,6,9,7,8,2,4,5],[8,5,9,6,2,4,7,3,1],[2,1,8,3,4,6,5,9,7],[7,9,4,2,5,1,6,8,3],[3,6,5,7,8,9,4,1,2],[6,2,1,4,3,5,9,7,8],[9,8,7,1,6,2,3,5,4],[5,4,3,8,9,7,1,2,6]]
1526	[[1,2,9,7,6,8,3,4,5],[7,4,3,9,5,1,8,6,2],[6,5,8,4,3,2,1,7,9],[8,9,2,1,4,5,6,3,7],[5,3,1,6,8,7,2,9,4],[4,6,7,3,2,9,5,1,8],[3,8,4,5,7,6,9,2,1],[2,1,6,8,9,4,7,5,3],[9,7,5,2,1,3,4,8,6]]
1527	[[4,2,5,8,3,7,6,1,9],[9,3,6,1,5,2,4,7,8],[8,7,1,6,4,9,3,2,5],[6,8,2,5,1,3,7,9,4],[1,4,9,7,6,8,2,5,3],[7,5,3,2,9,4,8,6,1],[2,1,7,4,8,5,9,3,6],[3,6,4,9,7,1,5,8,2],[5,9,8,3,2,6,1,4,7]]
1528	[[4,9,1,6,3,5,8,2,7],[7,2,3,4,9,8,6,5,1],[6,8,5,2,1,7,4,9,3],[2,1,4,5,6,9,3,7,8],[3,6,9,8,7,2,5,1,4],[8,5,7,3,4,1,2,6,9],[1,3,6,7,5,4,9,8,2],[9,4,2,1,8,6,7,3,5],[5,7,8,9,2,3,1,4,6]]
1529	[[2,1,3,6,4,5,7,8,9],[9,7,8,3,1,2,6,4,5],[5,4,6,8,7,9,2,3,1],[6,5,2,9,3,7,8,1,4],[7,3,1,4,5,8,9,6,2],[4,8,9,2,6,1,5,7,3],[3,6,5,7,9,4,1,2,8],[8,9,7,1,2,3,4,5,6],[1,2,4,5,8,6,3,9,7]]
1530	[[9,4,6,1,7,5,2,8,3],[3,8,1,2,6,4,9,5,7],[7,2,5,9,8,3,1,6,4],[6,9,7,3,5,1,4,2,8],[1,3,4,8,2,6,5,7,9],[8,5,2,7,4,9,3,1,6],[2,1,3,6,9,7,8,4,5],[4,6,8,5,3,2,7,9,1],[5,7,9,4,1,8,6,3,2]]
1531	[[2,5,7,6,4,8,3,9,1],[1,6,3,9,5,2,4,8,7],[8,4,9,1,7,3,2,5,6],[3,2,4,5,1,6,8,7,9],[9,7,5,8,2,4,6,1,3],[6,8,1,3,9,7,5,4,2],[4,3,6,7,8,9,1,2,5],[7,1,2,4,3,5,9,6,8],[5,9,8,2,6,1,7,3,4]]
1532	[[3,5,6,4,8,2,9,1,7],[1,4,8,7,6,9,2,3,5],[7,9,2,5,1,3,8,4,6],[2,7,5,9,3,4,1,6,8],[6,8,9,1,5,7,4,2,3],[4,3,1,6,2,8,5,7,9],[9,2,4,8,7,6,3,5,1],[8,1,7,3,4,5,6,9,2],[5,6,3,2,9,1,7,8,4]]
1533	[[3,4,1,6,5,8,7,2,9],[8,6,9,2,4,7,5,1,3],[5,7,2,1,3,9,4,6,8],[7,9,8,4,6,1,2,3,5],[2,1,5,9,7,3,8,4,6],[6,3,4,8,2,5,1,9,7],[4,8,7,3,1,6,9,5,2],[1,5,3,7,9,2,6,8,4],[9,2,6,5,8,4,3,7,1]]
1534	[[1,4,2,7,5,3,9,8,6],[3,8,9,2,6,1,5,7,4],[7,5,6,8,9,4,1,2,3],[6,1,5,3,4,8,2,9,7],[9,7,4,1,2,6,8,3,5],[8,2,3,5,7,9,4,6,1],[2,6,8,4,3,5,7,1,9],[4,9,7,6,1,2,3,5,8],[5,3,1,9,8,7,6,4,2]]
1535	[[2,8,4,1,3,9,7,6,5],[1,6,9,4,5,7,2,3,8],[3,7,5,6,8,2,1,4,9],[9,4,1,5,6,8,3,7,2],[8,3,2,7,9,1,4,5,6],[7,5,6,2,4,3,9,8,1],[5,9,7,3,1,6,8,2,4],[6,2,8,9,7,4,5,1,3],[4,1,3,8,2,5,6,9,7]]
1536	[[3,6,7,1,9,2,8,5,4],[9,8,4,7,5,6,3,2,1],[1,5,2,3,8,4,6,9,7],[6,9,3,8,2,7,4,1,5],[2,4,1,6,3,5,7,8,9],[8,7,5,9,4,1,2,3,6],[7,1,9,2,6,8,5,4,3],[5,2,6,4,1,3,9,7,8],[4,3,8,5,7,9,1,6,2]]
1537	[[3,6,2,9,4,7,5,1,8],[7,1,9,8,2,5,3,4,6],[5,4,8,3,6,1,7,2,9],[6,5,3,4,7,8,2,9,1],[1,2,7,6,5,9,4,8,3],[9,8,4,1,3,2,6,7,5],[4,7,1,5,9,3,8,6,2],[8,3,6,2,1,4,9,5,7],[2,9,5,7,8,6,1,3,4]]
1538	[[8,4,2,1,6,5,9,3,7],[3,7,1,9,8,2,4,6,5],[9,5,6,7,4,3,2,8,1],[1,9,4,8,5,6,3,7,2],[6,2,5,3,9,7,8,1,4],[7,8,3,4,2,1,6,5,9],[4,3,7,6,1,9,5,2,8],[2,1,9,5,3,8,7,4,6],[5,6,8,2,7,4,1,9,3]]
1539	[[6,7,9,3,4,2,1,8,5],[4,8,5,7,9,1,2,3,6],[1,3,2,5,8,6,4,7,9],[5,9,4,8,1,3,7,6,2],[8,6,1,9,2,7,3,5,4],[3,2,7,6,5,4,8,9,1],[9,1,6,2,3,8,5,4,7],[2,5,3,4,7,9,6,1,8],[7,4,8,1,6,5,9,2,3]]
1540	[[6,5,1,8,3,4,7,2,9],[7,4,3,9,5,2,8,1,6],[2,8,9,1,6,7,3,4,5],[3,7,8,4,9,6,2,5,1],[4,2,5,3,7,1,9,6,8],[9,1,6,2,8,5,4,7,3],[8,6,4,7,1,9,5,3,2],[1,3,2,5,4,8,6,9,7],[5,9,7,6,2,3,1,8,4]]
1541	[[2,6,4,7,9,1,3,8,5],[5,1,8,6,3,2,9,4,7],[3,7,9,5,4,8,6,1,2],[6,4,2,9,1,3,5,7,8],[8,3,1,2,5,7,4,6,9],[9,5,7,8,6,4,2,3,1],[4,8,3,1,2,9,7,5,6],[7,2,5,4,8,6,1,9,3],[1,9,6,3,7,5,8,2,4]]
1542	[[7,8,3,9,4,5,6,2,1],[1,9,2,8,6,3,7,4,5],[5,6,4,2,1,7,8,9,3],[9,2,8,6,3,4,5,1,7],[3,7,1,5,2,9,4,6,8],[4,5,6,1,7,8,2,3,9],[8,1,9,4,5,6,3,7,2],[6,3,5,7,9,2,1,8,4],[2,4,7,3,8,1,9,5,6]]
1543	[[8,9,5,1,2,4,7,6,3],[2,4,6,3,7,5,8,1,9],[1,7,3,9,8,6,2,4,5],[6,2,8,5,3,9,1,7,4],[5,3,4,2,1,7,9,8,6],[7,1,9,4,6,8,5,3,2],[4,6,1,7,5,2,3,9,8],[9,5,7,8,4,3,6,2,1],[3,8,2,6,9,1,4,5,7]]
1544	[[4,2,1,7,5,3,8,9,6],[5,3,8,2,6,9,4,7,1],[7,6,9,8,4,1,2,5,3],[8,9,2,1,7,6,3,4,5],[3,5,4,9,2,8,1,6,7],[6,1,7,4,3,5,9,2,8],[2,7,3,5,1,4,6,8,9],[1,8,5,6,9,2,7,3,4],[9,4,6,3,8,7,5,1,2]]
1545	[[9,8,3,2,1,6,4,5,7],[7,2,1,4,9,5,8,6,3],[4,6,5,3,8,7,2,9,1],[8,1,4,5,3,9,6,7,2],[6,5,7,1,2,8,9,3,4],[2,3,9,6,7,4,5,1,8],[1,9,8,7,6,2,3,4,5],[5,7,6,8,4,3,1,2,9],[3,4,2,9,5,1,7,8,6]]
1546	[[1,2,7,8,4,9,3,6,5],[9,3,8,7,5,6,4,1,2],[5,4,6,2,3,1,7,9,8],[2,6,1,3,8,4,5,7,9],[3,8,5,9,6,7,1,2,4],[7,9,4,1,2,5,6,8,3],[6,7,3,4,9,2,8,5,1],[8,1,2,5,7,3,9,4,6],[4,5,9,6,1,8,2,3,7]]
1547	[[5,4,7,6,9,3,2,8,1],[2,3,6,7,1,8,5,4,9],[8,9,1,4,2,5,3,6,7],[4,2,3,1,5,7,6,9,8],[1,5,8,9,3,6,7,2,4],[7,6,9,2,8,4,1,3,5],[9,7,4,5,6,2,8,1,3],[3,1,2,8,7,9,4,5,6],[6,8,5,3,4,1,9,7,2]]
1548	[[2,1,4,8,7,3,6,5,9],[9,8,6,2,4,5,3,1,7],[5,7,3,9,6,1,8,2,4],[4,2,7,5,9,8,1,3,6],[8,3,1,6,2,4,9,7,5],[6,5,9,3,1,7,2,4,8],[7,9,8,4,3,2,5,6,1],[3,4,5,1,8,6,7,9,2],[1,6,2,7,5,9,4,8,3]]
1549	[[7,9,4,5,2,3,8,1,6],[1,3,6,8,7,9,4,2,5],[5,2,8,1,6,4,9,3,7],[8,6,5,7,3,1,2,9,4],[9,4,7,2,8,5,3,6,1],[2,1,3,9,4,6,5,7,8],[4,8,1,3,9,7,6,5,2],[3,7,2,6,5,8,1,4,9],[6,5,9,4,1,2,7,8,3]]
1550	[[2,5,7,4,1,6,8,9,3],[4,8,6,3,9,2,1,7,5],[1,3,9,7,8,5,2,4,6],[8,7,5,2,3,4,9,6,1],[3,9,4,5,6,1,7,2,8],[6,1,2,8,7,9,3,5,4],[5,4,1,9,2,3,6,8,7],[7,2,3,6,5,8,4,1,9],[9,6,8,1,4,7,5,3,2]]
1551	[[7,3,2,1,6,5,8,4,9],[6,1,5,4,8,9,2,3,7],[9,8,4,3,7,2,1,5,6],[8,5,1,7,9,4,6,2,3],[3,4,9,8,2,6,7,1,5],[2,7,6,5,3,1,4,9,8],[5,2,8,6,4,3,9,7,1],[1,9,7,2,5,8,3,6,4],[4,6,3,9,1,7,5,8,2]]
1552	[[6,7,4,3,8,9,1,5,2],[8,9,3,5,1,2,7,6,4],[2,1,5,6,7,4,8,9,3],[4,5,9,8,3,7,2,1,6],[7,2,1,4,6,5,9,3,8],[3,6,8,2,9,1,4,7,5],[9,8,2,1,5,6,3,4,7],[5,3,7,9,4,8,6,2,1],[1,4,6,7,2,3,5,8,9]]
1553	[[2,1,6,7,3,5,8,4,9],[5,4,9,2,8,1,6,7,3],[7,8,3,4,6,9,1,2,5],[8,3,5,6,2,7,4,9,1],[9,7,4,1,5,8,3,6,2],[1,6,2,9,4,3,5,8,7],[4,5,8,3,9,2,7,1,6],[3,9,7,8,1,6,2,5,4],[6,2,1,5,7,4,9,3,8]]
1554	[[5,9,1,2,3,7,6,8,4],[2,7,6,4,8,5,9,1,3],[8,3,4,9,1,6,5,7,2],[7,4,3,1,5,9,8,2,6],[9,2,8,3,6,4,1,5,7],[1,6,5,8,7,2,4,3,9],[6,1,2,5,9,3,7,4,8],[3,5,9,7,4,8,2,6,1],[4,8,7,6,2,1,3,9,5]]
1555	[[8,9,7,4,1,5,2,3,6],[6,4,3,2,7,9,1,8,5],[2,1,5,6,3,8,4,7,9],[5,8,1,3,2,6,9,4,7],[7,6,9,1,5,4,8,2,3],[3,2,4,8,9,7,6,5,1],[1,3,8,7,6,2,5,9,4],[9,7,2,5,4,1,3,6,8],[4,5,6,9,8,3,7,1,2]]
1556	[[5,6,3,7,1,4,8,2,9],[1,9,8,5,2,6,3,7,4],[7,4,2,3,9,8,1,5,6],[9,7,5,2,4,1,6,3,8],[8,2,4,9,6,3,5,1,7],[6,3,1,8,5,7,4,9,2],[3,5,6,4,7,9,2,8,1],[4,8,9,1,3,2,7,6,5],[2,1,7,6,8,5,9,4,3]]
1557	[[2,6,3,5,9,7,8,1,4],[9,1,7,8,2,4,3,5,6],[5,8,4,1,3,6,9,2,7],[3,2,9,4,1,8,6,7,5],[1,7,8,9,6,5,4,3,2],[4,5,6,2,7,3,1,8,9],[8,3,5,7,4,9,2,6,1],[7,4,1,6,8,2,5,9,3],[6,9,2,3,5,1,7,4,8]]
1558	[[5,1,8,4,3,7,6,2,9],[3,4,9,6,8,2,5,7,1],[6,7,2,1,5,9,4,3,8],[1,6,4,7,2,8,9,5,3],[2,9,5,3,6,4,1,8,7],[8,3,7,9,1,5,2,6,4],[9,8,6,5,4,3,7,1,2],[7,5,3,2,9,1,8,4,6],[4,2,1,8,7,6,3,9,5]]
1559	[[4,1,9,5,3,8,2,6,7],[3,8,2,4,7,6,9,5,1],[5,6,7,1,9,2,8,3,4],[1,7,4,6,8,3,5,2,9],[8,9,6,2,5,1,7,4,3],[2,3,5,9,4,7,6,1,8],[7,5,3,8,2,4,1,9,6],[6,2,8,3,1,9,4,7,5],[9,4,1,7,6,5,3,8,2]]
1560	[[1,4,3,6,9,2,5,7,8],[6,2,5,4,8,7,1,3,9],[7,9,8,3,1,5,6,2,4],[3,1,9,2,4,6,8,5,7],[5,8,2,1,7,9,3,4,6],[4,6,7,5,3,8,9,1,2],[8,7,1,9,5,4,2,6,3],[9,3,6,7,2,1,4,8,5],[2,5,4,8,6,3,7,9,1]]
1561	[[5,7,2,6,3,9,1,8,4],[3,1,4,2,5,8,6,7,9],[8,6,9,4,1,7,2,3,5],[1,4,6,9,7,3,8,5,2],[7,3,5,8,2,1,9,4,6],[2,9,8,5,6,4,3,1,7],[9,2,3,7,8,5,4,6,1],[6,5,1,3,4,2,7,9,8],[4,8,7,1,9,6,5,2,3]]
1562	[[7,2,6,3,4,8,9,5,1],[4,5,3,1,7,9,2,6,8],[8,9,1,6,2,5,3,4,7],[9,8,7,5,3,4,1,2,6],[1,6,4,2,9,7,5,8,3],[5,3,2,8,1,6,7,9,4],[3,4,5,7,8,2,6,1,9],[6,1,9,4,5,3,8,7,2],[2,7,8,9,6,1,4,3,5]]
1563	[[7,6,5,4,9,1,8,3,2],[8,1,9,6,3,2,7,4,5],[2,3,4,5,8,7,1,6,9],[3,4,7,8,1,5,9,2,6],[9,2,1,7,6,3,5,8,4],[6,5,8,9,2,4,3,1,7],[1,9,3,2,7,6,4,5,8],[5,8,6,1,4,9,2,7,3],[4,7,2,3,5,8,6,9,1]]
1564	[[5,7,6,4,9,8,1,3,2],[9,3,1,5,2,7,6,8,4],[2,8,4,6,1,3,7,9,5],[4,9,7,2,3,1,5,6,8],[8,2,5,7,6,9,4,1,3],[6,1,3,8,4,5,9,2,7],[3,6,8,1,7,4,2,5,9],[1,4,9,3,5,2,8,7,6],[7,5,2,9,8,6,3,4,1]]
1565	[[3,8,6,1,2,4,9,7,5],[2,9,5,6,7,8,4,1,3],[4,1,7,3,9,5,6,2,8],[6,5,2,4,1,9,3,8,7],[9,3,8,7,5,2,1,6,4],[7,4,1,8,6,3,2,5,9],[5,7,9,2,4,6,8,3,1],[8,6,4,5,3,1,7,9,2],[1,2,3,9,8,7,5,4,6]]
1566	[[2,9,1,4,7,3,5,8,6],[8,3,6,2,5,1,9,4,7],[4,7,5,6,9,8,2,3,1],[6,8,4,9,1,2,7,5,3],[1,5,7,3,8,4,6,9,2],[3,2,9,7,6,5,8,1,4],[9,4,3,5,2,6,1,7,8],[5,6,8,1,3,7,4,2,9],[7,1,2,8,4,9,3,6,5]]
1567	[[6,4,5,2,7,1,8,3,9],[1,9,3,5,4,8,7,6,2],[7,2,8,9,6,3,1,4,5],[9,5,6,1,3,2,4,8,7],[3,7,2,6,8,4,9,5,1],[4,8,1,7,5,9,3,2,6],[2,3,9,4,1,6,5,7,8],[5,1,4,8,2,7,6,9,3],[8,6,7,3,9,5,2,1,4]]
1568	[[9,3,5,2,8,1,4,6,7],[2,8,6,7,3,4,5,9,1],[7,1,4,5,9,6,8,3,2],[1,2,7,8,4,9,3,5,6],[6,9,8,3,7,5,2,1,4],[4,5,3,1,6,2,7,8,9],[8,7,2,9,1,3,6,4,5],[3,6,9,4,5,7,1,2,8],[5,4,1,6,2,8,9,7,3]]
1569	[[3,2,6,1,8,5,7,9,4],[5,7,1,4,6,9,8,2,3],[8,4,9,3,2,7,5,6,1],[1,6,8,7,3,4,2,5,9],[7,9,3,5,1,2,6,4,8],[2,5,4,8,9,6,3,1,7],[4,8,7,2,5,1,9,3,6],[9,1,2,6,7,3,4,8,5],[6,3,5,9,4,8,1,7,2]]
1570	[[5,8,9,3,1,4,7,2,6],[7,1,2,8,6,9,5,4,3],[4,6,3,7,5,2,9,8,1],[8,3,1,6,4,7,2,9,5],[9,7,5,2,3,8,6,1,4],[6,2,4,5,9,1,8,3,7],[2,5,6,1,8,3,4,7,9],[1,4,7,9,2,5,3,6,8],[3,9,8,4,7,6,1,5,2]]
1571	[[1,5,6,4,7,9,3,2,8],[7,4,9,2,3,8,6,1,5],[3,8,2,1,5,6,9,7,4],[2,6,7,3,9,4,8,5,1],[8,3,1,7,2,5,4,6,9],[5,9,4,6,8,1,7,3,2],[4,7,3,9,1,2,5,8,6],[9,2,5,8,6,3,1,4,7],[6,1,8,5,4,7,2,9,3]]
1572	[[2,3,8,7,5,6,4,9,1],[4,7,6,1,9,8,5,2,3],[5,9,1,4,3,2,8,6,7],[7,2,5,9,8,1,3,4,6],[1,6,3,5,4,7,2,8,9],[8,4,9,2,6,3,7,1,5],[9,5,2,3,1,4,6,7,8],[6,1,7,8,2,5,9,3,4],[3,8,4,6,7,9,1,5,2]]
1573	[[4,5,6,9,3,7,8,2,1],[7,9,8,5,2,1,3,4,6],[2,1,3,6,8,4,9,5,7],[9,3,1,2,6,8,5,7,4],[5,2,4,1,7,3,6,8,9],[8,6,7,4,9,5,1,3,2],[3,8,9,7,1,2,4,6,5],[6,4,2,3,5,9,7,1,8],[1,7,5,8,4,6,2,9,3]]
1574	[[9,5,4,7,6,8,2,3,1],[3,1,2,9,5,4,7,8,6],[7,8,6,1,3,2,4,9,5],[6,3,7,2,4,5,9,1,8],[8,4,9,6,7,1,5,2,3],[5,2,1,3,8,9,6,4,7],[1,6,5,4,2,3,8,7,9],[2,9,8,5,1,7,3,6,4],[4,7,3,8,9,6,1,5,2]]
1575	[[9,3,6,7,4,1,8,2,5],[1,8,5,3,6,2,9,4,7],[2,7,4,8,5,9,3,6,1],[5,9,1,4,2,8,6,7,3],[6,4,3,5,9,7,2,1,8],[7,2,8,1,3,6,5,9,4],[4,1,2,9,8,3,7,5,6],[3,6,7,2,1,5,4,8,9],[8,5,9,6,7,4,1,3,2]]
1576	[[6,8,3,4,9,1,5,2,7],[5,9,7,2,8,6,1,3,4],[2,4,1,3,7,5,9,6,8],[4,5,8,1,3,9,2,7,6],[1,2,6,7,5,4,3,8,9],[7,3,9,6,2,8,4,1,5],[8,1,4,5,6,2,7,9,3],[9,7,2,8,4,3,6,5,1],[3,6,5,9,1,7,8,4,2]]
1577	[[3,2,8,9,1,5,6,4,7],[6,5,1,7,4,8,9,2,3],[4,7,9,2,6,3,8,5,1],[5,8,3,1,7,2,4,9,6],[2,9,7,4,3,6,5,1,8],[1,4,6,5,8,9,3,7,2],[7,3,4,8,9,1,2,6,5],[8,1,2,6,5,4,7,3,9],[9,6,5,3,2,7,1,8,4]]
1578	[[8,6,9,2,7,1,3,5,4],[5,2,1,4,9,3,6,8,7],[7,4,3,5,6,8,1,9,2],[9,3,6,8,1,4,2,7,5],[2,5,4,7,3,6,8,1,9],[1,7,8,9,2,5,4,3,6],[3,9,7,1,4,2,5,6,8],[4,1,5,6,8,7,9,2,3],[6,8,2,3,5,9,7,4,1]]
1579	[[6,3,8,1,5,7,2,4,9],[5,4,1,6,9,2,7,3,8],[2,7,9,3,4,8,6,1,5],[7,9,2,5,8,1,3,6,4],[8,1,6,4,7,3,5,9,2],[3,5,4,2,6,9,1,8,7],[4,2,5,8,1,6,9,7,3],[9,6,3,7,2,4,8,5,1],[1,8,7,9,3,5,4,2,6]]
1580	[[8,2,6,5,1,3,9,4,7],[5,7,3,4,9,2,8,6,1],[4,1,9,7,6,8,3,2,5],[1,4,5,9,7,6,2,8,3],[3,9,8,2,4,1,5,7,6],[2,6,7,3,8,5,1,9,4],[7,5,1,8,2,4,6,3,9],[9,3,2,6,5,7,4,1,8],[6,8,4,1,3,9,7,5,2]]
1581	[[5,4,3,8,2,6,1,7,9],[7,6,2,1,5,9,8,3,4],[8,9,1,7,4,3,5,2,6],[3,2,4,6,7,8,9,5,1],[1,8,6,2,9,5,3,4,7],[9,7,5,4,3,1,2,6,8],[4,5,8,9,6,2,7,1,3],[2,1,7,3,8,4,6,9,5],[6,3,9,5,1,7,4,8,2]]
1582	[[5,7,9,6,3,8,1,4,2],[1,6,2,9,4,5,3,8,7],[8,4,3,1,7,2,5,6,9],[3,9,4,5,8,7,2,1,6],[2,8,6,4,9,1,7,5,3],[7,5,1,3,2,6,4,9,8],[6,1,8,2,5,3,9,7,4],[9,3,7,8,1,4,6,2,5],[4,2,5,7,6,9,8,3,1]]
1583	[[2,6,9,4,7,5,1,8,3],[7,1,3,6,8,2,4,5,9],[4,5,8,1,3,9,2,7,6],[9,4,1,8,2,6,5,3,7],[8,3,2,7,5,1,6,9,4],[5,7,6,9,4,3,8,2,1],[6,2,7,3,1,8,9,4,5],[3,9,5,2,6,4,7,1,8],[1,8,4,5,9,7,3,6,2]]
1584	[[1,4,9,2,3,5,7,8,6],[5,7,3,4,8,6,1,9,2],[6,2,8,9,1,7,4,3,5],[2,6,5,3,4,9,8,1,7],[3,9,1,6,7,8,5,2,4],[7,8,4,5,2,1,3,6,9],[8,1,6,7,5,2,9,4,3],[4,5,2,1,9,3,6,7,8],[9,3,7,8,6,4,2,5,1]]
1585	[[1,3,2,8,9,4,7,6,5],[9,4,7,6,1,5,3,2,8],[5,6,8,2,7,3,9,4,1],[4,5,6,9,2,1,8,7,3],[8,7,1,4,3,6,2,5,9],[2,9,3,5,8,7,4,1,6],[6,2,5,3,4,9,1,8,7],[7,8,9,1,6,2,5,3,4],[3,1,4,7,5,8,6,9,2]]
1586	[[9,1,7,5,4,3,2,6,8],[2,8,3,1,7,6,4,9,5],[6,5,4,8,2,9,7,1,3],[1,6,2,7,8,4,5,3,9],[8,7,9,3,6,5,1,4,2],[3,4,5,2,9,1,8,7,6],[7,3,1,6,5,2,9,8,4],[5,9,6,4,1,8,3,2,7],[4,2,8,9,3,7,6,5,1]]
1587	[[5,8,2,4,3,9,7,1,6],[1,4,6,5,8,7,3,9,2],[7,3,9,2,6,1,4,5,8],[9,5,8,7,2,6,1,4,3],[2,7,1,3,5,4,8,6,9],[3,6,4,1,9,8,2,7,5],[8,2,7,9,1,5,6,3,4],[6,1,5,8,4,3,9,2,7],[4,9,3,6,7,2,5,8,1]]
1588	[[2,7,1,8,4,9,3,6,5],[3,5,8,6,7,1,4,9,2],[6,9,4,5,2,3,8,1,7],[5,4,3,7,9,6,1,2,8],[7,2,6,1,8,4,5,3,9],[1,8,9,3,5,2,7,4,6],[8,1,2,9,3,5,6,7,4],[9,3,5,4,6,7,2,8,1],[4,6,7,2,1,8,9,5,3]]
1589	[[5,9,7,8,2,1,3,6,4],[2,4,3,9,6,5,1,7,8],[8,1,6,3,7,4,2,5,9],[3,6,9,1,8,7,4,2,5],[4,5,2,6,9,3,8,1,7],[1,7,8,4,5,2,9,3,6],[6,3,1,5,4,9,7,8,2],[9,2,5,7,1,8,6,4,3],[7,8,4,2,3,6,5,9,1]]
1590	[[5,9,1,6,3,8,2,4,7],[2,4,8,1,5,7,6,9,3],[3,6,7,9,4,2,1,8,5],[7,8,2,4,1,5,9,3,6],[6,5,4,3,7,9,8,1,2],[9,1,3,8,2,6,7,5,4],[1,3,6,2,8,4,5,7,9],[4,2,5,7,9,1,3,6,8],[8,7,9,5,6,3,4,2,1]]
1591	[[5,8,1,3,6,2,4,7,9],[9,7,6,8,4,1,5,2,3],[2,4,3,5,9,7,1,8,6],[4,6,7,9,3,8,2,1,5],[8,2,5,6,1,4,3,9,7],[3,1,9,7,2,5,6,4,8],[1,3,8,2,7,6,9,5,4],[6,5,4,1,8,9,7,3,2],[7,9,2,4,5,3,8,6,1]]
1592	[[4,3,6,2,8,5,1,7,9],[7,1,2,9,6,4,8,5,3],[9,8,5,3,7,1,4,6,2],[5,6,1,4,9,3,2,8,7],[2,4,8,6,5,7,9,3,1],[3,7,9,8,1,2,6,4,5],[8,5,7,1,2,6,3,9,4],[6,2,4,7,3,9,5,1,8],[1,9,3,5,4,8,7,2,6]]
1593	[[9,1,2,7,6,4,3,8,5],[6,3,8,5,1,2,7,4,9],[7,4,5,9,3,8,6,1,2],[2,6,3,1,4,5,8,9,7],[4,8,1,6,9,7,2,5,3],[5,7,9,2,8,3,4,6,1],[3,5,6,8,7,9,1,2,4],[1,9,4,3,2,6,5,7,8],[8,2,7,4,5,1,9,3,6]]
1594	[[9,7,1,6,2,5,3,4,8],[6,3,4,8,1,7,5,2,9],[8,5,2,9,4,3,1,7,6],[5,2,3,1,7,6,9,8,4],[7,8,9,2,5,4,6,1,3],[4,1,6,3,8,9,7,5,2],[2,9,8,7,6,1,4,3,5],[1,6,5,4,3,2,8,9,7],[3,4,7,5,9,8,2,6,1]]
1595	[[1,9,5,2,4,7,6,3,8],[4,6,3,9,8,5,2,7,1],[2,8,7,3,6,1,9,4,5],[9,2,4,8,1,3,5,6,7],[8,7,6,4,5,2,1,9,3],[5,3,1,6,7,9,8,2,4],[7,4,9,1,2,8,3,5,6],[6,1,2,5,3,4,7,8,9],[3,5,8,7,9,6,4,1,2]]
1596	[[1,9,3,8,4,7,5,2,6],[7,2,8,6,9,5,1,3,4],[6,4,5,2,1,3,8,9,7],[2,8,9,4,5,6,7,1,3],[4,5,1,7,3,2,6,8,9],[3,6,7,9,8,1,2,4,5],[5,3,6,1,2,9,4,7,8],[8,7,2,3,6,4,9,5,1],[9,1,4,5,7,8,3,6,2]]
1597	[[6,3,2,8,5,7,1,4,9],[9,8,4,2,1,3,5,7,6],[5,1,7,6,4,9,3,8,2],[2,6,5,3,9,8,7,1,4],[1,7,9,4,2,5,8,6,3],[8,4,3,7,6,1,2,9,5],[3,2,6,1,8,4,9,5,7],[7,5,1,9,3,6,4,2,8],[4,9,8,5,7,2,6,3,1]]
1598	[[8,1,3,5,7,9,2,6,4],[2,5,9,6,3,4,1,7,8],[4,6,7,8,2,1,9,5,3],[5,2,4,7,1,3,8,9,6],[9,7,8,4,6,5,3,1,2],[6,3,1,9,8,2,5,4,7],[7,4,2,1,9,8,6,3,5],[1,8,6,3,5,7,4,2,9],[3,9,5,2,4,6,7,8,1]]
1599	[[2,7,3,1,5,8,4,6,9],[9,5,8,6,4,2,7,3,1],[1,6,4,7,3,9,8,2,5],[8,4,9,3,2,7,5,1,6],[7,2,6,5,1,4,9,8,3],[5,3,1,8,9,6,2,4,7],[4,8,7,9,6,3,1,5,2],[3,1,2,4,7,5,6,9,8],[6,9,5,2,8,1,3,7,4]]
1600	[[1,6,2,8,5,7,9,4,3],[4,8,7,9,3,1,2,6,5],[9,5,3,4,2,6,8,1,7],[7,4,1,2,9,3,6,5,8],[6,3,8,5,7,4,1,9,2],[5,2,9,6,1,8,7,3,4],[2,1,4,3,8,9,5,7,6],[3,7,5,1,6,2,4,8,9],[8,9,6,7,4,5,3,2,1]]
1601	[[6,1,5,9,4,8,3,7,2],[9,2,3,6,7,5,4,1,8],[7,8,4,3,1,2,5,9,6],[5,4,6,1,8,9,2,3,7],[8,7,1,2,5,3,9,6,4],[3,9,2,7,6,4,1,8,5],[2,6,7,4,9,1,8,5,3],[4,5,9,8,3,6,7,2,1],[1,3,8,5,2,7,6,4,9]]
1602	[[8,9,1,3,5,7,6,4,2],[6,7,2,9,1,4,8,5,3],[4,5,3,8,2,6,9,7,1],[9,2,7,5,4,8,3,1,6],[5,6,8,1,3,2,7,9,4],[3,1,4,7,6,9,5,2,8],[2,3,9,6,7,1,4,8,5],[1,8,5,4,9,3,2,6,7],[7,4,6,2,8,5,1,3,9]]
1603	[[4,3,9,1,5,7,6,2,8],[2,1,8,3,6,4,5,7,9],[6,5,7,2,9,8,3,1,4],[5,8,2,4,7,6,9,3,1],[3,9,6,5,8,1,2,4,7],[1,7,4,9,3,2,8,5,6],[9,2,1,6,4,3,7,8,5],[7,4,5,8,2,9,1,6,3],[8,6,3,7,1,5,4,9,2]]
1604	[[6,4,1,5,9,7,2,3,8],[5,7,2,8,6,3,4,9,1],[9,8,3,2,1,4,6,5,7],[1,9,8,3,2,6,7,4,5],[7,6,4,1,5,8,3,2,9],[3,2,5,7,4,9,1,8,6],[4,5,7,6,8,2,9,1,3],[2,1,6,9,3,5,8,7,4],[8,3,9,4,7,1,5,6,2]]
1605	[[7,5,2,3,8,6,9,4,1],[3,4,9,7,1,2,6,5,8],[8,1,6,9,5,4,2,7,3],[5,9,3,1,7,8,4,2,6],[1,6,4,2,3,9,7,8,5],[2,8,7,4,6,5,3,1,9],[9,7,8,6,2,1,5,3,4],[4,2,1,5,9,3,8,6,7],[6,3,5,8,4,7,1,9,2]]
1606	[[4,9,8,5,1,2,3,7,6],[3,7,5,6,4,8,9,1,2],[2,6,1,7,3,9,8,4,5],[1,5,3,4,2,6,7,9,8],[7,8,4,3,9,5,2,6,1],[6,2,9,1,8,7,5,3,4],[5,3,7,2,6,1,4,8,9],[9,1,2,8,7,4,6,5,3],[8,4,6,9,5,3,1,2,7]]
1607	[[6,1,4,9,8,3,5,2,7],[5,8,9,1,2,7,4,3,6],[7,3,2,5,6,4,9,8,1],[9,5,8,2,7,6,3,1,4],[3,7,6,4,1,9,2,5,8],[2,4,1,3,5,8,7,6,9],[1,6,3,7,4,5,8,9,2],[8,9,7,6,3,2,1,4,5],[4,2,5,8,9,1,6,7,3]]
1608	[[8,6,5,7,3,9,4,1,2],[7,2,1,4,8,5,6,9,3],[9,3,4,6,1,2,8,5,7],[6,1,8,5,2,7,3,4,9],[2,4,7,3,9,8,5,6,1],[5,9,3,1,4,6,7,2,8],[4,8,6,2,7,1,9,3,5],[1,5,9,8,6,3,2,7,4],[3,7,2,9,5,4,1,8,6]]
1609	[[3,6,9,1,7,2,8,5,4],[2,7,1,5,8,4,6,9,3],[8,4,5,3,6,9,2,7,1],[1,3,6,9,2,5,7,4,8],[7,2,4,6,1,8,5,3,9],[9,5,8,4,3,7,1,2,6],[5,1,3,7,4,6,9,8,2],[4,8,7,2,9,1,3,6,5],[6,9,2,8,5,3,4,1,7]]
1610	[[4,3,5,8,7,1,2,9,6],[1,8,7,6,2,9,5,3,4],[2,6,9,3,4,5,7,1,8],[8,7,4,1,9,6,3,5,2],[5,9,6,7,3,2,4,8,1],[3,1,2,5,8,4,9,6,7],[6,2,1,4,5,3,8,7,9],[7,4,3,9,6,8,1,2,5],[9,5,8,2,1,7,6,4,3]]
1611	[[4,5,8,3,1,9,7,6,2],[1,2,7,8,4,6,9,5,3],[9,6,3,7,2,5,1,4,8],[3,9,1,6,7,2,5,8,4],[8,4,2,5,3,1,6,9,7],[6,7,5,4,9,8,3,2,1],[5,1,4,9,8,7,2,3,6],[2,3,6,1,5,4,8,7,9],[7,8,9,2,6,3,4,1,5]]
1612	[[8,9,4,7,3,2,1,5,6],[6,7,5,4,1,8,3,2,9],[1,2,3,9,6,5,7,4,8],[3,4,8,2,5,1,9,6,7],[2,6,1,3,7,9,4,8,5],[7,5,9,8,4,6,2,3,1],[9,1,2,6,8,4,5,7,3],[4,8,7,5,9,3,6,1,2],[5,3,6,1,2,7,8,9,4]]
1613	[[4,6,1,5,8,3,2,7,9],[7,2,8,9,1,4,5,6,3],[3,5,9,7,2,6,1,8,4],[1,3,2,6,9,5,8,4,7],[8,9,7,3,4,2,6,5,1],[5,4,6,8,7,1,9,3,2],[2,7,5,4,6,9,3,1,8],[6,1,4,2,3,8,7,9,5],[9,8,3,1,5,7,4,2,6]]
1614	[[3,9,7,5,6,1,2,8,4],[1,8,2,9,4,7,3,6,5],[6,4,5,2,8,3,1,7,9],[8,5,4,6,1,2,9,3,7],[2,3,1,7,5,9,6,4,8],[7,6,9,8,3,4,5,2,1],[5,2,6,1,7,8,4,9,3],[9,7,3,4,2,5,8,1,6],[4,1,8,3,9,6,7,5,2]]
1615	[[2,8,7,6,3,5,1,9,4],[5,4,9,7,8,1,6,2,3],[1,3,6,2,4,9,7,5,8],[3,1,8,5,2,7,9,4,6],[7,6,2,9,1,4,3,8,5],[4,9,5,8,6,3,2,1,7],[8,5,3,1,9,6,4,7,2],[6,7,1,4,5,2,8,3,9],[9,2,4,3,7,8,5,6,1]]
1616	[[3,8,9,4,1,7,2,5,6],[4,2,5,8,6,9,3,1,7],[7,6,1,5,2,3,4,8,9],[8,4,7,1,3,6,5,9,2],[9,5,2,7,4,8,6,3,1],[6,1,3,9,5,2,7,4,8],[5,7,8,6,9,4,1,2,3],[1,3,6,2,8,5,9,7,4],[2,9,4,3,7,1,8,6,5]]
1617	[[8,1,7,5,4,3,2,6,9],[9,2,5,6,7,1,4,3,8],[4,3,6,8,9,2,1,7,5],[6,9,2,4,1,5,3,8,7],[5,7,3,2,8,9,6,1,4],[1,8,4,7,3,6,5,9,2],[7,6,8,1,2,4,9,5,3],[3,4,1,9,5,7,8,2,6],[2,5,9,3,6,8,7,4,1]]
1618	[[3,1,8,4,5,2,6,7,9],[4,2,7,6,9,1,3,5,8],[5,6,9,3,8,7,4,1,2],[2,3,1,5,4,6,9,8,7],[9,7,4,8,1,3,2,6,5],[8,5,6,2,7,9,1,3,4],[1,4,2,7,6,8,5,9,3],[6,8,3,9,2,5,7,4,1],[7,9,5,1,3,4,8,2,6]]
1619	[[3,2,4,9,5,7,1,8,6],[5,1,9,6,8,2,3,4,7],[6,8,7,4,3,1,9,2,5],[7,6,8,2,9,5,4,1,3],[1,5,2,8,4,3,6,7,9],[4,9,3,7,1,6,2,5,8],[9,3,5,1,2,8,7,6,4],[2,4,6,5,7,9,8,3,1],[8,7,1,3,6,4,5,9,2]]
1620	[[5,8,1,6,2,9,3,4,7],[7,9,4,1,3,5,2,6,8],[6,3,2,8,4,7,1,9,5],[1,7,5,4,6,8,9,3,2],[2,6,3,7,9,1,8,5,4],[8,4,9,3,5,2,7,1,6],[3,1,6,2,8,4,5,7,9],[9,2,7,5,1,6,4,8,3],[4,5,8,9,7,3,6,2,1]]
1621	[[5,9,2,8,1,4,7,6,3],[8,4,7,9,3,6,5,2,1],[6,1,3,2,5,7,9,8,4],[7,8,9,4,2,3,1,5,6],[2,3,1,7,6,5,8,4,9],[4,6,5,1,9,8,3,7,2],[1,7,8,6,4,9,2,3,5],[3,2,6,5,8,1,4,9,7],[9,5,4,3,7,2,6,1,8]]
1622	[[1,2,9,3,6,8,7,5,4],[8,6,4,7,5,9,2,3,1],[3,5,7,1,2,4,6,9,8],[5,8,1,2,7,3,9,4,6],[4,7,6,5,9,1,3,8,2],[2,9,3,4,8,6,1,7,5],[6,4,5,9,3,2,8,1,7],[7,3,8,6,1,5,4,2,9],[9,1,2,8,4,7,5,6,3]]
1623	[[6,2,4,9,3,8,1,5,7],[5,1,9,4,7,6,2,3,8],[8,7,3,2,5,1,9,6,4],[9,5,8,6,2,7,3,4,1],[1,4,2,3,8,5,7,9,6],[3,6,7,1,9,4,5,8,2],[2,8,1,5,4,3,6,7,9],[4,9,5,7,6,2,8,1,3],[7,3,6,8,1,9,4,2,5]]
1624	[[2,3,4,9,7,8,6,1,5],[6,9,7,5,1,4,2,8,3],[8,1,5,3,2,6,4,7,9],[9,4,2,1,8,5,3,6,7],[5,7,3,2,6,9,8,4,1],[1,6,8,7,4,3,9,5,2],[3,8,1,6,5,2,7,9,4],[7,2,6,4,9,1,5,3,8],[4,5,9,8,3,7,1,2,6]]
1625	[[3,8,2,1,5,9,7,4,6],[5,7,6,4,8,3,2,9,1],[9,4,1,6,7,2,3,8,5],[4,1,7,3,2,8,6,5,9],[2,3,5,9,1,6,4,7,8],[8,6,9,7,4,5,1,2,3],[7,2,8,5,6,1,9,3,4],[1,9,4,8,3,7,5,6,2],[6,5,3,2,9,4,8,1,7]]
1626	[[9,6,3,7,8,2,1,4,5],[4,1,5,9,3,6,7,8,2],[7,8,2,5,4,1,3,9,6],[3,5,1,2,9,8,6,7,4],[8,4,9,3,6,7,2,5,1],[6,2,7,1,5,4,8,3,9],[5,7,4,6,1,3,9,2,8],[1,3,8,4,2,9,5,6,7],[2,9,6,8,7,5,4,1,3]]
1627	[[7,3,6,2,9,4,8,1,5],[2,1,5,8,7,3,9,6,4],[8,4,9,5,6,1,2,7,3],[9,7,1,4,5,8,3,2,6],[4,8,3,1,2,6,7,5,9],[5,6,2,7,3,9,1,4,8],[6,5,8,9,1,2,4,3,7],[1,9,7,3,4,5,6,8,2],[3,2,4,6,8,7,5,9,1]]
1628	[[3,7,4,5,6,2,9,1,8],[1,8,9,3,4,7,6,2,5],[2,5,6,1,9,8,3,4,7],[7,3,2,8,1,9,4,5,6],[4,1,8,7,5,6,2,3,9],[9,6,5,2,3,4,8,7,1],[8,4,7,6,2,1,5,9,3],[5,9,1,4,8,3,7,6,2],[6,2,3,9,7,5,1,8,4]]
1629	[[7,6,5,4,2,1,3,9,8],[8,2,1,6,3,9,4,5,7],[4,9,3,7,5,8,1,6,2],[2,8,6,3,7,5,9,1,4],[1,5,7,9,4,6,2,8,3],[3,4,9,8,1,2,5,7,6],[5,1,8,2,6,3,7,4,9],[9,7,2,1,8,4,6,3,5],[6,3,4,5,9,7,8,2,1]]
1630	[[5,3,8,9,4,7,6,1,2],[7,1,4,6,5,2,9,3,8],[2,6,9,8,3,1,5,7,4],[9,8,5,2,1,4,3,6,7],[3,2,1,7,9,6,8,4,5],[6,4,7,3,8,5,1,2,9],[8,7,3,1,2,9,4,5,6],[1,5,6,4,7,8,2,9,3],[4,9,2,5,6,3,7,8,1]]
1631	[[1,2,3,5,4,6,7,8,9],[9,8,4,7,2,3,6,5,1],[7,6,5,9,8,1,2,3,4],[4,1,2,6,7,8,3,9,5],[3,9,7,1,5,2,4,6,8],[8,5,6,3,9,4,1,7,2],[6,3,8,2,1,5,9,4,7],[2,4,9,8,3,7,5,1,6],[5,7,1,4,6,9,8,2,3]]
1632	[[5,4,1,9,3,6,7,8,2],[3,2,8,4,7,1,5,9,6],[9,7,6,2,8,5,1,3,4],[2,6,9,3,5,8,4,1,7],[4,3,7,1,6,2,8,5,9],[1,8,5,7,4,9,6,2,3],[6,1,3,5,9,7,2,4,8],[7,9,2,8,1,4,3,6,5],[8,5,4,6,2,3,9,7,1]]
1633	[[8,3,2,9,4,5,1,7,6],[5,4,7,3,6,1,8,9,2],[6,1,9,8,7,2,3,4,5],[3,7,6,2,5,9,4,8,1],[2,8,4,7,1,6,9,5,3],[1,9,5,4,3,8,6,2,7],[9,5,1,6,2,4,7,3,8],[7,6,8,5,9,3,2,1,4],[4,2,3,1,8,7,5,6,9]]
1634	[[6,5,4,9,8,2,1,7,3],[1,8,7,6,4,3,2,9,5],[2,9,3,1,7,5,4,8,6],[4,7,8,3,2,9,5,6,1],[5,3,1,7,6,8,9,4,2],[9,6,2,5,1,4,8,3,7],[7,2,9,8,5,6,3,1,4],[8,4,6,2,3,1,7,5,9],[3,1,5,4,9,7,6,2,8]]
1635	[[7,6,4,5,8,9,3,2,1],[8,9,3,2,1,4,6,7,5],[1,2,5,6,3,7,8,9,4],[2,8,9,3,5,1,7,4,6],[5,4,1,7,6,2,9,3,8],[6,3,7,9,4,8,1,5,2],[3,1,8,4,9,5,2,6,7],[4,7,6,1,2,3,5,8,9],[9,5,2,8,7,6,4,1,3]]
1636	[[8,1,9,5,4,2,6,3,7],[7,3,4,8,9,6,2,1,5],[5,2,6,3,1,7,8,4,9],[4,9,7,1,5,8,3,2,6],[1,6,5,2,3,4,9,7,8],[3,8,2,7,6,9,1,5,4],[9,5,8,4,2,3,7,6,1],[6,4,3,9,7,1,5,8,2],[2,7,1,6,8,5,4,9,3]]
1637	[[3,9,1,6,5,2,4,8,7],[2,7,4,8,1,9,3,5,6],[6,8,5,4,3,7,1,2,9],[7,1,8,5,9,3,6,4,2],[5,6,2,1,7,4,9,3,8],[9,4,3,2,6,8,5,7,1],[1,5,7,3,2,6,8,9,4],[8,2,6,9,4,5,7,1,3],[4,3,9,7,8,1,2,6,5]]
1638	[[6,8,5,4,9,1,7,2,3],[2,1,7,8,5,3,9,6,4],[4,9,3,7,6,2,5,8,1],[7,6,4,2,1,5,3,9,8],[8,5,2,3,4,9,6,1,7],[1,3,9,6,7,8,2,4,5],[9,4,1,5,3,6,8,7,2],[3,2,6,1,8,7,4,5,9],[5,7,8,9,2,4,1,3,6]]
1639	[[3,8,1,7,6,2,5,4,9],[6,9,2,4,1,5,7,3,8],[5,7,4,3,9,8,1,2,6],[7,1,3,6,8,9,2,5,4],[9,4,6,2,5,7,8,1,3],[2,5,8,1,4,3,6,9,7],[8,2,5,9,3,6,4,7,1],[1,6,9,5,7,4,3,8,2],[4,3,7,8,2,1,9,6,5]]
1640	[[4,5,6,7,1,8,3,9,2],[3,9,7,2,5,4,8,1,6],[2,1,8,6,3,9,7,4,5],[7,6,3,4,9,1,2,5,8],[1,2,9,5,8,6,4,3,7],[5,8,4,3,7,2,1,6,9],[6,7,2,1,4,5,9,8,3],[9,4,5,8,2,3,6,7,1],[8,3,1,9,6,7,5,2,4]]
1641	[[8,1,4,3,9,7,5,2,6],[6,7,3,4,5,2,1,9,8],[2,5,9,1,6,8,3,4,7],[5,6,7,2,3,4,9,8,1],[3,8,1,9,7,6,4,5,2],[9,4,2,5,8,1,7,6,3],[4,9,6,8,1,3,2,7,5],[1,2,8,7,4,5,6,3,9],[7,3,5,6,2,9,8,1,4]]
1642	[[4,1,8,7,9,2,6,3,5],[5,2,9,8,6,3,7,1,4],[6,7,3,1,5,4,2,8,9],[8,9,4,2,3,7,1,5,6],[1,3,6,5,4,9,8,7,2],[7,5,2,6,1,8,4,9,3],[2,6,5,3,7,1,9,4,8],[3,4,1,9,8,6,5,2,7],[9,8,7,4,2,5,3,6,1]]
1643	[[8,9,6,1,4,5,3,2,7],[7,2,1,9,3,6,4,8,5],[3,5,4,7,2,8,1,9,6],[2,4,3,8,7,9,5,6,1],[6,7,8,5,1,4,9,3,2],[5,1,9,2,6,3,7,4,8],[9,6,2,3,5,7,8,1,4],[1,3,5,4,8,2,6,7,9],[4,8,7,6,9,1,2,5,3]]
1644	[[5,9,1,3,4,8,2,6,7],[7,8,6,1,9,2,3,5,4],[3,4,2,6,5,7,9,1,8],[4,5,7,8,2,6,1,9,3],[8,2,3,9,1,4,6,7,5],[1,6,9,5,7,3,8,4,2],[6,1,8,4,3,5,7,2,9],[9,7,4,2,8,1,5,3,6],[2,3,5,7,6,9,4,8,1]]
1645	[[3,1,7,5,9,2,6,8,4],[5,8,2,4,1,6,7,3,9],[6,9,4,8,3,7,1,5,2],[2,7,3,6,8,5,9,4,1],[8,4,9,1,7,3,5,2,6],[1,5,6,9,2,4,3,7,8],[9,2,8,7,5,1,4,6,3],[7,6,1,3,4,8,2,9,5],[4,3,5,2,6,9,8,1,7]]
1646	[[9,2,1,4,5,6,7,3,8],[3,8,5,9,1,7,4,2,6],[7,6,4,3,2,8,9,1,5],[6,4,2,7,3,1,5,8,9],[8,1,9,5,6,2,3,7,4],[5,7,3,8,4,9,2,6,1],[2,9,7,6,8,5,1,4,3],[4,5,6,1,7,3,8,9,2],[1,3,8,2,9,4,6,5,7]]
1647	[[8,4,1,6,5,9,2,3,7],[3,2,6,4,7,8,1,9,5],[7,5,9,3,2,1,4,8,6],[2,6,4,8,1,5,9,7,3],[5,7,8,2,9,3,6,4,1],[9,1,3,7,4,6,5,2,8],[6,3,5,9,8,2,7,1,4],[4,8,2,1,6,7,3,5,9],[1,9,7,5,3,4,8,6,2]]
1648	[[2,5,9,3,6,4,1,8,7],[1,8,4,5,7,9,6,3,2],[7,6,3,8,2,1,9,5,4],[4,7,2,6,1,5,8,9,3],[6,1,8,2,9,3,7,4,5],[9,3,5,7,4,8,2,1,6],[8,4,6,9,5,7,3,2,1],[3,2,1,4,8,6,5,7,9],[5,9,7,1,3,2,4,6,8]]
1649	[[8,2,5,3,9,7,4,6,1],[1,6,4,5,2,8,3,7,9],[7,3,9,1,4,6,8,2,5],[2,8,1,4,5,3,7,9,6],[6,9,7,8,1,2,5,3,4],[4,5,3,6,7,9,2,1,8],[3,1,2,9,8,5,6,4,7],[9,7,8,2,6,4,1,5,3],[5,4,6,7,3,1,9,8,2]]
1650	[[6,9,1,2,8,3,4,5,7],[8,7,4,5,9,6,1,3,2],[2,3,5,1,4,7,9,8,6],[5,8,7,3,6,9,2,4,1],[3,6,9,4,2,1,8,7,5],[4,1,2,8,7,5,3,6,9],[7,4,8,6,1,2,5,9,3],[1,5,6,9,3,4,7,2,8],[9,2,3,7,5,8,6,1,4]]
1651	[[7,5,8,4,1,3,2,9,6],[1,3,6,2,9,7,8,5,4],[4,9,2,5,6,8,3,7,1],[3,7,5,1,4,2,6,8,9],[6,4,1,3,8,9,5,2,7],[8,2,9,7,5,6,1,4,3],[9,6,3,8,2,4,7,1,5],[5,8,7,9,3,1,4,6,2],[2,1,4,6,7,5,9,3,8]]
1652	[[9,3,7,4,2,8,1,5,6],[6,1,4,3,5,9,8,7,2],[2,8,5,6,1,7,3,9,4],[1,7,3,9,4,6,5,2,8],[4,5,2,8,3,1,7,6,9],[8,9,6,5,7,2,4,3,1],[3,4,9,2,8,5,6,1,7],[7,6,8,1,9,3,2,4,5],[5,2,1,7,6,4,9,8,3]]
1653	[[2,4,9,1,7,5,3,8,6],[1,5,8,9,3,6,2,4,7],[7,6,3,4,2,8,1,5,9],[8,1,4,3,6,7,9,2,5],[3,9,5,2,8,4,6,7,1],[6,2,7,5,9,1,4,3,8],[4,8,6,7,1,2,5,9,3],[9,7,2,6,5,3,8,1,4],[5,3,1,8,4,9,7,6,2]]
1654	[[9,7,6,5,1,3,2,4,8],[4,8,3,2,7,9,6,5,1],[1,2,5,8,4,6,9,3,7],[5,4,7,3,9,1,8,6,2],[3,6,8,7,5,2,4,1,9],[2,9,1,6,8,4,5,7,3],[7,1,4,9,2,5,3,8,6],[6,5,9,1,3,8,7,2,4],[8,3,2,4,6,7,1,9,5]]
1655	[[4,6,1,7,3,8,9,5,2],[8,2,9,5,6,4,1,3,7],[7,5,3,9,2,1,4,8,6],[9,4,2,8,7,3,5,6,1],[6,1,7,2,5,9,3,4,8],[5,3,8,4,1,6,7,2,9],[1,8,4,3,9,2,6,7,5],[2,7,6,1,4,5,8,9,3],[3,9,5,6,8,7,2,1,4]]
1656	[[5,6,9,3,4,1,7,2,8],[4,8,2,7,6,9,3,5,1],[1,7,3,2,5,8,4,6,9],[9,1,5,6,3,2,8,4,7],[6,3,8,1,7,4,2,9,5],[2,4,7,9,8,5,6,1,3],[8,9,6,4,1,7,5,3,2],[3,5,1,8,2,6,9,7,4],[7,2,4,5,9,3,1,8,6]]
1657	[[3,7,5,1,6,2,9,8,4],[1,4,8,9,3,5,2,7,6],[2,9,6,8,7,4,5,3,1],[8,2,7,3,1,6,4,9,5],[5,6,4,2,9,8,3,1,7],[9,3,1,5,4,7,6,2,8],[4,1,2,7,5,9,8,6,3],[6,8,3,4,2,1,7,5,9],[7,5,9,6,8,3,1,4,2]]
1658	[[9,5,1,2,3,8,7,4,6],[6,3,2,7,4,9,5,1,8],[8,4,7,5,6,1,3,9,2],[5,6,3,1,2,4,9,8,7],[1,7,8,9,5,3,2,6,4],[4,2,9,8,7,6,1,3,5],[3,9,5,4,8,2,6,7,1],[7,8,6,3,1,5,4,2,9],[2,1,4,6,9,7,8,5,3]]
1659	[[8,3,5,2,1,4,6,7,9],[6,7,4,8,3,9,2,1,5],[2,9,1,5,6,7,3,8,4],[4,8,2,7,9,6,5,3,1],[7,1,6,3,4,5,9,2,8],[9,5,3,1,2,8,4,6,7],[1,4,7,6,5,2,8,9,3],[3,2,9,4,8,1,7,5,6],[5,6,8,9,7,3,1,4,2]]
1660	[[8,1,9,4,6,3,2,5,7],[6,2,4,5,1,7,3,8,9],[7,3,5,8,2,9,6,4,1],[4,5,2,1,7,6,8,9,3],[1,6,7,9,3,8,4,2,5],[9,8,3,2,4,5,7,1,6],[5,4,6,7,9,2,1,3,8],[2,7,8,3,5,1,9,6,4],[3,9,1,6,8,4,5,7,2]]
1661	[[5,8,6,2,7,1,9,4,3],[1,9,2,5,3,4,7,8,6],[3,7,4,8,9,6,2,5,1],[8,6,7,4,1,9,5,3,2],[2,3,5,7,6,8,4,1,9],[4,1,9,3,2,5,8,6,7],[7,2,8,1,5,3,6,9,4],[6,4,3,9,8,7,1,2,5],[9,5,1,6,4,2,3,7,8]]
1662	[[8,5,6,9,1,2,7,4,3],[2,7,4,3,8,5,1,9,6],[3,9,1,6,7,4,2,5,8],[4,2,7,1,3,6,9,8,5],[5,1,9,2,4,8,6,3,7],[6,3,8,7,5,9,4,2,1],[7,8,2,5,9,1,3,6,4],[1,6,5,4,2,3,8,7,9],[9,4,3,8,6,7,5,1,2]]
1663	[[5,9,1,6,2,4,7,3,8],[8,6,2,7,1,3,9,5,4],[4,7,3,5,8,9,2,1,6],[6,2,8,1,3,7,5,4,9],[3,1,4,9,5,8,6,7,2],[7,5,9,4,6,2,3,8,1],[9,8,5,2,7,1,4,6,3],[2,3,6,8,4,5,1,9,7],[1,4,7,3,9,6,8,2,5]]
1664	[[5,2,3,1,7,8,6,4,9],[4,9,8,5,6,2,1,7,3],[1,7,6,4,3,9,8,5,2],[8,4,9,3,1,5,7,2,6],[3,6,1,7,2,4,5,9,8],[2,5,7,8,9,6,3,1,4],[9,3,5,2,8,7,4,6,1],[7,8,2,6,4,1,9,3,5],[6,1,4,9,5,3,2,8,7]]
1665	[[8,2,9,4,1,3,7,6,5],[1,3,7,9,6,5,4,8,2],[5,4,6,8,2,7,1,3,9],[7,9,2,5,3,1,8,4,6],[4,6,1,7,8,9,2,5,3],[3,5,8,6,4,2,9,1,7],[9,1,4,3,7,6,5,2,8],[6,8,5,2,9,4,3,7,1],[2,7,3,1,5,8,6,9,4]]
1666	[[9,5,4,6,7,3,8,2,1],[3,2,8,4,1,5,9,7,6],[7,6,1,2,9,8,5,4,3],[8,9,7,3,6,4,2,1,5],[2,1,6,9,5,7,3,8,4],[5,4,3,8,2,1,7,6,9],[4,7,9,5,8,6,1,3,2],[6,8,5,1,3,2,4,9,7],[1,3,2,7,4,9,6,5,8]]
1667	[[2,4,6,3,7,5,1,8,9],[1,3,9,2,4,8,6,5,7],[5,7,8,1,6,9,2,4,3],[9,8,7,4,3,6,5,2,1],[3,1,4,8,5,2,7,9,6],[6,5,2,7,9,1,8,3,4],[8,2,3,6,1,4,9,7,5],[7,6,5,9,8,3,4,1,2],[4,9,1,5,2,7,3,6,8]]
1668	[[4,9,8,2,5,3,7,1,6],[5,1,3,9,7,6,8,4,2],[7,6,2,1,4,8,5,3,9],[3,8,5,6,2,4,1,9,7],[6,4,7,5,9,1,3,2,8],[9,2,1,3,8,7,6,5,4],[8,5,9,7,3,2,4,6,1],[2,7,6,4,1,5,9,8,3],[1,3,4,8,6,9,2,7,5]]
1669	[[6,9,1,3,7,4,5,8,2],[2,5,4,8,6,1,9,7,3],[3,7,8,5,2,9,6,1,4],[4,8,9,2,3,7,1,5,6],[1,6,7,4,8,5,2,3,9],[5,3,2,1,9,6,8,4,7],[7,4,5,9,1,2,3,6,8],[8,2,6,7,5,3,4,9,1],[9,1,3,6,4,8,7,2,5]]
1670	[[5,2,6,4,9,3,7,1,8],[1,3,7,6,8,2,5,9,4],[8,4,9,5,1,7,2,3,6],[7,8,2,9,3,6,1,4,5],[3,5,1,2,4,8,6,7,9],[6,9,4,1,7,5,8,2,3],[9,6,8,3,2,1,4,5,7],[4,1,5,7,6,9,3,8,2],[2,7,3,8,5,4,9,6,1]]
1671	[[3,2,1,4,6,8,9,7,5],[8,7,9,1,3,5,2,6,4],[5,4,6,7,9,2,8,1,3],[6,9,5,8,2,7,4,3,1],[7,8,2,3,4,1,6,5,9],[1,3,4,9,5,6,7,8,2],[2,6,3,5,8,9,1,4,7],[4,1,8,2,7,3,5,9,6],[9,5,7,6,1,4,3,2,8]]
1672	[[3,8,7,5,6,1,2,4,9],[4,5,1,9,3,2,6,7,8],[2,9,6,7,4,8,1,3,5],[1,2,8,3,5,4,9,6,7],[7,6,4,1,8,9,5,2,3],[9,3,5,2,7,6,8,1,4],[6,7,2,4,9,5,3,8,1],[5,1,3,8,2,7,4,9,6],[8,4,9,6,1,3,7,5,2]]
1673	[[7,9,8,2,6,4,1,5,3],[2,1,6,3,5,8,4,7,9],[3,5,4,7,9,1,8,6,2],[9,8,3,1,2,7,6,4,5],[6,4,2,5,8,9,3,1,7],[1,7,5,6,4,3,9,2,8],[8,6,1,9,7,5,2,3,4],[5,3,9,4,1,2,7,8,6],[4,2,7,8,3,6,5,9,1]]
1674	[[7,8,1,5,6,4,2,9,3],[5,2,9,1,3,7,6,8,4],[6,4,3,9,2,8,1,5,7],[3,1,8,4,5,9,7,2,6],[4,6,5,7,8,2,3,1,9],[2,9,7,3,1,6,8,4,5],[1,5,4,2,7,3,9,6,8],[9,3,6,8,4,1,5,7,2],[8,7,2,6,9,5,4,3,1]]
1675	[[2,3,9,5,7,6,8,1,4],[8,4,1,3,2,9,6,5,7],[6,5,7,4,1,8,3,2,9],[9,2,8,7,4,1,5,3,6],[5,1,4,8,6,3,7,9,2],[7,6,3,9,5,2,4,8,1],[3,8,6,2,9,7,1,4,5],[4,7,2,1,3,5,9,6,8],[1,9,5,6,8,4,2,7,3]]
1676	[[2,9,6,4,5,7,3,8,1],[3,8,7,9,6,1,5,2,4],[1,5,4,3,2,8,6,9,7],[8,4,5,2,1,3,7,6,9],[9,1,2,6,7,4,8,5,3],[7,6,3,8,9,5,1,4,2],[5,3,9,1,4,6,2,7,8],[4,7,8,5,3,2,9,1,6],[6,2,1,7,8,9,4,3,5]]
1677	[[8,9,2,3,7,4,5,1,6],[7,6,5,1,9,8,2,4,3],[3,4,1,2,5,6,7,8,9],[5,3,8,9,4,2,6,7,1],[6,2,7,5,8,1,3,9,4],[9,1,4,7,6,3,8,5,2],[4,5,9,6,3,7,1,2,8],[2,8,6,4,1,5,9,3,7],[1,7,3,8,2,9,4,6,5]]
1678	[[9,1,3,4,5,2,7,8,6],[5,8,6,9,3,7,4,1,2],[2,7,4,8,6,1,3,9,5],[7,2,1,3,8,9,6,5,4],[8,6,9,7,4,5,1,2,3],[4,3,5,2,1,6,9,7,8],[6,5,2,1,9,3,8,4,7],[3,9,8,5,7,4,2,6,1],[1,4,7,6,2,8,5,3,9]]
1679	[[3,6,2,9,4,7,8,5,1],[1,8,5,2,6,3,4,7,9],[9,7,4,5,1,8,2,6,3],[7,4,6,3,8,5,1,9,2],[5,3,9,1,2,6,7,8,4],[8,2,1,7,9,4,5,3,6],[2,9,3,8,7,1,6,4,5],[4,5,7,6,3,2,9,1,8],[6,1,8,4,5,9,3,2,7]]
1680	[[9,8,6,4,5,1,7,3,2],[3,5,1,9,2,7,6,4,8],[4,2,7,8,3,6,1,5,9],[2,6,3,1,7,9,4,8,5],[1,7,4,5,8,3,2,9,6],[8,9,5,6,4,2,3,1,7],[6,3,8,7,9,4,5,2,1],[5,1,2,3,6,8,9,7,4],[7,4,9,2,1,5,8,6,3]]
1681	[[6,3,8,9,1,7,5,4,2],[4,7,5,8,6,2,3,9,1],[1,9,2,4,3,5,7,8,6],[5,6,9,7,2,4,8,1,3],[2,1,4,3,5,8,6,7,9],[3,8,7,1,9,6,4,2,5],[9,4,3,5,7,1,2,6,8],[7,2,1,6,8,3,9,5,4],[8,5,6,2,4,9,1,3,7]]
1682	[[1,2,6,4,8,7,9,3,5],[5,4,9,3,1,2,6,7,8],[7,8,3,9,5,6,2,1,4],[3,5,2,8,9,1,7,4,6],[6,9,7,2,4,5,3,8,1],[4,1,8,7,6,3,5,9,2],[8,7,1,5,2,9,4,6,3],[2,3,4,6,7,8,1,5,9],[9,6,5,1,3,4,8,2,7]]
1683	[[9,1,4,5,3,8,2,6,7],[3,8,2,6,1,7,4,5,9],[7,5,6,9,4,2,8,1,3],[4,3,9,7,8,1,6,2,5],[1,6,7,2,5,9,3,4,8],[5,2,8,4,6,3,9,7,1],[6,9,1,8,7,4,5,3,2],[2,4,3,1,9,5,7,8,6],[8,7,5,3,2,6,1,9,4]]
1684	[[7,4,5,6,3,1,2,8,9],[9,3,6,8,7,2,5,1,4],[2,1,8,4,9,5,3,7,6],[1,5,7,9,2,4,6,3,8],[3,6,9,5,1,8,4,2,7],[8,2,4,3,6,7,9,5,1],[4,8,2,1,5,9,7,6,3],[6,7,1,2,4,3,8,9,5],[5,9,3,7,8,6,1,4,2]]
1685	[[9,4,5,2,7,1,3,6,8],[6,1,2,3,8,9,5,7,4],[8,3,7,5,4,6,9,2,1],[3,2,9,8,6,4,1,5,7],[4,8,1,7,9,5,2,3,6],[5,7,6,1,2,3,4,8,9],[2,6,4,9,3,7,8,1,5],[7,5,8,4,1,2,6,9,3],[1,9,3,6,5,8,7,4,2]]
1686	[[9,7,2,3,5,6,1,4,8],[5,1,8,7,9,4,2,3,6],[3,4,6,8,2,1,7,5,9],[1,5,9,4,6,3,8,7,2],[6,8,7,2,1,5,3,9,4],[4,2,3,9,7,8,6,1,5],[2,6,1,5,4,7,9,8,3],[8,9,4,1,3,2,5,6,7],[7,3,5,6,8,9,4,2,1]]
1687	[[3,8,9,4,7,5,2,6,1],[5,7,6,1,2,9,3,4,8],[4,2,1,8,6,3,9,5,7],[9,1,5,7,4,8,6,2,3],[8,6,4,2,3,1,7,9,5],[7,3,2,9,5,6,8,1,4],[2,9,7,5,8,4,1,3,6],[6,4,8,3,1,2,5,7,9],[1,5,3,6,9,7,4,8,2]]
1688	[[7,3,2,6,4,1,5,9,8],[5,4,8,9,7,3,2,1,6],[1,6,9,5,8,2,7,4,3],[3,2,5,4,6,9,1,8,7],[9,7,6,1,2,8,4,3,5],[8,1,4,3,5,7,9,6,2],[6,5,3,7,1,4,8,2,9],[2,9,1,8,3,5,6,7,4],[4,8,7,2,9,6,3,5,1]]
1689	[[7,4,9,1,3,2,5,6,8],[3,2,8,5,6,7,4,1,9],[5,6,1,4,8,9,7,2,3],[8,1,3,2,9,4,6,7,5],[4,9,5,7,1,6,8,3,2],[6,7,2,8,5,3,9,4,1],[2,3,7,9,4,5,1,8,6],[9,8,6,3,7,1,2,5,4],[1,5,4,6,2,8,3,9,7]]
1690	[[5,8,9,3,7,6,1,2,4],[2,6,7,9,4,1,5,8,3],[3,4,1,2,8,5,9,6,7],[1,3,8,7,6,2,4,5,9],[9,7,2,4,5,8,3,1,6],[6,5,4,1,9,3,8,7,2],[7,1,3,8,2,4,6,9,5],[4,9,5,6,1,7,2,3,8],[8,2,6,5,3,9,7,4,1]]
1691	[[5,2,4,7,3,9,8,1,6],[6,7,1,2,8,4,5,9,3],[9,3,8,6,5,1,7,2,4],[3,8,2,1,4,5,9,6,7],[1,9,5,8,7,6,4,3,2],[4,6,7,9,2,3,1,5,8],[8,4,6,5,9,2,3,7,1],[7,1,9,3,6,8,2,4,5],[2,5,3,4,1,7,6,8,9]]
1692	[[3,1,5,8,6,2,7,4,9],[6,2,9,4,7,1,8,3,5],[8,4,7,9,5,3,1,2,6],[7,8,4,2,3,9,5,6,1],[2,6,3,5,1,7,9,8,4],[5,9,1,6,8,4,3,7,2],[1,5,8,7,2,6,4,9,3],[9,7,6,3,4,5,2,1,8],[4,3,2,1,9,8,6,5,7]]
1693	[[3,4,2,8,1,9,6,5,7],[8,6,1,4,5,7,9,3,2],[5,7,9,2,3,6,8,4,1],[1,3,8,7,4,5,2,9,6],[6,2,5,9,8,1,4,7,3],[4,9,7,3,6,2,5,1,8],[7,8,3,5,2,4,1,6,9],[2,1,4,6,9,3,7,8,5],[9,5,6,1,7,8,3,2,4]]
1694	[[4,6,8,3,5,9,7,2,1],[5,9,1,6,2,7,8,4,3],[7,2,3,1,4,8,6,5,9],[3,7,9,2,8,5,4,1,6],[1,8,5,4,6,3,2,9,7],[6,4,2,7,9,1,3,8,5],[9,5,6,8,7,4,1,3,2],[8,3,7,9,1,2,5,6,4],[2,1,4,5,3,6,9,7,8]]
1695	[[4,1,3,6,9,8,7,5,2],[6,8,7,3,5,2,1,4,9],[9,5,2,7,4,1,8,6,3],[2,4,8,9,1,7,6,3,5],[5,3,1,4,8,6,2,9,7],[7,9,6,5,2,3,4,1,8],[3,6,4,2,7,5,9,8,1],[8,2,9,1,3,4,5,7,6],[1,7,5,8,6,9,3,2,4]]
1696	[[8,6,9,5,7,4,2,1,3],[3,5,2,1,9,8,4,7,6],[4,7,1,2,6,3,8,5,9],[1,3,8,7,4,5,9,6,2],[2,4,7,6,8,9,5,3,1],[6,9,5,3,2,1,7,4,8],[5,8,6,9,1,7,3,2,4],[9,1,3,4,5,2,6,8,7],[7,2,4,8,3,6,1,9,5]]
1697	[[5,7,6,1,2,9,3,4,8],[2,8,9,5,3,4,6,1,7],[3,1,4,6,8,7,2,9,5],[6,3,7,4,5,8,1,2,9],[1,2,5,3,9,6,7,8,4],[9,4,8,2,7,1,5,6,3],[4,5,3,8,1,2,9,7,6],[7,6,1,9,4,5,8,3,2],[8,9,2,7,6,3,4,5,1]]
1698	[[8,1,4,7,6,3,2,5,9],[5,7,2,9,8,1,3,4,6],[3,9,6,5,2,4,1,8,7],[2,3,8,4,5,6,9,7,1],[4,6,7,1,9,8,5,2,3],[9,5,1,2,3,7,4,6,8],[1,8,3,6,4,5,7,9,2],[7,2,5,8,1,9,6,3,4],[6,4,9,3,7,2,8,1,5]]
1699	[[1,5,9,4,7,8,2,6,3],[2,6,7,1,3,9,5,8,4],[4,8,3,2,6,5,9,7,1],[6,9,1,8,4,7,3,5,2],[3,7,2,9,5,1,8,4,6],[5,4,8,6,2,3,7,1,9],[7,3,4,5,1,2,6,9,8],[8,1,5,3,9,6,4,2,7],[9,2,6,7,8,4,1,3,5]]
1700	[[6,1,2,9,5,4,3,8,7],[5,4,9,8,3,7,6,1,2],[3,8,7,2,1,6,5,4,9],[8,9,1,6,7,2,4,3,5],[2,6,3,4,9,5,8,7,1],[4,7,5,3,8,1,2,9,6],[9,5,4,1,6,8,7,2,3],[1,2,6,7,4,3,9,5,8],[7,3,8,5,2,9,1,6,4]]
1701	[[6,4,2,3,1,5,9,8,7],[5,1,9,4,7,8,3,6,2],[7,3,8,6,2,9,4,1,5],[4,2,7,8,6,1,5,3,9],[8,9,1,2,5,3,6,7,4],[3,6,5,7,9,4,1,2,8],[1,8,4,5,3,7,2,9,6],[9,7,6,1,4,2,8,5,3],[2,5,3,9,8,6,7,4,1]]
1702	[[9,3,6,7,4,5,8,1,2],[7,8,5,1,3,2,4,6,9],[4,1,2,8,6,9,3,7,5],[6,2,7,4,9,8,5,3,1],[3,5,4,6,1,7,9,2,8],[8,9,1,2,5,3,7,4,6],[2,4,8,9,7,1,6,5,3],[5,6,9,3,2,4,1,8,7],[1,7,3,5,8,6,2,9,4]]
1703	[[6,5,2,3,9,8,7,1,4],[3,7,4,1,6,2,5,9,8],[8,1,9,4,7,5,6,3,2],[1,8,5,9,2,7,3,4,6],[7,9,3,8,4,6,1,2,5],[2,4,6,5,1,3,8,7,9],[9,3,8,2,5,1,4,6,7],[5,2,7,6,3,4,9,8,1],[4,6,1,7,8,9,2,5,3]]
1704	[[9,3,1,5,8,6,4,2,7],[7,6,4,2,1,9,3,5,8],[8,2,5,3,7,4,1,6,9],[1,9,8,6,5,2,7,3,4],[3,5,6,7,4,1,8,9,2],[4,7,2,8,9,3,5,1,6],[6,8,9,1,3,7,2,4,5],[5,4,3,9,2,8,6,7,1],[2,1,7,4,6,5,9,8,3]]
1705	[[9,7,4,5,3,6,2,1,8],[8,6,5,1,7,2,4,3,9],[1,3,2,9,8,4,5,7,6],[4,1,8,6,9,7,3,2,5],[7,5,3,2,1,8,6,9,4],[2,9,6,4,5,3,1,8,7],[5,8,9,3,4,1,7,6,2],[3,2,7,8,6,5,9,4,1],[6,4,1,7,2,9,8,5,3]]
1706	[[7,2,8,5,1,4,6,3,9],[4,5,1,6,3,9,8,7,2],[9,6,3,2,8,7,5,4,1],[2,8,9,4,7,5,1,6,3],[5,3,7,8,6,1,2,9,4],[6,1,4,3,9,2,7,5,8],[1,4,5,9,2,6,3,8,7],[8,7,6,1,4,3,9,2,5],[3,9,2,7,5,8,4,1,6]]
1707	[[2,8,7,3,4,1,6,5,9],[3,4,5,6,8,9,1,7,2],[1,9,6,5,7,2,3,4,8],[6,7,2,8,9,3,4,1,5],[9,5,4,7,1,6,8,2,3],[8,1,3,2,5,4,7,9,6],[4,3,1,9,6,5,2,8,7],[7,2,9,1,3,8,5,6,4],[5,6,8,4,2,7,9,3,1]]
1708	[[5,8,3,1,9,2,4,6,7],[2,6,9,4,7,5,8,1,3],[1,4,7,8,6,3,9,2,5],[8,7,5,2,1,9,3,4,6],[9,3,2,5,4,6,7,8,1],[6,1,4,3,8,7,2,5,9],[7,5,1,9,2,4,6,3,8],[3,2,6,7,5,8,1,9,4],[4,9,8,6,3,1,5,7,2]]
1709	[[3,9,1,8,2,4,5,7,6],[6,4,8,7,5,3,9,1,2],[2,5,7,9,1,6,3,4,8],[8,1,5,3,4,9,6,2,7],[4,2,3,6,7,5,1,8,9],[7,6,9,2,8,1,4,5,3],[9,7,4,5,3,2,8,6,1],[5,8,6,1,9,7,2,3,4],[1,3,2,4,6,8,7,9,5]]
1710	[[9,2,6,4,7,8,1,3,5],[1,5,4,9,3,2,7,8,6],[7,3,8,6,5,1,4,2,9],[3,1,5,7,8,6,2,9,4],[8,9,7,3,2,4,6,5,1],[4,6,2,1,9,5,3,7,8],[5,7,1,2,4,9,8,6,3],[6,8,3,5,1,7,9,4,2],[2,4,9,8,6,3,5,1,7]]
1711	[[3,9,5,7,2,4,6,1,8],[1,4,7,3,6,8,5,2,9],[2,8,6,9,5,1,4,7,3],[7,2,4,5,1,9,3,8,6],[9,3,8,2,7,6,1,5,4],[5,6,1,4,8,3,2,9,7],[6,1,9,8,4,5,7,3,2],[4,7,3,1,9,2,8,6,5],[8,5,2,6,3,7,9,4,1]]
1712	[[2,1,8,9,4,5,3,6,7],[4,6,9,2,7,3,8,5,1],[5,3,7,8,6,1,2,9,4],[1,2,6,7,8,9,4,3,5],[8,4,3,5,2,6,7,1,9],[9,7,5,3,1,4,6,8,2],[7,9,4,6,5,8,1,2,3],[6,5,2,1,3,7,9,4,8],[3,8,1,4,9,2,5,7,6]]
1713	[[7,2,9,6,3,1,8,5,4],[6,3,8,4,5,7,2,1,9],[5,4,1,2,9,8,7,3,6],[3,9,2,8,1,4,6,7,5],[1,6,5,9,7,3,4,8,2],[8,7,4,5,6,2,1,9,3],[9,1,7,3,4,6,5,2,8],[2,5,6,7,8,9,3,4,1],[4,8,3,1,2,5,9,6,7]]
1714	[[2,3,5,4,8,6,7,9,1],[1,9,8,5,7,2,3,4,6],[6,4,7,3,1,9,5,8,2],[7,5,6,1,2,4,8,3,9],[8,2,9,6,3,7,4,1,5],[4,1,3,9,5,8,6,2,7],[9,7,4,8,6,1,2,5,3],[5,6,1,2,4,3,9,7,8],[3,8,2,7,9,5,1,6,4]]
1715	[[5,1,9,4,7,6,8,3,2],[4,3,6,9,8,2,5,1,7],[7,8,2,3,5,1,4,9,6],[3,9,8,5,2,7,1,6,4],[6,7,4,1,3,8,9,2,5],[2,5,1,6,4,9,7,8,3],[9,2,3,7,1,5,6,4,8],[1,4,7,8,6,3,2,5,9],[8,6,5,2,9,4,3,7,1]]
1716	[[3,9,7,4,1,5,6,2,8],[2,6,5,7,9,8,3,1,4],[1,4,8,3,2,6,5,7,9],[6,2,4,8,3,1,9,5,7],[9,8,1,2,5,7,4,6,3],[7,5,3,6,4,9,1,8,2],[8,1,9,5,7,3,2,4,6],[5,7,2,9,6,4,8,3,1],[4,3,6,1,8,2,7,9,5]]
1717	[[7,3,9,5,1,4,2,8,6],[6,5,2,7,8,9,3,1,4],[8,1,4,3,6,2,5,9,7],[5,8,3,4,7,6,1,2,9],[4,9,6,1,2,3,7,5,8],[1,2,7,8,9,5,6,4,3],[3,4,8,6,5,1,9,7,2],[2,6,5,9,4,7,8,3,1],[9,7,1,2,3,8,4,6,5]]
1718	[[7,3,8,1,9,5,6,2,4],[4,1,6,8,2,3,5,9,7],[5,2,9,4,7,6,8,3,1],[9,6,3,5,1,2,7,4,8],[1,8,4,7,3,9,2,6,5],[2,7,5,6,4,8,3,1,9],[3,4,2,9,5,7,1,8,6],[8,9,7,2,6,1,4,5,3],[6,5,1,3,8,4,9,7,2]]
1719	[[9,3,2,6,1,4,5,7,8],[5,8,6,7,2,9,1,3,4],[4,1,7,3,8,5,2,6,9],[8,9,5,4,3,1,6,2,7],[2,7,4,5,6,8,9,1,3],[3,6,1,9,7,2,8,4,5],[6,5,9,1,4,3,7,8,2],[7,4,8,2,9,6,3,5,1],[1,2,3,8,5,7,4,9,6]]
1720	[[4,3,1,7,9,5,8,6,2],[6,9,5,1,2,8,3,4,7],[8,2,7,3,4,6,1,9,5],[7,1,4,2,6,9,5,3,8],[9,8,2,5,7,3,6,1,4],[5,6,3,8,1,4,2,7,9],[2,7,6,4,5,1,9,8,3],[1,5,8,9,3,7,4,2,6],[3,4,9,6,8,2,7,5,1]]
1721	[[6,4,2,3,1,7,9,8,5],[3,5,1,9,4,8,7,6,2],[8,7,9,2,5,6,3,1,4],[2,8,3,5,9,1,6,4,7],[7,6,5,8,3,4,2,9,1],[9,1,4,6,7,2,8,5,3],[1,3,7,4,6,9,5,2,8],[4,9,8,7,2,5,1,3,6],[5,2,6,1,8,3,4,7,9]]
1722	[[9,2,5,3,4,7,1,6,8],[8,1,3,2,9,6,4,7,5],[4,7,6,1,5,8,3,2,9],[3,5,1,6,2,4,9,8,7],[6,9,7,5,8,3,2,4,1],[2,4,8,7,1,9,5,3,6],[7,6,9,4,3,5,8,1,2],[1,8,4,9,6,2,7,5,3],[5,3,2,8,7,1,6,9,4]]
1723	[[9,3,6,8,2,4,1,7,5],[2,4,5,7,1,9,6,3,8],[7,8,1,3,6,5,2,9,4],[3,7,8,6,5,2,4,1,9],[5,9,2,4,3,1,8,6,7],[6,1,4,9,7,8,5,2,3],[8,2,7,1,4,3,9,5,6],[4,5,3,2,9,6,7,8,1],[1,6,9,5,8,7,3,4,2]]
1724	[[1,9,2,3,4,5,7,6,8],[7,5,6,1,9,8,2,3,4],[8,4,3,6,7,2,9,5,1],[9,2,1,5,8,3,4,7,6],[3,8,4,2,6,7,1,9,5],[5,6,7,4,1,9,3,8,2],[4,3,8,9,2,6,5,1,7],[2,7,5,8,3,1,6,4,9],[6,1,9,7,5,4,8,2,3]]
1725	[[8,3,4,5,1,2,7,9,6],[1,7,5,3,6,9,4,8,2],[2,9,6,8,4,7,1,3,5],[3,1,7,6,8,5,9,2,4],[4,8,9,2,3,1,5,6,7],[6,5,2,9,7,4,3,1,8],[7,6,8,4,9,3,2,5,1],[5,4,3,1,2,8,6,7,9],[9,2,1,7,5,6,8,4,3]]
1726	[[7,6,2,4,5,8,9,3,1],[5,9,4,2,1,3,7,8,6],[3,8,1,7,9,6,5,4,2],[2,3,8,6,7,4,1,9,5],[4,5,6,1,8,9,3,2,7],[1,7,9,5,3,2,8,6,4],[9,2,5,3,4,1,6,7,8],[6,1,3,8,2,7,4,5,9],[8,4,7,9,6,5,2,1,3]]
1727	[[1,6,3,8,4,2,7,9,5],[2,8,9,7,5,3,4,1,6],[5,4,7,9,1,6,2,8,3],[4,1,8,3,9,5,6,2,7],[3,7,2,4,6,8,9,5,1],[9,5,6,2,7,1,8,3,4],[6,9,1,5,2,4,3,7,8],[8,2,5,6,3,7,1,4,9],[7,3,4,1,8,9,5,6,2]]
1728	[[1,2,8,3,6,9,4,7,5],[6,4,5,8,7,2,9,3,1],[7,9,3,4,1,5,8,6,2],[3,7,1,6,5,8,2,4,9],[9,6,4,1,2,3,5,8,7],[5,8,2,7,9,4,6,1,3],[8,3,9,5,4,7,1,2,6],[2,1,7,9,8,6,3,5,4],[4,5,6,2,3,1,7,9,8]]
1729	[[6,1,4,9,3,7,8,2,5],[2,9,8,6,4,5,3,1,7],[3,5,7,8,1,2,4,9,6],[5,6,9,4,8,1,2,7,3],[7,8,3,5,2,9,6,4,1],[1,4,2,3,7,6,9,5,8],[8,7,1,2,6,4,5,3,9],[9,2,6,7,5,3,1,8,4],[4,3,5,1,9,8,7,6,2]]
1730	[[2,5,7,3,6,1,8,4,9],[6,9,4,8,2,5,3,1,7],[8,3,1,9,4,7,6,2,5],[4,8,5,2,3,9,1,7,6],[3,1,6,5,7,8,4,9,2],[9,7,2,6,1,4,5,3,8],[5,2,3,4,9,6,7,8,1],[7,4,8,1,5,2,9,6,3],[1,6,9,7,8,3,2,5,4]]
1731	[[9,5,6,1,7,4,3,8,2],[3,8,4,2,6,5,9,7,1],[7,1,2,3,9,8,6,4,5],[5,2,7,6,1,3,8,9,4],[6,4,3,5,8,9,2,1,7],[1,9,8,7,4,2,5,6,3],[2,7,1,9,5,6,4,3,8],[8,3,9,4,2,1,7,5,6],[4,6,5,8,3,7,1,2,9]]
1732	[[8,7,4,1,5,3,6,9,2],[1,2,6,9,4,7,5,8,3],[5,9,3,2,8,6,7,4,1],[4,5,9,6,2,8,3,1,7],[3,8,2,7,1,5,4,6,9],[7,6,1,4,3,9,2,5,8],[2,3,8,5,9,4,1,7,6],[6,1,5,8,7,2,9,3,4],[9,4,7,3,6,1,8,2,5]]
1733	[[5,8,3,6,9,2,7,1,4],[7,2,9,8,4,1,5,3,6],[1,4,6,5,3,7,8,2,9],[6,1,7,9,2,5,3,4,8],[3,9,4,1,8,6,2,7,5],[8,5,2,3,7,4,6,9,1],[9,7,1,2,5,8,4,6,3],[2,6,5,4,1,3,9,8,7],[4,3,8,7,6,9,1,5,2]]
1734	[[8,6,1,5,2,7,4,3,9],[5,3,2,4,9,1,7,6,8],[7,4,9,6,8,3,1,2,5],[6,7,5,9,4,2,8,1,3],[1,8,3,7,5,6,2,9,4],[9,2,4,1,3,8,6,5,7],[2,5,7,3,6,4,9,8,1],[3,1,8,2,7,9,5,4,6],[4,9,6,8,1,5,3,7,2]]
1735	[[1,3,5,6,7,9,8,2,4],[6,2,7,3,8,4,9,1,5],[8,4,9,2,5,1,6,7,3],[2,9,8,7,3,5,1,4,6],[3,6,1,4,9,8,2,5,7],[7,5,4,1,2,6,3,9,8],[4,8,6,9,1,7,5,3,2],[5,1,2,8,4,3,7,6,9],[9,7,3,5,6,2,4,8,1]]
1736	[[2,6,8,3,4,9,7,5,1],[4,7,1,5,2,6,9,3,8],[3,9,5,8,1,7,2,4,6],[1,2,6,7,9,5,3,8,4],[8,3,4,1,6,2,5,7,9],[7,5,9,4,8,3,6,1,2],[6,4,3,9,5,1,8,2,7],[5,1,2,6,7,8,4,9,3],[9,8,7,2,3,4,1,6,5]]
1737	[[7,3,4,5,9,8,2,1,6],[9,5,6,1,4,2,7,3,8],[2,1,8,6,3,7,4,5,9],[1,9,5,2,6,4,3,8,7],[8,4,2,7,1,3,9,6,5],[3,6,7,8,5,9,1,4,2],[6,8,9,4,2,1,5,7,3],[5,2,1,3,7,6,8,9,4],[4,7,3,9,8,5,6,2,1]]
1738	[[6,2,9,8,5,1,3,4,7],[4,5,3,2,7,9,6,8,1],[8,1,7,3,4,6,9,5,2],[5,9,1,6,2,3,8,7,4],[2,4,8,1,9,7,5,3,6],[3,7,6,4,8,5,1,2,9],[9,8,4,5,6,2,7,1,3],[7,3,5,9,1,4,2,6,8],[1,6,2,7,3,8,4,9,5]]
1739	[[1,3,6,5,4,2,8,7,9],[5,9,8,6,1,7,2,3,4],[2,4,7,9,8,3,1,6,5],[6,5,3,2,7,8,9,4,1],[8,7,4,1,3,9,5,2,6],[9,1,2,4,6,5,7,8,3],[7,8,5,3,9,6,4,1,2],[3,2,1,7,5,4,6,9,8],[4,6,9,8,2,1,3,5,7]]
1740	[[4,3,9,1,7,2,8,5,6],[2,7,1,5,8,6,4,3,9],[8,6,5,3,9,4,2,1,7],[9,4,7,6,1,5,3,2,8],[5,8,6,9,2,3,7,4,1],[1,2,3,8,4,7,9,6,5],[3,1,8,2,6,9,5,7,4],[7,9,2,4,5,1,6,8,3],[6,5,4,7,3,8,1,9,2]]
1741	[[7,2,9,1,3,5,4,8,6],[8,5,1,9,6,4,3,2,7],[4,6,3,7,2,8,5,1,9],[1,8,7,5,9,2,6,3,4],[6,9,5,4,8,3,2,7,1],[3,4,2,6,7,1,9,5,8],[2,3,4,8,1,6,7,9,5],[9,1,6,3,5,7,8,4,2],[5,7,8,2,4,9,1,6,3]]
1742	[[8,6,3,2,4,9,1,5,7],[7,2,4,5,1,8,6,3,9],[1,5,9,3,7,6,2,4,8],[3,4,6,9,2,7,8,1,5],[5,8,2,4,6,1,9,7,3],[9,7,1,8,5,3,4,6,2],[6,1,5,7,9,2,3,8,4],[2,3,7,1,8,4,5,9,6],[4,9,8,6,3,5,7,2,1]]
1743	[[6,8,9,5,4,3,7,1,2],[7,3,1,2,6,9,5,8,4],[5,4,2,8,1,7,9,3,6],[4,2,5,1,7,6,3,9,8],[3,1,8,9,2,5,6,4,7],[9,6,7,4,3,8,1,2,5],[2,5,6,3,8,1,4,7,9],[1,9,4,7,5,2,8,6,3],[8,7,3,6,9,4,2,5,1]]
1744	[[2,1,3,9,7,5,4,6,8],[4,8,5,2,6,3,9,7,1],[7,9,6,1,4,8,2,5,3],[6,3,4,7,2,9,8,1,5],[9,5,1,8,3,4,7,2,6],[8,7,2,5,1,6,3,9,4],[1,4,7,6,8,2,5,3,9],[3,6,9,4,5,7,1,8,2],[5,2,8,3,9,1,6,4,7]]
1745	[[8,3,2,4,9,1,7,5,6],[9,7,5,2,3,6,1,4,8],[6,4,1,5,7,8,3,9,2],[7,6,8,3,4,9,2,1,5],[1,2,4,7,8,5,9,6,3],[5,9,3,6,1,2,4,8,7],[3,1,9,8,5,7,6,2,4],[4,5,6,1,2,3,8,7,9],[2,8,7,9,6,4,5,3,1]]
1746	[[2,7,9,6,3,4,1,5,8],[8,1,6,9,7,5,2,3,4],[3,4,5,2,8,1,6,9,7],[7,2,1,4,9,8,3,6,5],[9,5,3,7,6,2,8,4,1],[6,8,4,1,5,3,7,2,9],[5,9,7,8,2,6,4,1,3],[4,3,2,5,1,7,9,8,6],[1,6,8,3,4,9,5,7,2]]
1747	[[9,7,8,2,6,1,4,5,3],[3,4,1,8,5,7,6,2,9],[5,6,2,9,4,3,1,7,8],[4,5,9,3,2,6,7,8,1],[1,3,6,5,7,8,9,4,2],[8,2,7,4,1,9,5,3,6],[7,9,3,1,8,5,2,6,4],[2,8,5,6,9,4,3,1,7],[6,1,4,7,3,2,8,9,5]]
1748	[[8,3,7,4,6,9,2,5,1],[4,2,1,8,5,7,3,6,9],[6,9,5,1,3,2,8,4,7],[2,6,4,9,7,3,1,8,5],[9,1,3,5,4,8,7,2,6],[7,5,8,2,1,6,4,9,3],[1,4,9,7,2,5,6,3,8],[3,8,2,6,9,1,5,7,4],[5,7,6,3,8,4,9,1,2]]
1749	[[9,2,6,1,7,4,8,5,3],[8,3,1,9,5,2,7,6,4],[4,5,7,3,6,8,9,2,1],[3,8,5,4,2,1,6,9,7],[2,7,4,8,9,6,1,3,5],[1,6,9,7,3,5,2,4,8],[6,1,8,5,4,9,3,7,2],[7,4,2,6,8,3,5,1,9],[5,9,3,2,1,7,4,8,6]]
1750	[[6,8,7,3,9,2,1,4,5],[5,1,4,7,8,6,3,9,2],[2,9,3,1,5,4,6,7,8],[3,2,6,9,4,8,7,5,1],[7,5,9,6,2,1,8,3,4],[1,4,8,5,7,3,2,6,9],[4,6,5,2,1,7,9,8,3],[9,3,1,8,6,5,4,2,7],[8,7,2,4,3,9,5,1,6]]
1751	[[9,5,4,3,1,6,2,8,7],[6,3,2,7,9,8,5,4,1],[1,8,7,4,2,5,3,9,6],[7,1,3,2,5,4,9,6,8],[8,6,9,1,7,3,4,2,5],[2,4,5,6,8,9,7,1,3],[4,2,8,5,3,1,6,7,9],[3,9,6,8,4,7,1,5,2],[5,7,1,9,6,2,8,3,4]]
1752	[[5,3,6,1,2,4,9,8,7],[7,4,8,5,3,9,2,1,6],[1,9,2,7,8,6,3,4,5],[2,6,4,8,7,1,5,9,3],[9,7,1,3,6,5,4,2,8],[3,8,5,4,9,2,6,7,1],[4,1,9,6,5,8,7,3,2],[8,5,7,2,4,3,1,6,9],[6,2,3,9,1,7,8,5,4]]
1753	[[9,7,8,4,5,6,2,1,3],[1,4,6,3,2,8,9,5,7],[3,5,2,1,7,9,6,4,8],[8,6,9,2,1,3,4,7,5],[4,3,7,9,6,5,1,8,2],[5,2,1,8,4,7,3,6,9],[6,8,3,5,9,4,7,2,1],[7,1,5,6,3,2,8,9,4],[2,9,4,7,8,1,5,3,6]]
1754	[[8,7,4,5,9,1,6,3,2],[2,3,5,8,6,4,1,7,9],[1,6,9,3,2,7,5,4,8],[3,4,1,2,7,5,9,8,6],[5,9,2,6,8,3,4,1,7],[6,8,7,4,1,9,3,2,5],[7,1,3,9,5,2,8,6,4],[4,5,8,7,3,6,2,9,1],[9,2,6,1,4,8,7,5,3]]
1755	[[9,7,6,5,2,1,8,4,3],[3,5,8,6,4,7,1,9,2],[1,4,2,3,9,8,7,5,6],[2,8,4,7,1,3,5,6,9],[6,9,3,8,5,4,2,7,1],[7,1,5,9,6,2,4,3,8],[5,2,1,4,3,9,6,8,7],[8,6,9,1,7,5,3,2,4],[4,3,7,2,8,6,9,1,5]]
1756	[[1,8,9,6,3,7,2,4,5],[2,5,6,1,8,4,3,9,7],[3,7,4,5,9,2,6,1,8],[4,9,2,3,5,8,1,7,6],[7,1,3,9,4,6,8,5,2],[5,6,8,2,7,1,9,3,4],[8,3,1,7,6,5,4,2,9],[6,2,7,4,1,9,5,8,3],[9,4,5,8,2,3,7,6,1]]
1757	[[5,6,1,2,9,3,8,4,7],[8,7,2,1,4,5,6,9,3],[9,4,3,7,6,8,1,5,2],[2,8,7,4,5,9,3,6,1],[3,5,6,8,2,1,4,7,9],[1,9,4,6,3,7,2,8,5],[4,2,5,3,7,6,9,1,8],[7,3,8,9,1,4,5,2,6],[6,1,9,5,8,2,7,3,4]]
1758	[[6,7,2,4,5,8,1,3,9],[5,9,4,3,1,6,2,8,7],[1,3,8,9,7,2,4,6,5],[3,8,5,2,9,1,6,7,4],[2,4,9,6,3,7,8,5,1],[7,6,1,8,4,5,3,9,2],[8,1,6,5,2,9,7,4,3],[9,2,3,7,6,4,5,1,8],[4,5,7,1,8,3,9,2,6]]
1759	[[4,7,1,8,2,3,6,5,9],[6,8,2,7,9,5,4,3,1],[3,9,5,6,1,4,8,2,7],[9,2,3,1,7,6,5,8,4],[7,4,8,9,5,2,1,6,3],[1,5,6,3,4,8,7,9,2],[2,6,7,4,8,9,3,1,5],[5,3,4,2,6,1,9,7,8],[8,1,9,5,3,7,2,4,6]]
1760	[[6,3,7,2,9,4,1,5,8],[5,2,8,1,3,7,4,6,9],[9,1,4,5,6,8,3,7,2],[3,6,1,4,8,2,7,9,5],[7,5,2,6,1,9,8,4,3],[8,4,9,7,5,3,2,1,6],[2,9,5,8,7,1,6,3,4],[1,8,6,3,4,5,9,2,7],[4,7,3,9,2,6,5,8,1]]
1761	[[4,5,6,7,3,9,8,2,1],[3,8,9,5,2,1,6,4,7],[2,1,7,6,4,8,3,5,9],[8,9,3,1,7,4,5,6,2],[6,2,1,3,8,5,9,7,4],[7,4,5,9,6,2,1,8,3],[1,6,4,8,9,7,2,3,5],[5,3,2,4,1,6,7,9,8],[9,7,8,2,5,3,4,1,6]]
1762	[[3,9,5,4,8,6,7,1,2],[2,1,6,9,3,7,8,4,5],[7,4,8,5,2,1,9,6,3],[6,3,2,1,7,8,4,5,9],[1,5,7,2,9,4,3,8,6],[9,8,4,3,6,5,1,2,7],[5,2,3,8,1,9,6,7,4],[8,7,9,6,4,2,5,3,1],[4,6,1,7,5,3,2,9,8]]
1763	[[1,5,3,8,2,4,9,6,7],[9,8,4,7,6,3,2,1,5],[7,6,2,1,5,9,4,3,8],[8,1,6,9,3,5,7,4,2],[5,4,9,2,1,7,3,8,6],[3,2,7,4,8,6,5,9,1],[4,3,5,6,7,8,1,2,9],[2,7,8,3,9,1,6,5,4],[6,9,1,5,4,2,8,7,3]]
1764	[[6,1,4,9,7,5,3,8,2],[9,3,7,2,8,4,1,5,6],[5,8,2,1,6,3,4,9,7],[7,9,6,4,3,2,8,1,5],[3,4,5,7,1,8,2,6,9],[1,2,8,5,9,6,7,4,3],[2,7,1,6,4,9,5,3,8],[8,5,9,3,2,1,6,7,4],[4,6,3,8,5,7,9,2,1]]
1765	[[3,8,4,6,2,9,1,5,7],[6,2,7,1,5,8,4,9,3],[9,1,5,7,4,3,6,8,2],[8,4,2,3,9,1,7,6,5],[7,3,9,5,6,2,8,4,1],[1,5,6,8,7,4,2,3,9],[2,9,3,4,1,6,5,7,8],[4,7,8,2,3,5,9,1,6],[5,6,1,9,8,7,3,2,4]]
1766	[[2,9,5,8,3,4,6,7,1],[1,3,4,6,9,7,5,2,8],[7,6,8,5,2,1,9,4,3],[6,5,1,2,7,8,4,3,9],[9,4,2,3,1,6,7,8,5],[8,7,3,4,5,9,2,1,6],[4,8,9,1,6,2,3,5,7],[5,1,7,9,4,3,8,6,2],[3,2,6,7,8,5,1,9,4]]
1767	[[4,1,7,8,2,9,5,3,6],[9,8,6,7,5,3,1,2,4],[2,3,5,6,1,4,9,7,8],[6,5,3,9,8,1,2,4,7],[7,2,8,4,6,5,3,9,1],[1,9,4,3,7,2,8,6,5],[5,4,2,1,9,7,6,8,3],[8,7,1,2,3,6,4,5,9],[3,6,9,5,4,8,7,1,2]]
1768	[[7,6,4,5,1,3,9,8,2],[9,8,3,2,4,7,5,1,6],[2,5,1,9,6,8,7,3,4],[8,7,2,1,5,4,6,9,3],[5,4,9,3,2,6,1,7,8],[3,1,6,7,8,9,2,4,5],[6,2,7,8,3,1,4,5,9],[1,3,5,4,9,2,8,6,7],[4,9,8,6,7,5,3,2,1]]
1769	[[6,4,3,9,7,1,8,5,2],[5,1,9,8,2,6,4,3,7],[8,2,7,3,5,4,6,9,1],[3,7,1,4,9,8,5,2,6],[9,6,5,2,1,3,7,4,8],[2,8,4,5,6,7,3,1,9],[4,5,2,6,8,9,1,7,3],[7,9,6,1,3,5,2,8,4],[1,3,8,7,4,2,9,6,5]]
1770	[[7,5,6,3,9,2,8,4,1],[2,1,9,4,8,7,6,3,5],[8,4,3,6,1,5,9,7,2],[5,2,7,1,4,8,3,9,6],[9,3,4,5,7,6,2,1,8],[1,6,8,9,2,3,4,5,7],[4,9,5,2,6,1,7,8,3],[3,7,2,8,5,4,1,6,9],[6,8,1,7,3,9,5,2,4]]
1771	[[8,9,2,6,7,3,1,5,4],[3,4,5,8,1,9,6,7,2],[7,6,1,2,4,5,9,3,8],[9,5,8,4,6,2,7,1,3],[1,7,4,3,9,8,2,6,5],[6,2,3,1,5,7,8,4,9],[4,3,6,9,2,1,5,8,7],[2,1,7,5,8,4,3,9,6],[5,8,9,7,3,6,4,2,1]]
1772	[[2,8,1,4,5,3,9,7,6],[4,5,7,6,2,9,8,3,1],[3,6,9,7,8,1,2,5,4],[1,7,3,8,6,5,4,9,2],[6,2,8,9,4,7,3,1,5],[9,4,5,1,3,2,7,6,8],[5,3,6,2,7,4,1,8,9],[7,1,2,5,9,8,6,4,3],[8,9,4,3,1,6,5,2,7]]
1773	[[7,1,4,8,2,6,5,9,3],[6,2,8,3,9,5,1,4,7],[5,3,9,1,4,7,8,6,2],[3,7,5,4,1,8,6,2,9],[8,9,1,2,6,3,4,7,5],[4,6,2,5,7,9,3,1,8],[2,5,7,6,3,4,9,8,1],[9,8,6,7,5,1,2,3,4],[1,4,3,9,8,2,7,5,6]]
1774	[[8,9,6,5,4,2,7,3,1],[4,3,5,7,6,1,9,8,2],[2,1,7,8,3,9,5,6,4],[5,2,1,3,8,6,4,7,9],[6,4,9,1,2,7,3,5,8],[7,8,3,4,9,5,1,2,6],[9,7,8,6,1,3,2,4,5],[1,5,4,2,7,8,6,9,3],[3,6,2,9,5,4,8,1,7]]
1775	[[5,4,8,1,3,2,6,7,9],[2,3,7,9,8,6,5,1,4],[6,9,1,4,7,5,2,3,8],[3,7,4,5,9,1,8,2,6],[9,2,6,7,4,8,3,5,1],[1,8,5,2,6,3,9,4,7],[4,1,3,6,5,9,7,8,2],[7,5,9,8,2,4,1,6,3],[8,6,2,3,1,7,4,9,5]]
1776	[[6,9,7,8,4,3,1,5,2],[2,1,5,7,6,9,4,3,8],[3,4,8,1,2,5,6,7,9],[9,5,4,3,1,8,7,2,6],[7,3,6,2,5,4,8,9,1],[1,8,2,9,7,6,5,4,3],[8,7,9,4,3,1,2,6,5],[4,6,3,5,8,2,9,1,7],[5,2,1,6,9,7,3,8,4]]
1777	[[8,4,2,3,6,1,7,9,5],[1,7,5,9,8,4,6,2,3],[9,6,3,5,7,2,4,1,8],[3,5,1,6,4,8,9,7,2],[2,9,4,7,3,5,1,8,6],[6,8,7,2,1,9,3,5,4],[4,1,9,8,2,3,5,6,7],[7,3,8,1,5,6,2,4,9],[5,2,6,4,9,7,8,3,1]]
1778	[[5,2,3,9,7,8,4,6,1],[7,9,6,4,2,1,8,5,3],[1,4,8,6,5,3,7,9,2],[6,1,9,3,4,5,2,8,7],[8,5,4,2,9,7,1,3,6],[3,7,2,8,1,6,5,4,9],[2,3,5,1,6,4,9,7,8],[9,6,7,5,8,2,3,1,4],[4,8,1,7,3,9,6,2,5]]
1779	[[2,1,9,4,3,5,7,6,8],[7,6,8,9,2,1,4,3,5],[3,4,5,8,6,7,2,9,1],[1,8,7,5,9,2,3,4,6],[4,9,6,1,8,3,5,7,2],[5,3,2,6,7,4,8,1,9],[6,2,4,3,1,8,9,5,7],[9,7,3,2,5,6,1,8,4],[8,5,1,7,4,9,6,2,3]]
1780	[[5,7,6,1,3,4,2,8,9],[1,3,9,5,2,8,4,6,7],[4,8,2,7,6,9,3,5,1],[9,2,7,3,5,1,6,4,8],[8,6,4,9,7,2,1,3,5],[3,1,5,8,4,6,7,9,2],[2,5,3,6,8,7,9,1,4],[7,9,8,4,1,3,5,2,6],[6,4,1,2,9,5,8,7,3]]
1781	[[2,6,9,5,4,8,1,7,3],[4,5,8,1,7,3,2,6,9],[1,3,7,9,2,6,5,8,4],[7,9,4,6,8,2,3,5,1],[6,1,3,4,5,7,9,2,8],[8,2,5,3,1,9,6,4,7],[3,4,2,7,6,1,8,9,5],[9,7,6,8,3,5,4,1,2],[5,8,1,2,9,4,7,3,6]]
1782	[[5,2,6,4,1,9,3,8,7],[7,3,9,5,2,8,4,6,1],[1,4,8,3,6,7,5,9,2],[3,8,7,2,4,6,9,1,5],[4,6,5,9,7,1,8,2,3],[9,1,2,8,3,5,7,4,6],[2,7,4,1,8,3,6,5,9],[8,5,3,6,9,2,1,7,4],[6,9,1,7,5,4,2,3,8]]
1783	[[1,3,2,6,8,9,7,4,5],[9,5,6,4,7,3,1,8,2],[8,4,7,1,5,2,9,3,6],[6,2,1,9,4,5,3,7,8],[4,8,9,3,2,7,5,6,1],[5,7,3,8,1,6,4,2,9],[3,1,8,5,6,4,2,9,7],[7,6,4,2,9,1,8,5,3],[2,9,5,7,3,8,6,1,4]]
1784	[[3,5,4,9,2,1,6,8,7],[2,7,1,6,8,5,4,3,9],[8,9,6,4,7,3,5,2,1],[9,4,2,7,5,6,8,1,3],[5,6,8,1,3,2,9,7,4],[7,1,3,8,9,4,2,5,6],[6,8,9,5,1,7,3,4,2],[4,3,7,2,6,8,1,9,5],[1,2,5,3,4,9,7,6,8]]
1785	[[5,3,6,2,9,1,8,4,7],[2,1,7,4,8,5,3,9,6],[9,4,8,3,6,7,1,5,2],[7,6,5,1,3,2,4,8,9],[1,8,4,9,7,6,2,3,5],[3,9,2,5,4,8,7,6,1],[4,5,1,8,2,9,6,7,3],[6,2,3,7,5,4,9,1,8],[8,7,9,6,1,3,5,2,4]]
1786	[[7,3,2,6,5,9,1,8,4],[6,5,4,8,2,1,9,3,7],[9,1,8,3,7,4,5,2,6],[1,8,9,2,6,7,3,4,5],[3,4,5,9,1,8,6,7,2],[2,7,6,5,4,3,8,9,1],[5,2,3,7,8,6,4,1,9],[4,9,7,1,3,5,2,6,8],[8,6,1,4,9,2,7,5,3]]
1787	[[8,5,6,7,1,9,2,3,4],[3,4,7,5,2,6,8,1,9],[9,1,2,3,4,8,6,5,7],[1,6,4,2,9,3,7,8,5],[5,7,8,1,6,4,9,2,3],[2,3,9,8,5,7,1,4,6],[6,8,5,9,3,2,4,7,1],[4,2,1,6,7,5,3,9,8],[7,9,3,4,8,1,5,6,2]]
1788	[[6,5,3,1,4,2,8,7,9],[8,1,4,9,5,7,2,3,6],[9,2,7,8,3,6,4,1,5],[1,6,8,7,9,4,3,5,2],[7,9,5,6,2,3,1,4,8],[4,3,2,5,8,1,9,6,7],[5,8,6,4,1,9,7,2,3],[3,7,1,2,6,8,5,9,4],[2,4,9,3,7,5,6,8,1]]
1789	[[1,4,9,6,3,7,8,2,5],[6,3,2,8,1,5,4,7,9],[7,5,8,2,4,9,3,1,6],[5,1,4,7,6,3,2,9,8],[3,9,6,1,8,2,7,5,4],[2,8,7,5,9,4,6,3,1],[9,7,3,4,5,8,1,6,2],[4,6,5,3,2,1,9,8,7],[8,2,1,9,7,6,5,4,3]]
1790	[[5,3,9,6,1,8,2,4,7],[8,7,4,2,5,9,6,3,1],[2,6,1,4,7,3,9,5,8],[6,9,7,8,3,1,5,2,4],[1,2,3,9,4,5,8,7,6],[4,8,5,7,6,2,1,9,3],[9,1,8,3,2,7,4,6,5],[7,5,6,1,9,4,3,8,2],[3,4,2,5,8,6,7,1,9]]
1791	[[7,1,4,9,2,6,5,3,8],[5,8,2,4,3,7,1,9,6],[6,9,3,1,8,5,2,7,4],[9,4,7,6,5,3,8,1,2],[8,6,5,7,1,2,9,4,3],[2,3,1,8,9,4,7,6,5],[4,2,8,3,7,9,6,5,1],[3,5,9,2,6,1,4,8,7],[1,7,6,5,4,8,3,2,9]]
1792	[[6,1,5,9,8,4,3,7,2],[7,9,2,1,3,5,8,4,6],[8,3,4,6,2,7,5,9,1],[1,2,9,3,7,8,6,5,4],[5,7,6,2,4,9,1,3,8],[3,4,8,5,6,1,7,2,9],[2,5,3,8,9,6,4,1,7],[4,8,1,7,5,2,9,6,3],[9,6,7,4,1,3,2,8,5]]
1793	[[9,7,5,6,4,2,8,1,3],[6,4,8,3,7,1,2,9,5],[1,2,3,8,5,9,6,4,7],[2,9,6,7,1,8,5,3,4],[8,3,1,5,9,4,7,2,6],[4,5,7,2,3,6,9,8,1],[7,6,9,1,2,3,4,5,8],[3,8,2,4,6,5,1,7,9],[5,1,4,9,8,7,3,6,2]]
1794	[[6,7,2,4,5,8,1,3,9],[5,9,1,3,2,6,7,8,4],[8,4,3,7,9,1,5,6,2],[3,8,5,2,7,9,4,1,6],[1,6,4,8,3,5,9,2,7],[9,2,7,1,6,4,3,5,8],[2,5,9,6,4,3,8,7,1],[4,1,6,5,8,7,2,9,3],[7,3,8,9,1,2,6,4,5]]
1795	[[5,7,9,1,4,2,6,3,8],[8,1,3,6,5,9,4,2,7],[2,6,4,7,8,3,5,9,1],[4,8,1,2,3,5,7,6,9],[9,5,6,8,1,7,2,4,3],[7,3,2,4,9,6,8,1,5],[6,9,8,3,7,4,1,5,2],[3,2,7,5,6,1,9,8,4],[1,4,5,9,2,8,3,7,6]]
1796	[[3,4,9,5,2,7,8,6,1],[5,1,6,9,3,8,7,2,4],[2,8,7,4,6,1,9,3,5],[1,7,5,2,9,3,4,8,6],[4,2,8,6,7,5,3,1,9],[9,6,3,8,1,4,2,5,7],[7,9,2,3,5,6,1,4,8],[6,3,4,1,8,9,5,7,2],[8,5,1,7,4,2,6,9,3]]
1797	[[5,6,1,2,4,8,7,3,9],[8,2,4,9,7,3,1,5,6],[3,9,7,5,6,1,2,8,4],[2,7,5,1,8,4,6,9,3],[9,4,6,3,2,5,8,1,7],[1,3,8,7,9,6,5,4,2],[7,1,3,6,5,9,4,2,8],[6,8,9,4,1,2,3,7,5],[4,5,2,8,3,7,9,6,1]]
1798	[[7,5,4,2,9,3,6,8,1],[9,1,6,7,4,8,3,2,5],[2,8,3,5,6,1,4,7,9],[1,2,7,8,3,6,9,5,4],[3,4,5,1,7,9,8,6,2],[6,9,8,4,2,5,1,3,7],[4,3,9,6,5,2,7,1,8],[5,6,1,9,8,7,2,4,3],[8,7,2,3,1,4,5,9,6]]
1799	[[8,5,3,2,9,6,4,1,7],[7,1,2,4,8,5,6,9,3],[9,4,6,1,3,7,5,2,8],[2,7,5,8,4,3,1,6,9],[3,9,4,7,6,1,2,8,5],[6,8,1,5,2,9,7,3,4],[1,2,9,3,7,4,8,5,6],[5,6,7,9,1,8,3,4,2],[4,3,8,6,5,2,9,7,1]]
1800	[[2,1,5,7,8,4,9,3,6],[8,7,9,1,3,6,4,2,5],[4,6,3,5,9,2,7,8,1],[7,5,1,8,6,9,3,4,2],[9,4,6,3,2,7,1,5,8],[3,2,8,4,5,1,6,9,7],[5,8,7,9,1,3,2,6,4],[1,3,2,6,4,8,5,7,9],[6,9,4,2,7,5,8,1,3]]
1801	[[3,1,6,8,4,2,5,9,7],[8,7,2,1,5,9,3,4,6],[5,9,4,7,6,3,8,1,2],[7,6,9,5,2,4,1,3,8],[1,5,8,9,3,7,2,6,4],[2,4,3,6,8,1,9,7,5],[4,2,1,3,7,5,6,8,9],[9,8,7,2,1,6,4,5,3],[6,3,5,4,9,8,7,2,1]]
1802	[[3,5,4,1,7,2,8,9,6],[7,2,6,8,9,3,5,1,4],[8,9,1,4,5,6,7,2,3],[5,4,9,3,1,8,2,6,7],[1,3,2,7,6,4,9,8,5],[6,8,7,5,2,9,3,4,1],[9,1,3,6,8,7,4,5,2],[2,7,5,9,4,1,6,3,8],[4,6,8,2,3,5,1,7,9]]
1803	[[1,4,9,5,6,2,7,8,3],[7,5,6,8,3,4,2,1,9],[2,3,8,7,1,9,6,5,4],[4,2,5,3,9,8,1,6,7],[9,7,3,1,2,6,5,4,8],[6,8,1,4,7,5,3,9,2],[8,1,4,2,5,7,9,3,6],[3,9,2,6,4,1,8,7,5],[5,6,7,9,8,3,4,2,1]]
1804	[[3,1,4,7,6,2,8,9,5],[2,8,5,9,4,1,7,6,3],[9,6,7,8,5,3,4,1,2],[1,3,9,2,8,5,6,4,7],[5,2,6,4,1,7,9,3,8],[7,4,8,3,9,6,2,5,1],[6,7,2,1,3,9,5,8,4],[4,5,1,6,7,8,3,2,9],[8,9,3,5,2,4,1,7,6]]
1805	[[9,5,6,7,1,8,2,3,4],[3,7,2,4,9,5,1,8,6],[1,8,4,2,6,3,9,5,7],[4,2,8,9,3,7,6,1,5],[5,1,7,6,8,2,4,9,3],[6,9,3,1,5,4,7,2,8],[8,4,9,3,7,1,5,6,2],[2,3,1,5,4,6,8,7,9],[7,6,5,8,2,9,3,4,1]]
1806	[[1,8,9,6,7,5,2,3,4],[3,2,5,4,8,9,6,1,7],[4,7,6,3,2,1,5,9,8],[9,1,3,7,6,4,8,5,2],[8,5,4,9,3,2,7,6,1],[7,6,2,1,5,8,9,4,3],[5,9,7,8,1,3,4,2,6],[2,3,8,5,4,6,1,7,9],[6,4,1,2,9,7,3,8,5]]
1807	[[9,3,5,7,1,8,4,2,6],[2,4,7,5,9,6,3,1,8],[6,8,1,3,2,4,7,5,9],[7,6,2,8,3,1,9,4,5],[4,5,9,2,6,7,8,3,1],[3,1,8,9,4,5,6,7,2],[1,9,3,6,7,2,5,8,4],[8,2,6,4,5,3,1,9,7],[5,7,4,1,8,9,2,6,3]]
1808	[[4,5,9,6,7,2,8,3,1],[1,3,7,4,9,8,6,2,5],[2,6,8,1,3,5,9,4,7],[8,1,6,7,4,3,5,9,2],[9,4,3,5,2,6,1,7,8],[7,2,5,8,1,9,4,6,3],[3,8,1,9,6,7,2,5,4],[6,7,4,2,5,1,3,8,9],[5,9,2,3,8,4,7,1,6]]
1809	[[1,4,3,9,5,8,7,2,6],[6,2,5,3,7,1,9,8,4],[7,9,8,4,6,2,1,5,3],[3,1,9,2,4,7,8,6,5],[4,8,2,6,1,5,3,7,9],[5,7,6,8,9,3,2,4,1],[9,5,1,7,2,4,6,3,8],[8,6,7,5,3,9,4,1,2],[2,3,4,1,8,6,5,9,7]]
1810	[[1,8,2,7,6,9,3,4,5],[6,4,3,2,5,8,7,9,1],[5,9,7,4,1,3,6,2,8],[4,3,6,9,8,1,5,7,2],[8,5,9,3,7,2,1,6,4],[7,2,1,5,4,6,8,3,9],[2,1,5,6,9,7,4,8,3],[9,6,4,8,3,5,2,1,7],[3,7,8,1,2,4,9,5,6]]
1811	[[9,1,8,4,3,2,7,6,5],[6,7,5,8,1,9,4,3,2],[2,4,3,7,5,6,8,1,9],[5,2,9,6,7,8,3,4,1],[3,6,7,1,4,5,2,9,8],[4,8,1,2,9,3,5,7,6],[7,9,6,5,2,4,1,8,3],[1,3,2,9,8,7,6,5,4],[8,5,4,3,6,1,9,2,7]]
1812	[[8,1,2,5,9,6,4,3,7],[9,7,4,3,8,1,2,6,5],[3,5,6,2,7,4,9,1,8],[2,6,5,1,4,3,7,8,9],[7,4,9,6,2,8,1,5,3],[1,8,3,7,5,9,6,2,4],[5,3,7,9,1,2,8,4,6],[4,9,1,8,6,5,3,7,2],[6,2,8,4,3,7,5,9,1]]
1813	[[3,1,6,7,5,9,2,8,4],[5,7,8,6,4,2,9,1,3],[4,2,9,3,1,8,5,7,6],[2,5,7,1,3,6,4,9,8],[9,3,1,8,2,4,7,6,5],[8,6,4,5,9,7,3,2,1],[1,9,2,4,8,3,6,5,7],[6,4,5,2,7,1,8,3,9],[7,8,3,9,6,5,1,4,2]]
1814	[[3,6,8,4,7,9,1,2,5],[1,7,4,5,6,2,3,9,8],[2,9,5,1,8,3,7,4,6],[4,8,9,6,1,7,2,5,3],[5,2,6,8,3,4,9,1,7],[7,1,3,2,9,5,8,6,4],[9,4,1,7,5,8,6,3,2],[6,5,7,3,2,1,4,8,9],[8,3,2,9,4,6,5,7,1]]
1815	[[5,2,8,4,7,1,3,6,9],[9,6,1,8,3,5,4,2,7],[7,3,4,6,9,2,5,1,8],[2,4,3,5,1,7,8,9,6],[6,7,9,3,8,4,1,5,2],[1,8,5,9,2,6,7,3,4],[3,5,6,2,4,8,9,7,1],[4,1,2,7,5,9,6,8,3],[8,9,7,1,6,3,2,4,5]]
1816	[[5,3,4,7,8,9,2,6,1],[1,8,6,5,2,3,4,7,9],[9,2,7,1,4,6,8,5,3],[3,4,8,9,7,5,6,1,2],[7,6,1,2,3,4,5,9,8],[2,9,5,6,1,8,3,4,7],[6,5,2,8,9,7,1,3,4],[4,1,9,3,6,2,7,8,5],[8,7,3,4,5,1,9,2,6]]
1817	[[1,2,5,8,4,6,9,3,7],[4,9,7,2,1,3,8,6,5],[3,8,6,5,9,7,4,1,2],[5,6,3,7,2,8,1,9,4],[7,1,8,4,6,9,2,5,3],[2,4,9,1,3,5,7,8,6],[8,7,4,3,5,1,6,2,9],[9,3,1,6,7,2,5,4,8],[6,5,2,9,8,4,3,7,1]]
1818	[[7,1,9,3,6,5,4,2,8],[5,2,8,9,4,1,3,7,6],[6,3,4,8,7,2,5,9,1],[3,7,5,4,8,6,2,1,9],[1,9,6,5,2,7,8,3,4],[8,4,2,1,3,9,6,5,7],[2,8,7,6,1,3,9,4,5],[4,5,1,2,9,8,7,6,3],[9,6,3,7,5,4,1,8,2]]
1819	[[5,3,9,7,1,6,2,4,8],[2,7,6,8,3,4,5,1,9],[4,8,1,2,9,5,3,6,7],[8,9,4,1,5,7,6,2,3],[3,5,7,9,6,2,1,8,4],[6,1,2,3,4,8,9,7,5],[9,6,5,4,7,1,8,3,2],[1,4,8,5,2,3,7,9,6],[7,2,3,6,8,9,4,5,1]]
1820	[[7,9,6,1,5,4,8,2,3],[4,5,3,8,9,2,1,6,7],[2,8,1,7,6,3,4,5,9],[5,1,7,6,4,8,3,9,2],[6,2,8,9,3,5,7,1,4],[9,3,4,2,1,7,6,8,5],[8,7,9,4,2,1,5,3,6],[1,6,5,3,7,9,2,4,8],[3,4,2,5,8,6,9,7,1]]
1821	[[7,5,8,1,2,3,9,6,4],[6,3,2,4,9,8,5,1,7],[9,4,1,7,5,6,3,8,2],[3,2,5,9,7,1,6,4,8],[1,7,9,8,6,4,2,5,3],[8,6,4,2,3,5,7,9,1],[5,1,6,3,4,7,8,2,9],[4,9,3,6,8,2,1,7,5],[2,8,7,5,1,9,4,3,6]]
1822	[[9,2,3,6,1,4,5,8,7],[5,6,8,9,7,2,1,3,4],[1,4,7,3,5,8,6,2,9],[6,5,4,2,8,1,9,7,3],[8,9,2,7,3,6,4,5,1],[3,7,1,4,9,5,2,6,8],[2,8,9,1,6,7,3,4,5],[4,3,5,8,2,9,7,1,6],[7,1,6,5,4,3,8,9,2]]
1823	[[8,3,4,9,5,6,7,1,2],[1,5,9,3,7,2,8,4,6],[6,2,7,1,8,4,3,5,9],[4,8,6,5,9,3,1,2,7],[2,1,5,8,6,7,9,3,4],[9,7,3,4,2,1,5,6,8],[7,9,2,6,1,5,4,8,3],[5,4,8,2,3,9,6,7,1],[3,6,1,7,4,8,2,9,5]]
1824	[[7,1,5,3,6,2,8,9,4],[8,4,2,7,5,9,6,3,1],[6,3,9,8,4,1,2,7,5],[1,6,4,9,8,3,7,5,2],[9,2,8,4,7,5,1,6,3],[3,5,7,1,2,6,4,8,9],[5,7,6,2,3,4,9,1,8],[4,8,1,5,9,7,3,2,6],[2,9,3,6,1,8,5,4,7]]
1825	[[5,7,6,1,8,3,4,2,9],[4,8,1,2,9,7,6,3,5],[3,9,2,5,6,4,1,7,8],[8,5,7,9,3,1,2,4,6],[2,4,3,6,7,8,5,9,1],[6,1,9,4,5,2,7,8,3],[1,2,5,3,4,9,8,6,7],[9,6,8,7,2,5,3,1,4],[7,3,4,8,1,6,9,5,2]]
1826	[[1,9,5,8,3,2,4,6,7],[8,4,7,6,5,1,3,9,2],[2,6,3,4,7,9,8,5,1],[3,7,4,5,6,8,1,2,9],[5,8,2,1,9,4,7,3,6],[6,1,9,7,2,3,5,4,8],[9,3,1,2,8,5,6,7,4],[4,2,6,3,1,7,9,8,5],[7,5,8,9,4,6,2,1,3]]
1827	[[7,6,2,4,8,3,1,9,5],[4,9,3,6,5,1,8,7,2],[8,1,5,2,9,7,3,4,6],[6,7,4,1,3,8,5,2,9],[2,3,1,9,4,5,7,6,8],[9,5,8,7,2,6,4,1,3],[5,2,9,8,1,4,6,3,7],[1,8,6,3,7,2,9,5,4],[3,4,7,5,6,9,2,8,1]]
1828	[[6,4,9,1,2,7,8,5,3],[2,3,1,6,8,5,7,9,4],[8,5,7,9,4,3,6,1,2],[3,8,6,2,5,9,1,4,7],[5,9,4,7,1,6,3,2,8],[7,1,2,8,3,4,5,6,9],[9,2,5,3,7,1,4,8,6],[4,7,8,5,6,2,9,3,1],[1,6,3,4,9,8,2,7,5]]
1829	[[8,5,7,3,1,4,6,2,9],[3,4,1,9,6,2,5,8,7],[6,2,9,8,5,7,1,4,3],[1,3,5,2,4,8,7,9,6],[7,8,6,1,9,3,4,5,2],[4,9,2,5,7,6,3,1,8],[9,7,3,4,8,1,2,6,5],[5,6,4,7,2,9,8,3,1],[2,1,8,6,3,5,9,7,4]]
1830	[[4,1,3,7,9,2,5,6,8],[5,7,2,6,1,8,3,9,4],[6,8,9,5,4,3,7,1,2],[2,4,6,9,7,5,8,3,1],[8,9,7,2,3,1,4,5,6],[1,3,5,4,8,6,2,7,9],[3,6,1,8,5,4,9,2,7],[9,5,8,1,2,7,6,4,3],[7,2,4,3,6,9,1,8,5]]
1831	[[6,4,1,8,9,2,3,7,5],[8,3,7,1,5,4,2,9,6],[5,2,9,7,6,3,4,1,8],[9,5,8,3,1,7,6,4,2],[3,7,6,4,2,5,9,8,1],[2,1,4,9,8,6,7,5,3],[4,8,3,2,7,1,5,6,9],[7,9,5,6,3,8,1,2,4],[1,6,2,5,4,9,8,3,7]]
1832	[[9,4,1,8,2,5,3,6,7],[5,6,3,7,4,9,1,2,8],[2,7,8,3,6,1,4,5,9],[7,5,2,6,3,8,9,4,1],[3,1,4,5,9,2,8,7,6],[8,9,6,1,7,4,2,3,5],[6,2,9,4,1,7,5,8,3],[4,3,5,9,8,6,7,1,2],[1,8,7,2,5,3,6,9,4]]
1833	[[9,6,5,8,2,1,4,7,3],[7,2,4,3,5,6,1,9,8],[8,3,1,4,9,7,2,6,5],[1,9,2,6,8,4,3,5,7],[3,7,8,5,1,9,6,2,4],[4,5,6,2,7,3,8,1,9],[5,8,7,1,3,2,9,4,6],[6,1,3,9,4,5,7,8,2],[2,4,9,7,6,8,5,3,1]]
1834	[[2,8,1,3,6,9,7,4,5],[6,5,7,4,8,2,1,9,3],[4,3,9,5,7,1,8,2,6],[1,2,4,7,9,5,3,6,8],[5,6,3,2,1,8,9,7,4],[9,7,8,6,3,4,5,1,2],[3,9,6,8,2,7,4,5,1],[8,1,5,9,4,6,2,3,7],[7,4,2,1,5,3,6,8,9]]
1835	[[8,2,4,9,1,3,5,6,7],[7,3,5,2,6,8,9,1,4],[1,9,6,7,4,5,3,2,8],[4,6,3,8,5,1,2,7,9],[5,1,2,3,7,9,4,8,6],[9,7,8,4,2,6,1,3,5],[2,5,1,6,8,4,7,9,3],[6,4,9,1,3,7,8,5,2],[3,8,7,5,9,2,6,4,1]]
1836	[[7,2,9,1,5,8,6,4,3],[4,8,3,6,2,9,1,5,7],[1,6,5,3,4,7,8,2,9],[3,4,2,7,1,6,5,9,8],[8,9,7,4,3,5,2,1,6],[5,1,6,9,8,2,7,3,4],[2,7,4,5,6,3,9,8,1],[9,5,1,8,7,4,3,6,2],[6,3,8,2,9,1,4,7,5]]
1837	[[2,4,5,1,3,8,7,9,6],[9,1,7,4,6,2,3,8,5],[3,6,8,7,9,5,4,1,2],[1,2,3,9,5,7,6,4,8],[8,9,6,3,2,4,1,5,7],[5,7,4,8,1,6,2,3,9],[7,5,1,6,8,3,9,2,4],[4,8,9,2,7,1,5,6,3],[6,3,2,5,4,9,8,7,1]]
1838	[[4,3,6,9,8,1,7,5,2],[8,1,9,7,2,5,3,4,6],[5,7,2,3,4,6,9,1,8],[1,6,4,2,5,3,8,9,7],[9,2,3,1,7,8,4,6,5],[7,5,8,4,6,9,2,3,1],[2,4,5,6,9,7,1,8,3],[6,9,1,8,3,2,5,7,4],[3,8,7,5,1,4,6,2,9]]
1839	[[4,8,1,9,2,6,5,7,3],[7,3,2,5,4,1,9,8,6],[6,9,5,3,7,8,1,4,2],[5,6,4,1,8,9,3,2,7],[2,1,9,7,6,3,4,5,8],[3,7,8,4,5,2,6,9,1],[8,2,3,6,9,5,7,1,4],[1,5,7,2,3,4,8,6,9],[9,4,6,8,1,7,2,3,5]]
1840	[[1,9,6,2,5,4,7,8,3],[2,8,3,6,9,7,4,1,5],[4,7,5,3,8,1,2,6,9],[3,4,2,5,1,9,6,7,8],[5,1,8,7,3,6,9,4,2],[7,6,9,4,2,8,5,3,1],[8,2,7,1,6,5,3,9,4],[9,5,4,8,7,3,1,2,6],[6,3,1,9,4,2,8,5,7]]
1841	[[5,7,9,8,6,1,3,2,4],[8,3,1,2,4,5,7,9,6],[6,2,4,3,9,7,5,1,8],[7,6,5,9,2,3,4,8,1],[9,4,3,1,5,8,6,7,2],[2,1,8,6,7,4,9,3,5],[1,9,6,4,3,2,8,5,7],[3,5,2,7,8,6,1,4,9],[4,8,7,5,1,9,2,6,3]]
1842	[[2,1,4,3,7,9,5,6,8],[3,9,5,6,8,2,1,7,4],[6,8,7,4,5,1,3,2,9],[7,6,8,9,3,5,2,4,1],[4,2,3,8,1,7,6,9,5],[9,5,1,2,4,6,8,3,7],[1,4,6,7,2,8,9,5,3],[8,3,2,5,9,4,7,1,6],[5,7,9,1,6,3,4,8,2]]
1843	[[8,9,7,4,3,6,5,1,2],[2,5,6,1,9,8,7,3,4],[4,3,1,2,5,7,9,6,8],[7,2,4,6,1,3,8,5,9],[5,8,3,9,2,4,6,7,1],[6,1,9,8,7,5,2,4,3],[3,6,2,5,4,9,1,8,7],[9,7,5,3,8,1,4,2,6],[1,4,8,7,6,2,3,9,5]]
1844	[[3,6,1,8,4,7,5,2,9],[2,8,5,9,1,6,4,7,3],[9,4,7,2,5,3,6,8,1],[4,1,2,6,3,5,7,9,8],[8,7,3,4,2,9,1,5,6],[5,9,6,7,8,1,3,4,2],[6,5,4,1,9,8,2,3,7],[1,2,9,3,7,4,8,6,5],[7,3,8,5,6,2,9,1,4]]
1845	[[1,6,7,8,4,2,9,5,3],[9,8,2,5,3,7,6,4,1],[5,3,4,9,1,6,8,2,7],[6,5,9,1,2,4,3,7,8],[7,4,3,6,9,8,2,1,5],[2,1,8,3,7,5,4,9,6],[3,9,5,4,8,1,7,6,2],[4,7,1,2,6,3,5,8,9],[8,2,6,7,5,9,1,3,4]]
1846	[[3,1,5,9,8,7,4,2,6],[7,6,4,2,5,3,8,1,9],[2,9,8,1,4,6,7,5,3],[8,2,6,4,3,1,9,7,5],[1,3,9,6,7,5,2,8,4],[5,4,7,8,2,9,3,6,1],[4,5,1,7,9,8,6,3,2],[6,8,2,3,1,4,5,9,7],[9,7,3,5,6,2,1,4,8]]
1847	[[8,3,9,4,7,2,6,1,5],[6,1,7,5,9,3,2,8,4],[2,5,4,6,8,1,7,9,3],[9,2,8,3,6,7,5,4,1],[4,6,3,1,2,5,9,7,8],[1,7,5,8,4,9,3,2,6],[3,9,1,2,5,4,8,6,7],[5,8,2,7,1,6,4,3,9],[7,4,6,9,3,8,1,5,2]]
1848	[[2,8,6,3,1,5,4,9,7],[1,9,3,7,4,8,6,2,5],[5,7,4,6,2,9,3,1,8],[8,6,2,9,7,3,1,5,4],[7,5,9,4,8,1,2,3,6],[3,4,1,2,5,6,8,7,9],[6,3,5,8,9,2,7,4,1],[4,1,8,5,3,7,9,6,2],[9,2,7,1,6,4,5,8,3]]
1849	[[7,8,5,9,4,3,1,2,6],[1,9,3,2,8,6,7,4,5],[2,6,4,7,5,1,9,8,3],[6,1,8,4,7,5,3,9,2],[4,2,7,1,3,9,6,5,8],[3,5,9,8,6,2,4,1,7],[9,3,2,5,1,7,8,6,4],[5,4,6,3,9,8,2,7,1],[8,7,1,6,2,4,5,3,9]]
1850	[[7,9,2,3,6,5,1,4,8],[6,1,8,9,4,2,7,5,3],[3,5,4,8,7,1,9,6,2],[8,7,9,6,5,3,2,1,4],[5,2,6,4,1,8,3,9,7],[4,3,1,2,9,7,6,8,5],[2,4,7,1,8,9,5,3,6],[9,6,3,5,2,4,8,7,1],[1,8,5,7,3,6,4,2,9]]
1851	[[3,8,6,9,1,7,5,4,2],[1,9,5,4,2,6,7,8,3],[4,2,7,3,5,8,9,1,6],[6,3,8,7,4,9,2,5,1],[2,7,9,1,3,5,8,6,4],[5,4,1,8,6,2,3,9,7],[7,1,4,5,9,3,6,2,8],[9,6,3,2,8,4,1,7,5],[8,5,2,6,7,1,4,3,9]]
1852	[[9,3,5,2,7,4,6,8,1],[4,2,7,1,6,8,3,9,5],[8,6,1,9,3,5,2,4,7],[3,5,9,7,8,1,4,2,6],[6,1,4,5,9,2,7,3,8],[7,8,2,6,4,3,1,5,9],[2,7,8,4,1,9,5,6,3],[1,4,3,8,5,6,9,7,2],[5,9,6,3,2,7,8,1,4]]
1853	[[1,6,2,7,4,9,5,3,8],[4,7,3,5,1,8,6,9,2],[9,8,5,6,2,3,4,1,7],[2,5,6,3,8,7,9,4,1],[3,4,9,1,5,2,7,8,6],[8,1,7,9,6,4,3,2,5],[5,2,1,4,9,6,8,7,3],[6,3,4,8,7,1,2,5,9],[7,9,8,2,3,5,1,6,4]]
1854	[[3,4,7,1,6,8,9,2,5],[6,9,8,5,2,4,7,1,3],[2,1,5,7,3,9,4,6,8],[8,7,1,4,5,2,3,9,6],[5,3,2,9,7,6,8,4,1],[4,6,9,3,8,1,5,7,2],[7,8,4,2,1,3,6,5,9],[9,2,3,6,4,5,1,8,7],[1,5,6,8,9,7,2,3,4]]
1855	[[4,7,9,5,3,2,1,6,8],[8,5,6,1,7,9,3,4,2],[1,2,3,8,4,6,9,5,7],[9,6,2,4,1,7,5,8,3],[3,1,5,9,6,8,7,2,4],[7,8,4,3,2,5,6,9,1],[5,9,7,2,8,1,4,3,6],[2,4,1,6,5,3,8,7,9],[6,3,8,7,9,4,2,1,5]]
1856	[[2,4,9,6,8,1,5,3,7],[5,7,8,9,3,4,1,6,2],[3,1,6,5,2,7,8,4,9],[8,6,1,3,4,9,7,2,5],[9,3,7,8,5,2,6,1,4],[4,2,5,7,1,6,3,9,8],[7,5,2,1,9,3,4,8,6],[1,8,4,2,6,5,9,7,3],[6,9,3,4,7,8,2,5,1]]
1857	[[1,6,2,5,9,4,7,8,3],[7,5,3,1,8,6,2,4,9],[4,9,8,7,3,2,1,5,6],[2,4,1,3,6,8,9,7,5],[5,3,9,2,4,7,6,1,8],[8,7,6,9,1,5,3,2,4],[3,1,5,8,2,9,4,6,7],[6,2,7,4,5,3,8,9,1],[9,8,4,6,7,1,5,3,2]]
1858	[[5,1,3,7,6,9,4,8,2],[6,9,8,4,2,1,7,5,3],[2,7,4,8,3,5,6,9,1],[7,8,5,1,9,4,3,2,6],[1,4,2,3,8,6,5,7,9],[3,6,9,5,7,2,8,1,4],[9,5,7,6,1,3,2,4,8],[4,3,1,2,5,8,9,6,7],[8,2,6,9,4,7,1,3,5]]
1859	[[7,8,1,4,2,5,6,3,9],[4,5,9,6,1,3,7,2,8],[2,3,6,7,9,8,1,4,5],[8,4,2,3,5,6,9,1,7],[9,6,7,2,4,1,5,8,3],[5,1,3,9,8,7,4,6,2],[1,7,5,8,6,2,3,9,4],[6,9,8,5,3,4,2,7,1],[3,2,4,1,7,9,8,5,6]]
1860	[[1,6,4,9,5,3,7,8,2],[5,7,9,8,4,2,6,1,3],[3,8,2,6,7,1,4,9,5],[4,2,7,5,8,9,1,3,6],[9,3,8,1,6,4,2,5,7],[6,1,5,3,2,7,9,4,8],[8,4,3,2,9,6,5,7,1],[7,5,6,4,1,8,3,2,9],[2,9,1,7,3,5,8,6,4]]
1861	[[6,9,4,5,3,8,7,1,2],[2,7,5,1,4,6,3,9,8],[8,3,1,7,9,2,6,4,5],[4,8,9,3,2,7,1,5,6],[3,1,2,9,6,5,4,8,7],[7,5,6,8,1,4,9,2,3],[1,6,3,2,5,9,8,7,4],[9,2,8,4,7,3,5,6,1],[5,4,7,6,8,1,2,3,9]]
1862	[[9,7,4,5,6,8,3,1,2],[2,3,6,4,1,9,7,8,5],[5,1,8,7,2,3,9,4,6],[3,9,1,2,7,5,4,6,8],[6,5,7,3,8,4,1,2,9],[4,8,2,1,9,6,5,7,3],[8,6,5,9,4,7,2,3,1],[7,2,3,8,5,1,6,9,4],[1,4,9,6,3,2,8,5,7]]
1863	[[1,7,8,3,4,9,2,6,5],[9,5,6,7,1,2,3,4,8],[2,3,4,5,6,8,9,7,1],[5,1,3,2,7,4,6,8,9],[4,9,2,8,5,6,1,3,7],[8,6,7,9,3,1,4,5,2],[6,2,5,1,8,3,7,9,4],[3,8,9,4,2,7,5,1,6],[7,4,1,6,9,5,8,2,3]]
1864	[[2,8,9,6,7,5,3,4,1],[6,1,4,9,3,2,8,5,7],[7,3,5,8,1,4,9,6,2],[3,4,1,5,8,6,7,2,9],[5,7,2,4,9,3,6,1,8],[8,9,6,1,2,7,5,3,4],[4,2,3,7,5,8,1,9,6],[1,5,8,2,6,9,4,7,3],[9,6,7,3,4,1,2,8,5]]
1865	[[2,7,8,1,6,4,3,5,9],[6,3,4,8,5,9,7,1,2],[5,1,9,2,3,7,6,4,8],[3,9,1,5,7,8,2,6,4],[8,5,6,4,9,2,1,3,7],[4,2,7,3,1,6,9,8,5],[1,4,2,9,8,3,5,7,6],[7,8,3,6,2,5,4,9,1],[9,6,5,7,4,1,8,2,3]]
1866	[[1,9,6,7,4,3,2,5,8],[3,2,5,9,1,8,6,7,4],[4,8,7,6,2,5,3,1,9],[8,1,3,5,6,2,4,9,7],[2,5,4,8,9,7,1,3,6],[7,6,9,4,3,1,8,2,5],[9,3,8,2,5,4,7,6,1],[6,7,1,3,8,9,5,4,2],[5,4,2,1,7,6,9,8,3]]
1867	[[9,1,3,7,6,4,2,8,5],[4,8,5,2,3,9,7,6,1],[7,6,2,1,8,5,4,9,3],[3,4,1,9,5,6,8,7,2],[6,5,7,8,2,3,9,1,4],[2,9,8,4,1,7,3,5,6],[5,2,6,3,7,8,1,4,9],[8,3,4,6,9,1,5,2,7],[1,7,9,5,4,2,6,3,8]]
1868	[[2,5,3,9,4,6,1,7,8],[7,6,9,2,1,8,4,3,5],[1,8,4,3,7,5,9,6,2],[4,9,6,7,8,2,3,5,1],[5,1,8,4,6,3,2,9,7],[3,2,7,1,5,9,6,8,4],[8,4,5,6,3,1,7,2,9],[9,3,1,5,2,7,8,4,6],[6,7,2,8,9,4,5,1,3]]
1869	[[4,5,6,2,1,3,9,8,7],[7,1,3,6,9,8,4,5,2],[8,2,9,4,7,5,6,1,3],[9,6,1,5,8,2,3,7,4],[2,8,4,7,3,1,5,6,9],[5,3,7,9,4,6,8,2,1],[1,4,5,3,6,7,2,9,8],[3,7,2,8,5,9,1,4,6],[6,9,8,1,2,4,7,3,5]]
1870	[[5,2,3,4,8,1,9,7,6],[1,6,4,9,3,7,8,2,5],[7,8,9,5,6,2,4,3,1],[6,9,1,2,7,3,5,4,8],[2,5,8,1,4,9,3,6,7],[4,3,7,6,5,8,1,9,2],[8,4,5,3,2,6,7,1,9],[3,1,2,7,9,5,6,8,4],[9,7,6,8,1,4,2,5,3]]
1871	[[5,2,6,8,4,9,3,1,7],[1,9,8,2,7,3,5,6,4],[3,7,4,6,1,5,8,9,2],[8,4,5,1,3,6,7,2,9],[7,6,9,5,2,4,1,8,3],[2,3,1,7,9,8,6,4,5],[4,5,2,3,8,1,9,7,6],[9,1,3,4,6,7,2,5,8],[6,8,7,9,5,2,4,3,1]]
1872	[[8,6,9,3,5,4,1,2,7],[1,5,7,9,2,8,3,4,6],[2,3,4,6,1,7,8,5,9],[4,7,8,2,3,1,9,6,5],[5,2,6,4,8,9,7,1,3],[3,9,1,7,6,5,2,8,4],[7,8,3,5,4,2,6,9,1],[6,4,2,1,9,3,5,7,8],[9,1,5,8,7,6,4,3,2]]
1873	[[9,2,1,8,4,3,7,6,5],[3,6,4,7,5,1,9,8,2],[7,8,5,6,2,9,3,4,1],[2,9,3,5,1,6,8,7,4],[1,7,6,9,8,4,5,2,3],[4,5,8,2,3,7,6,1,9],[5,1,2,3,6,8,4,9,7],[8,4,7,1,9,5,2,3,6],[6,3,9,4,7,2,1,5,8]]
1874	[[6,8,9,3,4,2,1,7,5],[7,3,5,6,9,1,8,2,4],[1,2,4,5,8,7,6,3,9],[5,1,2,8,7,9,3,4,6],[8,9,7,4,6,3,2,5,1],[3,4,6,2,1,5,7,9,8],[2,7,1,9,5,6,4,8,3],[9,6,8,7,3,4,5,1,2],[4,5,3,1,2,8,9,6,7]]
1875	[[6,1,2,5,7,8,4,9,3],[8,7,4,3,9,2,1,5,6],[5,3,9,6,1,4,7,2,8],[1,9,3,4,5,7,8,6,2],[4,2,5,8,6,3,9,1,7],[7,6,8,9,2,1,3,4,5],[2,4,6,7,3,9,5,8,1],[3,8,1,2,4,5,6,7,9],[9,5,7,1,8,6,2,3,4]]
1876	[[2,5,3,6,4,7,8,9,1],[4,8,6,2,9,1,5,3,7],[9,7,1,3,5,8,2,6,4],[3,4,8,1,2,5,6,7,9],[7,6,2,4,3,9,1,8,5],[5,1,9,7,8,6,4,2,3],[1,2,4,8,7,3,9,5,6],[6,3,5,9,1,2,7,4,8],[8,9,7,5,6,4,3,1,2]]
1877	[[9,5,4,3,8,7,1,2,6],[7,6,8,4,2,1,5,9,3],[3,2,1,9,5,6,4,7,8],[1,9,7,8,3,5,6,4,2],[8,4,5,7,6,2,3,1,9],[6,3,2,1,9,4,8,5,7],[2,8,6,5,4,9,7,3,1],[5,1,9,6,7,3,2,8,4],[4,7,3,2,1,8,9,6,5]]
1878	[[7,1,6,8,2,3,9,5,4],[5,2,8,6,4,9,1,3,7],[4,3,9,1,7,5,2,6,8],[1,6,2,3,5,4,8,7,9],[3,9,4,7,8,1,5,2,6],[8,5,7,2,9,6,4,1,3],[6,8,3,4,1,2,7,9,5],[2,4,5,9,6,7,3,8,1],[9,7,1,5,3,8,6,4,2]]
1879	[[8,6,5,2,7,1,4,3,9],[7,9,4,5,8,3,6,2,1],[1,2,3,6,9,4,8,7,5],[4,1,9,8,3,2,7,5,6],[6,3,2,1,5,7,9,4,8],[5,8,7,4,6,9,3,1,2],[2,7,8,3,1,6,5,9,4],[3,4,6,9,2,5,1,8,7],[9,5,1,7,4,8,2,6,3]]
1880	[[5,9,8,2,6,3,4,1,7],[6,1,7,9,4,5,3,2,8],[2,3,4,8,1,7,5,9,6],[4,6,1,7,5,2,8,3,9],[7,5,9,3,8,1,2,6,4],[8,2,3,6,9,4,1,7,5],[3,8,2,5,7,9,6,4,1],[1,7,6,4,2,8,9,5,3],[9,4,5,1,3,6,7,8,2]]
1881	[[7,9,5,6,2,1,3,4,8],[3,6,1,4,8,7,5,2,9],[8,4,2,3,9,5,6,7,1],[9,1,4,7,3,6,2,8,5],[2,3,8,1,5,9,7,6,4],[6,5,7,8,4,2,9,1,3],[1,2,3,5,6,8,4,9,7],[5,7,9,2,1,4,8,3,6],[4,8,6,9,7,3,1,5,2]]
1882	[[2,7,4,5,6,1,9,8,3],[5,3,8,4,7,9,2,1,6],[1,9,6,2,3,8,4,5,7],[3,5,2,1,9,4,6,7,8],[8,4,1,6,5,7,3,9,2],[7,6,9,8,2,3,1,4,5],[4,1,5,3,8,6,7,2,9],[9,2,3,7,1,5,8,6,4],[6,8,7,9,4,2,5,3,1]]
1883	[[4,3,7,5,2,8,1,9,6],[5,2,6,4,1,9,7,8,3],[9,8,1,3,7,6,2,4,5],[2,5,4,8,3,7,9,6,1],[6,7,3,2,9,1,4,5,8],[1,9,8,6,5,4,3,2,7],[8,6,2,7,4,3,5,1,9],[7,4,9,1,6,5,8,3,2],[3,1,5,9,8,2,6,7,4]]
1884	[[7,5,2,6,3,4,1,8,9],[3,9,1,7,8,5,2,4,6],[6,4,8,2,9,1,3,7,5],[9,2,6,4,5,3,7,1,8],[5,7,4,1,2,8,6,9,3],[1,8,3,9,6,7,5,2,4],[2,3,7,8,4,6,9,5,1],[4,6,9,5,1,2,8,3,7],[8,1,5,3,7,9,4,6,2]]
1885	[[4,6,1,5,8,3,7,2,9],[8,9,5,1,7,2,6,4,3],[3,2,7,4,9,6,5,1,8],[5,4,9,8,1,7,3,6,2],[6,8,2,3,4,5,9,7,1],[7,1,3,6,2,9,8,5,4],[9,7,8,2,5,1,4,3,6],[1,3,4,7,6,8,2,9,5],[2,5,6,9,3,4,1,8,7]]
1886	[[3,5,7,2,4,1,6,8,9],[2,8,1,6,5,9,7,4,3],[9,6,4,7,3,8,1,5,2],[5,7,3,4,1,2,9,6,8],[1,2,9,8,6,3,4,7,5],[8,4,6,5,9,7,3,2,1],[6,9,8,3,7,5,2,1,4],[7,1,5,9,2,4,8,3,6],[4,3,2,1,8,6,5,9,7]]
1887	[[9,2,8,6,3,7,4,5,1],[5,4,7,1,9,8,2,6,3],[3,1,6,4,2,5,7,8,9],[2,3,9,8,5,6,1,4,7],[6,5,4,2,7,1,3,9,8],[8,7,1,3,4,9,6,2,5],[4,9,2,7,8,3,5,1,6],[1,8,3,5,6,2,9,7,4],[7,6,5,9,1,4,8,3,2]]
1888	[[9,5,6,3,8,1,7,2,4],[8,4,7,9,2,5,3,1,6],[3,1,2,7,6,4,8,9,5],[4,8,5,2,9,3,1,6,7],[2,7,3,4,1,6,5,8,9],[1,6,9,5,7,8,2,4,3],[7,2,8,6,5,9,4,3,1],[5,9,4,1,3,2,6,7,8],[6,3,1,8,4,7,9,5,2]]
1889	[[3,2,9,7,5,6,4,1,8],[6,8,7,2,4,1,9,3,5],[4,5,1,3,9,8,7,2,6],[9,4,2,8,7,5,3,6,1],[5,3,6,1,2,9,8,4,7],[1,7,8,4,6,3,5,9,2],[8,1,4,5,3,2,6,7,9],[7,9,5,6,1,4,2,8,3],[2,6,3,9,8,7,1,5,4]]
1890	[[5,7,2,9,3,6,1,4,8],[4,6,8,1,5,7,2,3,9],[9,1,3,4,2,8,7,6,5],[7,2,9,6,8,3,5,1,4],[8,4,1,5,9,2,3,7,6],[6,3,5,7,1,4,9,8,2],[3,9,6,2,4,1,8,5,7],[2,8,7,3,6,5,4,9,1],[1,5,4,8,7,9,6,2,3]]
1891	[[4,3,2,1,7,6,9,5,8],[6,1,8,9,5,3,4,2,7],[5,7,9,8,4,2,6,1,3],[9,2,7,6,8,5,1,3,4],[1,8,5,4,3,7,2,9,6],[3,4,6,2,1,9,7,8,5],[2,5,3,7,9,4,8,6,1],[7,9,1,5,6,8,3,4,2],[8,6,4,3,2,1,5,7,9]]
1892	[[9,8,5,1,7,2,3,6,4],[7,2,3,6,4,9,1,5,8],[4,6,1,3,8,5,2,7,9],[5,4,7,8,9,3,6,1,2],[1,3,2,4,5,6,9,8,7],[8,9,6,7,2,1,5,4,3],[3,7,9,5,1,8,4,2,6],[6,1,4,2,3,7,8,9,5],[2,5,8,9,6,4,7,3,1]]
1893	[[4,1,7,3,9,5,2,6,8],[2,9,5,6,8,7,3,1,4],[3,8,6,1,4,2,9,7,5],[5,6,4,7,2,1,8,9,3],[9,2,1,8,6,3,5,4,7],[7,3,8,9,5,4,1,2,6],[6,5,3,2,7,9,4,8,1],[8,4,9,5,1,6,7,3,2],[1,7,2,4,3,8,6,5,9]]
1894	[[9,3,4,1,6,2,5,7,8],[2,1,6,5,8,7,3,4,9],[5,7,8,3,9,4,1,2,6],[3,4,2,9,1,8,7,6,5],[8,6,5,4,7,3,2,9,1],[1,9,7,2,5,6,8,3,4],[6,2,3,8,4,5,9,1,7],[7,8,9,6,2,1,4,5,3],[4,5,1,7,3,9,6,8,2]]
1895	[[2,8,7,1,9,5,3,6,4],[5,4,3,8,6,2,7,1,9],[9,1,6,3,4,7,5,8,2],[7,3,2,6,1,9,4,5,8],[4,9,1,7,5,8,6,2,3],[6,5,8,4,2,3,1,9,7],[8,6,4,2,7,1,9,3,5],[1,2,5,9,3,4,8,7,6],[3,7,9,5,8,6,2,4,1]]
1896	[[4,5,8,3,7,6,1,2,9],[2,7,9,5,4,1,6,8,3],[6,1,3,2,9,8,7,4,5],[9,4,6,1,5,7,2,3,8],[1,2,7,4,8,3,5,9,6],[8,3,5,9,6,2,4,1,7],[3,9,2,6,1,5,8,7,4],[5,8,1,7,3,4,9,6,2],[7,6,4,8,2,9,3,5,1]]
1897	[[5,8,2,3,9,7,1,6,4],[9,3,6,1,5,4,7,8,2],[4,7,1,2,8,6,3,5,9],[8,5,4,6,7,1,9,2,3],[6,2,7,5,3,9,8,4,1],[1,9,3,4,2,8,5,7,6],[2,6,5,8,1,3,4,9,7],[7,1,8,9,4,2,6,3,5],[3,4,9,7,6,5,2,1,8]]
1898	[[3,8,1,7,9,6,4,5,2],[5,6,2,8,3,4,1,9,7],[7,4,9,5,2,1,8,6,3],[6,9,4,3,8,7,2,1,5],[1,2,7,4,6,5,3,8,9],[8,5,3,2,1,9,7,4,6],[2,1,6,9,4,3,5,7,8],[9,3,5,1,7,8,6,2,4],[4,7,8,6,5,2,9,3,1]]
1899	[[3,7,9,5,2,4,1,8,6],[2,6,4,1,8,3,9,5,7],[8,5,1,9,6,7,4,3,2],[6,2,8,3,4,9,7,1,5],[7,9,5,8,1,2,3,6,4],[4,1,3,7,5,6,2,9,8],[5,4,6,2,9,1,8,7,3],[1,3,2,6,7,8,5,4,9],[9,8,7,4,3,5,6,2,1]]
1900	[[2,9,1,8,4,6,3,5,7],[5,6,8,7,9,3,1,2,4],[4,7,3,1,5,2,9,8,6],[3,4,6,5,7,9,8,1,2],[9,2,7,6,8,1,4,3,5],[1,8,5,3,2,4,7,6,9],[7,3,9,2,1,5,6,4,8],[6,5,4,9,3,8,2,7,1],[8,1,2,4,6,7,5,9,3]]
1901	[[2,7,5,9,8,1,6,3,4],[1,3,6,7,2,4,8,5,9],[4,9,8,3,5,6,2,1,7],[5,2,7,1,4,9,3,8,6],[8,4,3,5,6,2,9,7,1],[6,1,9,8,3,7,4,2,5],[3,6,1,4,7,8,5,9,2],[9,5,2,6,1,3,7,4,8],[7,8,4,2,9,5,1,6,3]]
1902	[[9,8,3,2,1,6,7,4,5],[2,7,1,5,8,4,6,9,3],[6,4,5,3,9,7,1,8,2],[3,2,9,8,6,5,4,1,7],[4,6,7,1,2,9,5,3,8],[1,5,8,7,4,3,2,6,9],[8,3,2,6,7,1,9,5,4],[5,9,6,4,3,2,8,7,1],[7,1,4,9,5,8,3,2,6]]
1903	[[7,1,4,8,6,3,2,9,5],[6,9,8,5,2,1,7,3,4],[2,3,5,4,7,9,8,1,6],[1,6,7,9,3,2,4,5,8],[4,8,9,6,1,5,3,2,7],[3,5,2,7,4,8,9,6,1],[9,4,3,1,5,7,6,8,2],[5,2,6,3,8,4,1,7,9],[8,7,1,2,9,6,5,4,3]]
1904	[[6,5,1,4,7,8,3,2,9],[7,9,2,1,3,5,4,6,8],[4,3,8,6,2,9,5,7,1],[2,4,9,5,1,7,8,3,6],[1,6,3,8,4,2,7,9,5],[8,7,5,3,9,6,1,4,2],[3,8,6,2,5,4,9,1,7],[9,2,4,7,8,1,6,5,3],[5,1,7,9,6,3,2,8,4]]
1905	[[4,6,8,5,9,7,2,3,1],[2,9,1,6,4,3,7,5,8],[5,3,7,8,1,2,4,6,9],[3,4,2,9,5,8,1,7,6],[8,7,9,2,6,1,5,4,3],[1,5,6,3,7,4,9,8,2],[7,2,4,1,3,6,8,9,5],[9,8,3,4,2,5,6,1,7],[6,1,5,7,8,9,3,2,4]]
1906	[[5,1,2,7,4,3,9,6,8],[6,3,4,8,2,9,7,5,1],[8,9,7,5,1,6,3,2,4],[3,2,5,6,8,4,1,9,7],[1,8,9,2,7,5,4,3,6],[4,7,6,9,3,1,2,8,5],[9,4,8,3,6,7,5,1,2],[2,5,1,4,9,8,6,7,3],[7,6,3,1,5,2,8,4,9]]
1907	[[1,7,5,2,6,9,4,3,8],[2,8,6,3,5,4,1,9,7],[4,3,9,8,1,7,5,2,6],[6,9,2,1,8,3,7,4,5],[8,5,4,7,9,6,2,1,3],[3,1,7,4,2,5,6,8,9],[9,6,3,5,4,2,8,7,1],[7,4,8,6,3,1,9,5,2],[5,2,1,9,7,8,3,6,4]]
1908	[[9,2,4,5,8,6,1,3,7],[3,5,6,1,7,4,8,9,2],[7,8,1,3,2,9,5,4,6],[4,1,3,2,6,8,9,7,5],[5,6,7,9,4,3,2,1,8],[2,9,8,7,1,5,3,6,4],[6,7,5,8,3,1,4,2,9],[1,4,9,6,5,2,7,8,3],[8,3,2,4,9,7,6,5,1]]
1909	[[8,3,5,2,4,9,1,6,7],[6,1,2,7,5,3,9,4,8],[9,7,4,8,6,1,5,2,3],[1,4,6,5,3,8,2,7,9],[3,5,7,9,2,4,6,8,1],[2,9,8,6,1,7,4,3,5],[5,8,1,4,7,6,3,9,2],[7,6,3,1,9,2,8,5,4],[4,2,9,3,8,5,7,1,6]]
1910	[[9,8,2,4,6,3,1,7,5],[7,1,6,8,5,9,4,3,2],[4,3,5,2,7,1,6,8,9],[6,5,8,7,3,4,9,2,1],[3,2,7,9,1,5,8,6,4],[1,9,4,6,8,2,7,5,3],[8,4,9,3,2,6,5,1,7],[5,6,3,1,4,7,2,9,8],[2,7,1,5,9,8,3,4,6]]
1911	[[8,3,4,9,2,6,1,5,7],[5,6,7,8,4,1,9,3,2],[2,1,9,7,5,3,4,6,8],[9,2,6,1,3,5,8,7,4],[4,8,5,6,7,9,3,2,1],[3,7,1,2,8,4,5,9,6],[6,9,3,4,1,7,2,8,5],[1,5,8,3,6,2,7,4,9],[7,4,2,5,9,8,6,1,3]]
1912	[[1,2,7,9,5,6,4,8,3],[3,4,6,1,8,2,9,5,7],[9,8,5,4,7,3,2,6,1],[8,9,4,2,6,1,7,3,5],[6,5,2,7,3,8,1,9,4],[7,3,1,5,4,9,8,2,6],[2,6,8,3,1,7,5,4,9],[5,1,9,6,2,4,3,7,8],[4,7,3,8,9,5,6,1,2]]
1913	[[2,6,5,1,7,8,3,4,9],[4,8,3,5,2,9,6,1,7],[9,7,1,3,4,6,2,8,5],[8,5,2,9,6,4,7,3,1],[1,3,9,8,5,7,4,6,2],[6,4,7,2,1,3,9,5,8],[7,2,8,6,3,1,5,9,4],[5,1,6,4,9,2,8,7,3],[3,9,4,7,8,5,1,2,6]]
1914	[[5,9,7,8,3,4,6,1,2],[2,3,8,6,5,1,4,9,7],[6,1,4,7,2,9,5,3,8],[4,5,6,9,7,2,3,8,1],[7,2,1,5,8,3,9,4,6],[9,8,3,4,1,6,2,7,5],[3,4,2,1,6,8,7,5,9],[8,7,9,2,4,5,1,6,3],[1,6,5,3,9,7,8,2,4]]
1915	[[5,4,2,7,3,6,9,1,8],[8,7,9,5,4,1,6,3,2],[6,3,1,2,8,9,4,7,5],[9,2,4,8,5,7,1,6,3],[3,8,5,1,6,4,7,2,9],[1,6,7,3,9,2,8,5,4],[4,1,6,9,2,5,3,8,7],[7,5,8,4,1,3,2,9,6],[2,9,3,6,7,8,5,4,1]]
1916	[[8,4,5,6,9,3,1,2,7],[7,2,3,1,4,5,8,6,9],[9,1,6,2,7,8,3,4,5],[5,6,1,7,3,9,4,8,2],[2,3,9,8,1,4,7,5,6],[4,8,7,5,6,2,9,3,1],[3,7,2,9,8,6,5,1,4],[1,5,4,3,2,7,6,9,8],[6,9,8,4,5,1,2,7,3]]
1917	[[1,8,3,2,7,4,5,6,9],[7,5,2,9,6,1,8,4,3],[9,6,4,3,8,5,7,1,2],[2,7,6,4,3,8,1,9,5],[3,4,8,5,1,9,6,2,7],[5,9,1,6,2,7,3,8,4],[4,1,9,8,5,3,2,7,6],[8,2,5,7,4,6,9,3,1],[6,3,7,1,9,2,4,5,8]]
1918	[[1,7,4,5,3,9,6,8,2],[2,6,9,1,7,8,3,4,5],[5,3,8,4,6,2,9,7,1],[7,8,2,3,9,5,1,6,4],[9,1,3,6,2,4,7,5,8],[4,5,6,8,1,7,2,9,3],[6,4,1,7,5,3,8,2,9],[8,9,7,2,4,1,5,3,6],[3,2,5,9,8,6,4,1,7]]
1919	[[2,3,6,9,4,1,8,5,7],[8,7,4,5,3,2,1,6,9],[1,5,9,8,7,6,2,3,4],[9,1,7,2,5,3,4,8,6],[3,6,8,1,9,4,5,7,2],[5,4,2,6,8,7,9,1,3],[4,2,3,7,1,5,6,9,8],[6,9,1,3,2,8,7,4,5],[7,8,5,4,6,9,3,2,1]]
1920	[[3,1,7,4,5,6,9,8,2],[2,9,4,3,8,1,6,7,5],[5,6,8,9,2,7,4,3,1],[6,3,2,5,9,4,8,1,7],[1,7,9,8,6,2,3,5,4],[4,8,5,7,1,3,2,6,9],[9,4,1,6,3,5,7,2,8],[7,2,3,1,4,8,5,9,6],[8,5,6,2,7,9,1,4,3]]
1921	[[2,4,7,1,5,8,3,6,9],[9,8,1,6,3,7,4,5,2],[3,5,6,4,2,9,7,1,8],[5,1,8,7,4,3,2,9,6],[7,6,3,9,8,2,1,4,5],[4,9,2,5,1,6,8,3,7],[8,2,5,3,9,4,6,7,1],[1,7,4,8,6,5,9,2,3],[6,3,9,2,7,1,5,8,4]]
1922	[[3,9,6,8,5,4,2,7,1],[2,8,5,1,6,7,4,9,3],[7,4,1,2,9,3,6,8,5],[6,1,3,7,8,5,9,4,2],[5,7,4,6,2,9,1,3,8],[9,2,8,4,3,1,5,6,7],[4,5,7,3,1,6,8,2,9],[1,6,2,9,7,8,3,5,4],[8,3,9,5,4,2,7,1,6]]
1923	[[6,3,9,4,5,7,8,2,1],[8,7,4,1,9,2,3,6,5],[1,2,5,3,6,8,4,7,9],[5,9,7,6,1,4,2,3,8],[4,8,6,5,2,3,1,9,7],[2,1,3,8,7,9,5,4,6],[3,4,1,9,8,6,7,5,2],[9,5,2,7,3,1,6,8,4],[7,6,8,2,4,5,9,1,3]]
1924	[[2,4,8,9,3,7,5,1,6],[1,7,5,4,6,8,2,3,9],[3,6,9,1,2,5,4,8,7],[7,5,3,8,9,4,6,2,1],[6,8,1,7,5,2,3,9,4],[9,2,4,3,1,6,7,5,8],[8,9,2,6,7,3,1,4,5],[5,1,6,2,4,9,8,7,3],[4,3,7,5,8,1,9,6,2]]
1925	[[7,4,5,3,8,2,6,9,1],[1,8,9,4,6,7,5,2,3],[6,2,3,5,1,9,7,4,8],[9,5,4,7,2,8,3,1,6],[8,3,1,6,9,4,2,5,7],[2,6,7,1,3,5,4,8,9],[3,7,2,9,4,1,8,6,5],[5,9,8,2,7,6,1,3,4],[4,1,6,8,5,3,9,7,2]]
1926	[[5,2,8,6,1,9,4,7,3],[3,6,1,4,7,2,9,5,8],[7,4,9,3,5,8,2,1,6],[9,7,4,2,3,1,6,8,5],[8,1,3,9,6,5,7,4,2],[2,5,6,7,8,4,1,3,9],[1,8,2,5,9,7,3,6,4],[4,3,5,1,2,6,8,9,7],[6,9,7,8,4,3,5,2,1]]
1927	[[4,2,6,5,8,9,3,7,1],[1,7,9,2,3,4,8,5,6],[8,3,5,6,7,1,4,2,9],[7,5,2,9,6,8,1,3,4],[6,4,8,3,1,5,7,9,2],[3,9,1,7,4,2,6,8,5],[2,6,3,4,5,7,9,1,8],[9,8,4,1,2,3,5,6,7],[5,1,7,8,9,6,2,4,3]]
1928	[[3,1,9,5,2,7,4,6,8],[6,8,2,4,3,9,1,5,7],[5,4,7,8,6,1,3,2,9],[7,9,1,2,5,8,6,3,4],[2,5,3,6,9,4,8,7,1],[8,6,4,1,7,3,2,9,5],[1,2,6,7,8,5,9,4,3],[9,7,8,3,4,6,5,1,2],[4,3,5,9,1,2,7,8,6]]
1929	[[5,7,2,4,6,1,3,9,8],[6,9,4,3,8,7,2,5,1],[8,1,3,5,9,2,4,6,7],[2,8,5,7,3,9,1,4,6],[7,3,6,1,4,5,8,2,9],[1,4,9,6,2,8,5,7,3],[4,6,7,2,1,3,9,8,5],[9,2,1,8,5,6,7,3,4],[3,5,8,9,7,4,6,1,2]]
1930	[[7,8,3,2,4,6,5,9,1],[9,1,2,3,8,5,7,4,6],[5,4,6,9,1,7,2,3,8],[2,3,5,1,7,4,6,8,9],[4,6,1,5,9,8,3,7,2],[8,7,9,6,3,2,4,1,5],[6,9,4,7,2,1,8,5,3],[1,5,7,8,6,3,9,2,4],[3,2,8,4,5,9,1,6,7]]
1931	[[8,6,2,5,3,1,4,9,7],[9,4,1,8,7,6,2,3,5],[3,5,7,4,9,2,6,8,1],[5,2,3,1,6,8,9,7,4],[7,1,9,2,4,3,5,6,8],[4,8,6,7,5,9,1,2,3],[1,9,5,6,8,7,3,4,2],[2,3,8,9,1,4,7,5,6],[6,7,4,3,2,5,8,1,9]]
1932	[[8,2,6,4,5,9,1,7,3],[5,9,1,3,6,7,4,2,8],[7,4,3,8,1,2,9,6,5],[9,5,7,2,4,6,3,8,1],[6,8,4,5,3,1,2,9,7],[3,1,2,7,9,8,5,4,6],[1,6,5,9,8,4,7,3,2],[4,7,8,1,2,3,6,5,9],[2,3,9,6,7,5,8,1,4]]
1933	[[9,5,4,2,1,7,3,8,6],[1,8,7,9,6,3,4,2,5],[3,2,6,5,4,8,1,7,9],[7,1,2,4,5,6,8,9,3],[5,4,8,3,2,9,6,1,7],[6,9,3,7,8,1,2,5,4],[4,3,5,8,9,2,7,6,1],[8,7,1,6,3,5,9,4,2],[2,6,9,1,7,4,5,3,8]]
1934	[[2,6,7,1,4,8,5,3,9],[9,8,3,6,5,7,1,2,4],[5,1,4,3,2,9,7,6,8],[4,3,5,9,8,6,2,7,1],[1,9,6,4,7,2,3,8,5],[7,2,8,5,3,1,4,9,6],[6,4,9,2,1,3,8,5,7],[8,5,2,7,9,4,6,1,3],[3,7,1,8,6,5,9,4,2]]
1935	[[1,5,3,6,4,9,2,7,8],[9,8,2,7,3,1,4,6,5],[7,4,6,5,8,2,1,9,3],[2,7,8,3,6,4,5,1,9],[3,1,5,2,9,7,6,8,4],[6,9,4,1,5,8,3,2,7],[5,2,1,8,7,3,9,4,6],[8,3,9,4,1,6,7,5,2],[4,6,7,9,2,5,8,3,1]]
1936	[[3,5,1,2,6,9,4,7,8],[9,4,6,5,8,7,2,1,3],[2,8,7,4,3,1,6,5,9],[1,7,9,6,5,2,8,3,4],[4,3,5,9,1,8,7,6,2],[6,2,8,3,7,4,5,9,1],[5,6,2,1,4,3,9,8,7],[7,1,4,8,9,5,3,2,6],[8,9,3,7,2,6,1,4,5]]
1937	[[3,8,1,6,5,2,7,9,4],[7,2,4,8,9,3,1,5,6],[9,6,5,7,4,1,3,2,8],[6,7,2,5,1,4,9,8,3],[1,3,8,9,7,6,2,4,5],[5,4,9,3,2,8,6,1,7],[2,1,7,4,3,5,8,6,9],[8,5,3,1,6,9,4,7,2],[4,9,6,2,8,7,5,3,1]]
1938	[[3,4,8,1,9,7,6,2,5],[5,1,9,2,6,8,7,4,3],[6,7,2,3,4,5,9,8,1],[2,8,7,5,3,1,4,6,9],[4,9,5,7,8,6,1,3,2],[1,3,6,9,2,4,5,7,8],[8,6,3,4,5,9,2,1,7],[9,2,1,6,7,3,8,5,4],[7,5,4,8,1,2,3,9,6]]
1939	[[4,3,1,5,8,9,7,6,2],[6,9,8,1,7,2,3,5,4],[2,5,7,3,6,4,9,1,8],[8,2,3,6,9,1,5,4,7],[9,1,5,7,4,8,2,3,6],[7,6,4,2,3,5,1,8,9],[3,7,9,8,1,6,4,2,5],[5,4,6,9,2,3,8,7,1],[1,8,2,4,5,7,6,9,3]]
1940	[[2,8,6,4,3,5,7,1,9],[4,5,9,1,7,2,6,8,3],[1,7,3,6,8,9,5,2,4],[7,2,4,9,5,1,8,3,6],[6,1,8,7,4,3,2,9,5],[9,3,5,8,2,6,4,7,1],[3,4,1,2,6,7,9,5,8],[5,6,2,3,9,8,1,4,7],[8,9,7,5,1,4,3,6,2]]
1941	[[1,8,3,9,2,7,6,5,4],[4,7,5,1,6,3,9,8,2],[9,2,6,5,8,4,7,1,3],[2,9,8,4,1,6,5,3,7],[5,4,7,2,3,8,1,9,6],[6,3,1,7,5,9,2,4,8],[8,1,2,3,7,5,4,6,9],[7,6,4,8,9,1,3,2,5],[3,5,9,6,4,2,8,7,1]]
1942	[[3,4,6,8,2,1,9,5,7],[1,8,2,7,9,5,4,6,3],[9,7,5,3,4,6,2,1,8],[2,5,7,6,3,4,8,9,1],[6,9,8,5,1,7,3,2,4],[4,3,1,2,8,9,5,7,6],[7,2,3,1,5,8,6,4,9],[5,6,4,9,7,3,1,8,2],[8,1,9,4,6,2,7,3,5]]
1943	[[2,6,9,1,5,8,3,7,4],[5,3,7,2,4,6,8,1,9],[8,1,4,9,7,3,5,6,2],[7,4,1,5,6,2,9,3,8],[6,2,8,3,9,1,7,4,5],[9,5,3,4,8,7,6,2,1],[4,9,2,6,3,5,1,8,7],[3,7,5,8,1,4,2,9,6],[1,8,6,7,2,9,4,5,3]]
1944	[[5,9,1,8,6,4,7,3,2],[8,4,7,5,2,3,6,1,9],[2,3,6,1,7,9,8,4,5],[6,5,9,4,1,7,3,2,8],[7,1,2,3,8,5,4,9,6],[3,8,4,6,9,2,5,7,1],[1,7,3,9,5,6,2,8,4],[9,2,5,7,4,8,1,6,3],[4,6,8,2,3,1,9,5,7]]
1945	[[6,7,8,9,1,5,3,4,2],[1,2,3,4,8,6,7,5,9],[5,9,4,7,3,2,6,8,1],[7,4,2,3,9,1,5,6,8],[8,5,9,6,4,7,1,2,3],[3,1,6,5,2,8,9,7,4],[9,3,5,2,6,4,8,1,7],[4,6,1,8,7,3,2,9,5],[2,8,7,1,5,9,4,3,6]]
1946	[[9,3,8,2,7,4,5,6,1],[7,4,5,9,1,6,3,8,2],[6,2,1,5,3,8,9,4,7],[2,6,4,7,8,3,1,9,5],[3,8,9,6,5,1,7,2,4],[1,5,7,4,9,2,6,3,8],[8,1,2,3,6,7,4,5,9],[4,9,3,1,2,5,8,7,6],[5,7,6,8,4,9,2,1,3]]
1947	[[1,2,3,5,8,9,6,4,7],[8,6,4,1,7,2,3,9,5],[9,7,5,3,6,4,8,2,1],[6,3,1,4,9,7,2,5,8],[4,8,7,2,5,3,1,6,9],[2,5,9,6,1,8,4,7,3],[3,9,6,7,4,1,5,8,2],[7,4,2,8,3,5,9,1,6],[5,1,8,9,2,6,7,3,4]]
1948	[[4,7,5,1,3,2,8,6,9],[6,1,9,4,8,5,3,7,2],[8,3,2,9,6,7,5,4,1],[3,5,4,2,9,8,7,1,6],[7,2,8,6,1,4,9,3,5],[1,9,6,7,5,3,4,2,8],[2,6,7,8,4,9,1,5,3],[9,4,3,5,2,1,6,8,7],[5,8,1,3,7,6,2,9,4]]
1949	[[7,9,5,6,4,1,3,2,8],[3,8,2,5,7,9,6,1,4],[6,1,4,8,3,2,9,5,7],[4,6,7,3,2,8,5,9,1],[2,3,1,7,9,5,8,4,6],[9,5,8,4,1,6,2,7,3],[1,4,9,2,6,3,7,8,5],[5,7,3,9,8,4,1,6,2],[8,2,6,1,5,7,4,3,9]]
1950	[[5,1,3,8,7,6,9,4,2],[9,2,8,4,3,1,6,5,7],[4,6,7,9,5,2,3,1,8],[3,7,4,6,8,9,1,2,5],[1,8,5,3,2,7,4,9,6],[2,9,6,5,1,4,7,8,3],[8,5,1,7,9,3,2,6,4],[7,4,2,1,6,5,8,3,9],[6,3,9,2,4,8,5,7,1]]
1951	[[7,2,6,9,4,8,5,3,1],[1,5,4,2,6,3,9,7,8],[8,9,3,7,1,5,4,2,6],[2,4,9,8,7,1,3,6,5],[3,6,1,4,5,2,8,9,7],[5,7,8,3,9,6,1,4,2],[6,3,2,5,8,9,7,1,4],[4,1,5,6,3,7,2,8,9],[9,8,7,1,2,4,6,5,3]]
1952	[[1,6,5,3,8,4,9,7,2],[9,8,3,5,7,2,1,4,6],[7,2,4,6,9,1,8,5,3],[2,5,9,8,1,6,4,3,7],[6,3,7,9,4,5,2,8,1],[8,4,1,2,3,7,6,9,5],[5,9,8,1,6,3,7,2,4],[3,7,6,4,2,8,5,1,9],[4,1,2,7,5,9,3,6,8]]
1953	[[5,3,9,7,8,1,6,4,2],[4,8,6,5,2,9,1,3,7],[7,1,2,6,4,3,5,9,8],[8,6,7,9,1,4,2,5,3],[3,5,1,2,6,7,4,8,9],[2,9,4,3,5,8,7,1,6],[9,7,5,1,3,2,8,6,4],[1,4,3,8,7,6,9,2,5],[6,2,8,4,9,5,3,7,1]]
1954	[[3,9,7,6,4,5,1,2,8],[1,8,5,9,7,2,4,6,3],[2,4,6,8,3,1,5,7,9],[8,7,1,4,9,6,3,5,2],[6,5,9,1,2,3,7,8,4],[4,2,3,5,8,7,6,9,1],[5,1,4,2,6,8,9,3,7],[9,3,8,7,5,4,2,1,6],[7,6,2,3,1,9,8,4,5]]
1955	[[4,8,6,3,1,9,2,5,7],[3,7,1,4,5,2,6,9,8],[2,5,9,6,8,7,1,4,3],[5,6,4,7,3,1,9,8,2],[9,1,3,8,2,4,7,6,5],[7,2,8,9,6,5,3,1,4],[6,3,5,1,7,8,4,2,9],[8,4,7,2,9,6,5,3,1],[1,9,2,5,4,3,8,7,6]]
1956	[[2,3,4,7,5,9,8,6,1],[6,9,7,8,1,2,3,5,4],[1,5,8,3,6,4,9,7,2],[5,6,3,9,2,8,4,1,7],[7,2,1,4,3,5,6,8,9],[4,8,9,6,7,1,2,3,5],[8,7,5,2,4,6,1,9,3],[9,1,2,5,8,3,7,4,6],[3,4,6,1,9,7,5,2,8]]
1957	[[9,8,1,4,7,3,5,2,6],[4,7,3,2,6,5,1,9,8],[6,5,2,1,9,8,7,3,4],[5,9,4,6,3,2,8,7,1],[1,2,8,9,5,7,6,4,3],[7,3,6,8,1,4,9,5,2],[3,6,7,5,4,1,2,8,9],[2,1,5,3,8,9,4,6,7],[8,4,9,7,2,6,3,1,5]]
1958	[[4,9,6,7,3,1,5,2,8],[2,1,3,5,6,8,7,9,4],[8,5,7,9,2,4,6,3,1],[9,4,1,6,8,2,3,7,5],[3,8,2,1,7,5,9,4,6],[7,6,5,4,9,3,8,1,2],[6,3,4,2,5,9,1,8,7],[1,7,8,3,4,6,2,5,9],[5,2,9,8,1,7,4,6,3]]
1959	[[5,8,3,7,9,2,6,4,1],[2,9,4,5,1,6,7,8,3],[1,7,6,3,4,8,9,2,5],[6,4,7,9,5,1,2,3,8],[8,3,1,2,7,4,5,6,9],[9,2,5,6,8,3,4,1,7],[4,5,8,1,2,7,3,9,6],[7,6,2,8,3,9,1,5,4],[3,1,9,4,6,5,8,7,2]]
1960	[[1,7,5,2,3,8,4,6,9],[6,8,9,4,5,1,3,2,7],[2,3,4,9,6,7,8,1,5],[4,6,8,1,2,9,5,7,3],[3,2,7,5,4,6,9,8,1],[9,5,1,8,7,3,2,4,6],[8,9,2,6,1,5,7,3,4],[5,1,3,7,8,4,6,9,2],[7,4,6,3,9,2,1,5,8]]
1961	[[9,7,4,5,3,1,8,6,2],[1,8,6,7,2,4,9,5,3],[5,2,3,8,6,9,4,1,7],[7,3,9,1,8,6,2,4,5],[2,6,1,4,7,5,3,8,9],[8,4,5,3,9,2,1,7,6],[6,9,8,2,4,7,5,3,1],[3,5,2,6,1,8,7,9,4],[4,1,7,9,5,3,6,2,8]]
1962	[[8,5,6,4,2,1,7,3,9],[2,7,1,6,3,9,5,4,8],[3,4,9,7,8,5,2,1,6],[6,3,7,1,4,8,9,5,2],[5,2,4,3,9,6,8,7,1],[9,1,8,5,7,2,3,6,4],[1,8,5,2,6,3,4,9,7],[4,6,2,9,5,7,1,8,3],[7,9,3,8,1,4,6,2,5]]
1963	[[9,2,8,1,4,6,7,5,3],[3,5,1,9,8,7,2,6,4],[6,4,7,2,5,3,8,9,1],[1,9,2,7,6,8,4,3,5],[5,6,4,3,9,2,1,8,7],[8,7,3,5,1,4,9,2,6],[7,3,6,8,2,1,5,4,9],[2,1,5,4,3,9,6,7,8],[4,8,9,6,7,5,3,1,2]]
1964	[[2,4,5,7,8,9,1,3,6],[7,1,6,3,5,4,8,2,9],[3,9,8,1,2,6,4,7,5],[8,7,9,6,4,5,3,1,2],[1,6,2,8,7,3,9,5,4],[5,3,4,9,1,2,7,6,8],[9,8,7,5,6,1,2,4,3],[6,2,3,4,9,7,5,8,1],[4,5,1,2,3,8,6,9,7]]
1965	[[8,3,4,5,2,7,9,6,1],[2,7,6,3,9,1,4,8,5],[1,9,5,8,6,4,2,7,3],[6,4,9,1,7,8,3,5,2],[3,1,7,2,5,6,8,4,9],[5,2,8,9,4,3,6,1,7],[9,5,1,6,8,2,7,3,4],[7,6,2,4,3,5,1,9,8],[4,8,3,7,1,9,5,2,6]]
1966	[[6,4,2,7,8,3,5,1,9],[8,1,9,2,5,4,7,3,6],[5,7,3,1,6,9,4,2,8],[3,5,8,4,9,2,1,6,7],[7,6,1,5,3,8,9,4,2],[2,9,4,6,7,1,3,8,5],[9,8,5,3,1,6,2,7,4],[4,3,7,8,2,5,6,9,1],[1,2,6,9,4,7,8,5,3]]
1967	[[2,7,9,3,5,8,6,1,4],[1,8,4,7,6,9,3,2,5],[6,5,3,1,2,4,8,9,7],[7,4,8,2,3,1,9,5,6],[5,3,6,4,9,7,1,8,2],[9,1,2,5,8,6,7,4,3],[3,2,1,8,7,5,4,6,9],[4,9,7,6,1,2,5,3,8],[8,6,5,9,4,3,2,7,1]]
1968	[[3,2,6,7,1,9,8,5,4],[5,4,9,8,2,3,6,1,7],[7,1,8,4,6,5,2,3,9],[2,9,1,5,4,6,7,8,3],[4,7,5,2,3,8,1,9,6],[6,8,3,9,7,1,5,4,2],[1,6,4,3,5,2,9,7,8],[8,5,7,6,9,4,3,2,1],[9,3,2,1,8,7,4,6,5]]
1969	[[5,3,2,8,1,4,7,9,6],[4,8,7,9,5,6,2,1,3],[9,6,1,7,2,3,4,8,5],[8,5,9,1,3,2,6,4,7],[1,7,6,4,9,5,8,3,2],[2,4,3,6,8,7,9,5,1],[6,2,8,5,4,1,3,7,9],[3,1,4,2,7,9,5,6,8],[7,9,5,3,6,8,1,2,4]]
1970	[[4,5,1,8,7,2,6,3,9],[9,7,8,3,4,6,2,1,5],[3,2,6,5,9,1,7,4,8],[6,9,5,4,1,3,8,7,2],[1,4,2,7,8,9,5,6,3],[8,3,7,6,2,5,4,9,1],[5,8,4,9,3,7,1,2,6],[2,6,3,1,5,4,9,8,7],[7,1,9,2,6,8,3,5,4]]
1971	[[5,1,2,7,4,3,8,9,6],[6,4,7,5,9,8,3,1,2],[8,3,9,6,1,2,7,5,4],[4,2,3,9,7,1,5,6,8],[7,8,6,3,5,4,1,2,9],[9,5,1,2,8,6,4,7,3],[2,7,5,8,3,9,6,4,1],[1,6,8,4,2,7,9,3,5],[3,9,4,1,6,5,2,8,7]]
1972	[[9,7,5,8,6,3,4,2,1],[8,4,2,1,7,5,9,6,3],[1,6,3,4,9,2,5,8,7],[3,2,9,5,4,7,6,1,8],[7,8,4,9,1,6,2,3,5],[5,1,6,3,2,8,7,9,4],[6,3,8,7,5,9,1,4,2],[2,5,1,6,8,4,3,7,9],[4,9,7,2,3,1,8,5,6]]
1973	[[9,4,3,2,6,1,8,5,7],[5,6,7,3,4,8,1,2,9],[8,2,1,7,5,9,4,3,6],[2,3,8,5,9,7,6,1,4],[6,1,4,8,2,3,9,7,5],[7,9,5,4,1,6,3,8,2],[1,7,6,9,3,5,2,4,8],[3,8,2,6,7,4,5,9,1],[4,5,9,1,8,2,7,6,3]]
1974	[[7,8,9,1,6,2,3,4,5],[1,6,2,3,4,5,7,8,9],[5,4,3,7,9,8,1,2,6],[3,9,8,6,7,4,5,1,2],[2,1,4,9,5,3,8,6,7],[6,5,7,8,2,1,9,3,4],[9,2,1,5,8,6,4,7,3],[4,3,5,2,1,7,6,9,8],[8,7,6,4,3,9,2,5,1]]
1975	[[4,8,1,7,5,9,6,2,3],[6,7,5,3,8,2,4,1,9],[9,2,3,1,6,4,5,8,7],[5,1,6,4,2,3,7,9,8],[8,3,7,9,1,6,2,5,4],[2,9,4,5,7,8,1,3,6],[7,6,8,2,3,5,9,4,1],[1,4,2,8,9,7,3,6,5],[3,5,9,6,4,1,8,7,2]]
1976	[[5,8,2,6,9,7,3,4,1],[3,9,1,5,4,8,2,7,6],[6,4,7,1,3,2,5,8,9],[2,1,9,3,7,6,8,5,4],[4,7,6,8,5,9,1,2,3],[8,5,3,4,2,1,9,6,7],[1,3,5,7,8,4,6,9,2],[7,2,8,9,6,3,4,1,5],[9,6,4,2,1,5,7,3,8]]
1977	[[3,1,8,7,5,9,2,4,6],[2,5,6,1,3,4,7,9,8],[7,9,4,2,6,8,5,3,1],[6,4,2,3,7,5,1,8,9],[9,3,1,6,8,2,4,7,5],[8,7,5,4,9,1,3,6,2],[4,2,9,8,1,7,6,5,3],[5,6,7,9,2,3,8,1,4],[1,8,3,5,4,6,9,2,7]]
1978	[[2,8,4,7,3,5,1,6,9],[1,9,3,6,2,4,5,8,7],[5,6,7,1,8,9,4,3,2],[8,5,9,2,4,6,7,1,3],[7,4,2,5,1,3,8,9,6],[6,3,1,8,9,7,2,4,5],[9,7,6,4,5,8,3,2,1],[3,2,8,9,7,1,6,5,4],[4,1,5,3,6,2,9,7,8]]
1979	[[1,6,5,3,4,7,2,8,9],[9,8,4,1,2,6,3,7,5],[2,3,7,8,5,9,1,4,6],[5,7,1,2,9,4,6,3,8],[3,4,2,6,1,8,5,9,7],[6,9,8,5,7,3,4,2,1],[8,2,6,9,3,5,7,1,4],[7,1,9,4,6,2,8,5,3],[4,5,3,7,8,1,9,6,2]]
1980	[[3,6,5,8,2,4,9,7,1],[7,4,9,3,1,6,2,8,5],[1,8,2,9,5,7,3,6,4],[6,5,8,2,7,9,4,1,3],[4,3,1,6,8,5,7,2,9],[2,9,7,4,3,1,6,5,8],[8,1,3,7,9,2,5,4,6],[9,2,4,5,6,8,1,3,7],[5,7,6,1,4,3,8,9,2]]
1981	[[7,5,9,2,4,3,1,8,6],[2,4,8,1,6,5,3,9,7],[1,3,6,9,7,8,5,4,2],[3,9,4,8,2,7,6,5,1],[5,1,7,6,3,9,4,2,8],[6,8,2,4,5,1,7,3,9],[9,2,3,7,1,4,8,6,5],[8,7,5,3,9,6,2,1,4],[4,6,1,5,8,2,9,7,3]]
1982	[[4,5,3,1,2,8,6,7,9],[8,2,6,9,7,5,4,1,3],[7,9,1,4,3,6,8,5,2],[3,6,5,7,8,1,9,2,4],[1,8,9,6,4,2,7,3,5],[2,7,4,5,9,3,1,8,6],[5,4,8,3,6,7,2,9,1],[9,3,7,2,1,4,5,6,8],[6,1,2,8,5,9,3,4,7]]
1983	[[2,8,7,5,3,1,4,6,9],[6,5,1,2,9,4,7,8,3],[3,4,9,8,6,7,2,5,1],[9,7,8,3,1,5,6,2,4],[5,1,6,4,2,9,3,7,8],[4,3,2,6,7,8,9,1,5],[7,9,3,1,8,6,5,4,2],[8,6,4,9,5,2,1,3,7],[1,2,5,7,4,3,8,9,6]]
1984	[[8,3,2,7,5,6,1,9,4],[5,6,4,1,9,8,3,2,7],[7,9,1,3,4,2,5,8,6],[9,2,7,6,1,3,4,5,8],[3,1,8,4,2,5,6,7,9],[4,5,6,9,8,7,2,1,3],[1,8,9,5,6,4,7,3,2],[2,4,3,8,7,1,9,6,5],[6,7,5,2,3,9,8,4,1]]
1985	[[9,3,5,8,6,2,7,1,4],[6,4,7,9,1,5,2,3,8],[2,8,1,4,7,3,9,6,5],[8,2,4,7,5,6,3,9,1],[1,9,3,2,4,8,6,5,7],[5,7,6,3,9,1,8,4,2],[7,1,2,6,3,4,5,8,9],[3,5,8,1,2,9,4,7,6],[4,6,9,5,8,7,1,2,3]]
1986	[[4,3,2,9,1,7,8,5,6],[1,5,9,3,6,8,7,4,2],[6,7,8,5,2,4,9,1,3],[7,4,3,1,9,6,2,8,5],[9,8,1,4,5,2,3,6,7],[2,6,5,8,7,3,4,9,1],[8,2,7,6,4,5,1,3,9],[5,9,4,7,3,1,6,2,8],[3,1,6,2,8,9,5,7,4]]
1987	[[6,4,3,9,7,5,1,8,2],[2,1,7,4,8,6,5,9,3],[8,9,5,2,1,3,4,7,6],[4,5,8,6,2,7,9,3,1],[1,3,2,8,5,9,7,6,4],[7,6,9,3,4,1,8,2,5],[3,7,6,1,9,4,2,5,8],[5,2,4,7,3,8,6,1,9],[9,8,1,5,6,2,3,4,7]]
1988	[[3,4,6,8,1,7,9,2,5],[7,9,8,4,5,2,1,6,3],[1,2,5,6,3,9,4,8,7],[2,8,3,1,9,4,5,7,6],[9,7,1,5,2,6,8,3,4],[5,6,4,3,7,8,2,1,9],[4,5,7,2,6,1,3,9,8],[8,1,9,7,4,3,6,5,2],[6,3,2,9,8,5,7,4,1]]
1989	[[5,7,4,1,6,8,2,3,9],[9,2,1,5,3,7,4,8,6],[8,3,6,9,4,2,7,5,1],[3,1,9,7,2,5,6,4,8],[6,4,7,8,1,3,9,2,5],[2,8,5,4,9,6,1,7,3],[7,9,2,3,8,1,5,6,4],[1,6,8,2,5,4,3,9,7],[4,5,3,6,7,9,8,1,2]]
1990	[[3,2,9,1,7,6,4,8,5],[5,7,4,8,2,3,9,6,1],[6,1,8,9,4,5,3,2,7],[4,9,6,5,3,8,7,1,2],[2,5,1,4,9,7,8,3,6],[7,8,3,2,6,1,5,4,9],[1,4,7,3,5,2,6,9,8],[8,3,5,6,1,9,2,7,4],[9,6,2,7,8,4,1,5,3]]
1991	[[3,4,8,6,9,5,2,1,7],[2,9,1,7,4,8,6,5,3],[7,6,5,1,3,2,4,8,9],[5,7,4,9,2,1,3,6,8],[9,1,6,8,7,3,5,4,2],[8,2,3,4,5,6,7,9,1],[6,5,7,2,8,9,1,3,4],[4,3,9,5,1,7,8,2,6],[1,8,2,3,6,4,9,7,5]]
1992	[[1,9,2,6,5,3,7,4,8],[7,3,5,8,4,9,1,2,6],[6,4,8,7,2,1,5,9,3],[5,1,9,2,7,8,3,6,4],[2,7,4,3,9,6,8,5,1],[8,6,3,5,1,4,2,7,9],[3,5,6,9,8,2,4,1,7],[9,2,1,4,3,7,6,8,5],[4,8,7,1,6,5,9,3,2]]
1993	[[8,1,6,7,4,9,5,3,2],[3,4,2,8,5,1,9,6,7],[7,5,9,2,6,3,1,4,8],[2,6,1,3,7,5,4,8,9],[9,8,3,4,2,6,7,1,5],[4,7,5,1,9,8,3,2,6],[1,2,8,9,3,7,6,5,4],[6,9,4,5,1,2,8,7,3],[5,3,7,6,8,4,2,9,1]]
1994	[[2,5,9,3,6,4,1,8,7],[1,7,3,5,9,8,2,4,6],[6,4,8,7,1,2,3,5,9],[8,2,7,1,5,6,4,9,3],[5,3,4,8,2,9,6,7,1],[9,1,6,4,3,7,8,2,5],[3,8,2,6,7,5,9,1,4],[4,6,5,9,8,1,7,3,2],[7,9,1,2,4,3,5,6,8]]
1995	[[3,9,4,2,7,6,5,1,8],[6,5,2,8,3,1,9,4,7],[8,1,7,5,9,4,3,2,6],[1,4,3,7,8,2,6,5,9],[9,7,6,1,5,3,2,8,4],[2,8,5,6,4,9,1,7,3],[4,2,1,9,6,7,8,3,5],[7,6,8,3,1,5,4,9,2],[5,3,9,4,2,8,7,6,1]]
1996	[[4,8,2,5,1,6,9,3,7],[1,6,3,9,2,7,5,4,8],[9,7,5,8,4,3,1,6,2],[6,1,9,3,7,2,4,8,5],[8,3,4,6,5,1,2,7,9],[2,5,7,4,8,9,6,1,3],[5,2,6,7,3,4,8,9,1],[7,9,1,2,6,8,3,5,4],[3,4,8,1,9,5,7,2,6]]
1997	[[9,2,4,7,1,5,8,3,6],[6,1,7,8,3,2,9,4,5],[3,5,8,9,4,6,2,7,1],[4,6,1,5,2,8,3,9,7],[5,8,9,3,6,7,4,1,2],[2,7,3,1,9,4,5,6,8],[1,9,6,2,5,3,7,8,4],[8,3,5,4,7,1,6,2,9],[7,4,2,6,8,9,1,5,3]]
1998	[[9,3,1,6,8,2,5,4,7],[5,2,7,9,4,3,6,8,1],[8,4,6,5,1,7,9,2,3],[6,1,3,8,9,5,4,7,2],[7,9,5,3,2,4,8,1,6],[4,8,2,1,7,6,3,5,9],[1,6,9,7,5,8,2,3,4],[3,5,4,2,6,1,7,9,8],[2,7,8,4,3,9,1,6,5]]
1999	[[5,7,8,6,4,1,2,9,3],[1,4,9,2,8,3,6,5,7],[2,6,3,7,5,9,1,4,8],[6,1,5,8,9,7,3,2,4],[9,3,4,5,6,2,8,7,1],[7,8,2,1,3,4,9,6,5],[4,5,6,9,1,8,7,3,2],[3,2,1,4,7,6,5,8,9],[8,9,7,3,2,5,4,1,6]]
2000	[[8,2,3,1,6,4,5,7,9],[5,1,6,7,9,2,8,4,3],[4,7,9,3,8,5,2,6,1],[3,4,7,5,1,8,9,2,6],[2,6,5,9,4,7,3,1,8],[9,8,1,2,3,6,7,5,4],[7,3,8,6,2,1,4,9,5],[1,9,2,4,5,3,6,8,7],[6,5,4,8,7,9,1,3,2]]
2001	[[4,7,2,3,6,1,5,9,8],[6,9,8,5,7,2,4,3,1],[3,5,1,8,9,4,6,2,7],[2,3,6,9,1,8,7,4,5],[5,1,9,7,4,6,3,8,2],[8,4,7,2,3,5,9,1,6],[1,6,5,4,8,3,2,7,9],[9,8,4,6,2,7,1,5,3],[7,2,3,1,5,9,8,6,4]]
2002	[[5,2,3,7,4,9,6,8,1],[4,9,1,3,8,6,2,5,7],[6,8,7,5,1,2,9,3,4],[3,1,5,2,6,7,4,9,8],[9,7,2,4,5,8,3,1,6],[8,6,4,9,3,1,5,7,2],[2,3,9,1,7,4,8,6,5],[1,5,8,6,2,3,7,4,9],[7,4,6,8,9,5,1,2,3]]
2003	[[8,2,3,6,9,4,1,5,7],[4,6,5,1,7,8,9,3,2],[7,9,1,2,3,5,6,8,4],[5,3,7,9,6,1,4,2,8],[6,8,2,4,5,3,7,9,1],[9,1,4,8,2,7,5,6,3],[3,5,9,7,4,2,8,1,6],[2,7,8,5,1,6,3,4,9],[1,4,6,3,8,9,2,7,5]]
2004	[[9,2,8,4,6,7,5,1,3],[7,4,3,1,2,5,8,9,6],[6,5,1,9,8,3,4,2,7],[4,8,6,3,9,2,1,7,5],[3,7,9,5,1,8,2,6,4],[2,1,5,7,4,6,3,8,9],[8,3,2,6,5,9,7,4,1],[1,6,7,8,3,4,9,5,2],[5,9,4,2,7,1,6,3,8]]
2005	[[9,4,7,5,1,8,6,2,3],[2,1,8,3,9,6,5,4,7],[3,6,5,4,7,2,1,8,9],[4,7,2,8,6,5,3,9,1],[1,8,6,7,3,9,2,5,4],[5,3,9,1,2,4,8,7,6],[8,5,3,9,4,1,7,6,2],[6,9,1,2,8,7,4,3,5],[7,2,4,6,5,3,9,1,8]]
2006	[[2,1,6,8,5,4,7,3,9],[4,8,7,6,9,3,5,2,1],[5,3,9,1,2,7,6,4,8],[9,6,4,3,7,2,1,8,5],[1,2,5,9,8,6,4,7,3],[3,7,8,5,4,1,9,6,2],[7,4,3,2,1,9,8,5,6],[6,5,1,7,3,8,2,9,4],[8,9,2,4,6,5,3,1,7]]
2007	[[6,2,9,4,1,8,7,5,3],[5,7,4,6,3,9,1,2,8],[3,1,8,7,5,2,6,9,4],[7,9,1,3,2,6,4,8,5],[4,6,3,8,9,5,2,7,1],[2,8,5,1,4,7,3,6,9],[1,5,2,9,6,4,8,3,7],[9,3,7,2,8,1,5,4,6],[8,4,6,5,7,3,9,1,2]]
2008	[[4,6,1,7,3,9,2,8,5],[3,5,9,2,1,8,4,6,7],[2,7,8,4,6,5,3,9,1],[1,9,7,5,2,4,8,3,6],[8,3,5,9,7,6,1,2,4],[6,4,2,1,8,3,5,7,9],[9,8,3,6,4,1,7,5,2],[7,1,6,3,5,2,9,4,8],[5,2,4,8,9,7,6,1,3]]
2009	[[3,5,4,9,6,2,1,7,8],[2,7,8,3,4,1,5,6,9],[1,6,9,7,5,8,3,2,4],[9,1,2,6,8,7,4,3,5],[8,3,5,2,1,4,6,9,7],[7,4,6,5,3,9,8,1,2],[5,2,1,4,9,6,7,8,3],[4,8,7,1,2,3,9,5,6],[6,9,3,8,7,5,2,4,1]]
2010	[[4,3,7,1,6,8,2,5,9],[8,5,6,2,4,9,1,7,3],[2,9,1,7,3,5,8,6,4],[6,4,5,8,9,2,3,1,7],[9,7,8,3,5,1,4,2,6],[3,1,2,4,7,6,9,8,5],[7,2,9,6,1,3,5,4,8],[5,8,4,9,2,7,6,3,1],[1,6,3,5,8,4,7,9,2]]
2011	[[7,6,3,1,4,8,2,9,5],[5,1,8,2,7,9,3,4,6],[4,2,9,6,3,5,1,7,8],[3,8,4,5,2,6,9,1,7],[9,5,2,7,8,1,6,3,4],[1,7,6,3,9,4,5,8,2],[8,3,5,4,1,2,7,6,9],[2,9,7,8,6,3,4,5,1],[6,4,1,9,5,7,8,2,3]]
2012	[[2,1,4,6,8,3,7,9,5],[7,5,3,9,4,1,2,6,8],[9,6,8,2,5,7,3,1,4],[3,4,5,1,6,9,8,2,7],[6,8,2,5,7,4,1,3,9],[1,7,9,3,2,8,4,5,6],[4,2,6,8,1,5,9,7,3],[5,3,7,4,9,2,6,8,1],[8,9,1,7,3,6,5,4,2]]
2013	[[6,2,3,1,8,4,9,5,7],[4,1,9,7,3,5,2,6,8],[7,8,5,9,2,6,1,4,3],[2,7,1,8,4,9,6,3,5],[3,5,8,6,7,1,4,9,2],[9,6,4,2,5,3,7,8,1],[8,9,6,5,1,2,3,7,4],[1,3,7,4,9,8,5,2,6],[5,4,2,3,6,7,8,1,9]]
2014	[[3,5,2,8,4,6,9,1,7],[4,6,9,7,5,1,8,3,2],[8,1,7,2,3,9,5,6,4],[7,4,6,5,2,8,1,9,3],[9,8,5,3,1,4,7,2,6],[2,3,1,6,9,7,4,5,8],[1,2,8,4,6,5,3,7,9],[6,9,4,1,7,3,2,8,5],[5,7,3,9,8,2,6,4,1]]
2015	[[3,6,4,5,2,7,9,1,8],[5,1,2,8,4,9,6,3,7],[7,9,8,6,3,1,5,2,4],[1,2,5,4,6,3,7,8,9],[9,8,6,1,7,5,2,4,3],[4,7,3,2,9,8,1,6,5],[2,5,7,3,1,4,8,9,6],[6,3,9,7,8,2,4,5,1],[8,4,1,9,5,6,3,7,2]]
2016	[[6,8,5,1,2,4,9,7,3],[4,7,2,9,3,5,8,1,6],[1,9,3,8,7,6,2,4,5],[3,5,4,2,1,7,6,9,8],[9,6,7,5,4,8,1,3,2],[8,2,1,6,9,3,4,5,7],[2,4,8,3,5,1,7,6,9],[5,1,6,7,8,9,3,2,4],[7,3,9,4,6,2,5,8,1]]
2017	[[6,4,7,5,3,8,2,1,9],[2,9,3,1,6,7,4,5,8],[8,5,1,2,4,9,7,6,3],[9,7,8,4,2,1,5,3,6],[4,3,6,9,8,5,1,2,7],[1,2,5,6,7,3,8,9,4],[7,8,9,3,5,2,6,4,1],[3,6,2,8,1,4,9,7,5],[5,1,4,7,9,6,3,8,2]]
2018	[[7,9,1,5,6,8,2,4,3],[2,4,6,7,3,9,1,5,8],[5,3,8,1,2,4,7,6,9],[3,7,4,8,9,6,5,2,1],[8,5,9,4,1,2,6,3,7],[6,1,2,3,7,5,9,8,4],[4,8,7,6,5,1,3,9,2],[9,6,3,2,4,7,8,1,5],[1,2,5,9,8,3,4,7,6]]
2019	[[4,9,5,1,3,6,7,8,2],[6,1,8,7,9,2,5,4,3],[7,2,3,8,5,4,9,1,6],[1,3,9,2,6,8,4,7,5],[2,5,7,3,4,1,6,9,8],[8,6,4,5,7,9,3,2,1],[5,7,2,9,1,3,8,6,4],[9,8,6,4,2,5,1,3,7],[3,4,1,6,8,7,2,5,9]]
2020	[[2,4,8,1,9,6,7,3,5],[9,3,1,7,2,5,4,8,6],[6,7,5,3,4,8,2,1,9],[1,2,7,9,6,4,3,5,8],[3,9,4,5,8,7,1,6,2],[8,5,6,2,3,1,9,4,7],[7,1,9,6,5,3,8,2,4],[4,6,2,8,1,9,5,7,3],[5,8,3,4,7,2,6,9,1]]
2021	[[8,6,4,7,9,5,2,1,3],[1,7,2,6,3,4,8,9,5],[9,5,3,2,8,1,4,7,6],[4,1,5,9,2,6,7,3,8],[2,8,9,3,5,7,6,4,1],[6,3,7,4,1,8,9,5,2],[7,9,1,8,6,3,5,2,4],[5,4,8,1,7,2,3,6,9],[3,2,6,5,4,9,1,8,7]]
2022	[[5,1,3,9,6,7,8,2,4],[8,6,9,4,2,1,5,3,7],[7,2,4,3,5,8,9,6,1],[2,3,8,6,1,4,7,9,5],[6,5,1,7,3,9,4,8,2],[9,4,7,5,8,2,6,1,3],[1,7,2,8,9,5,3,4,6],[3,8,5,1,4,6,2,7,9],[4,9,6,2,7,3,1,5,8]]
2023	[[7,5,4,2,9,1,3,6,8],[3,1,9,6,4,8,2,5,7],[8,6,2,5,3,7,9,4,1],[6,7,5,8,1,9,4,2,3],[2,3,1,4,7,6,8,9,5],[4,9,8,3,2,5,7,1,6],[1,2,3,7,6,4,5,8,9],[5,4,6,9,8,3,1,7,2],[9,8,7,1,5,2,6,3,4]]
2024	[[2,7,4,1,5,9,8,3,6],[8,5,9,3,6,4,2,1,7],[3,6,1,7,2,8,9,5,4],[4,1,5,6,8,7,3,9,2],[7,9,3,4,1,2,6,8,5],[6,8,2,9,3,5,7,4,1],[5,4,8,2,7,3,1,6,9],[9,2,6,8,4,1,5,7,3],[1,3,7,5,9,6,4,2,8]]
2025	[[4,9,3,2,1,7,8,5,6],[8,2,5,9,6,3,7,1,4],[6,1,7,5,4,8,2,9,3],[9,3,6,4,7,5,1,8,2],[2,8,1,3,9,6,4,7,5],[7,5,4,8,2,1,6,3,9],[1,7,9,6,5,4,3,2,8],[5,6,8,1,3,2,9,4,7],[3,4,2,7,8,9,5,6,1]]
2026	[[3,9,7,4,1,8,2,5,6],[4,2,6,9,7,5,3,1,8],[5,1,8,6,2,3,4,7,9],[2,6,1,7,3,9,5,8,4],[9,8,4,5,6,1,7,2,3],[7,5,3,8,4,2,6,9,1],[8,3,9,2,5,4,1,6,7],[1,7,2,3,9,6,8,4,5],[6,4,5,1,8,7,9,3,2]]
2027	[[2,6,8,3,5,9,7,1,4],[7,3,4,2,8,1,5,6,9],[9,1,5,4,7,6,3,2,8],[3,4,6,7,1,5,9,8,2],[5,2,1,8,9,3,6,4,7],[8,9,7,6,2,4,1,5,3],[6,8,2,1,3,7,4,9,5],[4,7,9,5,6,2,8,3,1],[1,5,3,9,4,8,2,7,6]]
2028	[[2,7,9,6,4,8,3,1,5],[3,5,1,2,9,7,6,8,4],[8,4,6,3,5,1,2,9,7],[7,6,3,1,8,5,9,4,2],[9,8,5,4,7,2,1,6,3],[4,1,2,9,3,6,7,5,8],[6,2,7,8,1,4,5,3,9],[1,9,4,5,2,3,8,7,6],[5,3,8,7,6,9,4,2,1]]
2029	[[2,3,5,7,4,6,8,9,1],[9,6,1,8,5,2,4,7,3],[8,7,4,3,9,1,5,6,2],[6,2,8,9,1,4,3,5,7],[7,4,3,2,8,5,9,1,6],[1,5,9,6,7,3,2,8,4],[4,9,7,1,2,8,6,3,5],[3,8,2,5,6,7,1,4,9],[5,1,6,4,3,9,7,2,8]]
2030	[[9,5,1,2,3,7,6,4,8],[2,4,7,6,5,8,3,1,9],[3,8,6,1,9,4,5,2,7],[1,3,2,5,8,9,7,6,4],[7,9,8,3,4,6,2,5,1],[4,6,5,7,2,1,8,9,3],[5,1,3,9,7,2,4,8,6],[8,7,9,4,6,5,1,3,2],[6,2,4,8,1,3,9,7,5]]
2031	[[4,8,1,7,2,9,6,5,3],[6,7,5,1,3,8,9,2,4],[2,3,9,4,5,6,8,1,7],[5,6,8,3,1,2,7,4,9],[7,2,3,8,9,4,1,6,5],[1,9,4,5,6,7,2,3,8],[9,4,6,2,7,3,5,8,1],[8,5,7,6,4,1,3,9,2],[3,1,2,9,8,5,4,7,6]]
2032	[[8,2,1,3,5,9,4,7,6],[9,5,6,7,4,1,8,2,3],[4,3,7,6,2,8,1,5,9],[1,7,3,9,6,4,5,8,2],[6,8,2,1,7,5,3,9,4],[5,9,4,8,3,2,7,6,1],[2,1,9,5,8,3,6,4,7],[7,4,8,2,1,6,9,3,5],[3,6,5,4,9,7,2,1,8]]
2033	[[9,8,6,5,3,7,1,2,4],[5,7,4,1,6,2,9,8,3],[1,3,2,4,9,8,7,6,5],[4,5,7,6,8,1,3,9,2],[3,6,9,7,2,4,5,1,8],[8,2,1,3,5,9,4,7,6],[2,9,5,8,1,3,6,4,7],[6,4,8,9,7,5,2,3,1],[7,1,3,2,4,6,8,5,9]]
2034	[[1,7,6,9,4,8,2,5,3],[8,3,4,1,5,2,6,9,7],[5,2,9,6,3,7,1,8,4],[4,5,8,2,1,6,3,7,9],[9,1,3,8,7,5,4,6,2],[2,6,7,3,9,4,5,1,8],[6,9,1,4,8,3,7,2,5],[3,8,5,7,2,1,9,4,6],[7,4,2,5,6,9,8,3,1]]
2035	[[5,8,7,6,3,4,9,2,1],[1,4,6,7,9,2,3,5,8],[9,2,3,1,8,5,7,4,6],[8,7,2,3,5,9,6,1,4],[3,5,1,8,4,6,2,7,9],[4,6,9,2,1,7,8,3,5],[6,3,8,5,7,1,4,9,2],[2,9,5,4,6,3,1,8,7],[7,1,4,9,2,8,5,6,3]]
2036	[[9,5,7,4,1,8,6,3,2],[8,6,1,7,2,3,5,9,4],[3,4,2,6,9,5,7,8,1],[6,3,8,2,5,7,4,1,9],[2,1,9,3,6,4,8,7,5],[5,7,4,1,8,9,3,2,6],[4,9,5,8,3,1,2,6,7],[7,2,3,9,4,6,1,5,8],[1,8,6,5,7,2,9,4,3]]
2037	[[8,5,2,4,3,6,1,7,9],[6,3,1,2,9,7,5,8,4],[4,9,7,1,8,5,6,2,3],[2,6,8,7,1,9,4,3,5],[9,1,3,8,5,4,7,6,2],[7,4,5,6,2,3,8,9,1],[1,2,9,5,6,8,3,4,7],[5,8,4,3,7,2,9,1,6],[3,7,6,9,4,1,2,5,8]]
2038	[[3,6,5,9,2,8,4,7,1],[1,4,9,7,3,6,2,5,8],[7,2,8,4,5,1,9,3,6],[5,1,6,8,4,9,3,2,7],[4,7,3,5,1,2,8,6,9],[8,9,2,3,6,7,5,1,4],[9,3,4,6,7,5,1,8,2],[2,8,7,1,9,3,6,4,5],[6,5,1,2,8,4,7,9,3]]
2039	[[2,4,3,8,1,5,6,9,7],[7,6,8,4,9,2,1,5,3],[1,9,5,7,3,6,2,4,8],[4,2,6,5,8,1,7,3,9],[8,5,7,9,2,3,4,1,6],[3,1,9,6,4,7,8,2,5],[9,3,4,2,6,8,5,7,1],[5,8,1,3,7,4,9,6,2],[6,7,2,1,5,9,3,8,4]]
2040	[[6,7,1,3,8,5,9,4,2],[3,2,5,9,6,4,1,8,7],[4,9,8,1,2,7,3,5,6],[1,5,2,7,3,8,4,6,9],[7,4,9,5,1,6,2,3,8],[8,6,3,2,4,9,7,1,5],[5,1,4,6,9,2,8,7,3],[2,3,6,8,7,1,5,9,4],[9,8,7,4,5,3,6,2,1]]
2041	[[3,9,4,8,7,2,1,5,6],[2,6,8,5,1,9,4,3,7],[1,5,7,4,6,3,2,8,9],[8,4,1,7,2,6,5,9,3],[5,7,2,3,9,8,6,4,1],[9,3,6,1,5,4,7,2,8],[4,2,3,6,8,1,9,7,5],[7,1,9,2,3,5,8,6,4],[6,8,5,9,4,7,3,1,2]]
2042	[[8,9,6,2,3,7,5,1,4],[2,4,5,1,9,8,7,3,6],[1,7,3,5,4,6,2,8,9],[3,5,1,4,2,9,6,7,8],[6,8,9,3,7,5,4,2,1],[7,2,4,8,6,1,9,5,3],[4,1,7,9,5,3,8,6,2],[5,3,2,6,8,4,1,9,7],[9,6,8,7,1,2,3,4,5]]
2043	[[3,5,7,4,8,9,2,6,1],[4,1,8,2,6,5,7,3,9],[9,6,2,3,7,1,8,5,4],[5,8,4,1,2,6,9,7,3],[2,9,1,8,3,7,5,4,6],[6,7,3,9,5,4,1,8,2],[1,4,5,7,9,3,6,2,8],[8,3,6,5,1,2,4,9,7],[7,2,9,6,4,8,3,1,5]]
2044	[[4,2,7,6,8,5,1,3,9],[9,5,3,7,4,1,8,2,6],[8,1,6,2,3,9,7,4,5],[2,7,8,4,1,6,5,9,3],[3,6,9,8,5,2,4,1,7],[1,4,5,3,9,7,6,8,2],[5,8,2,9,7,4,3,6,1],[7,9,4,1,6,3,2,5,8],[6,3,1,5,2,8,9,7,4]]
2045	[[4,2,6,7,3,1,5,8,9],[9,3,7,2,5,8,6,1,4],[1,8,5,9,6,4,2,7,3],[8,4,3,5,1,6,9,2,7],[2,5,9,8,4,7,1,3,6],[6,7,1,3,2,9,4,5,8],[5,6,4,1,7,3,8,9,2],[7,1,8,4,9,2,3,6,5],[3,9,2,6,8,5,7,4,1]]
2046	[[5,6,7,2,4,3,8,1,9],[2,4,8,9,1,5,6,3,7],[3,9,1,8,6,7,5,2,4],[6,3,4,5,2,8,9,7,1],[1,2,9,4,7,6,3,8,5],[7,8,5,1,3,9,2,4,6],[4,7,3,6,9,2,1,5,8],[9,5,2,7,8,1,4,6,3],[8,1,6,3,5,4,7,9,2]]
2047	[[8,7,6,5,3,2,4,9,1],[3,9,1,4,7,8,2,6,5],[2,4,5,6,1,9,8,7,3],[7,6,2,9,4,3,1,5,8],[9,1,3,8,2,5,6,4,7],[4,5,8,7,6,1,3,2,9],[6,8,9,1,5,4,7,3,2],[1,2,4,3,9,7,5,8,6],[5,3,7,2,8,6,9,1,4]]
2048	[[2,6,7,4,9,8,3,5,1],[1,5,8,2,7,3,9,6,4],[9,4,3,5,6,1,7,8,2],[5,2,1,9,8,4,6,3,7],[8,7,9,6,3,2,1,4,5],[4,3,6,1,5,7,8,2,9],[6,9,4,8,1,5,2,7,3],[7,8,5,3,2,9,4,1,6],[3,1,2,7,4,6,5,9,8]]
2049	[[7,4,2,9,3,6,1,5,8],[6,9,8,2,5,1,7,3,4],[1,3,5,7,8,4,9,2,6],[2,6,7,4,9,3,5,8,1],[4,5,1,6,7,8,2,9,3],[9,8,3,1,2,5,4,6,7],[5,1,6,3,4,2,8,7,9],[8,7,4,5,6,9,3,1,2],[3,2,9,8,1,7,6,4,5]]
2050	[[6,5,8,1,9,7,2,4,3],[7,2,3,4,6,8,9,5,1],[4,1,9,2,3,5,6,7,8],[3,8,4,9,1,2,5,6,7],[5,7,2,6,8,3,4,1,9],[9,6,1,5,7,4,3,8,2],[8,4,6,3,2,1,7,9,5],[2,9,7,8,5,6,1,3,4],[1,3,5,7,4,9,8,2,6]]
2051	[[8,5,1,3,9,4,2,6,7],[9,3,4,2,6,7,1,5,8],[2,7,6,8,1,5,3,4,9],[1,4,2,7,3,9,5,8,6],[5,8,9,1,4,6,7,2,3],[7,6,3,5,2,8,4,9,1],[3,9,5,6,7,2,8,1,4],[6,1,8,4,5,3,9,7,2],[4,2,7,9,8,1,6,3,5]]
2052	[[6,3,4,1,7,8,9,5,2],[7,9,2,4,3,5,6,8,1],[8,1,5,6,2,9,7,4,3],[4,5,6,9,1,2,8,3,7],[9,7,1,5,8,3,2,6,4],[3,2,8,7,6,4,1,9,5],[1,4,3,2,9,6,5,7,8],[2,8,9,3,5,7,4,1,6],[5,6,7,8,4,1,3,2,9]]
2053	[[9,8,7,3,2,6,1,4,5],[3,2,1,4,5,9,6,8,7],[5,4,6,7,8,1,9,3,2],[2,3,5,9,1,8,4,7,6],[6,9,4,5,3,7,2,1,8],[7,1,8,2,6,4,3,5,9],[4,5,3,6,7,2,8,9,1],[1,6,9,8,4,5,7,2,3],[8,7,2,1,9,3,5,6,4]]
2054	[[1,3,2,9,8,5,7,4,6],[9,6,4,1,7,3,5,8,2],[7,5,8,6,4,2,1,9,3],[8,9,7,4,6,1,3,2,5],[5,1,6,2,3,8,4,7,9],[2,4,3,7,5,9,8,6,1],[3,8,9,5,2,7,6,1,4],[4,2,5,8,1,6,9,3,7],[6,7,1,3,9,4,2,5,8]]
2055	[[2,7,5,9,8,6,3,4,1],[6,3,1,4,5,7,2,9,8],[8,9,4,1,2,3,7,6,5],[7,8,3,5,6,2,4,1,9],[9,5,6,7,1,4,8,2,3],[1,4,2,8,3,9,5,7,6],[5,2,9,3,7,1,6,8,4],[4,6,8,2,9,5,1,3,7],[3,1,7,6,4,8,9,5,2]]
2056	[[8,2,9,7,5,4,1,6,3],[3,5,7,1,6,9,4,2,8],[1,6,4,8,3,2,7,5,9],[6,4,3,5,2,7,9,8,1],[9,7,8,6,1,3,5,4,2],[2,1,5,4,9,8,3,7,6],[4,9,1,2,8,5,6,3,7],[5,8,6,3,7,1,2,9,4],[7,3,2,9,4,6,8,1,5]]
2057	[[2,7,4,9,5,1,6,3,8],[1,8,6,7,3,4,2,9,5],[3,9,5,2,6,8,4,7,1],[9,4,1,8,7,6,5,2,3],[7,5,8,3,4,2,1,6,9],[6,2,3,1,9,5,8,4,7],[4,6,9,5,1,3,7,8,2],[8,1,7,4,2,9,3,5,6],[5,3,2,6,8,7,9,1,4]]
2058	[[1,8,5,3,7,2,6,9,4],[9,2,6,4,5,1,3,7,8],[3,4,7,9,8,6,5,1,2],[7,6,9,8,4,5,1,2,3],[8,1,4,2,6,3,9,5,7],[2,5,3,7,1,9,4,8,6],[4,9,8,1,3,7,2,6,5],[5,7,1,6,2,4,8,3,9],[6,3,2,5,9,8,7,4,1]]
2059	[[8,2,1,7,6,3,5,9,4],[3,6,5,4,1,9,2,7,8],[4,7,9,8,2,5,3,1,6],[1,4,6,3,5,7,8,2,9],[5,9,7,1,8,2,4,6,3],[2,8,3,9,4,6,1,5,7],[7,5,4,6,3,1,9,8,2],[6,3,2,5,9,8,7,4,1],[9,1,8,2,7,4,6,3,5]]
2060	[[8,5,1,2,7,9,6,4,3],[7,9,4,3,1,6,2,8,5],[2,6,3,8,4,5,1,7,9],[6,3,5,9,8,1,4,2,7],[4,8,2,6,3,7,5,9,1],[9,1,7,5,2,4,8,3,6],[5,7,9,4,6,2,3,1,8],[1,2,8,7,5,3,9,6,4],[3,4,6,1,9,8,7,5,2]]
2061	[[6,4,7,3,8,5,2,1,9],[3,1,2,7,9,4,8,5,6],[5,8,9,1,6,2,3,4,7],[9,7,6,8,4,1,5,3,2],[8,5,4,2,3,7,9,6,1],[2,3,1,9,5,6,4,7,8],[7,6,8,4,2,3,1,9,5],[1,2,3,5,7,9,6,8,4],[4,9,5,6,1,8,7,2,3]]
2062	[[7,8,5,9,3,4,2,1,6],[2,6,4,5,1,7,3,9,8],[9,3,1,6,8,2,4,5,7],[5,7,3,8,4,6,1,2,9],[6,4,8,1,2,9,5,7,3],[1,2,9,7,5,3,8,6,4],[8,5,6,3,9,1,7,4,2],[4,1,7,2,6,8,9,3,5],[3,9,2,4,7,5,6,8,1]]
2063	[[7,6,8,3,1,5,9,4,2],[1,4,2,9,8,6,7,3,5],[5,3,9,2,4,7,1,8,6],[2,5,4,1,7,3,8,6,9],[6,8,7,5,9,4,2,1,3],[3,9,1,6,2,8,5,7,4],[8,2,5,4,6,1,3,9,7],[4,1,3,7,5,9,6,2,8],[9,7,6,8,3,2,4,5,1]]
2064	[[2,1,8,5,7,6,4,9,3],[3,6,5,4,9,1,8,7,2],[7,9,4,3,2,8,6,5,1],[5,2,1,8,4,9,3,6,7],[6,7,9,1,3,2,5,8,4],[8,4,3,6,5,7,1,2,9],[4,8,7,2,1,5,9,3,6],[9,3,6,7,8,4,2,1,5],[1,5,2,9,6,3,7,4,8]]
2065	[[2,3,1,4,9,5,6,7,8],[8,6,9,1,7,2,3,5,4],[4,7,5,3,8,6,1,9,2],[5,4,7,6,1,3,8,2,9],[9,1,2,8,5,7,4,3,6],[3,8,6,9,2,4,5,1,7],[6,2,8,7,3,1,9,4,5],[7,9,3,5,4,8,2,6,1],[1,5,4,2,6,9,7,8,3]]
2066	[[8,7,1,5,2,6,9,4,3],[3,4,2,7,8,9,5,1,6],[9,6,5,1,3,4,7,2,8],[1,2,6,3,7,8,4,5,9],[4,8,9,6,5,1,3,7,2],[7,5,3,9,4,2,8,6,1],[5,9,4,2,6,3,1,8,7],[6,3,7,8,1,5,2,9,4],[2,1,8,4,9,7,6,3,5]]
2067	[[9,2,6,8,5,4,3,1,7],[8,5,3,1,7,6,9,4,2],[1,4,7,2,3,9,8,5,6],[5,7,1,9,8,2,4,6,3],[3,8,4,6,1,7,2,9,5],[6,9,2,3,4,5,7,8,1],[7,1,9,4,6,3,5,2,8],[2,6,5,7,9,8,1,3,4],[4,3,8,5,2,1,6,7,9]]
2068	[[1,7,5,2,6,9,8,3,4],[9,4,3,7,5,8,6,1,2],[2,6,8,1,3,4,7,5,9],[3,8,9,6,1,7,4,2,5],[4,1,7,8,2,5,3,9,6],[5,2,6,9,4,3,1,8,7],[6,9,1,4,8,2,5,7,3],[7,3,4,5,9,1,2,6,8],[8,5,2,3,7,6,9,4,1]]
2069	[[2,5,8,4,7,6,3,1,9],[9,4,6,1,8,3,5,2,7],[3,1,7,5,9,2,4,6,8],[4,7,2,8,6,9,1,3,5],[6,3,5,7,1,4,9,8,2],[1,8,9,2,3,5,7,4,6],[5,6,3,9,2,1,8,7,4],[7,2,4,3,5,8,6,9,1],[8,9,1,6,4,7,2,5,3]]
2070	[[7,6,3,1,8,5,2,9,4],[2,4,5,7,3,9,1,8,6],[9,1,8,2,4,6,7,5,3],[8,7,6,4,5,2,3,1,9],[5,2,1,6,9,3,8,4,7],[3,9,4,8,7,1,5,6,2],[1,3,2,9,6,8,4,7,5],[4,8,9,5,2,7,6,3,1],[6,5,7,3,1,4,9,2,8]]
2071	[[4,6,3,9,2,1,5,7,8],[1,8,2,5,7,3,4,9,6],[9,7,5,4,6,8,2,1,3],[7,2,4,3,8,9,1,6,5],[3,5,9,6,1,2,8,4,7],[6,1,8,7,5,4,3,2,9],[2,4,6,8,3,7,9,5,1],[8,9,7,1,4,5,6,3,2],[5,3,1,2,9,6,7,8,4]]
\.


--
-- Data for Name: display; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.display (display_id, display_type, display_color1, display_color2, display_color3, display_color4, display_color5) FROM stdin;
1	DARK	orange	rgb(39, 39, 39)	yellowgreen	rgb(80, 80, 80)	white
2	BRIGHT	orange	lightgrey	black	rgb(80, 80, 80)	white
\.


--
-- Data for Name: legal_notice; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.legal_notice (id, legal_notice_text) FROM stdin;
1	<p><strong class="ql-size-large">1. Présentation du site.</strong></p><p>&nbsp;</p><p>En vertu de l'article 6 de la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l'économie numérique, il est précisé aux utilisateurs du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;l'identité des différents intervenants dans le cadre de sa réalisation et de son suivi :</p><ul><li><strong>Propriétaire</strong>&nbsp;: Killian AUDIC – 7 route de Précigné, 72&nbsp;300 Sablé sur Sarthe</li><li><strong>Créateur</strong>&nbsp;: Killian AUDIC -&nbsp;<a href="https://www.planitools.com" target="_blank" style="color: rgb(102, 102, 102);">https://www.planitools</a></li><li><strong>Responsable publication</strong>&nbsp;: Killian AUDIC</li><li><strong>Webmaster</strong>&nbsp;: Killian AUDIC –&nbsp;<a href="mailto:contact@mcrevoulin.com" target="_blank" style="color: rgb(102, 102, 102);">killianaudic@gmail.com</a></li><li><strong>Hébergeur</strong>&nbsp;: <span style="background-color: rgb(255, 255, 255); color: rgb(33, 37, 41);">https://www.ni-host.com/</span></li></ul><p>&nbsp;</p><p><strong class="ql-size-large">2. Conditions générales d'utilisation du site et des services proposés.</strong></p><p>&nbsp;</p><p>L'utilisation du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;implique l'acceptation pleine et entière des conditions générales d'utilisation ci-après décrites. Ces conditions d'utilisation sont susceptibles d'être modifiées ou complétées à tout moment, les utilisateurs du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;sont donc invités à les consulter de manière régulière.</p><p>Ce site est normalement accessible à tout moment aux utilisateurs. Une interruption pour raison de maintenance technique peut être toutefois décidée par&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>, qui s'efforcera alors de communiquer préalablement aux utilisateurs les dates et heures de l'intervention.</p><p>Le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;est mis à jour régulièrement par Killian AUDIC. De la même façon, les mentions légales peuvent être modifiées à tout moment : elles s'imposent néanmoins à l'utilisateur qui est invité à s'y référer le plus souvent possible afin d'en prendre connaissance.</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">3. Description des services fournis.</strong></p><p>&nbsp;</p><p>Le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;a pour objet de fournir une information concernant l'ensemble des activités de la société.</p><p>Killian AUDIC s'efforce de fournir sur le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;des informations aussi précises que possible. Toutefois, il ne pourra être tenu responsable des omissions, des inexactitudes et des carences dans la mise à jour, qu'elles soient de son fait ou du fait des tiers partenaires qui lui fournissent ces informations.</p><p>Tous les informations indiquées sur le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;sont données à titre indicatif, et sont susceptibles d'évoluer. Par ailleurs, les renseignements figurant sur le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;ne sont pas exhaustifs. Ils sont donnés sous réserve de modifications ayant été apportées depuis leur mise en ligne.</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">4. Limitations contractuelles sur les données techniques.</strong></p><p>&nbsp;</p><p>Le site utilise la technologie JavaScript.</p><p>Le site Internet ne pourra être tenu responsable de dommages matériels liés à l'utilisation du site. De plus, l'utilisateur du site s'engage à accéder au site en utilisant un matériel récent, ne contenant pas de virus et avec un navigateur de dernière génération mis-à-jour.</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">5. Propriété intellectuelle et contrefaçons.</strong></p><p>&nbsp;</p><p>Killian AUDIC est propriétaire des droits de propriété intellectuelle ou détient les droits d'usage sur tous les éléments accessibles sur le site, notamment les textes, images, graphismes, logo, icônes, sons, logiciels.</p><p>Toute reproduction, représentation, modification, publication, adaptation de tout ou partie des éléments du site, quel que soit le moyen ou le procédé utilisé, est interdite, sauf autorisation écrite préalable de : Killian AUDIC.</p><p>Toute exploitation non autorisée du site ou de l'un quelconque des éléments qu'il contient sera considérée comme constitutive d'une contrefaçon et poursuivie conformément aux dispositions des articles L.335-2 et suivants du Code de Propriété Intellectuelle.</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">6. Limitations de responsabilité.</strong></p><p>&nbsp;</p><p>Killian AUDIC ne pourra être tenu responsable des dommages directs et indirects causés au matériel de l'utilisateur, lors de l'accès au site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>, et résultant soit de l'utilisation d'un matériel ne répondant pas aux spécifications indiquées au point 4, soit de l'apparition d'un bug ou d'une incompatibilité</p><p>Killian AUDIC ne pourra également être tenu responsable des dommages indirects (tels par exemple qu'une perte de marché ou perte d'une chance) consécutifs à l'utilisation du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>.</p><p>Des espaces interactifs (possibilité de poser des questions dans l'espace contact) sont à la disposition des utilisateurs. Killian AUDIC se réserve le droit de supprimer, sans mise en demeure préalable, tout contenu déposé dans cet espace qui contreviendrait à la législation applicable en France, en particulier aux dispositions relatives à la protection des données. Le cas échéant, Killian AUDIC se réserve également la possibilité de mettre en cause la responsabilité civile et/ou pénale de l'utilisateur, notamment en cas de message à caractère raciste, injurieux, diffamant, ou pornographique, quel que soit le support utilisé (texte, photographie…).</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">7. Gestion des données personnelles.</strong></p><p>&nbsp;</p><p>En France, les données personnelles sont notamment protégées par la loi n° 78-87 du 6 janvier 1978, la loi n° 2004-801 du 6 août 2004, l'article L. 226-13 du Code pénal et la Directive Européenne du 24 octobre 1995.</p><p>À l'occasion de l'utilisation du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>, peuvent êtres recueillies : l'URL des liens par l'intermédiaire desquels l'utilisateur a accédé au site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>, le fournisseur d'accès de l'utilisateur, l'adresse de protocole Internet (IP) de l'utilisateur.</p><p>En tout état de cause Killian AUDIC ne collecte des informations personnelles relatives à l'utilisateur que pour le besoin de certains services proposés par le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>. L'utilisateur fournit ces informations en toute connaissance de cause, notamment lorsqu'il procède par lui-même à leur saisie. Il est alors précisé à l'utilisateur du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;l'obligation ou non de fournir ces informations.</p><p>Conformément aux dispositions des articles 38 et suivants de la loi 78-17 du 6 janvier 1978 relative à l'informatique, aux fichiers et aux libertés, tout utilisateur dispose d'un droit d'accès, de rectification et d'opposition aux données personnelles le concernant, en effectuant sa demande écrite et signée, accompagnée d'une copie du titre d'identité avec signature du titulaire de la pièce, en précisant l'adresse à laquelle la réponse doit être envoyée.</p><p>Aucune information personnelle de l'utilisateur du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;n'est publiée à l'insu de l'utilisateur, échangée, transférée, cédée ou vendue sur un support quelconque à des tiers. Seule l'hypothèse du rachat de Killian AUDIC et de ses droits permettrait la transmission des dites informations à l'éventuel acquéreur qui serait à son tour tenu de la même obligation de conservation . et de modification des données vis à vis de l'utilisateur du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>.</p><p>Le site n'est pas déclaré à la CNIL car il ne recueille pas d'informations personnelles.</p><p>Les bases de données sont protégées par les dispositions de la loi du 1er juillet 1998 transposant la directive 96/9 du 11 mars 1996 relative à la protection juridique des bases de données.</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">8. Liens hypertextes et cookies.</strong></p><p>&nbsp;</p><p>Le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;contient un certain nombre de liens hypertextes vers d'autres sites, mis en place avec l'autorisation de Killian AUDIC. Cependant, Killian AUDIC n'a pas la possibilité de vérifier le contenu des sites ainsi visités, et n'assumera en conséquence aucune responsabilité de ce fait.</p><p>La navigation sur le site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;est susceptible de provoquer l'installation de cookie(s) sur l'ordinateur de l'utilisateur. Un cookie est un fichier de petite taille, qui ne permet pas l'identification de l'utilisateur, mais qui enregistre des informations relatives à la navigation d'un ordinateur sur un site. Les données ainsi obtenues visent à faciliter la navigation ultérieure sur le site, et ont également vocation à permettre diverses mesures de fréquentation.</p><p>Le refus d'installation d'un cookie peut entraîner l'impossibilité d'accéder à certains services. L'utilisateur peut toutefois configurer son ordinateur de la manière suivante, pour refuser l'installation des cookies :</p><p>Sous Internet Explorer : onglet outil / options internet. Cliquez sur Confidentialité et choisissez Bloquer tous les cookies. Validez sur Ok.</p><p>Sous Google Chrome, dans les paramètres, rubrique «&nbsp;Confidentialité et sécurité&nbsp;», puis dans «&nbsp;cookies et autres données des sites&nbsp;», vous pouvez sélectionner «&nbsp;Bloquer tous les cookies&nbsp;».</p><p>&nbsp;</p><p>Cookies de sessions présents sur ce site :</p><ul><li>__session: Cookie de session propre à express-session</li></ul><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">9. Droit applicable et attribution de juridiction.</strong></p><p>&nbsp;</p><p>Tout litige en relation avec l'utilisation du site&nbsp;<a href="http://www.planitools.com/sudoku/" target="_blank" style="color: rgb(102, 102, 102);">http://www.planitools.com/sudoku</a>&nbsp;est soumis aux tribunaux Francais compétents statuant selon le droit français.</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">10. Les principales lois concernées.</strong></p><p>&nbsp;</p><p>Loi n° 78-87 du 6 janvier 1978, notamment modifiée par la loi n° 2004-801 du 6 août 2004 relative à l'informatique, aux fichiers et aux libertés.</p><p>Loi n° 2004-575 du 21 juin 2004 pour la confiance dans l'économie numérique.</p><p><strong>&nbsp;</strong></p><p><strong class="ql-size-large">11. Lexique.</strong></p><p><br></p><p>Utilisateur : Internaute se connectant, utilisant le site susnommé.</p><h5>Informations personnelles : « les informations qui permettent, sous quelque forme que ce soit, directement ou non, l'identification des personnes physiques auxquelles elles s'appliquent » (article 4 de la loi n° 78-17 du 6 janvier 1978).</h5>
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.logs (id, date_of_logs, hostname, ip_address, url, headers, logs_error) FROM stdin;
1	2022-11-29	217.182.9.234	::1	/api/board/getBoard/Facile1	{"cookie":"__session=s%3A4hhoQSpSaA5coH07ZytnU0jDz40ggOA4.qohfjbo92oI9V8Jb7xM3MRyJkhYDr9Dr1GSTnTqpot8; _ga=GA1.1.720043703.1669737004; _ga_EFQWDNV04X=GS1.1.1669737003.1.1.1669740428.0.0.0; connect.sid=s%3A3by3XQBT4pXMFle9nVXKdkwhq4SUOO_3.bLHBVedXYNI%2BDfcVtYOa3DF7Ds8UybS80SlW%2BqjNMV0","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku/sudoku-solver","accept":"*/*","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	Cannot read properties of undefined (reading 'board_data')
2	2022-11-29	217.182.9.234	::1	/api/board/getBoard/Facile1	{"cookie":"__session=s%3A4hhoQSpSaA5coH07ZytnU0jDz40ggOA4.qohfjbo92oI9V8Jb7xM3MRyJkhYDr9Dr1GSTnTqpot8; _ga=GA1.1.720043703.1669737004; connect.sid=s%3AFA5AMC7Ob8vM1Uhg8Wm3YBwiabYo3ZBP.4PIjQUL6WzMhSePO0RsPmTtDUmV%2F9Q5yRJmHv0Jp77w; _ga_EFQWDNV04X=GS1.1.1669737003.1.1.1669740907.0.0.0","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku/sudoku-solver","accept":"*/*","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	Cannot read properties of undefined (reading 'board_data')
3	2022-11-29	217.182.9.234	::1	/api/board/getBoard/Facile1	{"cookie":"__session=s%3A4hhoQSpSaA5coH07ZytnU0jDz40ggOA4.qohfjbo92oI9V8Jb7xM3MRyJkhYDr9Dr1GSTnTqpot8; _ga=GA1.1.720043703.1669737004; connect.sid=s%3AFA5AMC7Ob8vM1Uhg8Wm3YBwiabYo3ZBP.4PIjQUL6WzMhSePO0RsPmTtDUmV%2F9Q5yRJmHv0Jp77w; _ga_EFQWDNV04X=GS1.1.1669737003.1.1.1669740907.0.0.0","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku/sudoku-solver","accept":"*/*","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	Cannot read properties of undefined (reading 'board_data')
4	2022-11-29	217.182.9.234	::1	/api/board/getBoard/Facile1	{"cookie":"__session=s%3A4hhoQSpSaA5coH07ZytnU0jDz40ggOA4.qohfjbo92oI9V8Jb7xM3MRyJkhYDr9Dr1GSTnTqpot8; _ga=GA1.1.720043703.1669737004; connect.sid=s%3AFA5AMC7Ob8vM1Uhg8Wm3YBwiabYo3ZBP.4PIjQUL6WzMhSePO0RsPmTtDUmV%2F9Q5yRJmHv0Jp77w; _ga_EFQWDNV04X=GS1.1.1669737003.1.1.1669740907.0.0.0","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku/sudoku-solver","accept":"*/*","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	Cannot read properties of undefined (reading 'board_data')
5	2022-11-30	217.182.9.234	::1	/sudoku-solver/database	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; connect.sid=s%3A3CnRiCxgv8_ZgYGH3MLMZnsyGBtMFuBc.eNiQTHjIhWG8fA00xpsuP8UAyZM24c9qedpjWY5I1cI; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669797015.0.0.0","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku-solver","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	/home/ubuntu/projects/Sudoku-Solver/app/views/adminDB.ejs:3\n    1| <%- include('./partials/header'); %>\n    2| \n >> 3|     <%- include('./partials/DataBaseForm'); %>\n    4| \n    5|         <div>\n    6| \n\n/home/ubuntu/projects/Sudoku-Solver/app/views/partials/DataBaseForm.ejs:4\n    2| \n    3|     <label class="form__consigne" for="level-selection">NB GRILLES<br> EN BASE</label>\n >> 4|     <input class="inputAdmin" id="boardsCount" value="<% if (data[0].count){ %>\n    5|         <%= locals.data[0].count %>\n    6|             <% } %>">\n    7| \n\nCannot read properties of undefined (reading 'count')
6	2022-11-30	217.182.9.234	::1	/sudoku-solver/database	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669797015.0.0.0; connect.sid=s%3A4YAlaDTC3qwSa3GjJNLYW468C2ebAAvJ.ByMkLMwmp9zXHJx7eWgFlgLiEFyVoROMHCXmmLAqp%2Fk","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku/sudoku-solver","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	/home/ubuntu/projects/Sudoku-Solver/app/views/adminDB.ejs:3\n    1| <%- include('./partials/header'); %>\n    2| \n >> 3|     <%- include('./partials/DataBaseForm'); %>\n    4| \n    5|         <div>\n    6| \n\n/home/ubuntu/projects/Sudoku-Solver/app/views/partials/DataBaseForm.ejs:4\n    2| \n    3|     <label class="form__consigne" for="level-selection">NB GRILLES<br> EN BASE</label>\n >> 4|     <input class="inputAdmin" id="boardsCount" value="<% if (data[0].count){ %>\n    5|         <%= locals.data[0].count %>\n    6|             <% } %>">\n    7| \n\nCannot read properties of undefined (reading 'count')
7	2022-11-30	217.182.9.234	::1	/sudoku-solver/database	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; connect.sid=s%3A4YAlaDTC3qwSa3GjJNLYW468C2ebAAvJ.ByMkLMwmp9zXHJx7eWgFlgLiEFyVoROMHCXmmLAqp%2Fk; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669797579.0.0.0","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku/sudoku-solver","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	Cannot read properties of undefined (reading 'toString')
8	2022-11-30	217.182.9.234	::1	/sudoku-solver/database	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; connect.sid=s%3ASiNU_5pULvEy9TzIHVFThbZpwtku3kCh.HaRlSzoZLRWvQsIMZ%2FGSiecYSxhuXm%2F9QEZ9IUoNMHU; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669797726.0.0.0","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku/sudoku-solver","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"217.182.9.234:3000"}	Cannot read properties of undefined (reading 'toString')
9	2022-11-30	217.182.9.234	::1	/sudoku-solver/login/add	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669798652.0.0.0; connect.sid=s%3A8ZG-3y3OIynbntyfHuQ3CwWxN9mQAKrv.xFBc9VIu2kOZYgk3pCLqfAvb2F727tYpmSXvdg%2FaNPw","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku-solver/Login/FormCreation","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","content-type":"application/x-www-form-urlencoded","origin":"http://217.182.9.234:3000","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","content-length":"38","connection":"close","host":"217.182.9.234:3000"}	Cannot set headers after they are sent to the client
11	2022-11-30	217.182.9.234	::1	/sudoku-solver/login/add	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669798652.0.0.0; connect.sid=s%3A8ZG-3y3OIynbntyfHuQ3CwWxN9mQAKrv.xFBc9VIu2kOZYgk3pCLqfAvb2F727tYpmSXvdg%2FaNPw","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku-solver/login/add","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","content-type":"application/x-www-form-urlencoded","origin":"http://217.182.9.234:3000","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","content-length":"38","connection":"close","host":"217.182.9.234:3000"}	Cannot set headers after they are sent to the client
12	2022-11-30	217.182.9.234	::1	/sudoku-solver/login/add	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669798652.0.0.0; connect.sid=s%3A8ZG-3y3OIynbntyfHuQ3CwWxN9mQAKrv.xFBc9VIu2kOZYgk3pCLqfAvb2F727tYpmSXvdg%2FaNPw","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku-solver/login/add","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","content-type":"application/x-www-form-urlencoded","origin":"http://217.182.9.234:3000","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","content-length":"38","connection":"close","host":"217.182.9.234:3000"}	Cannot set headers after they are sent to the client
13	2022-11-30	217.182.9.234	::1	/sudoku-solver/login/add	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669798652.0.0.0; connect.sid=s%3A8ZG-3y3OIynbntyfHuQ3CwWxN9mQAKrv.xFBc9VIu2kOZYgk3pCLqfAvb2F727tYpmSXvdg%2FaNPw","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku-solver/login/add","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","content-type":"application/x-www-form-urlencoded","origin":"http://217.182.9.234:3000","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","content-length":"38","connection":"close","host":"217.182.9.234:3000"}	Cannot set headers after they are sent to the client
15	2022-11-30	217.182.9.234	::1	/sudoku-solver/login/add	{"cookie":"_ga=GA1.1.720043703.1669737004; __session=s%3Alf-GvqKumSa13berAQu5FJ6FcxZsENnU.ki9LPy3tbtfS2wjWo7ZFEQLIpXhAYhdQRpzF9Ep9y98; _ga_EFQWDNV04X=GS1.1.1669794983.2.1.1669798652.0.0.0; connect.sid=s%3A8ZG-3y3OIynbntyfHuQ3CwWxN9mQAKrv.xFBc9VIu2kOZYgk3pCLqfAvb2F727tYpmSXvdg%2FaNPw","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate","referer":"http://217.182.9.234:3000/sudoku/sudoku-solver/login/add","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36","content-type":"application/x-www-form-urlencoded","origin":"http://217.182.9.234:3000","upgrade-insecure-requests":"1","cache-control":"no-cache","pragma":"no-cache","content-length":"38","connection":"close","host":"217.182.9.234:3000"}	Cannot set headers after they are sent to the client
16	2022-12-08	www.planitools.com	::1	/sudoku-solver/database	{"cookie":"_ga=GA1.1.941197032.1655105912; __session=s%3AgjZi6Hy3vs5JRv5CPbNuQdW8KDGuWOgM.WcsKXEZqufnuO39NcuQ8JJKeienqaEUnxevWBNcYmnY; _ga_EFQWDNV04X=GS1.1.1670497588.113.1.1670500206.0.0.0; connect.sid=s%3A-UmXV9QOg-1GU1GMYDf7gSegDkwsWJ5i.DP6FefyuTEq2w%2BiURQnqEEIivdzWWV6UynD%2BzHRKFXE","accept-language":"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7","accept-encoding":"gzip, deflate, br","referer":"https://www.planitools.com/sudoku/sudoku/sudoku-solver","sec-fetch-dest":"document","sec-fetch-mode":"navigate","sec-fetch-site":"same-origin","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36","upgrade-insecure-requests":"1","sec-ch-ua-platform":"\\"Windows\\"","sec-ch-ua-mobile":"?0","sec-ch-ua":"\\"Not?A_Brand\\";v=\\"8\\", \\"Chromium\\";v=\\"108\\", \\"Google Chrome\\";v=\\"108\\"","cache-control":"no-cache","pragma":"no-cache","connection":"close","host":"www.planitools.com"}	Cannot read properties of undefined (reading 'toString')
\.


--
-- Data for Name: robots; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.robots (id, file_text) FROM stdin;
1	Disallow : /
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.role (role_id, role_description) FROM stdin;
1	ADMIN
2	CLIENT
3	VISITOR
\.


--
-- Data for Name: sitemap; Type: TABLE DATA; Schema: public; Owner: sudoku
--

COPY public.sitemap (id, file_text) FROM stdin;
1	A compléter
\.


--
-- Data for Name: changes; Type: TABLE DATA; Schema: sqitch; Owner: sudoku
--

COPY sqitch.changes (change_id, script_hash, change, project, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
d827af08ac8f3dbbc311fedad59ee32ae7c6dff1	b87a306f8f643ddddbda90170f7311c1c2e46947	initdb	sudoku	création des tables	2022-12-02 15:19:48.131309+00	Ubuntu	ubuntu@S008371	2022-01-29 14:13:43+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
a48323e4ecc821e87b1b8c967f9a6c0a85202412	79947c9545487d67bfbcc0a512b23b99e27422f7	legal_notice_table	sudoku	creation of the table to hold the legal notice text	2022-12-02 15:19:48.233327+00	Ubuntu	ubuntu@S008371	2022-06-01 09:45:39+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
909389e9db63ecb3224bde689439a14ffe60f411	fcc3c82d17876bcdcff04d35d85f8c3f42f6d83a	seo_tables	sudoku	adding tables robots and sitemap	2022-12-02 15:19:48.336938+00	Ubuntu	ubuntu@S008371	2022-06-06 07:10:10+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
f3fb5b5e76aae05049d2b8345b2ffea9017be3b0	6b757de9745007323d876d333a0898631664f8ef	logs_table	sudoku	add logs to database	2022-12-02 15:19:48.427422+00	Ubuntu	ubuntu@S008371	2022-06-06 13:05:33+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
e385171cdfcaec1cd80a9bbe9b58f653a233cbd9	3d9e4abcbf82352178c0e5252e84abe1198add00	constraint_actor	sudoku	removing unused constraints	2022-12-02 15:19:48.497038+00	Ubuntu	ubuntu@S008371	2022-06-06 13:58:42+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
\.


--
-- Data for Name: dependencies; Type: TABLE DATA; Schema: sqitch; Owner: sudoku
--

COPY sqitch.dependencies (change_id, type, dependency, dependency_id) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: sqitch; Owner: sudoku
--

COPY sqitch.events (event, change_id, change, project, note, requires, conflicts, tags, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
deploy	d827af08ac8f3dbbc311fedad59ee32ae7c6dff1	initdb	sudoku	création des tables	{}	{}	{}	2022-12-02 15:19:48.132775+00	Ubuntu	ubuntu@S008371	2022-01-29 14:13:43+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	a48323e4ecc821e87b1b8c967f9a6c0a85202412	legal_notice_table	sudoku	creation of the table to hold the legal notice text	{}	{}	{}	2022-12-02 15:19:48.234751+00	Ubuntu	ubuntu@S008371	2022-06-01 09:45:39+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	909389e9db63ecb3224bde689439a14ffe60f411	seo_tables	sudoku	adding tables robots and sitemap	{}	{}	{}	2022-12-02 15:19:48.337736+00	Ubuntu	ubuntu@S008371	2022-06-06 07:10:10+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	f3fb5b5e76aae05049d2b8345b2ffea9017be3b0	logs_table	sudoku	add logs to database	{}	{}	{}	2022-12-02 15:19:48.428606+00	Ubuntu	ubuntu@S008371	2022-06-06 13:05:33+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	e385171cdfcaec1cd80a9bbe9b58f653a233cbd9	constraint_actor	sudoku	removing unused constraints	{}	{}	{}	2022-12-02 15:19:48.497806+00	Ubuntu	ubuntu@S008371	2022-06-06 13:58:42+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	d827af08ac8f3dbbc311fedad59ee32ae7c6dff1	initdb	sudoku	création des tables	{}	{}	{}	2022-11-29 15:17:37.837095+00	Ubuntu	ubuntu@S008371	2022-01-29 14:13:43+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	a48323e4ecc821e87b1b8c967f9a6c0a85202412	legal_notice_table	sudoku	creation of the table to hold the legal notice text	{}	{}	{}	2022-11-29 15:17:37.939805+00	Ubuntu	ubuntu@S008371	2022-06-01 09:45:39+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	909389e9db63ecb3224bde689439a14ffe60f411	seo_tables	sudoku	adding tables robots and sitemap	{}	{}	{}	2022-11-29 15:17:38.050636+00	Ubuntu	ubuntu@S008371	2022-06-06 07:10:10+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	f3fb5b5e76aae05049d2b8345b2ffea9017be3b0	logs_table	sudoku	add logs to database	{}	{}	{}	2022-11-29 15:17:38.138577+00	Ubuntu	ubuntu@S008371	2022-06-06 13:05:33+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
deploy	e385171cdfcaec1cd80a9bbe9b58f653a233cbd9	constraint_actor	sudoku	removing unused constraints	{}	{}	{}	2022-11-29 15:17:38.210432+00	Ubuntu	ubuntu@S008371	2022-06-06 13:58:42+00	Killian AUDIC	killi@LAPTOP-5GJ086M6
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: sqitch; Owner: sudoku
--

COPY sqitch.projects (project, uri, created_at, creator_name, creator_email) FROM stdin;
sudoku	\N	2022-12-02 15:19:47.8148+00	Ubuntu	ubuntu@S008371
\.


--
-- Data for Name: releases; Type: TABLE DATA; Schema: sqitch; Owner: sudoku
--

COPY sqitch.releases (version, installed_at, installer_name, installer_email) FROM stdin;
1.1	2022-12-02 15:19:47.81178+00	Ubuntu	ubuntu@S008371
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: sqitch; Owner: sudoku
--

COPY sqitch.tags (tag_id, tag, project, change_id, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
\.


--
-- Name: actor_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.actor_actor_id_seq', 3, true);


--
-- Name: board_board_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.board_board_id_seq', 2071, true);


--
-- Name: display_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.display_display_id_seq', 2, true);


--
-- Name: legal_notice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.legal_notice_id_seq', 1, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.logs_id_seq', 16, true);


--
-- Name: robots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.robots_id_seq', 1, true);


--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.role_role_id_seq', 3, true);


--
-- Name: sitemap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sudoku
--

SELECT pg_catalog.setval('public.sitemap_id_seq', 1, true);


--
-- Name: actor actor_actor_email_key; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_actor_email_key UNIQUE (actor_email);


--
-- Name: actor actor_actor_login_key; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_actor_login_key UNIQUE (actor_login);


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


--
-- Name: board board_board_data_key; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.board
    ADD CONSTRAINT board_board_data_key UNIQUE (board_data);


--
-- Name: board board_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.board
    ADD CONSTRAINT board_pkey PRIMARY KEY (board_id);


--
-- Name: display display_display_type_key; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.display
    ADD CONSTRAINT display_display_type_key UNIQUE (display_type);


--
-- Name: display display_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.display
    ADD CONSTRAINT display_pkey PRIMARY KEY (display_id);


--
-- Name: legal_notice legal_notice_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.legal_notice
    ADD CONSTRAINT legal_notice_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: robots robots_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.robots
    ADD CONSTRAINT robots_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- Name: role role_role_description_key; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_role_description_key UNIQUE (role_description);


--
-- Name: sitemap sitemap_pkey; Type: CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.sitemap
    ADD CONSTRAINT sitemap_pkey PRIMARY KEY (id);


--
-- Name: changes changes_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.changes
    ADD CONSTRAINT changes_pkey PRIMARY KEY (change_id);


--
-- Name: changes changes_project_script_hash_key; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.changes
    ADD CONSTRAINT changes_project_script_hash_key UNIQUE (project, script_hash);


--
-- Name: dependencies dependencies_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.dependencies
    ADD CONSTRAINT dependencies_pkey PRIMARY KEY (change_id, dependency);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (change_id, committed_at);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project);


--
-- Name: projects projects_uri_key; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.projects
    ADD CONSTRAINT projects_uri_key UNIQUE (uri);


--
-- Name: releases releases_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.releases
    ADD CONSTRAINT releases_pkey PRIMARY KEY (version);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: tags tags_project_tag_key; Type: CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.tags
    ADD CONSTRAINT tags_project_tag_key UNIQUE (project, tag);


--
-- Name: actor actor_actor_display_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_actor_display_id_fkey FOREIGN KEY (actor_display_id) REFERENCES public.display(display_id);


--
-- Name: actor actor_actor_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sudoku
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_actor_role_id_fkey FOREIGN KEY (actor_role_id) REFERENCES public.role(role_id);


--
-- Name: changes changes_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.changes
    ADD CONSTRAINT changes_project_fkey FOREIGN KEY (project) REFERENCES sqitch.projects(project) ON UPDATE CASCADE;


--
-- Name: dependencies dependencies_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.dependencies
    ADD CONSTRAINT dependencies_change_id_fkey FOREIGN KEY (change_id) REFERENCES sqitch.changes(change_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dependencies dependencies_dependency_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.dependencies
    ADD CONSTRAINT dependencies_dependency_id_fkey FOREIGN KEY (dependency_id) REFERENCES sqitch.changes(change_id) ON UPDATE CASCADE;


--
-- Name: events events_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.events
    ADD CONSTRAINT events_project_fkey FOREIGN KEY (project) REFERENCES sqitch.projects(project) ON UPDATE CASCADE;


--
-- Name: tags tags_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.tags
    ADD CONSTRAINT tags_change_id_fkey FOREIGN KEY (change_id) REFERENCES sqitch.changes(change_id) ON UPDATE CASCADE;


--
-- Name: tags tags_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: sudoku
--

ALTER TABLE ONLY sqitch.tags
    ADD CONSTRAINT tags_project_fkey FOREIGN KEY (project) REFERENCES sqitch.projects(project) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

