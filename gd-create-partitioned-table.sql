DROP TABLE ProductSalesPartitioned;

CREATE TABLE ProductSalesPartitioned (
    product_id INT,
    year INT,
    country CHAR(2),
    sales INT
)
PARTITION BY LIST (country) AUTOMATIC
(
    PARTITION p_china VALUES ('CN')
);

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS(
        ownname => USER,
        tabname => 'PRODUCTSALESPARTITIONED',
        estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
        method_opt => 'FOR ALL COLUMNS SIZE AUTO',
        cascade => TRUE
    );
END;

SELECT
    partition_name,
    high_value,
    num_rows
FROM user_tab_partitions
WHERE table_name = 'PRODUCTSALESPARTITIONED'
ORDER BY partition_name;