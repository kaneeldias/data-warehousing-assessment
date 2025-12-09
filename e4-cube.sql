SELECT
    type.product_type,
    category.product_category,
    product.product,
    SUM(product.sales) AS total_sales
FROM
    Product product
    INNER JOIN ProductCategory category
        ON product.product_category_id = category.product_category_id
    INNER JOIN ProductType type
        ON category.product_type_id = type.product_type_id
GROUP BY
    CUBE (type.product_type, category.product_category, product.product)
ORDER BY
    type.product_type,
    category.product_category,
    product.product;
GO
