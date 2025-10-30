-- USE master;
-- GO
--
-- DROP DATABASE IF EXISTS oltp;
-- GO

CREATE DATABASE oltp;
GO

USE oltp;
GO

CREATE TABLE ProductCategory(
    category_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100)
)
GO

CREATE TABLE Product(
    product_id INT IDENTITY PRIMARY KEY,
    category_id INT,
    name VARCHAR(100),

    CONSTRAINT FK_Product_ProductCategory FOREIGN KEY (category_id) REFERENCES ProductCategory (category_id)
)
GO

CREATE TABLE Vendor(
    vendor_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    is_approved BIT
)
GO

CREATE TABLE CatalogItem(
    catalog_item_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    vendor_id INT,
    contract_price DECIMAL(10, 2),

    CONSTRAINT FK_CatalogItem_Product FOREIGN KEY (product_id) REFERENCES Product (product_id),
    CONSTRAINT FK_CatalogItem_Vendor FOREIGN KEY (vendor_id) REFERENCES Vendor (vendor_id)
)
GO

CREATE TABLE OrderItem(
    order_item_id INT IDENTITY PRIMARY KEY,
    catalog_item_id INT,
    unit_price DECIMAL(10, 2),
    quantity INT,

    CONSTRAINT FK_OrderItem_CatalogItem FOREIGN KEY (catalog_item_id) REFERENCES CatalogItem (catalog_item_id)
)
GO

CREATE TABLE Branch(
    branch_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100),
)
GO

CREATE TABLE Employee(
    employee_id CHAR(8) PRIMARY KEY,
    name VARCHAR(100),
)
GO

CREATE TABLE [Order](
    order_id INT IDENTITY PRIMARY KEY,
    branch_id INT,
    order_placed_on DATETIME,
    order_placed_by CHAR(8),
    status VARCHAR(20),

    CONSTRAINT FK_Order_Branch FOREIGN KEY (branch_id) REFERENCES Branch (branch_id),
    CONSTRAINT FK_Order_Employee FOREIGN KEY (order_placed_by) REFERENCES Employee (employee_id),
    CONSTRAINT CHK_Order_Status CHECK (status IN (
        'DRAFT', 'PENDING', 'ACCEPTED_BY_VENDOR', 'REJECTED_BY_VENDOR', 'CANCELLED_BY_COMPANY', 'CANCELLED_BY_VENDOR',
        'ON_DELIVERY', 'COMPLETED', 'REJECTED_ON_INSPECTION'
    ))
)
GO

CREATE TABLE Order_OrderItem(
    order_id INT,
    order_item_id INT,

    CONSTRAINT PK_OrderOrderItem PRIMARY KEY (order_id, order_item_id),
    CONSTRAINT FK_OrderOrderItemMapping_Order FOREIGN KEY (order_id) REFERENCES [Order] (order_id),
    CONSTRAINT FK_OrderOrderItemMapping_OrderItem FOREIGN KEY (order_item_id) REFERENCES OrderItem (order_item_id)
)
GO