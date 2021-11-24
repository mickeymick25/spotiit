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
-- Name: ads_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ads_status AS ENUM (
    'draft',
    'to_validate',
    'validated',
    'published',
    'failed',
    'success',
    'not_set'
);


--
-- Name: orientation; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.orientation AS ENUM (
    'North',
    'North_East',
    'East',
    'South_East',
    'South',
    'South_West',
    'West',
    'North_West',
    'Not_set'
);


--
-- Name: property_state; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.property_state AS ENUM (
    'recent',
    'old',
    'lifeannuity',
    'offplan',
    'not_set'
);


--
-- Name: property_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.property_type AS ENUM (
    'apartment',
    'house',
    'ground',
    'parking_Box',
    'loft_Workshop',
    'castle',
    'mansion',
    'building',
    'gite',
    'chalet_mobil_home',
    'Barge',
    'commercial_premises',
    'premises',
    'commercial_property',
    'activity_premises',
    'various',
    'not_set'
);


--
-- Name: sector_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sector_type AS ENUM (
    'Immobilier',
    'Emploi',
    'Auto/moto',
    'Non défini'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adfeatures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adfeatures (
    id bigint NOT NULL,
    comment character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    classifiedad_id bigint NOT NULL,
    type_id bigint NOT NULL
);


--
-- Name: adfeatures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.adfeatures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: adfeatures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.adfeatures_id_seq OWNED BY public.adfeatures.id;


--
-- Name: annonceurs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.annonceurs (
    id bigint NOT NULL,
    "sucessed_Ad" integer,
    "failed_Ad" integer,
    reward_engaged integer,
    reward_paid integer,
    reward_topay integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: annonceurs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.annonceurs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: annonceurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.annonceurs_id_seq OWNED BY public.annonceurs.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: classifiedads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.classifiedads (
    id bigint NOT NULL,
    "adReference" character varying,
    title character varying,
    short_description text,
    publicationdate date,
    deletedate date,
    "rewardPro" numeric,
    "rewardProPercent" numeric,
    "rewardInd" numeric,
    "rewardIndPercent" numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    localisation_id bigint,
    adstatus public.ads_status,
    sector public.sector_type,
    fixedreward boolean
);


--
-- Name: classifiedads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.classifiedads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: classifiedads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.classifiedads_id_seq OWNED BY public.classifiedads.id;


--
-- Name: localisations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.localisations (
    id bigint NOT NULL,
    number integer,
    street_type character varying,
    street character varying,
    district character varying,
    city character varying,
    dept integer,
    region character varying,
    logitude numeric,
    latitude numeric,
    radius integer,
    "time" integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: localisations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.localisations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: localisations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.localisations_id_seq OWNED BY public.localisations.id;


--
-- Name: propertyads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.propertyads (
    id bigint NOT NULL,
    netprice integer,
    livingarea numeric,
    landarea integer,
    rooms integer,
    bedrooms integer,
    floor integer,
    buildingyear integer,
    cmtyheating boolean,
    energydiagnostic character varying,
    carbon character varying,
    availability date,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    orientation public.orientation,
    propertytype public.property_type,
    propertystate public.property_state,
    classifiedad_id bigint NOT NULL
);


--
-- Name: propertyads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.propertyads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: propertyads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.propertyads_id_seq OWNED BY public.propertyads.id;


--
-- Name: propertyadwishes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.propertyadwishes (
    id bigint NOT NULL,
    wishlevel integer,
    comment character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    propertybuyad_id bigint,
    type_id bigint NOT NULL,
    propertytypewish_id integer,
    propertystatewish_id integer,
    propertydetailwish_id integer,
    insidefeaturewish_id integer,
    outsidefeaturewish_id integer,
    sharedfeaturewish_id integer,
    propertylocationwish_id integer
);


--
-- Name: propertyadwishes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.propertyadwishes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: propertyadwishes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.propertyadwishes_id_seq OWNED BY public.propertyadwishes.id;


--
-- Name: propertybuyads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.propertybuyads (
    id bigint NOT NULL,
    budget integer,
    supply integer,
    financing character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    classifiedad_id bigint NOT NULL
);


--
-- Name: propertybuyads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.propertybuyads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: propertybuyads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.propertybuyads_id_seq OWNED BY public.propertybuyads.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.types (
    id bigint NOT NULL,
    sector character varying,
    catetory character varying,
    "typeName" character varying,
    typekey character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.types_id_seq OWNED BY public.types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    first_name character varying,
    last_name character varying,
    admin boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: adfeatures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adfeatures ALTER COLUMN id SET DEFAULT nextval('public.adfeatures_id_seq'::regclass);


--
-- Name: annonceurs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annonceurs ALTER COLUMN id SET DEFAULT nextval('public.annonceurs_id_seq'::regclass);


--
-- Name: classifiedads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.classifiedads ALTER COLUMN id SET DEFAULT nextval('public.classifiedads_id_seq'::regclass);


--
-- Name: localisations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.localisations ALTER COLUMN id SET DEFAULT nextval('public.localisations_id_seq'::regclass);


--
-- Name: propertyads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyads ALTER COLUMN id SET DEFAULT nextval('public.propertyads_id_seq'::regclass);


--
-- Name: propertyadwishes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes ALTER COLUMN id SET DEFAULT nextval('public.propertyadwishes_id_seq'::regclass);


--
-- Name: propertybuyads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertybuyads ALTER COLUMN id SET DEFAULT nextval('public.propertybuyads_id_seq'::regclass);


--
-- Name: types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: adfeatures adfeatures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adfeatures
    ADD CONSTRAINT adfeatures_pkey PRIMARY KEY (id);


--
-- Name: annonceurs annonceurs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annonceurs
    ADD CONSTRAINT annonceurs_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: classifiedads classifiedads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.classifiedads
    ADD CONSTRAINT classifiedads_pkey PRIMARY KEY (id);


--
-- Name: localisations localisations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.localisations
    ADD CONSTRAINT localisations_pkey PRIMARY KEY (id);


--
-- Name: propertyads propertyads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyads
    ADD CONSTRAINT propertyads_pkey PRIMARY KEY (id);


--
-- Name: propertyadwishes propertyadwishes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT propertyadwishes_pkey PRIMARY KEY (id);


--
-- Name: propertybuyads propertybuyads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertybuyads
    ADD CONSTRAINT propertybuyads_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_adfeatures_on_classifiedad_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adfeatures_on_classifiedad_id ON public.adfeatures USING btree (classifiedad_id);


--
-- Name: index_adfeatures_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adfeatures_on_type_id ON public.adfeatures USING btree (type_id);


--
-- Name: index_classifiedads_on_localisation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_classifiedads_on_localisation_id ON public.classifiedads USING btree (localisation_id);


--
-- Name: index_propertyads_on_classifiedad_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_propertyads_on_classifiedad_id ON public.propertyads USING btree (classifiedad_id);


--
-- Name: index_propertyadwishes_on_propertybuyad_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_propertyadwishes_on_propertybuyad_id ON public.propertyadwishes USING btree (propertybuyad_id);


--
-- Name: index_propertyadwishes_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_propertyadwishes_on_type_id ON public.propertyadwishes USING btree (type_id);


--
-- Name: index_propertybuyads_on_classifiedad_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_propertybuyads_on_classifiedad_id ON public.propertybuyads USING btree (classifiedad_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: propertyadwishes fk_rails_0bf9c0ddf9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_0bf9c0ddf9 FOREIGN KEY (insidefeaturewish_id) REFERENCES public.propertybuyads(id);


--
-- Name: propertyadwishes fk_rails_28e11625f3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_28e11625f3 FOREIGN KEY (outsidefeaturewish_id) REFERENCES public.propertybuyads(id);


--
-- Name: propertyadwishes fk_rails_2fbab00e88; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_2fbab00e88 FOREIGN KEY (propertybuyad_id) REFERENCES public.propertybuyads(id);


--
-- Name: propertyadwishes fk_rails_54d4aafea9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_54d4aafea9 FOREIGN KEY (propertytypewish_id) REFERENCES public.propertybuyads(id);


--
-- Name: propertyadwishes fk_rails_5ae03a89ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_5ae03a89ca FOREIGN KEY (propertystatewish_id) REFERENCES public.propertybuyads(id);


--
-- Name: propertyadwishes fk_rails_6ab194d3e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_6ab194d3e2 FOREIGN KEY (type_id) REFERENCES public.types(id);


--
-- Name: adfeatures fk_rails_6decdc4b7f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adfeatures
    ADD CONSTRAINT fk_rails_6decdc4b7f FOREIGN KEY (type_id) REFERENCES public.types(id);


--
-- Name: propertybuyads fk_rails_737d865e7c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertybuyads
    ADD CONSTRAINT fk_rails_737d865e7c FOREIGN KEY (classifiedad_id) REFERENCES public.classifiedads(id);


--
-- Name: propertyads fk_rails_7eb8f15391; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyads
    ADD CONSTRAINT fk_rails_7eb8f15391 FOREIGN KEY (classifiedad_id) REFERENCES public.classifiedads(id);


--
-- Name: propertyadwishes fk_rails_86e3ff797e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_86e3ff797e FOREIGN KEY (propertylocationwish_id) REFERENCES public.propertybuyads(id);


--
-- Name: classifiedads fk_rails_aa1d51d410; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.classifiedads
    ADD CONSTRAINT fk_rails_aa1d51d410 FOREIGN KEY (localisation_id) REFERENCES public.localisations(id);


--
-- Name: adfeatures fk_rails_c4cbbd6950; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adfeatures
    ADD CONSTRAINT fk_rails_c4cbbd6950 FOREIGN KEY (classifiedad_id) REFERENCES public.classifiedads(id);


--
-- Name: propertyadwishes fk_rails_cfd3b69f4d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_cfd3b69f4d FOREIGN KEY (sharedfeaturewish_id) REFERENCES public.propertybuyads(id);


--
-- Name: propertyadwishes fk_rails_fba4cc03fa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propertyadwishes
    ADD CONSTRAINT fk_rails_fba4cc03fa FOREIGN KEY (propertydetailwish_id) REFERENCES public.propertybuyads(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210527194241'),
('20210703150334'),
('20210704222205'),
('20210704223750'),
('20210704225336'),
('20210704225535'),
('20210705215227'),
('20210705222301'),
('20210705222936'),
('20210705224152'),
('20210705225036'),
('20210706223133'),
('20210729145616'),
('20210729153723'),
('20210729154705'),
('20210729154737'),
('20210806181026'),
('20210806181607'),
('20210806181914'),
('20210806182049'),
('20210806182121'),
('20210807204235'),
('20210908201550');


