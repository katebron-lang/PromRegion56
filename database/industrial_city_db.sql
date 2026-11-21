--
-- PostgreSQL database dump
--

\restrict unbH1b4KFdZAMcvn3bsQqEoz2AOZUcM1PbSPNYVkgGacoteQpWd32oi0b366MYp

-- Dumped from database version 18.6 (Postgres.app)
-- Dumped by pg_dump version 18.6 (Postgres.app)

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
-- Name: cities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    region character varying(150) NOT NULL,
    district character varying(150),
    latitude double precision,
    longitude double precision,
    territory_type character varying(100),
    oktmo character varying(20),
    administrative_center character varying(150)
);


--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: data_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_sources (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    url text,
    source_type character varying(100),
    publication_date date,
    access_date date,
    description text
);


--
-- Name: data_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.data_sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.data_sources_id_seq OWNED BY public.data_sources.id;


--
-- Name: enterprise_metrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprise_metrics (
    id integer NOT NULL,
    enterprise_id integer NOT NULL,
    year integer NOT NULL,
    employees integer,
    revenue numeric,
    investments numeric,
    average_salary numeric,
    source_id integer,
    net_profit numeric,
    assets numeric,
    taxes_paid numeric,
    production_volume numeric,
    revenue_estimation_method text
);

COMMENT ON COLUMN public.enterprise_metrics.revenue_estimation_method IS 'Способ расчёта подставленной выручки. Заполнен для оценок, внесённых при заполнении пропусков.';


--
-- Name: COLUMN enterprise_metrics.net_profit; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprise_metrics.net_profit IS 'Чистая прибыль за год, руб.';


--
-- Name: COLUMN enterprise_metrics.assets; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprise_metrics.assets IS 'Активы предприятия на конец года, руб.';


--
-- Name: COLUMN enterprise_metrics.taxes_paid; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprise_metrics.taxes_paid IS 'Уплаченные налоги за год, руб.';


--
-- Name: COLUMN enterprise_metrics.production_volume; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprise_metrics.production_volume IS 'Объем производства, если показатель опубликован';


--
-- Name: enterprise_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprise_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprise_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprise_metrics_id_seq OWNED BY public.enterprise_metrics.id;


--
-- Name: enterprise_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprise_products (
    id integer NOT NULL,
    enterprise_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    product_category character varying(150),
    description text,
    is_main boolean DEFAULT false,
    source_id integer
);


--
-- Name: enterprise_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprise_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprise_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprise_products_id_seq OWNED BY public.enterprise_products.id;


--
-- Name: enterprise_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprise_sources (
    id integer NOT NULL,
    enterprise_id integer NOT NULL,
    source_id integer NOT NULL,
    source_role character varying(100),
    notes text
);


--
-- Name: enterprise_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprise_sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprise_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprise_sources_id_seq OWNED BY public.enterprise_sources.id;


--
-- Name: enterprises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    short_name character varying(250),
    inn character varying(12),
    ogrn character varying(15),
    city_id integer NOT NULL,
    industry_id integer NOT NULL,
    okved character varying(20),
    address text,
    activity_description text,
    products text,
    website character varying(255),
    phone character varying(50),
    email character varying(150),
    latitude double precision,
    longitude double precision,
    status character varying(50),
    foundation_year integer,
    employee_category character varying(100),
    is_city_forming boolean DEFAULT false,
    is_major_enterprise boolean DEFAULT false,
    economic_role character varying(150)
);


--
-- Name: COLUMN enterprises.economic_role; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.economic_role IS 'Роль предприятия в экономике территории';


--
-- Name: enterprises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_id_seq OWNED BY public.enterprises.id;


--
-- Name: industries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.industries (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text
);


--
-- Name: industries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.industries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: industries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.industries_id_seq OWNED BY public.industries.id;


--
-- Name: investment_projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.investment_projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    city_id integer,
    enterprise_id integer,
    industry_id integer,
    status character(100),
    start_year integer,
    end_year integer,
    investment_amount numeric(18,0),
    jobs_created integer,
    description text,
    source_id integer
);


--
-- Name: investment_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.investment_projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: investment_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.investment_projects_id_seq OWNED BY public.investment_projects.id;


--
-- Name: territory_metrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.territory_metrics (
    id integer NOT NULL,
    city_id integer,
    year integer NOT NULL,
    population integer,
    average_salary numeric(12,2),
    unemployment_rate numeric(5,2),
    investments numeric(18,2),
    industrial_output numeric(18,2),
    employed_population integer,
    enterprises_count integer,
    industrial_enterprises_count integer,
    source_id integer
);


--
-- Name: territory_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.territory_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: territory_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.territory_metrics_id_seq OWNED BY public.territory_metrics.id;


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: data_sources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_sources ALTER COLUMN id SET DEFAULT nextval('public.data_sources_id_seq'::regclass);


--
-- Name: enterprise_metrics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_metrics ALTER COLUMN id SET DEFAULT nextval('public.enterprise_metrics_id_seq'::regclass);


--
-- Name: enterprise_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_products ALTER COLUMN id SET DEFAULT nextval('public.enterprise_products_id_seq'::regclass);


--
-- Name: enterprise_sources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_sources ALTER COLUMN id SET DEFAULT nextval('public.enterprise_sources_id_seq'::regclass);


--
-- Name: enterprises id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises ALTER COLUMN id SET DEFAULT nextval('public.enterprises_id_seq'::regclass);


--
-- Name: industries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.industries ALTER COLUMN id SET DEFAULT nextval('public.industries_id_seq'::regclass);


--
-- Name: investment_projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investment_projects ALTER COLUMN id SET DEFAULT nextval('public.investment_projects_id_seq'::regclass);


