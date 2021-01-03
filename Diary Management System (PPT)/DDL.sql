--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9
-- Dumped by pg_dump version 10.9

-- Started on 2019-09-11 15:52:20

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
-- TOC entry 5 (class 2615 OID 24577)
-- Name: DMS; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "DMS";


ALTER SCHEMA "DMS" OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2878 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 202 (class 1259 OID 24622)
-- Name: Batch; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."Batch" (
    batch_id character varying(5) NOT NULL,
    product_id character varying(5) NOT NULL,
    batch_date date NOT NULL,
    milkstock_id character varying(10) NOT NULL,
    slot_time time without time zone,
    batch_quantity numeric(6,0)
);


ALTER TABLE "DMS"."Batch" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 24637)
-- Name: Branch; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."Branch" (
    branch_id character varying(5) NOT NULL,
    branch_name character varying(50) NOT NULL,
    street character varying(50) NOT NULL,
    area character varying(50) NOT NULL,
    city character varying(30) NOT NULL,
    contact numeric(10,0)
);


ALTER TABLE "DMS"."Branch" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 24605)
-- Name: Category; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."Category" (
    category_id character varying(5) NOT NULL,
    category_name character varying(20)
);


ALTER TABLE "DMS"."Category" OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 24590)
-- Name: Milk; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."Milk" (
    milkpurchase_id character varying(10) NOT NULL,
    vendor_id character varying(5) NOT NULL,
    order_date date,
    milkstock_id character varying(10),
    unit_price numeric(5,2),
    quantity numeric(8,2)
);


ALTER TABLE "DMS"."Milk" OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24585)
-- Name: MilkStock; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."MilkStock" (
    milkstock_id character varying(10) NOT NULL,
    ms_date date NOT NULL,
    open_stock numeric(8,2),
    end_stock numeric(8,2)
);


ALTER TABLE "DMS"."MilkStock" OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 24578)
-- Name: MilkVendor; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."MilkVendor" (
    vendor_id character varying(5) NOT NULL,
    vendor_name character varying(50) NOT NULL,
    registration_no character varying(15) NOT NULL,
    contact numeric(10,0),
    address character varying(100)
);


ALTER TABLE "DMS"."MilkVendor" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 24654)
-- Name: OrderItem; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."OrderItem" (
    order_item_id character varying(10) NOT NULL,
    product_id character varying(5) NOT NULL,
    order_id character varying(10) NOT NULL,
    order_quantity numeric(6,0),
    unit_price numeric(6,2)
);


ALTER TABLE "DMS"."OrderItem" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24669)
-- Name: Payment; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."Payment" (
    payment_id character varying(10) NOT NULL,
    payment_date date NOT NULL,
    order_id character varying(10) NOT NULL,
    amount numeric(10,2) NOT NULL
);


ALTER TABLE "DMS"."Payment" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 24610)
-- Name: Product; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."Product" (
    product_id character varying(5) NOT NULL,
    product_name character varying(30) NOT NULL,
    category_id character varying(5) NOT NULL,
    cost_price numeric(6,2),
    profit numeric(5,2),
    product_quantity numeric(6,0) NOT NULL,
    CONSTRAINT "Product_cost_price_check" CHECK ((cost_price > (0)::numeric)),
    CONSTRAINT "Product_profit_check" CHECK ((profit > (0)::numeric))
);


ALTER TABLE "DMS"."Product" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 24642)
-- Name: ProductOrder; Type: TABLE; Schema: DMS; Owner: postgres
--

