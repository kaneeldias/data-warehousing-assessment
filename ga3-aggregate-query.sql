SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SET SHOWPLAN_ALL ON;

SELECT
    COUNT(amount) AS number_of_sales,
    SUM(amount) AS total_sales,
    AVG(amount) AS average_sales
FROM Sales