--
-- Name: territory_metrics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.territory_metrics ALTER COLUMN id SET DEFAULT nextval('public.territory_metrics_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cities (id, name, region, district, latitude, longitude, territory_type, oktmo, administrative_center) FROM stdin;
1	Новотроицк	Оренбургская область	городской округ город Новотроицк	51.203	58.3267	город	53720000001	Новотроицк
2	Орск	Оренбургская область	городской округ город Орск	51.2049	58.5668	город	53723000001	Орск
3	Оренбург	Оренбургская область	городской округ город Оренбург	51.7682	55.0969	город	53701000001	Оренбург
4	Гай	Оренбургская область	Гайский муниципальный округ	51.4666	58.4552	город	53503000001	Гай
5	Бузулук	Оренбургская область	городской округ город Бузулук	52.7885	52.2539	город	53712000001	Бузулук
6	Медногорск	Оренбургская область	городской округ город Медногорск	51.40494	57.58031	город	53715000001	Медногорск
15	Дубенский	Оренбургская область	Беляевский район	\N	\N	\N	\N	\N
16	Юный	Оренбургская область	Оренбургский район	\N	\N	\N	\N	\N
17	Нежинка	Оренбургская область	Оренбургский район	\N	\N	\N	\N	\N
18	Холодные Ключи	Оренбургская область	Оренбургский район	\N	\N	\N	\N	\N
19	Мазуровка	Оренбургская область	Оренбургский район	\N	\N	\N	\N	\N
12	Кувандык	Оренбургская область	Кувандыкский муниципальный округ	\N	\N	\N	\N	\N
20	Сара	Оренбургская область	Кувандыкский муниципальный округ	\N	\N	\N	\N	\N
21	Дубиновка	Оренбургская область	Кувандыкский муниципальный округ	\N	\N	\N	\N	\N
10	Соль-Илецк	Оренбургская область	Соль-Илецкий муниципальный округ	\N	\N	\N	\N	\N
8	Ясный	Оренбургская область	Ясненский муниципальный округ	\N	\N	\N	\N	\N
9	Сорочинск	Оренбургская область	\N	\N	\N	\N	\N	\N
14	Бугуруслан	Оренбургская область	\N	\N	\N	\N	\N	\N
22	Акбулак	Оренбургская область	Акбулакский район	\N	\N	\N	\N	\N
23	Саракташ	Оренбургская область	Саракташский район	\N	\N	\N	\N	\N
24	Абдулино	Оренбургская область	Абдулинский муниципальный округ	\N	\N	\N	\N	\N
11	Светлый	Оренбургская область	Светлинский район	\N	\N	\N	\N	\N
13	Тюльган	Оренбургская область	Тюльганский район	\N	\N	\N	\N	\N
7	Переволоцкий	Оренбургская область	Переволоцкий район	\N	\N	\N	\N	\N
\.


--
-- Data for Name: data_sources; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.data_sources (id, name, url, source_type, publication_date, access_date, description) FROM stdin;
1	Программа развития муниципального образования город Новотроицк	https://base.garant.ru/408025329/1b93c134b90c6071b4dc3f495464b753/	Муниципальный нормативный документ	2023-11-14	2026-09-06	Сведения о крупных и средних предприятиях Новотроицка и структуре промышленности
2	АО «Уральская Сталь» — официальный сайт	https://uralsteel.com/	Официальный сайт предприятия	\N	2026-09-06	Информация о предприятии, продукции и деятельности АО «Уральская Сталь»
3	ООО «Оренбургский пропант» — официальный сайт	https://orenpropant.ru/	Официальный сайт предприятия	\N	2026-09-06	Информация о производстве пропантов, численности работников и инвестициях
4	АО «Новотроицкий цементный завод» — официальный сайт	https://novocement.ru/	Официальный сайт предприятия	\N	2026-09-06	Информация о деятельности и продукции Новотроицкого цементного завода
5	AKKERMANN CEMENT — официальный сайт	https://akkermann.ru/kratkaya-informacziya-o-kompanii/	Официальный сайт предприятия	\N	2026-09-06	Информация о производственных мощностях и деятельности ООО «АККЕРМАНН ЦЕМЕНТ»
6	АО «Новотроицкий завод хромовых соединений»	http://www.nzhs.ru/	Официальный сайт предприятия	\N	2026-09-06	Информация об АО «НЗХС», химической и металлургической продукции
7	АО «ЮУЗМС» — официальный сайт	https://xn--g1akpf8c.xn--p1ai/	Официальный сайт предприятия	\N	2026-09-08	Производство сульфата магния, удобрений и кормовых добавок; новости и вакансии 2026 года.
8	ООО «ЮМЗ» — официальный сайт	https://www.oooyumz.ru/contact	Официальный сайт предприятия	\N	2026-09-08	Реквизиты, адрес, контакты и номенклатура Южноуральского механического завода.
9	ПАО «Долина» — раскрытие информации 2026	https://e-disclosure.azipi.ru/messages/4553884/	Раскрытие информации эмитента	2026-06-17	2026-09-08	Актуальные на 2026 год сведения об эмитенте, ИНН, ОГРН и адресе.
10	ПАО «Долина» — официальный сайт	https://ao-dolina.com/about/	Официальный сайт предприятия	\N	2026-09-08	Реквизиты, адрес, контакты и сведения о производстве Кувандыкского завода КПО «Долина».
11	АО «Саринский элеватор» — Ростехнадзор	https://www.gosnadzor.ru/energy/energy/%D0%93%D1%80%D0%B0%D1%84%D0%B8%D0%BA%20%D0%9F%D0%91_3%20%D0%B8%204%20%D0%BA%D0%BB%D0%B0%D1%81%D1%81.pdf	Официальный государственный источник	\N	2026-09-08	Подтверждение эксплуатации объектов АО «Саринский элеватор» в 2026 году.
12	ООО МП «ПромСтройМаш» — официальный сайт	https://stanki-psm.ru/company/	Официальный сайт предприятия	\N	2026-09-08	Производственная площадка в Кувандыке, производство и ремонт металлообрабатывающего оборудования.
13	ООО «Хлебокомбинат» — сведения о юридическом лице	https://companies.rbc.ru/id/1025600752825-ooo-hlebokombinat/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД и статус Кувандыкского хлебокомбината.
14	ООО «КЗМП» — официальный сайт	https://stankopromservis.ru/about	Официальный сайт предприятия	\N	2026-09-08	Сведения о Кувандыкском заводе механических прессов и выпускаемом оборудовании.
15	АО «Дубиновское ХПП» — сведения о юридическом лице	https://companies.rbc.ru/id/1025600752616-ao-dubinovskoe-hlebopriemnoe-predpriyatie/	Открытый реестр юридических лиц	\N	2026-09-08	Реквизиты и сведения о действующем Дубиновском хлебоприемном предприятии.
16	ООО «Хлебокомбинат» — декларация соответствия 2026	https://xn----7sbajahheyaepn1ca0aveqcb0fxl.xn--p1acf/document/eaes-n-ru-d-rura07v6712126/	Реестр деклараций соответствия	2026-08-28	2026-09-08	Подтверждение производства хлебобулочной продукции в Кувандыке в 2026 году.
17	АО «Криолит» — сведения о юридическом лице	https://companies.rbc.ru/amp/ogrn/1025600752814/	Открытый реестр юридических лиц	\N	2026-09-08	Реквизиты и действующий статус юридического лица АО «Криолит».
18	ООО «КЗМП» — сведения о юридическом лице	https://saby.ru/profile/5607144468-560701001	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД и действующий статус.
19	ООО «Промстанкомаш» — сведения о юридическом лице	https://companies.rbc.ru/id/1205600011033-obschestvo-s-ogranichennoj-otvetstvennostyu-promstankomash/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД и действующий статус.
20	Соль-Илецкий машиностроительный завод — производственный профиль	https://www.oborudunion.ru/company/2387066/	Отраслевой каталог	\N	2026-09-08	Сведения о специализации завода на сельскохозяйственной и прицепной технике, адрес и контакты.
21	ООО «Илецк-Строй» — сведения о юридическом лице	https://companies.rbc.ru/id/1245600004572-ooo-iletsk-stroj/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, основной ОКВЭД 23.61.1 и действующий статус производителя бетонных и цементных изделий.
104	АО «Оренбургские минералы» — отчетность 2025	https://xfirm.ru/company/5618000027	Данные ФНС и Росстата	\N	2026-09-09	Выручка и среднесписочная численность за 2025 год.
22	ЦДПС «Илецксоль» — ООО «Руссоль»	https://russalt.ru/geografiya-dobychi/czdps-ileczksol/	Официальный сайт предприятия	\N	2026-09-08	Производственная площадка в Соль-Илецке: адрес, мощность до 1,7 млн тонн соли в год, более 560 млн тонн разведанных запасов и 530 сотрудников.
23	ООО «Источник» — сведения о юридическом лице	https://companies.rbc.ru/id/1265600001820-ooo-istochnik/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД 11.07 и действующий статус производителя напитков и упакованных вод.
24	Администрация Соль-Илецкого муниципального округа — прогноз социально-экономического развития 2025–2027	https://soliletsk.ru/assets/files/economic/3040-p-ot-05.12.2024-prognoz-ser.pdf	Официальный муниципальный документ	2024-12-05	2026-09-08	Официальные показатели населения, промышленного производства, инвестиций, занятости, безработицы и заработной платы.
25	ООО «Соль-Илецкий кирпичный завод - 1» — исторические сведения	https://companies.rbc.ru/id/1125658031971-obschestvo-s-ogranichennoj-otvetstvennostyu-sol-iletskij-kirpichnyij-zavod-1/	Открытый реестр юридических лиц	\N	2026-09-08	Историческое промышленное предприятие; ликвидировано 30.10.2014.
26	ООО «Соль-Илецкий Элеватор» — официальный сайт	https://iletsk.ru/o-nas	Официальный сайт предприятия	\N	2026-09-08	Элеваторный комплекс по приемке, подработке, хранению и отгрузке зерновых, зернобобовых и масличных культур; вместимость хранения до 140 тыс. тонн.
27	ООО «Соль-Илецкий машиностроительный завод» — сведения о юридическом лице	https://companies.rbc.ru/id/1035617275583-ooo-sol-iletskij-mashinostroitelnyij-zavod/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД и действующий статус Соль-Илецкого машиностроительного завода.
28	ООО «Руссоль» — реквизиты и статус	https://companies.rbc.ru/id/1085658025650-ooo-russol/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 08.93 и действующий статус ООО «Руссоль».
29	ООО «Соль-Илецкий кирпичный завод» — исторические сведения	https://companies.rbc.ru/id/1035617270765-ooo-sol-iletskij-kirpichnyij-zavod/	Открытый реестр юридических лиц	\N	2026-09-08	Историческое промышленное предприятие; ликвидировано 20.11.2014.
30	ООО «Соль-Илецкий Элеватор» — сведения о юридическом лице	https://companies.rbc.ru/id/1215600001957-obschestvo-s-ogranichennoj-otvetstvennostyu-zvezda/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, численность и действующий статус ООО «Соль-Илецкий Элеватор».
31	ООО «Оренгипс» — исторические сведения	https://companies.rbc.ru/id/1075658012913-obschestvo-s-ogranichennoj-otvetstvennostyu-orengips/	Открытый реестр юридических лиц	\N	2026-09-08	Историческое предприятие по добыче гипсового сырья и производству гипсовых изделий; ликвидировано 01.09.2015.
32	ООО «ОММИКС» — сведения о юридическом лице	https://check.tochka.com/company/1205600003696/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 20.51, адрес и действующий статус производителя взрывчатых веществ.
33	ООО «Мастодек» — официальный сайт	https://mastodek.ru/	Официальный сайт предприятия	\N	2026-09-08	Продукция из минерально-полимерного композита, контакты и реквизиты.
34	ООО «Палето 2.0» — производственная площадка	https://tppvo.ru/site_data/s273/files/files2024/Paleto.pdf	Документ торгово-промышленной палаты	\N	2026-09-08	Подтверждение швейного производства в Ясном, адреса площадки, телефона, e-mail, ИНН и ОГРН.
35	ООО «Ясный Камень» — исторические сведения	https://companies.rbc.ru/id/1135658006945-obschestvo-s-ogranichennoj-otvetstvennostyu-yasnyij-kamen/	Открытый реестр юридических лиц	\N	2026-09-08	Историческое предприятие добычи строительного камня; ликвидировано.
36	АО «Оренбургские минералы» — контакты и реквизиты	https://orenmin.ru/kontakty/	Официальный сайт предприятия	\N	2026-09-08	ИНН, адрес, телефоны и электронная почта предприятия.
37	АО «Оренбургские минералы» — сведения о юридическом лице	https://companies.rbc.ru/id/1025602137956-ao-kiembaevskij-gorno-obogatitelnyij-kombinat-orenburgskie-mineralyi/	Открытый реестр юридических лиц	\N	2026-09-08	ОГРН, ИНН, ОКВЭД 08.99.23, действующий статус и финансовые показатели.
38	ООО «Царь-Хлеб» — ликвидационная процедура	https://companies.rbc.ru/id/1215600000131-obschestvo-s-ogranichennoj-otvetstvennostyu-tsar-hleb/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 10.71 и статус процесса ликвидации в 2026 году.
39	ТОР «Ясный» — новый проект ООО «Кераминос»	https://orenburg.media/?p=546746	Региональный информационный источник	2026-07-05	2026-09-08	Проект добычи каолина-сырца: инвестиции более 70 млн руб., 28 рабочих мест, запуск проекта в 2026 году, ввод производства в 2027 году.
40	АО «Оренбургские минералы» — официальный сайт	https://orenmin.ru/	Официальный сайт предприятия	\N	2026-09-08	Градообразующее предприятие Ясного; производство хризотила, сведения о продукции, новостях и деятельности.
41	ООО «УралПромМаш» — производство в 2025 году	https://myseldon.com/ru/news/index/327572684	Региональный информационный источник	2025-04-10	2026-09-08	Подтверждение работы машиностроительного завода и выпуска/ремонта оборудования.
42	ООО «ОМ» — экспортные переговоры 2026	https://yasvesti.ru/2026/07/28/orenburgskie-predpriyatiya-nalazhivajut-sotrudnichestvo-s-indiej/	Региональный информационный источник	2026-07-28	2026-09-08	Подтверждение действующего производства стабилизирующей добавки «Хризопро» в 2026 году.
43	ООО «ПРОМОТОР» — сведения о юридическом лице	https://companies.rbc.ru/id/1205600005940-obschestvo-s-ogranichennoj-otvetstvennostyu-promotor/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 33.17, адрес и действующий статус предприятия по ремонту железнодорожной техники.
44	ООО «ЦПМ» — сведения о юридическом лице	https://companies.rbc.ru/id/1185658006698-ooo-tspm/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 13.92.1, адрес и действующий статус.
45	ООО «Яснотекс» — производство 2025	https://yasvesti.ru/2025/05/23/tri-pary-zheleznyh-sapog-yasnoteks/	Региональный информационный источник	2025-05-23	2026-09-08	Подтверждение работы предприятия по производству спецодежды и текстильных изделий.
46	ООО «Мастодек» — сведения о юридическом лице	https://companies.rbc.ru/id/1205600013850-obschestvo-s-ogranichennoj-otvetstvennostyu-mastodek/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес и ОКВЭД 23.99.
47	ООО «ЭнергетикПлюс» — сведения о юридическом лице	https://companies.rbc.ru/id/1165658072634-ooo-energetikplyus/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 35.30.1, адрес и действующий статус в 2026 году.
48	ООО «Кераминос» — сведения о юридическом лице	https://companies.rbc.ru/id/1235600010150-ooo-ooo-keraminos/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД 08.12.2 и действующий статус юридического лица.
49	ТОР «Ясный» — обзор 12 производственных предприятий	https://pda.orsk.ru/news/126280-toser-%C2%AByasnyy%C2%BB-12-predpriyatiy-kotorye-sozdayut-unikalnye-produkty	Региональный информационный источник	\N	2026-09-08	Производственные профили ОМ, ОММИКС, Мастмастер, Мастодек, ЦПМ, УралПромМаш, Восток-СТС, ПРОМОТОР, Палето 2.0, Композит и других резидентов.
50	ООО «Ясненский хлебозавод» — актуальные сведения	https://star-pro.ru/proverka-kontragenta/organization/1065635007855--ooo-yasnenskij-xlebozavod	Открытый реестр юридических лиц	2026-07-02	2026-09-08	ИНН, ОГРН, адрес, основной профиль и действующий статус в 2026 году.
51	ООО «Мастмастер» — сведения о юридическом лице	https://companies.rbc.ru/id/1195658014452-obschestvo-s-ogranichennoj-otvetstvennostyu-mastmaster/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД 20.30, численность и действующий статус в 2026 году.
52	ООО «Яснотекс» — сведения о юридическом лице	https://companies.rbc.ru/id/1195658008435-obschestvo-s-ogranichennoj-otvetstvennostyu-yasnoteks/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес и действующий статус производителя спецодежды.
53	ООО «Керамос» — банкротство	https://check.tochka.com/company/1025602137714/	Открытый реестр юридических лиц	\N	2026-09-08	Компания в стадии банкротства; ИНН, ОГРН, ОКВЭД 08.12.2 и адрес.
54	Исторический промышленный профиль города Ясный	https://base.garant.ru/27515180/53f89421bbdaf741eb2d1ecc4ddb4c33/	Официальный региональный нормативный документ	\N	2026-09-08	Исторический перечень промышленных предприятий Ясного и их специализация.
55	ООО «ОМ» — сведения о юридическом лице	https://companies.rbc.ru/id/1165658060798-ooo-om/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД 23.99 и действующий статус.
56	ООО «Композит» — сведения о юридическом лице	https://companies.rbc.ru/id/1205600013849-obschestvo-s-ogranichennoj-otvetstvennostyu-kompozit/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 23.99, адрес и действующий статус.
57	Региональная программа развития промышленности Оренбургской области — 2026	https://base.garant.ru/414691197/5ac206a89ea76855804609cd950fcaf7/	Официальный региональный нормативный документ	2026-07-28	2026-09-08	АО «Оренбургские минералы» включено в перечень производителей Оренбургской области.
58	ООО «УралПромМаш» — сведения о юридическом лице	https://companies.rbc.ru/id/1165658070126-ooo-uralskie-promyishlennyie-mashinyi/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД 28.99, численность и действующий статус на 2026 год.
59	ООО «Ясненская пивоварня» — актуальные сведения	https://check.tochka.com/company/1195658006257/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД 11.05 и действующий статус в 2026 году.
60	ООО «Восток-СТС» — сведения о юридическом лице	https://companies.rbc.ru/id/1195658008479-obschestvo-s-ogranichennoj-otvetstvennostyu-vostok-spetstehservis/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, профиль ремонта техники и действующий статус.
61	ООО «Энергоресурс» — сведения о юридическом лице	https://companies.rbc.ru/id/1105658027067-ooo-energoresurs/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 35.30.2, адрес и действующий статус в 2026 году.
62	ООО «Компонент-Лактис» — сведения о юридическом лице	https://companies.rbc.ru/id/1175658005643-ooo-komponent-laktis/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД и действующий статус ООО «Компонент-Лактис».
63	ООО «Компонент-Лактис» — производство 2026	https://orenburzhie.ru/news/v-buguruslane-nachnut-vypusk-probiotika-novogo-pokoleniya/	Региональный информационный источник	2026-02-02	2026-09-08	Подтверждение работы биотехнологического предприятия в Бугуруслане в 2026 году.
64	ООО «БайТекс» — ФНС БФО	https://bo.nalog.gov.ru/organizations-card/6925757	Официальный источник ФНС	\N	2026-09-08	Действующий статус, ИНН, ОГРН, адрес и ОКВЭД 06.10.1.
65	АО «Оренбургнефтеотдача» — сведения о предприятии	https://saby.ru/profile/5645001990-560201001	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД и действующий статус АО «Оренбургнефтеотдача».
66	ООО «НПК «Фильтр» — официальный сайт	https://www.npk-filtr.ru/contacts	Официальный сайт предприятия	\N	2026-09-08	Реквизиты, адрес, контакты и производственная площадка НПК «Фильтр» в Бугуруслане.
67	ООО «НПК «Фильтр» — сведения о юридическом лице	https://companies.rbc.ru/id/1146319009495-ooo-nauchno-proizvodstvennaya-kompaniya-filtr/	Открытый реестр юридических лиц	\N	2026-09-08	ОКВЭД, действующий статус и сведения о предприятии.
68	ООО «Сорочинский МЭЗ» — Федеральный центр компетенций	https://xn--b1aedfedwqbdfbnzkf0oe.xn--p1ai/national-project/organizations_pages/5617020920/	Официальный федеральный ресурс	\N	2026-09-08	Подтверждение деятельности предприятия, ИНН, ОКВЭД 10.41.2 и профиль производства.
69	ООО «Сорочинский МЭЗ» — сведения о юридическом лице	https://companies.rbc.ru/amp/ogrn/1105658027012/	Открытый реестр юридических лиц	\N	2026-09-08	ОГРН, ИНН, адрес, численность и действующий статус на 2026 год.
70	ООО «Сорочинский элеватор» — Федеральный центр компетенций	https://xn--b1aedfedwqbdfbnzkf0oe.xn--p1ai/national-project/organizations_pages/5617020895/	Официальный федеральный ресурс	\N	2026-09-08	Подтверждение деятельности элеватора, ИНН и ОКВЭД 52.10.3.
71	ООО «Сорочинский элеватор» — сведения о юридическом лице	https://companies.rbc.ru/id/1105658021512-ooo-sorochinskij-elevator/	Открытый реестр юридических лиц	\N	2026-09-08	ОГРН, ИНН, адрес и действующий статус.
72	ЗАО «Сорочинский КХП» — исторические сведения	https://site.birweb.1prime.ru/company-brief/1535831	Открытый реестр юридических лиц	\N	2026-09-08	Исторический комбинат хлебопродуктов; прекращение деятельности подтверждено на 2026 год.
73	ООО «Мясокомбинат «Сорочинский» — исторические сведения	https://companies.rbc.ru/id/1195658002572-obschestvo-s-ogranichennoj-otvetstvennostyu-myasokombinat-sorochinskij/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, профиль производства и ликвидированный статус.
74	ООО «ЦРВ Абдулино» — официальный сайт	https://crv-abdulino.ru/	Официальный сайт предприятия	\N	2026-09-08	Подтверждение действующего вагоноремонтного производства в Абдулино.
75	ООО «ЦРВ Абдулино» — сведения о юридическом лице	https://companies.rbc.ru/id/1085658022977-ooo-tsentr-remonta-vagonov-abdulino/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, численность и профиль деятельности.
76	ООО «Мяско» — сведения о юридическом лице	https://check.tochka.com/company/1155658010804/	Открытый реестр юридических лиц	\N	2026-09-08	Действующий статус, ИНН, ОГРН и ОКВЭД 10.11.1.
77	ООО «Абдулинский механический завод» — сведения о юридическом лице	https://check.tochka.com/region/abdulino/	Открытый реестр юридических лиц	\N	2026-09-08	На 2026 год принято решение о предстоящем исключении юридического лица из ЕГРЮЛ.
78	ООО «ЛБ Минералс-Светлое» — инвестиционный портал Оренбургской области	https://investinorenburg.ru/projects/	Официальный региональный инвестиционный портал	\N	2026-09-08	Проект обогащения каолина: 1,3 млрд рублей инвестиций, 80 рабочих мест, статус реализован.
79	ООО «ЛБ Минералс-Светлое» — сведения о юридическом лице	https://check.tochka.com/company/1215600002892/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес, ОКВЭД и действующий статус на 2026 год.
80	АО «Элеватор Рудный Клад» — корпоративные сведения	https://e-disclosure.azipi.ru/organization/personal-pages/363353/	Раскрытие информации эмитента	\N	2026-09-08	Реквизиты и сведения о юридическом лице.
81	АО «Элеватор Рудный Клад» — судебные сведения о прекращении основной деятельности	https://base.garant.ru/38946963/	Судебный акт	2025-07-28	2026-09-08	Судом установлено отчуждение почти всего имущественного комплекса и невозможность дальнейшей деятельности по хранению зерна.
82	МКП «Светлое» — сведения о юридическом лице	https://check.tochka.com/company/1225600008567/	Открытый реестр юридических лиц	\N	2026-09-08	Действующее энергетическое предприятие, производство тепловой энергии котельными.
83	ООО «ТЭМЗ» — официальный сайт	https://temz.ru/	Официальный сайт предприятия	\N	2026-09-08	Реквизиты, адрес, контакты и сведения о действующем Тюльганском электромеханическом заводе.
84	ООО «Тюльганский машиностроительный завод» — МЧС России	https://digital.mchs.gov.ru/fgpn/license/56-06-2026-003211	Официальный государственный реестр	2026-08-01	2026-09-08	ИНН, ОГРН, адрес и действующая лицензия предприятия в 2026 году.
85	ООО «Тюльганский машиностроительный завод» — сведения о юридическом лице	https://www.tbank.ru/business/contractor/legal/1055638047299/	Открытый реестр юридических лиц	\N	2026-09-08	Действующий статус, профиль механической обработки и дополнительные производственные ОКВЭД.
86	ОАО «Переволоцкий элеватор» — официальный сайт	https://orenelevator.ru/	Официальный сайт предприятия	\N	2026-09-08	Производство пшеничной муки, гречневой крупы и отрубей; адрес и контакты.
87	ОАО «Переволоцкий элеватор» — сведения о юридическом лице	https://companies.rbc.ru/id/1025602665395-oao-perevolotskij-elevator/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, адрес и действующий статус.
88	ООО «Самара Лей» — региональная научно-технологическая программа	https://base.garant.ru/413364998/1b93c134b90c6071b4dc3f495464b753/	Официальный региональный нормативный документ	2025-12-24	2026-09-08	Предприятие в Переволоцком указано как производитель паровых котлов и блочно-модульных котельных.
89	ООО «Самара Лей» — сведения о юридическом лице	https://spark-interfax.ru/statistics/city/53237000000	Открытый реестр компаний	\N	2026-09-08	ИНН 5640005535, ОГРН 1025602667441, адрес и действующий статус.
90	ООО «ТД «Завод Коммунар» — официальный сайт	https://kommunar.com/contact/	Официальный сайт предприятия	\N	2026-09-08	Производственная площадка в Саракташе, контакты и специализация на гидрооборудовании.
91	ООО «ТД «Завод Коммунар» — реквизиты производителя	https://fabricators.ru/proizvoditel/zavod-kommunar	Отраслевой каталог производителей	2026-04-27	2026-09-08	ИНН, ОГРН и сведения о производстве гидравлического оборудования.
92	ПК «Саракташский консервный завод» — сведения о юридическом лице	https://companies.rbc.ru/id/1155658022486-pk-pk-saraktashskij-konservnyij-zavod/	Открытый реестр юридических лиц	\N	2026-09-08	ИНН, ОГРН, ОКВЭД 10.39 и действующий статус на 2026 год.
93	Саракташский консервный завод — ОблПотребСоюз	https://orenops.ru/predpriyatie.html	Официальный сайт отраслевого объединения	\N	2026-09-08	Адрес, контакты и подтверждение действующей производственной площадки.
94	ООО «Саракташский молочный завод «Анаир» — исторические сведения	https://egrul.org/5643007876	Открытые данные ЕГРЮЛ	2026-07-13	2026-09-08	Ликвидированное молочное предприятие; дата прекращения деятельности 10.01.2019.
95	ООО «Степной Барашек» — сведения о юридическом лице	https://check.tochka.com/company/1265600002106/	Открытый реестр юридических лиц	\N	2026-09-08	Новое действующее предприятие 2026 года по переработке и консервированию мяса.
96	ООО «Акмел Добыча» — сведения о ликвидации	https://reputation.ru/ogrn/1145658339474	Открытый реестр юридических лиц	2026-02-11	2026-09-08	Исторический проект добычи и переработки мела; компания ликвидирована после банкротства 11.02.2026.
97	Проект завода тонкодисперсного мела в Акбулаке	https://web-hotfix-test010.k8s.trudvsem.ru/map/region?regionCode=5600000000000	Государственный инвестиционный ресурс	\N	2026-09-08	Историческая карточка проекта ООО «Акмел Добыча»: завод тонкодисперсного мела мощностью 100 тыс. тонн в год.
98	ПК «Саракташский консервный завод» — отчетность 2025	https://www.tbank.ru/business/contractor/legal/1155658022486/	Бухгалтерская отчетность	\N	2026-09-09	Выручка за 2025 год.
99	АО «Южно-Уральский химзавод» — показатели 2025	https://firmoteka.ru/5605021799	Данные ФНС	\N	2026-09-09	Выручка и среднесписочная численность за 2025 год.
100	ООО «ТЭМЗ» — отчетность 2025	https://companies.rbc.ru/id/1035618981485-ooo-tyulganskij-elektro-mehanicheskij-zavod/	Бухгалтерская отчетность	\N	2026-09-09	Выручка за 2025 год.
101	ООО «ЛБМ-Светлое» — показатели 2025	https://b2b.house/company/OOO-LBM-SVETLOE_1d393c2f-53fa-4b90-9634-731be1e48e14/	Бухгалтерская отчетность	\N	2026-09-09	Выручка и среднесписочная численность за 2025 год.
102	АО «МЭЗ «Уралэлектро» — выручка 2025	https://birweb-qa.1prime.ru/company-brief/1534247	Бухгалтерская отчетность	\N	2026-09-09	Выручка за 2025 год. Численность на странице относится к более раннему периоду и не используется.
103	ООО «ЦРВ Абдулино» — показатели 2025	https://reputation.ru/ogrn/1085658022977	Данные ФНС	\N	2026-09-09	Выручка и среднесписочная численность за 2025 год.
105	Фирмотека — рейтинг компаний Оренбургской области за 2025 год	https://firmoteka.ru/rating-by-revenue-reg56	Данные бухгалтерской отчетности ФНС	\N	2026-09-09	Выручка и, где доступно, среднесписочная численность за 2025 год.
106	ПАО «Орскнефтеоргсинтез» — отчетность 2025	https://companies.rbc.ru/id/1025601998498-pao-orsknefteorgsintez/	Бухгалтерская отчетность	\N	2026-09-09	Выручка за 2025 год.
107	ООО «БайТекс» — отчетность 2025	https://companies.rbc.ru/id/1025600545266-ooo-bajteks/	Бухгалтерская отчетность	\N	2026-09-09	Выручка за 2025 год.
108	Гайский ГОК — РСБУ 2025	https://cbonds.ru/news/3859357/	Отчетность РСБУ	\N	2026-09-09	Выручка ПАО «Гайский ГОК» за 2025 год.
109	ОАО «Переволоцкий элеватор» — отчетность 2025	https://www.tbank.ru/business/contractor/legal/1025602665395/	Бухгалтерская отчетность	\N	2026-09-09	Выручка за 2025 год.
110	АО «РИФАР» — ФНС 2025	https://firmoteka.ru/5604009196	Данные ФНС	\N	2026-09-09	Выручка и среднесписочная численность за 2025 год.
111	ООО «Сорочинский МЭЗ» — показатели 2025	https://reputation.ru/ogrn/1105658027012	Данные ФНС	\N	2026-09-09	Выручка и среднесписочная численность за 2025 год.
112	ООО «НСплав» — показатели за 2024 год	https://b2b.house/company/OOO-NSPLAV_5e0683cc-fe00-4778-bac0-b796c4af9388/	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2024 год — 2 807 055 000 руб.; среднесписочная численность — 154 человека.
113	ООО «Компонент-Лактис» — численность 2024	https://companium.ru/id/1175658005643-komponent-laktis	Данные ФНС / аналитический агрегатор	\N	2026-09-09	Среднесписочная численность за 2024 год — 41 человек.
114	АО «МЭЗ «Уралэлектро» — бухгалтерская отчетность за 2024 год	https://companies.rbc.ru/id/1025600752649-oao-aktsionernoe-obschestvo-mednogorskij-elektrotehnicheskij-zavod-uralelektro/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка за 2024 год — 1 699 882 000 руб.
115	ООО «Оренбургский пропант» — показатели за 2024 год	https://companies.rbc.ru/id/1175658020449-ooo-obschestvo-s-ogranichennoj-otvetstvennostyu-orenburgskij-propant/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка за 2024 год — 5 789 017 000 руб.
116	ООО «ЦРВ Абдулино» — показатели за 2024 год	https://b2b.house/company/OOO-CRV-ABDULINO_50674f6c-658e-40c2-8fc5-60685260e06e/	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2024 год — 442 778 000 руб.; среднесписочная численность — 138 человек.
117	ПАО «Орскнефтеоргсинтез» — финансовые показатели 2024	https://energybase.ru/downstream/orsknefteorgsintez	Бухгалтерская отчетность / отраслевой справочник	\N	2026-09-09	Выручка за 2024 год — 24 176 919 тыс. руб.
118	ООО «Газпром добыча Оренбург» — финансовые показатели 2024	https://energybase.ru/upstream/gazprom-dobycha-orenburg	Бухгалтерская отчетность / отраслевой справочник	\N	2026-09-09	Выручка за 2024 год — 142 851 034 тыс. руб.
119	АО «ОРМЕТ» — бухгалтерская отчетность за 2024 год	https://companies.rbc.ru/id/1025602077270-ao-ormet/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка за 2024 год — 8 457 293 000 руб.
120	ООО «ТЭМЗ» — показатели за 2024 год	https://checkspot.ru/company/1035618981485	Данные ФНС / аналитический агрегатор	\N	2026-09-09	Тюльганский электромеханический завод: выручка 412 512 000 руб.; ССЧ — 35 человек за 2024 год.
121	АО «Оренбургские минералы» — показатели за 2024 год	https://b2b.house/company/AO-ORENBURGSKIE-MINERALY_dcf15156-716e-4cfa-889d-a3306eedc9cb/	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2024 год — 9 128 454 000 руб.; ССЧ — 1 771 человек; расчетная среднемесячная зарплата — 88 671,47 руб.
122	ООО «Оренбургский пропант» — численность и расчетная зарплата 2024	https://b2b.house/company/OOO-ORENBURGSKIJ-PROPANT_2a790637-7ae3-42d2-8a05-3d105f6c4870/	Данные ФНС / аналитический агрегатор	\N	2026-09-09	ССЧ за 2024 год — 1 473 человека; расчетная среднемесячная зарплата — 82 986,08 руб.
123	ПАО «Гайский ГОК» — бухгалтерская отчетность за 2024 год	https://companies.rbc.ru/id/1025600682030-pao-gajskij-gorno-obogatitelnyij-kombinat/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка за 2024 год — 44 013 349 000 руб.
124	ООО «СМК ОРСК» — показатели за 2024 год	https://checkspot.ru/company/1095658013660	Данные ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2024 год — 2 947 832 000 руб.; среднесписочная численность — 554 человека.
125	ООО «Компонент-Лактис» — показатели за 2024 год	https://e-ecolog.ru/buh/2024/5602024488	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Выручка за 2024 год — 88 232 000 руб.
126	ООО «БайТекс» — бухгалтерская отчетность за 2024 год	https://check.tochka.com/company/1025600545266/	Данные ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2024 год — 15 426 817 000 руб.
127	ООО «Сорочинский МЭЗ» — бухгалтерская отчетность за 2024 год	https://check.tochka.com/company/1105658027012/	Данные ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2024 год — 12 295 653 000 руб.
149	АО «РИФАР» — показатели 2022	https://synapsenet.ru/organizacii/1025600684240-ao-rifar	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2022 год — 6 737 368 тыс. руб.
128	ООО «АСТОН-Поволжье» — показатели за 2024 год	https://checkspot.ru/company/1215600006192	Данные ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2024 год — 1 480 031 000 руб.; среднесписочная численность — 49 человек.
129	АО «Уральская Сталь» — бухгалтерская отчетность РСБУ за 2024 год	https://finolive.ru/docs/172/rsbu_year_2024.pdf	Бухгалтерская отчетность РСБУ	\N	2026-09-09	Официальная отчетность: выручка 153 749 457 тыс. руб.; среднесписочная численность 9 231 человек.
130	ООО «СМК ОРСК» — бухгалтерская отчетность 2024 с сопоставимыми данными 2023	https://companies.rbc.ru/id/1095658013660-ooo-orskij-zavod-metallokonstruktsij/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка на начало 2024 года — 2 797 202 000 руб., соответствующая 2023 году.
131	АО «Уральская Сталь» — бухгалтерская отчетность 2024 с сопоставимыми данными 2023	https://companies.rbc.ru/id/1055607061498-ao-uralskaya-stal/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка на начало 2024 года — 161 787 841 000 руб., соответствующая 2023 году.
132	ООО «БайТекс» — бухгалтерская отчетность за 2023 год	https://e-ecolog.ru/buh/2023/5602004322	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Выручка по строке 2110 за 2023 год — 13 561 457 тыс. руб.
133	АО «Оренбургские минералы» — финансовые показатели 2023	https://synapsenet.ru/organizacii/1025602137956-ao-orenburgskie-minerali	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2023 год — 7 726 363 тыс. руб.
134	АО «Оренбургские минералы» — численность сотрудников 2023	https://reputation.ru/ogrn/1025602137956	Данные ФНС / аналитический агрегатор	\N	2026-09-09	В 2023 году численность сотрудников составляла 1 840 человек.
135	АО «Южно-Уральский химзавод» — отчет о финансовых результатах 2023	https://dirinvest.ru/scanner/5605021799/168	Бухгалтерская отчетность	\N	2026-09-09	Выручка за 2023 год — 410 605 тыс. руб.
136	АО «РИФАР» — бухгалтерская отчетность 2024 с сопоставимыми данными 2023	https://companies.rbc.ru/id/1025600684240-ao-rifar/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка на начало 2024 года — 6 724 520 000 руб., соответствующая 2023 году.
137	ООО «Газпромнефть-Оренбург» — бухгалтерская отчетность за 2023 год	https://companies.rbc.ru/amp/ogrn/1165658052450/	Бухгалтерская отчетность / РБК Компании	\N	2026-09-09	Выручка за 2023 год — 85 841 631 000 руб.
138	ООО «Газпром добыча Оренбург» — финансовые показатели 2023	https://liccontragent.ru/company/100242786/economics	Бухгалтерская отчетность / аналитический агрегатор	\N	2026-09-09	Выручка за 2023 год — 125 170 259 000 руб.
139	ООО «СМК ОРСК» — показатели 2022	https://b2b.house/company/OOO-SMK-ORSK_ca263574-7302-4f58-b849-afba794dc361/	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Опубликованная выручка за 2022 год — около 1,71 млрд руб.; значение округленное.
140	ООО «Оренбургский пропант» — показатели 2022	https://synapsenet.ru/organizacii/1175658020449-ooo-orenburgskij-propant	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Выручка за 2022 год — 3 579 291 тыс. руб.
141	ООО «Сорочинский МЭЗ» — бухгалтерская отчетность 2022	https://egrul.org/bo/report_all.php?inn=5617020920	Бухгалтерская отчетность на основе данных ФНС	\N	2026-09-09	Выручка за 2022 год — 5 615 518 тыс. руб.
142	ООО «ЦРВ Абдулино» — бухгалтерская отчетность 2022	https://e-ecolog.ru/buh/2022/5601020378	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Строка 2110: выручка за 2022 год — 246 529 тыс. руб.
143	ОАО «Переволоцкий элеватор» — показатели 2022	https://saby.ru/profile/5640002090-564001001	Бухгалтерская отчетность / аналитический агрегатор	\N	2026-09-09	Выручка от основной деятельности за 2022 год — около 638,3 млн руб.
144	ООО «Компонент-Лактис» — показатели 2022	https://saby.ru/profile/5602024488-560201001	Бухгалтерская отчетность / аналитический агрегатор	\N	2026-09-09	Выручка от основной деятельности за 2022 год — 66 812 тыс. руб.
145	ПК «Саракташский консервный завод» — бухгалтерская отчетность 2022	https://e-ecolog.ru/buh/2022/5643022105	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Строка 2110: выручка за 2022 год — 28 696 тыс. руб.
146	АО «МЭЗ «Уралэлектро» — итоги работы 2022	https://t.me/s/pool_56?before=3302	Региональный информационный источник	\N	2026-09-09	Объем реализации предприятия в 2022 году — 1,5 млрд руб. без НДС; средняя зарплата — более 32 тыс. руб.
147	ПАО «Гайский ГОК» — отчетность 2022	https://b2b.house/company/PAO-GAJSKIJ-GOK_45b029c8-778b-4226-8346-cea57496c7fe/financial-statements/	Бухгалтерская отчетность	\N	2026-09-09	Строка 2110: выручка за 2022 год — 41 334 374 тыс. руб.
148	АО «Оренбургские минералы» — анализ отчетности 2022	https://innova-science.ru/wp-content/uploads/2023/11/sbornik-nauchnyh-trudov-17.11.2023-sni-21.pdf	Научная публикация на основе бухгалтерской отчетности	2023-11-17	2026-09-09	В анализе отчетности указана выручка от продажи без НДС за 2022 год — 6 752 232 тыс. руб.
150	ООО «БайТекс» — показатели 2022	https://energybase.ru/upstream/baitex	Отраслевая финансовая база	\N	2026-09-09	Выручка за 2022 год — 12 339 628 тыс. руб.
151	ООО «Газпром добыча Оренбург» — итоги 2022	https://www.akm.ru/news/gazprom_perevel_v_pryamoe_vladenie_gazprom_dobycha_orenburg/	Финансово-деловой источник	\N	2026-09-09	Опубликованная выручка за 2022 год — 123,6 млрд руб.; значение округленное.
152	ООО «Газпромнефть-Оренбург» — показатели 2022	https://b2b.house/company/OOO-GAZPROMNEFT-ORENBURG_6e593d79-93d6-4673-8d86-db62d4167aba/	Бухгалтерская отчетность / аналитический агрегатор	\N	2026-09-09	Опубликованная выручка за 2022 год — около 84,73 млрд руб.; значение округленное.
153	АО «ОРМЕТ» — бухгалтерская отчетность 2022	https://e-ecolog.ru/buh/2022/5616006746	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Строка 2110: выручка за 2022 год — 6 068 075 тыс. руб.
154	АО «Южно-Уральский завод магниевых соединений» — отчетность 2022	https://e-ecolog.ru/buh/2022/5605021799	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Строка 2110: выручка за 2022 год — 521 277 тыс. руб.
155	АО «Уральская Сталь» — РСБУ 2022	https://cbonds.ru/company/18741/	Бухгалтерская отчетность РСБУ / финансовая база	\N	2026-09-09	Выручка по РСБУ за 2022 год — 142 737 929 тыс. руб.
156	АО «МЭЗ «Уралэлектро» — бухгалтерская отчетность 2021	https://check.tochka.com/company/1025600752649/	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Выручка АО «МЭЗ «Уралэлектро» за 2021 год — 1 441 165 000 руб.
157	АО «Уральская Сталь» — презентация финансовых результатов	https://fs.moex.com/f/19697/prezentacija-uralstal.pdf	Корпоративная финансовая презентация	\N	2026-09-09	В презентации указана выручка АО «Уральская Сталь» за 2021 год — 142,4 млрд руб.
158	АО «Южно-Уральский завод магниевых соединений» — бухгалтерская отчетность 2021	https://e-ecolog.ru/buh/2021/5605021799	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Строка 2110: выручка за 2021 год — 503 492 тыс. руб.
159	АО «Оренбургские минералы» — бухгалтерская отчетность 2021	https://e-ecolog.ru/buh/2021/5618000027	Бухгалтерская отчетность ФНС и Росстата	\N	2026-09-09	Строка 2110: выручка за 2021 год — 9 476 522 тыс. руб.
160	ООО «ТЭМЗ» — численность 2021	https://www.openweb.ru/5650005291-ooo-temz	Открытый реестр юридических лиц	\N	2026-09-09	Среднесписочная численность ООО «ТЭМЗ» в 2021 году — 28 сотрудников.
161	ПАО «Гайский ГОК» — финансовые показатели 2021	https://cbonds.ru/stocks/RU000A0B6071/	Бухгалтерская отчетность РСБУ / финансовая база	\N	2026-09-09	Годовая выручка по РСБУ за 2021 год — 44 357 600 тыс. руб.
162	АО «РИФАР» — бухгалтерская отчетность 2021	https://b2b.house/company/AO-RIFAR_f33bf5a7-2d83-4c39-8130-cedce506a278/financial-statements/	Бухгалтерская отчетность ФНС / аналитический агрегатор	\N	2026-09-09	Строка 2110: выручка АО «РИФАР» за 2021 год — 6 561 429 тыс. руб.
163	ООО «ТЭМЗ» — показатели 2021	https://reputation.ru/pfr/office/066253?page=1&year=2021	Аналитический реестр работодателей	\N	2026-09-09	Выручка ООО «ТЭМЗ» за 2021 год — около 296,2 млн руб.
164	ОАО «Переволоцкий элеватор» — показатели 2021	https://www.openweb.ru/5640004644-zao-perevolockaya-melnica	Открытый реестр юридических лиц	\N	2026-09-09	На странице дочерней компании приведена выручка ОАО «Переволоцкий элеватор» за 2021 год — 619 417 000 руб.
165	ПАО «Орскнефтеоргсинтез» — продукция	https://www.ornpz.ru/produkcziya/2024.html	Официальный сайт	\N	2026-09-14	Паспорта качества и перечень нефтепродуктов
166	Южно-Уральский завод магниевых соединений — продукция	https://www.юузмс.рф/	Официальный сайт	\N	2026-09-14	Каталог магниевых соединений
167	АО «Новотроицкий цементный завод» — продукция	https://www.novocement.ru/index.php?Itemid=60&id=67&option=com_content&task=view	Официальный сайт	\N	2026-09-14	Общестроительные, специальные цементы и тампонажные материалы
168	АО «РИФАР» — продукция	https://rifar.ru/products/9/	Официальный сайт	\N	2026-09-14	Каталог радиаторов отопления
169	AKKERMANN CEMENT — продукция	https://akkermann.ru/	Официальный сайт	\N	2026-09-14	Цементная продукция предприятия
170	АО «Новотроицкий завод хромовых соединений» — продукция	https://icatalog.expocentr.ru/ru/exhibitions/348532c1-e716-11ec-80cd-a0d3c1fab97f/exhibitors/294869?stand=23C74	Отраслевой каталог	\N	2026-09-14	Перечень продукции НЗХС
171	АО «Оренбургские минералы» — продукция	https://orenmin.ru/kachestvo/	Официальный сайт	\N	2026-09-14	Информация о хризотиле и нерудных материалах
172	АО «Уральская Сталь» — продукция	https://uralsteel.com/products/	Официальный сайт	\N	2026-09-14	Каталог продукции АО «Уральская Сталь»
173	АО «МЭЗ «Уралэлектро» — низковольтная аппаратура	https://uralelectro.ru/rambo_project/starters-contactors/	Официальный сайт	\N	2026-09-14	Пускатели, контакторы и реле производства Уралэлектро
174	Русагро — масложировой бизнес	https://ar2024.rusagrogroup.ru/ru/performance-overview/combined-oil-fats-business	Корпоративная отчетность	\N	2026-09-14	Маслоэкстракционные предприятия производят растительное масло и шрот
175	АО «Бузулукский механический завод» — продукция	https://www.exponet.ru/exhibitions/online/agroor2017/buzulukskij.ru.html	Отраслевой каталог	\N	2026-09-14	Радиаторы, теплообменники, тракторная и сельскохозяйственная техника
176	АО «МЭЗ «Уралэлектро» — электродвигатели	https://www.uralelectro.ru/wp-content/uploads/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5-%D1%8D%D0%BB%D0%B5%D0%BA%D1%82%D1%80%D0%BE%D0%B4%D0%B2%D0%B8%D0%B3%D0%B0%D1%82%D0%B5%D0%BB%D0%B8-%D1%81%D0%B5%D1%80%D0%B8%D0%B9-%D0%90%D0%94%D0%9C-%D0%9E%D0%9C1-%D0%9E%D0%9C5-%D0%B8-IMM-%D0%9E%D0%9C1-%D0%9E%D0%9C5.pdf	Официальный каталог	\N	2026-09-14	Асинхронные электродвигатели морского исполнения
177	СПК «Птицефабрика Гайская» — официальный сайт	https://www.gayfa.ru/	Официальный сайт	\N	2026-09-26	История предприятия, профиль деятельности и продукция.
178	СПК «Птицефабрика Гайская» — РБК Компании	https://companies.rbc.ru/id/1025600684328-spk-spk-ptitsefabrika-gajskaya/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, статус и финансовые показатели предприятия.
179	ООО «Гаймясопром» — РБК Компании	https://companies.rbc.ru/id/1205600006886-obschestvo-s-ogranichennoj-otvetstvennostyu-radmirzoloto/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, статус и показатели ООО «Гаймясопром».
180	ООО «Гаймолоко» — РБК Компании	https://companies.rbc.ru/id/1025600682689-ooo-gajmoloko/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, статус и численность ООО «Гаймолоко».
181	ООО «Хлебный центр» — РБК Компании	https://companies.rbc.ru/id/1135658021872-ooo-hlebnyij-tsentr/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, численность и финансовые показатели.
182	ООО «Завод «Заряд» — РБК Компании	https://companies.rbc.ru/id/1045601901322-ooo-zavod-zaryad/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, статус и численность предприятия.
183	ООО «ФермерПродукт» — Точка	https://check.tochka.com/company/1175658014806/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, статус и финансовые показатели ООО «ФермерПродукт».
184	ООО «ГЗОЦМ «Гайская медь» — перечень производителей медных полуфабрикатов, 2026	https://www.garant.ru/products/ipo/prime/doc/56963485/	Нормативно-справочный источник	2026-08-14	2026-09-26	Подтверждение включения ООО «ГЗОЦМ «Гайская медь» в перечень производителей медных полуфабрикатов.
185	АО «РИФАР» — официальный сайт	https://rifar.ru/company/contacts/	Официальный сайт	\N	2026-09-26	Адрес, контакты и сведения о предприятии в городе Гае.
186	ПАО «Гайский ГОК» — официальный сайт	https://www.ggok.ru/ru/info/for-client/01/	Официальный сайт	2023-09-05	2026-09-26	Реквизиты, адрес и контакты ПАО «Гайский ГОК».
187	ООО «ЮЗСО» — РБК Компании	https://companies.rbc.ru/id/1065607037341-ooo-yuzhno-uralskij-zavod-spasatelnogo-oborudovaniya/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, статус и финансовые показатели ООО «ЮЗСО».
188	ООО «ЮЗСО» — официальный сайт	https://yzso.ru/	Официальный сайт	\N	2026-09-26	Контакты, продукция и год основания предприятия.
189	Гайский муниципальный округ — актуальные коды ОКТМО	https://www.nalog.gov.ru/rn56/taxation/submission_statements/rekvizit/14559470/	ФНС России	2024-12-26	2026-09-26	Изменение статуса Гайского городского округа на Гайский муниципальный округ и код ОКТМО.
190	Гай — географические координаты	https://your-online.ru/coordinates/ru/orenburgskaja-oblast	Географический справочник	\N	2026-09-26	Координаты города Гая: 51.4666, 58.4552.
191	Гайский городской округ — БД показателей муниципальных образований, 2024	https://www.rosstat.gov.ru/scripts/db_inet2/passport/table.aspx?opt=537130002024	Росстат	\N	2026-09-26	Среднемесячная заработная плата работников организаций за 2024 год.
192	ООО «ГЗОЦМ «Гайская медь» — РБК Компании	https://companies.rbc.ru/id/1215600001968-obschestvo-s-ogranichennoj-otvetstvennostyu-gzotsm-gajskaya-med/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, численность и финансовые показатели ООО «ГЗОЦМ «Гайская медь».
193	ООО «ММСК» — РБК Компании	https://companies.rbc.ru/id/1025600752726-ooo-mednogorskij-medno-sernyij-kombinat/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, действующий статус и финансовые показатели ООО «ММСК».
194	АО «МЭЗ «Уралэлектро» — официальный сайт	https://uralelectro.ru/	Официальный сайт	\N	2026-09-26	Профиль производства, история, продукция и контакты предприятия; работает с 1941 года, около 700 сотрудников.
195	ООО «Медногорское карьероуправление» — OpenWeb	https://www.openweb.ru/5606020646-ooo-mku	Данные ЕГРЮЛ	\N	2026-09-26	Реквизиты и статус юридического лица в стадии ликвидации.
196	ООО «Железобетон 2005» — Sledi	https://sledi.ru/zhelezobeton-2005-5614027050/	Данные ЕГРЮЛ и ФНС	\N	2026-09-26	Актуальные на 19.09.2026 реквизиты, действующий статус и сведения о предприятии.
197	ООО «Медногорский пивоваренный завод» — РБК Компании	https://companies.rbc.ru/id/1145658007043-ooo-obschestvo-s-ogranichennoj-otvetstvennostyu-mednogorskij-pivovarennyij-zavod/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, численность и финансовые показатели за 2024 год.
198	ООО «ОрСнэк» — РБК Компании	https://companies.rbc.ru/id/1115658032566-ooo-orsnek/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, численность, вид деятельности и финансовые показатели.
199	ООО «Промстройкомплект» — РБК Компании	https://companies.rbc.ru/id/1245600003120-ooo-psk/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, основной вид деятельности и финансовые показатели за 2025 год.
200	ООО «МЕДЖБИ» — РБК Компании	https://companies.rbc.ru/id/1225600001923-ooo-mednogorskie-zhelezobetonnyie-izdeliya/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, виды деятельности и финансовые показатели за 2023 год.
201	ООО «БРУ Уралстрой» — РБК Компании	https://companies.rbc.ru/id/1245600003153-ooo-bru-uralstroj/	Данные ЕГРЮЛ	\N	2026-09-26	Реквизиты и виды деятельности производителя товарного бетона.
202	ООО «Новый Ресурс» — РБК Компании	https://companies.rbc.ru/id/1245600006190-ooo-novyij-resurs/	Данные ЕГРЮЛ	\N	2026-09-26	Реквизиты и виды деятельности горнодобывающего предприятия.
203	ООО «Фландерс» — РБК Компании	https://companies.rbc.ru/id/1245600006948-ooo-flanders/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, вид деятельности и финансовые показатели предприятия.
204	Медногорск — население, координаты и ОКТМО	https://www.mojgorod.ru/orenburg_obl/mednogorsk/index.html	Статистический справочник	\N	2026-09-26	Численность населения Медногорска по годам, координаты и код ОКТМО; значения 2021–2023 приведены с округлением.
205	Оренбургстат — муниципальные образования на 1 января 2024 года	https://56.rosstat.gov.ru/storage/document/document_statistic_collection/2024-06/10/%D0%9C%D1%83%D0%BD%D0%B8%D1%86%D0%B8%D0%BF%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BD%D0%B0%201%20%D1%8F%D0%BD%D0%B2%D0%B0%D1%80%D1%8F%202024%20%D0%B3%D0%BE%D0%B4%D0%B0%281%29.pdf	Официальная статистика Росстата	2024-06-10	2026-09-26	Численность населения города Медногорска на 1 января 2024 года — 23 013 человек.
206	Оренбургстат — муниципальные образования на 1 января 2025 года	https://56.rosstat.gov.ru/storage/document/document_statistic_collection/2025-07/21/%D0%9C%D1%83%D0%BD%D0%B8%D1%86%D0%B8%D0%BF%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BD%D0%B0%201%20%D1%8F%D0%BD%D0%B2%D0%B0%D1%80%D1%8F%202024%20%D0%B3%D0%BE%D0%B4%D0%B0.pdf	Официальная статистика Росстата	2025-07-21	2026-09-26	Численность городского населения Медногорска на 1 января 2025 года — 22 723 человека.
207	Медногорский медно-серный комбинат — профиль предприятия	https://mmsk.ugmk.com/	Официальный сайт предприятия	\N	2026-09-26	Профиль предприятия и основная продукция: черновая медь, серная кислота и другая металлургическая продукция.
208	АО «Оренбургнефть» — официальный профиль Роснефти	https://www.rosneft.ru/about/Glance/OperationalStructure/Dobicha_i_razrabotka/Centralnaja_Rossija/orenburgneft/	Официальный сайт	\N	2026-09-26	Профиль АО «Оренбургнефть», актуальные сведения о добыче и дочернем ООО «РН-БГПП».
209	АО «Оренбургнефть» — РБК Компании	https://companies.rbc.ru/id/1025601802357-ao-orenburgneft/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, статус и финансовые показатели АО «Оренбургнефть».
210	ООО «РН-БГПП» — паспорт продукции Роснефти	https://www.rosneft.ru/upload/site1/document_file/PB_Sera_komovaya_BGPP_do_21.03.28.pdf	Официальный документ производителя	\N	2026-09-26	Производитель, адрес и сведения о продукции ООО «РН-БГПП».
211	ООО «РН-БГПП» — РБК Компании	https://companies.rbc.ru/id/1175658018975-ooo-rn-buzulukskoe-gazopererabatyivayuschee-predpriyatie/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, статус, ОКВЭД и численность ООО «РН-БГПП».
212	ООО «Завод Бузулук Гранит» — РБК Компании	https://companies.rbc.ru/id/1185658013320-ooo-zavod-buzuluk-granit/	Данные ЕГРЮЛ	\N	2026-09-26	Реквизиты, адрес, статус и ОКВЭД завода.
213	ООО «Бугурусланский сыродельный завод» — РБК Компании	https://companies.rbc.ru/id/1155658021551-ooo-buguruslanskij-syirodelnyij-zavod/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Правильное наименование, реквизиты, ОКВЭД, численность и показатели за 2025 год.
214	ООО «Бузулукмолоко» — РБК Компании	https://companies.rbc.ru/id/1025600575527-ooo-buzulukmoloko/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, статус, численность и финансовые показатели за 2025 год.
215	ООО «СПР» — официальный сайт	https://buzuluk.spr-prom.ru/o-kompanii/	Официальный сайт	\N	2026-09-26	Производство резинотехнических изделий, контакты и адрес предприятия в Бузулуке.
216	ООО «АСТОН-Поволжье» — официальный сайт	https://buzuluk.aston.ru/	Официальный сайт	\N	2026-09-26	Профиль маслоэкстракционного завода, продукция, мощность и адрес производственной площадки.
217	ООО «АСТОН-Поволжье» — бухгалтерская отчетность 2025	https://b2b.house/company/OOO-ASTON-POVOLZHE_ceac1b8e-5594-4aef-8eff-13de985fcfab/financial-statements/	Бухгалтерская отчетность ФНС	\N	2026-09-26	Выручка и чистая прибыль предприятия за 2025 год.
218	АО «Композит Групп» — РБК Компании	https://companies.rbc.ru/id/1025600577496-ao-buzulukskij-mehanicheskij-zavod/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Актуальное юридическое наименование бывшего Бузулукского механического завода, реквизиты и показатели за 2025 год.
219	ООО «Экономия» — РБК Компании	https://companies.rbc.ru/id/1025600578332-ooo-ekonomiya/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД, численность и финансовые показатели производителя кирпича.
220	ООО «Заготовитель» — РБК Компании	https://companies.rbc.ru/id/1045613150494-ooo-zagotovitel/	Данные ЕГРЮЛ	\N	2026-09-26	Реквизиты, ОКВЭД, статус и численность мясоперерабатывающего предприятия.
221	ООО «ПК Альянс» — РБК Компании	https://companies.rbc.ru/id/1215600001792-obschestvo-s-ogranichennoj-otvetstvennostyu-proizvodstvennaya-kompaniya-alyans/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД и финансовые показатели производителя напитков.
222	ООО «Стройаэрокуб» — РБК Компании	https://companies.rbc.ru/id/1255600001964-ooo-strojaerokub/	Данные ЕГРЮЛ	\N	2026-09-26	Реквизиты и производственный профиль нового предприятия строительных материалов.
223	ООО «Бузулукский ликероводочный завод» — РБК Компании	https://companies.rbc.ru/id/1155658017987-ooo-buzulukskij-likerovodochnyij-zavod/	Данные ЕГРЮЛ	\N	2026-09-26	Реквизиты, профиль предприятия и решение ФНС о ликвидации.
224	ООО «Бузулукское молоко» — B2B.House	https://b2b.house/company/OOO-BUZULUKSKOE-MOLOKO_8910c753-60be-4a1d-8d35-2c1301ee5fab/	Данные ФНС и бухгалтерской отчетности	\N	2026-09-26	Выручка, прибыль, численность и расчетная средняя зарплата за 2021–2025 годы.
225	ООО «Бузулукское молоко» — РБК Компании	https://companies.rbc.ru/id/1065603033429-ooo-buzulukskoe-moloko/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, профиль и финансовые показатели крупного молочного предприятия.
226	ООО «ТМК НГС-Бузулук» — официальный сайт ТМК	https://tmk-ngs.tmk-group.ru/tmk_ngs_contacts	Официальный сайт	\N	2026-09-26	Адрес, телефон и электронная почта ООО «ТМК НГС-Бузулук».
227	ООО «ТМК НГС-Бузулук» — РБК Компании	https://companies.rbc.ru/id/1025600575660-ooo-tmk-neftegazservis-buzuluk/	Данные ЕГРЮЛ и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, ОКВЭД и финансовые показатели за 2025 год.
228	ООО «ТМК НГС-Бузулук» — сведения о численности	https://site.birweb.1prime.ru/company-brief/4101826	Данные ФНС / аналитический агрегатор	\N	2026-09-26	Численность 477 сотрудников и выручка за 2025 год.
229	ООО «Горторг» — Companium	https://companium.ru/id/1045601154906-gortorg	Данные ФНС и бухгалтерской отчетности	\N	2026-09-26	Реквизиты, финансовые показатели и численность мясоперерабатывающего предприятия.
230	ООО «Горторг-Д» — Фирмотека	https://firmoteka.ru/5603015060	Данные ФНС и бухгалтерской отчетности	\N	2026-09-26	ОКВЭД, выручка, прибыль и численность производителя макаронных изделий за 2025 год.
231	Оренбургстат — муниципальные образования на 1 января 2021 года	https://56.rosstat.gov.ru/storage/document/document_statistic_collection/2021-06/11/%D0%9C%D1%83%D0%BD%D0%B8%D1%86%D0%B8%D0%BF%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BD%D0%B0%201%20%D1%8F%D0%BD%D0%B2%D0%B0%D1%80%D1%8F%202021%20%D0%B3%D0%BE%D0%B4%D0%B0.pdf	Официальная статистика Росстата	2021-06-11	2026-09-26	Численность населения городского округа город Бузулук на 1 января 2021 года — 86 042 человека.
232	Оренбургстат — численность населения муниципальных образований 2022–2023	https://56.rosstat.gov.ru/storage/mediabank/%D0%A0%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%204.%D0%A1%D1%82%D0%B0%D1%82%D0%B8%D1%81%D1%82%D0%B8%D0%BA%D0%B0%20%D0%BD%D0%B0%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D1%8F%20%D0%B8%20%D0%B7%D0%B4%D1%80%D0%B0%D0%B2%D0%BE%D0%BE%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F.pdf	Официальная статистика Росстата	\N	2026-09-26	Численность населения Бузулука: 88 250 человек на 01.01.2022 и 88 419 человек на 01.01.2023.
233	Бузулук — динамика численности населения	https://www.mojgorod.ru/orenburg_obl/buzuluk/index.html	Статистический справочник	\N	2026-09-26	Динамика населения города, включая 2024 год; значение приведено с округлением.
234	Оренбургстат — муниципальные образования на 1 января 2025 года	https://56.rosstat.gov.ru/storage/document/document_statistic_collection/2025-07/21/%D0%9C%D1%83%D0%BD%D0%B8%D1%86%D0%B8%D0%BF%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BD%D0%B0%201%20%D1%8F%D0%BD%D0%B2%D0%B0%D1%80%D1%8F%202024%20%D0%B3%D0%BE%D0%B4%D0%B0.pdf	Официальная статистика Росстата	2025-07-21	2026-09-26	Численность населения городского округа город Бузулук на 1 января 2025 года — 88 202 человека.
235	Бузулук — координаты	https://www.geodatos.net/en/coordinates/russia/buzuluk	Географический справочник	\N	2026-09-26	Координаты города Бузулука.
236	Бузулук — ОКТМО	https://classinform.ru/oktmo/53712000000.html	Классификатор ОКТМО	\N	2026-09-26	Код ОКТМО городского округа и населенного пункта Бузулук.
237	Инвестиционная декларация Оренбургской области — проекты в Бузулуке	https://www.orenb-gov.ru/doc/89242	Нормативный акт Оренбургской области	2022-04-15	2026-09-26	Инвестиционные проекты АСТОН-Поволжье и комплекса глубокой переработки масличных культур в Бузулуке.
238	РБК Компании — ООО «Новотроицкий содовый завод»	https://companies.rbc.ru/id/1185658000637-ooo-novotroitskij-sodovyij-zavod/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль 8189000 руб. Выручка 3155216000 руб.
239	РБК Компании — ООО «АККЕРМАНН ЦЕМЕНТ»	https://companies.rbc.ru/id/1025600822510-ooo-yuzhno-uralskaya-gorno-pererabatyivayuschaya-kompaniya/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2023 год. Чистая прибыль 6330547000 руб. Выручка 15165171000 руб.
240	РБК Компании — ООО «Металекс»	https://companies.rbc.ru/id/1025600820630-ooo-metaleks/	Карточка юридического лица	\N	2026-11-19	Подтверждены реквизиты юридического лица.
241	РБК Компании — АО «Новотроицкий цементный завод»	https://companies.rbc.ru/id/1025600820563-ao-novotroitskij-tsementnyij-zavod/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2024 год. Чистая прибыль -15423000 руб. Выручка 346428000 руб.
242	РБК Компании — АО «Новотроицкий завод хромовых соединений»	https://companies.rbc.ru/id/1025600820431-ao-novotroitskij-zavod-hromovyih-soedinenij/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2024 год. Чистая прибыль 625792000 руб. Выручка 10673929000 руб.
243	РБК Компании — ООО «Новотроицкий завод нестандартного технологического оборудования»	https://companies.rbc.ru/id/1175658023705-ooo-novotroitskij-zavod-nestandartnogo-tehnologicheskogo-oborudovaniya/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль 512027000 руб. Выручка 1118736000 руб.
244	РБК Компании — ООО «Новохром»	https://companies.rbc.ru/id/1025600820365-ooo-novohrom/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль 72229000 руб. Выручка 650283000 руб.
245	РБК Компании — ООО «НСплав»	https://companies.rbc.ru/amp/ogrn/1165658079718/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль 91728000 руб. Выручка 3516186000 руб.
246	РБК Компании — ООО «Оренбургский пропант»	https://companies.rbc.ru/id/1175658020449-ooo-obschestvo-s-ogranichennoj-otvetstvennostyu-orenburgskij-propant/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2024 год. Чистая прибыль -88542000 руб. Выручка 5789017000 руб.
247	РБК Компании — ООО «Новотроицкий завод бисульфита и пиросульфита»	https://companies.rbc.ru/id/1215600008942-obschestvo-s-ogranichennoj-otvetstvennostyu-novotroitskij-zavod-bisulfita-i-pirosulfita/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль 30936000 руб. Выручка 230353000 руб.
248	РБК Компании — ООО «ПОДДОН СЕРВИС»	https://companies.rbc.ru/id/1195658018907-obschestvo-s-ogranichennoj-otvetstvennostyu-poddon-servis/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль -2573000 руб. Выручка 62613000 руб.
249	РБК Компании — ООО «Новотроицкий завод цветных металлов»	https://companies.rbc.ru/id/1205600008668-obschestvo-s-ogranichennoj-otvetstvennostyu-novotroitskij-zavod-tsvetnyih-metallov/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль -74353000 руб. Выручка 239915000 руб.
250	РБК Компании — ООО «Хлебозавод»	https://companies.rbc.ru/id/1155658008505-ooo-hlebozavod/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2024 год. Чистая прибыль 12714000 руб. Выручка 490129000 руб.
251	РБК Компании — АО «Новотроицкий трубопрокатный завод»	https://companies.rbc.ru/id/1235600005486-nao-ao-ntpz/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2025 год. Чистая прибыль -869766000 руб. Выручка 854627000 руб.
252	РБК Компании — ООО «Завод Элмон»	https://companies.rbc.ru/id/1205600001342-obschestvo-s-ogranichennoj-otvetstvennostyu-zavod-elmon/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2024 год. Чистая прибыль 204000 руб. Выручка 4086000 руб.
253	РБК Компании — ООО «Уральский завод технологического машиностроения»	https://companies.rbc.ru/id/1175658020922-ooo-uralskij-zavod-tehnologicheskogo-mashinostroeniya/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2024 год. Чистая прибыль -281000 руб.
254	РБК Компании — АО «Уральская Сталь»	https://companies.rbc.ru/id/1055607061498-ao-uralskaya-stal/	Карточка юридического лица	\N	2026-11-19	Отчёт за 2024 год. Чистая прибыль 3407319000 руб. Выручка 153749457000 руб.
255	xfirm.ru — АО «Уральская Сталь»	https://xfirm.ru/company/5607019523	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
256	e-ecolog.ru — ООО «НСплав»	https://e-ecolog.ru/buh/2021/5607141530	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
257	saby.ru — ООО «НСплав»	https://saby.ru/profile/5607141530-560701001	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
258	xfirm.ru — ООО «Новотроицкий содовый завод»	https://xfirm.ru/company/5607142213	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
259	xfirm.ru — ООО «АККЕРМАНН ЦЕМЕНТ»	https://xfirm.ru/company/5607015014	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
260	reputation.ru — ООО «Металекс»	https://reputation.ru/ogrn/1025600820630	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
261	xfirm.ru — АО «Новотроицкий цементный завод»	https://xfirm.ru/company/5607004870	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
262	xfirm.ru — АО «Новотроицкий завод хромовых соединений»	https://xfirm.ru/company/5607002135	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
263	xfirm.ru — ООО «Новотроицкий завод нестандартного технологического оборудования»	https://xfirm.ru/company/5607142100	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
264	xfirm.ru — ООО «Оренбургский пропант»	https://xfirm.ru/company/5607142044	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
265	ruinn.ru — ООО «Новохром»	https://ruinn.ru/company/5607014758-ooo-novokhrom	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
266	ruinn.ru — ООО «Новотроицкий завод бисульфита и пиросульфита»	https://ruinn.ru/company/5607144115-ooo-nzbp	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
267	xfirm.ru — ООО «ПОДДОН СЕРВИС»	https://xfirm.ru/company/5607143440	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
268	e-ecolog.ru — ООО «Новотроицкий завод цветных металлов»	https://e-ecolog.ru/buh/2021/5607143640	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
269	saby.ru — ООО «Новотроицкий завод цветных металлов»	https://saby.ru/profile/5607143640-560701001	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
270	bo.nalog.gov.ru — ООО «Новотроицкий завод цветных металлов»	https://bo.nalog.gov.ru/download/bfo/pdf/11368895?detailId=51501101&period=2024	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
271	e-ecolog.ru — ООО «Хлебозавод»	https://e-ecolog.ru/buh/2022/5607140262	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
272	saby.ru — ООО «Хлебозавод»	https://saby.ru/profile/5607140262-560701001	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
273	org.gorodrabot.ru — ООО «Хлебозавод»	https://org.gorodrabot.ru/company/5607140262/ooo-khlebozavod/	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
274	synapsenet.ru — ООО «Хлебозавод»	https://synapsenet.ru/organizacii/1155658008505-ooo-hlebozavod	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
275	xfirm.ru — АО «Новотроицкий трубопрокатный завод»	https://xfirm.ru/company/5607144789	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
276	vsem-podryad.ru — ООО «Завод Элмон»	https://vsem-podryad.ru/company/e57f0af3-001f-4a26-bf27-b8e275150433/	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
277	e-ecolog.ru — ООО «Уральский завод технологического машиностроения»	https://e-ecolog.ru/buh/2021/5614080374	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
278	b2b.house — ООО «Уральский завод технологического машиностроения»	https://b2b.house/company/OOO-UZTM_8dafc414-9fab-42ee-9241-2e7a8a95fa86/	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
279	reputation.ru — ООО «Уральский завод технологического машиностроения»	https://reputation.ru/ogrn/1175658020922	Финансовые показатели	\N	2026-11-19	Исторические данные годовой бухгалтерской отчётности.
280	e-ecolog.ru — ОРМЕТ	https://e-ecolog.ru/buh/2024/5616006746	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5616006746.
281	b2b.house — ОРМЕТ	https://b2b.house/company/AO-ORMET_0d0aac61-fd7a-40f2-b716-93f14b6de6b6/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5616006746.
282	companies.rbc.ru — ОКУ	https://companies.rbc.ru/id/1025602000808-ao-orskoe-kareroupravlenie/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5615002820.
283	xfirm.ru — ОЩЗ	https://xfirm.ru/company/7708670326	Открытые сведения о предприятии	\N	2026-11-20	ИНН 7708670326.
284	companies.rbc.ru — ОЩЗ	https://companies.rbc.ru/id/1087746575652-ao-pervaya-nerudnaya-kompaniya/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 7708670326.
285	xfirm.ru — Орский НПЗ	https://xfirm.ru/company/5615002700	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5615002700.
286	xfirm.ru — Синтезспирт	https://xfirm.ru/company/5614085615	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085615.
287	companies.rbc.ru — Синтезспирт	https://companies.rbc.ru/id/1205600011187-obschestvo-s-ogranichennoj-otvetstvennostyu-sintezspirt/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085615.
288	xfirm.ru — ОМЗ	https://xfirm.ru/company/5613000880	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5613000880.
289	companies.rbc.ru — ОМЗ	https://companies.rbc.ru/id/1025601999400-ao-orskij-mashinostroitelnyij-zavod/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5613000880.
290	companies.rbc.ru — Механический завод	https://companies.rbc.ru/id/1115658026131-ao-mehanicheskij-zavod/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614057287.
291	xfirm.ru — Уралмаш-ГО	https://xfirm.ru/company/6673125685	Открытые сведения о предприятии	\N	2026-11-20	ИНН 6673125685.
292	companies.rbc.ru — Уралмаш-ГО	https://companies.rbc.ru/id/1056604819886-ooo-uralmash-gornoe-oborudovanie/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 6673125685.
293	xfirm.ru — Орский завод металлоконструкций	https://xfirm.ru/company/5614049014	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614049014.
294	b2b.house — УЗГО	https://b2b.house/company/OOO-UZGO_afeac6fc-ad0c-4c66-92e0-e460d92b81f3/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614046528.
295	e-ecolog.ru — УЗГО	https://e-ecolog.ru/buh/2025/5614046528	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614046528.
296	companies.rbc.ru — УЗГО	https://companies.rbc.ru/id/1085658034384-ooo-uralskij-zavod-gornogo-oborudovaniya/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614046528.
297	xfirm.ru — ОЗЭМИ	https://xfirm.ru/company/5614001069	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614001069.
298	companies.rbc.ru — ОЗЭМИ	https://companies.rbc.ru/id/1025601929803-zao-zakryitoe-aktsionernoe-obschestvo-orskij-zavod-elektromontazhnyih-izdelij/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614001069.
299	xfirm.ru — Орский ВРЗ	https://xfirm.ru/company/7705845722	Открытые сведения о предприятии	\N	2026-11-20	ИНН 7705845722.
300	companies.rbc.ru — Орский ВРЗ	https://companies.rbc.ru/id/1087746722293-ooo-novaya-vagonoremontnaya-kompaniya/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 7705845722.
301	saby.ru — Орский хлеб	https://saby.ru/profile/5615013290-561401001	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5615013290.
302	companies.rbc.ru — Орский хлеб	https://companies.rbc.ru/id/1025601998454-zao-orskij-hleb/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5615013290.
303	zachestnyibiznes.ru — Орский хлеб	https://zachestnyibiznes.ru/company/ul/1025601998454_5615013290_ZAO-ORSKIY-HLEB	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5615013290.
304	xfirm.ru — Орский мясокомбинат	https://xfirm.ru/company/5614054751	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614054751.
305	companies.rbc.ru — Орский мясокомбинат	https://companies.rbc.ru/id/1105658027551-ooo-orskij-myasokombinat/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614054751.
306	b2b.house — Пивоваренный завод Орский	https://b2b.house/company/OOO-PIVOVARENNYJ-ZAVOD-ORSKIJ_007cf89f-0e23-4707-98dd-44f8de8af0b9/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5616009698.
307	e-ecolog.ru — Пивоваренный завод Орский	https://e-ecolog.ru/buh/2023/5616009698	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5616009698.
308	companies.rbc.ru — Пивоваренный завод Орский	https://companies.rbc.ru/id/1025602076972-ooo-pivovarennyij-zavod-orskij/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5616009698.
309	xfirm.ru — Орская макаронная фабрика	https://xfirm.ru/company/5614077558	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614077558.
310	companies.rbc.ru — Орская макаронная фабрика	https://companies.rbc.ru/id/1165658072007-ooo-obschestvo-s-ogranichennoj-otvetstvennostyu-agro-alyans-omf/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614077558.
311	e-ecolog.ru — НПО ОРСК	https://e-ecolog.ru/buh/2022/5614085453	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085453.
312	b2b.house — НПО ОРСК	https://b2b.house/company/OOO-NPO-ORSK_60358ef5-fd8f-4dc4-97a9-5fc9e94afde3/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085453.
313	companies.rbc.ru — НПО ОРСК	https://companies.rbc.ru/id/1205600009911-obschestvo-s-ogranichennoj-otvetstvennostyu-npo-orsk/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085453.
314	xfirm.ru — ЗГМ	https://xfirm.ru/company/5614064527	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614064527.
315	companies.rbc.ru — ЗГМ	https://companies.rbc.ru/id/1135658017736-ooo-zavod-gornyih-mashin/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614064527.
316	xfirm.ru — ГорЦемМаш	https://xfirm.ru/company/5614079192	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614079192.
317	companies.rbc.ru — ГорЦемМаш	https://companies.rbc.ru/id/1175658007271-ooo-gortsemmash/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614079192.
318	e-ecolog.ru — Орский ПЭТ завод	https://e-ecolog.ru/buh/2022/5614084026	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614084026.
319	companies.rbc.ru — Орский ПЭТ завод	https://companies.rbc.ru/id/1195658014782-obschestvo-s-ogranichennoj-otvetstvennostyu-orskij-pet-zavod/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614084026.
320	reputation.ru — Орский ПЭТ завод	https://reputation.ru/ogrn/1195658014782	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614084026.
321	e-ecolog.ru — Завод холодильников ORSK	https://e-ecolog.ru/buh/2021/5614085372	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085372.
322	saby.ru — Завод холодильников ORSK	https://saby.ru/profile/5614085372-561401001	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085372.
323	companies.rbc.ru — Завод холодильников ORSK	https://companies.rbc.ru/id/1205600009515-obschestvo-s-ogranichennoj-otvetstvennostyu-tpk-orsk/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614085372.
324	e-ecolog.ru — Орскагромаш	https://e-ecolog.ru/buh/2025/5614061734	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614061734.
325	companies.rbc.ru — Орскагромаш	https://companies.rbc.ru/alphabetical-catalog/companies/o-r/27/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614061734.
326	xfirm.ru — Уралпласттара	https://xfirm.ru/company/5615015956	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5615015956.
327	companies.rbc.ru — Уралпласттара	https://companies.rbc.ru/okved/22.22/16/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5615015956.
328	xfirm.ru — РОСЭлектрод-Долина	https://xfirm.ru/company/5614080705	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614080705.
329	companies.rbc.ru — РОСЭлектрод-Долина	https://companies.rbc.ru/id/1175658024783-ooo-russkaya-organizatsiya-svarschikov-elektrod-dolina/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614080705.
330	companies.rbc.ru — УЗСК	https://companies.rbc.ru/id/1105658027958-ooo-uralskij-zavod-stroitelnyih-konstruktsij/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5607043540.
331	companies.rbc.ru — Спарта	https://companies.rbc.ru/alphabetical-catalog/companies/s-p/92/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5614058308.
332	РБК Компании — Стрела	https://companies.rbc.ru/id/1065658011638-ao-proizvodstvennoe-obedinenie-strela/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5609061432.
333	РБК Компании — Завод бурового оборудования	https://companies.rbc.ru/id/1025601806944-oao-zavod-burovogo-oborudovaniya/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5612002652.
334	РБК Компании — Завод Инвертор	https://companies.rbc.ru/id/1025600884583-ao-zavod-invertor/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5609003039.
335	РБК Компании — Оренбургский радиатор	https://companies.rbc.ru/id/1025601807307-ooo-orenburgskij-radiator/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5612030402.
336	РБК Компании — Нефтемаслозавод	https://companies.rbc.ru/id/1025600884198-oao-neftemaslozavod/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5609008608.
337	РБК Компании — Оренбургский завод металлоконструкций	https://companies.rbc.ru/id/1095658011349-ooo-orenburgskij-zavod-metallokonstruktsij/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5610127832.
338	РБК Компании — Оренпласт	https://companies.rbc.ru/alphabetical-catalog/companies/o-b/10/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5610053179.
339	РБК Компании — Профметалл	https://companies.rbc.ru/id/1155658008219-ooo-profmetall/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5610212164.
340	РБК Компании — Сладковско-Заречное	https://companies.rbc.ru/id/1065611033652-ooo-sladkovsko-zarechnoe/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5611037405.
341	РБК Компании — Технология	https://companies.rbc.ru/id/1025601807483-ooo-tehnologiya/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5612028890.
342	РБК Компании — Газпром добыча Оренбург	https://companies.rbc.ru/id/1025601028221-ooo-gazprom-dobyicha-orenburg/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5610058025.
343	РБК Компании — Газпромнефть-Оренбург	https://companies.rbc.ru/id/1165658052450-ooo-gazpromneft-orenburg/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5610218014.
344	РБК Компании — Ореана	https://companies.rbc.ru/id/1035608456751-ooo-oreana/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5612038313.
345	РБК Компании — НПЦ ВЕЛТ	https://companies.rbc.ru/okved/20.41.2/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5010039782.
346	РБК Компании — Завод ПромСтройМаш	https://companies.rbc.ru/id/1105658012811-ooo-torgovyij-dom-promstrojmash/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5609076936.
347	РБК Компании — МиСТ	https://companies.rbc.ru/id/1125658016681-ooo-mist/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5638060761.
348	РБК Компании — СтальКом	https://companies.rbc.ru/id/1155658015644-ooo-obschestvo-s-ogranichennoj-otvetstvennostyu-stalnaya-kompaniya/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5610213785.
349	РБК Компании — Полимерстрой	https://companies.rbc.ru/id/1105658003373-ooo-polimerstroj/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5611059769.
350	РБК Компании — НПП Энергия	https://companies.rbc.ru/id/1025601715765-ooo-nauchno-proizvodstvennoe-predpriyatie-energiya/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5611002434.
351	РБК Компании — НПП Пневмакс	https://companies.rbc.ru/alphabetical-catalog/companies/p-n/3/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5611059889.
352	РБК Компании — Гидропресс	https://companies.rbc.ru/id/1025601719681-oao-gidropress/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5611003815.
353	РБК Компании — Оренбургский маслоэкстракционный завод	https://companies.rbc.ru/id/1025601715831-ao-orenburgskij-masloekstraktsionnyij-zavod/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5611001455.
354	РБК Компании — Инженерные технологии	https://companies.rbc.ru/id/1185658014761-ooo-obschestvo-s-ogranichennoj-otvetstvennostyu-inzhenernyie-tehnologii/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5610232876.
355	РБК Компании — ЖБИ Степной	https://companies.rbc.ru/id/1025600884110-zao-zavod-zhelezobetonnyih-izdelij-stepnoj/	Открытые сведения о предприятии	\N	2026-11-20	ИНН 5609031910.
356	НЗБП — основание для заполнения выручки	https://ntsk.ru/news/46447	Открытый источник	\N	2026-11-20	Условный ноль до запуска производства в августе 2022 года.
357	НЗЦМ — основание для заполнения выручки	https://investinorenburg.ru/en/news/zapusk-proizvodstva-izvesti-na-ploshhadke-ooo-novotroiczkij-zavod-czvetnyh-metallov/	Открытый источник	\N	2026-11-20	Условный ноль до запуска производства в августе 2022 года.
358	НПО ОРСК — основание для заполнения выручки	https://www.interfax-russia.ru/volga/news/vypusk-holodilnikov-v-orske-planiruetsya-vozobnovit-v-marte-vlasti	Открытый источник	\N	2026-11-20	Условный ноль за полный год до возобновления производства холодильников. В 2021 году шла модернизация.
359	Инженерные Технологии — основание для заполнения выручки	https://bo.nalog.gov.ru/download/bfo/pdf/10789742?detailId=44856000&period=2022	Открытый источник	\N	2026-11-20	В отчётности ФНС по строке 2110 стоит прочерк. По правилу базы записан ноль.
360	Инженерные Технологии — основание для заполнения выручки	https://kontragent.vbr.ru/company/ooo-injenernie-tehnologii-1185658014761/	Открытый источник	\N	2026-11-20	Условный ноль за полные годы после ликвидации 28.09.2023.
361	ОМЭЗ — основание для заполнения выручки	https://bo.nalog.gov.ru/download/bfo/pdf/6915850?detailId=57430375&period=2025	Открытый источник	\N	2026-11-20	В сравнительной графе за 2024 год строки 2110 стоит прочерк. По правилу базы записан ноль.
362	Отчёты муниципального образования город Новотроицк, 2021–2025	https://base.garant.ru/408025329/1b93c134b90c6071b4dc3f495464b753/	Муниципальная статистика	\N	2026-11-20	Годовые приложения к отчётам МО; оценки помечены отдельно.
363	Социально-экономические показатели МО Город Орск, 2021–2025	\N	Муниципальная статистика	\N	2026-11-20	Отчёты администрации города за 2021–2025 годы, предоставленные для проекта.
364	Социально-экономическое развитие МО город Оренбург, 2021–2025	https://base.garant.ru/415031522/5633a92d35b966c2ba2f1e859e7bdd69/	Муниципальная статистика	\N	2026-11-20	Отчёты и приложения 2022–2025; часть значений 2021 не подтверждена.
365	Новотроицк: зарплата за январь–август 2025, данные мэрии в Ntsk.ru	https://ntsk.ru/news/61118	Местная пресса / первичные сведения мэрии	\N	2026-11-20	Применено только для модельного пересчёта годовой зарплаты; оценку не считать официальной.
366	Оренбург: муниципальный прогноз социально-экономического развития на 2021 год	https://base.garant.ru/402953552/31de5683116b8d79b08fa2d768e33df6/	Муниципальный прогноз (ГАРАНТ)	\N	2026-11-20	Оценки промышленности, ИПП, прибыли на 2021 год.
367	Росстат: социально-экономическое положение региональных центров ПФО 2021–2022	https://kulturaufa.ru/wp-content/uploads/2023/11/sbornik-ufa-za-2022g.pdf	Официальный статистический сборник	\N	2026-11-20	2021: инвестиции Оренбурга 54 336.2 млн руб. по ограниченному кругу организаций.
368	Оренбург: отчет главы города за 2021 год в местных СМИ	https://oburg.ru/news/36667-sergeju-salminu-predstoit-otchitatsja-o-rabote-prezhnego-glavy-orenburga.html	Публикация по муниципальной статистике	\N	2026-11-20	Зарегистрированная безработица в 2021 году 0.72%; вторичный источник.
369	Оренбургстат: статистический ежегодник Оренбурга 2021 (презентация)	https://56.rosstat.gov.ru/storage/mediabank/1.%D0%92%D1%8B%D1%81%D1%82%D0%B0%D0%B2%D0%BA%D0%B0_%D0%A1%D0%B2%D0%BE%D0%B4%D0%BD%D1%8B%D0%B9.pdf	Официальная региональная статистика	\N	2026-11-20	Численность населения муниципального образования на 01.01.2021 587408 человек.
\.


--
-- Data for Name: enterprise_metrics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprise_metrics (id, enterprise_id, year, employees, revenue, investments, average_salary, source_id, net_profit, assets, taxes_paid, production_volume, revenue_estimation_method) FROM stdin;
1	1	2025	\N	105454369000	\N	\N	105	-27277878000	\N	\N	\N	\N
2	9	2025	1412	6775672000	\N	\N	105	-16271000	\N	\N	\N	\N
3	2	2025	147	3516186000	\N	\N	105	91728000	\N	\N	\N	\N
4	14	2025	\N	30484883000	\N	\N	285	18812706000	\N	\N	\N	\N
5	11	2025	\N	9353553000	\N	\N	281	1867016000	\N	\N	\N	\N
6	19	2025	796	6178354000	\N	\N	105	129248000	\N	\N	\N	\N
7	74	2025	\N	111247373000	\N	\N	342	\N	\N	\N	\N	\N
8	87	2025	13	9694000000	\N	\N	105	\N	\N	\N	\N	\N
23	1	2024	9231	153749457000	\N	\N	129	3407319000	\N	\N	\N	\N
24	9	2024	1473	5789017000	\N	82986.08	122	-88542000	\N	\N	\N	\N
25	2	2024	154	2807055000	\N	\N	112	248100000	\N	\N	\N	\N
26	14	2024	\N	24176919000	\N	\N	285	-5527405000	\N	\N	\N	\N
27	11	2024	\N	8457293000	\N	\N	119	1991928000	\N	\N	\N	\N
28	19	2024	554	2947832000	\N	\N	124	-147569000	\N	\N	\N	\N
29	74	2024	\N	142851034000	\N	\N	342	\N	\N	\N	\N	\N
44	1	2023	\N	161787841000	\N	\N	131	25219304000	\N	\N	\N	\N
45	9	2023	\N	5059405000	\N	\N	115	217861000	\N	\N	\N	\N
46	14	2023	\N	22832486000	\N	\N	285	-15040919000	\N	\N	\N	\N
47	11	2023	\N	7001608000	\N	\N	280	1954746000	\N	\N	\N	\N
48	19	2023	\N	2797202000	\N	\N	293	38156000	\N	\N	\N	\N
49	74	2023	\N	125170259000	\N	\N	138	\N	\N	\N	\N	\N
50	76	2023	\N	85841631000	\N	\N	343	\N	\N	\N	\N	\N
62	14	2022	\N	21281934000	\N	\N	285	3876861000	\N	\N	\N	\N
64	19	2022	\N	1708893000	\N	\N	293	6880000	\N	\N	\N	\N
65	9	2022	\N	3579291000	\N	\N	140	215082000	\N	\N	\N	\N
75	74	2022	\N	123600000000	\N	\N	151	\N	\N	\N	\N	\N
76	76	2022	\N	84727154000	\N	\N	343	\N	\N	\N	\N	\N
77	11	2022	\N	6068075000	\N	\N	153	1358592000	\N	\N	\N	\N
79	1	2022	\N	142737929000	\N	\N	155	11707709000	\N	\N	\N	\N
80	14	2021	\N	14279567000	\N	\N	285	-2643226000	\N	\N	\N	\N
81	74	2021	\N	102690156000	\N	\N	118	\N	\N	\N	\N	\N
82	19	2021	\N	934365000	\N	\N	293	1234000	\N	\N	\N	\N
83	9	2021	\N	1858232000	\N	\N	140	557000	\N	\N	\N	\N
87	11	2021	\N	5727482000	\N	\N	153	1168519000	\N	\N	\N	\N
89	1	2021	\N	141417439000	\N	\N	157	11997691000	\N	\N	\N	\N
124	3	2025	\N	3155216000	\N	\N	238	8189000	\N	\N	\N	\N
125	4	2023	\N	15165171000	\N	\N	239	6330547000	\N	\N	\N	\N
126	6	2024	\N	346428000	\N	\N	241	-15423000	\N	\N	\N	\N
127	7	2024	\N	10673929000	\N	\N	242	625792000	\N	\N	\N	\N
128	8	2025	\N	1118736000	\N	\N	243	512027000	\N	\N	\N	\N
129	10	2025	\N	650283000	\N	\N	244	72229000	\N	\N	\N	\N
130	37	2025	\N	230353000	\N	\N	247	30936000	\N	\N	\N	\N
131	38	2025	\N	62613000	\N	\N	248	-2573000	\N	\N	\N	\N
132	39	2025	\N	239915000	\N	\N	249	-74353000	\N	\N	\N	\N
133	40	2024	\N	490129000	\N	\N	250	12714000	\N	\N	\N	\N
134	41	2025	\N	854627000	\N	\N	251	-869766000	\N	\N	\N	\N
135	42	2024	\N	4086000	\N	\N	252	204000	\N	\N	\N	\N
136	44	2024	\N	0	\N	\N	253	-281000	\N	\N	\N	\N
137	2	2021	\N	3415668000	\N	\N	256	650146000	\N	\N	\N	\N
138	2	2022	\N	3167200000	\N	\N	257	821000000	\N	\N	\N	\N
139	2	2023	\N	2979100000	\N	\N	257	153300000	\N	\N	\N	\N
140	3	2021	\N	761399000	\N	\N	258	-571287000	\N	\N	\N	\N
141	3	2022	\N	1666109000	\N	\N	258	-10128000	\N	\N	\N	\N
142	3	2023	\N	1524044000	\N	\N	258	29955000	\N	\N	\N	\N
143	3	2024	\N	1352981000	\N	\N	258	-298732000	\N	\N	\N	\N
144	4	2021	\N	12604991000	\N	\N	259	2640560000	\N	\N	\N	\N
145	4	2022	\N	13555757000	\N	\N	259	4472470000	\N	\N	\N	\N
146	4	2024	\N	15165171000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
147	4	2025	\N	15165171000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
148	5	2021	\N	469052000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2021 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 6).
149	5	2022	\N	881847000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2022 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 6).
150	5	2023	\N	1486963000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2023 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 6).
151	5	2024	\N	217739000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2024 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 9).
152	5	2025	\N	904359000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2025 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 8).
153	6	2021	\N	1199341000	\N	\N	261	578000	\N	\N	\N	\N
154	6	2022	\N	1437752000	\N	\N	261	8506000	\N	\N	\N	\N
155	6	2023	\N	546875000	\N	\N	261	8901000	\N	\N	\N	\N
156	6	2025	\N	379426000	\N	\N	261	19834000	\N	\N	\N	\N
157	7	2021	\N	12775484000	\N	\N	262	2960461000	\N	\N	\N	\N
158	7	2022	\N	12074966000	\N	\N	\N	\N	\N	\N	\N	Линейная интерполяция выручки предприятия между 2021 и 2024 гг.
159	7	2023	\N	11374447000	\N	\N	\N	\N	\N	\N	\N	Линейная интерполяция выручки предприятия между 2021 и 2024 гг.
160	7	2025	\N	10673929000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
161	8	2021	\N	41438000	\N	\N	263	3606000	\N	\N	\N	\N
162	8	2022	\N	150721000	\N	\N	263	28865000	\N	\N	\N	\N
163	8	2023	\N	195139000	\N	\N	263	33038000	\N	\N	\N	\N
164	8	2024	\N	486851000	\N	\N	263	80346000	\N	\N	\N	\N
165	10	2021	\N	1296014000	\N	\N	265	380752000	\N	\N	\N	\N
166	10	2022	\N	1154597000	\N	\N	265	651037000	\N	\N	\N	\N
167	10	2023	\N	851777000	\N	\N	265	501506000	\N	\N	\N	\N
168	10	2024	\N	704011000	\N	\N	265	347147000	\N	\N	\N	\N
169	37	2021	\N	0	\N	\N	266	-901000	\N	\N	\N	\N
170	37	2022	\N	47814000	\N	\N	266	2408000	\N	\N	\N	\N
171	37	2023	\N	211322000	\N	\N	266	89916000	\N	\N	\N	\N
172	37	2024	\N	212774000	\N	\N	266	72365000	\N	\N	\N	\N
173	38	2021	\N	53963000	\N	\N	267	2582000	\N	\N	\N	\N
174	38	2022	\N	69458000	\N	\N	267	8433000	\N	\N	\N	\N
175	38	2023	\N	41900000	\N	\N	267	4726000	\N	\N	\N	\N
176	38	2024	\N	62323000	\N	\N	267	203000	\N	\N	\N	\N
177	39	2021	\N	0	\N	\N	268	-51000	\N	\N	\N	\N
178	39	2022	\N	54800000	\N	\N	269	1900000	\N	\N	\N	\N
179	39	2023	\N	176723000	\N	\N	270	-90770000	\N	\N	\N	\N
180	39	2024	\N	217739000	\N	\N	270	376000	\N	\N	\N	\N
181	40	2021	\N	353949000	\N	\N	271	23575000	\N	\N	\N	\N
182	40	2022	\N	402816000	\N	\N	271	16385000	\N	\N	\N	\N
183	40	2023	\N	436108000	\N	\N	250	27000000	\N	\N	\N	\N
184	40	2025	\N	526300000	\N	\N	273	8533000	\N	\N	\N	\N
185	41	2023	\N	56485000	\N	\N	275	-3391000	\N	\N	\N	Линейная интерполяция выручки предприятия между 2022 и 2024 гг.
186	41	2024	\N	112969000	\N	\N	275	-265840000	\N	\N	\N	\N
187	42	2021	\N	2880000	\N	\N	276	-1270000	\N	\N	\N	\N
188	42	2022	\N	6940000	\N	\N	276	756000	\N	\N	\N	\N
189	42	2023	\N	5617000	\N	\N	252	-1410000	\N	\N	\N	\N
190	42	2025	\N	1164000	\N	\N	276	-154000	\N	\N	\N	\N
191	44	2021	\N	1185000	\N	\N	277	-285000	\N	\N	\N	\N
192	44	2022	\N	790000	\N	\N	278	-184000	\N	\N	\N	Линейная интерполяция выручки предприятия между 2021 и 2024 гг.
193	44	2023	\N	395000	\N	\N	278	-79000	\N	\N	\N	Линейная интерполяция выручки предприятия между 2021 и 2024 гг.
194	44	2025	\N	30019000	\N	\N	278	4528000	\N	\N	\N	\N
195	12	2021	\N	1408664000	\N	\N	282	56276000	\N	\N	\N	\N
196	12	2022	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
197	12	2023	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
198	12	2024	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
199	12	2025	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
200	15	2021	\N	1302501000	\N	\N	286	151985000	\N	\N	\N	\N
201	15	2022	\N	2120685000	\N	\N	286	251196000	\N	\N	\N	\N
202	15	2023	\N	2319772000	\N	\N	286	292532000	\N	\N	\N	\N
203	15	2024	\N	3177173000	\N	\N	286	797022000	\N	\N	\N	\N
204	15	2025	\N	2265803000	\N	\N	286	174011000	\N	\N	\N	\N
205	16	2021	\N	6538323000	\N	\N	288	83752000	\N	\N	\N	\N
206	16	2022	\N	6538323000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
207	16	2023	\N	6538323000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
208	16	2024	\N	6538323000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
209	16	2025	\N	6538323000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
210	17	2021	\N	62043000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2021 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 13).
211	17	2022	\N	125510000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2022 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 10).
212	17	2023	\N	195139000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2023 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 13).
213	17	2024	\N	294613000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2024 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 18).
214	17	2025	\N	221707000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2025 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 12).
215	18	2021	\N	457216000	\N	\N	291	-78033000	\N	\N	\N	\N
216	18	2022	\N	457216000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
217	18	2023	\N	457216000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
218	18	2024	\N	457216000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
219	18	2025	\N	457216000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
220	20	2021	\N	487970000	\N	\N	294	14760000	\N	\N	\N	\N
221	20	2022	\N	408440000	\N	\N	294	4620000	\N	\N	\N	\N
222	20	2023	\N	529240000	\N	\N	294	4670000	\N	\N	\N	\N
223	20	2024	\N	593693000	\N	\N	295	-83775000	\N	\N	\N	\N
224	20	2025	\N	790508000	\N	\N	295	7652000	\N	\N	\N	\N
225	21	2021	\N	195665000	\N	\N	297	3578000	\N	\N	\N	\N
226	21	2022	\N	211574000	\N	\N	297	5477000	\N	\N	\N	\N
227	21	2023	\N	644905000	\N	\N	297	127147000	\N	\N	\N	\N
228	21	2024	\N	2347910000	\N	\N	297	515886000	\N	\N	\N	\N
229	21	2025	\N	2347910000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
230	23	2021	\N	81300000	\N	\N	301	1000	\N	\N	\N	\N
231	23	2022	\N	85400000	\N	\N	301	3000	\N	\N	\N	\N
232	23	2023	\N	79400000	\N	\N	301	7000	\N	\N	\N	\N
233	23	2024	\N	74700000	\N	\N	301	10000	\N	\N	\N	\N
234	23	2025	\N	72000000	\N	\N	301	20000	\N	\N	\N	\N
235	24	2021	\N	1089519000	\N	\N	304	26056000	\N	\N	\N	\N
236	24	2022	\N	1416146000	\N	\N	304	163030000	\N	\N	\N	\N
237	24	2023	\N	1604969000	\N	\N	304	145835000	\N	\N	\N	\N
238	24	2024	\N	1861114000	\N	\N	304	95969000	\N	\N	\N	\N
239	24	2025	\N	1869389000	\N	\N	304	92753000	\N	\N	\N	\N
240	25	2021	\N	115010000	\N	\N	306	3990000	\N	\N	\N	\N
241	25	2022	\N	105121000	\N	\N	307	-4445000	\N	\N	\N	\N
242	25	2023	\N	96382000	\N	\N	307	-9500000	\N	\N	\N	\N
243	25	2024	\N	83134000	\N	\N	308	-11310000	\N	\N	\N	\N
244	25	2025	\N	91075000	\N	\N	308	-22902000	\N	\N	\N	\N
245	26	2021	\N	1024375000	\N	\N	309	1663000	\N	\N	\N	\N
246	26	2022	\N	1185347000	\N	\N	309	27975000	\N	\N	\N	\N
247	26	2023	\N	955922000	\N	\N	309	1798000	\N	\N	\N	\N
248	26	2024	\N	1189941000	\N	\N	309	8849000	\N	\N	\N	\N
249	26	2025	\N	1263740000	\N	\N	309	690000	\N	\N	\N	\N
250	27	2021	\N	0	\N	\N	311	-747000	\N	\N	\N	\N
251	27	2022	\N	25028000	\N	\N	311	1725000	\N	\N	\N	\N
252	27	2023	\N	37310000	\N	\N	312	380000	\N	\N	\N	\N
253	27	2024	\N	243035000	\N	\N	313	7560000	\N	\N	\N	\N
254	27	2025	\N	181146000	\N	\N	313	-1580000	\N	\N	\N	\N
255	28	2021	\N	359973000	\N	\N	314	18727000	\N	\N	\N	\N
256	28	2022	\N	594898000	\N	\N	314	59934000	\N	\N	\N	\N
257	28	2023	\N	547620000	\N	\N	314	49086000	\N	\N	\N	\N
258	28	2024	\N	549092000	\N	\N	314	14419000	\N	\N	\N	\N
259	28	2025	\N	478849000	\N	\N	314	886000	\N	\N	\N	\N
260	29	2021	\N	62043000	\N	\N	316	1143000	\N	\N	\N	\N
261	29	2022	\N	100299000	\N	\N	316	3126000	\N	\N	\N	\N
262	29	2023	\N	161361000	\N	\N	316	4816000	\N	\N	\N	\N
263	29	2024	\N	238428000	\N	\N	316	3290000	\N	\N	\N	\N
264	29	2025	\N	180053000	\N	\N	316	2567000	\N	\N	\N	\N
265	30	2021	\N	15798000	\N	\N	318	-232000	\N	\N	\N	\N
266	30	2022	\N	20746000	\N	\N	318	252000	\N	\N	\N	\N
267	30	2023	\N	24374000	\N	\N	319	\N	\N	\N	\N	\N
268	30	2024	\N	31085000	\N	\N	319	628000	\N	\N	\N	\N
269	30	2025	\N	25100000	\N	\N	320	-37000	\N	\N	\N	\N
270	31	2021	\N	384000	\N	\N	321	-6356000	\N	\N	\N	\N
271	31	2022	\N	22100000	\N	\N	322	-5300000	\N	\N	\N	\N
272	31	2023	\N	132438000	\N	\N	323	-2700000	\N	\N	\N	\N
273	31	2024	\N	229667000	\N	\N	323	-1039000	\N	\N	\N	\N
274	31	2025	\N	685100000	\N	\N	322	3300000	\N	\N	\N	\N
275	32	2021	\N	24318000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
276	32	2022	\N	24318000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
277	32	2023	\N	24318000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
278	32	2024	\N	24318000	\N	\N	324	2011000	\N	\N	\N	\N
279	32	2025	\N	31495000	\N	\N	324	2772000	\N	\N	\N	\N
280	33	2021	\N	7598000	\N	\N	326	196000	\N	\N	\N	\N
281	33	2022	\N	10498000	\N	\N	326	2731000	\N	\N	\N	\N
282	33	2023	\N	7177000	\N	\N	326	440000	\N	\N	\N	\N
283	33	2024	\N	3852000	\N	\N	326	-1224000	\N	\N	\N	\N
284	33	2025	\N	3852000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
285	34	2021	\N	3738000	\N	\N	328	40000	\N	\N	\N	\N
286	34	2022	\N	0	\N	\N	328	0	\N	\N	\N	\N
287	34	2023	\N	0	\N	\N	328	0	\N	\N	\N	\N
288	34	2024	\N	0	\N	\N	328	0	\N	\N	\N	\N
289	34	2025	\N	0	\N	\N	328	0	\N	\N	\N	\N
290	35	2021	\N	469052000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2021 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 6).
291	35	2022	\N	881847000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2022 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 6).
292	35	2023	\N	1486963000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2023 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 6).
293	35	2024	\N	217739000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2024 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 9).
294	35	2025	\N	904359000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2025 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 8).
295	36	2021	\N	15798000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2021 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 3).
296	36	2022	\N	20746000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2022 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 3).
297	36	2023	\N	33137000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2023 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 4).
298	36	2024	\N	65181000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2024 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 6).
299	36	2025	\N	57035000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2025 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 3).
300	45	2021	\N	62043000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2021 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 13).
301	45	2022	\N	125510000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2022 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 10).
302	45	2023	\N	195139000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2023 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 13).
303	45	2024	\N	294613000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2024 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 18).
304	45	2025	\N	221707000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2025 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 12).
305	46	2021	\N	895013000	\N	\N	333	\N	\N	\N	\N	\N
306	46	2022	\N	895013000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
307	46	2023	\N	895013000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
308	46	2024	\N	895013000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
309	46	2025	\N	895013000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2021).
310	47	2021	\N	829337000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
311	47	2022	\N	829337000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
312	47	2023	\N	829337000	\N	\N	334	\N	\N	\N	\N	\N
313	47	2024	\N	2727268000	\N	\N	334	\N	\N	\N	\N	\N
314	47	2025	\N	2727268000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
315	48	2021	\N	2181375000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2022).
316	48	2022	\N	2181375000	\N	\N	335	\N	\N	\N	\N	\N
317	48	2023	\N	2264328000	\N	\N	335	\N	\N	\N	\N	\N
318	48	2024	\N	2264328000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
319	48	2025	\N	2264328000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
320	49	2021	\N	151490000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
321	49	2022	\N	151490000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
322	49	2023	\N	151490000	\N	\N	336	\N	\N	\N	\N	\N
323	49	2024	\N	164189000	\N	\N	336	\N	\N	\N	\N	\N
324	49	2025	\N	164189000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
325	52	2021	\N	32812000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
326	52	2022	\N	32812000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
327	52	2023	\N	32812000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
328	52	2024	\N	32812000	\N	\N	337	\N	\N	\N	\N	\N
329	52	2025	\N	45029000	\N	\N	337	\N	\N	\N	\N	\N
330	67	2021	\N	160620000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
331	67	2022	\N	160620000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
332	67	2023	\N	160620000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
333	67	2024	\N	160620000	\N	\N	338	\N	\N	\N	\N	\N
334	67	2025	\N	160620000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
335	69	2021	\N	857752000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
336	69	2022	\N	857752000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
337	69	2023	\N	857752000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
338	69	2024	\N	857752000	\N	\N	339	\N	\N	\N	\N	\N
339	69	2025	\N	954091000	\N	\N	339	\N	\N	\N	\N	\N
340	71	2021	\N	47226352000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
341	71	2022	\N	47226352000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
342	71	2023	\N	47226352000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
343	71	2024	\N	47226352000	\N	\N	340	\N	\N	\N	\N	\N
344	71	2025	\N	26880872000	\N	\N	340	\N	\N	\N	\N	\N
345	73	2021	\N	1460913000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
346	73	2022	\N	1460913000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
347	73	2023	\N	1460913000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
348	73	2024	\N	1460913000	\N	\N	341	\N	\N	\N	\N	\N
349	73	2025	\N	1762488000	\N	\N	341	\N	\N	\N	\N	\N
350	76	2021	\N	84727154000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2022).
351	76	2024	\N	85841631000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
352	76	2025	\N	85841631000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
353	78	2021	\N	68039000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
354	78	2022	\N	68039000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
355	78	2023	\N	68039000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
356	78	2024	\N	68039000	\N	\N	344	\N	\N	\N	\N	\N
357	78	2025	\N	57035000	\N	\N	344	\N	\N	\N	\N	\N
358	79	2021	\N	13899000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
359	79	2022	\N	13899000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
360	79	2023	\N	13899000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
361	79	2024	\N	13899000	\N	\N	345	\N	\N	\N	\N	\N
362	79	2025	\N	13899000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
363	80	2021	\N	548495000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
364	80	2022	\N	548495000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
365	80	2023	\N	548495000	\N	\N	346	\N	\N	\N	\N	\N
366	80	2024	\N	380740000	\N	\N	346	\N	\N	\N	\N	\N
367	80	2025	\N	380740000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
368	81	2021	\N	78863000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
369	81	2022	\N	78863000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
370	81	2023	\N	78863000	\N	\N	347	\N	\N	\N	\N	\N
371	81	2024	\N	102600000	\N	\N	347	\N	\N	\N	\N	\N
372	81	2025	\N	102600000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
373	82	2021	\N	192294000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
374	82	2022	\N	192294000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
375	82	2023	\N	192294000	\N	\N	348	\N	\N	\N	\N	\N
376	82	2024	\N	304197000	\N	\N	348	\N	\N	\N	\N	\N
377	82	2025	\N	304197000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
378	83	2021	\N	3225158000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
379	83	2022	\N	3225158000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
380	83	2023	\N	3225158000	\N	\N	349	\N	\N	\N	\N	\N
381	83	2024	\N	4270093000	\N	\N	349	\N	\N	\N	\N	\N
382	83	2025	\N	4270093000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
383	84	2021	\N	285029000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
384	84	2022	\N	285029000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
385	84	2023	\N	285029000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
386	84	2024	\N	285029000	\N	\N	350	\N	\N	\N	\N	\N
387	84	2025	\N	262267000	\N	\N	350	\N	\N	\N	\N	\N
388	85	2021	\N	1520000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
389	85	2022	\N	1520000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
390	85	2023	\N	1520000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
391	85	2024	\N	1520000	\N	\N	351	\N	\N	\N	\N	\N
392	85	2025	\N	1520000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
393	86	2021	\N	191428000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
394	86	2022	\N	191428000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
395	86	2023	\N	191428000	\N	\N	352	\N	\N	\N	\N	\N
396	86	2024	\N	522664000	\N	\N	352	\N	\N	\N	\N	\N
397	86	2025	\N	522664000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
398	87	2021	\N	0	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
399	87	2022	\N	0	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
400	87	2023	\N	0	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
401	87	2024	\N	0	\N	\N	361	\N	\N	\N	\N	\N
402	88	2021	\N	0	\N	\N	359	\N	\N	\N	\N	\N
403	88	2022	\N	0	\N	\N	359	\N	\N	\N	\N	\N
404	88	2023	\N	0	\N	\N	\N	\N	\N	\N	\N	Линейная интерполяция выручки предприятия между 2022 и 2024 гг.
405	88	2024	\N	0	\N	\N	360	\N	\N	\N	\N	\N
406	88	2025	\N	0	\N	\N	360	\N	\N	\N	\N	\N
407	89	2021	\N	255898000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
408	89	2022	\N	255898000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2023).
409	89	2023	\N	255898000	\N	\N	355	\N	\N	\N	\N	\N
410	89	2024	\N	613323000	\N	\N	355	\N	\N	\N	\N	\N
411	89	2025	\N	613323000	\N	\N	\N	\N	\N	\N	\N	Перенос выручки предприятия за ближайший заполненный год (2024).
412	41	2021	\N	0	\N	\N	251	\N	\N	\N	\N	\N
413	41	2022	\N	0	\N	\N	251	\N	\N	\N	\N	\N
414	13	2021	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Аналог по продукции в Орске: выручка АО «Орское карьероуправление» (ИНН 5615002820) за 2021 год. Оценка филиала.
415	13	2022	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Аналог по продукции в Орске: выручка АО «Орское карьероуправление» (ИНН 5615002820) за 2021 год. Оценка филиала.
416	13	2023	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Аналог по продукции в Орске: выручка АО «Орское карьероуправление» (ИНН 5615002820) за 2021 год. Оценка филиала.
417	13	2024	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Аналог по продукции в Орске: выручка АО «Орское карьероуправление» (ИНН 5615002820) за 2021 год. Оценка филиала.
418	13	2025	\N	1408664000	\N	\N	\N	\N	\N	\N	\N	Аналог по продукции в Орске: выручка АО «Орское карьероуправление» (ИНН 5615002820) за 2021 год. Оценка филиала.
419	22	2021	\N	62043000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2021 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 13).
420	22	2022	\N	125510000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2022 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 10).
421	22	2023	\N	195139000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2023 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 13).
422	22	2024	\N	294613000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2024 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 18).
423	22	2025	\N	221707000	\N	\N	\N	\N	\N	\N	\N	Медиана выручки за 2025 г. по другим ИНН той же отрасли в трёх городах базы, до заполнения оценками (ИНН в выборке: 12).
\.


