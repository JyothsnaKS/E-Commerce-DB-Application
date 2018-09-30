drop database commerce;
create database commerce;
\c commerce;
create table customer(
    customer_id varchar(10) primary key,
    customer_name varchar(50) not null,
    email varchar(50),
    state varchar(50),
    city varchar(25),
    country varchar(25),
    postalcode numeric(6),
    password varchar(10) unique not null
);

create table customer_contact(
	customer_id varchar(10),
	contact_no numeric(10),
	foreign key(customer_id) references customer,
	primary key(customer_id,contact_no)
);

create table supplier(
	supplier_id varchar(10) primary key,
	brand_name varchar(50) not null,
	manager varchar(50)
);

create table supplier_contact(
	supplier_id varchar(10),
	contact_no numeric(10),
	foreign key(supplier_id) references supplier,
	primary key(supplier_ID,contact_no)
);

CREATE TABLE products(
	product_id varchar(10) primary key,
	product_name varchar(100),
	description varchar(500),
	price numeric(10,2),
	stock numeric,
	supplier_id varchar(10),
	foreign key(supplier_id) references supplier
);

CREATE TABLE cart(
	cart_id varchar(10) primary key,
	customer_id varchar(10),
	total_price numeric(10,2) default 0,
	foreign key(customer_id) references customer
);


CREATE TABLE includes(
	cart_id varchar(10),
	product_id varchar(10),
	foreign key(cart_id) references cart,
	foreign key(product_id) references products,
	primary key (cart_id, product_id)
);

CREATE TABLE shipper(
	shipper_id varchar(10) primary key,
	company varchar(50) unique,
	manager varchar(50)
);

CREATE TABLE shipper_contact(
	shipper_id varchar(10),
	contact_no numeric(10),
	foreign key(shipper_id) references shipper,
	primary key (shipper_id, contact_no)
);

CREATE TABLE _order(
	order_id varchar(10) primary key,
	cart_id varchar(10),
	shipper_id varchar(10),
	customer_id varchar(10),
    state varchar(50),
    city varchar(25),
    country varchar(25),
    postalcode numeric(6),
	total_price numeric(10,3),
	foreign key(cart_id) references cart,
	foreign key(shipper_id) references shipper,
	foreign key(customer_id) references customer
);

CREATE TABLE is_a(
	order_id varchar(10),
	product_id varchar(10),
	primary key (order_id, product_id),
	foreign key(order_id) references _order,
	foreign key(product_id) references products
);

CREATE TABLE cash(
	payment_id varchar(10),
	order_id varchar(10),
	paid_status boolean,
	primary key (payment_id, order_id),
	foreign key(order_id) references _order
);

CREATE TABLE net_banking(
	payment_id varchar(10),
	order_id varchar(10),
	account_no char(10),
	primary key (payment_id, order_id),
	foreign key(order_id) references _order
);

CREATE TABLE credit(
	payment_id varchar(10),
	order_id varchar(10),
	card_no numeric(16),
	expiry_date char(5),
	cvv numeric(3),
	primary key (payment_id, order_id),
	foreign key(order_id) references _order
);

