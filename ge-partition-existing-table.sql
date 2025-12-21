SELECT * FROM PRODUCTSALES;

SELECT
    partition_name,
    high_value,
    num_rows
FROM user_tab_partitions
WHERE table_name = 'PRODUCTSALES'
ORDER BY partition_name;

ALTER TABLE ProductSales MODIFY
PARTITION BY LIST (country) AUTOMATIC
(
    PARTITION p_china VALUES ('CN')
)