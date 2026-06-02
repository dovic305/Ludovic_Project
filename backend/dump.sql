--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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
-- Name: allergies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.allergies (
    id integer NOT NULL,
    patient_id integer,
    allergy_name character varying(100) NOT NULL,
    severity character varying(50)
);


--
-- Name: allergies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.allergies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: allergies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.allergies_id_seq OWNED BY public.allergies.id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    patient_id integer,
    doctor_id integer,
    appointment_date timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'scheduled'::character varying,
    reason character varying(255) DEFAULT 'Follow-up'::character varying,
    CONSTRAINT appointments_status_check CHECK (((status)::text = ANY ((ARRAY['scheduled'::character varying, 'completed'::character varying, 'cancelled'::character varying, 'no_show'::character varying])::text[])))
);


--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: doctor_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doctor_notes (
    id integer NOT NULL,
    patient_id integer,
    doctor_id integer,
    note_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: doctor_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.doctor_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: doctor_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.doctor_notes_id_seq OWNED BY public.doctor_notes.id;


--
-- Name: help_desk_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.help_desk_requests (
    id integer NOT NULL,
    user_id integer,
    email character varying(255) NOT NULL,
    subject character varying(255) DEFAULT 'Password Reset Request'::character varying,
    message text NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying,
    admin_response text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: help_desk_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.help_desk_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: help_desk_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.help_desk_requests_id_seq OWNED BY public.help_desk_requests.id;


--
-- Name: medical_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medical_history (
    id integer NOT NULL,
    patient_id integer,
    condition character varying(255) NOT NULL,
    date_diagnosed date,
    notes text
);


--
-- Name: medical_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medical_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medical_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medical_history_id_seq OWNED BY public.medical_history.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patients (
    user_id integer NOT NULL,
    date_of_birth date,
    contact_number character varying(20),
    blood_type character varying(5),
    emergency_contact_name character varying(100),
    emergency_contact_number character varying(20),
    address text,
    gender character varying(20)
);


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    permission_id integer NOT NULL,
    permission_name character varying(100) NOT NULL
);


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_permission_id_seq OWNED BY public.permissions.permission_id;


--
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prescriptions (
    id integer NOT NULL,
    patient_id integer,
    doctor_id integer,
    medication character varying(100) NOT NULL,
    dosage character varying(50) NOT NULL,
    frequency character varying(50) NOT NULL,
    start_date date,
    end_date date
);


--
-- Name: prescriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prescriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prescriptions_id_seq OWNED BY public.prescriptions.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL
);


--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    specialty character varying(100),
    phone character varying(20),
    reset_code character varying(10),
    reset_code_expires timestamp without time zone,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['patient'::character varying, 'doctor'::character varying, 'nurse'::character varying, 'admin'::character varying])::text[])))
);


--
-- Name: staff; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.staff AS
 SELECT u.id AS staff_id,
    u.id AS user_id,
    r.role_id,
    u.phone AS phone_number,
    u.created_at,
    u.full_name,
    u.email,
    u.role AS user_role,
    u.specialty
   FROM (public.users u
     LEFT JOIN public.roles r ON ((lower((u.role)::text) = lower((r.role_name)::text))))
  WHERE ((u.role)::text = ANY ((ARRAY['doctor'::character varying, 'nurse'::character varying, 'admin'::character varying])::text[]));


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
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
-- Name: allergies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergies ALTER COLUMN id SET DEFAULT nextval('public.allergies_id_seq'::regclass);


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: doctor_notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_notes ALTER COLUMN id SET DEFAULT nextval('public.doctor_notes_id_seq'::regclass);


--
-- Name: help_desk_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.help_desk_requests ALTER COLUMN id SET DEFAULT nextval('public.help_desk_requests_id_seq'::regclass);


--
-- Name: medical_history id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_history ALTER COLUMN id SET DEFAULT nextval('public.medical_history_id_seq'::regclass);


