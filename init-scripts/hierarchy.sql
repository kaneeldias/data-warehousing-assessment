DROP DATABASE IF EXISTS hierarchy;
GO

CREATE DATABASE hierarchy;
GO

USE hierarchy;
GO

DROP TABLE IF EXISTS ProductType;
CREATE TABLE ProductType(
    product_type_id INT IDENTITY PRIMARY KEY,
    product_type VARCHAR(100)
)
GO

DROP TABLE IF EXISTS ProductCategory;
CREATE TABLE ProductCategory(
    product_category_id INT IDENTITY PRIMARY KEY,
    product_category VARCHAR(100),
    product_type_id INT,
    FOREIGN KEY (product_type_id) REFERENCES ProductType(product_type_id)
)
GO

DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
    product_id INT IDENTITY PRIMARY KEY,
    product VARCHAR(100),
    product_category_id INT,
    sales INT,
    FOREIGN KEY (product_category_id) REFERENCES ProductCategory(product_category_id)
)

BULK INSERT ProductCategory
FROM '/var/opt/mssql/import/data/data - Product Category.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

BULK INSERT ProductType
FROM '/var/opt/mssql/import/data/data - Product Type.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

BULK INSERT Product
FROM '/var/opt/mssql/import/data/data - Product.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO