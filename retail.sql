create database retail;
create schema retail_schema;

create file format csv_fmt
type=csv
parse_header=true;

CREATE OR REPLACE STAGE csv_stage
  FILE_FORMAT = csv_fmt;
RETAIL.RETAIL_SCHEMA.CSV_STAGERETAIL.RETAIL_SCHEMA.CSV_STAGERETAIL.RETAIL_SCHEMA.CSV_STAGERETAIL.RETAIL_SCHEMA.CSV_STAGE
  desc stage csv_stage;

SELECT *
 FROM TABLE(
   INFER_SCHEMA(
     LOCATION=>'@CSV_STAGE/suppliers.csv',
      FILE_FORMAT=>'csv_fmt'
     )
   );

   list @csv_stage;

CREATE OR REPLACE TABLE suppliers
USING TEMPLATE (
  SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*)) ---Object_construct converst to Key:Pair, Array converts to array
    FROM TABLE(
      INFER_SCHEMA(
        LOCATION=>'@CSV_STAGE/suppliers.csv',
        FILE_FORMAT=>'csv_fmt'
      )
    ));
   
select * from customers;

truncate table customers;

 COPY INTO suppliers
  FROM @csv_stage/suppliers.csv
  FILE_FORMAT = (FORMAT_NAME = 'csv_fmt' ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE)
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

  --like this do same for next 4 files
  --another 4 tables get it from fivetran(postgresql dbeave)
  --get remaining from s3 to snowpipe to landing layer
  