--
-- Data for Name: enterprise_products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprise_products (id, enterprise_id, product_name, product_category, description, is_main, source_id) FROM stdin;
1	9	Керамические пропанты	Нефтегазовая промышленность	Керамические расклинивающие материалы для гидроразрыва пласта	t	3
2	14	Автомобильный бензин АИ-92	Нефтепродукты	Автомобильный бензин экологических классов К4 и К5	t	165
3	14	Автомобильный бензин АИ-95	Нефтепродукты	Автомобильный бензин экологического класса К5	t	165
4	14	Дизельное топливо Евро	Нефтепродукты	Дизельное топливо экологического класса К5	t	165
5	14	Дорожный нефтяной битум	Нефтепродукты	Битумы для дорожного строительства	f	165
6	14	Топливо для реактивных двигателей РТ	Нефтепродукты	Авиационное реактивное топливо	f	165
7	14	Сера техническая	Промышленная химия	Техническая сера, получаемая при нефтепереработке	f	165
12	6	Общестроительный цемент	Строительные материалы	Цемент общестроительного назначения	t	167
13	6	Специальный цемент	Строительные материалы	Специальные марки цемента	t	167
14	6	Тампонажные материалы	Строительные материалы	Материалы для цементирования нефтегазовых скважин	f	167
19	4	Навальный цемент	Строительные материалы	Цемент промышленной отгрузки	t	169
20	4	Тарированный цемент	Строительные материалы	Цемент в мешках	t	169
21	4	Цемент М500	Строительные материалы	Цемент марки М500	t	169
22	4	Цемент М600	Строительные материалы	Цемент повышенной прочности	f	169
23	7	Хромовый ангидрид	Химическая продукция	Технический хромовый ангидрид	t	170
24	7	Бихромат натрия	Химическая продукция	Соединение шестивалентного хрома	t	170
25	7	Окись хрома	Химическая продукция	Зеленая окись хрома	t	170
26	7	Металлический хром	Металлургическая продукция	Металлический хром	f	170
27	7	Бихромат калия	Химическая продукция	Калий двухромовокислый	f	170
33	1	Мостовая сталь	Металлургическая продукция	Сталь для мостостроения и металлоконструкций	t	172
34	1	Листовой прокат	Металлопрокат	Стальной листовой прокат промышленного назначения	t	172
35	1	Высокопрочная сталь WeldUS 690	Специальные стали	Высокопрочная свариваемая сталь	f	172
36	1	Износостойкая сталь HardUS 450	Специальные стали	Высокопрочная износостойкая сталь	f	172
\.


