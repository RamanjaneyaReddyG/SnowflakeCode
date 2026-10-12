create database test;
create schema test_schema;

create table customer (
customer_id	INT, 
first_name varchar,	
last_name varchar,	
city varchar,
joined_date date
);
show file formats;
desc file format csv_type;
create or replace file format csv_type
SKIP_HEADER=1
FIELD_DELIMITER=','
RECORD_DELIMITER='\n'
DATE_FORMAT='DD-MM-YYYY';

CREATE OR REPLACE STAGE EXT_S3
    URL = 's3://raman-snowflake/sourcedata/'
    CREDENTIALS = (
        AWS_KEY_ID = 'AKIAWXZCPMDJXVBCK2XT'
        AWS_SECRET_KEY = 'amlWQpwFwEjztp9nCy4hokJre1lzEEXHaw7E1AHD'
    )
    FILE_FORMAT = (
        FORMAT_NAME = 'CSV_TYPE'
    );

CREATE OR REPLACE STORAGE INTEGRATION s3_int
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 'S3'
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::463391908051:role/AWS_data_Ingestion'
    STORAGE_ALLOWED_LOCATIONS = ('s3://raman-snowflake/sourcedata/');

    desc integration s3_int;

    show stages;

    create or replace stage s3_stage
    file_format=csv_type
    storage_integration=s3_int
    URL='s3://raman-snowflake/sourcedata/';

    CREATE OR REPLACE STAGE s3_stage
  URL = 's3://raman-snowflake/sourcedata/'
  STORAGE_INTEGRATION = S3_INT
  FILE_FORMAT = CSV_TYPE;

    list @s3_stage;

copy into test.test_schema.s3_customer
from @s3_stage;

select * from test.test_schema.s3_customer;

show stages;
LIST @EXT_S3;


create pipe awspipe
AUTO_INGEST=true
as 
copy into test.test_schema.s3_customer
from @s3_stage;

show pipes;

select * from test.test_schema.s3_customer;

select SYSTEM$PIPE_STATUS('awspipe'); --lastReceivedMessageTimestamp":"2026-09-24T17:59:27.253Z","lastPulledFromChannelTimestamp":"2026-

create table s3_customer like customer;

alter file format csv_type
set parse_header=false;

copy into s3_customer
from @EXT_S3; 
--FILES=('customers.csv');
--credentials=(aws_key_id='AKIAWXZCPMDJXVBCK2XT' aws_secret_key='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');

select * from s3_customer;

select $1, $2 from @Ext_s3;

create database demo;
create schema demo_schema;

create stage demo.demo_schema.bike_stage;

LIST @BIKE_STAGE;

desc file format csv_type;

CREATE OR REPLACE FILE FORMAT csv_type
    TYPE = 'CSV'
    SKIP_HEADER = 1
    FIELD_DELIMITER = ','
    RECORD_DELIMITER = '\n'
    DATE_FORMAT = 'DD-MM-YYYY';

SELECT
    t.$1,
    t.$2,
    t.$3
FROM @demo.demo_schema.bike_stage
    (FILE_FORMAT => 'demo.demo_schema.csv_type') t;


    CREATE OR REPLACE TABLE DEMO.DEMO_SCHEMA.BIKE (

		RIDE_ID STRING,
		RIDEABLE_TYPE STRING,
		STARTED_AT STRING,
		ENDED_AT STRING,
		START_STATION_NAME STRING,
		START_STATIO_ID STRING,
		END_STATION_NAME STRING,
		END_STATION_ID STRING,
		START_LAT STRING,
		START_LNG STRING,
		END_LAT STRING,
		END_LNG STRING,
		MEMBER_CSUAL STRING);

COPY INTO demo.demo_schema.bike
from (
SELECT
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    t.$7,
    t.$8,
    t.$9,
    t.$10,
    t.$11,
    t.$12,
    t.$13
FROM @demo.demo_schema.bike_stage
    (FILE_FORMAT => 'demo.demo_schema.csv_type') t
);

select * from bike limit 4;
select count(*) from bike; --limit 4;

create warehouse DW_Large
WAREHOUSE_TYPE='STANDARD'
WAREHOUSE_SIZE='LARGE'
Initially_suspended=true;

USE SECONDARY ROLES ALL;
create role analyst;

grant role analyst to user ramanjasper3;
use role analyst;

grant usage on database demo to role analyst;
grant usage on schema demo_schema to role analyst;


show stages;
----26-09-2026

create or replace external table s3_ext_customer
with location=@s3_stage
file_format= csv_type;

select VALUE:c3::varchar as ID, value from s3_ext_customer;

show tables;

select * from bike; --688ms --54ms

Create or replace table orders_raw (
order_id int,
product_name varchar,
price double,
created_at date
);

Create or replace table orders_processed (
order_id int,
product_name varchar,
price double,
created_at date,
processed_at date
);

INSERT INTO orders_raw (order_id, product_name, price, created_at)
VALUES
(101, 'Laptop',        65000.00, '2026-09-01'),
(102, 'Mobile Phone',  35000.00, '2026-09-02'),
(103, 'Headphones',     2500.00, '2026-09-03'),
(104, 'Keyboard',       1800.00, '2026-09-04'),
(105, 'Mouse',           900.00, '2026-09-05'),
(106, 'Monitor',       18000.00, '2026-09-06'),
(107, 'USB Cable',       500.00, '2026-09-07'),
(108, 'Webcam',         4500.00, '2026-09-08'),
(109, 'Laptop Stand',   1500.00, '2026-09-09'),
(110, 'Power Bank',     3000.00, '2026-09-10');

select * from orders_raw;


create or replace stream orders_stream on table orders_raw;

show streams;

create or replace task process_new_orders
    warehouse=compute_wh,
    schedule='1 minute'
when
    system$stream_has_data('orders_stream')
as
insert into orders_processed
select
    order_id,
    product_name,
    price,DEMO.DEMO_SCHEMA.BIKEDEMO.DEMO_SCHEMA.BIKEDEMO
    created_at,
    current_timestamp() as processed_at
from orders_stream;

show tasks;




INSERT INTO orders_raw (order_id, product_name, price, created_at)
VALUES
(111, 'Laptop',        75000.00, '2026-09-01'),
(112, 'Mobile Phone',  55000.00, '2026-09-02');

alter task process_new_orders resume;

show tasks;
select * from orders_stream;

select * from orders_processed;

select system$stream_has_data('orders_stream') as has_data;

execute task process_new_orders;

grant role BI_ROLE to user RAM;

grant usage on schema demo_schema to role BI_ROLE;

grant select on all tables in schema demo_schema to role BI_ROLE;

SHOW NETWORK RULES IN ACCOUNT;

desc POSTGRES instance postgres;

desc network rule POSTGRES_INGRESS_RULE_POSTGRES;