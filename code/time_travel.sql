USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

-- Create the CUSTOMER table
ALTER SESSION SET TIMEZONE = 'UTC';

-- Create the CUSTOMER table
CREATE OR REPLACE TABLE CUSTOMER (
  CUSTOMER_ID INT,
  FIRST_NAME VARCHAR(50),
  LAST_NAME VARCHAR(50),
  EMAIL VARCHAR(100),
  PHONE VARCHAR(20),
  ADDRESS VARCHAR(200),
  CITY VARCHAR(50),
  STATE VARCHAR(50),
  COUNTRY VARCHAR(50),
  JOIN_DATE DATE
);


-- View the current state of the CUSTOMER table
SELECT * FROM CUSTOMER;

SHOW TABLES;

-- Insert sample records into the CUSTOMER table
INSERT INTO CUSTOMER (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE, ADDRESS, CITY, STATE, COUNTRY, JOIN_DATE)
VALUES
  (1, 'John', 'Doe', 'johndoe@example.com', '+1-555-1234', '123 Main St', 'Anytown', 'CA', 'USA', '2022-01-01'),
  (2, 'Jane', 'Smith', 'janesmith@example.com', '+1-555-5678', '456 Oak St', 'Anycity', 'NY', 'USA', '2022-01-02'),
  (3, 'Bob', 'Johnson', 'bobjohnson@example.com', '+1-555-9012', '789 Elm St', 'Anyville', 'TX', 'USA', '2022-01-03'),
  (4, 'Alice', 'Lee', 'alicelee@example.com', '+1-555-3456', '321 Pine St', 'Anytown', 'CA', 'USA', '2022-01-04'),
  (5, 'David', 'Kim', 'davidkim@example.com', '+1-555-7890', '654 Maple St', 'Anycity', 'NY', 'USA', '2022-01-05'),
  (6, 'Cathy', 'Wang', 'cathywang@example.com', '+1-555-1234', '987 Cedar St', 'Anyville', 'TX', 'USA', '2022-01-06'),
  (7, 'Michael', 'Garcia', 'michaelgarcia@example.com', '+1-555-5678', '159 Birch St', 'Anytown', 'CA', 'USA', '2022-01-07'),
  (8, 'Linda', 'Nguyen', 'lindanguyen@example.com', '+1-555-9012', '753 Spruce St', 'Anycity', 'NY', 'USA', '2022-01-08'),
  (9, 'Samuel', 'Martinez', 'samuelmartinez@example.com', '+1-555-3456', '246 Oak St', 'Anyville', 'TX', 'USA', '2022-01-09'),
  (10, 'Karen', 'Chen', 'karenchen@example.com', '+1-555-7890', '852 Pine St', 'Anytown', 'CA', 'USA', '2022-01-10');


SELECT * FROM CUSTOMER;

-- This command shows the current timezone used by the session
SHOW PARAMETERS LIKE 'TIMEZONE';

-- This command retrieves the current timestamp in the UTC timezone
SELECT SYSTIMESTAMP();

--Timestamp : 2024-12-11 18:44:49.528 +0000

-- Change the phone number for customer ID 1
UPDATE CUSTOMER SET PHONE = '+3-555-5678' WHERE CUSTOMER_ID = 1;

--Query ID : 01b8f6e5-0004-5127-0003-4b6300010406

-- View the current state of the CUSTOMER table
SELECT * FROM CUSTOMER;

-- View the state of the CUSTOMER table as it existed one day ago
SELECT * FROM CUSTOMER BEFORE(STATEMENT => '01b8f6e5-0004-5127-0003-4b6300010406');

-- This command selects all rows from the CUSTOMER table as it existed 20 seconds ago
SELECT * FROM CUSTOMER BEFORE(OFFSET => -150);

-- This command selects all rows from the CUSTOMER table that were valid before a specific timestamp
SELECT * FROM CUSTOMER AT(TIMESTAMP => '2024-12-11 18:44:49.528 +0000'::timestamp);

-- This command drops the CUSTOMER table, if it exists
DROP TABLE CUSTOMER;

-- This command selects all rows from the CUSTOMER table
SELECT * FROM CUSTOMER;

-- This command undrops the CUSTOMER table, if it was previously dropped
UNDROP TABLE CUSTOMER;

--Alter the account data retention
ALTER ACCOUNT SET MIN_DATA_RETENTION_TIME_IN_DAYS = 10;

-- You can also use  DATA_RETENTION_TIME_IN_DAYS, Final days will be MAX(DATA_RETENTION_TIME_IN_DAYS, MIN_DATA_RETENTION_TIME_IN_DAYS)
SHOW TABLES;

SHOW SCHEMAS;
SHOW DATABASES;

--You can also do time travel for COPY, Create Schema, Create database
CREATE TABLE copy_cust CLONE CUSTOMER
  AT(TIMESTAMP => '2024-12-11 18:44:49.528 +0000'::timestamp);

CREATE SCHEMA restored_schema CLONE LA_SCHEMA AT(OFFSET => -3600);

CREATE DATABASE restored_db CLONE LA_DB
  BEFORE(STATEMENT => '8e5d0ca9-005e-44e6-b858-a8f5b37c5726');