--
-- Data for Name: enterprise_sources; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprise_sources (id, enterprise_id, source_id, source_role, notes) FROM stdin;
129	3	238	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль 8189000 руб. Выручка 3155216000 руб. 2025 г. — выручка 3155216000 руб., чистая прибыль 8189000 руб..
130	4	239	Реквизиты и отчётность	Отчёт за 2023 год. Чистая прибыль 6330547000 руб. Выручка 15165171000 руб. 2023 г. — выручка 15165171000 руб., чистая прибыль 6330547000 руб..
131	5	240	Реквизиты и отчётность	Подтверждены реквизиты юридического лица.
132	6	241	Реквизиты и отчётность	Отчёт за 2024 год. Чистая прибыль -15423000 руб. Выручка 346428000 руб. 2024 г. — выручка 346428000 руб., чистая прибыль -15423000 руб..
133	7	242	Реквизиты и отчётность	Отчёт за 2024 год. Чистая прибыль 625792000 руб. Выручка 10673929000 руб. 2024 г. — выручка 10673929000 руб., чистая прибыль 625792000 руб..
134	8	243	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль 512027000 руб. Выручка 1118736000 руб. 2025 г. — выручка 1118736000 руб., чистая прибыль 512027000 руб..
135	10	244	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль 72229000 руб. Выручка 650283000 руб. 2025 г. — выручка 650283000 руб., чистая прибыль 72229000 руб..
136	2	245	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль 91728000 руб. Выручка 3516186000 руб. 2024 г. — выручка 2807055000 руб.. 2025 г. — выручка 3516186000 руб., чистая прибыль 91728000 руб..
137	9	246	Реквизиты и отчётность	Отчёт за 2024 год. Чистая прибыль -88542000 руб. Выручка 5789017000 руб.
138	37	247	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль 30936000 руб. Выручка 230353000 руб. 2025 г. — выручка 230353000 руб., чистая прибыль 30936000 руб..
139	38	248	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль -2573000 руб. Выручка 62613000 руб. 2025 г. — выручка 62613000 руб., чистая прибыль -2573000 руб..
140	39	249	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль -74353000 руб. Выручка 239915000 руб. 2025 г. — выручка 239915000 руб., чистая прибыль -74353000 руб..
141	40	250	Реквизиты и отчётность	Отчёт за 2024 год. Чистая прибыль 12714000 руб. Выручка 490129000 руб. 2023 г. — выручка 436108000 руб.. 2024 г. — выручка 490129000 руб., чистая прибыль 12714000 руб..
142	41	251	Реквизиты и отчётность	Отчёт за 2025 год. Чистая прибыль -869766000 руб. Выручка 854627000 руб. 2025 г. — выручка 854627000 руб., чистая прибыль -869766000 руб..
143	42	252	Реквизиты и отчётность	Отчёт за 2024 год. Чистая прибыль 204000 руб. Выручка 4086000 руб. 2023 г. — выручка 5617000 руб.. 2024 г. — выручка 4086000 руб., чистая прибыль 204000 руб..
144	44	253	Реквизиты и отчётность	Отчёт за 2024 год. Чистая прибыль -281000 руб. 2024 г. — чистая прибыль -281000 руб..
145	1	254	Реквизиты и отчётность	Отчёт за 2024 год. Чистая прибыль 3407319000 руб. Выручка 153749457000 руб.
146	1	155	Годовая бухгалтерская отчётность	2021 г. — выручка 141417439000 руб., чистая прибыль 11997691000 руб..
147	1	255	Годовая бухгалтерская отчётность	2022 г. — выручка 142737929000 руб., чистая прибыль 11707709000 руб.. 2023 г. — выручка 161787841000 руб., чистая прибыль 25219304000 руб.. 2025 г. — выручка 105454369000 руб., чистая прибыль -27277878000 руб..
148	1	131	Годовая бухгалтерская отчётность	2024 г. — выручка 153749457000 руб., чистая прибыль 3407319000 руб..
149	2	256	Годовая бухгалтерская отчётность	2021 г. — выручка 3415668000 руб., чистая прибыль 650146000 руб..
150	2	257	Годовая бухгалтерская отчётность	2022 г. — выручка ≈ 3167200000 руб., чистая прибыль ≈ 821000000 руб.. 2023 г. — выручка ≈ 2979100000 руб., чистая прибыль ≈ 153300000 руб.. 2024 г. — чистая прибыль ≈ 248100000 руб..
151	3	258	Годовая бухгалтерская отчётность	2021 г. — выручка 761399000 руб., чистая прибыль -571287000 руб.. 2022 г. — выручка 1666109000 руб., чистая прибыль -10128000 руб.. 2023 г. — выручка 1524044000 руб., чистая прибыль 29955000 руб.. 2024 г. — выручка 1352981000 руб., чистая прибыль -298732000 руб..
152	4	259	Годовая бухгалтерская отчётность	2021 г. — выручка 12604991000 руб., чистая прибыль 2640560000 руб.. 2022 г. — выручка 13555757000 руб., чистая прибыль 4472470000 руб.. 2024 г. — выручка не подтверждена, чистая прибыль не подтверждена. 2025 г. — выручка не подтверждена, чистая прибыль не подтверждена.
153	5	260	Годовая бухгалтерская отчётность	2021 г. — выручка не подтверждена, чистая прибыль не подтверждена. 2022 г. — выручка не подтверждена, чистая прибыль не подтверждена. 2023 г. — выручка не подтверждена, чистая прибыль не подтверждена. 2024 г. — выручка не подтверждена, чистая прибыль не подтверждена. 2025 г. — выручка не подтверждена, чистая прибыль не подтверждена.
154	6	261	Годовая бухгалтерская отчётность	2021 г. — выручка 1199341000 руб., чистая прибыль 578000 руб.. 2022 г. — выручка 1437752000 руб., чистая прибыль 8506000 руб.. 2023 г. — выручка 546875000 руб., чистая прибыль 8901000 руб.. 2025 г. — выручка 379426000 руб., чистая прибыль 19834000 руб..
155	7	262	Годовая бухгалтерская отчётность	2021 г. — выручка 12775484000 руб., чистая прибыль 2960461000 руб.. 2022 г. — выручка не подтверждена, чистая прибыль не подтверждена. 2023 г. — выручка не подтверждена, чистая прибыль не подтверждена. 2025 г. — выручка не подтверждена, чистая прибыль не подтверждена.
156	8	263	Годовая бухгалтерская отчётность	2021 г. — выручка 41438000 руб., чистая прибыль 3606000 руб.. 2022 г. — выручка 150721000 руб., чистая прибыль 28865000 руб.. 2023 г. — выручка 195139000 руб., чистая прибыль 33038000 руб.. 2024 г. — выручка 486851000 руб., чистая прибыль 80346000 руб..
157	9	264	Годовая бухгалтерская отчётность	2021 г. — выручка 1858232000 руб., чистая прибыль 557000 руб.. 2022 г. — выручка 3579291000 руб., чистая прибыль 215082000 руб.. 2023 г. — выручка 5059405000 руб., чистая прибыль 217861000 руб.. 2025 г. — выручка 6775672000 руб., чистая прибыль -16271000 руб..
158	9	115	Годовая бухгалтерская отчётность	2024 г. — выручка 5789017000 руб., чистая прибыль -88542000 руб..
159	10	265	Годовая бухгалтерская отчётность	2021 г. — выручка 1296014000 руб., чистая прибыль 380752000 руб.. 2022 г. — выручка 1154597000 руб., чистая прибыль 651037000 руб.. 2023 г. — выручка 851777000 руб., чистая прибыль 501506000 руб.. 2024 г. — выручка 704011000 руб., чистая прибыль 347147000 руб..
160	37	266	Годовая бухгалтерская отчётность	2021 г. — выручка не подтверждена, чистая прибыль -901000 руб.. 2022 г. — выручка 47814000 руб., чистая прибыль 2408000 руб.. 2023 г. — выручка 211322000 руб., чистая прибыль 89916000 руб.. 2024 г. — выручка 212774000 руб., чистая прибыль 72365000 руб..
161	38	267	Годовая бухгалтерская отчётность	2021 г. — выручка 53963000 руб., чистая прибыль 2582000 руб.. 2022 г. — выручка 69458000 руб., чистая прибыль 8433000 руб.. 2023 г. — выручка 41900000 руб., чистая прибыль 4726000 руб.. 2024 г. — выручка 62323000 руб., чистая прибыль 203000 руб..
162	39	268	Годовая бухгалтерская отчётность	2021 г. — выручка не подтверждена, чистая прибыль -51000 руб..
163	39	269	Годовая бухгалтерская отчётность	2022 г. — выручка ≈ 54800000 руб., чистая прибыль ≈ 1900000 руб..
164	39	270	Годовая бухгалтерская отчётность	2023 г. — выручка 176723000 руб., чистая прибыль -90770000 руб.. 2024 г. — выручка 217739000 руб., чистая прибыль 376000 руб..
165	40	271	Годовая бухгалтерская отчётность	2021 г. — выручка 353949000 руб., чистая прибыль 23575000 руб.. 2022 г. — выручка 402816000 руб., чистая прибыль 16385000 руб..
166	40	272	Годовая бухгалтерская отчётность	2023 г. — чистая прибыль ≈ 27000000 руб..
167	40	273	Годовая бухгалтерская отчётность	2025 г. — выручка ≈ 526300000 руб..
168	40	274	Годовая бухгалтерская отчётность	2025 г. — чистая прибыль 8533000 руб..
169	41	275	Годовая бухгалтерская отчётность	2023 г. — выручка не подтверждена, чистая прибыль -3391000 руб.. 2024 г. — выручка 112969000 руб., чистая прибыль -265840000 руб..
170	42	276	Годовая бухгалтерская отчётность	2021 г. — выручка ≈ 2880000 руб., чистая прибыль ≈ -1270000 руб.. 2022 г. — выручка ≈ 6940000 руб., чистая прибыль 756000 руб.. 2023 г. — чистая прибыль ≈ -1410000 руб.. 2025 г. — выручка 1164000 руб., чистая прибыль -154000 руб..
171	44	277	Годовая бухгалтерская отчётность	2021 г. — выручка 1185000 руб., чистая прибыль -285000 руб..
172	44	278	Годовая бухгалтерская отчётность	2022 г. — выручка не подтверждена, чистая прибыль -184000 руб.. 2023 г. — выручка не подтверждена, чистая прибыль -79000 руб.. 2025 г. — выручка 30019000 руб., чистая прибыль 4528000 руб..
173	44	279	Годовая бухгалтерская отчётность	2024 г. — выручка 0 руб..
174	11	119	Реквизиты и отчётность	Идентификация по ИНН. 2024, выручка 8457293000 руб. 2024, чистая прибыль 1991928000 руб.
175	11	153	Реквизиты и отчётность	2021, выручка 5727482000 руб. 2021, чистая прибыль 1168519000 руб. 2022, выручка 6068075000 руб. 2022, чистая прибыль 1358592000 руб.
176	11	280	Реквизиты и отчётность	2023, выручка 7001608000 руб. 2023, чистая прибыль 1954746000 руб.
177	11	281	Реквизиты и отчётность	2025, выручка 9353553000 руб. 2025, чистая прибыль 1867016000 руб.
178	12	282	Реквизиты и отчётность	Идентификация по ИНН. 2021, выручка 1408664000 руб. 2021, чистая прибыль 56276000 руб.
179	13	284	Головная компания	ИНН головной компании. Отчётность охватывает все подразделения.
180	13	283	Головная компания	2021, выручка 5510600000 руб. 2021, чистая прибыль 278395000 руб. 2022, выручка 7779300000 руб. 2022, чистая прибыль 251183000 руб. 2023, выручка 15844015000 руб. 2023, чистая прибыль 776767000 руб. 2024, выручка 13876622000 руб. 2024, чистая прибыль 547922000 руб. 2025, выручка 10807961000 руб. 2025, чистая прибыль 546650000 руб.
181	14	106	Реквизиты и отчётность	Идентификация по ИНН.
182	14	285	Реквизиты и отчётность	2021, выручка 14279567000 руб. 2021, чистая прибыль -2643226000 руб. 2022, выручка 21281934000 руб. 2022, чистая прибыль 3876861000 руб. 2023, выручка 22832486000 руб. 2023, чистая прибыль -15040919000 руб. 2024, выручка 24176919000 руб. 2024, чистая прибыль -5527405000 руб. 2025, выручка 30484883000 руб. 2025, чистая прибыль 18812706000 руб.
183	15	287	Реквизиты и отчётность	Идентификация по ИНН.
184	15	286	Реквизиты и отчётность	2021, выручка 1302501000 руб. 2021, чистая прибыль 151985000 руб. 2022, выручка 2120685000 руб. 2022, чистая прибыль 251196000 руб. 2023, выручка 2319772000 руб. 2023, чистая прибыль 292532000 руб. 2024, выручка 3177173000 руб. 2024, чистая прибыль 797022000 руб. 2025, выручка 2265803000 руб. 2025, чистая прибыль 174011000 руб.
185	16	289	Реквизиты и отчётность	Идентификация по ИНН.
186	16	288	Реквизиты и отчётность	2021, выручка 6538323000 руб. 2021, чистая прибыль 83752000 руб.
187	17	290	Реквизиты и отчётность	Идентификация по ИНН.
188	18	292	Реквизиты и отчётность	Идентификация по ИНН.
189	18	291	Реквизиты и отчётность	2021, выручка 457216000 руб. 2021, чистая прибыль -78033000 руб.
190	19	130	Реквизиты и отчётность	Идентификация по ИНН.
191	19	293	Реквизиты и отчётность	2021, выручка 934365000 руб. 2021, чистая прибыль 1234000 руб. 2022, выручка 1708893000 руб. 2022, чистая прибыль 6880000 руб. 2023, выручка 2797202000 руб. 2023, чистая прибыль 38156000 руб. 2024, выручка 2947832000 руб. 2024, чистая прибыль -147569000 руб. 2025, выручка 6178354000 руб. 2025, чистая прибыль 129248000 руб.
192	20	296	Реквизиты и отчётность	Идентификация по ИНН.
193	20	294	Реквизиты и отчётность	2021, выручка ≈ 487970000 руб. 2021, чистая прибыль ≈ 14760000 руб. 2022, выручка ≈ 408440000 руб. 2022, чистая прибыль ≈ 4620000 руб. 2023, выручка ≈ 529240000 руб. 2023, чистая прибыль ≈ 4670000 руб.
194	20	295	Реквизиты и отчётность	2024, выручка 593693000 руб. 2024, чистая прибыль -83775000 руб. 2025, выручка 790508000 руб. 2025, чистая прибыль 7652000 руб.
195	21	298	Реквизиты и отчётность	Идентификация по ИНН.
196	21	297	Реквизиты и отчётность	2021, выручка 195665000 руб. 2021, чистая прибыль 3578000 руб. 2022, выручка 211574000 руб. 2022, чистая прибыль 5477000 руб. 2023, выручка 644905000 руб. 2023, чистая прибыль 127147000 руб. 2024, выручка 2347910000 руб. 2024, чистая прибыль 515886000 руб.
197	22	300	Головная компания	ИНН головной компании. Отчётность охватывает все подразделения.
198	22	299	Головная компания	2021, выручка 13114663000 руб. 2021, чистая прибыль 444518000 руб. 2022, выручка 38064538000 руб. 2022, чистая прибыль 2439740000 руб. 2023, выручка 39365754000 руб. 2023, чистая прибыль 2027420000 руб.
199	23	302	Реквизиты и отчётность	Идентификация по ИНН.
200	23	301	Реквизиты и отчётность	2021, выручка ≈ 81300000 руб. 2022, выручка ≈ 85400000 руб. 2023, выручка ≈ 79400000 руб. 2024, выручка ≈ 74700000 руб. 2025, выручка ≈ 72000000 руб.
201	23	303	Реквизиты и отчётность	2021, чистая прибыль 1000 руб. 2022, чистая прибыль 3000 руб. 2023, чистая прибыль 7000 руб. 2024, чистая прибыль 10000 руб. 2025, чистая прибыль 20000 руб.
202	24	305	Реквизиты и отчётность	Идентификация по ИНН.
203	24	304	Реквизиты и отчётность	2021, выручка 1089519000 руб. 2021, чистая прибыль 26056000 руб. 2022, выручка 1416146000 руб. 2022, чистая прибыль 163030000 руб. 2023, выручка 1604969000 руб. 2023, чистая прибыль 145835000 руб. 2024, выручка 1861114000 руб. 2024, чистая прибыль 95969000 руб. 2025, выручка 1869389000 руб. 2025, чистая прибыль 92753000 руб.
204	25	308	Реквизиты и отчётность	Идентификация по ИНН. 2024, выручка 83134000 руб. 2025, выручка 91075000 руб. 2025, чистая прибыль -22902000 руб.
205	25	306	Реквизиты и отчётность	2021, выручка ≈ 115010000 руб. 2021, чистая прибыль ≈ 3990000 руб. 2024, чистая прибыль ≈ -11310000 руб.
206	25	307	Реквизиты и отчётность	2022, выручка 105121000 руб. 2022, чистая прибыль -4445000 руб. 2023, выручка 96382000 руб. 2023, чистая прибыль -9500000 руб.
207	26	310	Реквизиты и отчётность	Идентификация по ИНН.
208	26	309	Реквизиты и отчётность	2021, выручка 1024375000 руб. 2021, чистая прибыль 1663000 руб. 2022, выручка 1185347000 руб. 2022, чистая прибыль 27975000 руб. 2023, выручка 955922000 руб. 2023, чистая прибыль 1798000 руб. 2024, выручка 1189941000 руб. 2024, чистая прибыль 8849000 руб. 2025, выручка 1263740000 руб. 2025, чистая прибыль 690000 руб.
209	27	313	Реквизиты и отчётность	Идентификация по ИНН. 2024, выручка 243035000 руб. 2025, выручка 181146000 руб. 2025, чистая прибыль -1580000 руб.
210	27	311	Реквизиты и отчётность	2021, чистая прибыль -747000 руб. 2022, выручка 25028000 руб. 2022, чистая прибыль 1725000 руб.
211	27	312	Реквизиты и отчётность	2023, выручка ≈ 37310000 руб. 2023, чистая прибыль 380000 руб. 2024, чистая прибыль ≈ 7560000 руб.
212	28	315	Реквизиты и отчётность	Идентификация по ИНН.
213	28	314	Реквизиты и отчётность	2021, выручка 359973000 руб. 2021, чистая прибыль 18727000 руб. 2022, выручка 594898000 руб. 2022, чистая прибыль 59934000 руб. 2023, выручка 547620000 руб. 2023, чистая прибыль 49086000 руб. 2024, выручка 549092000 руб. 2024, чистая прибыль 14419000 руб. 2025, выручка 478849000 руб. 2025, чистая прибыль 886000 руб.
214	29	317	Реквизиты и отчётность	Идентификация по ИНН.
215	29	316	Реквизиты и отчётность	2021, выручка 62043000 руб. 2021, чистая прибыль 1143000 руб. 2022, выручка 100299000 руб. 2022, чистая прибыль 3126000 руб. 2023, выручка 161361000 руб. 2023, чистая прибыль 4816000 руб. 2024, выручка 238428000 руб. 2024, чистая прибыль 3290000 руб. 2025, выручка 180053000 руб. 2025, чистая прибыль 2567000 руб.
216	30	319	Реквизиты и отчётность	Идентификация по ИНН. 2023, выручка 24374000 руб. 2024, выручка 31085000 руб. 2024, чистая прибыль 628000 руб.
217	30	318	Реквизиты и отчётность	2021, выручка 15798000 руб. 2021, чистая прибыль -232000 руб. 2022, выручка 20746000 руб. 2022, чистая прибыль 252000 руб.
218	30	320	Реквизиты и отчётность	2025, выручка ≈ 25100000 руб. 2025, чистая прибыль -37000 руб.
219	31	323	Реквизиты и отчётность	Идентификация по ИНН. 2023, выручка 132438000 руб. 2024, выручка 229667000 руб. 2024, чистая прибыль -1039000 руб.
220	31	321	Реквизиты и отчётность	2021, выручка 384000 руб. 2021, чистая прибыль -6356000 руб.
221	31	322	Реквизиты и отчётность	2022, выручка ≈ 22100000 руб. 2022, чистая прибыль ≈ -5300000 руб. 2023, чистая прибыль ≈ -2700000 руб. 2025, выручка ≈ 685100000 руб. 2025, чистая прибыль ≈ 3300000 руб.
222	32	325	Реквизиты и отчётность	Идентификация по ИНН.
223	32	324	Реквизиты и отчётность	2024, выручка 24318000 руб. 2024, чистая прибыль 2011000 руб. 2025, выручка 31495000 руб. 2025, чистая прибыль 2772000 руб.
224	33	327	Реквизиты и отчётность	Идентификация по ИНН.
225	33	326	Реквизиты и отчётность	2021, выручка 7598000 руб. 2021, чистая прибыль 196000 руб. 2022, выручка 10498000 руб. 2022, чистая прибыль 2731000 руб. 2023, выручка 7177000 руб. 2023, чистая прибыль 440000 руб. 2024, выручка 3852000 руб. 2024, чистая прибыль -1224000 руб.
226	34	329	Реквизиты и отчётность	Идентификация по ИНН. Адрес в карточке юрлица — ул. Тобольская, 8. В базе и на сайте производства — ул. Тобольская, 10. Показатели относятся к ИНН 5614080705.
227	34	328	Реквизиты и отчётность	2021, выручка 3738000 руб. 2021, чистая прибыль 40000 руб. 2022, выручка 0 руб. 2022, чистая прибыль 0 руб. 2023, выручка 0 руб. 2023, чистая прибыль 0 руб. 2024, выручка 0 руб. 2024, чистая прибыль 0 руб. 2025, выручка 0 руб. 2025, чистая прибыль 0 руб.
228	35	330	Реквизиты и отчётность	Идентификация по ИНН.
229	36	331	Реквизиты и отчётность	Идентификация по ИНН.
230	45	332	Реквизиты и отчётность	Идентификация по ИНН.
231	46	333	Реквизиты и отчётность	Выручка. 2021: 895013000 руб.
232	47	334	Реквизиты и отчётность	Выручка. 2023: 829337000 руб. 2024: 2727268000 руб.
233	48	335	Реквизиты и отчётность	Выручка. 2022: 2181375000 руб. 2023: 2264328000 руб.
234	49	336	Реквизиты и отчётность	Выручка. 2023: 151490000 руб. 2024: 164189000 руб.
235	52	337	Реквизиты и отчётность	Выручка. 2024: 32812000 руб. 2025: 45029000 руб.
236	67	338	Реквизиты и отчётность	Выручка. 2024: 160620000 руб. Сверка года: https://reputation.ru/ogrn/1025601020180
237	69	339	Реквизиты и отчётность	Выручка. 2024: 857752000 руб. 2025: 954091000 руб.
238	71	340	Реквизиты и отчётность	Выручка. 2024: 47226352000 руб. 2025: 26880872000 руб.
239	73	341	Реквизиты и отчётность	Выручка. 2024: 1460913000 руб. 2025: 1762488000 руб.
240	74	342	Реквизиты и отчётность	Выручка. 2024: 142851034000 руб. 2025: 111247373000 руб.
241	76	343	Реквизиты и отчётность	Выручка. 2022: 84727154000 руб. 2023: 85841631000 руб.
242	78	344	Реквизиты и отчётность	Выручка. 2024: 68039000 руб. 2025: 57035000 руб.
243	79	345	Реквизиты и отчётность	Выручка. 2024: 13899000 руб. Сверка года: https://firmoteka.ru/5010039782
244	80	346	Реквизиты и отчётность	Выручка. 2023: 548495000 руб. 2024: 380740000 руб.
245	81	347	Реквизиты и отчётность	Выручка. 2023: 78863000 руб. 2024: 102600000 руб.
246	82	348	Реквизиты и отчётность	Выручка. 2023: 192294000 руб. 2024: 304197000 руб.
247	83	349	Реквизиты и отчётность	Выручка. 2023: 3225158000 руб. 2024: 4270093000 руб.
248	84	350	Реквизиты и отчётность	Выручка. 2024: 285029000 руб. 2025: 262267000 руб.
249	85	351	Реквизиты и отчётность	Выручка. 2024: 1520000 руб. Сверка года: https://reputation.ru/ogrn/1105658005287
250	86	352	Реквизиты и отчётность	Выручка. 2023: 191428000 руб. 2024: 522664000 руб.
251	87	353	Реквизиты и отчётность	Идентификация по ИНН.
252	88	354	Реквизиты и отчётность	Идентификация по ИНН.
253	89	355	Реквизиты и отчётность	Выручка. 2023: 255898000 руб. 2024: 613323000 руб.
254	41	251	Выручка	2021, 2022 — 0 руб. Условный ноль до регистрации АО 13.06.2023.
255	37	356	Выручка	2021 — 0 руб. Условный ноль до запуска производства в августе 2022 года.
256	39	357	Выручка	2021 — 0 руб. Условный ноль до запуска производства в августе 2022 года.
257	27	358	Выручка	2021 — 0 руб. Условный ноль за полный год до возобновления производства холодильников. В 2021 году шла модернизация.
258	88	359	Выручка	2021, 2022 — 0 руб. В отчётности ФНС по строке 2110 стоит прочерк. По правилу базы записан ноль.
259	88	360	Выручка	2024, 2025 — 0 руб. Условный ноль за полные годы после ликвидации 28.09.2023.
260	87	361	Выручка	2024 — 0 руб. В сравнительной графе за 2024 год строки 2110 стоит прочерк. По правилу базы записан ноль.
\.


