SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SET SHOWPLAN_ALL ON;

SELECT
    customer_id
FROM
    Customer
WHERE
    date_of_birth BETWEEN '1980-01-01' AND '1980-12-31';

EXEC sp_helpindex 'Customer';