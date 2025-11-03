USE [olap]
GO

INSERT INTO dbo.Dim_Product(
    product_id,
    name,
    category
) VALUES (
    1,
    'Apple iPhone 17',
    'Smartphones'
)
GO

INSERT INTO dbo.Dim_Product(
    product_id,
    name,
    category
) VALUES (
    2,
    'Samsung Galaxy S24',
    'Smartphones'
)
GO

INSERT INTO dbo.Dim_Product(
    product_id,
    name,
    category
) VALUES (
    3,
    'Google Pixel 8',
    'Smartphones'
)
GO

UPDATE dbo.Dim_Product
SET name = 'Apple iPhone 17 Pro Max'
WHERE product_id = 1
GO

DELETE FROM dbo.Dim_Product
WHERE product_id = 2
GO