--
-- Data for Name: enterprises; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprises (id, name, short_name, inn, ogrn, city_id, industry_id, okved, address, activity_description, products, website, phone, email, latitude, longitude, status, foundation_year, employee_category, is_city_forming, is_major_enterprise, economic_role) FROM stdin;
3	ООО «Новотроицкий содовый завод»	Новотроицкий содовый завод	5607142213	1185658000637	1	2	\N	\N	Реализация промышленного проекта по производству химической и строительной продукции	Сода, известь, гипс, газоблоки	\N	\N	\N	\N	\N	Инвестиционный проект	\N	\N	f	f	\N
4	ООО «АККЕРМАНН ЦЕМЕНТ»	AKKERMANN CEMENT	5607015014	1025600822510	1	4	\N	г. Новотроицк, территория 5,4 км автодороги Новотроицк — Орск, здание 2	Производство цемента и строительных материалов	Цемент различных марок	https://akkermann.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
5	ООО «Металекс»	Металекс	5607011852	1025600820630	1	1	\N	\N	Производство ферросплавов	Ферросилиций и другие ферросплавы	https://metal-x.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
6	АО «Новотроицкий цементный завод»	НЦЗ	5607004870	1025600820563	1	4	\N	г. Новотроицк, ул. Заводская, д. 3	Производство общестроительных и специальных цементов	Общестроительные цементы, тампонажные цементы, специальные материалы	https://novocement.ru/	+7 (3537) 60-19-56	\N	\N	\N	Действующее	\N	\N	f	f	\N
7	АО «Новотроицкий завод хромовых соединений»	НЗХС	5607002135	1025600820431	1	2	\N	\N	Химическое и металлургическое производство соединений хрома и хромсодержащей продукции	Соединения хрома, металлический хром, феррохром	https://nzhs.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
8	ООО «Новотроицкий завод нестандартного технологического оборудования»	НЗНТО	5607142100	1175658023705	1	3	\N	г. Новотроицк, ул. Восточная поляна, д. 14	Инжиниринг, производство и сервисное обслуживание промышленного оборудования	Промышленное оборудование, металлоконструкции, запасные части и комплектующие	https://nznto56.ru/	+7 (3537) 657-657	info@nznto56.ru	\N	\N	Действующее	\N	\N	f	f	\N
10	ООО «Новохром»	Новохром	5607014758	1025600820365	1	2	\N	\N	Производство красителей, пигментов и неорганических химических веществ	Красители, пигменты и химические вещества	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
12	АО «Орское карьероуправление»	ОКУ	5615002820	\N	2	7	\N	г. Орск, Гайское шоссе, д. 10	Добыча и переработка габбро-диабазов	Щебень, строительный песок	http://www.oky56.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
13	Орский щебеночный завод — филиал АО «ПНК»	ОЩЗ	7708670326	\N	2	7	\N	г. Орск, ул. Маршала Конева, 2Г	Добыча и переработка нерудных полезных ископаемых	Щебень, отсев, песок	https://orsk.1pnk.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
15	ООО «Синтезспирт»	Синтезспирт	5614085615	\N	2	2	\N	г. Орск, ул. Тобольская, д. 5	Производство органических химических веществ	Изопропиловый спирт и химическая продукция	https://syntalco.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
16	АО «Орский машиностроительный завод»	ОМЗ	5613000880	\N	2	3	\N	г. Орск, ул. Крупской, д. 1	Производство оборудования и комплектующих для нефтегазовой отрасли	Замки бурильных труб, комплектующие, газовые баллоны	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
17	АО «Механический завод»	Механический завод	5614057287	\N	2	3	\N	г. Орск, проспект Мира, д. 4, корп. 3А	Машиностроительное производство	Специальная и гражданская промышленная продукция	https://mz-orsk.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
18	ООО «Уралмаш-Горное оборудование»	Уралмаш-ГО	6673125685	\N	2	3	\N	г. Орск, проспект Мира, д. 12	Производство оборудования для металлургической и горнодобывающей промышленности	Горное и металлургическое оборудование	https://uralmash-kartex.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
20	ООО «Уральский завод горного оборудования»	УЗГО	5614046528	\N	2	3	\N	г. Орск, ул. Дорожная, д. 21	Тяжёлое машиностроение	Дробилки, мельницы, детали экскаваторов и горного оборудования	https://uzgo-product.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
2	ООО «НСплав»	НСплав	5607141530	1165658079718	1	1	\N	\N	Производство металлического хрома и хромовых брикетов	Металлический хром, порошок хрома, дегазированные брикеты	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
9	ООО «Оренбургский пропант»	Оренбургский пропант	5607142044	1175658020449	1	4	\N	г. Новотроицк, ул. Заводская, здание 7	Производство керамических пропантов для нефтегазовой промышленности	Пропанты для гидравлического разрыва пласта	https://orenpropant.ru/	+7 (3537) 60-17-17	info@orenpropant.ru	\N	\N	Действующее	\N	\N	f	f	\N
21	АО «Орский завод электромонтажных изделий»	ОЗЭМИ	5614001069	\N	2	3	\N	г. Орск, ул. Станиславского, 50В	Производство электротехнического оборудования	Трансформаторные подстанции и распределительные устройства	https://orskemi.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
22	Орский вагоноремонтный завод — филиал ООО «НВК»	Орский ВРЗ	7705845722	\N	2	3	\N	г. Орск, ул. Заводская, д. 6	Ремонт железнодорожного подвижного состава	Ремонт грузовых вагонов и колесных пар	https://www.nvrk.ru/enterprise/orsk	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
23	ЗАО «Орский хлеб»	Орский хлеб	5615013290	\N	2	5	\N	г. Орск, ул. Союзная, д. 7	Производство хлебобулочной и кондитерской продукции	Хлеб, хлебобулочные и кондитерские изделия	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
24	ООО «Орский мясокомбинат»	Орский мясокомбинат	5614054751	\N	2	5	\N	г. Орск, 1-й Домбаровский переулок, д. 41	Переработка мяса и производство мясной продукции	Мясные консервы, полуфабрикаты	https://orskmk.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
25	ООО «Пивоваренный завод «Орский»»	Пивоваренный завод Орский	5616009698	\N	2	5	\N	г. Орск, ул. Л. Толстого / ул. Пионерская, 29/8	Производство напитков	Пиво, квас, безалкогольные напитки	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
26	ООО «Агро-Альянс ОМФ»	Орская макаронная фабрика	5614077558	\N	2	5	\N	г. Орск, ул. Дорожная, зд. 4	Производство макаронных изделий	Макаронные изделия	https://agro-al.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
27	ООО «НПО ОРСК»	НПО ОРСК	5614085453	\N	2	3	\N	\N	Производство холодильной техники и механообработка	Холодильное оборудование, компрессоры, металлические изделия	https://npoorsk.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
28	ООО «Завод Горных Машин»	ЗГМ	5614064527	\N	2	3	\N	г. Орск, ул. Металлистов, д. 11	Производство горнодобывающего оборудования	Дробилки, грохоты, питатели и запасные части	https://zgm.su/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
29	Завод «ГорЦемМаш»	ГорЦемМаш	5614079192	\N	2	3	\N	г. Орск, ул. Металлистов, д. 1	Производство оборудования и запчастей для горнодобывающей промышленности	Запчасти для дробилок, мельниц и другого оборудования	https://zavod-gcm.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
30	ООО «Орский ПЭТ завод»	Орский ПЭТ завод	5614084026	\N	2	8	\N	г. Орск, Вокзальное шоссе, 18А	Производство пластмассовой упаковки	ПЭТ-преформы, бутылки, колпачки	https://petzavod56.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
31	ООО «ТПК ОРСК»	Завод холодильников ORSK	5614085372	\N	2	3	\N	г. Орск, проспект Мира, д. 4	Полный цикл производства бытовой холодильной техники	Бытовые холодильники	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
32	ООО «Орскагромаш»	Орскагромаш	5614061734	\N	2	3	\N	\N	Производство сельскохозяйственной техники	Самоходные опрыскиватели и комплектующие	https://www.orskagromash.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
33	ООО «Уралпласттара»	Уралпласттара	5615015956	\N	2	8	\N	г. Орск, ул. Союзная, владение 7А	Производство пластмассовых изделий для упаковки товаров	Пластмассовая тара и упаковка	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
34	ООО «РОСЭлектрод-Долина»	РОСЭлектрод-Долина	5614080705	\N	2	1	\N	г. Орск, ул. Тобольская, д. 10	Производство сварочных материалов	Сварочные электроды	https://roselektrod-dolina.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
35	ООО «Уральский завод строительных конструкций»	УЗСК	5607043540	\N	2	1	\N	г. Орск, ул. Тобольская, д. 9	Производство металлических строительных конструкций	Металлоконструкции, резервуары, опоры и металлоизделия	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
36	«Спарта»	Спарта	5614058308	\N	2	8	\N	\N	Производство изделий из стеклопластика	Лодки, катамараны, хоккейные корты и спортивное оборудование	https://sparta-orsk.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
37	ООО «Новотроицкий завод бисульфита и пиросульфита»	НЗБП	5607144115	1215600008942	1	2	\N	г. Новотроицк	Производство химических веществ	Бисульфит натрия, пиросульфит натрия	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
38	ООО «ПОДДОН СЕРВИС»	Поддон Сервис	5607143440	1195658018907	1	8	\N	г. Новотроицк	Производство деревянной тары	Деревянные поддоны и паллеты	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
39	ООО «Новотроицкий завод цветных металлов»	НЗЦМ	5607143640	1205600008668	1	1	\N	г. Новотроицк	Производство продукции из цветных металлов	Цветные металлы и продукция их переработки	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
40	ООО «Хлебозавод»	Новотроицкий хлебозавод	5607140262	1155658008505	1	5	\N	г. Новотроицк	Производство хлебобулочной и кондитерской продукции	Хлеб, хлебобулочные и кондитерские изделия	https://7hlebozavod.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
41	АО «Новотроицкий трубопрокатный завод»	НТПЗ	5607144789	1235600005486	1	1	\N	г. Новотроицк, ул. Заводская, здание 1Р	Производство бесшовных горячедеформированных стальных труб	Бесшовные трубы для нефтегазовой, химической, строительной и машиностроительной отраслей	https://novtpz.ru/	+7 (3537) 66-43-01	info@novtpz.ru	\N	\N	Действующее	\N	\N	f	f	\N
42	ООО «Завод Элмон»	Элмон	5607143496	1205600001342	1	3	\N	г. Новотроицк	Производство электротехнического оборудования	Электрощитовая продукция, светодиодные светильники	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
44	ООО «Уральский завод технологического машиностроения»	УЗТМ	5614080374	1175658020922	1	3	\N	г. Новотроицк	Производство технологического оборудования для горнодобывающей промышленности	Горное и технологическое оборудование	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
45	АО «Производственное объединение «Стрела»	ПО «Стрела»	5609061432	\N	3	3	\N	г. Оренбург	Крупное машиностроительное и приборостроительное предприятие	Промышленная и специальная машиностроительная продукция	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
46	АО «Завод бурового оборудования»	ЗБО	5612002652	\N	3	3	\N	г. Оренбург, проспект Победы, 118	Производство оборудования для буровых и геологоразведочных работ	Буровые установки, бурильные трубы, инструмент	https://zbo.ru/	+7 (3532) 75-68-14	pochta@zbo.ru	\N	\N	Действующее	\N	\N	f	f	\N
47	АО «Завод «Инвертор»	Инвертор	5609003039	\N	3	3	\N	г. Оренбург, проезд Автоматики, д. 8	Разработка и производство электротехнического оборудования	Инверторы, выпрямители, системы бесперебойного питания, подстанции	https://sbp-invertor.ru/	+7 (3532) 48-24-48	info@sbp-invertor.ru	\N	\N	Действующее	\N	\N	f	f	\N
48	ООО «Оренбургский радиатор»	Оренбургский радиатор	5612030402	\N	3	3	\N	г. Оренбург, ул. Комсомольская, 175	Разработка и серийное производство теплообменной продукции	Радиаторы и теплообменники для транспорта и специальной техники	https://orenrad.ru/	+7 (3532) 72-12-10	info@orenrad.ru	\N	\N	Действующее	\N	\N	f	f	\N
49	АО «Нефтемаслозавод»	Нефтемаслозавод	5609008608	\N	3	2	\N	г. Оренбург, ул. Заводская, д. 30	Переработка нефтяного сырья и производство нефтехимической продукции	Масла и нефтепродукты	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
52	ООО «Оренбургский завод металлоконструкций»	ОЗМК	5610127832	\N	3	1	\N	г. Оренбург	Производство металлических строительных конструкций	Быстровозводимые здания и металлоконструкции	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
67	ООО «Оренпласт»	Оренпласт	5610053179	\N	3	8	\N	г. Оренбург, ул. Локомотивная, д. 39	Производство изделий и конструкций из полимерных материалов	Пластиковые изделия и конструкции	http://www.orenplast.net/	+7 (3532) 52-58-40	\N	\N	\N	Действующее	\N	\N	f	f	\N
69	ООО «Оренбургский профметалл»	Оренбургский профметалл	5610212164	\N	3	1	\N	г. Оренбург, ул. Илекская, д. 132	Производство профилированного металлического проката и строительных металлоконструкций	Профлист, металлочерепица, металлосайдинг, сэндвич-панели	https://www.profmetall.ru/	+7 (3532) 99-24-24	profmetall96@mail.ru	\N	\N	Действующее	\N	\N	f	f	\N
71	ООО «Сладковско-Заречное»	Сладковско-Заречное	5611037405	\N	3	7	\N	г. Оренбург, ул. Комсомольская, д. 40	Геологоразведка и добыча нефти на месторождениях Оренбургской области	Нефть, газовый конденсат	https://www.sla-zar.ru/	+7 (3532) 43-22-01	info@sla-zar.ru	\N	\N	Действующее	\N	\N	f	f	\N
73	ООО «Технология»	Технология	5612028890	\N	3	3	\N	г. Оренбург, проспект Победы, д. 120	Проектирование и производство оборудования общемашиностроительного и нефтегазового назначения	Машиностроительное оборудование и комплектующие	https://tehno-oren.ru/	+7 (3532) 54-06-20	info@tehno-oren.ru	\N	\N	Действующее	\N	\N	f	f	\N
74	ООО «Газпром добыча Оренбург»	Газпром добыча Оренбург	5610058025	1025601028221	3	7	\N	г. Оренбург	Добыча газа, газового конденсата и эксплуатация газовых месторождений	Природный газ, газовый конденсат, углеводородное сырье	https://orenburg-dobycha.gazprom.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
76	ООО «Газпромнефть-Оренбург»	Газпромнефть-Оренбург	5610218014	1165658052450	3	7	\N	г. Оренбург, ул. Краснознаменная, д. 56/1	Разведка и добыча углеводородного сырья	Нефть и газ	https://www.gazprom-neft.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
78	Производственная компания «Ореана»	Ореана	5612038313	\N	3	8	\N	г. Оренбург, ул. Аксакова, д. 8	Швейное и текстильное производство	Школьная форма, одежда и текстильная продукция	https://oreana56.ru/	+7 (3532) 31-25-22	info@oreana56.ru	\N	\N	Действующее	\N	\N	f	f	\N
79	ООО «Научно-производственный центр «ВЕЛТ»	ВЕЛТ	5010039782	\N	3	2	\N	г. Оренбург, ул. Беляевская, д. 4/2	Разработка и производство дезинфицирующих, стерилизующих и антисептических средств	Дезинфицирующие средства, антисептики, репелленты и специализированная химическая продукция	https://velt-npo.ru/	+7 (3532) 50-80-30	officevelt@velt-npo.ru	\N	\N	Действующее	\N	\N	f	f	\N
80	ООО «Завод ПромСтройМаш»	ПромСтройМаш	5609076936	1105658012811	3	3	\N	г. Оренбург, ул. Терешковой, д. 287А	Проектирование и производство металлообрабатывающего и кузнечно-прессового оборудования	Гидравлические прессы, листогибочные и трубогибочные машины, металлорежущие станки	https://www.stanki-zavod.ru/	+7 (3532) 48-64-76	stanki-pcm@mail.ru	\N	\N	Действующее	\N	\N	f	f	\N
81	ООО «МиСТ»	МиСТ	5638060761	1125658016681	3	1	\N	г. Оренбург, Шарлыкское шоссе, д. 5	Производство микросетчатой, плетёной и вязаной промышленной продукции	Промышленные фильтры, металлические сетки и фильтрующие элементы	https://micromesh.ru/	+7 (3532) 43-91-55	info@mst56.ru	\N	\N	Действующее	\N	\N	f	f	\N
82	ООО «СтальКом»	СтальКом	5610213785	\N	3	3	\N	г. Оренбург, ул. Промышленная, д. 5/1	Разработка и производство промышленного и сельскохозяйственного оборудования	Дробильное оборудование, сельскохозяйственное оборудование, металлоизделия	https://s-k56.ru/	+7 (3532) 43-77-02	stal-kom@inbox.ru	\N	\N	Действующее	\N	\N	f	f	\N
83	ООО «Полимерстрой»	Полимерстрой	5611059769	\N	3	8	\N	г. Оренбург, ул. Юркина, д. 17	Производство трубопроводной продукции с теплоизоляционными и антикоррозионными покрытиями	Предизолированные трубы, соединительные детали, опоры и трубы с защитными покрытиями	https://polymerstroi.com/	+7 (3532) 45-05-56	info@polymerstroi.com	\N	\N	Действующее	\N	\N	f	f	\N
84	ООО «НПП «ЭНЕРГИЯ»	НПП ЭНЕРГИЯ	5611002434	\N	3	3	\N	г. Оренбург, ул. Авторемонтная, д. 17, стр. 1	Проектирование и производство оборудования для нефтегазовой, химической и энергетической промышленности	Шаровые краны, задвижки, клапаны, вентили, фитинги и нефтегазовое оборудование	https://nppenergy.com/	+7 (3532) 61-67-01	info@nppenergy.com	\N	\N	Действующее	\N	\N	f	f	\N
85	ООО НПП «ПневМакс»	ПневМакс	5611059889	\N	3	3	\N	г. Оренбург	Разработка и производство роботизированных комплексов и нестандартного промышленного оборудования	Роботизированные системы, упаковочное оборудование, оборудование для нефтегазовой промышленности	https://orenteh56.ru/	+7 (3532) 44-54-43	Techmasch@mail.ru	\N	\N	Действующее	\N	\N	f	f	\N
86	ПАО «Гидропресс»	Гидропресс	5611003815	\N	3	3	\N	г. Оренбург, пр. Братьев Коростелевых, д. 52	Проектирование и производство кузнечно-прессового оборудования	Гидравлические прессы, гидроагрегаты, цилиндры и специализированное промышленное оборудование	https://zavodgidropress.ru/	+7 (3532) 32-32-02	gidropress@gidropress-oren.ru	\N	\N	Действующее	\N	\N	f	f	\N
88	ООО «Инженерные Технологии»	Инженерные Технологии	5610232876	\N	3	3	\N	г. Оренбург, ул. Илекская, д. 1	Проектирование и производство технологического оборудования для нефтегазовой и химической промышленности	Трубопроводная и фонтанная арматура, электроприводы, нефтегазовое оборудование	https://e-t-a.org/	+7 (3532) 666-777	info@e-t-a.org	\N	\N	Действующее	\N	\N	f	f	\N
89	АО Завод железобетонных изделий «Степной»	ЖБИ Степной	5609031910	1025600884110	3	4	\N	г. Оренбург, ул. Техническая, д. 4	Производство бетона и железобетонных изделий для промышленного, дорожного и гражданского строительства	Железобетонные изделия, плиты, фундаментные блоки, товарный бетон	https://www.orenbeton.ru/	+7 (3532) 66-41-66	order@orenbeton.ru	\N	\N	Действующее	\N	\N	f	f	\N
1	АО «Уральская Сталь»	Уральская Сталь	5607019523	1055607061498	1	1	\N	\N	Металлургическое предприятие	Сталь, чугун, прокат и металлургическая продукция	\N	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
14	ПАО «Орскнефтеоргсинтез»	Орский НПЗ	5615002700	\N	2	2	\N	г. Орск, ул. Гончарова, д. 1А	Переработка нефти и производство нефтепродуктов	Автомобильные бензины, дизельное топливо, мазут, нефтепродукты	https://ornpz.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
87	АО «Оренбургский маслоэкстракционный завод»	ОМЭЗ	5611001455	\N	3	5	\N	г. Оренбург, ул. Орлова, д. 11	Переработка масличных культур и производство растительного масла	Подсолнечное масло, шрот, лузга	https://orenburgoil.ru/	+7 (3532) 38-13-58	omez-oren@mail.ru	\N	\N	Действующее	\N	\N	f	f	\N
11	АО «ОРМЕТ»	ОРМЕТ	5616006746	\N	2	7	\N	\N	Добыча и первичная переработка медных и медно-цинковых руд	Медная и медно-цинковая руда	https://or-met.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
19	ООО «СМК ОРСК»	Орский завод металлоконструкций	5614049014	\N	2	1	\N	г. Орск, ул. Металлистов, д. 5	Производство строительных металлоконструкций	Металлоконструкции и быстровозводимые здания	https://ozmk.ru/	\N	\N	\N	\N	Действующее	\N	\N	f	f	\N
\.


--
-- Data for Name: industries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.industries (id, name, description) FROM stdin;
1	Металлургия и металлообработка	Производство стали, чугуна, проката и металлических изделий
2	Химическая промышленность	Производство химических веществ и химической продукции
3	Машиностроение	Производство машин, оборудования и комплектующих
4	Производство строительных материалов	Цемент, бетон, строительные смеси и другая продукция
5	Пищевая промышленность	Производство продуктов питания и переработка сырья
6	Энергетика	Производство и распределение электрической и тепловой энергии
7	Добывающая промышленность	Добыча полезных ископаемых
8	Прочие отрасли	Другие направления промышленной деятельности
\.


--
-- Data for Name: investment_projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.investment_projects (id, name, city_id, enterprise_id, industry_id, status, start_year, end_year, investment_amount, jobs_created, description, source_id) FROM stdin;
\.


--
-- Data for Name: territory_metrics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.territory_metrics (id, city_id, year, population, average_salary, unemployment_rate, investments, industrial_output, employed_population, enterprises_count, industrial_enterprises_count, source_id) FROM stdin;
1	10	2024	45181	44628.50	0.80	1947780000.00	5135800000.00	\N	\N	\N	24
2	4	2024	\N	66276.90	\N	\N	\N	\N	\N	\N	191
3	6	2021	24300	\N	\N	\N	\N	\N	\N	\N	204
4	6	2022	23700	\N	\N	\N	\N	\N	\N	\N	204
5	6	2023	23400	\N	\N	\N	\N	\N	\N	\N	204
6	6	2024	23013	\N	\N	\N	\N	\N	\N	\N	205
7	6	2025	22723	\N	\N	\N	\N	\N	\N	\N	206
8	5	2021	86042	\N	\N	\N	\N	\N	\N	\N	231
9	5	2022	88250	\N	\N	\N	\N	\N	\N	\N	232
10	5	2023	88419	\N	\N	\N	\N	\N	\N	\N	232
11	5	2024	88300	\N	\N	\N	\N	\N	\N	\N	233
12	5	2025	88202	\N	\N	\N	\N	\N	\N	\N	234
13	1	2021	87590	46646.4	0.9	7868560000	187065210000	\N	\N	\N	362
14	1	2022	79950	52295.1	0.6	5523070000	192049570000	\N	\N	\N	362
15	1	2023	79400	62431.9	0.41	14619330000	208983130000	\N	\N	\N	362
16	1	2024	78871	74255.2	0.3	18227780000	194799010000	\N	\N	\N	362
17	1	2025	\N	85965.20	0.4	16317320000	146472650000	\N	\N	\N	362
18	2	2021	228682	38843.8	0.8	6478800000	44036500000	\N	\N	\N	363
19	2	2022	227131	44638.3	0.5	15024200000	62551700000	\N	\N	\N	363
20	2	2023	190980	55719.1	0.4	21964800000	82743200000	\N	\N	\N	363
21	2	2024	190318	74163.3	0.4	36290870000	105935100000	\N	\N	\N	363
22	2	2025	188136	89874.9	0.4	43802400000	134764700000	\N	\N	\N	363
23	3	2021	587408	48900	0.72	54336200000	250300000000	\N	\N	\N	364
24	3	2022	556373	55000	0.75	90200000000	361900000000	\N	\N	\N	364
25	3	2023	552831	61800	0.44	108300000000	388700000000	\N	\N	\N	364
26	3	2024	550344	69100	0.33	111400000000	420400000000	\N	\N	\N	364
27	3	2025	549947	78300	0.4	124400000000	355400000000	\N	\N	\N	364
\.


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cities_id_seq', 24, true);


--
-- Name: data_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.data_sources_id_seq', 369, true);


--
-- Name: enterprise_metrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprise_metrics_id_seq', 428, true);


--
-- Name: enterprise_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprise_products_id_seq', 111, true);


--
-- Name: enterprise_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprise_sources_id_seq', 260, true);


--
-- Name: enterprises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprises_id_seq', 174, true);


--
-- Name: industries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.industries_id_seq', 16, true);


--
-- Name: investment_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.investment_projects_id_seq', 4, true);


--
-- Name: territory_metrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.territory_metrics_id_seq', 27, true);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: data_sources data_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_sources
    ADD CONSTRAINT data_sources_pkey PRIMARY KEY (id);


--
-- Name: enterprise_metrics enterprise_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_metrics
    ADD CONSTRAINT enterprise_metrics_pkey PRIMARY KEY (id);


--
-- Name: enterprise_products enterprise_products_enterprise_id_product_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_products
    ADD CONSTRAINT enterprise_products_enterprise_id_product_name_key UNIQUE (enterprise_id, product_name);


--
-- Name: enterprise_products enterprise_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_products
    ADD CONSTRAINT enterprise_products_pkey PRIMARY KEY (id);


--
-- Name: enterprise_sources enterprise_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_sources
    ADD CONSTRAINT enterprise_sources_pkey PRIMARY KEY (id);


--
-- Name: enterprises enterprises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises
    ADD CONSTRAINT enterprises_pkey PRIMARY KEY (id);


--
-- Name: industries industries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.industries
    ADD CONSTRAINT industries_pkey PRIMARY KEY (id);


--
-- Name: investment_projects investment_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investment_projects
    ADD CONSTRAINT investment_projects_pkey PRIMARY KEY (id);


--
-- Name: territory_metrics territory_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.territory_metrics
    ADD CONSTRAINT territory_metrics_pkey PRIMARY KEY (id);


--
-- Name: enterprise_sources uq_enterprise_source; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_sources
    ADD CONSTRAINT uq_enterprise_source UNIQUE (enterprise_id, source_id);


--
-- Name: enterprise_metrics uq_enterprise_year; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_metrics
    ADD CONSTRAINT uq_enterprise_year UNIQUE (enterprise_id, year);


--
-- Name: idx_enterprise_metrics_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprise_metrics_year ON public.enterprise_metrics USING btree (year);


--
-- Name: idx_enterprise_products_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprise_products_category ON public.enterprise_products USING btree (product_category);


--
-- Name: idx_enterprise_products_enterprise; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprise_products_enterprise ON public.enterprise_products USING btree (enterprise_id);


--
-- Name: idx_enterprises_city; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprises_city ON public.enterprises USING btree (city_id);


--
-- Name: idx_enterprises_industry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprises_industry ON public.enterprises USING btree (industry_id);


--
-- Name: idx_enterprises_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprises_status ON public.enterprises USING btree (status);


--
-- Name: uq_enterprise_products_enterprise_product; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_enterprise_products_enterprise_product ON public.enterprise_products USING btree (enterprise_id, product_name);


--
-- Name: uq_territory_city_year; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_territory_city_year ON public.territory_metrics USING btree (city_id, year) WHERE (city_id IS NOT NULL);


--
-- Name: ux_industries_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_industries_name ON public.industries USING btree (name);


--
-- Name: enterprise_products enterprise_products_enterprise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_products
    ADD CONSTRAINT enterprise_products_enterprise_id_fkey FOREIGN KEY (enterprise_id) REFERENCES public.enterprises(id) ON DELETE CASCADE;


