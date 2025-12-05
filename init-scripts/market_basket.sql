USE olap;
GO

CREATE TABLE MarketBasket(
    ordered_date_id INT,
    product_a_id INT,
    product_b_id INT,
    branch_id INT,
    product_a_qty INT,
    product_b_qty INT,
    product_a_amt DECIMAL(10,2),
    product_b_amt DECIMAL(10,2)
)
GO