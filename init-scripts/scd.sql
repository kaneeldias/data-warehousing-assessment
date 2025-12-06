CREATE DATABASE scd;
GO

USE scd;
GO

CREATE TABLE Customer(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    ContactNumber VARCHAR(20)
)
GO

INSERT INTO Customer (CustomerID, CustomerName, Address, City, PostalCode, ContactNumber) VALUES
(1, 'John Doe', '123 Elm St', 'Springfield', '12345', '555-1234'),
(2, 'Jane Smith', '456 Oak St', 'Greenville', '67890', '555-5678'),
(3, 'Mike Johnson', '789 Pine St', 'Fairview', '11223', '555-8765'),
(4, 'Emily Davis', '321 Maple St', 'Riverside', '33445', '555-4321'),
(5, 'David Wilson', '654 Cedar St', 'Lakeside', '55667', '555-6789'),
(6, 'Sarah Brown', '987 Birch St', 'Hilltown', '77889', '555-9876'),
(7, 'Chris Taylor', '147 Spruce St', 'Brookfield', '99001', '555-3456'),
(8, 'Amanda Martinez', '258 Willow St', 'Oakwood', '22334', '555-6543'),
(9, 'James Anderson', '369 Poplar St', 'Cedarville', '44556', '555-7890'),
(10, 'Laura Thomas', '159 Chestnut St', 'Pinehurst', '66778', '555-0123');
GO

CREATE TABLE DimCustomer_type1(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    ContactNumber VARCHAR(20),
)
GO

CREATE TABLE DimCustomer_type2(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    ContactNumber VARCHAR(20),
    EffectiveDate DATETIME,
    ExpiryDate DATETIME,
)
GO