--
-- Name: enterprise_metrics fk_enterprise_metrics_source; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_metrics
    ADD CONSTRAINT fk_enterprise_metrics_source FOREIGN KEY (source_id) REFERENCES public.data_sources(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: enterprise_products fk_enterprise_products_source; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_products
    ADD CONSTRAINT fk_enterprise_products_source FOREIGN KEY (source_id) REFERENCES public.data_sources(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: enterprise_sources fk_enterprise_sources_enterprise; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_sources
    ADD CONSTRAINT fk_enterprise_sources_enterprise FOREIGN KEY (enterprise_id) REFERENCES public.enterprises(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enterprise_sources fk_enterprise_sources_source; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_sources
    ADD CONSTRAINT fk_enterprise_sources_source FOREIGN KEY (source_id) REFERENCES public.data_sources(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: enterprises fk_enterprises_city; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises
    ADD CONSTRAINT fk_enterprises_city FOREIGN KEY (city_id) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: enterprises fk_enterprises_industry; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises
    ADD CONSTRAINT fk_enterprises_industry FOREIGN KEY (industry_id) REFERENCES public.industries(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: enterprise_metrics fk_metrics_enterprise; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_metrics
    ADD CONSTRAINT fk_metrics_enterprise FOREIGN KEY (enterprise_id) REFERENCES public.enterprises(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investment_projects fk_project_city; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investment_projects
    ADD CONSTRAINT fk_project_city FOREIGN KEY (city_id) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: investment_projects fk_project_enterprise; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investment_projects
    ADD CONSTRAINT fk_project_enterprise FOREIGN KEY (enterprise_id) REFERENCES public.enterprises(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: investment_projects fk_project_industry; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investment_projects
    ADD CONSTRAINT fk_project_industry FOREIGN KEY (industry_id) REFERENCES public.industries(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: investment_projects fk_project_source; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investment_projects
    ADD CONSTRAINT fk_project_source FOREIGN KEY (source_id) REFERENCES public.data_sources(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: territory_metrics fk_territory_metrics_city; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.territory_metrics
    ADD CONSTRAINT fk_territory_metrics_city FOREIGN KEY (city_id) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_metrics fk_territory_metrics_source; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.territory_metrics
    ADD CONSTRAINT fk_territory_metrics_source FOREIGN KEY (source_id) REFERENCES public.data_sources(id) ON UPDATE CASCADE ON DELETE SET NULL;


CREATE TABLE public.parent_company_metrics (
    branch_id integer NOT NULL REFERENCES public.enterprises(id),
    parent_inn varchar(12) NOT NULL,
    year integer NOT NULL,
    revenue numeric,
    net_profit numeric,
    source_id integer REFERENCES public.data_sources(id),
    PRIMARY KEY (branch_id, year)
);

COMMENT ON TABLE public.parent_company_metrics IS 'Годовые показатели головной компании в рублях по всем подразделениям. Исключаются из городских итогов по филиалу.';

COPY public.parent_company_metrics (branch_id, parent_inn, year, revenue, net_profit, source_id) FROM stdin;
13	7708670326	2021	5510600000	278395000	283
13	7708670326	2022	7779300000	251183000	283
13	7708670326	2023	15844015000	776767000	283
13	7708670326	2024	13876622000	547922000	283
13	7708670326	2025	10807961000	546650000	283
22	7705845722	2021	13114663000	444518000	299
22	7705845722	2022	38064538000	2439740000	299
22	7705845722	2023	39365754000	2027420000	299
22	7705845722	2024	\N	\N	\N
22	7705845722	2025	\N	\N	\N
\.

--
-- PostgreSQL database dump complete
--

\unrestrict unbH1b4KFdZAMcvn3bsQqEoz2AOZUcM1PbSPNYVkgGacoteQpWd32oi0b366MYp



-- === PromRegion56 v2 upgrade ===
-- PromRegion56: расширение системы социально-экономических показателей.
-- PostgreSQL 18; совместимо с действующим дампом industrial_city_db.sql.
-- Порядок: восстановите оригинальный дамп в тестовую БД, затем выполните этот файл.
-- Скрипт НЕ удаляет и НЕ перезаписывает исходные таблицы и их значения.
-- НЕ добавляет вымышленные показатели: только справочник, таблицу измерений и
-- перенос уже существующих ненулевых значений со статусом «требует проверки».
-- Повторный запуск безопасен для импортированных записей: ON CONFLICT DO NOTHING.

BEGIN;

-- Тип записи важен: юридическое лицо, филиал и площадка не равнозначны.
ALTER TABLE public.enterprises
  ADD COLUMN IF NOT EXISTS entity_type varchar(30);
ALTER TABLE public.enterprises
  ADD COLUMN IF NOT EXISTS parent_enterprise_id integer;
COMMENT ON COLUMN public.enterprises.entity_type IS
  'Задать после проверки: legal_entity / branch / production_site / project';
COMMENT ON COLUMN public.enterprises.parent_enterprise_id IS
  'ID головной организации; заполнять только после проверки связей';

CREATE TABLE IF NOT EXISTS public.metric_catalog (
  code varchar(70) PRIMARY KEY,
  scope varchar(15) NOT NULL CHECK (scope IN ('enterprise','territory')),
  category varchar(100) NOT NULL,
  title varchar(255) NOT NULL,
  unit varchar(40) NOT NULL,
  priority smallint NOT NULL CHECK (priority BETWEEN 1 AND 3),
  definition text NOT NULL
);

INSERT INTO public.metric_catalog
  (code, scope, category, title, unit, priority, definition)
VALUES
  ('employees', 'enterprise', 'Труд и занятость', 'Численность работников (вид учета уточняется)', 'чел.', 1, 'После проверки уточнить: среднесписочная, средняя или численность на дату'),
  ('average_salary', 'enterprise', 'Труд и занятость', 'Среднемесячная начисленная заработная плата', 'руб./мес.', 1, 'Отделять опубликованное значение от расчетной оценки'),
  ('wage_fund', 'enterprise', 'Труд и занятость', 'Годовой фонд начисленной заработной платы', 'руб.', 2, 'Фонд оплаты труда за год'),
  ('new_jobs_actual', 'enterprise', 'Труд и занятость', 'Фактически созданные рабочие места', 'ед.', 2, 'Не смешивать с планом инвестиционного проекта'),
  ('vacancies', 'enterprise', 'Труд и занятость', 'Количество открытых вакансий', 'ед.', 3, 'Срез на конкретную дату; для годового показателя нужна методика'),
  ('staff_turnover_pct', 'enterprise', 'Труд и занятость', 'Текучесть кадров', '%', 3, 'При наличии официальной методики расчета'),
  ('training_employees', 'enterprise', 'Труд и занятость', 'Работники, прошедшие обучение', 'чел.', 3, 'Обучение и повышение квалификации за год'),
  ('occupational_accidents', 'enterprise', 'Труд и занятость', 'Несчастные случаи на производстве', 'случ.', 3, 'Только опубликованные и сопоставимые сведения'),
  ('social_spending', 'enterprise', 'Труд и занятость', 'Расходы на социальные программы', 'руб.', 3, 'Поддержка сотрудников и территории'),
  ('revenue', 'enterprise', 'Финансы', 'Выручка', 'руб.', 1, 'Обычно строка 2110 отчета о финансовых результатах'),
  ('net_profit', 'enterprise', 'Финансы', 'Чистая прибыль (убыток)', 'руб.', 1, 'Убыток хранится отрицательным значением'),
  ('assets', 'enterprise', 'Финансы', 'Активы всего', 'руб.', 1, 'Балансовая стоимость на конец года'),
  ('investments', 'enterprise', 'Инвестиции', 'Инвестиции в основной капитал', 'руб.', 1, 'Фактические инвестиции предприятия за год'),
  ('taxes_paid', 'enterprise', 'Финансы', 'Уплаченные налоги', 'руб.', 1, 'Уточнять состав налогов и методику источника'),
  ('cost_of_sales', 'enterprise', 'Финансы', 'Себестоимость продаж', 'руб.', 1, 'Строка 2120 отчета о финансовых результатах'),
  ('gross_profit', 'enterprise', 'Финансы', 'Валовая прибыль (убыток)', 'руб.', 2, 'Строка 2100 отчета о финансовых результатах'),
  ('operating_profit', 'enterprise', 'Финансы', 'Прибыль (убыток) от продаж', 'руб.', 1, 'Строка 2200 отчета о финансовых результатах'),
  ('profit_before_tax', 'enterprise', 'Финансы', 'Прибыль (убыток) до налогообложения', 'руб.', 2, 'Строка 2300 отчета о финансовых результатах'),
  ('equity', 'enterprise', 'Финансы', 'Капитал и резервы', 'руб.', 2, 'Раздел III бухгалтерского баланса'),
  ('liabilities', 'enterprise', 'Финансы', 'Обязательства всего', 'руб.', 2, 'Долгосрочные плюс краткосрочные обязательства'),
  ('accounts_receivable', 'enterprise', 'Финансы', 'Дебиторская задолженность', 'руб.', 2, 'Балансовый показатель на конец года'),
  ('accounts_payable', 'enterprise', 'Финансы', 'Кредиторская задолженность', 'руб.', 2, 'Балансовый показатель на конец года'),
  ('fixed_assets', 'enterprise', 'Финансы', 'Основные средства', 'руб.', 2, 'Балансовый показатель на конец года'),
  ('rnd_expenses', 'enterprise', 'Инвестиции', 'Затраты на исследования и разработки', 'руб.', 3, 'При наличии раскрытия'),
  ('production_volume', 'enterprise', 'Производство', 'Общий физический объем производства', 'ед. (уточнить)', 3, 'Не использовать без указания конкретной продукции и единицы измерения'),
  ('production_index_pct', 'enterprise', 'Производство', 'Индекс промышленного производства', '%', 2, 'В сопоставимых ценах к предыдущему году; при доступности для предприятия'),
  ('capacity_utilization_pct', 'enterprise', 'Производство', 'Загрузка производственных мощностей', '%', 2, 'В процентах к установленной мощности'),
  ('export_revenue', 'enterprise', 'Рынки сбыта', 'Экспортная выручка', 'руб.', 3, 'При опубликованных сведениях; учитывать курс и отчетный период'),
  ('environment_spending', 'enterprise', 'Экология', 'Затраты на охрану окружающей среды', 'руб.', 3, 'Расходы за год'),
  ('air_emissions', 'enterprise', 'Экология', 'Выбросы загрязняющих веществ в атмосферу', 'т/год', 3, 'При наличии открытых данных по площадке или организации'),
  ('waste_generated', 'enterprise', 'Экология', 'Образовано отходов', 'т/год', 3, 'Уточнять классы отходов и субъект отчетности'),
  ('water_use', 'enterprise', 'Экология', 'Использование воды', 'тыс. м³/год', 3, 'Уточнять границы учета и источник'),
  ('ghg_emissions', 'enterprise', 'Экология', 'Выбросы парниковых газов', 'т CO₂-экв./год', 3, 'При раскрытии сопоставимого углеродного учета'),
  ('population', 'territory', 'Демография', 'Численность населения', 'чел.', 1, 'Указывать дату измерения, обычно на 1 января'),
  ('average_salary_territory', 'territory', 'Доходы', 'Среднемесячная начисленная заработная плата', 'руб./мес.', 1, 'Указать охват организаций и методологию Росстата'),
  ('unemployment_rate', 'territory', 'Рынок труда', 'Уровень безработицы (методика не уточнена)', '%', 1, 'Для импортированных значений проверить вид безработицы'),
  ('registered_unemployment_rate', 'territory', 'Рынок труда', 'Уровень зарегистрированной безработицы', '%', 2, 'По данным службы занятости; не смешивать с методикой МОТ'),
  ('ilo_unemployment_rate', 'territory', 'Рынок труда', 'Уровень безработицы по методике МОТ', '%', 3, 'Только если показатель доступен на данном территориальном уровне'),
  ('investments_territory', 'territory', 'Инвестиции', 'Инвестиции в основной капитал территории', 'руб.', 1, 'Учитывать статистический охват и территориальные границы'),
  ('industrial_output', 'territory', 'Промышленность', 'Объем отгруженных товаров собственного производства', 'руб.', 1, 'Не приравнивать к сумме выручки организаций'),
  ('employed_population', 'territory', 'Рынок труда', 'Численность занятого населения', 'чел.', 2, 'По методике официальной статистики'),
  ('enterprises_count', 'territory', 'Бизнес', 'Количество организаций', 'ед.', 2, 'Сравнивать одинаковые критерии учета'),
  ('industrial_enterprises_count', 'territory', 'Промышленность', 'Количество промышленных организаций', 'ед.', 2, 'Классификация по ОКВЭД'),
  ('migration_balance', 'territory', 'Демография', 'Миграционный прирост (убыль)', 'чел.', 2, 'Прибывшие минус выбывшие за год'),
  ('births', 'territory', 'Демография', 'Число родившихся', 'чел.', 2, 'За отчетный год'),
  ('deaths', 'territory', 'Демография', 'Число умерших', 'чел.', 2, 'За отчетный год'),
  ('registered_unemployed', 'territory', 'Рынок труда', 'Зарегистрированные безработные', 'чел.', 2, 'Не смешивать с безработными по методике МОТ'),
  ('small_business_count', 'territory', 'Бизнес', 'Число субъектов МСП', 'ед.', 2, 'Структура МСП по реестру и статусам'),
  ('municipal_budget_revenue', 'territory', 'Бюджет', 'Доходы местного бюджета', 'руб.', 2, 'Исполнение местного бюджета'),
  ('municipal_budget_expenditure', 'territory', 'Бюджет', 'Расходы местного бюджета', 'руб.', 2, 'Исполнение местного бюджета'),
  ('housing_commissioned', 'territory', 'Качество жизни', 'Ввод жилья', 'м²', 2, 'Общая площадь введенного жилья'),
  ('retail_turnover', 'territory', 'Потребительский рынок', 'Оборот розничной торговли', 'руб.', 3, 'По доступной территориальной статистике'),
  ('hospital_beds', 'territory', 'Социальная инфраструктура', 'Число больничных коек', 'ед.', 3, 'Сравнивать по методике и доступности'),
  ('preschool_places', 'territory', 'Социальная инфраструктура', 'Места в дошкольных учреждениях', 'ед.', 3, 'Сопоставлять с численностью детей'),
  ('air_pollution', 'territory', 'Экология', 'Выбросы загрязняющих веществ на территории', 'т/год', 3, 'Суммарный территориальный показатель при наличии')

ON CONFLICT (code) DO NOTHING;

-- Универсальная таблица годовых показателей предприятия ИЛИ территории.
-- Отсутствие записи означает отсутствие значения, а НЕ ноль.
CREATE TABLE IF NOT EXISTS public.metric_values (
  id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  metric_code varchar(70) NOT NULL REFERENCES public.metric_catalog(code),
  enterprise_id integer REFERENCES public.enterprises(id) ON DELETE CASCADE,
  city_id integer REFERENCES public.cities(id) ON DELETE CASCADE,
  period_year smallint NOT NULL CHECK (period_year BETWEEN 1990 AND 2100),
  value_numeric numeric(30,4) NOT NULL,
  source_id integer REFERENCES public.data_sources(id) ON DELETE SET NULL,
  value_kind varchar(25) NOT NULL DEFAULT 'legacy_unclassified'
    CHECK (value_kind IN ('reported','calculated','estimated','legacy_unclassified')),
  verification_status varchar(20) NOT NULL DEFAULT 'pending'
    CHECK (verification_status IN ('pending','verified','rejected')),
  reporting_scope varchar(30) NOT NULL DEFAULT 'unknown'
    CHECK (reporting_scope IN ('unknown','legal_entity','branch','production_site','group','municipality')),
  precision_kind varchar(20) NOT NULL DEFAULT 'unknown'
    CHECK (precision_kind IN ('unknown','exact','rounded','approximate')),
  measurement_date date,
  source_detail text,
  note text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT metric_values_single_entity_chk CHECK (
    (enterprise_id IS NOT NULL AND city_id IS NULL)
    OR (enterprise_id IS NULL AND city_id IS NOT NULL)
  ),
  CONSTRAINT metric_values_verified_source_chk CHECK (
    verification_status <> 'verified' OR source_id IS NOT NULL
  )
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_metric_values_enterprise
  ON public.metric_values (enterprise_id, metric_code, period_year, reporting_scope)
  WHERE enterprise_id IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_metric_values_territory
  ON public.metric_values (city_id, metric_code, period_year, reporting_scope)
  WHERE city_id IS NOT NULL;
-- Дополнительные ссылки: одному числу могут соответствовать несколько документов.
CREATE TABLE IF NOT EXISTS public.metric_value_sources (
  metric_value_id bigint NOT NULL REFERENCES public.metric_values(id) ON DELETE CASCADE,
  source_id integer NOT NULL REFERENCES public.data_sources(id) ON DELETE CASCADE,
  source_role varchar(30) NOT NULL DEFAULT 'primary',
  section_or_page text,
  PRIMARY KEY (metric_value_id, source_id)
);

CREATE INDEX IF NOT EXISTS ix_metric_values_source ON public.metric_values(source_id);
CREATE INDEX IF NOT EXISTS ix_metric_values_code_year ON public.metric_values(metric_code, period_year);

-- Сохраняем ссылки на исходные записи: одни и те же источники могут подтверждать
-- разные показатели, но исходный дамп содержит только один source_id на всю строку.
-- Поэтому ВСЕ импортированные значения требуют отдельной проверки источника.
INSERT INTO public.metric_values (
  metric_code, enterprise_id, period_year, value_numeric, source_id,
  value_kind, verification_status, reporting_scope, precision_kind,
  source_detail, note
)
SELECT d.code, m.enterprise_id, m.year, v.val, m.source_id,
  'legacy_unclassified', 'pending', 'unknown', 'unknown',
  'Импорт из enterprise_metrics.id=' || m.id,
  'Методика, год источника, субъект учета и точность требуют сверки'
FROM public.enterprise_metrics m
CROSS JOIN LATERAL (VALUES
  ('employees', m.employees::numeric),
  ('revenue', m.revenue::numeric),
  ('investments', m.investments::numeric),
  ('average_salary', m.average_salary::numeric),
  ('net_profit', m.net_profit::numeric),
  ('assets', m.assets::numeric),
  ('taxes_paid', m.taxes_paid::numeric)
) AS v(code, val)
JOIN public.metric_catalog d ON d.code = v.code AND d.scope = 'enterprise'
WHERE v.val IS NOT NULL
ON CONFLICT DO NOTHING;

-- Старое поле production_volume не переносится: нет единицы измерения и продукта.
-- Оно в текущем дампе полностью пустое.

INSERT INTO public.metric_values (
  metric_code, city_id, period_year, value_numeric, source_id,
  value_kind, verification_status, reporting_scope, precision_kind,
  source_detail, note
)
SELECT d.code, tm.city_id, tm.year, v.val, tm.source_id,
  'legacy_unclassified', 'pending', 'municipality', 'unknown',
  'Импорт из territory_metrics.id=' || tm.id,
  'Проверить границы муниципалитета, методику и дату учета'
FROM public.territory_metrics tm
CROSS JOIN LATERAL (VALUES
  ('population', tm.population::numeric),
  ('average_salary_territory', tm.average_salary::numeric),
  ('unemployment_rate', tm.unemployment_rate::numeric),
  ('investments_territory', tm.investments::numeric),
  ('industrial_output', tm.industrial_output::numeric),
  ('employed_population', tm.employed_population::numeric),
  ('enterprises_count', tm.enterprises_count::numeric),
  ('industrial_enterprises_count', tm.industrial_enterprises_count::numeric)
) AS v(code, val)
JOIN public.metric_catalog d ON d.code = v.code AND d.scope = 'territory'
WHERE v.val IS NOT NULL AND tm.city_id IS NOT NULL
ON CONFLICT DO NOTHING;

-- Привязка первичного источника К КАЖДОМУ числу, а не ко всей строке года.
INSERT INTO public.metric_value_sources(metric_value_id, source_id, source_role)
SELECT mv.id, mv.source_id, 'primary'
FROM public.metric_values mv
WHERE mv.source_id IS NOT NULL
ON CONFLICT DO NOTHING;

-- Продукция измеряется по позиции и в конкретных единицах, а не одним numeric.
CREATE TABLE IF NOT EXISTS public.enterprise_product_output (
  id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  enterprise_product_id integer NOT NULL REFERENCES public.enterprise_products(id) ON DELETE CASCADE,
  period_year smallint NOT NULL CHECK (period_year BETWEEN 1990 AND 2100),
  quantity numeric(26,4) NOT NULL CHECK (quantity >= 0),
  unit varchar(40) NOT NULL CHECK (length(trim(unit)) > 0),
  source_id integer REFERENCES public.data_sources(id) ON DELETE SET NULL,
  verification_status varchar(20) NOT NULL DEFAULT 'pending'
    CHECK (verification_status IN ('pending','verified','rejected')),
  note text,
  CONSTRAINT product_output_verified_source_chk CHECK (
    verification_status <> 'verified' OR source_id IS NOT NULL
  ),
  UNIQUE (enterprise_product_id, period_year, unit)
);

-- Раздельно: фактические и плановые эффекты инвестиционного проекта.
ALTER TABLE public.investment_projects
  ADD COLUMN IF NOT EXISTS actual_jobs_created integer;
ALTER TABLE public.investment_projects
  ADD COLUMN IF NOT EXISTS actual_investment_amount numeric(20,2);
COMMENT ON COLUMN public.investment_projects.jobs_created IS
  'В исходной базе показатель может быть плановым; сверить по источнику';

-- Представление сравнимых динамик без подстановки пропущенных лет.
CREATE OR REPLACE VIEW public.v_enterprise_financial_dynamics AS
WITH year_values AS (
 SELECT e.id AS enterprise_id, e.name AS enterprise_name,
   mv.reporting_scope, mv.period_year,
   max(mv.value_numeric) FILTER (WHERE mv.metric_code = 'revenue') AS revenue,
   max(mv.value_numeric) FILTER (WHERE mv.metric_code = 'net_profit') AS net_profit,
   max(mv.value_numeric) FILTER (WHERE mv.metric_code = 'employees') AS employees
 FROM public.enterprises e
 JOIN public.metric_values mv ON mv.enterprise_id = e.id
   AND mv.verification_status <> 'rejected'
 GROUP BY e.id, e.name, mv.reporting_scope, mv.period_year
), previous_year AS (
 SELECT y.*,
   lag(period_year) OVER w AS previous_period_year,
   lag(revenue) OVER w AS previous_revenue
 FROM year_values y
 WINDOW w AS (PARTITION BY enterprise_id, reporting_scope ORDER BY period_year)
)
SELECT enterprise_id, enterprise_name, reporting_scope, period_year,
  revenue, net_profit, employees,
 CASE WHEN revenue > 0 AND net_profit IS NOT NULL
      THEN round(net_profit * 100.0 / revenue, 2) END AS net_margin_pct,
 CASE WHEN employees > 0 AND revenue IS NOT NULL
      THEN round(revenue / employees, 2) END AS revenue_per_employee_rub,
 CASE WHEN previous_period_year = period_year - 1 AND previous_revenue > 0
      AND revenue IS NOT NULL
      THEN round((revenue / previous_revenue - 1) * 100, 2) END AS revenue_yoy_pct
FROM previous_year;
-- ВНИМАНИЕ: представление не подтверждает достоверность значений.
-- Для интерфейса выводите verification_status из metric_values рядом с графиком.

COMMIT;

-- Контроль после выполнения:
-- SELECT scope, category, count(*) FROM public.metric_catalog GROUP BY 1,2 ORDER BY 1,2;
-- SELECT count(*) FROM public.metric_values;
-- SELECT * FROM public.v_enterprise_financial_dynamics WHERE enterprise_id = 171 ORDER BY period_year;


-- === Verified public facts ===
-- PromRegion56 v2: фактологическое расширение, версия 2026-11-15.
-- ВСЕ НОВЫЕ ЧИСЛА имеют действительную ссылку на источник и описание формы.
-- Величины из РСБУ в источниках выражены в тыс. руб.; здесь они умножены на 1000.
-- Незаполненные величины НЕ интерполируются и НЕ заменяются нулями.
-- Этот файл предназначен для выполнения ПОСЛЕ исходного дампа + metrics_extension.sql.
BEGIN;

INSERT INTO public.data_sources(id,name,url,source_type,publication_date,access_date,description) VALUES
(1001, 'АО «Уральская Сталь»: бухгалтерская отчетность 2024–2025, формы 1–2', 'https://fapvdo.ru/company-5607019523/', 'Воспроизведение опубликованной отчетности РСБУ', NULL, '2026-11-15', 'Показатели бухбаланса, выручка, себестоимость и финансовый результат в тыс. руб.; первичная публикация эмитента в источнике 1002'),
(1002, 'АО «Уральская Сталь»: официальный реестр годовой бухгалтерской отчетности за 2025 год', 'https://www.e-disclosure.ru/portal/files.aspx?id=7650&type=3', 'Официальное раскрытие эмитента', NULL, '2026-11-15', 'Публикация годового комплекта РСБУ 30.04.2026; используется как указатель первоисточника, численные строки проверены по источнику 1001'),
(1003, 'АО «Оренбургские минералы»: отчетность РСБУ 2025 (сопоставимые 2024 и баланс 2023)', 'https://www.audit-it.ru/buh_otchet/checkxml.php?inn=5618000027&token=b0a3f&year=2025', 'Републикация бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Баланс и финансовые результаты; единицы исходной таблицы — тыс. руб.'),
(1004, 'ООО «Оренбургский пропант»: бухгалтерская отчетность 2025/2024', 'https://e-ecolog.ru/buh/2025/5607142044', 'Републикация бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Отчет о финансовых результатах и баланс; единицы в тыс. руб.'),
(1005, 'АО «РИФАР»: бухгалтерская отчетность 2025', 'https://b2b.house/company/AO-RIFAR_f33bf5a7-2d83-4c39-8130-cedce506a278/financial-statements/', 'Републикация бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Финансовые строки за 2025 год; в заголовке страницы есть противоречие по активам — этот показатель не загружен'),
(1006, 'ООО «Сорочинский МЭЗ»: бухгалтерская отчетность 2025', 'https://companies.rbc.ru/id/1105658027012-ooo-sorochinskij-masloekstraktsionnyij-zavod/', 'Агрегатор бухгалтерской отчетности', NULL, '2026-11-15', 'Выручка, чистая прибыль, себестоимость и валовая прибыль за 2025 год'),
(1007, 'ПАО «Гайский ГОК»: бухгалтерская отчетность 2024', 'https://companies.rbc.ru/id/1025600682030-pao-gajskij-gorno-obogatitelnyij-kombinat/', 'Агрегатор бухгалтерской отчетности', NULL, '2026-11-15', 'РСБУ, выручка, чистая прибыль, себестоимость за 2024 год'),
(1008, 'ООО «Бузулукское молоко»: бухгалтерская отчетность 2025 и 2024', 'https://www.audit-it.ru/buh_otchet/checkxml.php?inn=5603017010&token=d8138&year=2025', 'Републикация бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Строки бухгалтерского баланса и финансовых результатов в тыс. руб.'),
(1009, 'Оренбургстат: муниципальные образования на 1 января 2025 года', 'https://56.rosstat.gov.ru/storage/document/document_statistic_collection/2025-07/21/%D0%9C%D1%83%D0%BD%D0%B8%D1%86%D0%B8%D0%BF%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BD%D0%B0%201%20%D1%8F%D0%BD%D0%B2%D0%B0%D1%80%D1%8F%202024%20%D0%B3%D0%BE%D0%B4%D0%B0.pdf', 'Официальная статистика Оренбургстата', NULL, '2026-11-15', 'Из таблицы Оренбургстата: численность населения муниципального образования и городского ядра отдельно; заголовок URL содержит устаревшее «2024», документ опубликован в 2025 г.'),
(1010, 'ООО «Оренбургский пропант»: ССЧ 2025', 'https://bazanpa.ru/contragent/5607142044/', 'Агрегатор реестровых сведений ФНС', NULL, '2026-11-15', 'Среднесписочная численность 1 412 человек за 2025 год; зарплата дана только округленно и не импортируется'),
(1011, 'АО «РИФАР»: ССЧ 2025', 'https://bazanpa.ru/contragent/5604009196/', 'Агрегатор реестровых сведений ФНС', NULL, '2026-11-15', 'Среднесписочная численность 876 человек за 2025 год'),
(1012, 'АО «РИФАР»: бухгалтерская отчетность 2024', 'https://companies.rbc.ru/id/1025600684240-ao-rifar/', 'Агрегатор бухгалтерской отчетности', NULL, '2026-11-15', '2024 РСБУ, выручка, чистая прибыль, себестоимость и валовая прибыль'),
(1013, 'ПАО «Гайский ГОК»: отчетность РСБУ 2025', 'https://cbonds.ru/news/3859357/', 'Финансовое СМИ / отчетность РСБУ', NULL, '2026-11-15', 'Убыток и активы указаны округлённо; в точный слой не включены'),
(1014, 'АО «Уральская Сталь»: сообщение об итогах РСБУ 2025', 'https://www.kommersant.ru/doc/8589417', 'Деловое СМИ / отчетность РСБУ', NULL, '2026-11-15', 'Независимое подтверждение факта убытка и падения выручки в 2025 г.'),
(1015, 'Оренбургстат: паспорт МО город Новотроицк 2024', 'https://rosstat.gov.ru/scripts/db_inet2/passport/table.aspx?opt=537200002024', 'Официальная статистика Росстата', NULL, '2026-11-15', 'Численность населения МО на 01.01.2024 — 79 410 человек'),
(1016, 'Оренбургстат: паспорт МО город Орск 2024', 'https://rosstat.gov.ru/scripts/db_inet2/passport/table.aspx?opt=537230002024', 'Официальная статистика Росстата', NULL, '2026-11-15', 'Численность населения МО на 01.01.2024 — 190 318 человек'),
(1017, 'ПАО «Орскнефтеоргсинтез»: отчетность РСБУ 2025/2024', 'https://www.audit-it.ru/buh_otchet/checkxml.php?inn=5615002700&token=a5c00&year=2025', 'Републикация бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Все основные строки отчета о финансовых результатах 2024/25 и бухгалтерский баланс 2023–2025; данные в тыс. руб.'),
(1018, 'ПАО «Орскнефтеоргсинтез»: первичное раскрытие РСБУ', 'https://www.e-disclosure.ru/portal/files.aspx?id=931&type=3', 'Официальное раскрытие эмитента', NULL, '2026-11-15', 'Размещена годовая отчетность за 2025 год 13.03.2026; использован как указатель на первичные документы'),
(1019, 'ООО «Газпром добыча Оренбург»: отчетность РСБУ 2025/2024', 'https://www.audit-it.ru/buh_otchet/checkxml.php?inn=5610058025&token=85c01&year=2025', 'Републикация бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Построчные финансовые результаты и баланс в тыс. руб. на 2025, 2024 и 2023 годы'),
(1020, 'ООО «СМК ОРСК»: финансовая отчетность ФНС 2021–2025', 'https://xfirm.ru/company/5614049014', 'Агрегатор бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Точная выручка 2023–2025, прибыль 2023–2024, уплаченные налоги 2025; прибыль 2025 противоречит b2b.house — исключена из сверенного набора'),
(1021, 'ООО «СМК ОРСК»: альтернативная отчетность 2025', 'https://b2b.house/company/OOO-SMK-ORSK_ca263574-7302-4f58-b849-afba794dc361/', 'Агрегатор бухгалтерской отчетности ФНС', NULL, '2026-11-15', 'Прибыль за 2025 год 103 158 000 руб. расходится с 129 248 000 руб. в источнике 1020. Цифра оставлена на перепроверку'),
(1022, 'АО «Новотроицкий трубопрокатный завод»: бухгалтерская отчетность 2025', 'https://companies.rbc.ru/id/1235600005486-nao-ao-ntpz/', 'Агрегатор отчетности ФНС', NULL, '2026-11-15', 'Выручка, себестоимость, валовой результат и чистый убыток за 2025 год'),
(1023, 'АО «Новотроицкий трубопрокатный завод»: отчетность 2023–2025', 'https://xfirm.ru/company/5607144789', 'Агрегатор отчетности ФНС', NULL, '2026-11-15', 'Контроль чистой прибыли 2025, выручка и чистая прибыль 2024, чистая прибыль 2023'),
(1024, 'АО «Новотроицкий цементный завод»: финансы 2025', 'https://b2b.house/company/AO-NCZ_ab8427ef-6671-403c-a8c4-6f19d3009fcf/', 'Агрегатор отчетности ФНС', NULL, '2026-11-15', 'Выручка и чистая прибыль 2025 года; не считать автоматически производственным выпуском'),
(1025, 'АО «Новотроицкий цементный завод»: финансовые итоги 2024', 'https://companies.rbc.ru/id/1025600820563-ao-novotroitskij-tsementnyij-zavod/', 'Агрегатор отчетности ФНС', NULL, '2026-11-15', 'Выручка, себестоимость, валовая прибыль, чистый убыток 2024 года; основной ОКВЭД юрлица — аренда недвижимости'),
(1026, 'АО «Новотроицкий завод хромовых соединений»: отчетность 2024', 'https://companies.rbc.ru/id/1025600820431-ao-novotroitskij-zavod-hromovyih-soedinenij/', 'Агрегатор отчетности ФНС', NULL, '2026-11-15', 'Выручка, себестоимость, валовая прибыль и чистая прибыль 2024 года')
ON CONFLICT (id) DO UPDATE SET name=EXCLUDED.name,url=EXCLUDED.url,source_type=EXCLUDED.source_type,access_date=EXCLUDED.access_date,description=EXCLUDED.description;

-- Сдвиг последовательности после вставки источников с явными ID 1001+.
-- Без этого будущая автоматическая вставка источников может столкнуться с занятыми ID.
SELECT pg_catalog.setval(pg_get_serial_sequence('public.data_sources','id'),
  (SELECT max(id) FROM public.data_sources),true);
UPDATE public.data_sources SET publication_date='2026-03-13' WHERE id=1018;
UPDATE public.data_sources SET publication_date='2025-07-21' WHERE id=1009;


-- Верифицированные значения муниципального населения; не смешивать с городом как населённым пунктом.
INSERT INTO public.metric_catalog(code,scope,category,title,unit,priority,definition)
VALUES ('population_city_core','territory','Демография','Численность городского населённого пункта','чел.',1,
  'Городское население (сам город), без сельских населенных пунктов муниципального образования, на 1 января отчетного года')
ON CONFLICT (code) DO NOTHING;

-- Существующие данные по Медногорску 2021–2025 относятся к городу, а не к муниципальному образованию.
UPDATE public.metric_values SET metric_code='population_city_core',
  note=coalesce(note,'') || ' | Переклассифицировано из population: городское население Медногорска; исходные числовые значения сохранены.'
WHERE city_id=6 AND metric_code='population' AND period_year BETWEEN 2021 AND 2025
  AND value_numeric IN (24300,23700,23400,23013,22723) AND verification_status='pending';

-- Данные юридических лиц: статус verified означает сверку с указанной веб-страницей,
-- НЕ независимую аудиторскую проверку оригинальных XBRL/XML или подписанных PDF.
INSERT INTO public.metric_values(
 metric_code,enterprise_id,period_year,value_numeric,source_id,
 value_kind,verification_status,reporting_scope,precision_kind,source_detail,note)
VALUES
('revenue', 1, 2025, 105454369000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 1, 2025, 96788205000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 1, 2025, 8666164000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 1, 2025, -11818162000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 1, 2025, -29264048000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 1, 2025, -22408878000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 1, 2025, 163048433000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 1, 2025, 23487354000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 1, 2025, 48137525000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 1, 2025, 49191069000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 1, 2025, 51963137000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 1, 2024, 153749457000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 1, 2024, 119852917000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 1, 2024, 33896540000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 1, 2024, 11172379000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 1, 2024, 5324629000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 1, 2024, 3407319000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 1, 2024, 155829966000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 1, 2024, 45896232000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 1, 2024, 40272998000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 1, 2024, 42101926000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 1, 2024, 21142975000, 1001, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1001; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 57, 2025, 8876726000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 57, 2025, 6165533000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 57, 2025, 2711193000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 57, 2025, 973195000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 57, 2025, 45251000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 57, 2025, 6754000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 57, 2025, 15085660000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 57, 2025, 12941788000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 57, 2025, 2390468000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 57, 2025, 7189695000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 57, 2025, 499040000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 57, 2024, 9128454000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 57, 2024, 6414436000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 57, 2024, 2714018000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 57, 2024, 901862000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 57, 2024, 802325000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 57, 2024, 625794000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 57, 2024, 15264192000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 57, 2024, 12935034000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 57, 2024, 2278235000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 57, 2024, 7977686000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 57, 2024, 497784000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 57, 2023, 14195286000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1600 отчетности', 'Балансовые значения на 31.12.2023 из сопоставимой колонки формы за 2025 г.'),
('equity', 57, 2023, 12309321000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1300 отчетности', 'Балансовые значения на 31.12.2023 из сопоставимой колонки формы за 2025 г.'),
('fixed_assets', 57, 2023, 2276141000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1150 отчетности', 'Балансовые значения на 31.12.2023 из сопоставимой колонки формы за 2025 г.'),
('accounts_receivable', 57, 2023, 4723836000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1230 отчетности', 'Балансовые значения на 31.12.2023 из сопоставимой колонки формы за 2025 г.'),
('accounts_payable', 57, 2023, 712683000, 1003, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1003; строка 1520 отчетности', 'Балансовые значения на 31.12.2023 из сопоставимой колонки формы за 2025 г.'),
('revenue', 9, 2025, 6775672000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 9, 2025, 5816015000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 9, 2025, 959657000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 9, 2025, 640533000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 9, 2025, -9173000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 9, 2025, -16271000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 9, 2025, 7239713000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 9, 2025, 449864000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 9, 2025, 3531598000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 9, 2025, 394501000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 9, 2024, 5789017000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 9, 2024, 5081573000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 9, 2024, 707444000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 9, 2024, 384160000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 9, 2024, -104485000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 9, 2024, -88542000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 9, 2024, 7262191000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 9, 2024, 466135000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 9, 2024, 3227166000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 9, 2024, 61064000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 9, 2023, 6465103000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1600 отчетности', 'Балансовая колонка 2023 в отчетности за 2025 год'),
('fixed_assets', 9, 2023, 3045167000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1150 отчетности', 'Балансовая колонка 2023 в отчетности за 2025 год'),
('accounts_receivable', 9, 2023, 110059000, 1004, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1004; строка 1230 отчетности', 'Балансовая колонка 2023 в отчетности за 2025 год'),
('revenue', 70, 2025, 6127359000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 2110 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('cost_of_sales', 70, 2025, 6510806000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 2120 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('gross_profit', 70, 2025, -383447000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 2100 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('operating_profit', 70, 2025, -1015259000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 2200 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('profit_before_tax', 70, 2025, -3203436000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 2300 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('net_profit', 70, 2025, -3385261000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 2400 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('equity', 70, 2025, 3426383000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 1300 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('fixed_assets', 70, 2025, 2279446000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 1150 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('accounts_receivable', 70, 2025, 1273308000, 1005, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1005; строка 1230 отчетности', 'Активы намеренно не импортированы: противоречивые значения в заголовке и таблице сайта'),
('revenue', 70, 2024, 7421967000, 1012, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1012; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 70, 2024, 5557080000, 1012, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1012; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 70, 2024, 1864887000, 1012, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1012; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 70, 2024, 1096997000, 1012, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1012; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 70, 2024, 8339449000, 1012, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1012; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 70, 2024, 6879853000, 1012, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1012; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 61, 2025, 27586658000, 1006, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1006; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 61, 2025, 24587706000, 1006, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1006; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 61, 2025, 2998952000, 1006, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1006; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 61, 2025, 262119000, 1006, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1006; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 53, 2024, 44013349000, 1007, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1007; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 53, 2024, 33607638000, 1007, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1007; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 53, 2024, 10405711000, 1007, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1007; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 53, 2024, 400402000, 1007, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1007; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 53, 2024, 62307309000, 1007, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1007; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 53, 2024, 38550718000, 1007, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1007; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 171, 2025, 2353458000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 171, 2025, 1874312000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 171, 2025, 479146000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 171, 2025, 193413000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 171, 2025, 129168000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 171, 2025, 91330000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 171, 2025, 659499000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 171, 2025, 392781000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 171, 2025, 257223000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 171, 2025, 23491000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 171, 2025, 105381000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 171, 2024, 2016194000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 171, 2024, 1589431000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 171, 2024, 426763000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 171, 2024, 186431000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 171, 2024, 139662000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 171, 2024, 110736000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 171, 2024, 482470000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 171, 2024, 350275000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 171, 2024, 295680000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 171, 2024, 95524000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 171, 2023, 520226000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1600 отчетности', 'Балансовая колонка 2023 из опубликованной отчетности за 2025 год'),
('equity', 171, 2023, 270563000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1300 отчетности', 'Балансовая колонка 2023 из опубликованной отчетности за 2025 год'),
('fixed_assets', 171, 2023, 285628000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1150 отчетности', 'Балансовая колонка 2023 из опубликованной отчетности за 2025 год'),
('accounts_payable', 171, 2023, 117338000, 1008, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1008; строка 1520 отчетности', 'Балансовая колонка 2023 из опубликованной отчетности за 2025 год'),
('revenue', 14, 2025, 30484883000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 14, 2025, 17395610000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 14, 2025, 13089273000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 14, 2025, 10636794000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 14, 2025, 25122148000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 14, 2025, 18812706000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 14, 2025, 187877964000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 14, 2025, 26205674000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 14, 2025, 131536553000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 14, 2025, 20882517000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 14, 2025, 5437341000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 14, 2024, 24176919000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 14, 2024, 15442834000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 14, 2024, 8734085000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 14, 2024, 6126404000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 14, 2024, -9864128000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 14, 2024, -5527405000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 14, 2024, 165518621000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 14, 2024, 7392968000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 14, 2024, 103657937000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 14, 2024, 20340150000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 14, 2024, 4988075000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 14, 2023, 139261728000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1600 отчетности', 'Сопоставимый баланс на 31.12.2023 из отчетности за 2025 г.'),
('equity', 14, 2023, 8937777000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1300 отчетности', 'Сопоставимый баланс на 31.12.2023 из отчетности за 2025 г.'),
('fixed_assets', 14, 2023, 81657695000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1150 отчетности', 'Сопоставимый баланс на 31.12.2023 из отчетности за 2025 г.'),
('accounts_receivable', 14, 2023, 26260027000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1230 отчетности', 'Сопоставимый баланс на 31.12.2023 из отчетности за 2025 г.'),
('accounts_payable', 14, 2023, 5412845000, 1017, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1017; строка 1520 отчетности', 'Сопоставимый баланс на 31.12.2023 из отчетности за 2025 г.'),
('revenue', 74, 2025, 111247373000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 74, 2025, 97746437000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 74, 2025, 13500936000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 74, 2025, 8002313000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 74, 2025, 2401681000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 74, 2025, 1106769000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 74, 2025, 89904329000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 74, 2025, 74052444000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 74, 2025, 15822751000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 74, 2025, 11447489000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 74, 2025, 11260068000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 74, 2024, 142851034000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 74, 2024, 115035864000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 74, 2024, 27815170000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('operating_profit', 74, 2024, 22350255000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2200 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('profit_before_tax', 74, 2024, 23949434000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 74, 2024, 18205712000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 74, 2024, 99931836000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1600 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('equity', 74, 2024, 79685675000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1300 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('fixed_assets', 74, 2024, 17248945000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1150 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_receivable', 74, 2024, 24621414000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1230 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('accounts_payable', 74, 2024, 15691322000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1520 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('assets', 74, 2023, 80856242000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1600 отчетности', 'Балансовые значения на 31.12.2023 в сопоставимой колонке отчета 2025'),
('equity', 74, 2023, 61479963000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1300 отчетности', 'Балансовые значения на 31.12.2023 в сопоставимой колонке отчета 2025'),
('fixed_assets', 74, 2023, 18017866000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1150 отчетности', 'Балансовые значения на 31.12.2023 в сопоставимой колонке отчета 2025'),
('accounts_receivable', 74, 2023, 19044593000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1230 отчетности', 'Балансовые значения на 31.12.2023 в сопоставимой колонке отчета 2025'),
('accounts_payable', 74, 2023, 15695699000, 1019, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1019; строка 1520 отчетности', 'Балансовые значения на 31.12.2023 в сопоставимой колонке отчета 2025'),
('revenue', 19, 2025, 6178354000, 1020, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1020; строка 2110 отчетности', 'Точная выручка ФНС; прибыль 2025 не добавлена из-за расхождения двух агрегаторов'),
('revenue', 19, 2024, 2947832000, 1020, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1020; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 19, 2024, -147569000, 1020, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1020; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 19, 2023, 2797202000, 1020, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1020; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 19, 2023, 38156000, 1020, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1020; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('taxes_paid', 19, 2025, 165648963.09, 1020, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1020; уплаченные налоги по ФНС, без страховых взносов', 'ФНС: уплаченные налоги без страховых взносов, точная сумма с копейками'),
('taxes_paid', 19, 2024, 104066724.12, 1020, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1020; уплаченные налоги по ФНС, без страховых взносов', 'ФНС: уплаченные налоги без страховых взносов, точная сумма с копейками'),
('revenue', 41, 2025, 854627000, 1022, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1022; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 41, 2025, 968105000, 1022, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1022; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 41, 2025, -113478000, 1022, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1022; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 41, 2025, -869766000, 1022, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1022; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 41, 2024, 112969000, 1023, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1023; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 41, 2024, -265840000, 1023, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1023; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 41, 2023, -3391000, 1023, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1023; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 6, 2025, 379426000, 1024, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1024; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 6, 2025, 19834000, 1024, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1024; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 6, 2024, 346428000, 1025, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1025; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 6, 2024, 221868000, 1025, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1025; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 6, 2024, 124560000, 1025, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1025; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 6, 2024, -15423000, 1025, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1025; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('revenue', 7, 2024, 10673929000, 1026, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1026; строка 2110 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('cost_of_sales', 7, 2024, 8537730000, 1026, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1026; строка 2120 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('gross_profit', 7, 2024, 2136199000, 1026, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1026; строка 2100 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('net_profit', 7, 2024, 625792000, 1026, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1026; строка 2400 отчетности', 'Сверено с открытой страницей источника; для юридически значимого использования проверить оригинал ФНС/эмитента.'),
('employees', 9, 2025, 1412, 1010, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1010; среднесписочная численность', 'Среднесписочная численность работников, 2025'),
('employees', 70, 2025, 876, 1011, 'reported', 'verified', 'legal_entity', 'exact', 'Источник 1011; среднесписочная численность', 'Среднесписочная численность работников, 2025')
ON CONFLICT (enterprise_id,metric_code,period_year,reporting_scope)
  WHERE enterprise_id IS NOT NULL
DO UPDATE SET value_numeric=EXCLUDED.value_numeric, source_id=EXCLUDED.source_id,
 value_kind=EXCLUDED.value_kind,verification_status=EXCLUDED.verification_status,
 precision_kind=EXCLUDED.precision_kind,source_detail=EXCLUDED.source_detail,
 note=EXCLUDED.note,updated_at=now();

-- Источник на каждый подтвержденный показатель (независимо от старого source_id в строке).
INSERT INTO public.metric_value_sources(metric_value_id,source_id,source_role,section_or_page)
SELECT id,source_id,'primary',source_detail
FROM public.metric_values
WHERE verification_status='verified' AND source_id BETWEEN 1001 AND 1026
ON CONFLICT(metric_value_id,source_id) DO NOTHING;

INSERT INTO public.metric_values(metric_code,city_id,period_year,value_numeric,source_id,
 value_kind,verification_status,reporting_scope,precision_kind,measurement_date,source_detail,note)
VALUES
('population', 3, 2025, 549947, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 14, 2025, 42104, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 5, 2025, 88202, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 6, 2025, 23803, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 1, 2025, 78871, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 2, 2025, 188136, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 24, 2025, 23003, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 4, 2025, 38570, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 12, 2025, 39719, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 10, 2025, 44644, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 9, 2025, 39392, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование'),
('population', 8, 2025, 17511, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Муниципальное образование')
ON CONFLICT (city_id,metric_code,period_year,reporting_scope)
 WHERE city_id IS NOT NULL
DO UPDATE SET value_numeric=EXCLUDED.value_numeric,source_id=EXCLUDED.source_id,
 verification_status=EXCLUDED.verification_status,value_kind=EXCLUDED.value_kind,
 precision_kind=EXCLUDED.precision_kind,measurement_date=EXCLUDED.measurement_date,
 source_detail=EXCLUDED.source_detail,note=EXCLUDED.note,updated_at=now();

INSERT INTO public.metric_values(metric_code,city_id,period_year,value_numeric,source_id,
 value_kind,verification_status,reporting_scope,precision_kind,measurement_date,source_detail,note)
VALUES
('population_city_core', 3, 2025, 536515, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 14, 2025, 41792, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 5, 2025, 88202, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 6, 2025, 22723, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 1, 2025, 73994, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 2, 2025, 185362, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 24, 2025, 16719, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 4, 2025, 32105, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 12, 2025, 26133, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 10, 2025, 25228, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 9, 2025, 27686, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)'),
('population_city_core', 8, 2025, 15241, 1009, 'reported', 'verified', 'municipality', 'exact', '2025-01-01', 'Таблица Оренбургстата, 1 января 2025 г.', 'Население городского ядра (не весь муниципальный округ)')
ON CONFLICT (city_id,metric_code,period_year,reporting_scope)
 WHERE city_id IS NOT NULL
DO UPDATE SET value_numeric=EXCLUDED.value_numeric,source_id=EXCLUDED.source_id,
 verification_status=EXCLUDED.verification_status,value_kind=EXCLUDED.value_kind,
 precision_kind=EXCLUDED.precision_kind,measurement_date=EXCLUDED.measurement_date,
 source_detail=EXCLUDED.source_detail,note=EXCLUDED.note,updated_at=now();

INSERT INTO public.metric_values(metric_code,city_id,period_year,value_numeric,source_id,
 value_kind,verification_status,reporting_scope,precision_kind,measurement_date,source_detail)
VALUES
('population', 1, 2024, 79410, 1015, 'reported', 'verified', 'municipality', 'exact', '2024-01-01', 'БД показателей муниципальных образований (Росстат), 01.01.2024'),
('population', 2, 2024, 190318, 1016, 'reported', 'verified', 'municipality', 'exact', '2024-01-01', 'БД показателей муниципальных образований (Росстат), 01.01.2024')
ON CONFLICT (city_id,metric_code,period_year,reporting_scope)
 WHERE city_id IS NOT NULL
DO UPDATE SET value_numeric=EXCLUDED.value_numeric,source_id=EXCLUDED.source_id,
 verification_status=EXCLUDED.verification_status,value_kind=EXCLUDED.value_kind,
 precision_kind=EXCLUDED.precision_kind,measurement_date=EXCLUDED.measurement_date,source_detail=EXCLUDED.source_detail,updated_at=now();

INSERT INTO public.metric_value_sources(metric_value_id,source_id,source_role,section_or_page)
SELECT id,source_id,'primary',source_detail FROM public.metric_values
WHERE verification_status='verified' AND source_id IN (1009,1015,1016)
ON CONFLICT(metric_value_id,source_id) DO NOTHING;

-- Исправление одного явно округленного значения в СТАРОЙ таблице для совместимости старых экранов.
-- Другие финансовые показатели синхронизированы с проверенными отчетами, если row уже существует.
-- Старый m.source_id НЕ используется в новом UI: он относится к строке целиком.
-- Для новых данных правильный source_id всегда берется из metric_values.
UPDATE public.enterprise_metrics m
SET revenue=v.value_numeric
FROM public.metric_values v
WHERE m.enterprise_id=v.enterprise_id AND m.year=v.period_year AND v.metric_code='revenue'
 AND v.reporting_scope='legal_entity' AND v.verification_status='verified';
UPDATE public.enterprise_metrics m
SET net_profit=v.value_numeric
FROM public.metric_values v
WHERE m.enterprise_id=v.enterprise_id AND m.year=v.period_year AND v.metric_code='net_profit'
 AND v.reporting_scope='legal_entity' AND v.verification_status='verified';
UPDATE public.enterprise_metrics m
SET assets=v.value_numeric
FROM public.metric_values v
WHERE m.enterprise_id=v.enterprise_id AND m.year=v.period_year AND v.metric_code='assets'
 AND v.reporting_scope='legal_entity' AND v.verification_status='verified';

-- Новые вакансии/социальные/экологические и инвестиционные величины не заполняются без документов.
-- Сравнение по отрасли должно исключать филиалы и учитывать разные отчетные охваты.

-- Журнал качества: требования к ручному разбору перед публичным выводом.
CREATE TABLE IF NOT EXISTS public.data_quality_issues (
  id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  issue_key text NOT NULL UNIQUE,
  enterprise_id integer REFERENCES public.enterprises(id) ON DELETE SET NULL,
  city_id integer REFERENCES public.cities(id) ON DELETE SET NULL,
  metric_code varchar(70) REFERENCES public.metric_catalog(code) ON DELETE SET NULL,
  period_year integer,
  severity varchar(12) NOT NULL CHECK (severity IN ('low','medium','high')),
  issue_type varchar(50) NOT NULL,
  description text NOT NULL,
  source_id integer REFERENCES public.data_sources(id) ON DELETE SET NULL,
  resolution_status varchar(20) NOT NULL DEFAULT 'open' CHECK (resolution_status IN ('open','investigating','resolved','ignored')),
  created_at timestamptz NOT NULL DEFAULT now()
);

INSERT INTO public.data_quality_issues(issue_key,enterprise_id,city_id,metric_code,period_year,severity,issue_type,description,source_id)
VALUES
('possible_duplicate_metalex', 5, NULL, NULL, NULL, 'high', 'duplicate', '«Металекс» (ID 5) и «МЕТАЛЕКС» (ID 43): проверить ИНН/ОГРН до объединения; автоматически НЕ объединялись.', NULL),
('uralstal_2021_scope', 1, NULL, 'revenue', 2021, 'high', 'source_conflict', 'Выручка 2021 в исходной БД 142,4 млрд ₽ по источнику 157; на стороннем финансовом сайте встречается другое значение. Проверить идентичность отчетного периметра (РСБУ/группа).', 1001),
('rifar_2025_assets_dispute', 70, NULL, 'assets', 2025, 'high', 'conflicting_source', 'Источник 1005 содержит противоречивые суммы активов в текстовом описании и подробной таблице. Активы 2025 в новую сверенную выборку НЕ внесены.', 1005),
('mednogorsk_population_scope', NULL, 6, 'population', 2025, 'high', 'territory_scope', 'В старой БД 22 723 — население города; в муниципальном округе Медногорск 23 803. В v2 хранятся отдельно.', 1009),
('legal_entity_site_mixing', 50, NULL, NULL, NULL, 'high', 'entity_scope', 'Оренбургский ГПЗ и гелиевый завод — производственные площадки, не отдельные юрлица. Не суммировать их бухгалтерские показатели с ООО «Газпром переработка».', NULL),
('cement_legal_entity_activity', 6, NULL, NULL, NULL, 'high', 'entity_scope', 'АО «НЦЗ»: основной ОКВЭД юрлица по источнику 1025 — аренда недвижимости. Нельзя трактовать всю отчетную выручку юрлица как стоимость выпущенного цемента.', 1025),
('smk_2025_profit_conflict', 19, NULL, 'net_profit', 2025, 'high', 'conflicting_source', 'Два агрегатора данных ФНС расходятся по чистой прибыли ООО «СМК ОРСК» за 2025 год: 129 248 000 ₽ и 103 158 000 ₽. Значение НЕ импортировано, нужна сверка с оригиналом ГИР БО.', 1020),
('historical_wrong_year_sources', NULL, NULL, NULL, NULL, 'medium', 'provenance', 'В legacy enterprise_metrics имеются строки, в которых один источник относится к следующему отчетному году или ко всей карточке, а не к конкретной цифре. Все legacy-импорты помечены pending.', NULL),
('unverified_environment', NULL, NULL, 'air_emissions', NULL, 'medium', 'missing_data', 'Открытых достоверных значений выбросов по каждой площадке в данных нет; нельзя подставлять показатель региона или ноль.', NULL)
ON CONFLICT(issue_key) DO NOTHING;

-- История загрузки: позволяет объяснить, что обновлялось, не притворяясь, что все 174 компании проверены.
CREATE TABLE IF NOT EXISTS public.dataset_releases(
 release_code text PRIMARY KEY,
 release_date date NOT NULL,
 description text NOT NULL,
 verified_fact_rows integer NOT NULL,
 official_municipal_rows integer NOT NULL,
 source_count_new integer NOT NULL,
 imported_legacy_verified boolean NOT NULL DEFAULT false
);
INSERT INTO public.dataset_releases VALUES
 ('v2-2026-11-15','2026-11-15',
 'Исходный каталог + схема 55 показателей + новые сверенные финансовые и муниципальные факты; исходные показатели отдельно pending',
 202,26,26,false)
ON CONFLICT(release_code) DO UPDATE SET description=EXCLUDED.description,
 verified_fact_rows=EXCLUDED.verified_fact_rows,official_municipal_rows=EXCLUDED.official_municipal_rows,
 source_count_new=EXCLUDED.source_count_new;

-- Новое представление: по одному лучшему значению на показатель, предприятие и год.
-- Условие сортировки: проверенные опубликованные значения впереди устаревших legacy.
CREATE OR REPLACE VIEW public.v2_best_enterprise_metrics AS
SELECT e.id AS enterprise_id,e.name AS enterprise_name,c.name AS city_name,
       mv.metric_code,cat.category,cat.title,cat.unit,mv.period_year,mv.value_numeric,
       mv.verification_status,mv.value_kind,mv.reporting_scope,mv.precision_kind,
       mv.source_id,s.name AS source_name,s.url AS source_url,
       mv.source_detail,mv.note
FROM public.enterprises e
JOIN public.cities c ON c.id=e.city_id
JOIN LATERAL (
 SELECT *, row_number() OVER (PARTITION BY metric_code,period_year ORDER BY
    CASE verification_status WHEN 'verified' THEN 0 WHEN 'pending' THEN 1 ELSE 2 END,
    CASE reporting_scope WHEN 'legal_entity' THEN 0 WHEN 'production_site' THEN 1 ELSE 2 END,
    CASE precision_kind WHEN 'exact' THEN 0 WHEN 'rounded' THEN 1 ELSE 2 END,
    updated_at DESC, id DESC) AS preference_rank
 FROM public.metric_values v WHERE v.enterprise_id=e.id AND v.verification_status<>'rejected'
) mv ON mv.preference_rank=1
JOIN public.metric_catalog cat ON cat.code=mv.metric_code
LEFT JOIN public.data_sources s ON s.id=mv.source_id;

CREATE OR REPLACE VIEW public.v2_verified_metric_points AS
SELECT * FROM public.v2_best_enterprise_metrics
WHERE verification_status='verified';

CREATE OR REPLACE VIEW public.v2_enterprise_financial_dashboard AS
SELECT enterprise_id, enterprise_name, city_name,period_year,
 max(value_numeric) FILTER(WHERE metric_code='revenue') AS revenue_rub,
 max(value_numeric) FILTER(WHERE metric_code='net_profit') AS net_profit_rub,
 max(value_numeric) FILTER(WHERE metric_code='cost_of_sales') AS cost_of_sales_rub,
 max(value_numeric) FILTER(WHERE metric_code='operating_profit') AS operating_profit_rub,
 max(value_numeric) FILTER(WHERE metric_code='assets') AS assets_rub,
 max(value_numeric) FILTER(WHERE metric_code='employees') AS employees,
 CASE WHEN max(value_numeric) FILTER(WHERE metric_code='revenue')>0
   AND max(value_numeric) FILTER(WHERE metric_code='net_profit') IS NOT NULL
  THEN round(100*max(value_numeric) FILTER(WHERE metric_code='net_profit') /
          nullif(max(value_numeric) FILTER(WHERE metric_code='revenue'),0),2) END AS net_margin_pct,
 CASE WHEN max(value_numeric) FILTER(WHERE metric_code='employees')>0
   AND max(value_numeric) FILTER(WHERE metric_code='revenue') IS NOT NULL
  THEN round(max(value_numeric) FILTER(WHERE metric_code='revenue') /
          nullif(max(value_numeric) FILTER(WHERE metric_code='employees'),0),2) END AS revenue_per_employee_rub
FROM public.v2_verified_metric_points
GROUP BY enterprise_id,enterprise_name,city_name,period_year;

CREATE OR REPLACE VIEW public.v2_territory_dashboard AS
SELECT c.id AS city_id,c.name AS center_name,v.period_year,
  max(v.value_numeric) FILTER(WHERE v.metric_code='population') AS municipal_population,
  max(v.value_numeric) FILTER(WHERE v.metric_code='population_city_core') AS urban_core_population,
  max(v.value_numeric) FILTER(WHERE v.metric_code='average_salary_territory') AS avg_salary_rub,
  max(v.value_numeric) FILTER(WHERE v.metric_code='industrial_output') AS industrial_output_rub,
  max(v.value_numeric) FILTER(WHERE v.metric_code='investments_territory') AS investments_rub
FROM public.cities c JOIN public.metric_values v ON v.city_id=c.id
WHERE v.reporting_scope='municipality' AND v.verification_status='verified'
GROUP BY c.id,c.name,v.period_year;

CREATE OR REPLACE VIEW public.v2_metric_coverage AS
SELECT c.scope, c.category, c.title, c.unit,
 count(v.id) FILTER(WHERE v.verification_status='verified') AS verified_points,
 count(v.id) FILTER(WHERE v.verification_status='pending') AS points_pending,
 count(DISTINCT v.enterprise_id) FILTER(WHERE v.verification_status='verified') AS enterprises_verified,
 count(DISTINCT v.city_id) FILTER(WHERE v.verification_status='verified') AS territories_verified
FROM public.metric_catalog c LEFT JOIN public.metric_values v ON v.metric_code=c.code
GROUP BY c.code,c.scope,c.category,c.title,c.unit;

CREATE OR REPLACE VIEW public.v2_sources_explorer AS
SELECT ds.id,ds.name,ds.url,ds.source_type,ds.publication_date,ds.access_date,
  count(DISTINCT mv.id) AS metric_values_count,
  count(DISTINCT mv.enterprise_id) AS enterprises_count,
  count(DISTINCT mv.city_id) AS territories_count
FROM public.data_sources ds
LEFT JOIN public.metric_values mv ON mv.source_id=ds.id
GROUP BY ds.id,ds.name,ds.url,ds.source_type,ds.publication_date,ds.access_date;

COMMIT;

-- Срезы для новой ИС:
-- SELECT * FROM public.v2_enterprise_financial_dashboard WHERE enterprise_id = 1 ORDER BY period_year DESC;
-- SELECT * FROM public.v2_best_enterprise_metrics WHERE enterprise_id = 9 ORDER BY period_year DESC, category;
-- SELECT * FROM public.v2_territory_dashboard WHERE period_year = 2025 ORDER BY municipal_population DESC;
-- SELECT * FROM public.v2_metric_coverage ORDER BY verified_points DESC;
-- SELECT * FROM public.v2_sources_explorer ORDER BY metric_values_count DESC;
-- SELECT * FROM public.data_quality_issues WHERE resolution_status='open';

-- PromRegion56 v3: verified-first Novotroitsk expansion, then Orsk starter set.
-- APPLY AFTER promregion56_v2_full.sql; non-destructive; intended for PostgreSQL 18.
-- Sources marked "secondary" reproduce open government financial data; verify primary signed files before formal publication.
BEGIN;
CREATE TABLE IF NOT EXISTS public.enterprise_research_status (
 enterprise_id integer PRIMARY KEY REFERENCES public.enterprises(id) ON DELETE CASCADE,
 priority_order smallint NOT NULL, identification_status varchar(30) NOT NULL DEFAULT 'unreviewed',
 evidence_level varchar(40) NOT NULL DEFAULT 'legacy_only',
 identity_source_id integer REFERENCES public.data_sources(id),
 duplicate_candidate_id integer REFERENCES public.enterprises(id),
 review_note text, reviewed_at date,
 last_checked_at date);
INSERT INTO public.enterprise_research_status(enterprise_id,priority_order,identification_status,evidence_level,review_note)
SELECT e.id, CASE WHEN e.city_id=1 THEN 1 ELSE 2 END,'unreviewed','legacy_only',
CASE WHEN e.city_id=1 THEN 'Новотроицк: первоочередная ручная сверка юридического лица и отчетности' ELSE 'Остальная Оренбургская область: следующий этап; данные из v2 сохранены' END
FROM public.enterprises e ON CONFLICT (enterprise_id) DO NOTHING;
INSERT INTO public.data_sources(id,name,url,source_type,publication_date,access_date,description) VALUES
(1101,'ООО «Новотроицкий содовый завод», РБК Компании, результаты 2025','https://companies.rbc.ru/id/1185658000637-ooo-novotroitskij-sodovyij-zavod/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 2110, 2120, 2100, 2400, сопоставимая 2024 выручка'),
(1102,'ООО «Новотроицкий содовый завод», официальный сайт','https://nspltd.ru/company/','Официальный сайт предприятия',NULL,'2026-11-15','Реальное производство с 2019 года, введённые линии и продукция'),
(1103,'ООО «АККЕРМАНН ЦЕМЕНТ», бухгалтерская отчетность до 2023, РБК','https://companies.rbc.ru/id/1025600822510-ooo-yuzhno-uralskaya-gorno-pererabatyivayuschaya-kompaniya/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2023: 2110, 2120, 2100, 2400; 2022 2110; последующие годы публично отсутствуют'),
(1104,'ООО «Металекс», официальный сайт: реквизиты','https://metal-x.ru/company/detail.php','Официальный сайт предприятия',NULL,'2026-11-15','Подтверждено ИНН 5607011852, ОГРН 1025600820630, адрес'),
(1105,'ООО «Металекс», финансовая карточка Точка','https://check.tochka.com/company/1025600820630/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2021: выручка 1 541 823 000, чистая прибыль 400 036 000'),
(1106,'ООО «НЗНТО», републикация отчётности ФНС 2025','https://e-ecolog.ru/buh/2025/5607142100','Републикация отчетности ФНС / вторичный',NULL,'2026-11-15','2025 и 2024: формы 2, строки 2110, 2120, 2100, 2200, 2300, 2400'),
(1107,'ООО «Новохром», РБК Компании','https://companies.rbc.ru/id/1025600820365-ooo-novohrom/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025: выручка, себестоимость, валовая и чистая прибыль; 2024 сопоставимая выручка'),
(1108,'ООО «Новохром», Фирмотека (кадры)','https://firmoteka.ru/5607014758','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','Среднесписочная численность 74 чел. за 2025 год'),
(1109,'ООО «НЗБП», РБК Компании','https://companies.rbc.ru/id/1215600008942-obschestvo-s-ogranichennoj-otvetstvennostyu-novotroitskij-zavod-bisulfita-i-pirosulfita/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025: выручка, себестоимость, чистая прибыль; выручка 2024'),
(1110,'ООО «НЗБП», руИНН: численность','https://ruinn.ru/company/5607144115-ooo-nzbp','Агрегатор реестровых сведений ФНС / вторичный',NULL,'2026-11-15','39 чел. в 2025 году'),
(1111,'ООО «Поддон Сервис», републикация отчётности ФНС 2025','https://e-ecolog.ru/buh/2025/5607143440','Републикация отчетности ФНС / вторичный',NULL,'2026-11-15','2025–2024 бухгалтерский баланс, отчет о финансовых результатах'),
(1112,'ООО «Поддон Сервис», РБК Компании','https://companies.rbc.ru/id/1195658018907-obschestvo-s-ogranichennoj-otvetstvennostyu-poddon-servis/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 чистый убыток, численность 25 работников; финансовые строки сверены с 1111'),
(1113,'ООО «НЗЦМ», републикация отчётности ФНС 2025','https://e-ecolog.ru/buh/2025/5607143640','Републикация отчетности ФНС / вторичный',NULL,'2026-11-15','2025 и 2024: строки 2110, 2120, 2100, 2200, 2300, 2400'),
(1114,'ООО «НЗЦМ», число работников, справочник','https://xfirm.ru/company/5607002135','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','Через список связанных организаций: численность 120 человек 2025'),
(1115,'ООО «Хлебозавод», бухгалтерские показатели 2025','https://synapsenet.ru/organizacii/1155658008505-ooo-hlebozavod','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025: прибыль 8 533 000 руб., изменения выручки; 2025 выручка округлена в источниках'),
(1116,'ООО «Хлебозавод», Т-Банк','https://www.tbank.ru/business/contractor/legal/1155658008505/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025: выручка ~526,28 млн руб.; точная выручка не подтверждена по источнику 1116'),
(1117,'АО «НТПЗ», РБК Компании','https://companies.rbc.ru/id/1235600005486-nao-ao-ntpz/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025: выручка 854 627 000 руб., себестоимость, валовой убыток, чистый убыток'),
(1118,'ООО «Завод Элмон», B2B-подряд','https://vsem-podryad.ru/company/e57f0af3-001f-4a26-bf27-b8e275150433/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025: выручка 1 164 000, убыток -154 000, активы 9 869 000'),
(1119,'ООО «Завод Элмон», РБК Компании','https://companies.rbc.ru/id/1205600001342-obschestvo-s-ogranichennoj-otvetstvennostyu-zavod-elmon/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2024: выручка, чистая прибыль, себестоимость, балансовые данные'),
(1120,'ООО «УЗТМ», B2B.house','https://b2b.house/company/OOO-UZTM_8dafc414-9fab-42ee-9241-2e7a8a95fa86/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 выручка и прибыль, активы; 2024 убыток'),
(1121,'ООО «НСплав», РБК Компании','https://companies.rbc.ru/id/1165658079718-ooo-nsplav/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 выручка, себестоимость, валовая прибыль, чистая прибыль'),
(1122,'ООО «НСплав», РБК финансовая сводка','https://companies.rbc.ru/amp/ogrn/1165658079718/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 активы, обязательства и собственный капитал'),
(1123,'ООО «Синтезспирт», РБК Компании','https://companies.rbc.ru/id/1205600011187-obschestvo-s-ogranichennoj-otvetstvennostyu-sintezspirt/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 выручка, себестоимость, валовая и чистая прибыль; 2024 сопоставимая выручка'),
(1124,'ООО «Синтезспирт», Фирмотека','https://firmoteka.ru/5614085615','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 среднесписочная численность 400 чел.'),
(1125,'АО «Орский машиностроительный завод», XFirm','https://xfirm.ru/company/5613000880','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2021 выручка 6 538 323 000; 2022–2025 публичные значения на странице отсутствуют'),
(1126,'АО «Орский машиностроительный завод», Т-Банк','https://www.tbank.ru/business/contractor/legal/1025601999400/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2021 чистая прибыль 83,75 млн руб. (округлённо); не включена в точный слой'),
(1127,'Администрация города Новотроицка: Экономическое развитие, 09.09.2025 № 1579-п','https://base.garant.ru/412707195/e88847e78ccd9fdb54482c7fa15982bf/','Официальный муниципальный нормативный документ',NULL,'2026-11-15','На 01.01.2025: 7 средних, 36 малых, 410 микропредприятий, 1572 ИП, 5406 самозанятых'),
(1128,'ООО «Новотроицкий содовый завод», 2025 ССЧ и правоотношения','https://zachestnyibiznes.ru/company/report?ogrn=1185658000637&type=total','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','Среднесписочная численность за 2025 год 517 чел., за 2024 год 521 чел.'),
(1129,'ООО «НЗНТО», РБК Компании','https://companies.rbc.ru/id/1175658023705-ooo-novotroitskij-zavod-nestandartnogo-tehnologicheskogo-oborudovaniya/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Подтверждение ИНН, ОГРН, 2025 финансовые значения'),
(1130,'АО «Новотроицкий завод хромовых соединений», РБК','https://companies.rbc.ru/id/1025600820431-ao-novotroitskij-zavod-hromovyih-soedinenij/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','ИНН/ОГРН, 2024 выручка 10 673 929 000 руб., прибыль 625 792 000'),
(1131,'АО «НЦЗ»: финансовый профиль 2025','https://b2b.house/company/AO-NCZ_ab8427ef-6671-403c-a8c4-6f19d3009fcf/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025: выручка 379 426 000, прибыль 19 834 000, 94 работника'),
(1134,'ООО «Новохром», руИНН, финансовая отчетность 2021–2025','https://ruinn.ru/company/5607014758-ooo-novokhrom','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2021–2025 точные значения: выручка, себестоимость, валовая и чистая прибыль, активы, капитал'),
(1135,'ООО «НЗЦМ», РБК Компании, финансовая карточка 2025','https://companies.rbc.ru/id/1205600008668-obschestvo-s-ogranichennoj-otvetstvennostyu-novotroitskij-zavod-tsvetnyih-metallov/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2025 численность 77 человек'),
(1136,'ООО «АККЕРМАНН ЦЕМЕНТ», XFirm, архив выручки 2012–2023','https://xfirm.ru/company/5607015014','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Выручка 2021 года 12 604 991 000 руб.; 2024 и 2025 финансовая отчетность отсутствует'),
(1137,'ООО «АККЕРМАНН ЦЕМЕНТ», Inndex, годовая отчетность 2022','https://inndex.ru/ul/novotroitsk/ogrn-1025600822510-a58-ooo-akkermann-tsement','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2022: чистая прибыль 4 472 470 000 руб., валюта баланса 13 029 755 000 руб.'),
(1132,'ООО «НСЗ», републикация отчётности 2022 / сравнение 2021','https://e-ecolog.ru/buh/2022/5607142213','Републикация отчетности ФНС / вторичный',NULL,'2026-11-15','2022/2021: формы 2, строки 2110,2120,2100,2200,2300,2400'),
(1133,'ООО «Хлебозавод», РБК Компании, 2024','https://companies.rbc.ru/id/1155658008505-ooo-hlebozavod/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','2024: 2110, 2120, 2100, 2400')
ON CONFLICT (id) DO UPDATE SET name=EXCLUDED.name,url=EXCLUDED.url,source_type=EXCLUDED.source_type,access_date=EXCLUDED.access_date,description=EXCLUDED.description;
SELECT pg_catalog.setval(pg_get_serial_sequence('public.data_sources','id'),(SELECT MAX(id) FROM public.data_sources),true);
UPDATE public.enterprises SET inn=COALESCE(inn,'5607019523'), ogrn=COALESCE(ogrn,NULL) WHERE id=1;
UPDATE public.enterprise_research_status SET identification_status='registered',evidence_level='legacy_only',identity_source_id=NULL,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=1;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607141530'), ogrn=COALESCE(ogrn,'1165658079718') WHERE id=2;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1121,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=2;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607142213'), ogrn=COALESCE(ogrn,'1185658000637') WHERE id=3;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1101,review_note='В исходной базе обозначен инвестиционным проектом; официальный сайт подтверждает выпуск продукции. Исходный исторический статус будет исправлен на «Действующее» по результатам сверки.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=3;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607015014'), ogrn=COALESCE(ogrn,'1025600822510') WHERE id=4;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1103,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=4;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607011852'), ogrn=COALESCE(ogrn,'1025600820630') WHERE id=5;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1104,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=5;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607004870'), ogrn=COALESCE(ogrn,'1025600820563') WHERE id=6;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1131,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=6;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607002135'), ogrn=COALESCE(ogrn,'1025600820431') WHERE id=7;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1130,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=7;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607142100'), ogrn=COALESCE(ogrn,'1175658023705') WHERE id=8;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1129,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=8;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607142044'), ogrn=COALESCE(ogrn,NULL) WHERE id=9;
UPDATE public.enterprise_research_status SET identification_status='registered',evidence_level='legacy_only',identity_source_id=NULL,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=9;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607014758'), ogrn=COALESCE(ogrn,'1025600820365') WHERE id=10;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1107,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=10;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607144115'), ogrn=COALESCE(ogrn,'1215600008942') WHERE id=37;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1109,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=37;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607143440'), ogrn=COALESCE(ogrn,'1195658018907') WHERE id=38;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1112,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=38;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607143640'), ogrn=COALESCE(ogrn,'1205600008668') WHERE id=39;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1113,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=39;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607140262'), ogrn=COALESCE(ogrn,'1155658008505') WHERE id=40;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1115,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=40;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607144789'), ogrn=COALESCE(ogrn,'1235600005486') WHERE id=41;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1117,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=41;
UPDATE public.enterprises SET inn=COALESCE(inn,'5607143496'), ogrn=COALESCE(ogrn,'1205600001342') WHERE id=42;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1119,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=42;
UPDATE public.enterprises SET inn=COALESCE(inn,'5614080374'), ogrn=COALESCE(ogrn,'1175658020922') WHERE id=44;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1120,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=44;
UPDATE public.enterprises SET inn=COALESCE(inn,'5614085615'), ogrn=COALESCE(ogrn,'1205600011187') WHERE id=15;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1123,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=15;
UPDATE public.enterprises SET inn=COALESCE(inn,'5613000880'), ogrn=COALESCE(ogrn,'1025601999400') WHERE id=16;
UPDATE public.enterprise_research_status SET identification_status='matched',evidence_level='web_checked',identity_source_id=1125,review_note='Идентификация по ИНН и ОГРН из указанной публичной карточки; официальный ЕГРЮЛ проверить отдельно.',reviewed_at='2026-11-15',last_checked_at='2026-11-15' WHERE enterprise_id=16;
UPDATE public.enterprise_research_status SET identification_status='duplicate_candidate',evidence_level='name_only',duplicate_candidate_id=5,review_note='Потенциальный дубликат ООО Металекс (ID 5): ни ИНН, ни ОГРН в этой карточке не было. Не переносить цифры на ID 43 до проверки.',reviewed_at='2026-11-15' WHERE enterprise_id=43;
UPDATE public.enterprises SET status='Действующее' WHERE id=3 AND status='Инвестиционный проект';
UPDATE public.enterprise_research_status SET identification_status='matched', evidence_level='web_checked', identity_source_id=1102,review_note='Инвестиционный проект реализован: официальный сайт подтверждает осуществляемый выпуск продукции; статус в старой таблице не переписан без отдельной ревизии', reviewed_at='2026-11-15' WHERE enterprise_id=3;
-- Numeric records: original report value as RUB (convert thous.RUB to RUB), employees as persons.
INSERT INTO public.metric_values(metric_code,enterprise_id,period_year,value_numeric,source_id,value_kind,verification_status,reporting_scope,precision_kind,source_detail,note) VALUES
('revenue',2,2025,3516186000,1121,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',2,2025,3117344000,1121,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',2,2025,398842000,1121,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',2,2025,91728000,1121,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',2,2025,3576904000,1122,'reported','verified','legal_entity','exact','Баланс 2025, активы','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('liabilities',2,2025,1101071000,1122,'reported','verified','legal_entity','exact','Баланс 2025, обязательства','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('equity',2,2025,2475833000,1122,'reported','verified','legal_entity','exact','Баланс 2025, капитал','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',3,2025,3155216000,1101,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',3,2025,2985566000,1101,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',3,2025,169650000,1101,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',3,2025,8189000,1101,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('employees',3,2025,517,1128,'reported','verified','legal_entity','exact','ССЧ за 2025 год','Временной период определён по подписи карточки источника.'),
('revenue',3,2024,1352981000,1101,'reported','verified','legal_entity','exact','Сопоставимая колонка 2024 в отчётности 2025','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('employees',3,2024,521,1128,'reported','verified','legal_entity','exact','ССЧ за 2024 год','Временной период определён по подписи карточки источника.'),
('revenue',3,2022,1666109000,1132,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',3,2022,1394573000,1132,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',3,2022,271536000,1132,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',3,2022,178856000,1132,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',3,2022,-10128000,1132,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',3,2022,-10128000,1132,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',3,2021,761399000,1132,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',3,2021,1035155000,1132,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',3,2021,-273756000,1132,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',3,2021,-362307000,1132,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',3,2021,-571287000,1132,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',3,2021,-571287000,1132,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',4,2023,15165171000,1103,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',4,2023,4972045000,1103,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',4,2023,10193126000,1103,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',4,2023,6330547000,1103,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',4,2022,13555757000,1103,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',4,2022,4472470000,1137,'reported','verified','legal_entity','exact','Чистая прибыль за 2022 год','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',4,2022,13029755000,1137,'reported','verified','legal_entity','exact','Валюта баланса на конец 2022 года','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',4,2021,12604991000,1136,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',5,2021,1541823000,1105,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',5,2021,400036000,1105,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',8,2025,1118736000,1106,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',8,2025,526913000,1106,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',8,2025,591823000,1106,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',8,2025,520779000,1106,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',8,2025,512027000,1106,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',8,2025,512027000,1106,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',8,2024,486851000,1106,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',8,2024,302207000,1106,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',8,2024,184644000,1106,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',8,2024,93259000,1106,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',8,2024,80184000,1106,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',8,2024,80184000,1106,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',10,2021,1296014000,1134,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',10,2021,701308000,1134,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',10,2021,594706000,1134,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',10,2021,380752000,1134,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',10,2021,1082640000,1134,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('equity',10,2021,998300000,1134,'reported','verified','legal_entity','exact','1300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',10,2022,1154597000,1134,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',10,2022,401410000,1134,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',10,2022,753187000,1134,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',10,2022,651037000,1134,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',10,2022,1513146000,1134,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('equity',10,2022,1416547000,1134,'reported','verified','legal_entity','exact','1300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',10,2023,851777000,1134,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',10,2023,290645000,1134,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',10,2023,561132000,1134,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',10,2023,501506000,1134,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',10,2023,1505961000,1134,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('equity',10,2023,1456725000,1134,'reported','verified','legal_entity','exact','1300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',10,2024,704011000,1134,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',10,2024,270967000,1134,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',10,2024,433044000,1134,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',10,2024,347147000,1134,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',10,2024,1082104000,1134,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('equity',10,2024,1008133000,1134,'reported','verified','legal_entity','exact','1300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('employees',10,2024,80,1108,'reported','verified','legal_entity','exact','ССЧ за 2024 год (разность данных ФНС в публикации)','Временной период определён по подписи карточки источника.'),
('revenue',10,2025,650283000,1134,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',10,2025,360349000,1134,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',10,2025,289934000,1134,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',10,2025,72229000,1134,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',10,2025,1137070000,1134,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('equity',10,2025,1080362000,1134,'reported','verified','legal_entity','exact','1300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('employees',10,2025,74,1108,'reported','verified','legal_entity','exact','ССЧ за 2025 год','Временной период определён по подписи карточки источника.'),
('revenue',37,2025,230353000,1109,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',37,2025,209930000,1109,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',37,2025,30936000,1109,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('employees',37,2025,39,1110,'reported','verified','legal_entity','exact','ССЧ за 2025 год','Временной период определён по подписи карточки источника.'),
('revenue',37,2024,212774000,1109,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',38,2025,62613000,1111,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',38,2025,56813000,1111,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',38,2025,5800000,1111,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',38,2025,-403000,1111,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',38,2025,-3100000,1111,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',38,2025,-2573000,1112,'reported','verified','legal_entity','exact','Чистая прибыль/убыток 2025','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',38,2025,55928000,1111,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('accounts_receivable',38,2025,8845000,1111,'reported','verified','legal_entity','exact','1230','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('accounts_payable',38,2025,6928000,1111,'reported','verified','legal_entity','exact','1520','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',38,2024,62323000,1111,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',38,2024,53008000,1111,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',38,2024,9315000,1111,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',38,2024,3650000,1111,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',38,2024,204000,1111,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',38,2024,57638000,1111,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',39,2025,239915000,1113,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',39,2025,271120000,1113,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',39,2025,-31205000,1113,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',39,2025,-73873000,1113,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',39,2025,-74353000,1113,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',39,2025,-74353000,1113,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('employees',39,2025,77,1135,'reported','verified','legal_entity','exact','ССЧ за 2025 год, РБК Компании','Временной период определён по подписи карточки источника.'),
('revenue',39,2024,217739000,1113,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',39,2024,161186000,1113,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',39,2024,56553000,1113,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('operating_profit',39,2024,-22416000,1113,'reported','verified','legal_entity','exact','2200','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('profit_before_tax',39,2024,376000,1113,'reported','verified','legal_entity','exact','2300','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',39,2024,376000,1113,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',40,2025,8533000,1115,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',40,2024,490129000,1133,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',40,2024,12714000,1133,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',40,2024,321833000,1133,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',40,2024,168296000,1133,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',41,2025,854627000,1117,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',41,2025,968105000,1117,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',41,2025,-113478000,1117,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',41,2025,-869766000,1117,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',42,2025,1164000,1118,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',42,2025,-154000,1118,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',42,2025,9869000,1118,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',42,2024,4086000,1119,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',42,2024,3882000,1119,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',42,2024,204000,1119,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',44,2025,30019000,1120,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',44,2025,4528000,1120,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('assets',44,2025,18657000,1120,'reported','verified','legal_entity','exact','1600','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',44,2024,-281000,1120,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',15,2025,2265803000,1123,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('cost_of_sales',15,2025,1463083000,1123,'reported','verified','legal_entity','exact','2120','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('gross_profit',15,2025,802720000,1123,'reported','verified','legal_entity','exact','2100','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('net_profit',15,2025,174011000,1123,'reported','verified','legal_entity','exact','2400','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('employees',15,2025,400,1124,'reported','verified','legal_entity','exact','ССЧ за 2025 год','Временной период определён по подписи карточки источника.'),
('revenue',15,2024,3177173000,1123,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.'),
('revenue',16,2021,6538323000,1125,'reported','verified','legal_entity','exact','2110','Воспроизведение опубликованных данных; исходный подписанный отчет ФНС дополнительно проверить.')
ON CONFLICT (enterprise_id,metric_code,period_year,reporting_scope) WHERE enterprise_id IS NOT NULL DO UPDATE SET value_numeric=EXCLUDED.value_numeric,source_id=EXCLUDED.source_id,source_detail=EXCLUDED.source_detail,verification_status='verified',value_kind='reported',precision_kind='exact',note=EXCLUDED.note,updated_at=now() WHERE public.metric_values.verification_status <> 'verified';
INSERT INTO public.metric_value_sources(metric_value_id,source_id,source_role,section_or_page)
SELECT mv.id,mv.source_id,'value_evidence',mv.source_detail FROM public.metric_values mv
WHERE mv.verification_status='verified' AND mv.source_id BETWEEN 1101 AND 1133
ON CONFLICT(metric_value_id,source_id) DO NOTHING;
INSERT INTO public.metric_catalog(code,scope,category,title,unit,priority,definition) VALUES ('medium_enterprises','territory','Предпринимательство','Средние предприятия','ед.',2,'Количество средних предприятий на 01.01.2025, без малых, микро и ИП') ON CONFLICT(code) DO NOTHING;
INSERT INTO public.metric_catalog(code,scope,category,title,unit,priority,definition) VALUES ('small_enterprises','territory','Предпринимательство','Малые предприятия','ед.',2,'Количество малых предприятий на 01.01.2025, без микро и ИП') ON CONFLICT(code) DO NOTHING;
INSERT INTO public.metric_catalog(code,scope,category,title,unit,priority,definition) VALUES ('micro_enterprises','territory','Предпринимательство','Микропредприятия','ед.',2,'Количество микропредприятий на 01.01.2025, без ИП') ON CONFLICT(code) DO NOTHING;
INSERT INTO public.metric_catalog(code,scope,category,title,unit,priority,definition) VALUES ('individual_entrepreneurs','territory','Предпринимательство','Индивидуальные предприниматели','чел.',2,'Количество ИП на 01.01.2025') ON CONFLICT(code) DO NOTHING;
INSERT INTO public.metric_catalog(code,scope,category,title,unit,priority,definition) VALUES ('self_employed_registered','territory','Предпринимательство','Самозанятые нарастающим итогом','чел.',2,'Зарегистрированные плательщики НПД на 01.01.2025, включает физических лиц и ИП; нельзя суммировать с числом ИП') ON CONFLICT(code) DO NOTHING;
INSERT INTO public.metric_values(metric_code,city_id,period_year,value_numeric,source_id,value_kind,verification_status,reporting_scope,precision_kind,measurement_date,source_detail,note) VALUES
('medium_enterprises',1,2025,7,1127,'reported','verified','municipality','exact','2025-01-01','Постановление № 1579-п от 09.09.2025, срез на 01.01.2025','Общий зарегистрированный бизнес, не число только промышленных предприятий'),
('small_enterprises',1,2025,36,1127,'reported','verified','municipality','exact','2025-01-01','Постановление № 1579-п от 09.09.2025, срез на 01.01.2025','Общий зарегистрированный бизнес, не число только промышленных предприятий'),
('micro_enterprises',1,2025,410,1127,'reported','verified','municipality','exact','2025-01-01','Постановление № 1579-п от 09.09.2025, срез на 01.01.2025','Общий зарегистрированный бизнес, не число только промышленных предприятий'),
('individual_entrepreneurs',1,2025,1572,1127,'reported','verified','municipality','exact','2025-01-01','Постановление № 1579-п от 09.09.2025, срез на 01.01.2025','Общий зарегистрированный бизнес, не число только промышленных предприятий'),
('self_employed_registered',1,2025,5406,1127,'reported','verified','municipality','exact','2025-01-01','Постановление № 1579-п от 09.09.2025, срез на 01.01.2025','Общий зарегистрированный бизнес, не число только промышленных предприятий')
ON CONFLICT (city_id,metric_code,period_year,reporting_scope) WHERE city_id IS NOT NULL DO UPDATE SET value_numeric=EXCLUDED.value_numeric,source_id=EXCLUDED.source_id,verification_status='verified',measurement_date=EXCLUDED.measurement_date,source_detail=EXCLUDED.source_detail,precision_kind='exact' WHERE public.metric_values.verification_status <> 'verified';
INSERT INTO public.metric_values(metric_code,city_id,period_year,value_numeric,source_id,value_kind,verification_status,reporting_scope,precision_kind,measurement_date,source_detail,note) VALUES
('population',1,2025,78871,1127,'reported','verified','municipality','exact','2025-01-01','Численность населения муниципального образования на 01.01.2025','Официальная муниципальная программа; указан охват территориального показателя'),
('average_salary_territory',1,2024,'74255.2',1127,'reported','verified','municipality','exact',NULL,'Средняя зарплата работников крупных и средних организаций, опубликована на 01.01.2025','Официальная муниципальная программа; указан охват территориального показателя'),
('industrial_output',1,2024,194799010000,1127,'reported','verified','municipality','exact',NULL,'Объём отгрузки продукции крупных и средних промышленных предприятий за 2024','Официальная муниципальная программа; указан охват территориального показателя'),
('retail_turnover',1,2024,10010240000,1127,'reported','verified','municipality','exact',NULL,'Оборот розничной торговли крупных и средних предприятий за 2024','Официальная муниципальная программа; указан охват территориального показателя'),
('registered_unemployed',1,2025,140,1127,'reported','verified','municipality','exact','2025-01-01','Зарегистрированные безработные на 01.01.2025','Официальная муниципальная программа; указан охват территориального показателя'),
('registered_unemployment_rate',1,2025,'0.3',1127,'reported','verified','municipality','exact','2025-01-01','Уровень зарегистрированной безработицы на 01.01.2025; не МОТ','Официальная муниципальная программа; указан охват территориального показателя')
ON CONFLICT (city_id,metric_code,period_year,reporting_scope) WHERE city_id IS NOT NULL DO UPDATE SET value_numeric=EXCLUDED.value_numeric,source_id=EXCLUDED.source_id,verification_status='verified',measurement_date=EXCLUDED.measurement_date,source_detail=EXCLUDED.source_detail,precision_kind='exact' WHERE public.metric_values.verification_status <> 'verified';
INSERT INTO public.metric_value_sources(metric_value_id,source_id,source_role,section_or_page) SELECT id,1127,'official_municipal_program',source_detail FROM public.metric_values WHERE city_id=1 AND source_id=1127 AND verification_status='verified' ON CONFLICT(metric_value_id,source_id) DO NOTHING;
-- Legacy compatibility: keep all old rows but replace stale approximations when a verified exact value exists. Full provenance stays in metric_values.
WITH agg AS (SELECT enterprise_id,period_year,
MAX(value_numeric) FILTER(WHERE metric_code='revenue') revenue,MAX(value_numeric) FILTER(WHERE metric_code='net_profit') net_profit,
MAX(value_numeric) FILTER(WHERE metric_code='employees') employees,MAX(value_numeric) FILTER(WHERE metric_code='assets') assets,MIN(source_id) FILTER(WHERE metric_code='revenue') revenue_source
FROM public.metric_values WHERE verification_status='verified' AND reporting_scope='legal_entity' AND enterprise_id IS NOT NULL GROUP BY 1,2)
INSERT INTO public.enterprise_metrics(enterprise_id,year,revenue,net_profit,employees,assets,source_id) SELECT a.enterprise_id,a.period_year,a.revenue,a.net_profit,a.employees::integer,a.assets,a.revenue_source FROM agg a WHERE a.revenue IS NOT NULL AND NOT EXISTS
 (SELECT 1 FROM public.enterprise_metrics x WHERE x.enterprise_id=a.enterprise_id AND x.year=a.period_year);
WITH agg AS (SELECT enterprise_id,period_year,
MAX(value_numeric) FILTER(WHERE metric_code='revenue') revenue,MAX(value_numeric) FILTER(WHERE metric_code='net_profit') net_profit,
MAX(value_numeric) FILTER(WHERE metric_code='employees') employees,MAX(value_numeric) FILTER(WHERE metric_code='assets') assets
FROM public.metric_values WHERE verification_status='verified' AND reporting_scope='legal_entity' AND enterprise_id IS NOT NULL GROUP BY 1,2)
UPDATE public.enterprise_metrics em SET revenue=COALESCE(a.revenue,em.revenue),net_profit=COALESCE(a.net_profit,em.net_profit),employees=COALESCE(a.employees::integer,em.employees),assets=COALESCE(a.assets,em.assets) FROM agg a WHERE em.enterprise_id=a.enterprise_id AND em.year=a.period_year AND
 ((a.revenue IS NOT NULL AND em.revenue IS DISTINCT FROM a.revenue) OR (a.net_profit IS NOT NULL AND em.net_profit IS DISTINCT FROM a.net_profit) OR (a.employees IS NOT NULL AND em.employees IS DISTINCT FROM a.employees::integer) OR (a.assets IS NOT NULL AND em.assets IS DISTINCT FROM a.assets));
CREATE OR REPLACE VIEW public.v3_enterprise_research_queue AS
SELECT e.id AS enterprise_id,e.name AS enterprise_name,c.name AS city_name,c.region,rs.priority_order,rs.identification_status,rs.duplicate_candidate_id,
COUNT(DISTINCT mv.id) FILTER(WHERE mv.verification_status='verified') AS verified_values,
COUNT(DISTINCT mv.period_year) FILTER(WHERE mv.verification_status='verified' AND mv.metric_code='revenue') AS verified_revenue_years,
MAX(mv.period_year) FILTER(WHERE mv.verification_status='verified') AS newest_verified_year
FROM public.enterprises e JOIN public.cities c ON c.id=e.city_id
LEFT JOIN public.enterprise_research_status rs ON rs.enterprise_id=e.id
LEFT JOIN public.metric_values mv ON mv.enterprise_id=e.id
GROUP BY e.id,e.name,c.name,c.region,rs.priority_order,rs.identification_status,rs.duplicate_candidate_id;
CREATE OR REPLACE VIEW public.v3_verified_provenance AS
SELECT e.id AS enterprise_id,e.name,c.name AS city_name, mv.period_year, mv.metric_code, mc.title AS metric_title, mv.value_numeric,mc.unit,
mv.precision_kind,mv.verification_status,mv.source_detail,src.name AS source_name,src.url AS source_url,src.source_type
FROM public.metric_values mv JOIN public.enterprises e ON e.id=mv.enterprise_id JOIN public.cities c ON c.id=e.city_id JOIN public.metric_catalog mc ON mc.code=mv.metric_code LEFT JOIN public.data_sources src ON src.id=mv.source_id
WHERE mv.verification_status='verified';
COMMIT;

-- V4 UPGRADE BEGIN
-- PromRegion56 v4: Orsk and Orenburg evidence-based expansion.

-- Intended after v3_full.sql, PostgreSQL >= 15, tested statically only.

-- Exact financial series reproduced by third-party aggregators are NOT authenticated original FNS reports.

-- Financial data must be attributed to INN and a legal entity, not a site or branch.

BEGIN;

CREATE TABLE IF NOT EXISTS public.v4_entity_identity (
 enterprise_id integer PRIMARY KEY REFERENCES public.enterprises(id) ON DELETE CASCADE,
 researched_inn varchar(12), researched_ogrn varchar(15), entity_kind varchar(35) NOT NULL DEFAULT 'unreviewed',
 identity_status varchar(40) NOT NULL DEFAULT 'not_researched_in_detail', source_id integer REFERENCES public.data_sources(id),
 location_note text, checked_on date NOT NULL DEFAULT CURRENT_DATE,
 CONSTRAINT v4_identity_inn_shape_chk CHECK (researched_inn IS NULL OR researched_inn ~ '^[0-9]{10,12}$')
);
CREATE TABLE IF NOT EXISTS public.v4_quality_issues (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 enterprise_id integer REFERENCES public.enterprises(id),
 problem_code varchar(80) NOT NULL, details text NOT NULL, evidence_url text,
 review_status varchar(30) NOT NULL DEFAULT 'open', created_on date NOT NULL DEFAULT CURRENT_DATE,
 UNIQUE(enterprise_id,problem_code)
);
CREATE TABLE IF NOT EXISTS public.v4_period_observations (
 id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
 city_id integer NOT NULL REFERENCES public.cities(id),
 period_from date NOT NULL,period_to date NOT NULL, period_type varchar(30) NOT NULL,
 metric_code varchar(70) NOT NULL REFERENCES public.metric_catalog(code),
 numeric_value numeric(30,4) NOT NULL, source_id integer NOT NULL REFERENCES public.data_sources(id),
 coverage_note text NOT NULL,
 UNIQUE(city_id,period_from,period_to,metric_code,coverage_note),
 CHECK(period_from<=period_to)
);

INSERT INTO public.data_sources(id,name,url,source_type,publication_date,access_date,description) VALUES
(2201,'ООО «Синтезспирт», ИНН 5614085615, годовой ряд 2021–2025','https://xfirm.ru/company/5614085615','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2202,'ООО «Синтезспирт», кадровая статистика Фирмотека','https://firmoteka.ru/5614085615','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','2024 и 2025: среднесписочная численность'),
(2203,'ООО «Синтезспирт», показатели 2025, РБК','https://companies.rbc.ru/id/1205600011187-obschestvo-s-ogranichennoj-otvetstvennostyu-sintezspirt/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2204,'АО «Орское карьероуправление», РБК Компании','https://companies.rbc.ru/id/1025602000808-ao-orskoe-kareroupravlenie/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2205,'ООО УЗГО, ИНН 5614046528, финансовые показатели','https://b2b.house/company/OOO-UZGO_afeac6fc-ad0c-4c66-92e0-e460d92b81f3/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2206,'АО «ОЗЭМИ», ИНН 5614001069, финансовые показатели 2021–2024','https://xfirm.ru/company/5614001069','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2207,'ЗАО «Орский хлеб», ИНН 5615013290, отчетность 2025','https://clickfile.ru/ul/1105658013670','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2208,'ООО «Пивоваренный завод Орский», ИНН 5616009698','https://www.tbank.ru/business/contractor/legal/1025602076972/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2209,'ООО «Агро-Альянс ОМФ», ИНН 5614077558, ряды 2021–2025','https://xfirm.ru/company/5614077558','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2210,'ООО «Агро-Альянс ОМФ», кадры, Фирмотека','https://firmoteka.ru/5614077558','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2211,'ООО «НПО ОРСК», сведения о выручке и прибыли','https://b2b.house/company/OOO-NPO-ORSK_60358ef5-fd8f-4dc4-97a9-5fc9e94afde3/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2212,'ООО «Завод горных машин», ИНН 5614064527, отраслевой справочник','https://energybase.ru/vendor/zgm','Отраслевой финансовый справочник / вторичный',NULL,'2026-11-15','Суммы в тыс. рублей в источнике; умножены на 1000'),
(2213,'ООО «ГорЦемМаш», ИНН 5614079192, сведения 2025','https://b2b.house/company/OOO-GCM_7a60935f-f2f2-4f71-a22e-7b77d66ea886/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2214,'ООО «ТПК ОРСК», ИНН 5614085372, карточка Т-Банк','https://www.tbank.ru/business/contractor/legal/1205600009515/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2215,'ООО «Орскагромаш», ИНН 5614061734','https://gororg.ru/okved/C/28/orsk/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2216,'ООО «СМК ОРСК», ИНН 5614049014, финансовая отчетность 2021–2025','https://xfirm.ru/company/5614049014','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2217,'АО «Орский машиностроительный завод», ИНН 5613000880','https://xfirm.ru/company/5613000880','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2218,'АО «ОРМЕТ», ОГРН 1025602077270, отчетность','https://companies.rbc.ru/id/1025602077270-ao-ormet/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2219,'ПАО «Орскнефтеоргсинтез», ОГРН 1025601998498','https://companies.rbc.ru/id/1025601998498-pao-orsknefteorgsintez/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2220,'АО «Завод бурового оборудования», ИНН 5612002652','https://xfirm.ru/company/5612002652','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2221,'АО «Завод Инвертор», ИНН 5609003039','https://xfirm.ru/company/5609003039','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2222,'АО «Завод Инвертор», раскрытие бухгалтерской отчетности','https://www.e-disclosure.ru/portal/files.aspx?id=19868&type=3','Портал раскрытия отчетности эмитентов',NULL,'2026-11-15','Есть документы по годам: числа не извлечены, автоматического заполнения нет'),
(2223,'ООО «Оренбургский радиатор», ИНН 5612030402','https://xfirm.ru/company/5612030402','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2224,'АО «Нефтемаслозавод», ИНН 5609008608','https://xfirm.ru/company/5609008608','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2225,'ООО «Оренбургский завод металлоконструкций», ИНН 5610127832','https://companies.rbc.ru/id/1095658011349-ooo-orenburgskij-zavod-metallokonstruktsij/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2226,'ООО «Оренпласт», ИНН 5610053179, B2B.house','https://b2b.house/company/OOO-ORENPLAST_a1616730-0cc7-4e6e-83b9-81322317f282/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2227,'ООО «Сладковско-Заречное», ИНН 5611037405, ряд 2022–2025','https://xfirm.ru/company/5611037405','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2228,'ООО «Ореана», ИНН 5612038313','https://companies.rbc.ru/id/1035608456751-ooo-oreana/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2229,'ООО НПЦ «ВЕЛТ», ИНН 5010039782','https://firmoteka.ru/5010039782','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2230,'ООО «Завод ПромСтройМаш», ИНН 5609076936','https://xfirm.ru/company/5609076936','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2231,'ООО «МиСТ», ИНН 5638060761','https://xfirm.ru/company/5638060761','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2232,'ООО «СтальКом» («Стальная компания»), ИНН 5610213785','https://xfirm.ru/company/5610213785','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2233,'ООО «Полимерстрой», ИНН 5611059769','https://xfirm.ru/company/5611059769','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2234,'ООО НПП «Энергия», ИНН 5611002434, РБК','https://companies.rbc.ru/id/1025601715765-ooo-nauchno-proizvodstvennoe-predpriyatie-energiya/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2235,'ООО НПП «ПневМакс», ИНН 5611059889','https://xfirm.ru/company/5611059889','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2236,'АО «Оренбургский маслоэкстракционный завод», БФО ФНС 2025','https://bo.nalog.gov.ru/download/bfo/pdf/6915850?detailId=57430375&period=2025','ФНС ГИР БО / официальный первичный документ',NULL,'2026-11-15','ИНН 5611001455; бухгалтерский баланс, отчет о финансовых результатах (в тыс. руб.); дата выгрузки 20.04.2026'),
(2237,'Отчёт главы города Орска 2024–2025, официальный документ','https://orsk-gorsovet.ru/media/2016/%D0%9E%D1%82%D1%87%D0%B5%D1%82-%D0%B3%D0%BB%D0%B0%D0%B2%D1%8B_2024-2025.pdf','Официальный документ муниципалитета',NULL,'2026-11-15','2024 полные годы; 2025 показатели за 9 месяцев/полугодие, отдельно от годовых'),
(2238,'Официальный документ города Оренбурга (демография)','https://base.garant.ru/415031522/5633a92d35b966c2ba2f1e859e7bdd69/','Муниципальный нормативный документ',NULL,'2026-11-15','Муниципальная территория, включающая также подведомственные населённые пункты'),
(2239,'ООО «Орский мясокомбинат», ИНН 5614054751: БФО 2021–2025','https://okvedo.ru/company/5614054751','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2240,'ООО «Орский мясокомбинат», среднесписочная численность 2025','https://xfirm.ru/company/5614054751','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2241,'ООО «Орский ПЭТ завод», ИНН 5614084026, РБК Компании','https://companies.rbc.ru/id/1195658014782-obschestvo-s-ogranichennoj-otvetstvennostyu-orskij-pet-zavod/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2242,'ООО «Орский ПЭТ завод», численность 2025','https://reputation.ru/ogrn/1195658014782','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2243,'ООО «Уралпласттара», ИНН 5615015956, финансовые показатели 2021–2024','https://xfirm.ru/company/5615015956','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2244,'ООО «РОСЭлектрод-Долина», ИНН 5614080705, реквизиты','https://companies.rbc.ru/id/1175658024783-ooo-russkaya-organizatsiya-svarschikov-elektrod-dolina/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2245,'ООО «Уральский завод строительных конструкций», ГИР БО ФНС 2020','https://bo.nalog.gov.ru/download/bfo/pdf/3377163?detailId=8769285&period=2020','ФНС ГИР БО / официальный первичный документ',NULL,'2026-11-15','Подтверждает ИНН 5607043540 и историческую отчетность 2020; нельзя выдавать её за 2025'),
(2246,'ООО «Технология», Оренбург, ИНН 5612028890, РБК','https://companies.rbc.ru/id/1025601807483-ooo-tehnologiya/','Агрегатор отчетности ФНС / вторичный',NULL,'2026-11-15','Сведения по указанному ИНН и году; первичная подписанная отчетность не скачана'),
(2247,'ООО «Технология», 2025 год, работники','https://gororg.ru/company/5612028890/ooo-tekhnologiya/','Агрегатор сведений ФНС / вторичный',NULL,'2026-11-15','На странице 2025 — численность 249 человек'),
(2248,'АО «Завод ЖБИ Степной», републикация бухгалтерской отчётности 2025, 2024','https://e-ecolog.ru/buh/2025/5609031910','Републикация отчетности ФНС / вторичный',NULL,'2026-11-15','Строки 2110, 2120, 2100, 2200, 2300, 2400 в тыс. рублей за 2024–2025')
ON CONFLICT(id) DO NOTHING;

SELECT pg_catalog.setval('public.data_sources_id_seq'::regclass,(SELECT max(id) FROM public.data_sources));

INSERT INTO public.v4_entity_identity(enterprise_id,researched_inn,researched_ogrn,entity_kind,identity_status,source_id,location_note) VALUES
(11,'5616006746',NULL,'legal_entity','matched_by_inn',2218,''),
(12,'5615002820','1025602000808','legal_entity','matched_by_inn',2204,''),
(13,NULL,NULL,'branch','branch_identity_pending',NULL,'Орский щебеночный завод — филиал АО «ПНК»: нельзя подставлять выручку всего АО как выручку филиала'),
(14,'5615002700',NULL,'legal_entity','matched_by_inn',2219,''),
(15,'5614085615','1205600011187','legal_entity','matched_by_inn',2201,''),
(16,'5613000880',NULL,'legal_entity','matched_by_inn',2217,''),
(17,NULL,NULL,'unreviewed','not_researched_in_detail',NULL,'Нет отдельно подтверждённой связки ИНН и финансовой отчетности; исходная карточка сохраняется'),
(18,NULL,NULL,'unreviewed','not_researched_in_detail',NULL,'Нет отдельно подтверждённой связки ИНН и финансовой отчетности; исходная карточка сохраняется'),
(19,'5614049014',NULL,'legal_entity','matched_by_inn',2216,''),
(20,'5614046528',NULL,'legal_entity','matched_by_inn',2205,''),
(21,'5614001069',NULL,'legal_entity','matched_by_inn',2206,''),
(22,NULL,NULL,'branch','branch_identity_pending',NULL,'Орский ВРЗ — филиал ООО «НВК»: нельзя приписывать отчетность головной компании без сегментного раскрытия'),
(23,'5615013290',NULL,'legal_entity','matched_by_inn',2207,''),
(24,'5614054751','1105658027551','legal_entity','matched_by_inn',2239,''),
(25,'5616009698',NULL,'legal_entity','matched_by_inn',2208,''),
(26,'5614077558','1165658072007','legal_entity','matched_by_inn',2209,''),
(27,'5614085453',NULL,'legal_entity','matched_by_inn',2211,''),
(28,'5614064527',NULL,'legal_entity','matched_by_inn',2212,''),
(29,'5614079192',NULL,'legal_entity','matched_by_inn',2213,''),
(30,'5614084026','1195658014782','legal_entity','matched_by_inn',2241,''),
(31,'5614085372',NULL,'legal_entity','matched_by_inn',2214,''),
(32,'5614061734',NULL,'legal_entity','matched_by_inn',2215,''),
(33,'5615015956','1025602003459','legal_entity','matched_by_inn',2243,''),
(34,'5614080705','1175658024783','legal_entity','matched_by_inn',2244,'Юрлицо идентифицировано, но числовые ряды не добавлены без подтверждения финансовой отчётности'),
(35,'5607043540',NULL,'legal_entity','matched_by_inn',2245,'Официальный документ ФНС относится к 2020 году; статус актуальной работы и показатели 2021–2025 требуют отдельной проверки'),
(36,NULL,NULL,'unreviewed','not_researched_in_detail',NULL,'Нет отдельно подтверждённой связки ИНН и финансовой отчетности; исходная карточка сохраняется'),
(45,NULL,NULL,'unreviewed','not_researched_in_detail',NULL,'Нет отдельно подтверждённой связки ИНН и финансовой отчетности; исходная карточка сохраняется'),
(46,'5612002652',NULL,'legal_entity','matched_by_inn',2220,''),
(47,'5609003039',NULL,'legal_entity','matched_by_inn',2221,''),
(48,'5612030402',NULL,'legal_entity','matched_by_inn',2223,'Юридический адрес на 15.11.2026: Шадринск, Курганская область. Название и история связаны с Оренбургом. Проверить наличие текущей производственной площадки в Оренбурге.'),
(49,'5609008608',NULL,'legal_entity','matched_by_inn',2224,''),
(52,'5610127832',NULL,'legal_entity','matched_by_inn',2225,''),
(67,'5610053179',NULL,'legal_entity','matched_by_inn',2226,''),
(69,NULL,NULL,'unreviewed','not_researched_in_detail',NULL,'Нет отдельно подтверждённой связки ИНН и финансовой отчетности; исходная карточка сохраняется'),
(71,'5611037405','1065611033652','legal_entity','matched_by_inn',2227,''),
(73,'5612028890','1025601807483','legal_entity','matched_by_inn',2246,''),
(74,'5610058025',NULL,'legal_entity','matched_by_inn',NULL,'В исходной БД уже есть ИНН; новый финансовый показатель не добавлялся без дополнительной сверки'),
(76,'5610218014',NULL,'legal_entity','matched_by_inn',NULL,'В исходной БД уже есть ИНН; новый финансовый показатель не добавлялся без дополнительной сверки'),
(78,'5612038313',NULL,'legal_entity','matched_by_inn',2228,''),
(79,'5010039782',NULL,'legal_entity','matched_by_inn',2229,'ИНН выдан в другом регионе; сведения о расположении производственной площадки нужно сверить'),
(80,'5609076936',NULL,'legal_entity','matched_by_inn',2230,'Компания могла сменить юрадрес на Москву; финансовые суммы по юрлицу, производство в Оренбурге проверить'),
(81,'5638060761',NULL,'legal_entity','matched_by_inn',2231,'Юрлицо зарегистрировано в посёлке Пригородный Оренбургского района, не в городе Оренбург'),
(82,'5610213785',NULL,'legal_entity','matched_by_inn',2232,'Полное юридическое наименование ООО «Стальная компания»; торговое «СтальКом»'),
(83,'5611059769',NULL,'legal_entity','matched_by_inn',2233,''),
(84,'5611002434',NULL,'legal_entity','matched_by_inn',2234,''),
(85,'5611059889',NULL,'legal_entity','matched_by_inn',2235,''),
(86,NULL,NULL,'unreviewed','not_researched_in_detail',NULL,'Нет отдельно подтверждённой связки ИНН и финансовой отчетности; исходная карточка сохраняется'),
(87,'5611001455',NULL,'legal_entity','matched_by_inn',2236,''),
(88,NULL,NULL,'legal_entity','ambiguous_identity',NULL,'По адресу Илекская, 1 обнаружены одноимённые ООО (ИНН 5610232876 и 5609086660); без выписки головного юрлица использовать отчётность нельзя'),
(89,'5609031910','1025600884110','legal_entity','matched_by_inn',2248,'')
ON CONFLICT(enterprise_id) DO UPDATE SET researched_inn=COALESCE(EXCLUDED.researched_inn,public.v4_entity_identity.researched_inn), researched_ogrn=COALESCE(EXCLUDED.researched_ogrn,public.v4_entity_identity.researched_ogrn),entity_kind=EXCLUDED.entity_kind, identity_status=EXCLUDED.identity_status,source_id=COALESCE(EXCLUDED.source_id,public.v4_entity_identity.source_id),location_note=EXCLUDED.location_note,checked_on=CURRENT_DATE;

UPDATE public.enterprises SET inn='5614085615' WHERE id=15 AND inn IS NULL;

UPDATE public.enterprises SET inn='5615002820' WHERE id=12 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614046528' WHERE id=20 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614001069' WHERE id=21 AND inn IS NULL;

UPDATE public.enterprises SET inn='5615013290' WHERE id=23 AND inn IS NULL;

UPDATE public.enterprises SET inn='5616009698' WHERE id=25 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614077558' WHERE id=26 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614085453' WHERE id=27 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614064527' WHERE id=28 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614079192' WHERE id=29 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614085372' WHERE id=31 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614061734' WHERE id=32 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614049014' WHERE id=19 AND inn IS NULL;

UPDATE public.enterprises SET inn='5613000880' WHERE id=16 AND inn IS NULL;

UPDATE public.enterprises SET inn='5616006746' WHERE id=11 AND inn IS NULL;

UPDATE public.enterprises SET inn='5615002700' WHERE id=14 AND inn IS NULL;

UPDATE public.enterprises SET inn='5612002652' WHERE id=46 AND inn IS NULL;

UPDATE public.enterprises SET inn='5609003039' WHERE id=47 AND inn IS NULL;

UPDATE public.enterprises SET inn='5612030402' WHERE id=48 AND inn IS NULL;

UPDATE public.enterprises SET inn='5609008608' WHERE id=49 AND inn IS NULL;

UPDATE public.enterprises SET inn='5610127832' WHERE id=52 AND inn IS NULL;

UPDATE public.enterprises SET inn='5610053179' WHERE id=67 AND inn IS NULL;

UPDATE public.enterprises SET inn='5611037405' WHERE id=71 AND inn IS NULL;

UPDATE public.enterprises SET inn='5612038313' WHERE id=78 AND inn IS NULL;

UPDATE public.enterprises SET inn='5010039782' WHERE id=79 AND inn IS NULL;

UPDATE public.enterprises SET inn='5609076936' WHERE id=80 AND inn IS NULL;

UPDATE public.enterprises SET inn='5638060761' WHERE id=81 AND inn IS NULL;

UPDATE public.enterprises SET inn='5610213785' WHERE id=82 AND inn IS NULL;

UPDATE public.enterprises SET inn='5611059769' WHERE id=83 AND inn IS NULL;

UPDATE public.enterprises SET inn='5611002434' WHERE id=84 AND inn IS NULL;

UPDATE public.enterprises SET inn='5611059889' WHERE id=85 AND inn IS NULL;

UPDATE public.enterprises SET inn='5611001455' WHERE id=87 AND inn IS NULL;

UPDATE public.enterprises SET inn='5610058025' WHERE id=74 AND inn IS NULL;

UPDATE public.enterprises SET inn='5610218014' WHERE id=76 AND inn IS NULL;

UPDATE public.enterprises SET inn='5609031910' WHERE id=89 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614054751' WHERE id=24 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614084026' WHERE id=30 AND inn IS NULL;

UPDATE public.enterprises SET inn='5615015956' WHERE id=33 AND inn IS NULL;

UPDATE public.enterprises SET inn='5614080705' WHERE id=34 AND inn IS NULL;

UPDATE public.enterprises SET inn='5607043540' WHERE id=35 AND inn IS NULL;

UPDATE public.enterprises SET inn='5612028890' WHERE id=73 AND inn IS NULL;

UPDATE public.enterprises SET entity_type='branch' WHERE id IN (13,22) AND (entity_type IS NULL OR entity_type='branch');

INSERT INTO public.v4_quality_issues(enterprise_id,problem_code,details,evidence_url) VALUES(29,'conflicting_net_profit_2024','Републикации показывают разные значения чистой прибыли 2024; не занесена до сверки с ФНС','https://companies.rbc.ru/id/1175658007271-ooo-gortsemmash/') ON CONFLICT(enterprise_id,problem_code) DO NOTHING;

INSERT INTO public.v4_quality_issues(enterprise_id,problem_code,details,evidence_url) VALUES(19,'legacy_revenue_rounding','Исходная база: 2025 выручка 6 179 000 000 руб.; опубликованная XFirm 6 178 354 000 руб. Исправляется в отдельном слое показателей, старое значение остаётся для аудита','https://xfirm.ru/company/5614049014') ON CONFLICT(enterprise_id,problem_code) DO NOTHING;

INSERT INTO public.v4_quality_issues(enterprise_id,problem_code,details,evidence_url) VALUES(48,'legal_address_moved','На текущую дату у организации ИНН 5612030402 юридический адрес в Шадринске; финансовые показатели относятся ко всему юрлицу, а не исключительно к Оренбургу','https://xfirm.ru/company/5612030402') ON CONFLICT(enterprise_id,problem_code) DO NOTHING;

INSERT INTO public.v4_quality_issues(enterprise_id,problem_code,details,evidence_url) VALUES(80,'registration_moved','В реестрах на 2026 год встречается московский юридический адрес; анализ влияния на экономику Оренбурга требует учёта отдельно расположенных производственных площадок','https://xfirm.ru/company/5609076936') ON CONFLICT(enterprise_id,problem_code) DO NOTHING;

INSERT INTO public.v4_quality_issues(enterprise_id,problem_code,details,evidence_url) VALUES(81,'city_scope_mismatch','Компания относится к Оренбургскому району (п. Пригородный), хотя в старой БД стоит city_id=3. Не объединять с городскими итогами без уточнения','https://xfirm.ru/company/5638060761') ON CONFLICT(enterprise_id,problem_code) DO NOTHING;

INSERT INTO public.v4_quality_issues(enterprise_id,problem_code,details,evidence_url) VALUES(88,'ambiguous_inn','Два близких наименования и адреса, один профиль ликвидирован. Требуется ЕГРЮЛ и подтверждение сайта перед цифрами','https://saby.ru/profile/5609086660-772701001') ON CONFLICT(enterprise_id,problem_code) DO NOTHING;

INSERT INTO public.v4_quality_issues(enterprise_id,problem_code,details,evidence_url) VALUES(73,'workforce_source_difference','РБК показывает ССЧ 246 человек без очевидного отчётного года, другая карточка 249 на 2025. Прежде чем представлять 249 как точное, проверить официальный набор сведений ФНС','https://companies.rbc.ru/id/1025601807483-ooo-tehnologiya/') ON CONFLICT(enterprise_id,problem_code) DO NOTHING;

INSERT INTO public.metric_values(metric_code,enterprise_id,period_year,value_numeric,source_id,value_kind,verification_status,reporting_scope,precision_kind,source_detail,note)
VALUES
('cost_of_sales',12,2021,989557000,2204,'reported','verified','legal_entity','exact','Финансовые результаты за 2021; строка определяется по названию','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('gross_profit',12,2021,419107000,2204,'reported','verified','legal_entity','exact','Финансовые результаты за 2021; строка определяется по названию','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',12,2021,56276000,2204,'reported','verified','legal_entity','exact','Финансовые результаты за 2021; строка определяется по названию','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',12,2021,1408664000,2204,'reported','verified','legal_entity','exact','Финансовые результаты за 2021; строка определяется по названию','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',15,2021,151985000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',15,2021,1302501000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',15,2022,251196000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',15,2022,2120685000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',15,2023,292532000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',15,2023,2319772000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',15,2024,390,2202,'reported','verified','legal_entity','exact','Среднесписочная численность, человек','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',15,2024,797022000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',15,2024,3177173000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',15,2025,1463083000,2203,'reported','verified','legal_entity','exact','Строка 2120, отчет о финансовых результатах','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',15,2025,400,2202,'reported','verified','legal_entity','exact','Среднесписочная численность, человек','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('gross_profit',15,2025,802720000,2203,'reported','verified','legal_entity','exact','Строка 2100, отчет о финансовых результатах','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',15,2025,174011000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',15,2025,2265803000,2201,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',16,2021,6538323000,2217,'reported','verified','legal_entity','exact','Последний доступный год финансовой отчетности на странице 2021','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',19,2021,1234000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',19,2021,934365000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',19,2022,6880000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',19,2022,1708893000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',19,2023,38156000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',19,2023,2797202000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',19,2024,-147569000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',19,2024,2947832000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',19,2025,129248000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',19,2025,6178354000,2216,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',20,2024,-83775000,2205,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',20,2024,593693000,2205,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',20,2025,7652000,2205,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',20,2025,790508000,2205,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',21,2021,3578000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',21,2021,195665000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',21,2022,5477000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',21,2022,211574000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',21,2023,127147000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',21,2023,644905000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',21,2024,515886000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',21,2024,2347910000,2206,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',23,2025,72029000,2207,'reported','verified','legal_entity','exact','Выручка за 2025 год','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',24,2021,349680000,2239,'reported','verified','legal_entity','exact','Активы по балансу, конец года, руб.','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',24,2021,26056000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',24,2021,1089519000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',24,2022,496561000,2239,'reported','verified','legal_entity','exact','Активы по балансу, конец года, руб.','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',24,2022,163030000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',24,2022,1416146000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',24,2023,615971000,2239,'reported','verified','legal_entity','exact','Активы по балансу, конец года, руб.','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',24,2023,145835000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',24,2023,1604969000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',24,2024,692977000,2239,'reported','verified','legal_entity','exact','Активы по балансу, конец года, руб.','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',24,2024,95969000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',24,2024,1861114000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',24,2025,786427000,2239,'reported','verified','legal_entity','exact','Активы по балансу, конец года, руб.','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',24,2025,284,2240,'reported','verified','legal_entity','exact','Среднесписочная численность за 2025; человек','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',24,2025,92753000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',24,2025,1869389000,2239,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',25,2025,-22900000,2208,'reported','verified','legal_entity','rounded','Округлено агрегатором: 91,07 млн и убыток 22,90 млн','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',25,2025,91070000,2208,'reported','verified','legal_entity','rounded','Округлено агрегатором: 91,07 млн и убыток 22,90 млн','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',26,2021,1663000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',26,2021,1024375000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',26,2022,27975000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',26,2022,1185347000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',26,2023,1798000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',26,2023,955922000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',26,2024,253,2210,'reported','verified','legal_entity','exact','Среднесписочная численность','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',26,2024,8849000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',26,2024,1189941000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',26,2025,232,2210,'reported','verified','legal_entity','exact','Среднесписочная численность','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',26,2025,690000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',26,2025,1263740000,2209,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',27,2025,-1580000,2211,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',27,2025,181146000,2211,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',28,2021,18727000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',28,2021,359973000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',28,2022,59934000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',28,2022,594898000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',28,2023,49086000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',28,2023,547620000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',28,2024,14419000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',28,2024,549092000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',28,2025,886000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',28,2025,478849000,2212,'reported','verified','legal_entity','exact','Источник публикует в тыс. руб.; переведено в рубли без округления сверх исходного','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',29,2024,238428000,2213,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',29,2025,2567000,2213,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',29,2025,180053000,2213,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',30,2023,24374000,2241,'reported','verified','legal_entity','exact','РБК Компании: выручка за 2024 и сопоставимый показатель на начало 2024','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',30,2024,30278000,2241,'reported','verified','legal_entity','exact','Себестоимость 2024','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',30,2024,628000,2241,'reported','verified','legal_entity','exact','Чистая прибыль 2024','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',30,2024,31085000,2241,'reported','verified','legal_entity','exact','РБК Компании: выручка за 2024 и сопоставимый показатель на начало 2024','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',30,2025,3,2242,'reported','verified','legal_entity','exact','Среднесписочная численность за 2025, человек','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',31,2025,3330000,2214,'reported','verified','legal_entity','rounded','Округлённая карточка агрегатора, требуется первичный PDF','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',31,2025,685050000,2214,'reported','verified','legal_entity','rounded','Округлённая карточка агрегатора, требуется первичный PDF','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',32,2025,31500000,2215,'reported','pending','legal_entity','approximate','Приблизительная выручка, агрегатор; не для точной финансовой аналитики','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',33,2021,196000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',33,2021,7598000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',33,2022,2731000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',33,2022,10498000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',33,2023,440000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',33,2023,7177000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',33,2024,2,2243,'reported','verified','legal_entity','exact','Среднесписочная численность за 2024','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',33,2024,-1224000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',33,2024,3852000,2243,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',46,2021,61456000,2220,'reported','verified','legal_entity','exact','Последний опубликованный в карточке год 2021','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',46,2021,895013000,2220,'reported','verified','legal_entity','exact','Последний опубликованный в карточке год 2021','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',47,2021,1957000,2221,'reported','verified','legal_entity','exact','Финансовая карточка: за 2022–2025 нет значений','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',47,2021,552856000,2221,'reported','verified','legal_entity','exact','Финансовая карточка: за 2022–2025 нет значений','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',48,2022,81641000,2223,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',48,2022,2181375000,2223,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',48,2023,153219000,2223,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',48,2023,2264328000,2223,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',49,2021,-13630000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',49,2021,201886000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',49,2022,4152000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',49,2022,174877000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',49,2023,-57494000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',49,2023,151490000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',49,2024,-94182000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',49,2024,164189000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',49,2025,-57460000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',49,2025,286382000,2224,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',52,2025,43386000,2225,'reported','verified','legal_entity','exact','Отчет о финансовых результатах за 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',52,2025,1359000,2225,'reported','verified','legal_entity','exact','Отчет о финансовых результатах за 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',52,2025,45029000,2225,'reported','verified','legal_entity','exact','Отчет о финансовых результатах за 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',67,2025,-10435000,2226,'reported','verified','legal_entity','exact','Финансовая карточка, опубликованное значение в рублях','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',67,2025,139078000,2226,'reported','verified','legal_entity','exact','Финансовая карточка, опубликованное значение в рублях','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',71,2022,9124368000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',71,2022,64947638000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',71,2023,1605712000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',71,2023,58717373000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',71,2024,-1925911000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',71,2024,47226352000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',71,2025,-1970320000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',71,2025,26880872000,2227,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',73,2024,1460913000,2246,'reported','verified','legal_entity','exact','Бухгалтерские значения 2025 и сравнимая выручка за 2024','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',73,2025,1320832000,2246,'reported','verified','legal_entity','exact','Строка 2120 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',73,2025,249,2247,'reported','verified','legal_entity','exact','2025, кадры, человек','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',73,2025,271235000,2246,'reported','verified','legal_entity','exact','Чистая прибыль 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',73,2025,1762488000,2246,'reported','verified','legal_entity','exact','Бухгалтерские значения 2025 и сравнимая выручка за 2024','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',78,2025,51621000,2228,'reported','verified','legal_entity','exact','Финансовые строки бухгалтерской отчетности за 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',78,2025,28045000,2228,'reported','verified','legal_entity','exact','Финансовые строки бухгалтерской отчетности за 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',78,2025,57035000,2228,'reported','verified','legal_entity','exact','Финансовые строки бухгалтерской отчетности за 2025','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',79,2024,10,2229,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',79,2024,13899000,2229,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('employees',79,2025,12,2229,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',79,2025,1672000,2229,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',79,2025,17286000,2229,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',80,2021,13520000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',80,2021,181483000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',80,2022,12705000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',80,2022,155311000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',80,2023,116478000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',80,2023,548495000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',80,2024,67557000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',80,2024,380740000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',80,2025,31075000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',80,2025,383658000,2230,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',81,2021,1235000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',81,2021,95741000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',81,2022,228000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',81,2022,78058000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',81,2023,349000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',81,2023,78863000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',81,2024,1568000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',81,2024,102600000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',81,2025,3000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',81,2025,90049000,2231,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',82,2021,4199000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',82,2021,233353000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',82,2022,302000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',82,2022,184042000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',82,2023,467000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',82,2023,192294000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',82,2024,4793000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',82,2024,304197000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',82,2025,3560000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',82,2025,174391000,2232,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',83,2021,20902000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',83,2021,1095210000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',83,2022,66745000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',83,2022,1975361000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',83,2023,230439000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',83,2023,3225158000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',83,2024,582031000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',83,2024,4270093000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',83,2025,4174000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',83,2025,2805306000,2233,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',84,2024,285029000,2234,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',84,2025,136693000,2234,'reported','verified','legal_entity','exact','Строка 2120','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('gross_profit',84,2025,125574000,2234,'reported','verified','legal_entity','exact','Строка 2100','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',84,2025,22759000,2234,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',84,2025,262267000,2234,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',85,2021,6000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',85,2021,164000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',85,2022,16000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',85,2022,1828000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',85,2023,2000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',85,2023,3516000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',85,2024,7000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',85,2024,1520000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',85,2025,2000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',85,2025,484000,2235,'reported','verified','legal_entity','exact','Таблица финансовых показателей по годам, руб.; источник перепубликует ФНС','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',87,2023,32537000,2236,'reported','verified','legal_entity','exact','Сопоставимая графа в ГИР БО ФНС 2025, строка 1600, тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('equity',87,2023,27514000,2236,'reported','verified','legal_entity','exact','Сопоставимая графа в ГИР БО ФНС 2025, строка 1300, тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',87,2024,39562000,2236,'reported','verified','legal_entity','exact','Сопоставимая графа в ГИР БО ФНС 2025, строка 1600, тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('equity',87,2024,24093000,2236,'reported','verified','legal_entity','exact','Сопоставимая графа в ГИР БО ФНС 2025, строка 1300, тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',87,2024,-3421000,2236,'reported','verified','legal_entity','exact','Сопоставимая графа в ГИР БО ФНС 2025, строка 2400, тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('accounts_payable',87,2025,9086811000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 1520, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('accounts_receivable',87,2025,9105740000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 1230, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('assets',87,2025,9448693000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 1600, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',87,2025,8321973000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 2120, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('equity',87,2025,45590000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 1300, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('fixed_assets',87,2025,8678000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 1150, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('gross_profit',87,2025,1371492000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 2100, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',87,2025,21498000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 2400, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('operating_profit',87,2025,134716000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 2200, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('profit_before_tax',87,2025,299689000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 2300, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',87,2025,9693465000,2236,'reported','verified','legal_entity','exact','ГИР БО 2025, форма 0710002 либо 0710001, строка 2110, единица тыс. руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',89,2024,446597000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('gross_profit',89,2024,166726000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',89,2024,88081000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('operating_profit',89,2024,53264000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('profit_before_tax',89,2024,113262000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',89,2024,613323000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('cost_of_sales',89,2025,308304000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('gross_profit',89,2025,58381000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('net_profit',89,2025,10580000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('operating_profit',89,2025,-54505000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('profit_before_tax',89,2025,14247000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.'),
('revenue',89,2025,366685000,2248,'reported','verified','legal_entity','exact','Таблица отчёта о финансовых результатах ФНС, тысяч руб. ×1000','V4; отчетность по ИНН юридического лица. Вторичный источник не равнозначен заверенному PDF ФНС.')
ON CONFLICT (enterprise_id,metric_code,period_year,reporting_scope) WHERE enterprise_id IS NOT NULL
DO UPDATE SET value_numeric=EXCLUDED.value_numeric,source_id=EXCLUDED.source_id,
 value_kind=EXCLUDED.value_kind,verification_status=EXCLUDED.verification_status,
 precision_kind=EXCLUDED.precision_kind,source_detail=EXCLUDED.source_detail,
 note=EXCLUDED.note, updated_at=now()
WHERE public.metric_values.verification_status <> 'verified';

INSERT INTO public.metric_value_sources(metric_value_id,source_id,source_role,section_or_page)
SELECT mv.id,mv.source_id,CASE WHEN ds.source_type LIKE 'ФНС ГИР БО%' THEN 'primary' ELSE 'secondary' END,mv.source_detail
FROM public.metric_values mv JOIN public.data_sources ds ON ds.id=mv.source_id
WHERE mv.source_id BETWEEN 2201 AND 2999 AND mv.enterprise_id IS NOT NULL
ON CONFLICT(metric_value_id,source_id) DO NOTHING;

INSERT INTO public.metric_catalog(code,scope,category,title,unit,priority,definition) VALUES('investments_territory','territory','Инвестиции','Инвестиции в основной капитал','руб.',1,'Уточнять охват и отчетный период') ON CONFLICT(code) DO NOTHING;

INSERT INTO public.v4_period_observations(city_id,period_from,period_to,period_type,metric_code,numeric_value,source_id,coverage_note) VALUES
(2,'2025-01-01','2025-09-30','nine_months','industrial_output',100200000000,2237,'Орск: январь–сентябрь 2025; отгрузка промышленной продукции 100,2 млрд руб.; опубликовано округлённо'),
(2,'2024-01-01','2024-12-31','annual','average_salary_territory',74200,2237,'Орск: среднемесячная начисленная зарплата на крупных и средних предприятиях; округлено, методика отчёта'),
(2,'2024-01-01','2024-12-31','annual','investments_territory',37100000000,2237,'Орск: инвестиции в основной капитал крупными и средними предприятиями; округлено'),
(2,'2025-01-01','2025-09-30','nine_months','average_salary_territory',87500,2237,'Орск: средняя зарплата крупных и средних предприятий за январь–сентябрь 2025; округлено'),
(2,'2025-10-01','2025-10-31','month_end','registered_unemployment_rate',0.4,2237,'Орск: зарегистрированная безработица на октябрь 2025; не методика МОТ'),
(3,'2025-01-01','2025-01-01','point_in_time','population',549947,2238,'Оренбург: население муниципального образования на 01.01.2025; не только административная городская черта')
ON CONFLICT(city_id,period_from,period_to,metric_code,coverage_note) DO NOTHING;

WITH agg AS (
 SELECT enterprise_id,period_year,
 MAX(value_numeric) FILTER(WHERE metric_code='revenue') revenue,
 MAX(value_numeric) FILTER(WHERE metric_code='net_profit') net_profit,
 MAX(value_numeric) FILTER(WHERE metric_code='employees') employees,
 MAX(value_numeric) FILTER(WHERE metric_code='assets') assets,
 MIN(source_id) FILTER(WHERE metric_code='revenue') revenue_source
 FROM public.metric_values WHERE verification_status='verified' AND reporting_scope='legal_entity'
 AND enterprise_id IN (SELECT enterprise_id FROM public.v4_entity_identity WHERE identity_status='matched_by_inn')
 GROUP BY enterprise_id,period_year
)
INSERT INTO public.enterprise_metrics(enterprise_id,year,revenue,net_profit,employees,assets,source_id)
SELECT enterprise_id,period_year,revenue,net_profit,employees::int,assets,revenue_source FROM agg a
WHERE revenue IS NOT NULL AND NOT EXISTS(SELECT 1 FROM public.enterprise_metrics old WHERE old.enterprise_id=a.enterprise_id AND old.year=a.period_year);
WITH agg AS (
 SELECT enterprise_id,period_year,
 MAX(value_numeric) FILTER(WHERE metric_code='revenue') revenue,
 MAX(value_numeric) FILTER(WHERE metric_code='net_profit') net_profit,
 MAX(value_numeric) FILTER(WHERE metric_code='employees') employees,
 MAX(value_numeric) FILTER(WHERE metric_code='assets') assets
 FROM public.metric_values WHERE verification_status='verified' AND reporting_scope='legal_entity'
 AND source_id BETWEEN 2201 AND 2999
 GROUP BY enterprise_id,period_year
)
UPDATE public.enterprise_metrics em SET revenue=COALESCE(agg.revenue,em.revenue),
 net_profit=COALESCE(agg.net_profit,em.net_profit),employees=COALESCE(agg.employees::integer,em.employees),
 assets=COALESCE(agg.assets,em.assets)
FROM agg WHERE em.enterprise_id=agg.enterprise_id AND em.year=agg.period_year;

CREATE OR REPLACE VIEW public.v4_city_enterprise_coverage AS
 SELECT c.name AS city,e.id AS enterprise_id,e.name AS enterprise,
 ia.researched_inn,ia.entity_kind,ia.identity_status,ia.location_note,
 COUNT(mv.id) FILTER (WHERE mv.verification_status='verified') AS available_verified_values,
 COUNT(DISTINCT mv.period_year) FILTER (WHERE mv.metric_code='revenue' AND mv.verification_status='verified') AS years_of_revenue,
 MAX(mv.period_year) FILTER(WHERE mv.verification_status='verified') AS latest_year
 FROM public.enterprises e JOIN public.cities c ON c.id=e.city_id
 LEFT JOIN public.v4_entity_identity ia ON e.id=ia.enterprise_id
 LEFT JOIN public.metric_values mv ON e.id=mv.enterprise_id AND mv.reporting_scope='legal_entity'
 WHERE e.city_id IN (2,3)
 GROUP BY c.name,e.id,e.name,ia.researched_inn,ia.entity_kind,ia.identity_status,ia.location_note;
CREATE OR REPLACE VIEW public.v4_city_financial_evidence AS
 SELECT c.name AS city,e.id AS enterprise_id,e.name AS enterprise,e.inn,
 mv.period_year,mv.metric_code,mc.title,mv.value_numeric,mc.unit,mv.precision_kind,
 mv.verification_status,ds.name AS source_name,ds.url AS source_url,ds.source_type,
 mv.source_detail
 FROM public.metric_values mv JOIN public.enterprises e ON mv.enterprise_id=e.id
 JOIN public.cities c ON e.city_id=c.id
 JOIN public.metric_catalog mc ON mc.code=mv.metric_code
 JOIN public.data_sources ds ON ds.id=mv.source_id
 WHERE e.city_id IN(2,3) AND mv.reporting_scope='legal_entity' AND mv.verification_status='verified';

COMMIT;