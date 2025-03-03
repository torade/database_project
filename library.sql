PGDMP      3                }            library    17.2    17.2 0    T           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            U           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            V           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            W           1262    65613    library    DATABASE     }   CREATE DATABASE library WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Romanian_Romania.1252';
    DROP DATABASE library;
                     postgres    false            �            1259    65875    author    TABLE     �   CREATE TABLE public.author (
    author_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    nationality character varying(50)
);
    DROP TABLE public.author;
       public         heap r       postgres    false            �            1259    65874    author_author_id_seq    SEQUENCE     �   CREATE SEQUENCE public.author_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.author_author_id_seq;
       public               postgres    false    218            X           0    0    author_author_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.author_author_id_seq OWNED BY public.author.author_id;
          public               postgres    false    217            �            1259    65882    book    TABLE     �   CREATE TABLE public.book (
    book_id integer NOT NULL,
    title character varying(255) NOT NULL,
    publisher character varying(100),
    publication_year integer,
    shelf_location character varying(50),
    genre_id integer
);
    DROP TABLE public.book;
       public         heap r       postgres    false            �            1259    65888    book_author    TABLE     �   CREATE TABLE public.book_author (
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    contribution_order integer
);
    DROP TABLE public.book_author;
       public         heap r       postgres    false            �            1259    65881    book_book_id_seq    SEQUENCE     �   CREATE SEQUENCE public.book_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.book_book_id_seq;
       public               postgres    false    220            Y           0    0    book_book_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.book_book_id_seq OWNED BY public.book.book_id;
          public               postgres    false    219            �            1259    65904    genre    TABLE     �   CREATE TABLE public.genre (
    genre_id integer NOT NULL,
    genre_name character varying(50) NOT NULL,
    genre_description character varying(200)
);
    DROP TABLE public.genre;
       public         heap r       postgres    false            �            1259    65903    genre_genre_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genre_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.genre_genre_id_seq;
       public               postgres    false    223            Z           0    0    genre_genre_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.genre_genre_id_seq OWNED BY public.genre.genre_id;
          public               postgres    false    222            �            1259    65920    loan    TABLE     �   CREATE TABLE public.loan (
    loan_id integer NOT NULL,
    book_id integer NOT NULL,
    user_id integer NOT NULL,
    borrow_date date NOT NULL,
    return_date date
);
    DROP TABLE public.loan;
       public         heap r       postgres    false            �            1259    65919    loan_loan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.loan_loan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.loan_loan_id_seq;
       public               postgres    false    227            [           0    0    loan_loan_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.loan_loan_id_seq OWNED BY public.loan.loan_id;
          public               postgres    false    226            �            1259    65911    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(70) NOT NULL,
    phone character varying(20)
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    65910    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               postgres    false    225            \           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               postgres    false    224            �           2604    65878    author author_id    DEFAULT     t   ALTER TABLE ONLY public.author ALTER COLUMN author_id SET DEFAULT nextval('public.author_author_id_seq'::regclass);
 ?   ALTER TABLE public.author ALTER COLUMN author_id DROP DEFAULT;
       public               postgres    false    218    217    218            �           2604    65885    book book_id    DEFAULT     l   ALTER TABLE ONLY public.book ALTER COLUMN book_id SET DEFAULT nextval('public.book_book_id_seq'::regclass);
 ;   ALTER TABLE public.book ALTER COLUMN book_id DROP DEFAULT;
       public               postgres    false    219    220    220            �           2604    65907    genre genre_id    DEFAULT     p   ALTER TABLE ONLY public.genre ALTER COLUMN genre_id SET DEFAULT nextval('public.genre_genre_id_seq'::regclass);
 =   ALTER TABLE public.genre ALTER COLUMN genre_id DROP DEFAULT;
       public               postgres    false    222    223    223            �           2604    65923    loan loan_id    DEFAULT     l   ALTER TABLE ONLY public.loan ALTER COLUMN loan_id SET DEFAULT nextval('public.loan_loan_id_seq'::regclass);
 ;   ALTER TABLE public.loan ALTER COLUMN loan_id DROP DEFAULT;
       public               postgres    false    226    227    227            �           2604    65914    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               postgres    false    225    224    225            H          0    65875    author 
   TABLE DATA           O   COPY public.author (author_id, first_name, last_name, nationality) FROM stdin;
    public               postgres    false    218   �6       J          0    65882    book 
   TABLE DATA           e   COPY public.book (book_id, title, publisher, publication_year, shelf_location, genre_id) FROM stdin;
    public               postgres    false    220   C7       K          0    65888    book_author 
   TABLE DATA           M   COPY public.book_author (book_id, author_id, contribution_order) FROM stdin;
    public               postgres    false    221   G8       M          0    65904    genre 
   TABLE DATA           H   COPY public.genre (genre_id, genre_name, genre_description) FROM stdin;
    public               postgres    false    223   �8       Q          0    65920    loan 
   TABLE DATA           S   COPY public.loan (loan_id, book_id, user_id, borrow_date, return_date) FROM stdin;
    public               postgres    false    227   D9       O          0    65911    users 
   TABLE DATA           M   COPY public.users (user_id, first_name, last_name, email, phone) FROM stdin;
    public               postgres    false    225   �9       ]           0    0    author_author_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.author_author_id_seq', 7, true);
          public               postgres    false    217            ^           0    0    book_book_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.book_book_id_seq', 9, true);
          public               postgres    false    219            _           0    0    genre_genre_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.genre_genre_id_seq', 5, true);
          public               postgres    false    222            `           0    0    loan_loan_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.loan_loan_id_seq', 5, true);
          public               postgres    false    226            a           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);
          public               postgres    false    224            �           2606    65880    author author_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);
 <   ALTER TABLE ONLY public.author DROP CONSTRAINT author_pkey;
       public                 postgres    false    218            �           2606    65892    book_author book_author_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id);
 F   ALTER TABLE ONLY public.book_author DROP CONSTRAINT book_author_pkey;
       public                 postgres    false    221    221            �           2606    65887    book book_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);
 8   ALTER TABLE ONLY public.book DROP CONSTRAINT book_pkey;
       public                 postgres    false    220            �           2606    65909    genre genre_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (genre_id);
 :   ALTER TABLE ONLY public.genre DROP CONSTRAINT genre_pkey;
       public                 postgres    false    223            �           2606    65925    loan loan_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.loan
    ADD CONSTRAINT loan_pkey PRIMARY KEY (loan_id);
 8   ALTER TABLE ONLY public.loan DROP CONSTRAINT loan_pkey;
       public                 postgres    false    227            �           2606    65918    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 postgres    false    225            �           2606    65916    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    225            �           2606    65898 &   book_author book_author_author_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.book_author DROP CONSTRAINT book_author_author_id_fkey;
       public               postgres    false    221    4772    218            �           2606    65893 $   book_author book_author_book_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.book_author DROP CONSTRAINT book_author_book_id_fkey;
       public               postgres    false    4774    220    221            �           2606    65937    book fk_genre    FK CONSTRAINT     �   ALTER TABLE ONLY public.book
    ADD CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES public.genre(genre_id) ON DELETE SET NULL;
 7   ALTER TABLE ONLY public.book DROP CONSTRAINT fk_genre;
       public               postgres    false    220    223    4778            �           2606    65926    loan loan_book_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.loan
    ADD CONSTRAINT loan_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.loan DROP CONSTRAINT loan_book_id_fkey;
       public               postgres    false    227    4774    220            �           2606    65931    loan loan_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.loan
    ADD CONSTRAINT loan_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.loan DROP CONSTRAINT loan_user_id_fkey;
       public               postgres    false    4782    227    225            H   �   x�E̻
�P��z�a��%��Y��s����-b�1��P��<M-J�A��q�l��j����'��AҢ[�l��5�E1m8�g��+���sԹ����mǜ;�r@��߳ �y�����>�'5�      J   �   x�%��n�0E��W�J�UxCɒ�"E��@�&��Yp<��	��c�n4�����b�eM�!Ke�&���g������l��L��n���Ƞ ������$��}b�߸�s���f=��t����GhO�2"�a� �*�H��zv9��q+��t�--�Qێ催{ed�v���6��hy(��,��b��'���+� 4(c'u�fpI �?��A�h�UG���6-�e#���B������I�A9[S      K   -   x���  ��^1&�`3�_��1AJ��7�7��RwIz���      M   �   x�U�An�@���)|�Z� ��X�qg�&vd;	s�!!�����#P���`�9���v@�$��3훇��JV�b��r��ȝ'�����hy�v.����/�;tdhf�?�_i[�efi��A����o:�Ps@�PًNdL���N%����d�������i�s���R�      Q   J   x�M��� �Ћ�;<�D*��:�s>8|J�VL���*(5YZ�${��/������5,�z�� �]�6      O   �   x�U��n�0Eg�_$�-{K�v)�)C�.�M$*$+��&����;����}�#�g��K�!����M;z�|M�ǒA*͌u�w�@oe�S��e�K�M��<s�0��@�p+	��o\`ļ��Z˜�jд2�WL��Z&�Xy{��L)�tZ���1�D7�*�7�1���q�a?Q�s��=��':�L�~w�!��^���5�����\q     