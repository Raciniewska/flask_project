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
SET default_tablespace = '';

SET default_with_oids = false;

CREATE ROLE schronisko WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  NOCREATEROLE
  NOREPLICATION;

----------------PRODUKT--------------------------------

CREATE TABLE public.produkt (
    id_produktu integer NOT NULL,
    nazwa character varying NOT NULL,
    producent character varying,
    opis character varying,
	cena numeric(8,2) NOT NULL
);

ALTER TABLE public.produkt OWNER TO schronisko;

CREATE SEQUENCE public.id_produktu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.id_produktu_seq OWNER TO schronisko;

ALTER SEQUENCE public.id_produktu_seq OWNED BY public.produkt.id_produktu;

--------------------------------------------------------------------------
----------------WOLONTARIUSZ----------------------------------------------

CREATE TABLE public.wolontariusz(
  id_osoby integer NOT NULL,
  imie character varying NOT NULL,
  nazwisko character varying NOT NULL,
  adres character varying,
  adres_email character varying NOT NULL,
  data_zatrudnienia date,
  godziny_pracy character varying,
  haslo character varying NOT NULL,
  liczba_godzin_przepracowaanych_w_msc integer,
  login character varying NOT NULL,
  numer_telefonu character varying,
  rodzaj_umowy character varying,
  stawka_godzinowa numeric(5,2),
  pesel character varying,
  czy_pelnoletni boolean,
  zgoda_opiekuna character varying
);

ALTER TABLE public.wolontariusz OWNER TO schronisko;

CREATE SEQUENCE public.wolontariusz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.wolontariusz_id_seq OWNER TO schronisko;

ALTER SEQUENCE public.wolontariusz_id_seq OWNED BY public.wolontariusz.id_osoby;

--------------------------------------------------------------------------
----------------PRACOWNIK BIURA----------------------------------------------

CREATE TABLE public.pracownik_biura(
  id_osoby integer NOT NULL,
  imie character varying NOT NULL,
  nazwisko character varying NOT NULL,
  adres character varying,
  adres_email character varying NOT NULL,
  data_zatrudnienia date,
  godziny_pracy character varying,
  haslo character varying NOT NULL,
  liczba_godzin_przepracowaanych_w_msc integer,
  login character varying NOT NULL,
  numer_telefonu character varying,
  rodzaj_umowy character varying,
  stawka_godzinowa numeric(5,2),
  pesel character varying,
  liczba_wykorzystanych_dni_urlopu integer,
  numer_pokoju integer,
  posiadany_sprzet_elektroniczny character varying
);

ALTER TABLE public.pracownik_biura OWNER TO schronisko;

CREATE SEQUENCE public.pracownik_biura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.pracownik_biura_id_seq OWNER TO schronisko;

ALTER SEQUENCE public.pracownik_biura_id_seq OWNED BY public.pracownik_biura.id_osoby;

--------------------------------------------------------------------------
----------------CLASS VARIABLES----------------------------------------------

CREATE TABLE public.class_variables(
  id_class_variables integer NOT NULL,
  liczba_zlozonych_zamowien integer
);

ALTER TABLE public.class_variables OWNER TO schronisko;

CREATE SEQUENCE public.class_variables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.class_variables_id_seq OWNER TO schronisko;

ALTER SEQUENCE public.class_variables_id_seq OWNED BY public.class_variables.id_class_variables;

--------------------------------------------------------------------------
----------------DOSTAWCA----------------------------------------------

CREATE TABLE public.dostawca(
  id_osoby integer NOT NULL,
  imie character varying NOT NULL,
  nazwisko character varying NOT NULL,
  adres character varying,
  adres_email character varying NOT NULL,
  data_zatrudnienia date,
  godziny_pracy character varying,
  haslo character varying NOT NULL,
  liczba_godzin_przepracowaanych_w_msc integer,
  login character varying NOT NULL,
  numer_telefonu character varying NOT NULL,
  rodzaj_umowy character varying,
  stawka_godzinowa numeric(5,2),
  firma character varying NOT NULL,
  typ_samochodu character varying
);

ALTER TABLE public.dostawca OWNER TO schronisko;

CREATE SEQUENCE public.dostawca_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.dostawca_id_seq OWNER TO schronisko;

ALTER SEQUENCE public.dostawca_id_seq OWNED BY public.dostawca.id_osoby;

--------------------------------------------------------------------------
----------------ZAMOWIENIE----------------------------------------------

CREATE TABLE public.zamowienie (
    id_zamowienia integer NOT NULL,
	id_dostawcy integer NOT NULL,
	id_pracownika integer,
	id_wolontariusza integer,
    data_zlozenia date,
	data_dostawy date,
	status character varying,
	kwota numeric (10,2),
	komentarz character varying
);

ALTER TABLE public.zamowienie OWNER TO schronisko;

CREATE SEQUENCE public.zamowienie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.zamowienie_id_seq OWNER TO schronisko;

ALTER SEQUENCE public.zamowienie_id_seq OWNED BY public.zamowienie.id_zamowienia;

