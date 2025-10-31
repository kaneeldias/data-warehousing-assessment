USE [oltp]; EXEC sys.sp_cdc_enable_db;
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Branch', @role_name=NULL, @capture_instance=N'cdc_Branch_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'CatalogItem', @role_name=NULL, @capture_instance=N'cdc_CatalogItem_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Employee', @role_name=NULL, @capture_instance=N'cdc_Employee_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Order', @role_name=NULL, @capture_instance=N'cdc_Order_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Order_OrderItem', @role_name=NULL, @capture_instance=N'cdc_Order_OrderItem_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'OrderItem', @role_name=NULL, @capture_instance=N'cdc_OrderItem_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Product', @role_name=NULL, @capture_instance=N'cdc_Product_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'ProductCategory', @role_name=NULL, @capture_instance=N'cdc_ProductCategory_ci';
USE [oltp]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Vendor', @role_name=NULL, @capture_instance=N'cdc_Vendor_ci';
GO

USE [olap] EXEC sys.sp_cdc_enable_db;
USE [olap]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Dim_Branch', @role_name=NULL, @capture_instance=N'cdc_Dim_Branch_ci';
USE [olap]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Dim_Date', @role_name=NULL, @capture_instance=N'cdc_Dim_Date_ci';
USE [olap]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Dim_Employee', @role_name=NULL, @capture_instance=N'cdc_Dim_Employee_ci';
USE [olap]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Dim_Product', @role_name=NULL, @capture_instance=N'cdc_Dim_Product_ci';
USE [olap]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Dim_Vendor', @role_name=NULL, @capture_instance=N'cdc_Dim_Vendor_ci';
USE [olap]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Fact_OrderItem', @role_name=NULL, @capture_instance=N'cdc_Fact_OrderItem_ci';
USE [olap]; EXEC sys.sp_cdc_enable_table @source_schema=N'dbo', @source_name=N'Fact_Delivery', @role_name=NULL, @capture_instance=N'cdc_Fact_Delivery_ci';
GO