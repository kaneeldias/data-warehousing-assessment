USE [olap]
GO

INSERT INTO dbo.Dim_Product(
    product_id,
    name,
    category
) VALUES (
    2,
    'Apple iPhone 17',
    'Smartphones'
)
GO

UPDATE dbo.Dim_Product
SET name = 'Apple iPhone 17 Pro Max'
WHERE product_id = 2
GO