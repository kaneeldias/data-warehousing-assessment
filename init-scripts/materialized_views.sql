DROP DATABASE IF EXISTS mv;
GO

CREATE DATABASE mv;
GO

USE mv;
GO

DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales(
    sales_id INT IDENTITY PRIMARY KEY,
    product VARCHAR(100),
    date INT,
    sales INT
)
GO

BULK INSERT Sales
FROM '/var/opt/mssql/import/data/data - Sales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO

CREATE OR ALTER PROCEDURE dbo.Refresh_mv_view_1
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cols NVARCHAR(MAX);
    DECLARE @sql  NVARCHAR(MAX);

    SELECT @cols = STRING_AGG(QUOTENAME([date]), ',') WITHIN GROUP (ORDER BY [date])
    FROM (SELECT DISTINCT [date] FROM dbo.Sales) years;

    -- Recreate concrete pivot table
    SET @sql = N'
    DROP TABLE IF EXISTS dbo.mv_view_1;
    SELECT product, ' + @cols + N'
    INTO dbo.mv_view_1
    FROM (
      SELECT product, [date], sales FROM dbo.Sales
    ) s
    PIVOT (
      SUM(sales) FOR [date] IN (' + @cols + N')
    ) p;';

    EXEC sp_executesql @sql;
END;
GO

EXEC dbo.Refresh_mv_view_1;
GO

CREATE CLUSTERED INDEX idx_mv_view_1 ON dbo.mv_view_1(product);
GO

EXEC msdb.dbo.sp_add_job
    @job_name = N'Refresh_mv_view_hourly',
    @enabled = 1,
    @description = N'Refresh mv_view_1 every hour',
    @owner_login_name = N'sa';
GO

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'Refresh_mv_view_hourly',
    @step_name = N'Run proc',
    @subsystem = N'TSQL',
    @command = N'EXEC mv.dbo.Refresh_mv_view_1;',
    @database_name = N'mv';
GO

EXEC msdb.dbo.sp_add_jobschedule
    @job_name = N'Refresh_mv_view_hourly',
    @name = N'Hourly schedule',
    @freq_type = 4,               -- daily
    @freq_interval = 1,           -- every day
    @freq_subday_type = 8,        -- hours
    @freq_subday_interval = 1,    -- every 1 hour
    @active_start_time = 000000;
GO

