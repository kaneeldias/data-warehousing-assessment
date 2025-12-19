DROP TABLE Customer;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender CHAR(1),
    is_homeowner NUMBER(1),
    marital_status VARCHAR(50)
);

SET AUTOTRACE ON EXPLAIN

SELECT
    customer_id
FROM Customer
WHERE
    gender = 'F' AND
    is_homeowner = 1 AND
    marital_status = 'single';

DELETE FROM plan_table;
EXPLAIN PLAN FOR SELECT CUSTOMER_ID FROM CUSTOMER WHERE gender = 'F' AND is_homeowner = 1 AND marital_status = 'single';
SELECT operation, options, object_name, cost AS total_cost, io_cost, cpu_cost FROM plan_table ORDER BY id;

CREATE BITMAP INDEX customer_bitmap_idx
ON Customer (gender, is_homeowner, marital_status);

SELECT index_name, uniqueness, index_type
FROM user_indexes
WHERE table_name = 'CUSTOMER';