--------------------------------------------------------------------------
----------------PRODUKT W ZAMOWIENIU----------------------------------------------

CREATE TABLE public.produkt_w_zamowieniu (
    id_zamowienia integer NOT NULL,
	id_produktu integer NOT NULL,
	ilosc integer
);

ALTER TABLE public.produkt_w_zamowieniu OWNER TO schronisko;

---------------------------------------------------------------------------
--------------------*********************----------------------------------

ALTER TABLE ONLY public.produkt ALTER COLUMN id_produktu SET DEFAULT nextval('public.id_produktu_seq'::regclass);

ALTER TABLE ONLY public.wolontariusz ALTER COLUMN id_osoby SET DEFAULT nextval('public.wolontariusz_id_seq'::regclass);

ALTER TABLE ONLY public.pracownik_biura ALTER COLUMN id_osoby SET DEFAULT nextval('public.pracownik_biura_id_seq'::regclass);

ALTER TABLE ONLY public.dostawca ALTER COLUMN id_osoby SET DEFAULT nextval('public.dostawca_id_seq'::regclass);

ALTER TABLE ONLY public.zamowienie ALTER COLUMN id_zamowienia SET DEFAULT nextval('public.zamowienie_id_seq'::regclass);

ALTER TABLE ONLY public.class_variables ALTER COLUMN id_class_variables SET DEFAULT nextval('public.class_variables_id_seq'::regclass);

---------------------------------------------------------------------------
--------------------*********************----------------------------------

ALTER TABLE ONLY public.produkt
    ADD CONSTRAINT produkt_pkey PRIMARY KEY (id_produktu);

ALTER TABLE ONLY public.wolontariusz
    ADD CONSTRAINT wolontariusz_pkey PRIMARY KEY (id_osoby);
	
ALTER TABLE ONLY public.pracownik_biura
    ADD CONSTRAINT pracownik_biura_pkey PRIMARY KEY (id_osoby);

ALTER TABLE ONLY public.dostawca
    ADD CONSTRAINT dostawca_pkey PRIMARY KEY (id_osoby);
	
ALTER TABLE ONLY public.zamowienie
    ADD CONSTRAINT zamowienie_pkey PRIMARY KEY (id_zamowienia);
	
ALTER TABLE ONLY public.class_variables
    ADD CONSTRAINT class_variables_pkey PRIMARY KEY (id_class_variables);

---------------------------------------------------------------------------
--------------------*********************----------------------------------

ALTER TABLE ONLY public.produkt_w_zamowieniu
    ADD CONSTRAINT produkt_w_zamowieniu_id_zamowienia_fkey FOREIGN KEY (id_zamowienia) REFERENCES public.zamowienie(id_zamowienia);

ALTER TABLE ONLY public.produkt_w_zamowieniu
    ADD CONSTRAINT produkt_w_zamowieniu_id_produktu_fkey FOREIGN KEY (id_produktu) REFERENCES public.produkt(id_produktu);

ALTER TABLE ONLY public.zamowienie
    ADD CONSTRAINT zamowienie_dostawca_id_fkey FOREIGN KEY (id_dostawcy) REFERENCES public.dostawca(id_osoby);

ALTER TABLE ONLY public.zamowienie
    ADD CONSTRAINT zamowienie_pracownik_id_fkey FOREIGN KEY (id_pracownika) REFERENCES public.pracownik_biura(id_osoby);
	
ALTER TABLE ONLY public.zamowienie
    ADD CONSTRAINT zamowienie_wolontariusz_id_fkey FOREIGN KEY (id_wolontariusza) REFERENCES public.wolontariusz(id_osoby);

---------------------------------------------------------------------------
--------------------INSERTY----------------------------------

INSERT INTO public.produkt VALUES (1,'Karma wieprzowa kot 2kg','swiat zwierzat','Ekologiczna karma dla kota 2kg',49.99);

INSERT INTO public.pracownik_biura VALUES (1,'Anna','Pracowita','Kreta 23/4 432-121 Poznan','apracowita@promyk.com',
'2020-10-05','pn-pt 8:00-17:00','pracownik',25,'apracowita','21309112','umowa o prace',12.50,'98124398234',7,2,'laptop DELL');

INSERT INTO public.wolontariusz VALUES (1,'Tomasz','Nowak','Bliska 23/4 432-121 Poznan','tnowak@gmail.com',
'2019-10-05','pn-pt 12:00-17:00','wolontariusz',15,'tnowak','21332112','wolontariat',00.00,'98123098234','t','C://Documents/zgoda1.jpg');

INSERT INTO public.dostawca VALUES (1,'Jan','Kowalski','Dluga 43 30-456 Bydgoszcz','jkowalski@dhl.com',
'2001-10-05','pn-pt 8:00-17:00','dostawca',40,'jkowalski','345098123','umowa o dzielo',15.00,'DHL','Tir');

INSERT INTO public.zamowienie VALUES (1,1,1,1,'2019-10-04','2019-10-05','dostarczone',49.99,'-');

INSERT INTO public.class_variables VALUES (1,1);

INSERT INTO public.produkt_w_zamowieniu VALUES (1,1,1);


