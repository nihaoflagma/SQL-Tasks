--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-03-30 15:56:41

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

--
-- TOC entry 7 (class 2615 OID 16388)
-- Name: pgagent; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pgagent;


ALTER SCHEMA pgagent OWNER TO postgres;

--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA pgagent; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';


--
-- TOC entry 2 (class 3079 OID 16389)
-- Name: pgagent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgagent WITH SCHEMA pgagent;


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgagent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgagent IS 'A PostgreSQL job scheduler';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 239 (class 1259 OID 16704)
-- Name: bicycle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bicycle (
    serial_number character varying(20) NOT NULL,
    model character varying(100) NOT NULL,
    gear_count integer NOT NULL,
    price numeric(10,2) NOT NULL,
    type character varying(20) NOT NULL,
    CONSTRAINT bicycle_type_check CHECK (((type)::text = ANY ((ARRAY['Mountain'::character varying, 'Road'::character varying, 'Hybrid'::character varying])::text[])))
);


ALTER TABLE public.bicycle OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16786)
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    id_booking integer NOT NULL,
    id_room integer,
    id_customer integer,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16785)
-- Name: booking_id_booking_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_id_booking_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_id_booking_seq OWNER TO postgres;

--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 250
-- Name: booking_id_booking_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_id_booking_seq OWNED BY public.booking.id_booking;


--
-- TOC entry 237 (class 1259 OID 16682)
-- Name: car; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car (
    vin character varying(17) NOT NULL,
    model character varying(100) NOT NULL,
    engine_capacity numeric(4,2) NOT NULL,
    horsepower integer NOT NULL,
    price numeric(10,2) NOT NULL,
    transmission character varying(20) NOT NULL,
    CONSTRAINT car_transmission_check CHECK (((transmission)::text = ANY ((ARRAY['Automatic'::character varying, 'Manual'::character varying])::text[])))
);


ALTER TABLE public.car OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16722)
-- Name: cars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cars (
    name character varying(100) NOT NULL,
    class character varying(100) NOT NULL,
    year integer NOT NULL
);


ALTER TABLE public.cars OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16716)
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes (
    class character varying(100) NOT NULL,
    type character varying(20) NOT NULL,
    country character varying(100) NOT NULL,
    numdoors integer NOT NULL,
    enginesize numeric(3,1) NOT NULL,
    weight integer NOT NULL,
    CONSTRAINT classes_type_check CHECK (((type)::text = ANY ((ARRAY['Racing'::character varying, 'Street'::character varying])::text[])))
);


ALTER TABLE public.classes OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16775)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id_customer integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16774)
-- Name: customer_id_customer_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_id_customer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_id_customer_seq OWNER TO postgres;

--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 248
-- Name: customer_id_customer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_id_customer_seq OWNED BY public.customer.id_customer;


--
-- TOC entry 253 (class 1259 OID 16803)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    departmentid integer NOT NULL,
    departmentname character varying(100) NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16802)
-- Name: departments_departmentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_departmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_departmentid_seq OWNER TO postgres;

--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 252
-- Name: departments_departmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_departmentid_seq OWNED BY public.departments.departmentid;


--
-- TOC entry 257 (class 1259 OID 16817)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employeeid integer NOT NULL,
    name character varying(100) NOT NULL,
    "position" character varying(100),
    managerid integer,
    departmentid integer,
    roleid integer
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 16816)
-- Name: employees_employeeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_employeeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employeeid_seq OWNER TO postgres;

--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 256
-- Name: employees_employeeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_employeeid_seq OWNED BY public.employees.employeeid;


--
-- TOC entry 245 (class 1259 OID 16753)
-- Name: hotel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel (
    id_hotel integer NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255) NOT NULL
);


ALTER TABLE public.hotel OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16752)
-- Name: hotel_id_hotel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hotel_id_hotel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotel_id_hotel_seq OWNER TO postgres;

--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 244
-- Name: hotel_id_hotel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hotel_id_hotel_seq OWNED BY public.hotel.id_hotel;


