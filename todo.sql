--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Ubuntu 16.6-1.pgdg24.04+1)
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: calendario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calendario (
    calendario_id integer NOT NULL,
    tarea_id integer NOT NULL,
    fecha date NOT NULL,
    usuario_id integer NOT NULL
);


ALTER TABLE public.calendario OWNER TO postgres;

--
-- Name: calendario_calendario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.calendario_calendario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.calendario_calendario_id_seq OWNER TO postgres;

--
-- Name: calendario_calendario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.calendario_calendario_id_seq OWNED BY public.calendario.calendario_id;


--
-- Name: tareas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tareas (
    descripcion text,
    estado character varying(50) DEFAULT NULL::character varying,
    prioridad character varying(50) DEFAULT NULL::character varying,
    fecha_creacion date,
    fecha_vencimiento date,
    usuario_asignado_id integer,
    tarea_id integer NOT NULL
);


ALTER TABLE public.tareas OWNER TO postgres;

--
-- Name: tareas_tarea_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tareas_tarea_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tareas_tarea_id_seq OWNER TO postgres;

--
-- Name: tareas_tarea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tareas_tarea_id_seq OWNED BY public.tareas.tarea_id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    nombre character varying(50) NOT NULL,
    usuario character varying(100) NOT NULL,
    telefono character varying(10) NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    usuario_id integer NOT NULL,
    descripcion text
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_usuario_id_seq OWNER TO postgres;

--
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;


--
-- Name: calendario calendario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendario ALTER COLUMN calendario_id SET DEFAULT nextval('public.calendario_calendario_id_seq'::regclass);


--
-- Name: tareas tarea_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tareas ALTER COLUMN tarea_id SET DEFAULT nextval('public.tareas_tarea_id_seq'::regclass);


--
-- Name: usuarios usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);


--
-- Data for Name: calendario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calendario (calendario_id, tarea_id, fecha, usuario_id) FROM stdin;
1	13	2024-11-30	1
\.


--
-- Data for Name: tareas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tareas (descripcion, estado, prioridad, fecha_creacion, fecha_vencimiento, usuario_asignado_id, tarea_id) FROM stdin;
CODIGO	terminado	baja	2024-11-24	\N	1	4
proyecto 	terminado	media	2024-11-24	2024-11-24	1	2
Examen de matematicas	terminado	alta	2024-11-24	2024-11-24	1	3
CODIGO 2	terminado	alta	2024-11-24	2024-11-24	1	5
exposicion de proyecto 	pendiente	alta	2024-11-24	\N	1	8
aaa	en_proceso	media	2024-11-24	\N	\N	9
base de datos proyecto 	en_proceso	alta	2024-11-24	\N	1	10
Examen de matematicas 2	pendiente	alta	2024-11-24	\N	1	11
Testing de la base 	pendiente	alta	2024-11-24	\N	1	13
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (nombre, usuario, telefono, "contraseña", usuario_id, descripcion) FROM stdin;
Roy Bernal Ibarra	Ralentomvk	4494575413	rollo200726	1	ou che
Filis Embriz Pozos 	Filis	4495411077	12345	8	\N
Filis Embriz Pozos 	Filis	4495411077	1234	9	\N
\.


--
-- Name: calendario_calendario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.calendario_calendario_id_seq', 1, true);


--
-- Name: tareas_tarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tareas_tarea_id_seq', 13, true);


--
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 9, true);


--
-- Name: calendario calendario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendario
    ADD CONSTRAINT calendario_pkey PRIMARY KEY (calendario_id);


--
-- Name: tareas tareas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tareas
    ADD CONSTRAINT tareas_pkey PRIMARY KEY (tarea_id);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);


--
-- Name: calendario calendario_tarea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendario
    ADD CONSTRAINT calendario_tarea_id_fkey FOREIGN KEY (tarea_id) REFERENCES public.tareas(tarea_id);


--
-- Name: calendario calendario_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendario
    ADD CONSTRAINT calendario_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id);


--
-- PostgreSQL database dump complete
--

