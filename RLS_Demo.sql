create or replace database rls_demo;
create or replace schema rls_schema;

CREATE OR REPLACE TABLE CUSTOMERS (
    CUSTOMER_ID INT,
    CUSTOMER_NAME VARCHAR(100),
    COUNTRY VARCHAR(20),
    ACCOUNT_BALANCE NUMBER(12,2)
);

INSERT INTO CUSTOMERS VALUES
(101, 'John Smith', 'US', 25000),
(102, 'David Miller', 'US', 35000),
(103, 'Robert Wilson', 'US', 45000),
(104, 'Rahul Sharma', 'INDIA', 15000),
(105, 'Priya Reddy', 'INDIA', 28000),
(106, 'Amit Kumar', 'INDIA', 32000),
(107, 'James Brown', 'UK', 40000),
(108, 'Emma Watson', 'UK', 55000);

select * from customers;


create role if not exists US_ANALYST;
create role if not exists IND_ANALYST;
create role if not exists ADMIN_ANALYST;

show roles;


grant usage on database rls_demo to role US_ANALYST;
grant usage on schema rls_schema to role US_ANALYST;
grant select on table customers to role US_ANALYST;

grant usage on database rls_demo to role IND_ANALYST;
grant usage on schema rls_schema to role IND_ANALYST;
grant select on table customers to role IND_ANALYST;

grant usage on database rls_demo to role ADMIN_ANALYST;
grant usage on schema rls_schema to role ADMIN_ANALYST;
grant select on table customers to role ADMIN_ANALYST;


ALTER row access policy customer_country_policy
set body ->
    Case when is_role_in_session('ADMIN_ANALYST')
         then true
         when is_role_in_session('US_ANALYST')
         and COUNTRY='US'
         then true
         when is_role_in_session('IND_ANALYST')
         and country='INDIA'
         then true
         else false
        end;

alter table customers
add row access policy customer_country_policy
on (country);

use role ADMIN_ANALYST;
select * from customers;

SELECT
    CURRENT_USER(),
    CURRENT_ROLE(),
    CURRENT_SECONDARY_ROLES();

grant role ADMIN_ANALYST to user ramanjasper3;
