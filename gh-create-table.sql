DROP TABLE Orders;
DROP TABLE CustomerErrors;

CREATE TABLE CustomerErrors (
    customer_id INT PRIMARY KEY ,
    name VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    "DATE" DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES CustomerErrors(customer_id)
);