--
-- TOC entry 238 (class 1259 OID 16693)
-- Name: motorcycle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motorcycle (
    vin character varying(17) NOT NULL,
    model character varying(100) NOT NULL,
    engine_capacity numeric(4,2) NOT NULL,
    horsepower integer NOT NULL,
    price numeric(10,2) NOT NULL,
    type character varying(20) NOT NULL,
    CONSTRAINT motorcycle_type_check CHECK (((type)::text = ANY ((ARRAY['Sport'::character varying, 'Cruiser'::character varying, 'Touring'::character varying])::text[])))
);


ALTER TABLE public.motorcycle OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 16839)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    projectid integer NOT NULL,
    projectname character varying(100) NOT NULL,
    startdate date,
    enddate date,
    departmentid integer
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 16838)
-- Name: projects_projectid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_projectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_projectid_seq OWNER TO postgres;

--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 258
-- Name: projects_projectid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_projectid_seq OWNED BY public.projects.projectid;


--
-- TOC entry 242 (class 1259 OID 16732)
-- Name: races; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.races (
    name character varying(100) NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.races OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16737)
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.results (
    car character varying(100) NOT NULL,
    race character varying(100) NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE public.results OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16810)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    roleid integer NOT NULL,
    rolename character varying(100) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16809)
-- Name: roles_roleid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_roleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_roleid_seq OWNER TO postgres;

--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 254
-- Name: roles_roleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_roleid_seq OWNED BY public.roles.roleid;


--
-- TOC entry 247 (class 1259 OID 16762)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    id_room integer NOT NULL,
    id_hotel integer,
    room_type character varying(20) NOT NULL,
    price numeric(10,2) NOT NULL,
    capacity integer NOT NULL,
    CONSTRAINT room_room_type_check CHECK (((room_type)::text = ANY ((ARRAY['Single'::character varying, 'Double'::character varying, 'Suite'::character varying])::text[])))
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16761)
-- Name: room_id_room_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_id_room_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_id_room_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 246
-- Name: room_id_room_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_id_room_seq OWNED BY public.room.id_room;


--
-- TOC entry 261 (class 1259 OID 16851)
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    taskid integer NOT NULL,
    taskname character varying(100) NOT NULL,
    assignedto integer,
    projectid integer
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 16850)
-- Name: tasks_taskid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_taskid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_taskid_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 260
-- Name: tasks_taskid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_taskid_seq OWNED BY public.tasks.taskid;


--
-- TOC entry 236 (class 1259 OID 16676)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle (
    maker character varying(100) NOT NULL,
    model character varying(100) NOT NULL,
    type character varying(20) NOT NULL,
    CONSTRAINT vehicle_type_check CHECK (((type)::text = ANY ((ARRAY['Car'::character varying, 'Motorcycle'::character varying, 'Bicycle'::character varying])::text[])))
);


ALTER TABLE public.vehicle OWNER TO postgres;

