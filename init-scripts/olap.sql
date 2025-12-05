-- USE master;
-- GO
--
-- DROP DATABASE IF EXISTS [olap];
-- GO

CREATE DATABASE olap;
GO

USE olap;
GO

CREATE TABLE Dim_Product(
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100)
)
GO

CREATE TABLE Dim_Vendor(
    vendor_id INT PRIMARY KEY,
    name VARCHAR(100),
    is_approved BIT
)
GO

CREATE TABLE Dim_Branch(
    branch_id INT PRIMARY KEY,
    name VARCHAR(100)
)
GO

CREATE TABLE Dim_Employee(
    employee_id CHAR(8) PRIMARY KEY,
    name VARCHAR(100),
)
GO

CREATE TABLE Dim_Date(
    date_id INT PRIMARY KEY,
    year SMALLINT,
    quarter TINYINT,
    month TINYINT,
    day TINYINT
)
GO

CREATE TABLE Fact_OrderItem(
    order_item_id INT PRIMARY KEY,
    product_id INT,
    vendor_id INT,
    branch_id INT,
    employee_id CHAR(8),
    unit_price DECIMAL(10, 2),
    quantity INT,
    total_price AS (unit_price * quantity),
    contract_price DECIMAL(10, 2),
    deviation_from_contract_price AS (unit_price - contract_price),
    ordered_date_id INT,

    CONSTRAINT FK_FactOrderItem_DimProduct FOREIGN KEY (product_id) REFERENCES Dim_Product (product_id),
    CONSTRAINT FK_FactOrderItem_DimVendor FOREIGN KEY (vendor_id) REFERENCES Dim_Vendor (vendor_id),
    CONSTRAINT FK_FactOrderItem_DimBranch FOREIGN KEY (branch_id) REFERENCES Dim_Branch (branch_id),
    CONSTRAINT FK_FactOrderItem_DimEmployee FOREIGN KEY (employee_id) REFERENCES Dim_Employee (employee_id),
    CONSTRAINT FK_FactOrderItem_DimDate FOREIGN KEY (ordered_date_id) REFERENCES Dim_Date (date_id)
)
GO

CREATE TABLE Fact_Delivery(
    delivery_id INT PRIMARY KEY,
    vendor_id INT,
    scheduled_date_id INT,
    delivered_date_id INT,
    was_delivered BIT,
    was_rejected BIT,
    delay_days SMALLINT

    CONSTRAINT FK_FactDelivery_DimVendor FOREIGN KEY (vendor_id) REFERENCES Dim_Vendor (vendor_id),
    CONSTRAINT FK_FactDelivery_ScheduledDate FOREIGN KEY (scheduled_date_id) REFERENCES Dim_Date (date_id),
    CONSTRAINT FK_FactDelivery_DeliveredDate FOREIGN KEY (delivered_date_id) REFERENCES Dim_Date (date_id)
)
GO