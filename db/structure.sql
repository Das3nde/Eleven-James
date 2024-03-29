--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE addresses (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    address_line text,
    apt_unit character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    phone character varying(255),
    type character varying(255),
    addressable_id integer,
    addressable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    selected_shipping boolean DEFAULT false
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admins (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: comment_helps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comment_helps (
    id integer NOT NULL,
    comment_id integer,
    user_id integer,
    helpful boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comment_helps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comment_helps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comment_helps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comment_helps_id_seq OWNED BY comment_helps.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    product_id integer,
    user_id integer,
    description text,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    fit_score integer DEFAULT 0,
    excitement_score integer DEFAULT 0,
    accuracy_score integer DEFAULT 0,
    wear_again_score integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    subject character varying(255),
    message text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: courier_transits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE courier_transits (
    uuid character varying(255) NOT NULL,
    courier_id integer,
    is_signature_required boolean,
    customer character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_instance_id character varying(255)
);


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE customers (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: event_transits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE event_transits (
    uuid character varying(255) NOT NULL,
    event_id integer,
    is_pickup boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_instance_id character varying(255)
);


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    title character varying(255),
    subhead character varying(255),
    description text,
    venue character varying(255),
    address1 character varying(255),
    address2 character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    pickup boolean,
    drop_off boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    date date,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: fedex_transits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fedex_transits (
    uuid character varying(255) NOT NULL,
    shipping_class character varying(255),
    tracking_number character varying(255),
    is_signature_required boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_instance_id character varying(255)
);


--
-- Name: news; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE news (
    id integer NOT NULL,
    title character varying(255),
    description text,
    date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE news_id_seq OWNED BY news.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments (
    id integer NOT NULL,
    user_id integer,
    amount numeric,
    purpose character varying(255),
    status character varying(255),
    cc_last_four character varying(255),
    txn_id character varying(255),
    custom_message text,
    paypal_response_dump text,
    ipn_status character varying(255),
    ipn_custom_message text,
    ipn_response_dump text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- Name: product_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_images (
    id integer NOT NULL,
    product_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone,
    rank integer
);


--
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_images_id_seq OWNED BY product_images.id;


--
-- Name: product_instances; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_instances (
    id character varying(255) NOT NULL,
    product_id integer,
    status_id character varying(255),
    current_size character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    required_size character varying(255),
    is_available boolean,
    is_clean boolean,
    next_status_id character varying(255),
    next_status_table character varying(255),
    prev_status_id character varying(255),
    prev_status_table character varying(255),
    status_table character varying(255)
);


--
-- Name: product_requests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_requests (
    id integer NOT NULL,
    user_id integer,
    date timestamp without time zone,
    product_id integer,
    product_instance_id integer,
    fulfillment_time date,
    removal_time date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: product_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_requests_id_seq OWNED BY product_requests.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    model character varying(255),
    quantity integer,
    collection character varying(255),
    brand character varying(255),
    case_diameter integer,
    face_color character varying(255),
    case_material character varying(255),
    band_color character varying(255),
    band_material character varying(255),
    band_name character varying(255),
    reference character varying(255),
    family character varying(255),
    description text,
    cost integer,
    retail_price integer,
    dial_style character varying(255),
    hand_color character varying(255),
    clasp_type character varying(255),
    is_used boolean,
    movement character varying(255),
    power_reserve character varying(255),
    bezel_type character varying(255),
    purchase_date date,
    vendor_id character varying(255),
    bucketed_classification character varying(255),
    water_resistance integer,
    is_borrowed boolean,
    return_date date,
    is_new_arrival boolean,
    is_featured boolean,
    banner_image_file_name character varying(255),
    banner_image_content_type character varying(255),
    banner_image_file_size integer,
    banner_image_updated_at timestamp without time zone,
    banner_display boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: records; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE records (
    uuid character varying(255) NOT NULL,
    product_instance_id character varying(255),
    "table" character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    due_date timestamp without time zone,
    est_start_date timestamp without time zone,
    est_end_date timestamp without time zone,
    next_id character varying(255),
    next_table character varying(255)
);


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE referrals (
    id integer NOT NULL,
    user_id integer,
    email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255)
);


--
-- Name: referrals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE referrals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referrals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE referrals_id_seq OWNED BY referrals.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: rotations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rotations (
    uuid character varying(255) NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_instance_id character varying(255)
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: selections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE selections (
    id integer NOT NULL,
    pairings text,
    date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: selections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE selections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: selections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE selections_id_seq OWNED BY selections.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE services (
    uuid character varying(255) NOT NULL,
    requested_size character varying(255),
    cleaning boolean,
    repair_description text,
    vendor_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    product_instance_id character varying(255)
);


--
-- Name: storage_records; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE storage_records (
    uuid character varying(255) NOT NULL,
    bin_number integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_available boolean,
    product_instance_id character varying(255)
);


--
-- Name: super_admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE super_admins (
    id integer NOT NULL,
    email character varying(255),
    password_hash character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: super_admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE super_admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: super_admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE super_admins_id_seq OWNED BY super_admins.id;


--
-- Name: tiers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tiers (
    id integer NOT NULL,
    name character varying(255),
    cost integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tiers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tiers_id_seq OWNED BY tiers.id;


--
-- Name: unarranged_transits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE unarranged_transits (
    uuid character varying(255) NOT NULL,
    product_instance_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255),
    transit_table character varying(255),
    username character varying(255),
    rental_months character varying(255),
    paypal_authorization_token character varying(255),
    approved boolean DEFAULT false,
    paypal_profile_id character varying(255),
    payment_mode character varying(255),
    paid_till timestamp without time zone
);


--
-- Name: users_admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_admins (
    user_id integer,
    admin_id integer
);


--
-- Name: users_customers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_customers (
    user_id integer,
    customer_id integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE vendors (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone integer,
    fax integer,
    email character varying(255),
    website character varying(255),
    city character varying(255),
    state character varying(255),
    postal_code character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vendors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vendors_id_seq OWNED BY vendors.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_helps ALTER COLUMN id SET DEFAULT nextval('comment_helps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY news ALTER COLUMN id SET DEFAULT nextval('news_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_images ALTER COLUMN id SET DEFAULT nextval('product_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_requests ALTER COLUMN id SET DEFAULT nextval('product_requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY referrals ALTER COLUMN id SET DEFAULT nextval('referrals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY selections ALTER COLUMN id SET DEFAULT nextval('selections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY super_admins ALTER COLUMN id SET DEFAULT nextval('super_admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tiers ALTER COLUMN id SET DEFAULT nextval('tiers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vendors ALTER COLUMN id SET DEFAULT nextval('vendors_id_seq'::regclass);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: comment_helps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comment_helps
    ADD CONSTRAINT comment_helps_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: courier_transits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY courier_transits
    ADD CONSTRAINT courier_transits_pkey PRIMARY KEY (uuid);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: event_transits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY event_transits
    ADD CONSTRAINT event_transits_pkey PRIMARY KEY (uuid);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: fedex_transits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fedex_transits
    ADD CONSTRAINT fedex_transits_pkey PRIMARY KEY (uuid);


--
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: product_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_instances
    ADD CONSTRAINT product_instances_pkey PRIMARY KEY (id);


--
-- Name: product_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_requests
    ADD CONSTRAINT product_requests_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: records_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_pkey PRIMARY KEY (uuid);


--
-- Name: referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: rotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rotations
    ADD CONSTRAINT rotations_pkey PRIMARY KEY (uuid);


--
-- Name: selections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY selections
    ADD CONSTRAINT selections_pkey PRIMARY KEY (id);


--
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (uuid);


--
-- Name: storage_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY storage_records
    ADD CONSTRAINT storage_records_pkey PRIMARY KEY (uuid);


--
-- Name: super_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY super_admins
    ADD CONSTRAINT super_admins_pkey PRIMARY KEY (id);


--
-- Name: tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tiers
    ADD CONSTRAINT tiers_pkey PRIMARY KEY (id);


--
-- Name: unarranged_transits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY unarranged_transits
    ADD CONSTRAINT unarranged_transits_pkey PRIMARY KEY (uuid);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: index_admins_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_admins_on_name ON admins USING btree (name);


--
-- Name: index_admins_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_admins_on_name_and_resource_type_and_resource_id ON admins USING btree (name, resource_type, resource_id);


--
-- Name: index_courier_transits_courier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_courier_transits_courier_id ON courier_transits USING btree (courier_id);


--
-- Name: index_customers_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_customers_on_name ON customers USING btree (name);


--
-- Name: index_customers_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_customers_on_name_and_resource_type_and_resource_id ON customers USING btree (name, resource_type, resource_id);


--
-- Name: index_event_transits_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_event_transits_on_event_id ON event_transits USING btree (event_id);


--
-- Name: index_fedex_transits_on_tracking_number; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_fedex_transits_on_tracking_number ON fedex_transits USING btree (tracking_number);


--
-- Name: index_product_images_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_images_on_product_id ON product_images USING btree (product_id);


--
-- Name: index_product_instances_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_instances_on_product_id ON product_instances USING btree (product_id);


--
-- Name: index_product_requests_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_requests_on_product_id ON product_requests USING btree (product_id);


--
-- Name: index_product_requests_on_product_instance_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_requests_on_product_instance_id ON product_requests USING btree (product_instance_id);


--
-- Name: index_product_requests_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_requests_on_user_id ON product_requests USING btree (user_id);


--
-- Name: index_records_on_product_instance_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_records_on_product_instance_id ON records USING btree (product_instance_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_rotations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rotations_on_user_id ON rotations USING btree (user_id);


--
-- Name: index_services_on_vendor_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_services_on_vendor_id ON services USING btree (vendor_id);


--
-- Name: index_users_admins_on_user_id_and_admin_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_admins_on_user_id_and_admin_id ON users_admins USING btree (user_id, admin_id);


--
-- Name: index_users_customers_on_user_id_and_customer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_customers_on_user_id_and_customer_id ON users_customers USING btree (user_id, customer_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130322211256');

INSERT INTO schema_migrations (version) VALUES ('20130322211258');

INSERT INTO schema_migrations (version) VALUES ('20130322211302');

INSERT INTO schema_migrations (version) VALUES ('20130402212215');

INSERT INTO schema_migrations (version) VALUES ('20130402212439');

INSERT INTO schema_migrations (version) VALUES ('20130402212449');

INSERT INTO schema_migrations (version) VALUES ('20130415192033');

INSERT INTO schema_migrations (version) VALUES ('20130415193340');

INSERT INTO schema_migrations (version) VALUES ('20130423181253');

INSERT INTO schema_migrations (version) VALUES ('20130423182003');

INSERT INTO schema_migrations (version) VALUES ('20130424183325');

INSERT INTO schema_migrations (version) VALUES ('20130426190857');

INSERT INTO schema_migrations (version) VALUES ('20130427014555');

INSERT INTO schema_migrations (version) VALUES ('20130427052203');

INSERT INTO schema_migrations (version) VALUES ('20130428042604');

INSERT INTO schema_migrations (version) VALUES ('20130428070137');

INSERT INTO schema_migrations (version) VALUES ('20130428071748');

INSERT INTO schema_migrations (version) VALUES ('20130429175917');

INSERT INTO schema_migrations (version) VALUES ('20130429201415');

INSERT INTO schema_migrations (version) VALUES ('20130516191952');

INSERT INTO schema_migrations (version) VALUES ('20130516192342');

INSERT INTO schema_migrations (version) VALUES ('20130517214051');

INSERT INTO schema_migrations (version) VALUES ('20130520181454');

INSERT INTO schema_migrations (version) VALUES ('20130520182012');

INSERT INTO schema_migrations (version) VALUES ('20130520200417');

INSERT INTO schema_migrations (version) VALUES ('20130520211418');

INSERT INTO schema_migrations (version) VALUES ('20130520211914');

INSERT INTO schema_migrations (version) VALUES ('20130520212246');

INSERT INTO schema_migrations (version) VALUES ('20130520214053');

INSERT INTO schema_migrations (version) VALUES ('20130520214323');

INSERT INTO schema_migrations (version) VALUES ('20130520224240');

INSERT INTO schema_migrations (version) VALUES ('20130520232224');

INSERT INTO schema_migrations (version) VALUES ('20130522200052');

INSERT INTO schema_migrations (version) VALUES ('20130524045007');

INSERT INTO schema_migrations (version) VALUES ('20130524204110');

INSERT INTO schema_migrations (version) VALUES ('20130530041143');

INSERT INTO schema_migrations (version) VALUES ('20130530101001');

INSERT INTO schema_migrations (version) VALUES ('20130530181344');

INSERT INTO schema_migrations (version) VALUES ('20130602065013');

INSERT INTO schema_migrations (version) VALUES ('20130603200704');

INSERT INTO schema_migrations (version) VALUES ('20130603213001');

INSERT INTO schema_migrations (version) VALUES ('20130605073056');

INSERT INTO schema_migrations (version) VALUES ('20130605190928');

INSERT INTO schema_migrations (version) VALUES ('20130606051439');

INSERT INTO schema_migrations (version) VALUES ('20130607164306');

INSERT INTO schema_migrations (version) VALUES ('20130613174634');

INSERT INTO schema_migrations (version) VALUES ('20130613175859');

INSERT INTO schema_migrations (version) VALUES ('20130619175903');

INSERT INTO schema_migrations (version) VALUES ('20130620093126');

INSERT INTO schema_migrations (version) VALUES ('20130627104513');

INSERT INTO schema_migrations (version) VALUES ('20130627135825');

INSERT INTO schema_migrations (version) VALUES ('20130627152319');

INSERT INTO schema_migrations (version) VALUES ('20130627154001');

INSERT INTO schema_migrations (version) VALUES ('20130628104352');

INSERT INTO schema_migrations (version) VALUES ('20130703143906');

INSERT INTO schema_migrations (version) VALUES ('20130709000105');

INSERT INTO schema_migrations (version) VALUES ('20130709001653');

INSERT INTO schema_migrations (version) VALUES ('20130709061015');

INSERT INTO schema_migrations (version) VALUES ('20130718174103');

INSERT INTO schema_migrations (version) VALUES ('20130718183917');

INSERT INTO schema_migrations (version) VALUES ('20130726091847');

INSERT INTO schema_migrations (version) VALUES ('20130730174936');

INSERT INTO schema_migrations (version) VALUES ('20130801165705');

INSERT INTO schema_migrations (version) VALUES ('20130805140335');

INSERT INTO schema_migrations (version) VALUES ('20130807150041');

INSERT INTO schema_migrations (version) VALUES ('20130807152953');

INSERT INTO schema_migrations (version) VALUES ('20130812094801');

INSERT INTO schema_migrations (version) VALUES ('20130812125427');