--
-- TOC entry 4795 (class 2604 OID 16789)
-- Name: booking id_booking; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN id_booking SET DEFAULT nextval('public.booking_id_booking_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 16778)
-- Name: customer id_customer; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN id_customer SET DEFAULT nextval('public.customer_id_customer_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 16806)
-- Name: departments departmentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN departmentid SET DEFAULT nextval('public.departments_departmentid_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 16820)
-- Name: employees employeeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employeeid SET DEFAULT nextval('public.employees_employeeid_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 16756)
-- Name: hotel id_hotel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel ALTER COLUMN id_hotel SET DEFAULT nextval('public.hotel_id_hotel_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 16842)
-- Name: projects projectid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN projectid SET DEFAULT nextval('public.projects_projectid_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 16813)
-- Name: roles roleid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN roleid SET DEFAULT nextval('public.roles_roleid_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 16765)
-- Name: room id_room; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN id_room SET DEFAULT nextval('public.room_id_room_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 16854)
-- Name: tasks taskid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN taskid SET DEFAULT nextval('public.tasks_taskid_seq'::regclass);


--
-- TOC entry 4754 (class 0 OID 16390)
-- Dependencies: 221
-- Data for Name: pga_jobagent; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobagent (jagpid, jaglogintime, jagstation) FROM stdin;
22460	2025-03-28 14:43:57.15216+03	DESKTOP-P176H5B
\.


--
-- TOC entry 4755 (class 0 OID 16399)
-- Dependencies: 223
-- Data for Name: pga_jobclass; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobclass (jclid, jclname) FROM stdin;
\.


--
-- TOC entry 4756 (class 0 OID 16409)
-- Dependencies: 225
-- Data for Name: pga_job; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobhostagent, jobenabled, jobcreated, jobchanged, jobagentid, jobnextrun, joblastrun) FROM stdin;
\.


--
-- TOC entry 4758 (class 0 OID 16457)
-- Dependencies: 229
-- Data for Name: pga_schedule; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths) FROM stdin;
\.


--
-- TOC entry 4759 (class 0 OID 16485)
-- Dependencies: 231
-- Data for Name: pga_exception; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_exception (jexid, jexscid, jexdate, jextime) FROM stdin;
\.


--
-- TOC entry 4760 (class 0 OID 16499)
-- Dependencies: 233
-- Data for Name: pga_joblog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_joblog (jlgid, jlgjobid, jlgstatus, jlgstart, jlgduration) FROM stdin;
\.


--
-- TOC entry 4757 (class 0 OID 16433)
-- Dependencies: 227
-- Data for Name: pga_jobstep; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstcode, jstconnstr, jstdbname, jstonerror, jscnextrun) FROM stdin;
\.


--
-- TOC entry 4761 (class 0 OID 16515)
-- Dependencies: 235
-- Data for Name: pga_jobsteplog; Type: TABLE DATA; Schema: pgagent; Owner: postgres
--

COPY pgagent.pga_jobsteplog (jslid, jsljlgid, jsljstid, jslstatus, jslresult, jslstart, jslduration, jsloutput) FROM stdin;
\.


--
-- TOC entry 5040 (class 0 OID 16704)
-- Dependencies: 239
-- Data for Name: bicycle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bicycle (serial_number, model, gear_count, price, type) FROM stdin;
SN123456789	Domane	22	3500.00	Road
SN987654321	Defy	20	3000.00	Road
SN456789123	Stumpjumper	30	4000.00	Mountain
\.


--
-- TOC entry 5052 (class 0 OID 16786)
-- Dependencies: 251
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking (id_booking, id_room, id_customer, check_in_date, check_out_date) FROM stdin;
1	1	1	2025-05-01	2025-05-05
2	2	2	2025-05-02	2025-05-06
3	3	3	2025-05-03	2025-05-07
4	4	4	2025-05-04	2025-05-08
5	5	5	2025-05-05	2025-05-09
6	6	6	2025-05-06	2025-05-10
7	7	7	2025-05-07	2025-05-11
8	8	8	2025-05-08	2025-05-12
9	9	9	2025-05-09	2025-05-13
10	10	10	2025-05-10	2025-05-14
11	1	2	2025-05-11	2025-05-15
12	2	3	2025-05-12	2025-05-14
13	3	4	2025-05-13	2025-05-15
14	4	5	2025-05-14	2025-05-16
15	5	6	2025-05-15	2025-05-16
16	6	7	2025-05-16	2025-05-18
17	7	8	2025-05-17	2025-05-21
18	8	9	2025-05-18	2025-05-19
19	9	10	2025-05-19	2025-05-22
20	10	1	2025-05-20	2025-05-22
21	1	2	2025-05-21	2025-05-23
22	2	3	2025-05-22	2025-05-25
23	3	4	2025-05-23	2025-05-26
24	4	5	2025-05-24	2025-05-25
25	5	6	2025-05-25	2025-05-27
26	6	7	2025-05-26	2025-05-29
\.


--
-- TOC entry 5038 (class 0 OID 16682)
-- Dependencies: 237
-- Data for Name: car; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car (vin, model, engine_capacity, horsepower, price, transmission) FROM stdin;
1HGCM82633A123456	Camry	2.50	203	24000.00	Automatic
2HGFG3B53GH123456	Civic	2.00	158	22000.00	Manual
1FA6P8CF0J1234567	Mustang	5.00	450	55000.00	Automatic
\.


--
-- TOC entry 5042 (class 0 OID 16722)
-- Dependencies: 241
-- Data for Name: cars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cars (name, class, year) FROM stdin;
Ford Mustang	SportsCar	2020
BMW 3 Series	Sedan	2019
Toyota RAV4	SUV	2021
Renault Clio	Hatchback	2020
Ferrari 488	Convertible	2019
Chevrolet Camaro	Coupe	2021
Mercedes-Benz S-Class	Luxury Sedan	2022
Ford F-150	Pickup	2021
Audi A4	Sedan	2018
Nissan Rogue	SUV	2020
\.


--
-- TOC entry 5041 (class 0 OID 16716)
-- Dependencies: 240
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes (class, type, country, numdoors, enginesize, weight) FROM stdin;
SportsCar	Racing	USA	2	3.5	1500
Sedan	Street	Germany	4	2.0	1200
SUV	Street	Japan	4	2.5	1800
Hatchback	Street	France	5	1.6	1100
Convertible	Racing	Italy	2	3.0	1300
Coupe	Street	USA	2	2.5	1400
Luxury Sedan	Street	Germany	4	3.0	1600
Pickup	Street	USA	2	2.8	2000
\.


--
-- TOC entry 5050 (class 0 OID 16775)
-- Dependencies: 249
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (id_customer, name, email, phone) FROM stdin;
1	John Doe	john.doe@example.com	+1234567890
2	Jane Smith	jane.smith@example.com	+0987654321
3	Alice Johnson	alice.johnson@example.com	+1122334455
4	Bob Brown	bob.brown@example.com	+2233445566
5	Charlie White	charlie.white@example.com	+3344556677
6	Diana Prince	diana.prince@example.com	+4455667788
7	Ethan Hunt	ethan.hunt@example.com	+5566778899
8	Fiona Apple	fiona.apple@example.com	+6677889900
9	George Washington	george.washington@example.com	+7788990011
10	Hannah Montana	hannah.montana@example.com	+8899001122
\.


--
-- TOC entry 5054 (class 0 OID 16803)
-- Dependencies: 253
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (departmentid, departmentname) FROM stdin;
1	Отдел продаж
2	Отдел маркетинга
3	IT-отдел
4	Отдел разработки
5	Отдел поддержки
\.


--
-- TOC entry 5058 (class 0 OID 16817)
-- Dependencies: 257
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employeeid, name, "position", managerid, departmentid, roleid) FROM stdin;
1	Иван Иванов	Генеральный директор	\N	1	3
2	Петр Петров	Директор по продажам	1	1	2
3	Светлана Светлова	Директор по маркетингу	1	2	2
4	Алексей Алексеев	Менеджер по продажам	2	1	1
5	Мария Мариева	Менеджер по маркетингу	3	2	1
6	Андрей Андреев	Разработчик	1	4	4
7	Елена Еленова	Специалист по поддержке	1	5	5
8	Олег Олегов	Менеджер по продукту	2	1	1
9	Татьяна Татеева	Маркетолог	3	2	6
10	Николай Николаев	Разработчик	6	4	4
11	Ирина Иринина	Разработчик	6	4	4
12	Сергей Сергеев	Специалист по поддержке	7	5	5
13	Кристина Кристинина	Менеджер по продажам	4	1	1
14	Дмитрий Дмитриев	Маркетолог	3	2	6
15	Виктор Викторов	Менеджер по продажам	4	1	1
16	Анастасия Анастасиева	Специалист по поддержке	7	5	5
17	Максим Максимов	Разработчик	6	4	4
18	Людмила Людмилова	Специалист по маркетингу	3	2	6
19	Наталья Натальева	Менеджер по продажам	4	1	1
20	Александр Александров	Менеджер по маркетингу	3	2	1
21	Галина Галина	Специалист по поддержке	7	5	5
22	Павел Павлов	Разработчик	6	4	4
23	Марина Маринина	Специалист по маркетингу	3	2	6
24	Станислав Станиславов	Менеджер по продажам	4	1	1
25	Екатерина Екатеринина	Специалист по поддержке	7	5	5
26	Денис Денисов	Разработчик	6	4	4
27	Ольга Ольгина	Маркетолог	3	2	6
28	Игорь Игорев	Менеджер по продукту	2	1	1
29	Анастасия Анастасиевна	Специалист по поддержке	7	5	5
30	Валентин Валентинов	Разработчик	6	4	4
\.


--
-- TOC entry 5046 (class 0 OID 16753)
-- Dependencies: 245
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel (id_hotel, name, location) FROM stdin;
1	Grand Hotel	Paris, France
2	Ocean View Resort	Miami, USA
3	Mountain Retreat	Aspen, USA
4	City Center Inn	New York, USA
5	Desert Oasis	Las Vegas, USA
6	Lakeside Lodge	Lake Tahoe, USA
7	Historic Castle	Edinburgh, Scotland
8	Tropical Paradise	Bali, Indonesia
9	Business Suites	Tokyo, Japan
10	Eco-Friendly Hotel	Copenhagen, Denmark
\.


--
-- TOC entry 5039 (class 0 OID 16693)
-- Dependencies: 238
-- Data for Name: motorcycle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motorcycle (vin, model, engine_capacity, horsepower, price, type) FROM stdin;
JYARN28E9FA123456	YZF-R1	1.00	200	17000.00	Sport
1HD1ZK3158K123456	Sportster	1.20	70	12000.00	Cruiser
JKBVNAF156A123456	Ninja	0.90	150	14000.00	Sport
\.


--
-- TOC entry 5060 (class 0 OID 16839)
-- Dependencies: 259
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (projectid, projectname, startdate, enddate, departmentid) FROM stdin;
1	Проект A	2025-01-01	2025-12-31	1
2	Проект B	2025-02-01	2025-11-30	2
3	Проект C	2025-03-01	2025-10-31	4
4	Проект D	2025-04-01	2025-09-30	5
5	Проект E	2025-05-01	2025-08-31	3
\.


--
-- TOC entry 5043 (class 0 OID 16732)
-- Dependencies: 242
-- Data for Name: races; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.races (name, date) FROM stdin;
Indy 500	2023-05-28
Le Mans	2023-06-10
Monaco Grand Prix	2023-05-28
Daytona 500	2023-02-19
Spa 24 Hours	2023-07-29
Bathurst 1000	2023-10-08
Nürburgring 24 Hours	2023-06-17
Pikes Peak International Hill Climb	2023-06-25
\.


--
-- TOC entry 5044 (class 0 OID 16737)
-- Dependencies: 243
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.results (car, race, "position") FROM stdin;
Ford Mustang	Indy 500	1
BMW 3 Series	Le Mans	3
Toyota RAV4	Monaco Grand Prix	2
Renault Clio	Daytona 500	5
Ferrari 488	Le Mans	1
Chevrolet Camaro	Monaco Grand Prix	4
Mercedes-Benz S-Class	Spa 24 Hours	2
Ford F-150	Bathurst 1000	6
Audi A4	Nürburgring 24 Hours	8
Nissan Rogue	Pikes Peak International Hill Climb	3
\.


--
-- TOC entry 5056 (class 0 OID 16810)
-- Dependencies: 255
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (roleid, rolename) FROM stdin;
1	Менеджер
2	Директор
3	Генеральный директор
4	Разработчик
5	Специалист по поддержке
6	Маркетолог
\.


--
-- TOC entry 5048 (class 0 OID 16762)
-- Dependencies: 247
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (id_room, id_hotel, room_type, price, capacity) FROM stdin;
1	1	Single	150.00	1
2	1	Double	200.00	2
3	1	Suite	350.00	4
4	2	Single	120.00	1
5	2	Double	180.00	2
6	2	Suite	300.00	4
7	3	Double	250.00	2
8	3	Suite	400.00	4
9	4	Single	100.00	1
10	4	Double	150.00	2
11	5	Single	90.00	1
12	5	Double	140.00	2
13	6	Suite	280.00	4
14	7	Double	220.00	2
15	8	Single	130.00	1
16	8	Double	190.00	2
17	9	Suite	360.00	4
18	10	Single	110.00	1
19	10	Double	160.00	2
\.


--
-- TOC entry 5062 (class 0 OID 16851)
-- Dependencies: 261
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (taskid, taskname, assignedto, projectid) FROM stdin;
1	Задача 1: Подготовка отчета по продажам	4	1
2	Задача 2: Анализ рынка	9	2
3	Задача 3: Разработка нового функционала	10	3
4	Задача 4: Поддержка клиентов	12	4
5	Задача 5: Создание рекламной кампании	5	2
6	Задача 6: Обновление документации	6	3
7	Задача 7: Проведение тренинга для сотрудников	8	1
8	Задача 8: Тестирование нового продукта	11	3
9	Задача 9: Ответы на запросы клиентов	12	4
10	Задача 10: Подготовка маркетинговых материалов	9	2
11	Задача 11: Интеграция с новым API	10	3
12	Задача 12: Настройка системы поддержки	7	5
13	Задача 13: Проведение анализа конкурентов	9	2
14	Задача 14: Создание презентации для клиентов	4	1
15	Задача 15: Обновление сайта	6	3
\.


--
-- TOC entry 5037 (class 0 OID 16676)
-- Dependencies: 236
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicle (maker, model, type) FROM stdin;
Toyota	Camry	Car
Honda	Civic	Car
Ford	Mustang	Car
Yamaha	YZF-R1	Motorcycle
Harley-Davidson	Sportster	Motorcycle
Kawasaki	Ninja	Motorcycle
Trek	Domane	Bicycle
Giant	Defy	Bicycle
Specialized	Stumpjumper	Bicycle
\.


--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 250
-- Name: booking_id_booking_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_id_booking_seq', 1, false);


--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 248
-- Name: customer_id_customer_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_id_customer_seq', 1, false);


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 252
-- Name: departments_departmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_departmentid_seq', 1, false);


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 256
-- Name: employees_employeeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employeeid_seq', 1, false);


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 244
-- Name: hotel_id_hotel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hotel_id_hotel_seq', 1, false);


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 258
-- Name: projects_projectid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_projectid_seq', 1, false);


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 254
-- Name: roles_roleid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_roleid_seq', 1, false);


--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 246
-- Name: room_id_room_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_id_room_seq', 1, false);


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 260
-- Name: tasks_taskid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_taskid_seq', 1, false);


--
-- TOC entry 4848 (class 2606 OID 16709)
-- Name: bicycle bicycle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bicycle
    ADD CONSTRAINT bicycle_pkey PRIMARY KEY (serial_number);


--
-- TOC entry 4866 (class 2606 OID 16791)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id_booking);


--
-- TOC entry 4844 (class 2606 OID 16687)
-- Name: car car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT car_pkey PRIMARY KEY (vin);


--
-- TOC entry 4852 (class 2606 OID 16726)
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (name);


--
-- TOC entry 4850 (class 2606 OID 16721)
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (class);


--
-- TOC entry 4862 (class 2606 OID 16784)
-- Name: customer customer_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_email_key UNIQUE (email);


--
-- TOC entry 4864 (class 2606 OID 16782)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id_customer);


--
-- TOC entry 4868 (class 2606 OID 16808)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (departmentid);


--
-- TOC entry 4872 (class 2606 OID 16822)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employeeid);


--
-- TOC entry 4858 (class 2606 OID 16760)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (id_hotel);


--
-- TOC entry 4846 (class 2606 OID 16698)
-- Name: motorcycle motorcycle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motorcycle
    ADD CONSTRAINT motorcycle_pkey PRIMARY KEY (vin);


--
-- TOC entry 4874 (class 2606 OID 16844)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (projectid);


--
-- TOC entry 4854 (class 2606 OID 16736)
-- Name: races races_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.races
    ADD CONSTRAINT races_pkey PRIMARY KEY (name);


--
-- TOC entry 4856 (class 2606 OID 16741)
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (car, race);


--
-- TOC entry 4870 (class 2606 OID 16815)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (roleid);


--
-- TOC entry 4860 (class 2606 OID 16768)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (id_room);


--
-- TOC entry 4876 (class 2606 OID 16856)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (taskid);


--
-- TOC entry 4842 (class 2606 OID 16681)
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (model);


--
-- TOC entry 4879 (class 2606 OID 16710)
-- Name: bicycle bicycle_model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bicycle
    ADD CONSTRAINT bicycle_model_fkey FOREIGN KEY (model) REFERENCES public.vehicle(model);


--
-- TOC entry 4884 (class 2606 OID 16797)
-- Name: booking booking_id_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public.customer(id_customer);


--
-- TOC entry 4885 (class 2606 OID 16792)
-- Name: booking booking_id_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_id_room_fkey FOREIGN KEY (id_room) REFERENCES public.room(id_room);


--
-- TOC entry 4877 (class 2606 OID 16688)
-- Name: car car_model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT car_model_fkey FOREIGN KEY (model) REFERENCES public.vehicle(model);


--
-- TOC entry 4880 (class 2606 OID 16727)
-- Name: cars cars_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_class_fkey FOREIGN KEY (class) REFERENCES public.classes(class);


--
-- TOC entry 4886 (class 2606 OID 16828)
-- Name: employees employees_departmentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_departmentid_fkey FOREIGN KEY (departmentid) REFERENCES public.departments(departmentid) ON DELETE CASCADE;


--
-- TOC entry 4887 (class 2606 OID 16823)
-- Name: employees employees_managerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_managerid_fkey FOREIGN KEY (managerid) REFERENCES public.employees(employeeid) ON DELETE SET NULL;


--
-- TOC entry 4888 (class 2606 OID 16833)
-- Name: employees employees_roleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_roleid_fkey FOREIGN KEY (roleid) REFERENCES public.roles(roleid) ON DELETE SET NULL;


--
-- TOC entry 4878 (class 2606 OID 16699)
-- Name: motorcycle motorcycle_model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motorcycle
    ADD CONSTRAINT motorcycle_model_fkey FOREIGN KEY (model) REFERENCES public.vehicle(model);


--
-- TOC entry 4889 (class 2606 OID 16845)
-- Name: projects projects_departmentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_departmentid_fkey FOREIGN KEY (departmentid) REFERENCES public.departments(departmentid) ON DELETE CASCADE;


--
-- TOC entry 4881 (class 2606 OID 16742)
-- Name: results results_car_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_car_fkey FOREIGN KEY (car) REFERENCES public.cars(name);


--
-- TOC entry 4882 (class 2606 OID 16747)
-- Name: results results_race_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_race_fkey FOREIGN KEY (race) REFERENCES public.races(name);


--
-- TOC entry 4883 (class 2606 OID 16769)
-- Name: room room_id_hotel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_id_hotel_fkey FOREIGN KEY (id_hotel) REFERENCES public.hotel(id_hotel);


--
-- TOC entry 4890 (class 2606 OID 16857)
-- Name: tasks tasks_assignedto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assignedto_fkey FOREIGN KEY (assignedto) REFERENCES public.employees(employeeid) ON DELETE SET NULL;


--
-- TOC entry 4891 (class 2606 OID 16862)
-- Name: tasks tasks_projectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_projectid_fkey FOREIGN KEY (projectid) REFERENCES public.projects(projectid) ON DELETE CASCADE;


-- Completed on 2025-03-30 15:56:46

--
-- PostgreSQL database dump complete
--