CREATE TABLE "DMS"."ProductOrder" (
    order_id character varying(10) NOT NULL,
    branch_id character varying(5) NOT NULL,
    order_date date NOT NULL,
    delivery_date date,
    total_amount numeric(10,2),
    status character varying(10),
    CONSTRAINT "ProductOrder_check" CHECK ((delivery_date >= order_date)),
    CONSTRAINT "ProductOrder_status_check" CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'delivered'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE "DMS"."ProductOrder" OWNER TO postgres;

--
-- TOC entry 2866 (class 0 OID 24622)
-- Dependencies: 202
-- Data for Name: Batch; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."Batch" (batch_id, product_id, batch_date, milkstock_id, slot_time, batch_quantity) FROM stdin;
\.


--
-- TOC entry 2867 (class 0 OID 24637)
-- Dependencies: 203
-- Data for Name: Branch; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."Branch" (branch_id, branch_name, street, area, city, contact) FROM stdin;
\.


--
-- TOC entry 2864 (class 0 OID 24605)
-- Dependencies: 200
-- Data for Name: Category; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."Category" (category_id, category_name) FROM stdin;
\.


--
-- TOC entry 2863 (class 0 OID 24590)
-- Dependencies: 199
-- Data for Name: Milk; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."Milk" (milkpurchase_id, vendor_id, order_date, milkstock_id, unit_price, quantity) FROM stdin;
\.


--
-- TOC entry 2862 (class 0 OID 24585)
-- Dependencies: 198
-- Data for Name: MilkStock; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."MilkStock" (milkstock_id, ms_date, open_stock, end_stock) FROM stdin;
\.


--
-- TOC entry 2861 (class 0 OID 24578)
-- Dependencies: 197
-- Data for Name: MilkVendor; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."MilkVendor" (vendor_id, vendor_name, registration_no, contact, address) FROM stdin;
\.


--
-- TOC entry 2869 (class 0 OID 24654)
-- Dependencies: 205
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."OrderItem" (order_item_id, product_id, order_id, order_quantity, unit_price) FROM stdin;
\.


--
-- TOC entry 2870 (class 0 OID 24669)
-- Dependencies: 206
-- Data for Name: Payment; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."Payment" (payment_id, payment_date, order_id, amount) FROM stdin;
\.


--
-- TOC entry 2865 (class 0 OID 24610)
-- Dependencies: 201
-- Data for Name: Product; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."Product" (product_id, product_name, category_id, cost_price, profit, product_quantity) FROM stdin;
\.


--
-- TOC entry 2868 (class 0 OID 24642)
-- Dependencies: 204
-- Data for Name: ProductOrder; Type: TABLE DATA; Schema: DMS; Owner: postgres
--

COPY "DMS"."ProductOrder" (order_id, branch_id, order_date, delivery_date, total_amount, status) FROM stdin;
\.


--
-- TOC entry 2722 (class 2606 OID 24626)
-- Name: Batch Batch_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Batch"
    ADD CONSTRAINT "Batch_pkey" PRIMARY KEY (batch_date, product_id, batch_id);


--
-- TOC entry 2724 (class 2606 OID 24641)
-- Name: Branch Branch_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Branch"
    ADD CONSTRAINT "Branch_pkey" PRIMARY KEY (branch_id);


--
-- TOC entry 2718 (class 2606 OID 24609)
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (category_id);


--
-- TOC entry 2714 (class 2606 OID 24589)
-- Name: MilkStock MilkStock_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."MilkStock"
    ADD CONSTRAINT "MilkStock_pkey" PRIMARY KEY (milkstock_id);


--
-- TOC entry 2710 (class 2606 OID 24582)
-- Name: MilkVendor MilkVendor_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."MilkVendor"
    ADD CONSTRAINT "MilkVendor_pkey" PRIMARY KEY (vendor_id);


--
-- TOC entry 2712 (class 2606 OID 24584)
-- Name: MilkVendor MilkVendor_registration_no_key; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."MilkVendor"
    ADD CONSTRAINT "MilkVendor_registration_no_key" UNIQUE (registration_no);


--
-- TOC entry 2716 (class 2606 OID 24594)
-- Name: Milk Milk_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Milk"
    ADD CONSTRAINT "Milk_pkey" PRIMARY KEY (milkpurchase_id, vendor_id);


--
-- TOC entry 2728 (class 2606 OID 24658)
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (order_item_id);


--
-- TOC entry 2730 (class 2606 OID 24673)
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (payment_id);


--
-- TOC entry 2726 (class 2606 OID 24648)
-- Name: ProductOrder ProductOrder_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."ProductOrder"
    ADD CONSTRAINT "ProductOrder_pkey" PRIMARY KEY (order_id);


--
-- TOC entry 2720 (class 2606 OID 24616)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (product_id);


--
-- TOC entry 2735 (class 2606 OID 24632)
-- Name: Batch Batch_milkstock_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Batch"
    ADD CONSTRAINT "Batch_milkstock_id_fkey" FOREIGN KEY (milkstock_id) REFERENCES "DMS"."MilkStock"(milkstock_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2734 (class 2606 OID 24627)
-- Name: Batch Batch_product_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Batch"
    ADD CONSTRAINT "Batch_product_id_fkey" FOREIGN KEY (product_id) REFERENCES "DMS"."Product"(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2732 (class 2606 OID 24600)
-- Name: Milk Milk_milkstock_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Milk"
    ADD CONSTRAINT "Milk_milkstock_id_fkey" FOREIGN KEY (milkstock_id) REFERENCES "DMS"."MilkStock"(milkstock_id);


--
-- TOC entry 2731 (class 2606 OID 24595)
-- Name: Milk Milk_vendor_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Milk"
    ADD CONSTRAINT "Milk_vendor_id_fkey" FOREIGN KEY (vendor_id) REFERENCES "DMS"."MilkVendor"(vendor_id);


--
-- TOC entry 2738 (class 2606 OID 24664)
-- Name: OrderItem OrderItem_order_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."OrderItem"
    ADD CONSTRAINT "OrderItem_order_id_fkey" FOREIGN KEY (order_id) REFERENCES "DMS"."ProductOrder"(order_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2737 (class 2606 OID 24659)
-- Name: OrderItem OrderItem_product_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."OrderItem"
    ADD CONSTRAINT "OrderItem_product_id_fkey" FOREIGN KEY (product_id) REFERENCES "DMS"."Product"(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2739 (class 2606 OID 24674)
-- Name: Payment Payment_order_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Payment"
    ADD CONSTRAINT "Payment_order_id_fkey" FOREIGN KEY (order_id) REFERENCES "DMS"."ProductOrder"(order_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2736 (class 2606 OID 24649)
-- Name: ProductOrder ProductOrder_branch_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."ProductOrder"
    ADD CONSTRAINT "ProductOrder_branch_id_fkey" FOREIGN KEY (branch_id) REFERENCES "DMS"."Branch"(branch_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2733 (class 2606 OID 24617)
-- Name: Product Product_category_id_fkey; Type: FK CONSTRAINT; Schema: DMS; Owner: postgres
--

ALTER TABLE ONLY "DMS"."Product"
    ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY (category_id) REFERENCES "DMS"."Category"(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2019-09-11 15:52:21

--
-- PostgreSQL database dump complete
--

