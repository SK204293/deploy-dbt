--dbt cloud setup

--create role
--create warehouse
create or replace warehouse dbt_dev_wh
  WAREHOUSE_SIZE = 'MEDIUM'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

CREATE or replace ROLE dbt_dev_role;

create database dbt_dev_db;
create schema dbt_dev_schema;

--create user
CREATE or replace USER dbt_user1
  PASSWORD = 'P@00word-001'
  DEFAULT_ROLE = dbt_dev_role
  DEFAULT_WAREHOUSE = dbt_dev_wh
  DEFAULT_NAMESPACE = dbt_dev_db.dbt_dev_schema
  MUST_CHANGE_PASSWORD = False;

--Grant permissions
GRANT all ON DATABASE dbt_dev_db TO ROLE dbt_dev_role;
GRANT all ON WAREHOUSE dbt_dev_wh TO ROLE dbt_dev_role;
GRANT all ON FUTURE SCHEMAS IN DATABASE dbt_dev_db TO ROLE dbt_dev_role;

--*******************************************************
-- Grant access on existing database and schemas


-- Grant access on all existing tables
GRANT SELECT ON ALL TABLES IN SCHEMA dbt_dev_db.dbt_dev_schema TO ROLE dbt_dev_role;

-- Grant access on all future schemas, tables, views, and stages
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE dbt_dev_db TO ROLE dbt_dev_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA dbt_dev_db.dbt_dev_schema TO ROLE dbt_dev_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA dbt_dev_db.dbt_dev_schema TO ROLE dbt_dev_role;
GRANT USAGE ON FUTURE STAGES IN SCHEMA dbt_dev_db.dbt_dev_schema TO ROLE dbt_dev_role;

--OAUTH
--OAuth Client ID
--OAuth Client Secret
CREATE OR REPLACE SECURITY INTEGRATION DBT_CLOUD
  TYPE = OAUTH
  ENABLED = TRUE
  OAUTH_CLIENT = CUSTOM
  OAUTH_CLIENT_TYPE = 'CONFIDENTIAL'
  OAUTH_REDIRECT_URI = 'https://bc566.us1.dbt.com/'
  OAUTH_ISSUE_REFRESH_TOKENS = TRUE
  OAUTH_REFRESH_TOKEN_VALIDITY = 7776000;

SHOW GRANTS TO USER dbt_user1;
GRANT ROLE DBT_DEV_ROLE TO USER dbt_user1;
--********************************************
----           Prod
--********************************************
create or replace warehouse dbt_prod_wh
  WAREHOUSE_SIZE = 'MEDIUM'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

CREATE or replace ROLE dbt_prod_role;

create database dbt_prod_db;
create schema dbt_prod_schema;

--create user
CREATE or replace USER dbt_prod1
  PASSWORD = 'P@00word-001'
  DEFAULT_ROLE = dbt_prod_role
  DEFAULT_WAREHOUSE = dbt_prod_wh
  DEFAULT_NAMESPACE = dbt_prod_db.dbt_prod_schema
  MUST_CHANGE_PASSWORD = False;

--Grant permissions
GRANT all ON DATABASE dbt_prod_db TO ROLE dbt_prod_role;
GRANT all ON WAREHOUSE dbt_prod_wh TO ROLE dbt_prod_role;
GRANT all ON FUTURE SCHEMAS IN DATABASE dbt_prod_db TO ROLE dbt_prod_role;
GRANT DBT_PROD_DB ON dbt_prod_schema TO ROLE dbt_prod_role;

--*******************************************************
-- Grant access on existing database and schemas


-- Grant access on all existing tables
GRANT SELECT ON ALL TABLES IN SCHEMA dbt_prod_db.dbt_prod_schema TO ROLE dbt_prod_role;

-- Grant access on all future schemas, tables, views, and stages
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE dbt_prod_db TO ROLE dbt_prod_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA dbt_prod_db.dbt_prod_schema TO ROLE dbt_prod_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA dbt_prod_db.dbt_prod_schema TO ROLE dbt_prod_role;
GRANT USAGE ON FUTURE STAGES IN SCHEMA dbt_prod_db.dbt_prod_schema TO ROLE dbt_prod_role;

--OAUTH
--OAuth Client ID
--OAuth Client Secret

SHOW GRANTS TO USER dbt_prod1;
GRANT ROLE DBT_PROD_ROLE TO USER dbt_prod1;


