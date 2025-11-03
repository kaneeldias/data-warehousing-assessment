USE [olap]
GO

CREATE SCHEMA manual_cdc AUTHORIZATION dbo;
GO

CREATE TABLE manual_cdc.Dim_Product_Changes (
    timestamp DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    change_type CHAR(17),
    product_id INT,
    name VARCHAR(100),
    category VARCHAR(100),
);
GO

CREATE TRIGGER trg_Products_AfterInsert
ON dbo.Dim_Product
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO manual_cdc.Dim_Product_Changes (change_type, product_id, name, category)
    SELECT 'INSERT', i.product_id, i.name, i.category
    FROM inserted i;
END;
GO

CREATE TRIGGER trg_Products_AfterUpdate
ON dbo.Dim_Product
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO manual_cdc.Dim_Product_Changes (change_type, product_id, name, category)
    SELECT 'UPDATE_BEFORE', d.product_id, d.name, d.category
    FROM deleted d
    INNER JOIN inserted i ON d.product_id = i.product_id;

    INSERT INTO manual_cdc.Dim_Product_Changes (change_type, product_id, name, category)
    SELECT 'UPDATE_AFTER', i.product_id, i.name, i.category
    FROM inserted i
END;
GO

CREATE TRIGGER trg_Products_AfterDelete
ON dbo.Dim_Product
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO manual_cdc.Dim_Product_Changes (change_type, product_id, name, category)
    SELECT 'DELETE', d.product_id, d.name, d.category
    FROM deleted d;
END;
GO