PGDMP      6            
    |            todo     16.6 (Ubuntu 16.6-1.pgdg24.04+1)     17.2 (Ubuntu 17.2-1.pgdg24.04+1) %    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    24882    todo    DATABASE     p   CREATE DATABASE todo WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE todo;
                     postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1259    33109 
   calendario    TABLE     �   CREATE TABLE public.calendario (
    calendario_id integer NOT NULL,
    tarea_id integer NOT NULL,
    fecha date NOT NULL,
    usuario_id integer NOT NULL
);
    DROP TABLE public.calendario;
       public         heap r       postgres    false    4            �            1259    33108    calendario_calendario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.calendario_calendario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.calendario_calendario_id_seq;
       public               postgres    false    220    4            �           0    0    calendario_calendario_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.calendario_calendario_id_seq OWNED BY public.calendario.calendario_id;
          public               postgres    false    219            �            1259    33126    eventos    TABLE       CREATE TABLE public.eventos (
    evento_id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    fecha_inicio timestamp without time zone NOT NULL,
    fecha_fin timestamp without time zone NOT NULL,
    usuario_id integer
);
    DROP TABLE public.eventos;
       public         heap r       postgres    false    4            �            1259    33125    eventos_evento_id_seq    SEQUENCE     �   CREATE SEQUENCE public.eventos_evento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.eventos_evento_id_seq;
       public               postgres    false    4    222            �           0    0    eventos_evento_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.eventos_evento_id_seq OWNED BY public.eventos.evento_id;
          public               postgres    false    221            �            1259    24889    tareas    TABLE     1  CREATE TABLE public.tareas (
    descripcion text,
    estado character varying(50) DEFAULT NULL::character varying,
    prioridad character varying(50) DEFAULT NULL::character varying,
    fecha_creacion date,
    fecha_vencimiento date,
    usuario_asignado_id integer,
    tarea_id integer NOT NULL
);
    DROP TABLE public.tareas;
       public         heap r       postgres    false    4            �            1259    24909    tareas_tarea_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tareas_tarea_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tareas_tarea_id_seq;
       public               postgres    false    4    215            �           0    0    tareas_tarea_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tareas_tarea_id_seq OWNED BY public.tareas.tarea_id;
          public               postgres    false    218            �            1259    24896    usuarios    TABLE       CREATE TABLE public.usuarios (
    nombre character varying(50) NOT NULL,
    usuario character varying(100) NOT NULL,
    telefono character varying(10) NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    usuario_id integer NOT NULL,
    descripcion text
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false    4            �            1259    24901    usuarios_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_usuario_id_seq;
       public               postgres    false    4    216            �           0    0    usuarios_usuario_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;
          public               postgres    false    217            �           2604    33112    calendario calendario_id    DEFAULT     �   ALTER TABLE ONLY public.calendario ALTER COLUMN calendario_id SET DEFAULT nextval('public.calendario_calendario_id_seq'::regclass);
 G   ALTER TABLE public.calendario ALTER COLUMN calendario_id DROP DEFAULT;
       public               postgres    false    220    219    220            �           2604    33129    eventos evento_id    DEFAULT     v   ALTER TABLE ONLY public.eventos ALTER COLUMN evento_id SET DEFAULT nextval('public.eventos_evento_id_seq'::regclass);
 @   ALTER TABLE public.eventos ALTER COLUMN evento_id DROP DEFAULT;
       public               postgres    false    222    221    222            �           2604    24910    tareas tarea_id    DEFAULT     r   ALTER TABLE ONLY public.tareas ALTER COLUMN tarea_id SET DEFAULT nextval('public.tareas_tarea_id_seq'::regclass);
 >   ALTER TABLE public.tareas ALTER COLUMN tarea_id DROP DEFAULT;
       public               postgres    false    218    215            �           2604    24902    usuarios usuario_id    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN usuario_id DROP DEFAULT;
       public               postgres    false    217    216            �          0    33109 
   calendario 
   TABLE DATA           P   COPY public.calendario (calendario_id, tarea_id, fecha, usuario_id) FROM stdin;
    public               postgres    false    220   �+       �          0    33126    eventos 
   TABLE DATA           f   COPY public.eventos (evento_id, titulo, descripcion, fecha_inicio, fecha_fin, usuario_id) FROM stdin;
    public               postgres    false    222   ,       �          0    24889    tareas 
   TABLE DATA           �   COPY public.tareas (descripcion, estado, prioridad, fecha_creacion, fecha_vencimiento, usuario_asignado_id, tarea_id) FROM stdin;
    public               postgres    false    215   1,       �          0    24896    usuarios 
   TABLE DATA           e   COPY public.usuarios (nombre, usuario, telefono, "contraseña", usuario_id, descripcion) FROM stdin;
    public               postgres    false    216   �,       �           0    0    calendario_calendario_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.calendario_calendario_id_seq', 10, true);
          public               postgres    false    219            �           0    0    eventos_evento_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.eventos_evento_id_seq', 1, false);
          public               postgres    false    221            �           0    0    tareas_tarea_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tareas_tarea_id_seq', 22, true);
          public               postgres    false    218            �           0    0    usuarios_usuario_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 12, true);
          public               postgres    false    217            �           2606    33114    calendario calendario_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.calendario
    ADD CONSTRAINT calendario_pkey PRIMARY KEY (calendario_id);
 D   ALTER TABLE ONLY public.calendario DROP CONSTRAINT calendario_pkey;
       public                 postgres    false    220            �           2606    33133    eventos eventos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (evento_id);
 >   ALTER TABLE ONLY public.eventos DROP CONSTRAINT eventos_pkey;
       public                 postgres    false    222            �           2606    24912    tareas tareas_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tareas
    ADD CONSTRAINT tareas_pkey PRIMARY KEY (tarea_id);
 <   ALTER TABLE ONLY public.tareas DROP CONSTRAINT tareas_pkey;
       public                 postgres    false    215            �           2606    24904    usuarios usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    216            �           2606    33139 #   calendario calendario_tarea_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.calendario
    ADD CONSTRAINT calendario_tarea_id_fkey FOREIGN KEY (tarea_id) REFERENCES public.tareas(tarea_id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.calendario DROP CONSTRAINT calendario_tarea_id_fkey;
       public               postgres    false    215    3305    220            �           2606    33120 %   calendario calendario_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.calendario
    ADD CONSTRAINT calendario_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id);
 O   ALTER TABLE ONLY public.calendario DROP CONSTRAINT calendario_usuario_id_fkey;
       public               postgres    false    216    3307    220            �           2606    33134    eventos eventos_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.eventos DROP CONSTRAINT eventos_usuario_id_fkey;
       public               postgres    false    222    3307    216            �   >   x�Uʱ� ����6Ov��s ��%�"w(ؠ��Ţ����E/4�
���_IN0�      �      x������ � �      �   �   x�}�M
�@F��)���Tt�?��JԴL�Q�Y��oDJ��B��}	����e��]7�@G:�
u�y�+r42�{������K�_W��yco�y쌥fM&��
*�Jk\xe�����B'���0�m[�P����~FE�#ϲ�&����ϖQdr��ӱ����+����r��/܋_�      �   �   x����
�0�ϛ���$M�=*(x��^��h4�B����MzRO���73�NA/�m|��*��@�t%�� �s��L�<9GJ�V �F~�5lo���������f�9,,&CL
c@�Tg������h?���>=���|?!�A.Z�2��jo���jS�����&���`���F��	c�FL�     