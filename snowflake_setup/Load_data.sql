create warehouse transforming;
create database raw;
create database analytics;
create schema raw.jaffle_shop;
create schema raw.stripe;
create or replace stage raw.jaffle_shop.dbt_tutorial;

create table raw.jaffle_shop.customers (    
    id integer,
    first_name varchar,
    last_name varchar,
    email varchar
);

copy into raw.jaffle_shop.customers
from @raw.jaffle_shop.dbt_tutorial/raw_customers.csv
file_format = (type = 'csv' field_optionally_enclosed_by = '"' skip_header = 1);


create table raw.jaffle_shop.orders( 
    id integer,
    user_id integer,
    order_date date,
    status varchar
);

copy into raw.jaffle_shop.orders
from @raw.jaffle_shop.dbt_tutorial/raw_orders.csv
file_format = (type = 'csv' field_optionally_enclosed_by = '"' skip_header = 1);

create table raw.stripe.payment ( 
    id integer,
    orderid integer,
    paymentmethod varchar,
    amount integer
);

copy into raw.stripe.payment
from @raw.jaffle_shop.dbt_tutorial/raw_payments.csv
file_format = (type = 'csv' field_optionally_enclosed_by = '"' skip_header = 1);

select * from raw.jaffle_shop.customers;
select * from raw.jaffle_shop.orders;
select * from raw.stripe.payment;

drop table raw.public.my_first_dbt_model;
drop view raw.public.my_second_dbt_model;
drop view raw.public.customers;