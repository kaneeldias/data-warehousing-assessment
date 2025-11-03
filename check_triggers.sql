USE [olap];
GO


SELECT *
FROM sys.triggers t
JOIN sys.tables tbl ON t.parent_id = tbl.object_id
WHERE tbl.name = 'Dim_Product'
GO;