--
-- Name: permissions permission_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN permission_id SET DEFAULT nextval('public.permissions_permission_id_seq'::regclass);


--
-- Name: prescriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions ALTER COLUMN id SET DEFAULT nextval('public.prescriptions_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: allergies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.allergies (id, patient_id, allergy_name, severity) FROM stdin;
1	5	Penicillin	Severe
2	6	Peanuts	Moderate
3	6	Pollen	Mild
4	7	sea food	Unknown
5	8	Rice	Unknown
6	9	ALlergic to fauls cock	Unknown
\.


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.appointments (id, patient_id, doctor_id, appointment_date, status, reason) FROM stdin;
1	5	2	2026-05-01 10:00:00	scheduled	Follow-up
3	5	3	2026-04-10 09:00:00	completed	Follow-up
4	7	3	2026-05-11 08:14:00	completed	tonsill
2	6	3	2026-05-02 14:30:00	completed	Follow-up
\.


--
-- Data for Name: doctor_notes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.doctor_notes (id, patient_id, doctor_id, note_text, created_at) FROM stdin;
1	5	2	Patient is doing well. Blood pressure is stable. Advised to continue current diet.	2026-05-06 18:56:23.313965
2	6	3	Asthma symptoms have been mild recently. Refilled inhaler prescription.	2026-05-06 18:56:23.313965
\.


--
-- Data for Name: help_desk_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.help_desk_requests (id, user_id, email, subject, message, status, admin_response, created_at) FROM stdin;
\.


--
-- Data for Name: medical_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medical_history (id, patient_id, condition, date_diagnosed, notes) FROM stdin;
1	5	Hypertension	2019-03-10	Controlled with medication
2	5	Type 2 Diabetes	2021-08-15	Diet controlled
3	6	Asthma	2005-04-20	Uses inhaler as needed
4	7	chest pain	2026-05-11	Reported on Registration
5	8	Normal	2026-05-11	Reported on Registration
6	9	big dick	2026-05-22	Reported on Registration
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patients (user_id, date_of_birth, contact_number, blood_type, emergency_contact_name, emergency_contact_number, address, gender) FROM stdin;
5	1985-06-15	555-0101	O+	Jane Doe	555-0102	\N	\N
6	1992-11-23	555-0201	A-	Robert Lee	555-0202	\N	\N
8	2026-05-11	5677777	A-	Junior Cris	5612678	\N	\N
9	2026-05-06	7783452	O-	Robert Pau	5059374	\N	\N
7	2004-03-05	7723421	AB-	Joseph Tonny	7364948	Manplace	\N
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.permissions (permission_id, permission_name) FROM stdin;
\.


--
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.prescriptions (id, patient_id, doctor_id, medication, dosage, frequency, start_date, end_date) FROM stdin;
1	5	2	Lisinopril	10mg	Once daily	2023-01-01	2024-01-01
2	6	3	Albuterol Inhaler	90mcg	As needed	2023-05-15	2024-05-15
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_permissions (role_id, permission_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (role_id, role_name) FROM stdin;
1	Admin
2	Doctor
3	Nurse
4	Patient
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, password_hash, role, full_name, email, created_at, specialty, phone, reset_code, reset_code_expires) FROM stdin;
1	admin1	$2b$10$7V15Ifz7Bn3uEYR1tYw79OG.qdukOJAq.Jai5virYvmd/FR20moNu	admin	System Admin	admin@health.com	2026-05-06 18:56:23.260529	\N	\N	\N	\N
2	doc_smith	$2b$10$7V15Ifz7Bn3uEYR1tYw79OK3Hf3SgAvRjpe77M2cQYPhyT.8rxhlq	doctor	Dr. Sarah Smith	drsmith@health.com	2026-05-06 18:56:23.260529	\N	\N	\N	\N
3	doc_jones	$2b$10$7V15Ifz7Bn3uEYR1tYw79OK3Hf3SgAvRjpe77M2cQYPhyT.8rxhlq	doctor	Dr. Mike Jones	drlee@health.com	2026-05-06 18:56:23.260529	\N	\N	\N	\N
4	nurse_joy	$2b$10$7V15Ifz7Bn3uEYR1tYw79O32EoIJ4yGCQ3HvRYckcWqvM8NZf7BaG	nurse	Nurse Joy	echen@health.com	2026-05-06 18:56:23.260529	\N	\N	\N	\N
5	pat_doe	$2b$10$7V15Ifz7Bn3uEYR1tYw79OtbfmEb1wbOmF2l38ifBpO0vj5aEN67m	patient	John Doe	john.doe@example.com	2026-05-06 18:56:23.260529	\N	\N	\N	\N
6	pat_lee	$2b$10$7V15Ifz7Bn3uEYR1tYw79OtbfmEb1wbOmF2l38ifBpO0vj5aEN67m	patient	Amanda Lee	amanda.lee@example.com	2026-05-06 18:56:23.260529	\N	\N	\N	\N
8	jc430	$2b$10$wDlYM.7gS7ouzPU6y4a6quEMUNBIMKz4GVhFydLQL9U5jBxMy2lNC	patient	Junior Cris	jc@gmail.com	2026-05-11 18:44:44.591027	\N	\N	\N	\N
9	elirarua006284	$2b$10$6LDNsoGGVxEIktE1P5lXKO2CmUE7Nm5/xAqd5QE7Coc9bVLvNFWqW	patient	Elijah Rarua	elirarua006@gmail.com	2026-05-22 14:43:06.375339	\N	\N	418958	2026-05-22 15:44:40.509
7	willybong218	$2b$10$0.Fe6DB5pI5vTFpCQSml4uoe7k2x84hN1V0Ag4SeSwhUUzLZQnpIa	patient	willy Bong	willybong@gmail.com	2026-05-11 18:01:22.074762	\N	\N	\N	\N
\.


--
-- Name: allergies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.allergies_id_seq', 6, true);


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.appointments_id_seq', 4, true);


--
-- Name: doctor_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.doctor_notes_id_seq', 2, true);


--
-- Name: help_desk_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.help_desk_requests_id_seq', 1, false);


--
-- Name: medical_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medical_history_id_seq', 6, true);


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permissions_permission_id_seq', 1, false);


--
-- Name: prescriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.prescriptions_id_seq', 2, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- Name: allergies allergies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergies
    ADD CONSTRAINT allergies_pkey PRIMARY KEY (id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: doctor_notes doctor_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_notes
    ADD CONSTRAINT doctor_notes_pkey PRIMARY KEY (id);


--
-- Name: help_desk_requests help_desk_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.help_desk_requests
    ADD CONSTRAINT help_desk_requests_pkey PRIMARY KEY (id);


--
-- Name: medical_history medical_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_history
    ADD CONSTRAINT medical_history_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (user_id);


--
-- Name: permissions permissions_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_permission_name_key UNIQUE (permission_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permission_id);


--
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: allergies allergies_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergies
    ADD CONSTRAINT allergies_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(user_id) ON DELETE CASCADE;


--
-- Name: appointments appointments_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: appointments appointments_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(user_id) ON DELETE CASCADE;


--
-- Name: doctor_notes doctor_notes_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_notes
    ADD CONSTRAINT doctor_notes_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: doctor_notes doctor_notes_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctor_notes
    ADD CONSTRAINT doctor_notes_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(user_id) ON DELETE CASCADE;


--
-- Name: help_desk_requests help_desk_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.help_desk_requests
    ADD CONSTRAINT help_desk_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: medical_history medical_history_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_history
    ADD CONSTRAINT medical_history_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(user_id) ON DELETE CASCADE;


--
-- Name: patients patients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: prescriptions prescriptions_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: prescriptions prescriptions_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(user_id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(permission_id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

