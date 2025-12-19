DROP DATABASE IF EXISTS indexes;
GO

CREATE DATABASE indexes;
GO

USE indexes;
GO

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer(
    customer_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    date_of_birth DATE
)
GO

BULK INSERT Customer
FROM '/var/opt/mssql/import/data/data - Customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales
(
    sale_id     INT IDENTITY PRIMARY KEY,
    customer_id INT,
    sale_date   DATE,
    amount      DECIMAL(10, 2),
)

BULK INSERT Sales
FROM '/var/opt/mssql/import/data/data - Sales2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO